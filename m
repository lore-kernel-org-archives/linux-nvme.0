From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 16:20:58 +0300
Subject: [PATCH 2/2] nvme: no need to wait for the reset when keepalive
 fails
In-Reply-To: <20170615131518.GA23908@lst.de>
References: <20170612162738.19022-1-hch@lst.de>
 <20170612162738.19022-2-hch@lst.de>
 <b9348f66-2530-6e3c-67e4-7f0a56b7fc5a@grimberg.me>
 <20170615121647.GA18698@infradead.org>
 <e26a5920-3625-1876-3a89-e85a74846f5d@grimberg.me>
 <20170615124643.GA23852@lst.de>
 <1f0dd933-1535-c22e-d44b-665a2df12ee4@grimberg.me>
 <20170615131518.GA23908@lst.de>
Message-ID: <095d5e5d-7862-8b92-8003-bafdb522728d@grimberg.me>


>>> I dropped the admin_queue checks as request by you.
>>
>> Then I don't see it. is it under the same title?
> 
> I was sent in the same series as the patch you reviewed, thus the
> 2/2 in the subject.

in "[PATCH 1/2] nvme: move reset workqueue handling to common code"
its still there...
