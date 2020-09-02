Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E783C433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:28:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D881A2072A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mushrYuK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmzBIV4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D881A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Po948F6gP++GPJQ/NFZsp7vQSEsN6ZqBloZCSJgVh6w=; b=mushrYuKxrPMJ8jTiGgkqL5AfU
	wzz3VeLTmxQ9BEPK2PsGmJ+YqFX7FPOUVmZgXPikZkPtqscmF6zEZju32wBzlCE2f4H5nQPAFfY8Y
	mFfzH3BHVlH0/xJu/4cdFJhEFCq70jQGG8X3XzOto+bQVPvpa869ltkNnecjWpzD0vrReF1rDmCkR
	55AQd/wwwpQXKLkXK4rvsY75onjJ+a9YIl/f+HRpJIR6qTL28Cl6fgB+Nnd3J9EyGNTI5HAn4yaot
	tYsPivklTOV5oS+DUUik8DTANLl08YKqarZ1t0PhtipqSdNShUH2L3CIMwZffgfDw6qqNzmm0u0Wb
	qfRL7Y9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDNC0-000382-MM; Wed, 02 Sep 2020 07:28:28 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDNBy-00037E-Vk
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 07:28:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599031706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=my/0/60EKzMd85e5xSLIjetq7nWAOV8+6qBH9JYWi7Q=;
 b=cmzBIV4prBCxB/K7uvoRHo1O0GxBN6t1hN9oIf+qsdPVAEeVO2MAtRHOzmxI8Scd7PFSB2
 TGT4cqVaiCRuQ1DtMCKO5gFym6Bl0UkaHVC3T3yzl1Vzj5zxiHIDi6XAoPqU4oOyX7oYvA
 CbeOJGDmi+yoEEdw25ckcg9i5/MwtHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-sSv_-87eODSzmHOwURIeLg-1; Wed, 02 Sep 2020 03:28:24 -0400
X-MC-Unique: sSv_-87eODSzmHOwURIeLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655F9801FDF;
 Wed,  2 Sep 2020 07:28:23 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com
 [10.66.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14F8A5C1BB;
 Wed,  2 Sep 2020 07:28:21 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	jthumshirn@suse.de
Subject: [PATCH blktests] nvme/005: add the missing _have_program nvme
Date: Wed,  2 Sep 2020 15:27:57 +0800
Message-Id: <20200902072757.32187-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_032827_052487_578B298F 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/005 | 2 +-
 tests/nvme/030 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/005 b/tests/nvme/005
index 8c79d23..325f2b6 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -13,7 +13,7 @@ QUICK=1
 requires() {
 	_have_modules loop nvme-core nvme-loop nvmet && \
 		_have_module_param_value nvme_core multipath Y && \
-		_have_configfs
+		_have_configfs && _have_program nvme
 }
 
 test() {
diff --git a/tests/nvme/030 b/tests/nvme/030
index 94020f4..fa68ff1 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -36,7 +36,7 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-    _setup_nvmet
+	_setup_nvmet
 
 	port="$(_create_nvmet_port "loop")"
 
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
