Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D8C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kG3hSNYcRPVcN22CrD54Pg1SGCLZw1U1KmPTt/BPsAQ=; b=n+I5606Be+K0wrbOUDTXKxRR21
	ldi2GWGsBdRIdy4JNZq8DZvRsjeZYWDFYLJgYVrzClEzRQoMIn9AWRjlh47kjOna3PS/XODhx8A3O
	8M2wXYyv5QjtFXNCDI75gvgbIBARBkHLcAPHu3pPYDYYMs6na3TDlMh3pbJnctYkZXeiISLg5lWG6
	k2sZl+2XEIzHzhGduXTRD8+i3+j9iEQxrFGFR5p3nAqKVw2lorY8k27RHBsIZtHZ1x6qTm3Gv1Ctd
	3w5nGXTuNv+Lgx4r+9zSW8LixlD5ePIuzPveeso7aA08YYokfCYA8XZBJOrDSYF70UakL8Cjt4/Uw
	typQTV3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpO7-0000000Bqo5-23Z3;
	Wed, 07 Feb 2024 21:23:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNw-0000000Bqdm-1kaO
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:23:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D931D61AA2;
	Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4838EC433C7;
	Wed,  7 Feb 2024 21:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340991;
	bh=iOziTvu6wmjSavSMr9/wOzK6SY7pCtHgB6PvF+dkuuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAexUWvX3DM0geGnB+0miqIpKJHjB9yO4iXb7g3oK7lvY5//MdRF8BmP8zcUFdcn6
	 RuyDv3T25NOxu+tfKYClTcrcwewWXMjK3IsVQCxpSCQBA0kZXYeQbb6S9IIkC+4ReZ
	 vuCoXLrQJgqeuLt51iLjKNXIsNTPNhy9IavUBE1DMRrTXaYxBYxjguyeL6J3pvJg+z
	 RikeoFVtP6Mc0i60yLMfPrcaqKqsF8t7EZZpsdkY9a6FdDkDYNyLZ58u9RFe4atkgk
	 GxcIPceAgxGyPhyjjznnhapOYY9/At1nsiiL7ZO5pnZSu0tBx7LjgiLXjPdeUnoPJO
	 hym9UsB8gORwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 37/44] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed,  7 Feb 2024 16:21:04 -0500
Message-ID: <20240207212142.1399-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132312_652594_211FA5C3 
X-CRM114-Status: GOOD (  11.48  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6d111b03d371..d50af99e847d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1108,12 +1108,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1143,8 +1140,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
@@ -1181,7 +1176,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
-- 
2.43.0


