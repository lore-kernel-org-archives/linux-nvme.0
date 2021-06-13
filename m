Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A6C48BE8
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96F8611C0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96F8611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9LZNsjsG19uvbxXmqzY8xdiiqnHfKK6WKY2upNOJRac=; b=R4ZwptcAXQr1CZ
	+51fEdCQ4Kh6EGdiFJDVbO+IS3ReBiT+ir3urYpqd6uULQwNWrcSaMF+QAnSbGizlRWzxVFTa3es6
	jViXG4QX710hnR/2Mvm/tkaJCYu76OQgp8ApU4/jvfZ4V0PqZ6+WAeXz3+3R4iDtRatOAYDPB0mOS
	MDGdTEh7zgJa3HkmvZTDgyYbuHaO09RTdY3ikFilPARNZ//LWLjw+ccqVidZrr3F8lfTrvqDIo9GU
	mI5cYDd4dXxgkeYjrgTsp2IJhcHKgO1Fm2LdjQyeF2LC/q0uODXziTIWLZbCy1XIz88MEzFQwjOTZ
	ILhSs8wA6ya+wM53CegA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsWKK-00B6jy-Q2; Sun, 13 Jun 2021 20:03:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsWJw-00B6ga-Do
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 20:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623614581; x=1655150581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V+2/rHCM5P308kI+jBNTnBukML1O7ESsLoA05WqxixI=;
 b=Ad6HcBwBroZ8zivo1EMn/x+JpxlRgiCn72N2dy8JYl9jL4rfeq9ll6Rs
 kWtZ6d0R4Nk1Y2vO+UyvhNkJyeD7YEaHsy9VxrbtMDsBWG17kHtpuzt60
 Mr3YzyYfNhnE9mi7aN8MhouZLpAK3lDsAOmVjC8+ER7MpLeMRiV2sMlEh
 zcm1sqBwSoPDQpoug1omcgdCjdKRZjA8kwopqxgFNWJ0GZ6eaTsYqhZin
 ZRc2JpsH/ZG0Dz2CXN7OHv8/20CsHoYni4hjYsX729UbnpbDAwAj/Qs+6
 fgKq2hjzbMW3Lg8KRMElJAGAaXsGTAi1MDehRPJhx4CjZgdmhE37+OLvJ g==;
IronPort-SDR: 8eACNGfp9W9yNw+9Efv3GNl1/8BUdD8h0T5joaOpOECgMKR0lqPr+yavg77a14LGe8sUVky50g
 5PToi5149HrLBcq3Rl9XSu0Sdnpsaf9yzPQD/wTWfb5eYqKxVoLeIUuJVWGceYRIXZ5dRWd7AI
 +5zZsmmzc8UwyfA3kRVR0+Aeh8B2MJ6q9izh28QLtuKq3CYVcFLmnlybQe2Y1uvYFUwUH0LQ8T
 KFG8B2J6DlO4Op5d7wSvCuzHiGE3K0RCTKXcYH5InN/cRdLFzMFGM2STMp1L7GdSq6g/UIc3DF
 POg=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; d="scan'208";a="172326117"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 04:02:56 +0800
IronPort-SDR: 2cN7qfRQ0rnfx8Li7qH38IJu3etyFGTxtiy/C5rwbRF4tzQUzUNzi8wgxiSTsOY84THawGTcf+
 vURd7CMUne2W3ts6bHJ3VqYpzIQKCHHcHG8YQ7b9EpXCJUdheC81cjQswl4d8474szfBGBSFo+
 I8CSSegBvQztfTk0fUQfeOgNArH3zU//IMXMIxRfShtyJB7/uV4uLvnvByYwrg9FCs/8i0o/Jv
 Jm/kAeL2gJ7xbDbobmaKlOo2uFlOHcFijeX1yar88U+m/mxYyG0nyBbJU3rBW8rGc7CjzfVKN8
 VUB3idDobb7V9zWPpEH/Qw/r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 12:40:26 -0700
IronPort-SDR: A6A/Q/+kYIrZkKSMMuyuuD1h4n5hBJZS/flI5vZ9hl5mcwF+jnYs1BbQhCAONe/9ATeLtcMlh0
 pmn2BHMbyikRtXbcD0t7pg1bP22MduvIcw7C1Ush2fSR/qxio73lMd4YqNKLL0UkLjspK3gMJZ
 qGU/qkPsSUxFdHoeUY4liaadLwuqIbHPzyL4qumphtt4Jqcf7Yi10byXfHJ/dWC75NMlodsix8
 E2f+j2+suNNUta93bblf8llSBspqQbKZ0p9fNaxr8hHNq6d+lU7+DJaRTwblv1fzVxuxY3j3ob
 2Yw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2021 13:02:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/3] nvmet: use subsys->max_nsid to report MNAN
Date: Sun, 13 Jun 2021 13:02:50 -0700
Message-Id: <20210613200252.9167-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_130300_546816_F11E0933 
X-CRM114-Status: GOOD (  13.46  )
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

For Spec regarding MNAN value:-

If the controller supports Asymmetric Namespace Access Reporting, then
this field shall be set to a non-zero value that is less than or equal
to the NN value.

Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
MNAN value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..a8ec377bb68d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+	id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
