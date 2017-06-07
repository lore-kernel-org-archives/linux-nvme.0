From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 7 Jun 2017 15:49:30 +0200
Subject: [PATCH v2 2/8] nvme: rename uuid to nguid in nvme_ns
In-Reply-To: <CAHp75VfcXQNPjJd4-7okeifmEBdCtCVkJVR6hMb=jmDryt71oQ@mail.gmail.com>
References: <20170601111750.20880-1-jthumshirn@suse.de>
 <20170601111750.20880-3-jthumshirn@suse.de>
 <CAHp75VfcXQNPjJd4-7okeifmEBdCtCVkJVR6hMb=jmDryt71oQ@mail.gmail.com>
Message-ID: <d8d850d5-781f-5803-3282-73099efd159b@suse.de>

On 06/07/2017 03:47 PM, Andy Shevchenko wrote:
> I suppose it should go through UUID tree?

Yup.

The whole series is based on the UUID tree, so I though Christoph will
pick it up after uuid/for-next is merged.



-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
