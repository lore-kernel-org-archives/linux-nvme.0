Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFC8C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5048F20DD4
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJX0WMa3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeQan2Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048F20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=quKFnR0NTOAYYb1aeun8fD9LgU8gqicx5RX2APTuvRs=; b=XJX0WMa36SzfBNFLeGNNylkYj
	1pW2GwFieoo2LNmoKc85v/QKURAY05lKhmd9Xx4pY8kvviU28kNJShHEfRVe5lC+2UjLhL8XhphLV
	94+qeIA1tK/AcLdYx5c9F7gXU7aSsDh262yWWGrgTKOigLDmaa/fUx+gpzWjmWXkBUTzK5EOd1QbP
	sRIq0fs3BqsmAFajtXJjg8KIn0wZ3GPHKd2gwoBAhUulO9LN2VTtstMog/C+GZ/bzwbg3agbUd+P9
	J6PjVqksxC8pOLu/mlX3cmqRZtb5cgtTcGxWR7u6IF7KaN02RB3I5N7BDwP02ytWT5LH9cx2ve37s
	o+vTfDrNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiClF-00019z-HQ; Thu, 26 Nov 2020 08:36:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiClA-000189-3e
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:36:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606379771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVrLd3u++NGxsba5ZF6vCk00fz0YWU/gqYiw53/j61A=;
 b=XeQan2Vjktw9Xek+ZnS/unqSFGPK4OgkYAlVzdUqT0t7uqVEaz9jskrnkYHQYxdq4V325i
 j919E1qhATr8BRJZplXAHYHhbxUg0jzB6jw4nLS3Qfb38+KgJ7+2928L4eBRwRpagUIRqE
 LwzHr4K/mgwmHtuOLTw7kdRAezQieRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-nbB4CddkNWW-62uA4Ihwlg-1; Thu, 26 Nov 2020 03:36:05 -0500
X-MC-Unique: nbB4CddkNWW-62uA4Ihwlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F239D1012E85;
 Thu, 26 Nov 2020 08:36:03 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27D1819C66;
 Thu, 26 Nov 2020 08:36:01 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V3 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler list
Date: Thu, 26 Nov 2020 16:35:30 +0800
Message-Id: <20201126083532.27509-4-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_033612_285033_0ADF3EE3 
X-CRM114-Status: GOOD (  13.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is no cfq scheduler and new added kyber scheduler in lastest kernel,
introduce get_scheduler_list and fix nvmeof-mp/012 srp/012

To reproduce it:
$ ./check nvmeof-mp/012
nvmeof-mp/012 (dm-mpath on top of multiple I/O schedulers)   [passed]
    runtime  5.922s  ...  8.804s

$ cat results/nodev/nvmeof-mp/012.full  | grep -n "Changing scheduler"
31:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed
47:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 11 +++++++++++
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/srp/012              | 10 ++++++----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ebc5939..ba6fa0d 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -326,6 +326,17 @@ set_scheduler() {
 	fi
 }
 
+# Get block dev scheduler list
+get_scheduler_list() {
+	local b=$1 p
+	p=/sys/block/"$b"/queue/scheduler
+	if [ -e "$p" ]; then
+		sed 's/[][]//g' /sys/block/"$b"/queue/scheduler
+	else
+		return 1
+	fi
+}
+
 # Get a /dev/... path that points at dm device number $1. Set its I/O scheduler
 # to $2 and its timeout to $3. The shell script that includes this file must
 # define a function get_bdev_path() that translates device number $1 into a
diff --git a/tests/nvmeof-mp/012 b/tests/nvmeof-mp/012
index ae6a92c..8b2e918 100755
--- a/tests/nvmeof-mp/012
+++ b/tests/nvmeof-mp/012
@@ -8,7 +8,7 @@ DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
 
 test_io_schedulers() {
-	local dev m
+	local dev m dm scheds
 
 	# Load all I/O scheduler kernel modules
 	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
@@ -17,15 +17,17 @@ test_io_schedulers() {
 	for mq in y n; do
 		use_blk_mq ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
-		for sched in noop deadline bfq cfq; do
-			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
+		dm=$(basename "$(readlink -f "${dev}")") || return $?
+		scheds="$(get_scheduler_list "$dm")" || return $?
+		for sched in $scheds; do
+			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
 			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
 			run_fio --verify=md5 --rw=randwrite --bs=4K --size=64K \
 				--ioengine=libaio --iodepth=64 \
 				--iodepth_batch=32 --group_reporting --sync=1 \
 				--direct=1 --filename="$dev" \
-				--name=${sched} --thread --numjobs=1 \
+				--name="${sched}" --thread --numjobs=1 \
 				--output="${RESULTS_DIR}/nvmeof-mp/012-${sched}-${mq}.txt" \
 				>>"$FULL" ||
 				return $?
diff --git a/tests/srp/012 b/tests/srp/012
index 20c6daf..ffd56ef 100755
--- a/tests/srp/012
+++ b/tests/srp/012
@@ -8,7 +8,7 @@ DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
 
 test_io_schedulers() {
-	local dev m
+	local dev m dm scheds
 
 	# Load all I/O scheduler kernel modules
 	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
@@ -18,15 +18,17 @@ test_io_schedulers() {
 		[ $mq = n ] && ! _have_legacy_dm && continue
 		use_blk_mq ${mq} ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
-		for sched in noop deadline bfq cfq; do
-			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
+		dm=$(basename "$(readlink -f "${dev}")") || return $?
+		scheds="$(get_scheduler_list "$dm")" || return $?
+		for sched in $scheds; do
+			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
 			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
 			run_fio --verify=md5 --rw=randwrite --bs=4K --size=64K \
 				--ioengine=libaio --iodepth=64 \
 				--iodepth_batch=32 --group_reporting --sync=1 \
 				--direct=1 --filename="$dev" \
-				--name=${sched} --thread --numjobs=1 \
+				--name="${sched}" --thread --numjobs=1 \
 				--output="${RESULTS_DIR}/srp/012-${sched}-${mq}.txt" \
 				>>"$FULL" ||
 				return $?
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
