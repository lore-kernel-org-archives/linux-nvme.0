From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Mar 2018 21:45:17 +0200
Subject: NVMf initiator persistent across boots
In-Reply-To: <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
Message-ID: <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>


> Hi all,
> 
> Sorry for the delay, but I wanted to know if we had a progress for this 
> topic. I want to add functionality that gives persistency for fabric 
> devices not only across boots but also across adapter/device removals.
> My idea is to add a flag --persist to "nvme connect" command. This 
> command will add the created ctrls to a file 
> (/etc/nvme-fabrics/persistent_ctrls for example).
> And I want to add a udev rule that in case of ctrl removal, we'll run a 
> script that try to periodicly connect to the target.
Why not just add a periodic task to run nvme connect-all?
--
[Unit]
Description=NVMf auto discovery service
After=systemd-modules-load.service network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nvme connect-all
StandardOutput=journal

[Timer]
OnUnitActiveSec=1min

[Install]
WantedBy=multi-user.target timers.target
--

That would simply run nvme connect-all once every say minute.
The only problem is that it relies on the kernel to fail
duplicate subsystems. We could enforce that in nvme-cli for that
matter though (we can compare against sysfs address and subsysnqn).

Johannes is probably one to know better than me if this is the
correct way to go...
