Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAECC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:03:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A0A64F0C
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A0A64F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wa+L4m7IXZKUXTI+1JBQRZuze0BgnVaYNqrmH6kVRhQ=; b=Dpzv2tQMwP8/mVJckI5nYOt67
	p9DaDYqZF6m6H/eY50dycSIUFxBcoIRuI9qPcj9/jSUyJ8p46lDPQgWN2jsiC2J+14WGh369p4Vnx
	z21aK6zBJLk1d1xl7wJKrkXHfNTv/uE0p3z0DgwyeaAQyuWPY+QOhzqtUpxqTm56BvmdmLF5r89Tw
	fJJ+o+AO5G6ZtloO6n/Pd21dymruxUBJ1+v6d9YwKJEO+ppPg6/x8VDa5ioBxJ9osQomcechnZuii
	+gS9PS6nc6gQ06GebWloHOCsHVSwm1/KyT+UCevaqYk/nRgUPHHhTJN/a38Xpt7QimfRiolu2h/a+
	+VEqg6wrg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKbH-0029C8-Dd; Wed, 17 Mar 2021 01:03:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKVV-0027IX-RK
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:57:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6657464FAE;
 Wed, 17 Mar 2021 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942672;
 bh=8LpXTNgfmmT0/ApRuQPyPnu99fhgrRhPP5y4X55vZ0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nQdrzVPIXmroPRoCGeWzJkBROWD38uIQSStjxPOR0McqSOhXSltlCEnAP2gjI4QK9
 3LVwKamOadNzQXQ2tNysulH3hwXCl21dVPHeTH+avfKuh45KPlef3aFGcE+Qw62uvS
 XsYvSNKPOMccBQFDskcOMZbqfvvHEE6EDUVcwmTir84zjSpg8rmD6ZE7gbCQmIUkGk
 Wn6jqOCnTk9OXg02RiaRZiuukeivwI6JBngUkbX5B7CXeUrTWV6vNmYYgdnIA1GYUJ
 OJF1Fp7o2PsE8Q0LXDkydaPJcpkgJKWaEl5Ks2+dWokF5kBLlHY/x8sDiY1stHVpoA
 zIABWcd7ckQlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 47/54] nvme-core: check ctrl css before setting
 up zns
Date: Tue, 16 Mar 2021 20:56:46 -0400
Message-Id: <20210317005654.724862-47-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005654.724862-1-sashal@kernel.org>
References: <20210317005654.724862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005754_546227_01149E59 
X-CRM114-Status: UNSURE (   8.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 0ec84df4953bd42c6583a555773f1d4996a061eb ]

Ensure multiple Command Sets are supported before starting to setup a
ZNS namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[hch: move the check around a bit]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a684168fa4a3..66247f8776b7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4031,6 +4031,12 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				nsid);
 			break;
 		}
+		if (!nvme_multi_css(ctrl)) {
+			dev_warn(ctrl->device,
+				"command set not reported for nsid: %d\n",
+				ns->head->ns_id);
+			break;
+		}
 		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	default:
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
