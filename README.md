# ytar
## YouTube Audio Ripper

For downloading the audio from public domain videos on YouTube.  

## How it works

### Search page

When the application loads, you will be greeted by a text box.  
Enter your search terms, one per line, and click 'Load'.  
Take care in phrasing your search terms, they will be used for the final file names, if that is something you are concerned about.  
You can enter duplicate search terms! If you do the resulting filenames will each be prepended with 'ytdl' and a number indicating the order in which it was processed.  

### Search confirmation page

A list of the terms you selected will be displayed.  
If everything looks right, click 'Continue'.

### Video selection process

A video matching your search term will be displayed.  
You have three options on the viewer page.  
* If the video is the one you were trying to reach click 'Accept'. It will be added to the queue and a video for your next search term will be displayed.
* If the video isn't right, click 'Retry'. Another possible match for your search term will be displayed.  If you do this ten times, it will be treated as though you hit 'Reject', see below.
* Finally, if you are having no luck at all, click 'Reject' and the application will move on to the next search term in the list.  A list of failed search terms will be provided to you on the download page.

### Download page

The search page will display a list of the videos you have selected to download the audio from, containing the search term and a screen shot of the video.  Below this list is another list containing the search terms for which an acceptable video was not found (see reject and retry above).

Clicking 'Prepare' will tell the application to prepare your files for download.  This can take a while, particularly if the videos are long.  The list item corresponding to the file currently being processed will be highlighted in blue, to give you some indicator of the progress being made.  

Finally, once your download has been prepared, the 'Download' button will become active.  Click it, and select the destination for the zip file to be saved.

### Results

The file you save at the end of this process is a compressed file. You will need to use a decompression tool like 'Unzip' or 'Winzip' to extract the files.  The audio files will be in the .opus format.
