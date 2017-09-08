From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 8 Sep 2017 07:44:37 -0400 (EDT)
Subject: Host reconnecting need more than 60s to start after nvmetcli clear
 on target
In-Reply-To: <506214967.5315130.1504869110572.JavaMail.zimbra@redhat.com>
Message-ID: <402757886.5318604.1504871077415.JavaMail.zimbra@redhat.com>

Hi

I found this issue on latest 4.13, is it for designed?  I cannot reproduce it on 4.12.

Here is the log from host:
4.13
[  637.246798] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
[  637.436315] nvme nvme0: creating 40 I/O queues.
[  637.939988] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
[  645.319803] nvme nvme0: rescanning

-->need more than 60 seconds to start reconnect

[  706.073551] nvme nvme0: Reconnecting in 10 seconds...
[  717.740550] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  717.748061] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  717.754495] nvme nvme0: Failed reconnect attempt 1
[  717.759853] nvme nvme0: Reconnecting in 10 seconds...
[  728.530246] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  728.537757] nvme nvme0: rdma_resolve_addr wait failed (-104).

4.12
[  106.264737] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
[  106.390110] nvme nvme0: creating 40 I/O queues.
[  106.903876] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
[  116.865211] nvme nvme0: rescanning
[  116.912470] nvme nvme0: Reconnecting in 10 seconds...
[  127.129986] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  127.137492] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  127.144116] nvme nvme0: Failed reconnect attempt 1
[  127.149474] nvme nvme0: Reconnecting in 10 seconds...
[  137.343403] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  137.350904] nvme nvme0: rdma_resolve_addr wait failed (-104).


Best Regards,
  Yi Zhang
