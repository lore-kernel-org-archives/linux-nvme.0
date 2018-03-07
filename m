From: hare@suse.de (Hannes Reinecke)
Date: Wed, 7 Mar 2018 16:48:29 +0100
Subject: NVMf initiator persistent across boots
In-Reply-To: <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
 <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
Message-ID: <ac5d043b-f28d-8516-2b23-8e9daa1e439f@suse.de>

On 03/05/2018 08:45 PM, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> Sorry for the delay, but I wanted to know if we had a progress for
>> this topic. I want to add functionality that gives persistency for
>> fabric devices not only across boots but also across adapter/device
>> removals.
>> My idea is to add a flag --persist to "nvme connect" command. This
>> command will add the created ctrls to a file
>> (/etc/nvme-fabrics/persistent_ctrls for example).
>> And I want to add a udev rule that in case of ctrl removal, we'll run
>> a script that try to periodicly connect to the target.
> Why not just add a periodic task to run nvme connect-all?
> -- 
> [Unit]
> Description=NVMf auto discovery service
> After=systemd-modules-load.service network-online.target
> 
> [Service]
> Type=oneshot
> ExecStart=/usr/bin/nvme connect-all
> StandardOutput=journal
> 
> [Timer]
> OnUnitActiveSec=1min
> 
> [Install]
> WantedBy=multi-user.target timers.target
> -- 
> 
> That would simply run nvme connect-all once every say minute.
> The only problem is that it relies on the kernel to fail
> duplicate subsystems. We could enforce that in nvme-cli for that
> matter though (we can compare against sysfs address and subsysnqn).
> 
> Johannes is probably one to know better than me if this is the
> correct way to go...
> 
In principle we could; but we should first decide what the correct
strategy here is.
FC has the same issue, and tries to overcome this by adding custom
uevents.

Wasn't there a session proposed at LSF/MM?
I guess that's the right forum to discuss it, as it'll involve all fabrics.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
