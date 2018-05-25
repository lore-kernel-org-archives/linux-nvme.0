From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 25 May 2018 13:56:05 +0200
Subject: [BUG REPORT] crash in nvme-fcloop
Message-ID: <20180525115605.fbsf45jypmzjfxix@linux-x5ow.site>

Hey James et al,

I'm experiencing a bug with Linus' current master (HEAD ==
b50694381cfc22dce3a60a291cdae294a5e5777c) and nvme-fcloop.ko.

It's trivially reproduced (please find the reproducer below) and
manifests in several ways:

Either I get stuck in an endless loop of:
[   19.577145] nvme_fcloop: fcloop_exit: Failed deleting target port
[   19.577788] nvme_fcloop: fcloop_exit: Failed deleting remote port

Or it panics with the following trace (there are actually multiple
panics interleaved:
[  493.722109] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[  493.722395] nvme nvme1: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  493.724065] PGD 0 P4D 0
[  493.726673] Oops: 0000 [#1] SMP PTI
[  493.727524] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.727545] Modules linked in: loop nvme_fcloop(-) nvme_fc nvme_fabrics nvmet_fc nvmet nvme_core
[  493.729109] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.731249] CPU: 4 PID: 277 Comm: kworker/4:1 Not tainted 4.17.0-rc6+ #890
[  493.731251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  493.731258] Workqueue: events fcloop_tgt_lsrqst_done_work [nvme_fcloop]
[  493.732778] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.734456] RIP: 0010:fcloop_tgt_lsrqst_done_work+0x10/0x30 [nvme_fcloop]
[  493.734458] RSP: 0018:ffffabaa00ae3e78 EFLAGS: 00010286
[  493.736990] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.740252] RAX: ffff89ebf86f42a8 RBX: ffff89ebf86f42a8 RCX: ffff89ebfb3202a0
[  493.740253] RDX: 0000000000000000 RSI: ffff89ebf86f42a8 RDI: ffff89ebf86f4200
[  493.740254] RBP: ffff89ebf9eac000 R08: 0000000000000000 R09: 0000000000000001
[  493.740255] R10: 0000000000000001 R11: 0000000000000001 R12: ffff89ebfb320280
[  493.740256] R13: ffff89ebfb323f00 R14: 0000000000000000 R15: 0ffff89ebfb323f0
[  493.740258] FS:  0000000000000000(0000) GS:ffff89ebfb300000(0000) knlGS:0000000000000000
[  493.740259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  493.740260] CR2: 0000000000000008 CR3: 000000010340a000 CR4: 00000000000006e0
[  493.740264] Call Trace:
[  493.741114] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.742039]  process_one_work+0x147/0x350
[  493.742052]  worker_thread+0x47/0x3d0
[  493.742748] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.743571]  kthread+0xf8/0x130
[  493.743575]  ? rescuer_thread+0x2e0/0x2e0
[  493.744544] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.745503]  ? kthread_bind+0x10/0x10
[  493.745508]  ret_from_fork+0x35/0x40
[  493.745510] Code:
[  493.746484] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.747431] 48 89 39 31 c0 c3 0f 1f 44
[  493.748400] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.749478] 00 00 0f 1f 44 00 00 f3 c3 66 0f 1f 84 00 00 00 00
[  493.751108] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.752086] 00 0f 1f 44 00 00 48 89 f8
[  493.752431] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.753242] 48 8b 7f f8 48 8b 50 f0 <48> 83 7a 08 00 74
[  493.753792] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.753794] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.754294] 0c 8b 70 48 48 8b 47 38 e9 bd 0f 59 c5
[  493.755124] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.755547] f3
[  493.756098] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.756909] c3
[  493.757412] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.758181] nvme_fcloop: fcloop_exit: Failed deleting target port
[  493.758993] RIP: fcloop_tgt_lsrqst_done_work+0x10/0x30 [nvme_fcloop] RSP: ffffabaa00ae3e78
[  493.759101] (NULL device *): queue 0 connect admin queue failed (-111).
[  493.759516] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  493.760325] CR2: 0000000000000008
[  493.760327] ---[ end trace 3dea94f519a24d5e ]---

