From: sbauer@eng.utah.edu (Scott Bauer)
Date: Fri, 30 Dec 2016 22:41:46 -0700
Subject: [PATCH v4 0/6] SED OPAL Library
In-Reply-To: <20161231035108.GA18886@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <20161230082826.GA30378@infradead.org>
 <20161230225252.GA3716@sbauer-Z170X-UD5>
 <20161231035108.GA18886@infradead.org>
Message-ID: <5c2ba56a-dfc4-d83a-0df0-b66b2f59cb54@eng.utah.edu>



On 12/30/2016 08:51 PM, Christoph Hellwig wrote:
> On Fri, Dec 30, 2016@03:52:53PM -0700, Scott Bauer wrote:
>> On Fri, Dec 30, 2016@12:28:26AM -0800, Christoph Hellwig wrote:
>>> Hi Scott,
>>>
>>> do you have a pointer to the userspace using this ioctls?  Over the
>>> holidays I finally managed to put a test system for my collection of m.2
>>> key M cards together, so I should be able to test the code, which I'd
>>> definitively like to do before ACKing.  More comments on the code itself
>>> will follow soon.
>>
>>
>> We've enabled the supporte into nvmecli you can pull my branch here:
>> https://github.com/ScottyBauer/nvme-cli/tree/sed-nvme
> 
> Can we move this out of nvme-cli into a separate tool?  I'd like to use
> your code to support ATA disk as well.  (and that should give us SCSI
> for free, but I don't have access to a SCSI disk with OPAL support)
> 

I don't have an issue with that. It may take a week or two we'll have to have
lawyers and crap OK the new program, not sure how long that takes.
