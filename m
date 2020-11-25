Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2244C56201
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0646820857
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXWvLbwv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7r9g41q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0646820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YRUhve/76vsHltUu2G6gJfhjYt2X7g0N/Fe5Y+wOlQg=; b=FXWvLbwv3QwEwPcBvux5Q4Nyu
	IgzcR8t36G0bo31qXd9SRYGMo4W0jVMqDj37kykXQQsGFsyfKYjK2JXc2hiAmoXNv0CyIynU+Hn+N
	xDMw6ogtPc/gswR6VAzN7JrBeuMtFA0YTY4U58jDRxltymhEsodxaZf9EJoc4bfoRoFXTpQH0Hog3
	mlfsp8QLCiz4ySBSDBTdFP8le3YnkTvqiRssbYFn6gdFPB/AZnhNqFCgUnE+w3aNqhyf5sCucgGXl
	p+2bJ4oCsa0pINSVwEmMSIKf6ia5iT9zylJRm6nYYAaUzkWrKMrfaGw/sJtSDu+fF14M1RiENZ4j6
	Idc4H2Z2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpID-0008Ci-0b; Wed, 25 Nov 2020 07:32:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpIA-0008Be-0L
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=renZVtfhEUS0Yt3aLsnjSOzfTPu2i8bPTg+ghTRf1mU=;
 b=Z7r9g41qwa2KJyIs52/wRWJ+DklOtRNUcq0M/LTp5Keg9t30zvPLPZH1XeFqOYb6Xe6B0C
 xb5ZkZHjImatg23ngjrCFYy1PLCvpTMvL9yOx7XTZzBttQFKaXNpeWVzhfRrbmprXCX1uC
 JVYKI2DVC5N2V6anepWF5FupGkesLfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-bDU1xAopOTqkQgZX7l8Ckw-1; Wed, 25 Nov 2020 02:32:37 -0500
X-MC-Unique: bDU1xAopOTqkQgZX7l8Ckw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6667A18C89EB;
 Wed, 25 Nov 2020 07:32:36 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F53919C46;
 Wed, 25 Nov 2020 07:32:34 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V2 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler list
Date: Wed, 25 Nov 2020 15:32:03 +0800
Message-Id: <20201125073205.8788-4-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023242_119673_ADFC693F 
X-CRM114-Status: GOOD (  13.36  )
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
 common/multipath-over-rdma | 12 ++++++++++++
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/srp/012              | 10 ++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ebc5939..1bbefb7 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -326,6 +326,18 @@ set_scheduler() {
 	fi
 }
 
+# Get block dev scheduler list
+get_scheduler_list() {
+	local b=$1 p
+	p=/sys/block/"$b"/queue/scheduler
+	if [ -e "$p" ]; then
+		scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
+		echo "$scheds"
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
