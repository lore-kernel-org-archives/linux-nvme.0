From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 17 Dec 2018 09:33:24 +0100
Subject: [PATCH v3 2/2] trace nvme submit queue status
In-Reply-To: <20181217080605.16867-2-yupeng0921@gmail.com>
References: <20181217080605.16867-1-yupeng0921@gmail.com>
 <20181217080605.16867-2-yupeng0921@gmail.com>
Message-ID: <11554384-e0a9-0bde-97e9-228b29e6b641@suse.de>

Is the addition of a trace_pci.h really needed? Why can't you just put
it in trace.h?

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
