Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCD2C197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dJI7TJqJcZXfYE4uxD9s71zcB+w5orV7D9R6g4qD3OA=; b=CbDT+2BE4iCRG6vHZ+m9WBZ1PS
	qChlDMuYmr27xAtCSB1ZBjuLOt0v5pHy3PdPJmdfyo4zvHuLaJhrJ3e/p2eecavdchCjVn03UAb4p
	McsNTTU0ChcN3g1c7AE82SE8izAl0MaAGNqgifzmWqk8o5tF0Ja/pfG6VISkHpwxbKUTLgn/5QPu1
	XGldKzRc6P6e+Aarcd9ycqg0PvGjTYRZ3V+5Z56KFg9SI+f8gZHvUojj5wbY++i1HDT7J/7zHLKev
	z+4sFLmY+IRZQo98VEvmvhAUPoKiDe7HGzGuvynd4w3tbfvo7TEpBC5lrEfusf9ic1nJhCAQrNd7g
	uFJWMGPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjms-00000008eHm-1bpH;
	Thu, 27 Feb 2025 19:43:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnj7K-00000008OeO-1qlH
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 19:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740682814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dJI7TJqJcZXfYE4uxD9s71zcB+w5orV7D9R6g4qD3OA=;
	b=cMocS+9BxRN+6jFwKhwn1Uzzc8ck/cQU9s/hqKCmv3vbksOutZFX2wXBDtOUO6fB5VWqLX
	HYrqJz9H9jB9ARPNEcs93dsmoCGJTWoYSAj+5Kspo1RNxI++R8arjx0lXUq5/WgJHeslPe
	LwwLBSHZkqZ+Q5Vaq2aajoQfgGumM0Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-fPNBD-pfPgO6aGt9OSR7FQ-1; Thu,
 27 Feb 2025 14:00:11 -0500
X-MC-Unique: fPNBD-pfPgO6aGt9OSR7FQ-1
X-Mimecast-MFC-AGG-ID: fPNBD-pfPgO6aGt9OSR7FQ_1740682810
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE89B1955BFC;
	Thu, 27 Feb 2025 19:00:09 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A96911944F2E;
	Thu, 27 Feb 2025 19:00:07 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvmet: remove old function prototype
Date: Thu, 27 Feb 2025 20:00:05 +0100
Message-ID: <20250227190005.895342-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 45CT2Kc77Zg7i0SXvPKVXPdo_pCbkHUk_d4zcwaACX0_1740682810
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_110018_551666_C0B8916B 
X-CRM114-Status: UNSURE (   8.78  )
X-CRM114-Notice: Please train this message.
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

nvmet_subsys_nsid_exists() doesn't exist anymore

Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/nvmet.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d2c1233981e1..fcf4f460dc9a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -647,7 +647,6 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
-bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_MIN_QUEUE_SIZE	16
 #define NVMET_MAX_QUEUE_SIZE	1024
-- 
2.43.5


