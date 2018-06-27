From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 12:00:36 +0200
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
Message-ID: <20180627100036.iherk3kx64u7qcsk@linux-x5ow.site>

On Wed, Jun 27, 2018@11:06:22AM +0300, Sagi Grimberg wrote:
> Maybe change the display to request_queue_id=%d?

request_queue_id is pretty long, how about rqid?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
