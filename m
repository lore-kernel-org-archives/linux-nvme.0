From: keith.busch@intel.com (Keith Busch)
Date: Fri, 9 Oct 2015 14:20:38 +0000 (UTC)
Subject: [PATCH 8/8] nvme: properly handle partially initialized queues
 in nvme_create_io_queues
In-Reply-To: <20151009061506.GA28370@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-9-git-send-email-hch@lst.de>
 <56169138.90804@dev.mellanox.co.il> <20151009061506.GA28370@lst.de>
Message-ID: <alpine.LNX.2.00.1510091419100.27742@localhost.lm.intel.com>

On Thu, 8 Oct 2015, Christoph Hellwig wrote:
> On Thu, Oct 08, 2015@06:52:24PM +0300, Sagi Grimberg wrote:
>> On 10/3/2015 4:39 PM, Christoph Hellwig wrote:
>>> This avoids having to clean up later in a seemingly unrelated place.
>>>
>>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>>
>> I assume Keith reviewed this one correct? :)
>
> He did reply with a reviewed-by tag to the previous posting of the series,
> I think that qualifies.

I think Sagi was just making a light of using the wrong name (your's)
in the "Reviewed-by". :)
