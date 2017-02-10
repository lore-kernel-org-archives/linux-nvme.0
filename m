From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 15:54:50 +0100
Subject: [PATCH v2 3/4] switchtec: Add sysfs attributes to the Switchtec
 driver
In-Reply-To: <1486058763-7730-4-git-send-email-logang@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-4-git-send-email-logang@deltatee.com>
Message-ID: <20170210145450.GD24594@kroah.com>

On Thu, Feb 02, 2017@11:06:02AM -0700, Logan Gunthorpe wrote:
> This patch adds a few read-only sysfs attributes which provide
> some device information that is exposed from the devices. Primarily
> component and device names and versions. These are documented in
> Documentation/ABI/testing/sysfs-class-switchtec.
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Stephen Bates <stephen.bates at microsemi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
