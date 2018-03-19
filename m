From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 19 Mar 2018 11:56:49 +0100
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <3ff966fc-ee5c-e171-f427-638619ff706f@mellanox.com>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
 <20180319101143.lfsy2lksp3zl5lcr@linux-x5ow.site>
 <3ff966fc-ee5c-e171-f427-638619ff706f@mellanox.com>
Message-ID: <20180319105649.vchnplwx4c5vjkhb@linux-x5ow.site>

On Mon, Mar 19, 2018@12:48:15PM +0200, Max Gurtovoy wrote:
> 
> 
> On 3/19/2018 12:11 PM, Johannes Thumshirn wrote:
> > On Mon, Mar 19, 2018@09:47:47AM +0000, Israel Rukshin wrote:
> > > tractive port flag means that nvmet transport is active and ready for
> > > receiving requests from host.
> > > It differ from enabled port state (port with subsystem symbolic link)
> > differs^
> > 
> > 
> > Also, this would need an accompanying nvmetcli change as well.
> 
> Are you reffereing to the current implementation ?
> Which change is in your mind ?
> 
> Currently the tractive flag will become true if the initial port
> configuration will succeed (also using nvmetcli).
> One can create a service/timer/script to check periodically the tractive
> flag and echo 1 to it in case needed (for persistent target configuration).

No I was thinking of a nvmetcli command to administratively toggle the
tractive flag from within nvmetcli.

It is exported via configfs 'CONFIGFS_ATTR(nvmet_, tractive);' so
what's the purpose of a user controllable knob that can't be
controlled by the tool that usually configures these?

Byte,
	   Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
