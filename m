From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 18:09:10 +0100
Subject: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
In-Reply-To: <9a1d4150-b329-1a69-9efd-f06da32afe02@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
 <20170210145124.GA24594@kroah.com>
 <ca970e7a-b062-d351-9a04-49a9e05955b5@deltatee.com>
 <20170210165550.GA23959@kroah.com>
 <9a1d4150-b329-1a69-9efd-f06da32afe02@deltatee.com>
Message-ID: <20170210170910.GA25450@kroah.com>

On Fri, Feb 10, 2017@10:03:10AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 10/02/17 09:55 AM, Greg Kroah-Hartman wrote:
> > Yes, but try it yourself to verify it really is correct :)
> 
> Yes, of course... turns out it wasn't. I accidentally refereed to dev
> before I assigned it. I had mainly just wanted your feedback to ensure
> that switching to device_register made sense.
> 
> > And it can just be an add-on patch, no need to respin a whole new
> > version for just that simple change, it doesn't hurt anything as-is,
> > it's just "not needed".
> 
> Ok... How should I do that exactly? Attempt to reply to the thread with
> another patch?

Sure, or just wait for these to be applied to the PCI tree and then send
a follow-on patch.  It's up to Bjorn really, as to what he wants.

thanks,

greg k-h
