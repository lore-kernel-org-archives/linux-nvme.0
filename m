Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F283C3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlDDpX5Rlxdsb+uOPKCdGiqUd/jvI/IKpf8EKLETTd8=; b=z6Z+FKcqBq5BujZfWVQoxbqH/t
	a1/gCzVVc8n8ezghOQNln0ylPX7d0fZXIgNZcGMZV7eF7VkWrCO357MU8VEn+8IG7Zv3RTtPJnSkg
	c1nBYB80t6XN1BHRiIy9RgZRGOXIfvLTj2K1iJbYa/rcN4nYR1V21k9O408UEVOXYRBAVljpNss2e
	nS2/C3C9OLS1PaFOu4hio2MexbN9BiOi0mDnrPmRy1WW/fssQ4szky9mpUZhL37eoQU9TIPHpxkmN
	O9esm2xBV0NVD94oA3IFlC3Rv35pPk7I45uniNgjjT+IYBQal62KQcrmDOGGaiirOK+5+sMjQAjDn
	34ICE19Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0hX-0000000DGM9-3Jny;
	Wed, 17 Jul 2024 09:11:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0h8-0000000DG5t-3wRE
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 09:11:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TlDDpX5Rlxdsb+uOPKCdGiqUd/jvI/IKpf8EKLETTd8=; b=nsf0aeJKUm4HdoMGamlNDBm/4J
	sArJO2a5A+EaH1PQgIHhfXTqsYsIkS7rLqwujgGBffEe87kviCIp4kfMkOayCK9/CSbxyKkTr1Rcv
	QiihLWuGgCjdSyi0QkbwH0MiwCv6bu70EnlvMGmnSZX04XzQFS0dWehM17OcyDPO8uJiVZ0pqn0ib
	IFQkVbGn4ohl6fJeg/z8UaeanI4Wv9Q0jlKlxCmLyPs00VTuPrdfhrDMFfGGqH8XF3VbfIauUZLs5
	6bJKDEZM3f6M8piDk+VRvusU2h51qAW0z9fvoKeWkyd7/CP1ffJ/58rwHFdHhr7l1yd9n3003Q3e3
	x67QqExA==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0h5-00000002HZA-2TMT
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D48DCE16D2;
	Wed, 17 Jul 2024 09:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C9C4AF09;
	Wed, 17 Jul 2024 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207467;
	bh=Q8zoK18+LwzdilPBi5wEy5PBS08P2O1n25/4i1hDRb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQe0QEG3V75OAntN7ncQHz0hys1kqR3j8Hm4RwA6J4YysVbhn31SmCWIb3l1DQVvm
	 uppq5hTGtpVw7GvXrGBNNqAKjQHhafWq9eyvhQh7IcOgBaP7lJdPmyVDLrrQ7YJupm
	 HWJOstESCW9RgMiEPF5fmNWAJjGClLLtWYPNt7fMrdI0Z3r32BtiQu+kYFX14fqsDJ
	 40tMiaQfEZIvVd83o87OTp4TESPkhiVvTHafLWayaUA9Cc/YZgAZcSvMgJHmVf85qt
	 fuOnYy6RBKT42imzqulWrEqTBgpIYS4/tH8KQiH7jMb2lXLXhWdcgZHD7c2xMl+cys
	 qcm6ujVui3IqQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 15/16] nvme-target: do not check authentication status for admin commands twice
Date: Wed, 17 Jul 2024 11:10:30 +0200
Message-Id: <20240717091031.143188-16-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_101128_005316_9097CA56 
X-CRM114-Status: GOOD (  10.80  )
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

nvmet_check_ctrl_status() checks the authentication status, so
we don't need to do that prior to calling it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..d64480f01f4a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1005,8 +1005,6 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_admin_cmd(req);
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
-- 
2.35.3


