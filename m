From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 12 Nov 2012 15:55:43 +0000
Subject: Linux-nvme Digest, Vol 8, Issue 3
In-Reply-To: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEEC01@corpmail1.na.ads.idt.com>
References: <mailman.11.1352221203.2108.linux-nvme@lists.infradead.org>
 <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEEC01@corpmail1.na.ads.idt.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B9162BC5A3@FMSMSX105.amr.corp.intel.com>

> -----Original Message-----
> From: linux-nvme-bounces at lists.infradead.org [mailto:linux-nvme-
> bounces at lists.infradead.org] On Behalf Of Panah, Khosrow
> Sent: Friday, November 09, 2012 5:32 PM
> To: linux-nvme at lists.infradead.org
> Subject: RE: Linux-nvme Digest, Vol 8, Issue 3
> 
> All,
> 
> Driver should check controller Identify data to validate Discard/TRIM
> command is supported prior to exporting this feature.
> 
> 

Yes it should, though the patch I submitted already does exactly that.
