From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 22 Jun 2017 20:53:05 +0200
Subject: [PATCH v2 3/6] qla2xxx: Add FC-NVMe F/W initialization and
 transport registration
In-Reply-To: <2d07d1fd-545b-0308-8a2b-5cfb59cbcf2b@broadcom.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-4-himanshu.madhani@cavium.com>
 <20170622094649.GD5670@linux-x5ow.site>
 <2d07d1fd-545b-0308-8a2b-5cfb59cbcf2b@broadcom.com>
Message-ID: <20170622185305.GB3284@linux-x5ow.site>

On Thu, Jun 22, 2017@10:48:46AM -0700, James Smart wrote:
> He can't move it. the fcport->nvme_remote_port pointer is set by the
> nvme_fc_register_remoteport() routine (if return status is 0).

Gah, that's kind of wired. Literly _all_ of the Kernel's register_xxx()
funtions have a semantic that after the registration is done the object can be
used and thus assigning private pointer afterwards is an error. Damn I didn't
realize this in the nmve-fc review.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
