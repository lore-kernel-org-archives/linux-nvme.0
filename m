From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Wed, 25 Jun 2014 20:56:35 +0200
Subject: [PATCH v9] NVMe: Convert to blk-mq
In-Reply-To: <20140625113715.GA4525@infradead.org>
References: <1403651531-24891-1-git-send-email-m@bjorling.me>
 <1403651531-24891-2-git-send-email-m@bjorling.me>
 <20140625113715.GA4525@infradead.org>
Message-ID: <CAOu_J6nTcEjEpAe+S7Wg9SxUj_u=QitsDjYkKmCpaGP1MAexhw@mail.gmail.com>

On Wed, Jun 25, 2014@1:37 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Jun 25, 2014@01:12:11AM +0200, Matias Bj??rling wrote:
>> This converts the current NVMe driver to utilize the blk-mq layer.
>>
>> Contributions in this patch from:
>>
>>   Sam Bradshaw <sbradshaw at micron.com>
>>   Jens Axboe <axboe at kernel.dk>
>>   Keith Busch <keith.busch at intel.com>
>>   Christoph Hellwig <hch at infradead.org>
>>   Robert Nelson <rlnelson at google.com>
>
> Is there really something from me in here except for a bit of review?
>

Only the review. Do you want me to change it to a Reviewed-by?
