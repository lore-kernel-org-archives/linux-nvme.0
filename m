From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Oct 2015 17:32:27 +0200
Subject: [dm-devel] [PATCH 3/6] sd: implement the Persistent
 Reservation API
In-Reply-To: <561FC6AA.3080508@sandisk.com>
References: <1444911052-9423-1-git-send-email-hch@lst.de>
 <1444911052-9423-4-git-send-email-hch@lst.de> <561FC6AA.3080508@sandisk.com>
Message-ID: <20151015153227.GA3536@lst.de>

On Thu, Oct 15, 2015@08:30:50AM -0700, Bart Van Assche wrote:
> Can you explain why this functionality has been added to the sd driver 
> instead of the SCSI core ? Aren't persistent reservations a concept that 
> applies to all SCSI device types ?

In theory it does.  In practice it's only used by disks/arrays and tapes,
and as tapes don't have a struct block_device this isn't going to be useful
for them.
