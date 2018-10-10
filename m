From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Oct 2018 10:40:23 -0600
Subject: [PATCH] NVMe-CLI WDC Plugin - Simplify the device id checking
 routines.
In-Reply-To: <1539108633-3610-1-git-send-email-jeff.lien@wdc.com>
References: <1539108633-3610-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <20181010164023.GB9967@localhost.localdomain>

On Tue, Oct 09, 2018@06:10:51PM +0000, Jeffrey Lien wrote:
> This change will make one common function that will retrieve the pci
> vendor and device id's and check them for a match of the passed in
> id's.
> 
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>

Thanks, applied.
