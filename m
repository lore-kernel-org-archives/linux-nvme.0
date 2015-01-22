From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 16:58:02 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <20150122154930.GA28027@infradead.org>
References: <1421886503-25276-1-git-send-email-yan@purestorage.com>
 <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>
 <20150122084517.GA2093@infradead.org>
 <alpine.LNX.2.00.1501221430040.15481@localhost.lm.intel.com>
 <20150122154930.GA28027@infradead.org>
Message-ID: <alpine.LNX.2.00.1501221651410.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Christoph Hellwig wrote:
> On Thu, Jan 22, 2015@03:21:28PM +0000, Keith Busch wrote:
>> But if you really need to restrict namespace access, shouldn't that be
>> enforced on the target side with reservations or similar mechanism?
>
> Think for example about containers where we give eah container access
> to a single nvme namespace, including container root access.  Here you
> don't really want container A to be able to submit I/O for another
> container.  A similar case exists for virtualization where we had
> problems with SCSI passthrough from guests.


Okay, that's a great point.

Yan, we should apply this if you can submit a patch for the linux-block
tree.
