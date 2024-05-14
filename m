Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B1FC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=; b=wuujfvZdyU751v1QruD8YH6klT
	FLGPtb97OezWhl4XQR5//wcCCepRXBerdore+/gtu1b52GznbLPESSfwlaBPZGuPi+zsODtXu0Ems
	Mr8FU37hTBjLci39qpzTdR+RoqGKGjRO2yXNRIcXYcNePENsPeqSgwpOcpL7FZPoG+k303kw6BBMD
	fijpyXyWmJ9pR1C0PsaR4VAj8il/neri/Spx06kZFy6pQph6zdmRWzcIi8GGNjbd3wQ+/wbqInw6/
	9bb1GQCsw/0TdOoex6u4wMY1t3H6pUVWSqB4kGEo/ouzXBE/XTKffQlcWqcUyk02mDLv4hLN76bwS
	xGUrevtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLU-0000000GjD5-0uc0;
	Tue, 14 May 2024 17:53:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLN-0000000Gj6T-0Tki
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=;
	b=H+QZPFSohMIki4oHu8rhha/RnYOE0Ow+Fe08dLlpFN2Ya/IJErvO8Tzvnp1fFOav4zWgro
	sIbKKe2JnToOA24vLAzEflM1G1xmDUXH6yE5+2rQ6QhDvm2fl1YUg3BIvC7WiNeLNiya6u
	K4ZHDpKwdl23egNhrinoC2SP0ZwToOg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-qrfXvdWFNuuPCZl6fv1CTg-1; Tue,
 14 May 2024 13:53:36 -0400
X-MC-Unique: qrfXvdWFNuuPCZl6fv1CTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D1229AA2C9;
	Tue, 14 May 2024 17:53:35 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A433A400057;
	Tue, 14 May 2024 17:53:34 +0000 (UTC)
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
	randyj@purestorage.com
Subject: [PATCH v4 6/6] nvme: multipath: pr_notice when iopolicy changes
Date: Tue, 14 May 2024 13:53:22 -0400
Message-Id: <20240514175322.19073-7-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_105341_245875_7CE8F114 
X-CRM114-Status: GOOD (  10.45  )
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


