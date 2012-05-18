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
