Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E4FEE14D4
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wpk/JLwGOs1eIjILox3z19SNd6kr3FuL2TFM0S4zDCQ=; b=SLKbYk1CQxAzn4gBSgrqW4yct6
	S3aFQP127gaKk+VmNLnQrxKC0MwkFnfqE8AGYWJ0gJYpMAZApeW0mJsRWVrp9MLTOI/aIN0NsiXeM
	Nfmiz3Zv13ngSUfldq/rv9rx7mTMrB04Nyc/nUBOzU/WUFlSvDFhSmF1UG+TKnmP7pqI+5srQ3Et2
	wqmwiG52oqlFtGO7v17sTvnrChaTq7vlolFQ0+XeYJWpw/CvsOlD7YoCMDTBEy4LH4yoLy742dW02
	nxKe+UNqAdHKe7vLqxbP6LlVo+n9OrJAVhBiEg3zi8C9eQUUCvPGhMOYmXJSmSzKM/QSNZc69SH+I
	3IY0xmiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qe5wm-00BGA6-29;
	Thu, 07 Sep 2023 03:44:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qe5wk-00BG8s-0X
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 03:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694058281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wpk/JLwGOs1eIjILox3z19SNd6kr3FuL2TFM0S4zDCQ=;
	b=aBIoV2LlLtlQPsEs2fJKgIzftQPjO3DZoDuo6FZKEURkTSaz/YEuK4FTCwUxTZAt6YrAZx
	Yvy7LPy+XHoySKwXhhv2Zsj0CXimR8f63rj3QEvRsszKquetNpCnS0QmoX5qCN/7samLTu
	eX6SXi7ipJ1LEJGkge5mqgFvjUGQ/0o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-uByImZJyOSSBhsRwCKBLRQ-1; Wed, 06 Sep 2023 23:44:39 -0400
X-MC-Unique: uByImZJyOSSBhsRwCKBLRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 749D838149AE;
	Thu,  7 Sep 2023 03:44:39 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99F0B21EE56A;
	Thu,  7 Sep 2023 03:44:37 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de
Subject: [PATCH blktests] tests/nvme/031: fix connecting faiure
Date: Thu,  7 Sep 2023 11:44:23 +0800
Message-Id: <20230907034423.3928010-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_204446_298468_4F85D1D9 
X-CRM114-Status: GOOD (  11.18  )
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

allow_any_host was disabled during _create_nvmet_subsystem, call
_create_nvmet_host before connecting to allow the host to connect.

[76096.420586] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[76096.440595] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[76096.491344] nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 for subsystem blktests-subsystem-0 not allowed
[76096.505049] nvme nvme2: Connect for subsystem blktests-subsystem-0 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[76096.519609] nvme nvme2: failed to connect queue: 0 ret=16772

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/031 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/031 b/tests/nvme/031
index d5c2561..696db2d 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -42,10 +42,12 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
+		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
+		_remove_nvmet_host "${def_hostnqn}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.34.3


