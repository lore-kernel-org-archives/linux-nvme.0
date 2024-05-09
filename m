Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D81EC10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=; b=3Gql0PW9XNp5BNhuiIF+mAHq5l
	/AwPBa/cNFCY9KcMzHYucTSnu+xh3xid7SI/hfnE6dwp9wnEuJeqvPnNnWzcT+xJ+tmehmeHcQxQV
	GeXYkUDaIW5ZJXdlQ6ZTV9klLQ1YOlzr+pcwsIP1VHiaHhZo6a3Gjh5JuMOrPhYyAqODrekzDcE4a
	jNkuYE9XJBAKStAD1TM/2/h/RN7b2W+jRl5ZL9kCOz4QQY3znlDlSfu++NtHwdeR3+BaDWjSvuF3B
	MrzWD6ACFZ/k/dftvE1iBMVU1UmtlitiWaixakRCrBpdl7qc8H9y0C+HRaguMaPh9y3xJqHUV0c6H
	5r4KvAfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Aft-00000002pcr-3fOG;
	Thu, 09 May 2024 20:47:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Afm-00000002pbb-1LBw
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 20:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715287645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=;
	b=UK3c5IzUIBgTi0Nw5UQgyWfHeXI72pj/jA2SxMNIRoQwt6Kmzp39DgACenxf/eNCK516+l
	cvgxu1pLhRbmyohs9MT+7zGhyhlK73rxq8hqaOZ+KRWsrkoeKHTqN3GBDRGkjH1LqdU40C
	dNaetFIbxZEqWfc/dwLvbjFX8P58FzE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-MVAV1Q_mOD-RwikX89Y0GA-1; Thu,
 09 May 2024 16:43:30 -0400
X-MC-Unique: MVAV1Q_mOD-RwikX89Y0GA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FE3829AA389;
	Thu,  9 May 2024 20:43:29 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F25061C4DB56;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	aviv.coro@ibm.com
Subject: [PATCH v3 3/3] nvme: multipath: pr_notice when iopolicy changes
Date: Thu,  9 May 2024 16:43:24 -0400
Message-Id: <20240509204324.832846-4-jmeneghi@redhat.com>
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_134726_825353_C41BED91 
X-CRM114-Status: GOOD (  10.88  )
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

Send a pr_notice when ever the iopolicy on a subsystem
is changed. This is important for support reasons. It
is fully expected that users will be changing the iopolicy
with active IO in progress.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e9330bb1990b..0286e44a081f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -67,6 +67,10 @@ static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
 		}
 	}
 	mutex_unlock(&subsys->lock);
+
+	pr_notice("%s: %s enable %d status %d for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[iopolicy], enable, ret, subsys->subnqn);
+
 	return ret;
 }
 
@@ -890,6 +894,8 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 {
 	struct nvme_ctrl *ctrl;
 
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
 	WRITE_ONCE(subsys->iopolicy, iopolicy);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -898,6 +904,10 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
+
+	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
+			subsys->subnqn);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
-- 
2.39.3


