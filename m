From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 15:54:26 +0100
Subject: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <1486058763-7730-1-git-send-email-logang@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
Message-ID: <20170210145426.GB24594@kroah.com>

On Thu, Feb 02, 2017@11:05:59AM -0700, Logan Gunthorpe wrote:
> Changes since v1:
> 
> * Rebased onto 4.10-rc6 (cleanly)
> * Split the patch into a few more easily digestible patches (as
>   suggested by Greg Kroah-Hartman)
> * Folded switchtec.c into switchtec.h (per Greg)
> * Fixed a bunch of 32bit build warnings caught by the kbuild test robot
> * Fixed some issues in the documentation so it has a proper
>   reStructredText format (as noted by Jonathan Corbet)
> * Fixed padding and sizes in the IOCTL structures as noticed by Emil
>   Velikov and used pahole to verify their consistency across 32 and 64
>   bit builds
> * Reworked one of the IOCTL interfaces to be more future proof (per
>   Emil).
> 
> Changes since RFC:
> 
> * Fixed incorrect use of the drive model as pointed out by Greg
>   Kroah-Hartman
> * Used devm functions as suggested by Keith Busch
> * Added a handful of sysfs attributes to the switchtec class
> * Added a handful of IOCTLs to the switchtec device
> * A number of miscellaneous bug fixes

I didn't audit the ioctl code, but the driver model and sysfs stuff
looks sane to me, nice job cleaning it up.

thanks,

greg k-h
