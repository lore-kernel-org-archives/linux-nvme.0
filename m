From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 1 Jun 2017 15:01:11 +0200
Subject: [PATCH v2 6/8] nvme: provide UUID value to userspace
In-Reply-To: <20170601124726.GF2845@localhost.localdomain>
References: <20170601111750.20880-1-jthumshirn@suse.de>
 <20170601111750.20880-7-jthumshirn@suse.de>
 <20170601124726.GF2845@localhost.localdomain>
Message-ID: <c71882ec-09ad-6104-0917-449abb8b27ae@suse.de>

On 06/01/2017 02:47 PM, Keith Busch wrote:
> FWIW, tools should have been using the 'wwid' attribute, which returns
> either EUI64 or NGUID so a unique identifier can be gotten from a
> single file without checking for the existence of either. That should
> help not break backward compatibility, but I've no idea if anything
> actually relies on 'uuid' returning the NGUID.

Yep, that's why I though I'd be clever and place this hack in there. I
think we can remove it in 1-2 years or so when most/all userspace has
adopted to the change (there shouldn't be too much apart from some hand
crafted udev rules anyways).

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
