// Burp Suite Version Checker
// Returns the latest version of Burp Suite

// Does the same as the following bash one-liner:
// curl -s 'https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=20' | jq -r '.ResultSet.Results | map(select((.title | contains ("Professional")) and (.releaseChannels | index("Stable")))|.version)[0]'

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
)

const VersionDataURL = "https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=30"

type Result struct {
	Builds []struct {
		Md5Checksum          string `json:"Md5Checksum"`
		ProductEdition       string `json:"ProductEdition"`
		ProductId            string `json:"ProductId"`
		ProductPlatform      string `json:"ProductPlatform"`
		ProductPlatformLabel string `json:"ProductPlatformLabel"`
		Sha256Checksum       string `json:"Sha256Checksum"`
		Version              string `json:"Version"`
	} `json:"builds"`
	Categories      []string    `json:"categories"`
	Content         string      `json:"content"`
	Id              int         `json:"id"`
	Labels          []string    `json:"labels"`
	ProductType     interface{} `json:"productType"`
	ReleaseChannels []string    `json:"releaseChannels"`
	ReleaseDate     string      `json:"releaseDate"`
	Title           string      `json:"title"`
	URL             string      `json:"url"`
	Version         string      `json:"version"`
}

type Response struct {
	AdditionalData  bool `json:"AdditionalData"`
	IsHtmlResultSet bool `json:"IsHtmlResultSet"`
	Status          int  `json:"Status"`
	ResultSet       struct {
		HasMoreResults bool     `json:"HasMoreResults"`
		PageNumber     int      `json:"PageNumber"`
		PageSize       int      `json:"PageSize"`
		TotalCount     int      `json:"TotalCount"`
		TotalPageCount int      `json:"TotalPageCount"`
		Results        []Result `json:"Results"`
	} `json:"ResultSet"`
}

var releaseFlag string
var ReleaseChoices = []string{"Stable", "Early Adopter"}

var categoryFlag string
var CategoryChoices = []string{"Professional", "Community"}

var rawJSONFlag bool

func init() {
	log.SetOutput(os.Stderr)
	log.SetFlags(log.LstdFlags | log.Lshortfile)
}

func contains[T comparable](elems []T, v T) bool {
	for _, s := range elems {
		if v == s {
			return true
		}
	}
	return false
}

func main() {
	flag.StringVar(&releaseFlag, "release", "Stable", fmt.Sprintf("Release channel to check for its updates (%s)", strings.Join(ReleaseChoices, ", ")))
	flag.StringVar(&categoryFlag, "category", "Professional", fmt.Sprintf("Category to check for its updates (%s)", strings.Join(CategoryChoices, ", ")))
	flag.BoolVar(&rawJSONFlag, "raw", false, "Print the raw JSON response from portswigger for the selected release and category")
	flag.Usage = func() {
		fmt.Println("Burp Suite Version Checker")
		_, err := fmt.Fprintf(os.Stderr, "Usage: %s [options]\n", os.Args[0])
		if err != nil {
			return // ignore error
		}
		flag.PrintDefaults()
	}
	flag.Parse()

	// Assert flags are valid
	if !contains(ReleaseChoices, releaseFlag) {
		log.Fatalf("Invalid release channel: %s (not [%s])", releaseFlag, strings.Join(ReleaseChoices, ", "))
	}

	if !contains(CategoryChoices, categoryFlag) {
		log.Fatalf("Invalid category: %s (not [%s])", categoryFlag, strings.Join(CategoryChoices, ", "))
	}

	// Get the latest metadata from portswigger
	log.Printf("Checking for updates (release=%s, category=%s)...", releaseFlag, categoryFlag)
	response, err := http.Get(VersionDataURL)
	if err != nil {
		log.Fatal("Error GET request:", err)
	}

	data, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatal("Error reading response:", err)
	}

	var res Response
	err = json.Unmarshal(data, &res)
	if err != nil {
		log.Fatal("Error unmarshalling:", err)
	}

	results := res.ResultSet.Results
	for _, result := range results {
		if contains(result.ReleaseChannels, releaseFlag) && contains(result.Categories, categoryFlag) {
			if rawJSONFlag {
				// marshal
				jsonResult, err := json.Marshal(result)
				if err != nil {
					log.Fatal("Error marshalling:", err)
				}
				fmt.Print(string(jsonResult))
			} else {
				fmt.Print(result.Version)
			}
			os.Exit(0)
		}
	}
}
