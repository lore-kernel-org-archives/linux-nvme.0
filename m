From: nickchengster@gmail.com (Nick Cheng)
Date: Mon, 14 May 2018 14:26:38 +0800
Subject: How to setup nvmetcli for FC loopback mode?
Message-ID: <CAHoscUe9uAsp0tdBzzN85AzkoG=WFyuGG4rj=4O7EE02pgK4qQ@mail.gmail.com>

Hi there,
I faced a problem about setting nvmetcli for FC loopback mode.
The configuration is a NVMe SSD, KC1000, from Kingston and a HBA, QLE2672
2-port 16Gb Fibre Channel Adapter, from QLogic and are installed on Linux
kernel 4.16.6.

The scenario is a fc loop mode, which uses the sole FC HBA as an initiator
and target, to access the NVMe SSD as a NVMe target.

I installed all the required drivers, i.e. nvme-core, nvme, nvme-fabrics,
nvme-fc, nvmet, nvmet-fc, nvme-loop, nvme-fcloop and qla2xxx, in order and
nvmetcli and followded through steps on
http://git.infradead.org/users/hch/nvmetcli.git/blob/HEAD:/Documentation/nvmetcli.txt
.

But when I reach line 212, "create testnqn", on the link above, I had error
message as
"Could not symlink testnqn in configFS: [Errno 6] No such device or
address".

I hacked the kernel source and found seemingly there are some device
attributes on the path, "/sys/devices/virtual/fcloop/ctl/", to fill. But I
can't figure out what strings and format are.

Please guide me, if you have any ideas.

Thank you,
