From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 30 Aug 2017 12:37:47 +0300
Subject: NVMf initiator persistent across boots
In-Reply-To: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
Message-ID: <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>

Hi,

> Could we have NVMf initiator setup persistent across boots ?
> 
> Is this a possibility ? If yes, I would like suggestions on how this 
> could be implemented.

We could add a systemctl one-shot add-on that would
issue nvme connect-all for each line available in
the discovery.conf file.

Something like:
--
[Unit]
Description=NVMf auto discovery service
After=systemd-modules-load.service network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nvme connect-all
StandardOutput=journal

[Install]
WantedBy=multi-user.target
--

Where discovery.conf would have the relevant parameters
like:
--
--traddr=<traddr1> --trsvcid=<trsvcid1>
--traddr=<traddr2> --trsvcid=<trsvcid2>
--

One thing we may want to have is to make sure
that nvme relevant modules are loaded at boot time
so we may want nvme-cli to either manually load them
or the installation would add them to systemd-modules-load.service
(i.e. add relevant files to /etc/modules-load.d/)

Thoughts?
