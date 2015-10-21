From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 21 Oct 2015 17:41:40 +0300
Subject: [PATCH 10/18] nvme: move nvme_setup_flush and nvme_setup_rw to
 common code
In-Reply-To: <20151021065510.GA19280@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-11-git-send-email-hch@lst.de>
 <56261EF2.3080507@dev.mellanox.co.il> <20151021065510.GA19280@lst.de>
Message-ID: <5627A424.2000209@dev.mellanox.co.il>

On 10/21/2015 9:55 AM, Christoph Hellwig wrote:
> On Tue, Oct 20, 2015@02:01:06PM +0300, Sagi Grimberg wrote:
>> I do agree that making these static inline can speed things up here,
>> but the coding style documentation asks to avoid inline'ing functions
>> longer than a few lines of code (See Documentation/CodingStyle Chapter
>> 15: "The inline disease").
>>
>> Do you think this case qualifies as an exception?
>
> Yes.  The inline is only used once per NVMe transport driver and it's
> used in the absolute fast path in a place where being able to optimize
> the assignments inside and outside the function call will become useful.
> Also all the code is trivial assignments and simple conditionals so it's
> actually pretty small in terms of generated code.
>

I agree it is better to have them inline...

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
