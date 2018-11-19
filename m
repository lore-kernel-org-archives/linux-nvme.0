From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Nov 2018 11:00:24 -0800
Subject: [PATCH 3/7] nvme-fc: remove unused poll implementation
In-Reply-To: <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-4-axboe@kernel.dk> <20181119075904.GC9622@infradead.org>
 <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>
Message-ID: <b3a8a5a0-3788-b8ae-57d4-7550f56f0400@broadcom.com>



On 11/19/2018 7:19 AM, Jens Axboe wrote:
> On 11/19/18 12:59 AM, Christoph Hellwig wrote:
>> On Sat, Nov 17, 2018@02:43:50PM -0700, Jens Axboe wrote:
>>> This relies on the fc taget ops setting ->poll_queue, which
>>> nobody does. Otherwise it just checks if something has
>>> completed, which isn't very useful.
>> Please also remove the unused ->poll_queue method.
>>
>> Otherwise looks fine:
>>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Sure, will do.
>

Looks fine on my end

Reviewed-by:? James Smart <jsmart2021 at gmail.com>
