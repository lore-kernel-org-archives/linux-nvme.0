From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 17 Dec 2013 10:18:35 -0500
Subject: Inter NVMe drive attach problem
In-Reply-To: <003b01cefae2$bb145d70$313d1850$@com>
References: <003b01cefae2$bb145d70$313d1850$@com>
Message-ID: <20131217151835.GO6900@linux.intel.com>

On Tue, Dec 17, 2013@01:44:49PM +0900, ????? wrote:
> I test with nvme SSDD "Intel SSD DC P3700 Series (200GB) - fultondale".
> But, Disk drive is not found.
> 
> My system is SUSE Linux Enterprise Server 11 (Service pack3).
> 
> First I download Kernel source in NVME.org
> (http://git.infradead.org/users/willy/linux-nvme.git) daily snapshot.
> Then, Did kernel compile and applied it my Suse linux system successfully.
> but I could find it Mass Storge device tree.
> but, I could not find it in block device and DISK tree.
> I could find only SSD Drive by SATA.

Are you sure you don't have a DC S3700 drive?  These are SATA drives
and do not work with the NVMe driver; they would show up in the way you
are suggesting.  Perhaps you could send me an lspci and lsscsi off-list.
