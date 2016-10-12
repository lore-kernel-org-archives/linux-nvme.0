From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Oct 2016 11:50:48 -0700
Subject: [PATCH 0/7 v2] nvme-fabrics: Add FC-NVME Transport support
In-Reply-To: <20161012085358.GA12972@infradead.org>
References: <57f82b0d.sLiRmQ0NSI2pLk2l%james.smart@broadcom.com>
 <20161012085358.GA12972@infradead.org>
Message-ID: <a12ea17d-bf55-1cb5-ae90-0dc90735a61d@broadcom.com>



On 10/12/2016 1:53 AM, Christoph Hellwig wrote:
> On Fri, Oct 07, 2016@04:09:01PM -0700, James Smart wrote:
>> The patches in this set add support for the FC transport to the nvme
>> fabrics subsystem.  The set include header files with T11 transport
>> definitions and an api for the FC-NVME transport to talk with FC LLDDs.
>> It also includes host and target transport files. A FC loopback driver
>> is supplied to act as a FC LLDD to exercise the api.
> What's the timeline for submitting the lpfc support?  Even if you're
> not submitting it quite yet having it available somewhere as a reference
> would be really useful when reviewing the code.

I've already submitted lpfc nvme support once with the prior transport 
posting. Look on linux-nvme as well as linux-scsi and look for the 
11.2.0.1 patch set.  I'm wrapping up the repost of it with this new 
transport posting now. It'll be based on a lpfc update that I'm posting 
momentarilly. So, within a day or two.


>
> Also the code makes git-am complain:
not sure what's generating this.  Everything is pre-checked vs 
Checkpatch. I'll look closer.

-- james
