Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B0ED6E2A2
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 03:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2izUDURaRNSUCsPxbB5/AV6z/0BbH/iA3UrWDhYORS4=; b=D1QHznLRt2kJhzBFncig4/64GX
	BgcNZCnA+i7somAUWv2C4urKz/BNORtPu1th8SY/1FhBRFoZZeazcNLEw8Ea87Jg1WgEK3cuYROzs
	SbJMMXTswZ/JyErDdWixlkUxiNJmj5N17wVueGU002wKsrDzk+YtiiM5u6bxSKkeETd+A1S3leS6E
	QeUFJvLsaDvECIQBEJuM0+8FdZNioy9OM8XDpN9+w6QSxpp/p3MulBEt6o3agx47oUmhLGFSufA0H
	NW26mgir5Gft6P/rzT37+6oSRnQdn3sWXUDFzzDQ3FUM2sJsLDcy8TWOJ9Nm5uHn0eVBf7KTn7tyd
	WiH3pidw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDb4m-0000000EGN7-09El;
	Wed, 20 Nov 2024 03:08:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDb4i-0000000EGMd-46Do
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 03:08:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732072094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2izUDURaRNSUCsPxbB5/AV6z/0BbH/iA3UrWDhYORS4=;
	b=emMcM/kyae/tJrFU0AEKpaEgH3YqCB6bbi0FDif0U7MSZxfCmb+6M2QG3J9izy7hb6zPJg
	rUaiybRXtA6dfMF7Hr7rWvUMgadKWR0guj0L3uuaaDAiK7Dy4TnUpwBSqoAGya7Is+r4a3
	VO49LBVsiPPfAtp3KzRjMVBIvDQsOeg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-ns8c121-OLKO-eGKC5Zeyg-1; Tue,
 19 Nov 2024 22:02:20 -0500
X-MC-Unique: ns8c121-OLKO-eGKC5Zeyg-1
X-Mimecast-MFC-AGG-ID: ns8c121-OLKO-eGKC5Zeyg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 849BE1954B1A;
	Wed, 20 Nov 2024 03:02:14 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A87D19560A3;
	Wed, 20 Nov 2024 03:02:13 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: hare@suse.de,
	shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvme/052: don't remove the def_nsid namespace during the test
Date: Tue, 19 Nov 2024 21:49:25 -0500
Message-ID: <20241120024925.1397864-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_190817_144174_C9F61126 
X-CRM114-Status: GOOD (  10.02  )
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

Skip def_nsid(1) namespace removal during the test as it will be removed
from _remove_nvmet_ns during _nvmet_target_cleanup phase

$ ./check nvme/052
nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
    runtime  3.273s  ...  3.299s
    --- tests/nvme/052.out	2024-11-19 19:29:36.873210200 -0500
    +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-11-19 21:29:26.016088521 -0500
    @@ -1,2 +1,4 @@
     Running nvme/052
    +common/nvme: line 635: /sys/kernel/config/nvmet//subsystems/blktests-subsystem-1/namespaces/1/enable: No such file or directory
    +rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1/namespaces/1': No such file or directory
     Test complete

Fixes: 67e25d7 ("nvme/052: do not create namespace when setting up the target")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/052 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/052 b/tests/nvme/052
index 8443c90..2ff9e53 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -71,6 +71,8 @@ test() {
 			break
 		fi
 
+		[ ${nsid} -eq 1 ] && continue
+
 		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 
 		# wait until async request is processed and ns is removed
-- 
2.45.1


