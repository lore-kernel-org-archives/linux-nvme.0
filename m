Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF0C5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCAD20872
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MqjTb9yK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTWSuGDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCAD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mc50rl8K+qyRLtU00KQoXBFi0l+5pyRxhYgotPsIpIs=; b=MqjTb9yKwg/1+246Hct0pbJ4+
	MO1yxwV+KrQsWZ5VqWuls3/svcqN9SFBNvKuff+q/JD0yIWseJkEHDaX8NqxFnYYgShr5AuDjU7vy
	ICNXdjLhh17Tx2XMRP2QlbzZlEWr4Ibd5faa3dbfuRFlP9NIzBzRKQT5Fu/RiKF/9xIvgxQag/YXx
	JKL0Zul6C0KqpjjRKMlahnlEPKMiw7xdWRhvgqgJ35ALcHlTZLUQ4y/qsY4NdWTVx0SI7cm40Dqom
	Zmw1Rb9eZ+6Fmx4khEabYa2cTelSuoD/aYEHsxBbxLqkGJrq8kMtfD8UvQWrUj33sFe3LQEes28+r
	yKtSQKDNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpI4-0008AH-Il; Wed, 25 Nov 2020 07:32:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpI2-00089p-I4
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:32:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+CRVUJRr10yjo78bfkJPa3QfjhrcfCQgimLtvVFbMo=;
 b=GTWSuGDMhZ6dw9IUWtYiZ5GjL49O5F1smUlIcFasvWNJUcbzQVMQpyijnuNn2aAKWDka1p
 pfuh+X6mmU1wFYy/99yPLIlmNFtl34GNJfHRxJBa0FexmVFWwkVnlyvRVe7dpvfGC8SA9e
 UUZujP+QMEoDs1v5eVeb7rOI77J9Aog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-HeAkB7VMP4y6jmHo9LMd0Q-1; Wed, 25 Nov 2020 02:32:31 -0500
X-MC-Unique: HeAkB7VMP4y6jmHo9LMd0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4524107B45A;
 Wed, 25 Nov 2020 07:32:30 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6A2C19C46;
 Wed, 25 Nov 2020 07:32:28 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V2 blktests 1/5] tests/srp/rc: update the ib_srpt module name
Date: Wed, 25 Nov 2020 15:32:01 +0800
Message-Id: <20201125073205.8788-2-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023234_666944_79B784C9 
X-CRM114-Status: GOOD (  13.71  )
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

Fix the ib_srpt module insmod failure as the module in some distros are
end with .xz, like bellow on fedora:
/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko.xz

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/srp/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 7fc094b..1f665a2 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -465,7 +465,7 @@ configure_target_ports() {
 
 # Load LIO and configure the SRP target driver and LUNs.
 start_lio_srpt() {
-	local b d gid i ini_ids=() opts p target_ids=() vdev
+	local b d gid i ini_ids=() opts p target_ids=()
 
 	for gid in $(all_primary_gids); do
 		if [ "${gid#fe8}" != "$gid" ]; then
@@ -500,7 +500,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
+	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
 		if [ -b "$(readlink -f "$r")" ]; then
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
