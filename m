From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 7 Sep 2017 14:15:52 +0200
Subject: [PATCH] nvme: fix lightnvm check
In-Reply-To: <20170907120128.GB18794@lst.de>
References: <20170906094825.8845-1-hch@lst.de>
 <20170906150604.GD17331@localhost.localdomain>
 <20170907120128.GB18794@lst.de>
Message-ID: <4735ef51-e4a8-d34a-d6e4-fa969a3c1b58@lightnvm.io>

On 09/07/2017 02:01 PM, Christoph Hellwig wrote:
> On Wed, Sep 06, 2017@11:06:04AM -0400, Keith Busch wrote:
>> Ugh, even with this quirk, new lightnvm device will be broken for
>> all existing kernels. This sort of thing really could benefit from a
>> standard's defined capability or command set supported bit to distinguish
>> lightnvm devices. Lacking that, this looks like the only thing we can
>> do at the moment.
> 
> I told them to register a different class code for these devices a long
> time ago, but nothing happened.  Then again I might underestimate the
> complexity of getting a class code..

I must have misunderstood when we discussed it. I understood it as to 
add detection to the NVMe specification.

Going with Class code might not be the right way due to them describing 
the base protocol.

It would be great to have a command set id dedicated for it. We have 
been waiting on completing the specification before going in and 
allocating a bit. Another approach, as OCSSD has grown, might be to use 
the existing command set, and teach the identify command about 
Zones/Chunks, where one writes sequentially within.

Reviewed-by: Matias Bj?rling <mb at lightnvm.io>
