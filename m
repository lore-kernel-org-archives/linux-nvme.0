From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 27 Jan 2016 13:19:14 +0200
Subject: [PATCH 2/2] NVMe: Fix io incapable return values
In-Reply-To: <CAF1ivSZEoSbnQTiJFYh+pjdz1FdhO=Hhq96mjf8OZuWS7asNoA@mail.gmail.com>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <1453757017-13640-2-git-send-email-keith.busch@intel.com>
 <20160126165415.GC609@infradead.org>
 <CAF1ivSZEoSbnQTiJFYh+pjdz1FdhO=Hhq96mjf8OZuWS7asNoA@mail.gmail.com>
Message-ID: <56A8A7B2.9000006@dev.mellanox.co.il>


>>> The function returns true when the controller can't handle IO.
>>
>> Ooops.  I though I had actually seen a fix for this a short while
>> ago, not sure why that got missed.
>
> Yes, you saw that. It is in NVMeOF driver.

Yea...

>> Acked-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
