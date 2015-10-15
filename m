From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 15 Oct 2015 08:30:50 -0700
Subject: [dm-devel] [PATCH 3/6] sd: implement the Persistent Reservation
 API
In-Reply-To: <1444911052-9423-4-git-send-email-hch@lst.de>
References: <1444911052-9423-1-git-send-email-hch@lst.de>
 <1444911052-9423-4-git-send-email-hch@lst.de>
Message-ID: <561FC6AA.3080508@sandisk.com>

On 10/15/2015 05:10 AM, Christoph Hellwig wrote:
> This is a mostly trivial mapping to the PERSISTENT RESERVE IN/OUT
> commands.

Hello Christoph,

Can you explain why this functionality has been added to the sd driver 
instead of the SCSI core ? Aren't persistent reservations a concept that 
applies to all SCSI device types ?

Thanks,

Bart.
