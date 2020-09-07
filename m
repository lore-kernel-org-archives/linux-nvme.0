Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4AEC2BB84
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D78821D95
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PKzJiC5D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I02caxbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D78821D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NeE5WLeuwjGyiBvwLf732Vp7vOyIKxk5obMO8vgNzdk=; b=PKzJiC5DQKZNMEW9pLag/7Ven
	hhOT/Y3oP1ra1Xbr8Rwd8AlLpbeX5aXEEAvf98LOf4WDiVS6mJmgtAcGbbp+4GHdvroSrdsq8luP/
	VvzQXwD3qozkGwV6znsLjMOyrkm9xppWo7/QyDDtSYo83bA0+TT0r90wC3HW47LAKdZUzypgjNyUj
	pEGY9Vv4Uu26MNqQqaW9XP32Muji31E0sbWHItizIKQn3d64edGVYLF+6enoqDy5PkifULygySiGq
	B1UqhIF2yJ9bdaz/u7oimaG2iq5xwkH0izMVfD7Dqr1v4ubkPwgN2aLwDKI2qqfhnuPzoiflOZZYG
	KB7JzO1tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK8G-00070u-5t; Mon, 07 Sep 2020 16:36:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK6O-000671-BS
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:34:58 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6DE0B21D93;
 Mon,  7 Sep 2020 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496483;
 bh=/RTeKqlM4eEKvHgTozSYnhVsgFdlsZhU8zbzBPsVOYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I02caxbVshSITtQIylVPUDtBcGjsviHBGY08YQRtqqRRLs3n9sov7J2c4jyusYIF7
 QJNuAzHYZffpCYQp2LRBcyV97y/8mOJhR9h+ncKyxPJ4Ic9ojSrlj7n/QJYVGu4pm4
 FwPdRHHaPRNoDoUM6ugR1gkCs8A5RbtTTb5nCl8g=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/26] nvme-fabrics: don't check state
 NVME_CTRL_NEW for request acceptance
Date: Mon,  7 Sep 2020 12:34:13 -0400
Message-Id: <20200907163426.1281284-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163426.1281284-1-sashal@kernel.org>
References: <20200907163426.1281284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123444_509921_4309F92D 
X-CRM114-Status: GOOD (  14.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit d7144f5c4cf4de95fdc3422943cf51c06aeaf7a7 ]

NVME_CTRL_NEW should never see any I/O, because in order to start
initialization it has to transition to NVME_CTRL_CONNECTING and from
there it will never return to this state.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bcd09d3a44dad..05dd46f984414 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -577,7 +577,6 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * which is require to set the queue live in the appropinquate states.
 	 */
 	switch (ctrl->state) {
-	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		if (req->cmd->common.opcode == nvme_fabrics_command &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
