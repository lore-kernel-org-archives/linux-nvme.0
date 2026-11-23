Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BF606A686
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yn3yfZAs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwBwPo52
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LNEib23kdbMBmadoWSW0XQ0A3tFBRek9SSNN92u2eYk=; b=Yn3yfZAszop/NB
	kQ+joa73+GEOeT8fsZOI59rr8C1D9ecPsOnzJRNAIhlJU0tMAQPgf2adDVv1X5TZuHOLf8SdAGVgj
	3abzI5SUSxN+h3Qu7cc9WUGjYiBsNRZdaG5AaIhd41EPKpWdTHjgEO5XbsylKhWzcWodvsdI/q7Sp
	a+3TOsDNkMMNYH1osIGE+yKsaGyu122AVdWk8JscRR2DbVKp0c8zY7vxuLMnhqGqxkZ5WxxE3uxCj
	UwA9goRGNYWAhfrxkdx3ImDw+DM8Rr00skH3Ee7LQkxh5MLSTdKw8Jvr7WQHF8BpsLXaxUaSiUCOh
	j76zfrFs3od2Iv1WkztQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYp-00000004IzB-2FLZ;
	Mon, 23 Nov 2026 17:10:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYo-00000004Ivy-0TTU
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84A4B61D1E;
	Mon, 23 Nov 2026 17:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02A51F00ACF;
	Mon, 23 Nov 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453832;
	bh=LNEib23kdbMBmadoWSW0XQ0A3tFBRek9SSNN92u2eYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NwBwPo52aWGqeBDE3K8inUD7CkUpn9i8jWv0waSEL4+rB+96wntI0/gn9s6UsnRpB
	 gGXsD51QLUw27YDxj/Jixq9/V6ncpBzIg7qge6jwCDQsLCl0y/lwOJixECErwhxzu6
	 zD7iOUZJ6QPJWL1XAQl47/lt1qvblIkriJgPxVUcQc3tpL+OmXvXCmk1Wfl0ZIDLYk
	 DcJtmT0gdiSesMXXiC8eGsaZNHl29+m/HtNmL6s70l/znr+an3msKPVs+dG4ttBZyg
	 nomttMkoMGXcdQ7RBSH5NpKxFrRRzzfcBOgaTdEWDKowoFX+JTCKmtfVapWZiTHq6o
	 81NRyF2hMnsbQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 18:10:07 +0100
Subject: [PATCH v6 7/9] nvme-auth: wait for authentication to finish when
 changing keys
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v6-7-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=1265;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=7VrlctXLlyrYagLcRP+azunhus4YGknA+amKa/OT2yU=;
 b=86wY3AwPcjlAEvnt1dEXGhuEDNj1ouzJDAlgAFI6PsqSD+k0URXGPHEwNvCTxCl7CUuAwYa5+
 j6Yji3VlCj9CaSeo4ecb8F2C5XyCZzGN5NvBzVF4F9pG1JZydeRRWcD
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When changing DH-HMAC-CHAP keys in sysfs we need to wait for authentication
to complete on all queues. Otherwise the user might change the keys while
authentication is in progress, causing the authentication to fail and
I/O to be interrupted.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c94abb901a73c880d354d9c1223d89fe5c9b0e89..8b6e5409f4893d8e56ff6fb15a89b540b1f733da 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -911,7 +911,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -1011,7 +1011,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 

-- 
2.51.0


