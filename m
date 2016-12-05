From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Dec 2016 14:33:27 -0500
Subject: detect and warn about ahci-remapped NVMe devices
In-Reply-To: <1480703463-17489-1-git-send-email-hch@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
Message-ID: <20161205193327.GB30331@mtj.duckdns.org>

Hello,

On Fri, Dec 02, 2016@07:31:00PM +0100, Christoph Hellwig wrote:
> Just a small band-aid to detect the AHCI-remapped NVMe devices
> for now.  Hopefully we'll eventually get a fake PCIe root port
> driver ala VMD for them.

Applied 1-3 to libata/for-4.10.  Fixed the dup constant definition in
0002.

Thanks.

-- 
tejun
