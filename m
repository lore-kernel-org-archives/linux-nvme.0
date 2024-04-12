Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE91FC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Aq2j5CdxkSO+SfJ7yBPUM9RPgNjH3B7S8zMDMCufTc4=; b=fkCWzvtQRKajMed6/C+Sy40t3p
	oVe1sRpEJDlpXzQMIyLSWah5q34xE/+TvcfGFBWshMFe0cziGHfqbir80j6gENqyhkvBB1Oc33+l5
	dvhF93rnuApv1ron1wgPZZs3/9sQOpFS4vgBtGCuGjlRT9DmZqih2zi6wj4FfwRGsJuwgOhKQ3dRl
	+ijOYJsPcaUfXhwVjCx5ZACeH21HxNvT5iWoVrnY77qk+t8J4+3D2COa9aZg1x1sFa7uInuLj8FEY
	I2++l9MYfNgt7BtaRirwGaKfnohjw0BQfBa6SA89Gax9/nPvpbejG9G5+DAU8PeCMHCvDSPYL7XwW
	tNQtKlaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvHAR-0000000HNpV-31fX;
	Fri, 12 Apr 2024 13:42:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvHAO-0000000HNoj-46Mf
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 13:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712929325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aq2j5CdxkSO+SfJ7yBPUM9RPgNjH3B7S8zMDMCufTc4=;
	b=jVMTP98F+zswUfXiNRonwcBxEsoyQT65cLb0VMfNlaVuDT1PclVz8ihwit10NDiG3zUYCJ
	3ipav1qFAyVBSvfngYW9/GZzNZKKUc7p+sUFMrJYj/NWKKMwBMsUvipU17Mu3SKFpgvrYM
	xNxqXh7HmucOo8QBkUlnNkN7ZVy4/Qw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-eZN09XH2NsauyoXKQV7s7w-1; Fri, 12 Apr 2024 09:42:02 -0400
X-MC-Unique: eZN09XH2NsauyoXKQV7s7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 820A1801FAF;
	Fri, 12 Apr 2024 13:42:01 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE9AF10E47;
	Fri, 12 Apr 2024 13:41:59 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: return the error code to the nvmet_auth_ctrl_hash() callers
Date: Fri, 12 Apr 2024 15:41:54 +0200
Message-Id: <20240412134154.565298-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_064209_319992_3C4DF4A3 
X-CRM114-Status: UNSURE (   9.68  )
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

If nvmet_auth_ctrl_hash() fails, return the error code to its callers

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index fb518b00f71f..4f08362aee8b 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -480,7 +480,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
-- 
2.39.3


