From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 2 Feb 2018 09:50:32 +0800
Subject: [PATCH] nvme: Fix discard buffer overrun
In-Reply-To: <1d659e2b-42a4-f453-c85b-5d58c6c01f40@kernel.dk>
References: <20180201000158.23012-1-keith.busch@intel.com>
 <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
 <1d659e2b-42a4-f453-c85b-5d58c6c01f40@kernel.dk>
Message-ID: <7b2262e6-dc60-6289-0d11-53882846208b@oracle.com>

Hi Jens

Thanks for your kindly response.

On 02/01/2018 11:27 PM, Jens Axboe wrote:
> On 2/1/18 7:55 AM, jianchao.wang wrote:
>> Hi Keith
>>
>> Since each discard bio merged into a request is counted as one segment,
>> why not let blk_rq_nr_discard_segments return numbers of bios directly.
> 
> That's a good idea, but for now this looks fine. Both this and the
> core block hole can be fixed, and then someone can hopefully work
> on making discards behave a bit more nicely after that.
> 
Yes, got it.

Thanks
Jianchao
