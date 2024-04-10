Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8007BCD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/4RJtfof8lGqKYKZsBoIgBCGDf1H14vcSc6v5mFXPQ=; b=PZjvUm7cp5tTKF02cpdc/rOcxI
	AjTL1a0ZcWgMZqsIXknRq52OIdUrXDdk+7e2pQSjH8lB9LfwCVKFG7JE3wbroZR6LBLh7v6UJMIv1
	EzviU/X3Ejr6HcDIO7INGwrho7FeySUGwl575Js9cv/B6dOiCTu1SlE3qVnU2fgg7utyZguHQGMtX
	kD1NuDcop82+wBtB8XBxfamtJpLyEFOGFwMBVNjfIBZ0muZ+TQ9c4fa3wd8FFu4oEIqOID5U1UT88
	P+KTAzuFLirn38P6GbuQ7Gq2HctYIBRcXKaCL2Qe8uhMEdlD/vUxaV7YGptIGDctmLaEPtFrPcUUl
	Yjs6d0Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbw-00000006EV6-3o3M;
	Wed, 10 Apr 2024 09:51:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbt-00000006ES9-1aOz
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 09:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/4RJtfof8lGqKYKZsBoIgBCGDf1H14vcSc6v5mFXPQ=;
	b=DNcC/Kp8nf6WnN+yGamv3zbpI6d8o14tcE9reoXftXxr3APSn8vybGbkEqmhKbcJBQJOtD
	IW3f7r5Si7i/tGIXiBnMeF5pYv6l6X9nITbgXTUb55yZvLoMt9/VHrE1FaooI+XY196rNU
	fudu0AD7Wo1xjyhy0zQpQSnAgc4J9Hg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-QDKDHKpnPSm1rfRKonRwWQ-1; Wed, 10 Apr 2024 05:48:51 -0400
X-MC-Unique: QDKDHKpnPSm1rfRKonRwWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B23510499A2;
	Wed, 10 Apr 2024 09:48:51 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F35D6492BC6;
	Wed, 10 Apr 2024 09:48:49 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Wed, 10 Apr 2024 11:48:41 +0200
Message-Id: <20240410094842.370170-2-mlombard@redhat.com>
In-Reply-To: <20240410094842.370170-1-mlombard@redhat.com>
References: <20240410094842.370170-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_025117_588205_5B9D849A 
X-CRM114-Status: GOOD (  10.87  )
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

If the nvmet_auth_host_hash() function fails, the error code should
be returned to its callers.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..9e51c064b072 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -370,7 +370,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.39.3


