Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8451CC63777
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED89120B80
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QP8T97o0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ0gNTJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kuMYAms9bx/8vnxTkyW8Iw1anJtpN++PRF2pcVSkryM=; b=QP8T97o0Fzi1P6syJTjXJmeUN
	RSwMdC0wutkGtvqOEUbb+VgPLctkpMk7vW0Ad5+/C6bq3hmv7ROeYrJrufl1dUd/ekyB+17w1HYD3
	z3mYMY1yAKKJ1EUJChsoxE8cAyHnG+4G+JMzenwOsjyLQHZAd7LMoKSBz5WUQfe61O1e9T3mI4Zc5
	mDK186sUEeA0hRxJI5yvdAgGzQ4tJt+CKXpYsWRPOIBgUHSVaI8bRkV6Oe9jKTueIVbSI3lflgu4C
	ygREDO6E/YkCJ0mlfmFruoJGEOTsw2fZcKVvjBCOTZAobVjiIpBWX2egdwUhUtwXMk1reLS3NhTwz
	EaoFZ3+Iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiCl7-00017T-Kx; Thu, 26 Nov 2020 08:36:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiCl3-00016C-6R
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606379764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpEC5D0qOw9//L2As7ovMFYeDVD089fvAUww7rjLk5w=;
 b=jJ0gNTJc8TQ4pcQv2sOAM5MgZt/EngI33MG0cFPftRv6K/jd6uja3qYXY6oQuKT1EW85iq
 dRHHiH7SaBQHGAmME15zBkmyRHVojXI7IbmQO1HLZs6kwGMzmVXS+gNw6BbR4Nu2nLRIQb
 5Ddi2tUNn1D1nJJq0UC+odcUw8T4SZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-sLMyRioIMuCzZi04AmfOBw-1; Thu, 26 Nov 2020 03:36:00 -0500
X-MC-Unique: sLMyRioIMuCzZi04AmfOBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740041012E85;
 Thu, 26 Nov 2020 08:35:59 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76BC719C66;
 Thu, 26 Nov 2020 08:35:57 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V3 blktests 1/5] tests/srp/rc: update the ib_srpt module name
Date: Thu, 26 Nov 2020 16:35:28 +0800
Message-Id: <20201126083532.27509-2-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_033605_318450_FEFA0549 
X-CRM114-Status: GOOD (  14.06  )
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
