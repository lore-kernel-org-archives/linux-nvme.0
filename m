From: Zeta_Syanthis@Jabil.com (Zeta Syanthis)
Date: Mon, 24 Oct 2016 23:02:48 +0000
Subject: [NVME-CLI] NVMe Format Issues - HGST Drives
Message-ID: <BY2PR0201MB19119DF43362BC07D9F7D9E38FA90@BY2PR0201MB1911.namprd02.prod.outlook.com>

Recently, when running an nvme-format against some HGST NVMe drives, I saw some odd errors crop up in syslog that all looked like this. I've seen it on a few systems now and have become a little more concerned.? I've seen references to this around the mailing list, but am a bit confused. Is this a kernel bug, or is it likely to be a hardware issue?

Oct 14 09:45:45 localhost kernel: nvme 0000:05:00.0: I/O 1 QID 0 timeout, reset controller

For reference, I'm running Centos 7.2 with the 4.4.1 elrepo kernel and nvme-cli 0.8.? I'm running these two commands in sequence:

nvme format -s 1 /dev/nvme0n1
nvme format? /dev/nvme0n1

Thank you,

Zeta Mercy Syanthis
Software Test Engineer
StackVelocity
