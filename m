From: zhitaoli1201@163.com (zhitaoli1201@163.com)
Date: Sat, 27 Oct 2018 15:34:52 +0800
Subject: Duplicate subnqn of NVMe SSD Controllers
Message-ID: <5m6gor-7xj0dn5dtb12x1b8f3-xfsypw-s3pjnd-oq8eyy-82l7b1-qdnqdci1wm87jp0w3aj5wymq-xt9rda-x787pwq8q8mz-118hyj7ztvz0flkog2-9es5q86pqysjjks19b-ps9rfn-a0r0vp7260ev.1540625692098@email.android.com>

Hello, everyone,


I am Zhitao Li, interested in Linux kernel and?SSDs.

I am writing nvme device drivers based on my Open-channel SSDs. However, when two SSDs are connected to motherboard and Linux(4.17) boots, following warning information will be printed in the booting process:


"nvme nvme1: ignoring ctrl due to duplicate subnqn (nqn.2014.08.org.nvmexpress:1ded1dedAA....)"


It seems that the?nvme qualified name of my two SSDs is same. After booting, only one device is available.


Could anyone give some explanation or advice about how to make both devices availbale?


?

Best regards,

Zhitao Li
