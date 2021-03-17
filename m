Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41942C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:57:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C296664FA8
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C296664FA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dnE/8/9XvdbklIlJa98Z9/v2VrbR2njx/GAW5hYQX28=; b=m8FRRLGNhUS7P1IFNSCLOfkK8
	dqS4yZrqzINndm8/lDqrMb4whxnOuLXJLfXlOc0f9SuP/HpVERe7f1DVKgaUi3qhHqRO1/C8e8Py5
	4Zz76qwCX7YzbETQL09oPFbxLQ4JAghQbMpcPujlQtCINcd6Q73iR9lZzWK3avSg/4dGzriaFhPdT
	1oe889H8KBTyx0pWn2HqroJX2U3CyvfLoDj8RtuUmP/UGlLhUEmKT7aSFLYNF4br10mn4YiWRVY9r
	iOVVmZf3jCq0Xg3LHsgPMkMLzMXHqV+kNz0w8q1EAFZ+Tt2lyWWFYTj7ixiOFW25T3JnmcAf4RmEo
	9yTVgxJJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKVN-00277q-C5; Wed, 17 Mar 2021 00:57:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKUN-0026gR-Ex
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:56:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F0664FB2;
 Wed, 17 Mar 2021 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942602;
 bh=6yxJo0m1SHli94yQhjg+gVBOREYv0JUFfyEY2W+/Ru4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CClVIC/FsGE2+K7sLqXEmIhUGmc5geru/40g5aeUVkSwbxTWxxsxrAQWyCZIZdPra
 8ZyNNj8+RyKvqNq84yxxXr60ZFa6pK0PwiGK24uKlA8MU3HONUZ1MebOacbojVGrrp
 YPjf1igGw5B0MwW+pSYPSo1oJV9l6Zimaq3tMVL7ePBX8eWBGrRmhnynaAShOHnPx/
 +JbBD3C708caqkJnj7qJ/HdJbr8AFFjLscOLfIeCyAfTj9yQtkcTopAaWOOaVju6gq
 ry9wV0jCVLdn+uOmVuCocWhWczrbTVY/XZprud2MA57Ve3T71ODzXFZp3XIfheJX7o
 kx9Hc00gr0DIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 53/61] nvme-core: check ctrl css before setting
 up zns
Date: Tue, 16 Mar 2021 20:55:27 -0400
Message-Id: <20210317005536.724046-53-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005645_635602_12762BE9 
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
index 28bfe5bbf769..e5cc92a6a16d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4081,6 +4081,12 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
