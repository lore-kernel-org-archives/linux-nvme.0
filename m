From: hch@lst.de (Christoph Hellwig)
Date: Sat, 24 Sep 2016 01:36:00 +0200
Subject: [PATCH] nvmet: Use direct IO for writes
In-Reply-To: <766d06e4-748f-e380-c522-5977794c66ac@grimberg.me>
References: <1474481450-5036-1-git-send-email-sagi@grimberg.me>
 <20160922135707.GA14645@lst.de>
 <369f64ac-7059-ca5a-24aa-6775985e049e@kernel.dk>
 <90968fae-476a-2f7a-cb93-f83e99a9d878@grimberg.me>
 <63105f3f-3042-5b98-86e4-d8a1cc51494d@kernel.dk>
 <766d06e4-748f-e380-c522-5977794c66ac@grimberg.me>
Message-ID: <20160923233600.GA19147@lst.de>

On Fri, Sep 23, 2016@02:12:38PM -0700, Sagi Grimberg wrote:
>
>>> So are we OK with bypassing that in nvmet?
>>
>> I'm OK with the patch as posted.
>
> Thanks, I'll queue it up for 4.9

Btw, it might be a good idea to send our for-4.9 branch to Jens
so it gets some linux-next exposure.
