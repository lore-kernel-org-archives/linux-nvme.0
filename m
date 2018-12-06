From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Dec 2018 16:44:32 +0100
Subject: [PATCH 2/2] nvme: create slaves/holder entries for multipath
 devices
In-Reply-To: <20181128083816.GB4269@calabresa>
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-3-hch@lst.de> <20181128083816.GB4269@calabresa>
Message-ID: <20181206154432.GA26584@lst.de>

On Wed, Nov 28, 2018@06:38:17AM -0200, Thadeu Lima de Souza Cascardo wrote:
> I will send a followup that includes your two patches, fixing up this one, plus
> another two because that is simply reverting the revert of Hanne's patch. Which
> means it still has the lsblk bug.
> 
> Then, we have two options: do not use GENHD_FL_HIDDEN on multipath nvme disks,
> or expose devt for those disks. I am sending a patch for the second option.

Can you please send it out so we can look at it before the 4.21 merge
window opens?