I really tried to fix the bug myself but I'm kinda lost in the maze
currently.

Any help is really appreciated here.

Thanks,
	Johannes

Reproducer:
>From 71a8453feec41ce66356de64b9dfc954ef121982 Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Thu, 24 May 2018 11:04:58 +0200
Subject: [PATCH blktests] nvme: add a reproducer for a nvme-fcloop test

This test creates a FC-NVME loopback target with two ports, connects
to it and then disconnects and removes the modules.

In case of failure the kernel will crash with a NULL pointer
dereference in __queue_work().

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

---
This is currently unfixed upstream
---
 common/nvme        |  57 +++++++++++++++++++++++++
 tests/nvme/006     | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/006.out |   2 +
 3 files changed, 180 insertions(+)
 create mode 100755 tests/nvme/006
 create mode 100644 tests/nvme/006.out

diff --git a/common/nvme b/common/nvme
index 5d7d89cbfb90..a202907582e0 100644
--- a/common/nvme
+++ b/common/nvme
@@ -101,3 +101,60 @@ _find_nvme_loop_dev() {
 		fi
 	done
 }
+
+_find_nvmedev_by_subsysnqn() {
+	local snqn="$1"
+	local nvmedev=""
+
+	for d in /sys/class/nvme/nvme?; do
+		nqn=$(cat $d/subsysnqn);
+		if [[ "$nqn" == "$snqn" ]]; then
+			nvmedev="$(basename $d)"
+			break
+		fi
+	done
+
+	echo "$nvmedev"
+}
+
+_nvme_fcloop_add_rport() {
+	local rport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${rport} > ${loopctl}/add_remote_port
+}
+
+_nvme_fcloop_del_rport() {
+	local rport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${rport} > ${loopctl}/del_remote_port
+}
+
+_nvme_fcloop_add_lport() {
+	local lport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${lport} > ${loopctl}/add_local_port
+}
+
+_nvme_fcloop_del_lport() {
+	local lport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${lport} > ${loopctl}/del_local_port
+}
+
+_nvme_fcloop_add_tport() {
+	local tport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${tport} > ${loopctl}/add_target_port
+}
+
+_nvme_fcloop_del_tport() {
+	local tport="$1"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo ${tport} > ${loopctl}/del_target_port
+}
diff --git a/tests/nvme/006 b/tests/nvme/006
new file mode 100755
index 000000000000..24aa9d03871e
--- /dev/null
+++ b/tests/nvme/006
@@ -0,0 +1,121 @@
+#!/bin/bash
+#
+# Reproducer for nvme-fcloop crash
+#
+# Copyright (C) 2018 Johannes Thumshirn
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+DESCRIPTION="create nvme-fcloop with two ports and connect/disconnect"
+
+requires() {
+	_have_module nvme-fcloop && _have_module nvmet && _have_module loop && \
+		_have_configfs && _have_module nvme-core && \
+		_have_module nvmet-fc
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local tport1="wwnn=0x200140111111dbcc,wwpn=0x100140111111dbcc,roles=0x60"
+	local tport2="wwnn=0x200140111111dbcd,wwpn=0x100140111111dbcd,roles=0x60"
+	local lport1="wwnn=0x200140111111dac8,wwpn=0x100140111111dac8,roles=0x10"
+	local lport2="wwnn=0x200140111111dac9,wwpn=0x100140111111dac9,roles=0x10"
+	local rport1="wwnn=0x200140111111dbcc,wwpn=0x100140111111dbcc,lpwwnn=0x200140111111dac8,lpwwpn=0x100140111111dac8,roles=0x60"
+	local rport2="wwnn=0x200140111111dbcd,wwpn=0x100140111111dbcd,lpwwnn=0x200140111111dac9,lpwwpn=0x100140111111dac9,roles=0x60"
+
+	# Clean up all stale modules
+	modprobe -r nvme-fcloop
+	modprobe -r nvmet-fc
+	modprobe -r nvme-core
+	modprobe -r nvmet
+
+	modprobe nvme-core multipath=1
+	modprobe nvmet
+	modprobe nvmet-fc
+	modprobe nvme-fcloop
+
+
+	_nvme_fcloop_add_tport ${tport1}
+	_nvme_fcloop_add_tport ${tport2}
+
+	_nvme_fcloop_add_lport ${lport1}
+	_nvme_fcloop_add_lport ${lport2}
+
+	_nvme_fcloop_add_rport ${rport1}
+	_nvme_fcloop_add_rport ${rport2}
+
+	local port1
+	port1=$(_create_nvmet_port "fc")
+
+	local port2
+	port2=$(_create_nvmet_port "fc")
+
+	echo fc > /sys/kernel/config/nvmet/ports/${port1}/addr_adrfam
+	printf "%s" "nn-0x200140111111dbcc:pn-0x100140111111dbcc" > /sys/kernel/config/nvmet/ports/${port1}/addr_traddr
+
+	echo fc > /sys/kernel/config/nvmet/ports/${port2}/addr_adrfam
+	printf "%s" "nn-0x200140111111dbcd:pn-0x100140111111dbcd" > /sys/kernel/config/nvmet/ports/${port2}/addr_traddr
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	_add_nvmet_subsys_to_port "${port1}" "blktests-subsystem-1"
+	_add_nvmet_subsys_to_port "${port2}" "blktests-subsystem-1"
+
+	nvme connect -t fc -a "nn-0x200140111111dbcc:pn-0x100140111111dbcc" -w "nn-0x200140111111dac8:pn-0x100140111111dac8" -n blktests-subsystem-1
+	nvme connect -t fc -a "nn-0x200140111111dbcd:pn-0x100140111111dbcd" -w "nn-0x200140111111dac9:pn-0x100140111111dac9" -n blktests-subsystem-1
+
+	local nvmedev=""
+	nvmedev="$(_find_nvmedev_by_subsysnqn blktests-subsystem-1)"
+
+	nvme disconnect -d "${nvmedev}"
+	sleep 10 # wait till all disconnects are done on the target side
+
+	for port in ${port1} ${port2}; do
+		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
+		_remove_nvmet_port "${port}"
+	done
+
+	_remove_nvmet_subsystem "blktests-subsystem-1"
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
+
+	_nvme_fcloop_del_tport "wwnn=0x200140111111dbcc,wwpn=0x100140111111dbcc"
+	_nvme_fcloop_del_tport "wwnn=0x200140111111dbcd,wwpn=0x100140111111dbcd"
+
+	_nvme_fcloop_del_lport "wwnn=0x200140111111dac8,wwpn=0x100140111111dac8"
+	_nvme_fcloop_del_lport "wwnn=0x200140111111dac9,wwpn=0x100140111111dac9"
+
+	_nvme_fcloop_del_rport "wwnn=0x200140111111dbcc,wwpn=0x100140111111dbcc"
+	_nvme_fcloop_del_rport "wwnn=0x200140111111dbcd,wwpn=0x100140111111dbcd"
+
+
+	modprobe -r nvme-fcloop
+	modprobe -r nvmet-fc
+	modprobe -r nvme-core
+	modprobe -r nvmet
+	modprobe -r loop
+
+	# In case we can trigger the bug, it happens ~10-20 sec after the module
+	# unloads in my setup
+
+	sleep 20
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/006.out b/tests/nvme/006.out
new file mode 100644
index 000000000000..b66cd5a5950a
--- /dev/null
+++ b/tests/nvme/006.out
@@ -0,0 +1,2 @@
+Running nvme/006
+Test complete
-- 
2.12.3



-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
