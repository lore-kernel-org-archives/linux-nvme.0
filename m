From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 4 Mar 2018 17:56:31 +0200
Subject: NVMf initiator persistent across boots
In-Reply-To: <20170830094553.GC3941@linux-x5ow.site>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
Message-ID: <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>

Hi all,

Sorry for the delay, but I wanted to know if we had a progress for this 
topic. I want to add functionality that gives persistency for fabric 
devices not only across boots but also across adapter/device removals.
My idea is to add a flag --persist to "nvme connect" command. This 
command will add the created ctrls to a file 
(/etc/nvme-fabrics/persistent_ctrls for example).
And I want to add a udev rule that in case of ctrl removal, we'll run a 
script that try to periodicly connect to the target.

thoughts ?

On 8/30/2017 12:45 PM, Johannes Thumshirn wrote:
> [+Cc James]
> 
> On Wed, Aug 30, 2017@12:37:47PM +0300, Sagi Grimberg wrote:
> [...]
>> Something like:
>> --
>> [Unit]
>> Description=NVMf auto discovery service
>> After=systemd-modules-load.service network-online.target
>>
>> [Service]
>> Type=oneshot
>> ExecStart=/usr/bin/nvme connect-all
>> StandardOutput=journal
>>
>> [Install]
>> WantedBy=multi-user.target
>> --
>>
>> Where discovery.conf would have the relevant parameters
>> like:
>> --
>> --traddr=<traddr1> --trsvcid=<trsvcid1>
>> --traddr=<traddr2> --trsvcid=<trsvcid2>
>> --
>>
>> One thing we may want to have is to make sure
>> that nvme relevant modules are loaded at boot time
>> so we may want nvme-cli to either manually load them
>> or the installation would add them to systemd-modules-load.service
>> (i.e. add relevant files to /etc/modules-load.d/)
>>
>> Thoughts?
> 
> That's exactly what I wanted to do for SUSE distros as well, so I'm fine with
> it.
> 
> James Smart has a bunch of scripts and udev rules for FC-NVMe autoconnecting
> and I asked him earlier today to sumbit them here as well.

Can you share these rules so we can create something generic ?

> 
> Byte,
> 	Johannes
> 

Cheers,
Max.
