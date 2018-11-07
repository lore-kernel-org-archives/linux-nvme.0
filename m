From: ilya@yadro.com (=?utf-8?B?0JjQu9GM0Y8g0JrRg9C30L3QtdGG0L7Qsg==?=)
Date: Wed, 7 Nov 2018 18:52:41 +0300
Subject: Question regarding dual-port NVMe drives naming.
Message-ID: <20181107155241.ynvixi56i44zeakz@yadro.com>

Hello,
recently I started to use dual-port NVMe drives and faced with behaviour different to single-port drives.

Dual-port drives have [virtual] Expansion ROM at 3ff083000000 [disabled] [size=128K] while single-port drives does not have expansion ROMs.
In naming of dual-port drives there are new names in sysfs like nvme1c1n1.
Also all dual-port drives in sysfs are located in virtual directory like they don't have any parent bus.

Could somebody explain this difference or give the direction where to dig?
Thank you in advance! 
