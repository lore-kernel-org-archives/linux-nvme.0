From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 02 Oct 2017 16:45:34 +0200
Subject: [PATCH] nvme: reset retires after path failover
In-Reply-To: <20171002143503.14507-1-jthumshirn@suse.de> (Johannes Thumshirn's
 message of "Mon, 2 Oct 2017 16:35:03 +0200")
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <20171002143503.14507-1-jthumshirn@suse.de>
Message-ID: <mqdtvzh38xd.fsf@linux-x5ow.site>

Gah, please ignore this one. I tested on the wrong device.

But FYI, when triggering a path failure in my RDMA setup (setting one
switch port down) I get these nice messages:
[ 1148.124063] nvme nvme0: SEND for CQE 0xffff8817c3720180 failed with
status transport retry counter exceeded (12)
[ 1148.180489] nvme nvme0: failed nvme_keep_alive_end_io error=10
[ 1148.187887] nvme nvme0: Reconnecting in 10 seconds...
[ 1148.194356] print_req_error: I/O error, dev nvme0n1, sector 1690128
[ 1148.194361] print_req_error: I/O error, dev nvme0n1, sector 1692168
[ 1148.194367] print_req_error: I/O error, dev nvme0n1, sector 1694208
[ 1148.379058] XFS (nvms0n1): writeback error on sector 1628688

the nvme ones are expected, but I don't really like to see writeback
errors from the FS here. Something's still a bit off.

Byte,
        Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
