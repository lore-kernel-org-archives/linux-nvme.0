From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 05 Dec 2017 08:57:31 +0100
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning
 event
In-Reply-To: <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me> (Sagi
 Grimberg's message of "Tue, 5 Dec 2017 09:28:53 +0200")
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-2-sagi@grimberg.me>
 <20171204200721.GB17023@lst.de>
 <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me>
Message-ID: <mqda7yxehec.fsf@linux-x5ow.site>

Sagi Grimberg <sagi at grimberg.me> writes:
> 2. handle the event in the kernel, issue the log page with retain bit on
> and only then notify userspace.
>
> I personally prefer (2), what do others think?

Sorry for chiming in so late, but I agree with Sagi.

Byte,
        Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
