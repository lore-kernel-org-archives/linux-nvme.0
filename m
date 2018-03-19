From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 19 Mar 2018 11:11:43 +0100
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <1521452867-13619-2-git-send-email-israelr@mellanox.com>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
Message-ID: <20180319101143.lfsy2lksp3zl5lcr@linux-x5ow.site>

On Mon, Mar 19, 2018@09:47:47AM +0000, Israel Rukshin wrote:
> tractive port flag means that nvmet transport is active and ready for
> receiving requests from host.
> It differ from enabled port state (port with subsystem symbolic link)
differs^


Also, this would need an accompanying nvmetcli change as well.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
