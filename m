From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 1 Feb 2018 23:07:15 +0800
Subject: [PATCH] nvme: Fix discard buffer overrun
In-Reply-To: <20180201150533.GG27735@localhost.localdomain>
References: <20180201000158.23012-1-keith.busch@intel.com>
 <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
 <20180201150533.GG27735@localhost.localdomain>
Message-ID: <9ae3b38d-d949-535a-5b71-0cd1702729c9@oracle.com>

Hi Keith

Thanks for your kindly response.

On 02/01/2018 11:05 PM, Keith Busch wrote:
> On Thu, Feb 01, 2018@10:55:30PM +0800, jianchao.wang wrote:
>> Hi Keith
>>
>> Since each discard bio merged into a request is counted as one segment,
>> why not let blk_rq_nr_discard_segments return numbers of bios directly.
> 
> Right, I'm all for fixing the discard segment count. At the same time,
> I don't want to depend on it's correctness to not access out-of-bounds
> array indices.
> 
Actually, if we use iterating request bio list to return discard segments count,
we won't have any out-of-bounds error any more. And things will be simpler. :)

Thanks
Jianchao
