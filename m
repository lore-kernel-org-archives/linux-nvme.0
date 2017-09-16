From: hch@lst.de (hch@lst.de)
Date: Sat, 16 Sep 2017 03:09:47 +0200
Subject: [PATCH] qla2xxx: convert nvme Transport error to internal error
In-Reply-To: <yq1poartq01.fsf@oracle.com>
References: <20170914183015.21540-1-jsmart2021@gmail.com>
 <5CEF2024-2483-401C-8134-3709DF54CBB6@cavium.com>
 <yq1poartq01.fsf@oracle.com>
Message-ID: <20170916010947.GA16883@lst.de>

On Fri, Sep 15, 2017@09:02:22PM -0400, Martin K. Petersen wrote:
> 
> Himanshu,
> 
> >> Patch removing transport-specific errors crosssed with a qla2xxx update
> >> that referenced the status value being removed.
> >> 
> >> Swap status to an internal error.
> 
> Applied to 4.14/scsi-fixes.

I've already picked this up with the reset of James' series to get rid of
these errors in lpfc and the nvme code.  I can still rebase the nvme tree,
but it will require the scsi tree to get in first which is a little
annoying.
