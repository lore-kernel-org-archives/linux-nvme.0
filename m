From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu, 6 Dec 2018 14:48:47 -0200
Subject: [PATCH 2/2] nvme: create slaves/holder entries for multipath
 devices
In-Reply-To: <20181206154432.GA26584@lst.de>
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-3-hch@lst.de>
 <20181128083816.GB4269@calabresa> <20181206154432.GA26584@lst.de>
Message-ID: <20181206164846.GF4269@calabresa>

On Thu, Dec 06, 2018@04:44:32PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 28, 2018@06:38:17AM -0200, Thadeu Lima de Souza Cascardo wrote:
> > I will send a followup that includes your two patches, fixing up this one, plus
> > another two because that is simply reverting the revert of Hanne's patch. Which
> > means it still has the lsblk bug.
> > 
> > Then, we have two options: do not use GENHD_FL_HIDDEN on multipath nvme disks,
> > or expose devt for those disks. I am sending a patch for the second option.
> 
> Can you please send it out so we can look at it before the 4.21 merge
> window opens?

Just sent. Sorry about the delay.

Thanks.
Cascardo.
