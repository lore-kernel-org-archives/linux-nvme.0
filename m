Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE24ECA0FE1
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b14KFAbUfxLuh3G+xzSz+u/cs7GkD+hIhchjM1kL8UM=; b=fTBZPASlo3CnMy9XEcjUYQjArN
	F1aljkBfEUkhYWy/p8i29AAniRzVTy6dP+GtZWq5o61wWy2Lhtm28XQbIJJL6hpH+e9edsMOVr9gC
	pAg1lnJNqD4Vaf+HrPSYoxDxY/o6KYoNodu8qyFTuZtjNBto1PacpoXiHU7AIbh2yTpGDH8DPOH36
	pN3N0IdFVM2MVYawDirhvH6dJ5zVy0O5gBqXqRrnEy1ZswB3SZ6DTTI2sjuOryodnCE6s3+3pjFmL
	lBjboaQ+gss/MvwBgnjFKmJQvBXUdbsBqfS3cihGYXRBaf56lCNvAcn39TkXMa2IkWpT+WiDNgcYN
	P944NeLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphu2-00000004AIx-1u5N;
	Sat, 23 Aug 2025 06:39:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTrz-0000000354F-07sk
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Aug 2025 15:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=b14KFAbUfxLuh3G+xzSz+u/cs7GkD+hIhchjM1kL8UM=; b=muKP9ckE7clmQBquRNmWgAFKFc
	01ezSXJi8KH4wugqCAda0dMe4F11QN5E3w4h0p61U8twMYG8EdvkeaUTOrLcaHDlhohtaiGo8flej
	KukJ0miifnjSWM0OblCF5gtBeJCqotj9++KfyjReaBw3VBMzBk0iCk3NC+WEUzi/aUOyg8pxD5OB8
	Pq3odEbPt2tT1Hd50Fj4B7Xb4xPjSF6QQQg5kEWhVONz8Gre1U8mbrGHPOLGGCy00m1iSOX1bnj05
	YoNeiCNTaDpT4SryJdufT413oW/aeNuY6KalQw2MYLCq6vKLRvF3ZjpKUlJcEVlIMgesXgp6ax6Kv
	Mk00pang==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTrv-00000000zOY-3lSk
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 15:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b14KFAbUfxLuh3G+xzSz+u/cs7GkD+hIhchjM1kL8UM=;
	b=PJLBj+DqvvCyMhnYsOWblue45aWK34rN4aFGYy0riPMxu5amOEqGofg3OBBYohBJdzbX4T
	RlOBR2pM00QS4r1/reFuABihybMy0I0LLFpAHJmf65IcmPAhW9AyzpHY/PAbsJ6/9bqN56
	8hGyTOdgj/XrpIHOWIjPrEWSM4nrHsk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b14KFAbUfxLuh3G+xzSz+u/cs7GkD+hIhchjM1kL8UM=;
	b=VsQN4u7/MC4IfCmicTeI5yKZMARIicoDdsGY+Z6GKPdjgDAbIDMJoDVSJoZQGst0C6O/Ql
	rCY1lmDE1IgqgatXf7lXQAHYtnf4Cw/hUH06HTBXiY7gE3tmELmzjEE5mu5FSu4bVwr3+i
	LCM78RF63IieWnIW3g/T+ntiXUZT6TY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-KVQcaxuFPFm5w0GE6oZOEw-1; Fri,
 22 Aug 2025 11:39:46 -0400
X-MC-Unique: KVQcaxuFPFm5w0GE6oZOEw-1
X-Mimecast-MFC-AGG-ID: KVQcaxuFPFm5w0GE6oZOEw_1755877184
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1140819560A2;
	Fri, 22 Aug 2025 15:39:44 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5ECF830001A1;
	Fri, 22 Aug 2025 15:39:43 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com,
	chaitanyak@nvidia.com,
	dwagner@suse.de
Subject: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to _nvme_connect_subsys()
Date: Fri, 22 Aug 2025 11:10:52 -0400
Message-ID: <20250822151053.3248822-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efVhliBEL-R7dA-w9JE-WOTknwwF_HMhJjcVGZNfBL8_1755877184
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_163956_093131_79CE3BCB 
X-CRM114-Status: GOOD (  14.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The default behavior of _nvme_connect_subsys is just wait for the
controller ready, but sometimes the namespace was not ready after
_nvme_connect_subsys especially on RT kernel, it's better we can
have namespace ready in _nvme_connect_subsys, so
1) re-use the the function _nvme_ns_ready to check namespace ready
2) add one new argument `--no-wait-ns` to skip for the cases that
don't need wait for namespace ready
3) update to use "return 1" for controller failure check and "return 2"
for namespace failure check

