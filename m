Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50936C369B4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=supl0p9C0y0UidCJqxrg7W/S5GYwBcricq9pjL9wD6I=; b=lhCmFnU+tvJ2dMhh30EVJO8gza
	SNul51Mv7cV8BtcsitqOJqBCyB9McMVwjHr0oIL/x8S47l1jAZbJP+JqpHLNJ+mc24Az6WZPJLloW
	6HcfSHCFTJgo3xIAtdCH/BOkhokN8i9cOiPtH+4ezj9VpRzR95gdDfXzxLH5mxmg0ilb47IpX51St
	yx4m1OCHkQa3LS62SN6ibFBZxt/gTzo+713DhNV7ES5dLYoTwruJ5WVCz1eXAr/5CNSniSuHa+DjB
	V7lWqkU0WD9/sv0KMqCFcbjiD6llIZEP6/BFLEeWLgtsoRXi0CcsG88u+rvgIVspv106gEZeQj1ga
	P/5R5HjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1i-00000002RTl-3c97;
	Mon, 14 Apr 2025 14:43:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JrF-0000000288R-1v2T
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=supl0p9C0y0UidCJqxrg7W/S5GYwBcricq9pjL9wD6I=; b=UqqPyJeWm3UF0ybOBd/OCMVjzO
	tbhi7EkTC6JyXMzf6zlaytFbsCOy4bGZ7KU9ZuF71KIXyPN77Qs5o5c5RVBaoY2QBzORTSx7ryMsl
	23qSTJl1p6phGmFb2EzgsSozJmD4RNBjYmPVq4Ga5nB4h56ZmjcQHcN3uQOmM2bV5CPozayztmi/e
	YsG9rkw0ggumA+De7YY5WYwS63PX5lh50KWZhfwYho1s3lAj78N6ltUysp95IkIVrz9G2nk67xKNY
	uh8/8QNysg6meCOjrKyh50fD1l/K5eIEYPIocw6hNlZWK0nndH6R3I2mUh4WofRZeYQ0jzTElNTfA
	T2XE6xSg==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4JrC-00000009gp7-1w3t
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:28:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CECD4A575;
	Mon, 14 Apr 2025 13:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20B2C4CEE2;
	Mon, 14 Apr 2025 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637293;
	bh=D6E+ftwKaEDnlOgH7CxwdYq9Pjv4XAYi+CX9eMqeQas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2PdMGNGhB1O1gGOOrXqJjX7XLV3HZqQhpx4EabrEYB3tD5RyAAdweG3coo3of5e+
	 fU4Xl7xTD4wLO45T5a0pJF/PfFnVSodGW007U9lbJNWPXnNOpWNwP90igx6H+szxxh
	 bhGDHoRYqs7BlkNLJFA6trx2PSl807nf81hael//AhDj2eMc9uDA4QiT8UTdxWRLXH
	 e5BNnS1VD/ZXG0WWbGdVYNpzP6m4bdoHJDLWIbV4NZc6/SbAJQG+bHIMRwn3aN3/Qx
	 ne6JoT+AoibBiX8RqW1TakWYbTzWWbgue35NygXJy4T4YzQF+z91HOnSGFLbMpyBtX
	 5LRfkkNeGBoUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 18/34] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:27:12 -0400
Message-Id: <20250414132729.679254-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_142814_748337_63AF2F7B 
X-CRM114-Status: GOOD (  10.86  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bdf..bc3b037737c8c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


