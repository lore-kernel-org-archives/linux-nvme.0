From: s90752@hotmail.com (Ching-Chiao Chang)
Date: Thu, 29 Nov 2018 00:50:18 +0000
Subject: Whenever running nvme discover command, syslog shows warning messages
Message-ID: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>

Hi,

Whenever running nvme discover command, i.e., nvme discover --transport=rdma --traddr=10.10.0.4, syslog shows the following messages,
Nov 27 15:24:30 initiator-xxx kernel: [55897.822948] nvme nvme1: sqsize 128 > ctrl maxcmd 1, clamping down
Nov 27 15:24:30 initiator-xxx kernel: [55897.822956] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.10.0.4:4420
Nov 27 15:24:30 initiator-xxx kernel: [55897.823213] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
...
I was wondering if there is any way to avoid these warning messages?

OS: Ubuntu 16.04.5
Kernel: 4.18.5-041805-generic
nvme version 1.6.120.g5c8a

Thanks.
Andy