After this change, it will avoids the failures like below which easy to
be reproduced on rt kernel:

nvme/010 (tr=3Dloop bd=3Dfile) (run data verification fio job)   [failed]
    runtime  21.644s  ...  9.787s
    --- tests/nvme/010.out        2025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/010.out.bad      =
  2025-07-30 03:01:35.276827933 +0000
    @@ -1,3 +1,7 @@
     Running nvme/010
    +fio: pid=3D0, err=3D21/file:filesetup.c:150, func=3Dunlink, error=3DIs=
 a directory
    +fio exited with status 1
    +fio: pid=3D0, err=3D21/file:filesetup.c:150, func=3Dunlink, error=3DIs=
 a directory
    +4;fio-3.35;verify;0;21;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000000;0.00=
0000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.000000%=
=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.000000%=
=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.900000%=
=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0.0000=
00;0;0;0.000000%;0.000000;0.000000;0;0;0;0;0;0;0.000000;0.000000;0;0;0.0000=
00;0.000000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.00=
0000%=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.00=
0000%=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.90=
0000%=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0=
.000000;0;0;0.000000%;0.000000;0.000000;0;0;0;0;0;0;0.000000;0.000000;0;0;0=
.000000;0.000000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;=
30.000000%=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;=
80.000000%=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;=
99.900000%=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000=
000;0.000000;0;0;0.000000%;0.000000;0.000000;0.000000%;0.000000%;0;0;0;0.0%=
;0.0%;0.0%;0.0%;0.0%;0.0%;0.0%;nan%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.0=
0%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;=
0.00%;0.00%
     disconnected 1 controller(s)
     Test complete
nvme/012 (tr=3Dloop bd=3Dfile) (run mkfs and data verification fio) [failed=
]
    runtime  21.731s  ...  9.372s
    --- tests/nvme/012.out        2025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/012.out.bad      =
  2025-07-30 03:02:01.436992167 +0000
    @@ -1,3 +1,4 @@
     Running nvme/012
    +FAIL: fio verify failed
     disconnected 1 controller(s)
     Test complete
