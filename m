Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBC606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WuFAAoI2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYzGAwN/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BvUKm1Kc6TxTvWGhVgwmGhFF4aascmDSTk67ZMS1+no=; b=WuFAAoI2yUxJaX
	NvVKLi7UP9NtFHJfZS8kO3O62YMXNSoeivsSs0vTPSUiXgsWEdyBh3XaNySQr8s4UZ2yCy/w8FdeN
	hTntQ+2SdYgk9CGDlP0YO/FeMl+KTXaymSs8va9wYBpT2SIQV5q8B9bSY6pd4CrQFj8UdGjMvuOwX
	UCLOLNZ68yDlXYExV2Afj4NA3MsnoaM9YjXyqRJIPuj3P5Q4G/q7KS2p0S9LF4fX7RtzE6MDGgZn6
	Bx6BcG3s/8IGWlBDkSPCXxZuTKdRJFW7WF53JYYUF4TmTSZLoYNfO34avJtgZLfjZY0WYswW80x12
	wq6hkFgkTygFSLCZx86g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaEJ-0000000DUui-0MYP;
	Thu, 26 Nov 2026 14:13:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaE8-0000000DUu6-3A78
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:13:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67A7940B3E;
	Thu, 26 Nov 2026 14:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39791F008B2;
	Thu, 26 Nov 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702411;
	bh=BvUKm1Kc6TxTvWGhVgwmGhFF4aascmDSTk67ZMS1+no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gYzGAwN/1GxhLQ/AFboZpDP4nb+5s5RvRz/Yb516Q526XWwAcqCjdXxov9kcfWmBq
	 wPL/GSf2DsD11w9GtlRz5OFRmL+YcuIkayeJlJ/ESg4kYKF/yIbzvzKEoza8RtUqZ1
	 QGtff/sQIkd5E/CTAfHRoFCz+crdsWrUwTkRcLdALF4yaXcH9H54IZ58VK5Aq2NiaW
	 fWvcHfQgR63VLZYatal2XM2ZyMRm9EuJz57XVG3dP10CUEp+iT68N5wsmLOfDSsbIB
	 0q/+Bl3Pe+RyY4mffX54xQS93PY6xrvYb2aXmgeX1MNQT051FhtxCkCKj4uDQXmKJR
	 r1i9cDdBvjfbQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:29 +0100
Subject: [PATCH v7 11/14] nvme-auth: wait for authentication to finish when
 changing keys
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-11-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1265;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=NxkaI8mY5H5XZmcu73pyXibvOuqB8Vcv/J50v8rLZvc=;
 b=ywEpeYUqVl8+Hrn4lfPchjdwtHLhh8mv9UHyAiolv+onNInM40YQ9ez/LMb2ceFBElhPikEjH
 CCD7jp3MrRgBSv30JEh1cPXev1SvLr/QPlIeHQPg+0ziGIP0VtaGYnK
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
index ab912a4b281c717ca569062c19850d305f20500d..4ebc03a8ddcaede1344988dfe816bbaf3746bb55 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -908,7 +908,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -1005,7 +1005,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 

-- 
2.51.0


