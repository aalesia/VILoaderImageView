VILoaderImageView
=================

This class is a subclass of UIImageView designed to take in an image URL and display the image.

##Reqirements

This class requires the QuartzCore framework for it's fade in animation.

##Instance Methods

* -(id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl animated:(BOOL)animated;

    * frame
        * Sets the frame for the image view.
    * imageUrl
        * The location of the image that is going to be displayed.
    * animated
        * Sets whether or not to have the image fade in when it comes down from the server.
        
    This method initializes the frame and proceeds to call setImageUrl:animated:.

* -(id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;

    * frame
        * Sets the frame for the image view.
    * imageUrl
        * The location of the image that is going to be displayed.
        
    This method called initWithFrame:imageUrl:animated: and sets animated to NO.


* -(void)setImageUrl:(NSString *)imageUrl animated:(BOOL)animated;

    * imageUrl
        * The location of the image that is going to be displayed.
    * animated
        * Sets whether or not to have the image fade in when it comes down from the server.
        
    This method checks to see if the given image exists in the cache. If it does, it will display it immediately. If the image does not exist, it will display an activity indicator while pulling the image down. Once it finishes downloading the image, it will either fade in if animate is YES or simply replace the image.

* -(void)setImageUrl:(NSString *)imageUrl;

    * imageUrl
        * The location of the image that is going to be displayed.
        
    This method called setImageUrl:animated: and sets animated to NO.
    
## Define Variable Explanations

   * Length of Cache - LENGTH_OF_CACHE
      * Set this to the number of seconds you'd like the cache to persist for. If the cached image is older than that length of time, it will be reloaded from it's URL and recached.
   
   * Decompress - PREDECOMPRESS
      * Set this to 1 if you'd like the UIImages to be returned decompressed, 0 if not. Decompressed images require more memory, but will improve draw times of UIImages.
   
   * Number of items in local cache - LOCAL_CACHE_MAX_ITEMS
      * Set this to the number of items you'd like held in the local memory cache, more items means more caching, but also more required memory. Find your own sweet spot.
   
   * Max Concurrent Operations - MAX_CONCURRENT_OPERATIONS
      * Set this to the number of simultaneously running image loading operations you'd like.