nvme/019 (tr=3Dloop bd=3Dfile) (test NVMe DSM Discard command)   [failed]
    runtime  9.477s  ...  8.982s
    --- tests/nvme/019.out        2025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/019.out.bad      =
  2025-07-30 03:02:57.567344555 +0000
    @@ -1,4 +1,32 @@
     Running nvme/019
    -NVMe DSM: success
    +/dev is not a block or character device
    +Usage: nvme dsm <device> [OPTIONS]
    +
    +The Dataset Management command is used by the host to
    +indicate attributes for ranges of logical blocks. This includes
    ...
    (Run 'diff -u tests/nvme/019.out /root/blktests/results/nodev_tr_loop_b=
d_file/nvme/019.out.bad' to see the entire diff)
nvme/021 (tr=3Dloop bd=3Dfile) (test NVMe list command)          [failed]
    runtime  9.188s  ...  8.884s
    --- tests/nvme/021.out=092025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/021.out.bad=09202=
5-07-31 09:04:48.415419449 +0000
    @@ -1,2 +1,3 @@
     Running nvme/021
    +ERROR: device not listed
     Test complete
nvme/023 (tr=3Dloop bd=3Dfile) (test NVMe smart-log command)     [failed]
    runtime  9.070s  ...  8.991s
    --- tests/nvme/023.out        2025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/023.out.bad      =
  2025-07-30 03:03:39.747609389 +0000
    @@ -1,2 +1,3 @@
     Running nvme/023
    +ERROR: smart-log bdev-ns failed
     Test complete
nvme/026 (tr=3Dloop bd=3Dfile) (test NVMe ns-descs)              [failed]
    runtime  9.573s  ...  9.020s
    --- tests/nvme/026.out        2025-07-26 14:42:07.918582261 +0000
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/026.out.bad      =
  2025-07-30 03:04:00.117737295 +0000
    @@ -1,2 +1,3 @@
     Running nvme/026
    +ERROR: ns-desc failed
     Test complete
nvme/047 (tr=3Dtcp) (test different queue types for fabric transponvme/047 =
(tr=3Dtcp) (test different queue types for fabric transports) [failed]3.669=
s  ...
   runtime  3.669s  ...  2.890s
   --- tests/nvme/047.out      2025-07-26 14:42:07.918582261 +0000
   +++ /root/blktests/results/nodev_tr_tcp/nvme/047.out.bad   2025-07-31 13=
:24:14.993729267 +0000
  @@ -1,2 +1,3 @@
   Running nvme/047
   +common/fio: line 197: Error: '/dev/nvme0n1' does not exist or is not ac=
cessible: syntax error in expression (error token is ": '/dev/nvme0n1' does=
 not exist or is not accessible")
   Test complete

Link: https://github.com/linux-blktests/blktests/issues/193
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/nvme | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/common/nvme b/common/nvme
index 791868c..8de41fa 100644
--- a/common/nvme
+++ b/common/nvme
@@ -284,6 +284,7 @@ _nvme_connect_subsys() {
 =09local reconnect_delay=3D""
 =09local ctrl_loss_tmo=3D""
 =09local no_wait=3Dfalse
+=09local no_wait_ns=3Dfalse
 =09local hdr_digest=3Dfalse
 =09local data_digest=3Dfalse
 =09local tls=3Dfalse
@@ -291,6 +292,7 @@ _nvme_connect_subsys() {
 =09local port
 =09local i
 =09local -a ARGS
+=09local ret=3D0
=20
 =09while [[ $# -gt 0 ]]; do
 =09=09case $1 in
@@ -346,6 +348,10 @@ _nvme_connect_subsys() {
 =09=09=09=09no_wait=3Dtrue
 =09=09=09=09shift 1
 =09=09=09=09;;
+=09=09=09--no-wait-ns)
+=09=09=09=09no_wait_ns=3Dtrue
+=09=09=09=09shift 1
+=09=09=09=09;;
 =09=09=09--hdr-digest)
 =09=09=09=09hdr_digest=3Dtrue
 =09=09=09=09shift 1
@@ -432,14 +438,23 @@ _nvme_connect_subsys() {
 =09if [[ ${no_wait} =3D false ]]; then
 =09=09local ctrldev
=20
-=09=09ctrldev=3D$(echo "${connect}"  | sed -n 's/.*device.:.\(nvme[0-9]*\)=
./\1/p')
+=09=09ctrldev=3D$(echo "${connect}" | sed -n 's/.*device.:.\(nvme[0-9]*\).=
/\1/p')
 =09=09udevadm settle
 =09=09for ((i =3D 0; i < 10; i++)); do
-=09=09=09_nvme_ctrl_ready "${ctrldev}" "${subsysnqn}" && return 0
+=09=09=09_nvme_ctrl_ready "${ctrldev}" "${subsysnqn}" && break
 =09=09=09sleep .1
 =09=09done
-=09=09return 1
+=09=09[ $i -eq 10 ] && ret=3D1
+=09=09if [[ ${no_wait_ns} =3D false ]]; then
+=09=09=09for ((i =3D 0; i < 10; i++)); do
+=09=09=09=09_nvme_ns_ready "${subsysnqn}" && break
+=09=09=09=09sleep .1
+=09=09=09done
+=09=09=09[ $i -eq 10 ] && ret=3D2
+=09=09fi
+
 =09fi
+=09return "$ret"
 }
=20
 _nvme_disconnect_subsys() {
@@ -462,7 +477,6 @@ _nvme_disconnect_subsys() {
 =09=09grep -o "disconnected.*"
 }
=20
-
 _nvme_ctrl_ready() {
 =09local ctrldev=3D"${1}"
 =09local subsysnqn=3D"${2:-$def_subsysnqn}"
@@ -476,6 +490,23 @@ _nvme_ctrl_ready() {
 =09return 1
 }
=20
+_nvme_ns_ready() {
+=09local subsysnqn=3D"${1}"
+=09local ns_path ns_id dev
+=09local cfs_path=3D"${NVMET_CFS}/subsystems/$subsysnqn"
+
+=09dev=3D$(_find_nvme_dev "$subsysnqn")
+=09for ns_path in "${cfs_path}/namespaces/"*; do
+=09=09ns_id=3D${ns_path##*/}
+=09=09if [[ ! -b /dev/${dev}n${ns_id} ||
+=09=09=09! -e /sys/block/${dev}n${ns_id}/uuid ||
+=09=09=09! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
+=09=09=09return 1
+=09=09fi
+=09done
+=09return 0
+}
+
 _remote_wwnn() {
 =09local -i port=3D${1}
=20
--=20
2.45.1


