From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 19:17:40 +0300
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <4c3be76c-0ae3-a95a-3067-cebb9fab340e@fb.com>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
 <20170228141017.GC20317@lst.de>
 <20170228160056.GA15639@localhost.localdomain>
 <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>
 <20170420085609.GA6217@linux-x5ow.site>
 <20170420142044.GB21311@localhost.localdomain>
 <4c3be76c-0ae3-a95a-3067-cebb9fab340e@fb.com>
Message-ID: <8ae3cdeb-0c81-7ce9-758e-717d7955808c@grimberg.me>


>> Thanks, I forgot about this one, but still think it's a good idea.
>> Applied it to for-next.
>
> Agree, it's a nice addition.

I think its harmless to have. especially when we do log that it
happened.
