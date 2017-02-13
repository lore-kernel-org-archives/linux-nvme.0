From: hch@infradead.org (hch@infradead.org)
Date: Mon, 13 Feb 2017 00:04:54 -0800
Subject: [PATCH v2 4/4] Maintainers: Add Information for SED Opal library
In-Reply-To: <20170210164458.GB2734@sbauer-Z170X-UD5>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-5-git-send-email-scott.bauer@intel.com>
 <DF4PR84MB0169EB8A90CC23F59135B464AB440@DF4PR84MB0169.NAMPRD84.PROD.OUTLOOK.COM>
 <20170210164458.GB2734@sbauer-Z170X-UD5>
Message-ID: <20170213080454.GA18903@infradead.org>

On Fri, Feb 10, 2017@09:44:59AM -0700, Scott Bauer wrote:
> > > +F:include/linux/sed*
> > > +F:include/uapi/linux/sed*
> > 
> > Since this is in the block tree and is not nvme specific, could you use
> > linux-block as the main list?
> 
> Sure, that's fine. Is there a way to denote "main list" in maintainers,
> or just list it first?

I'd just use linux-block - traffic isn't much higher than the nvme list,
and it fits a lot better.  FYI, I hope to have ATA (and as byproduct
SCSI) support ready for the next merge window.
