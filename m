Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD9C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:08:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A08A61003
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A08A61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xHJATVoWwPa+ZolQpT8sbD8b+Crat0XCdjdX6J4nqlo=; b=FRdsSjJAL/0aUhT5j2gbrYGie
	buITKHxDhpYNbb4uT2znHsrLyp0liDxiS9VKKgHevK80vT5flAOY4rRhh9jjbwig+dVPYVJJ4VocA
	pBGgiANKgocojxCCbdRdjZskejfNjFMSZpClLQGKXMQ6huRhfkYgysu59ZEBCkmnBRU/8/LvXEhqA
	jft0julOz30iksKP44qL1GHjNcDF1s2N26jVZyCsJ3jpyMBkmvrCly2JzBDiFZuGhxMklyYZh1OR4
	FlJ8YIzu6A4cYeONoBQkyyZunXlL/TzwNUQ1Daqy2ltuQDh5EEfZ8PORX00dCVjayOemGrdI8L6cy
	prI2MhNsg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcHdA-006rKb-SY; Fri, 30 Apr 2021 01:07:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcl-006rGp-Em
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 01:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=HE3R4PdbRe6YNK/5rshpseNr+0ONuJonr+tfheICdXs=; b=VBqFarL5MwCdwSVcrg4/T06Ewk
 8Y8LsC0gf8Cf8Qkal9hiueeVVFXU0VPtp+mO3iaW1mDHrkuiERD/GSNEDp6t/ESIpz5TiD0LxHA4Z
 ZnrrTl3SFWT22if3WvU4RWdgRb5pH7ZdfFpwNWEJ0BSNewnwLyXkhmqyvWWEaC48S2SWhk30HoSAI
 A/bvo1rGd8caPmvg/F+hjVOS6vDMpiV9mlvprwHN6zU1WFCDmct78a69hXGumm+A0+Vw6Kp28O7sn
 tSV9+mM0E8Tld5hjngkEftvCiYlGaGbLZKT/N1gl243accW2j80yeJRTVqiGHGweJW+CzFSuyvGhJ
 QxfDTJbQ==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHci-0013YK-Un
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 01:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619744836; x=1651280836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ImtvA5VkoWj7l71VVbw0Jjv0EfmfGHkHHRhK69ya3zQ=;
 b=QB6AWxUcgf4kj/Q70QkPtJvb1W2ggTKuPjhmvhzkQbOP+dtMoYrg+EYj
 se7eYzJaRb5v+/qv5JMzG8ct2bS9KLgxSVIyFoSs9DvwagucXIPBDYqSf
 Xn7BJNu4v3uWQShswUvyYI71YtTSMk5RQ/IH14zeANx/mtvYarN3sPPP7
 fSM7l4vFusN2Avl849ClAcFz0ys3yqkMiHKjlOfhEnyYp3PDAncmk3Wmp
 lvwHVuqKxiz1D7FX8CjOI8N3HSpFJQJ+JNubgFhmp+1bE8gfK+eyS/K4h
 rcSmuyAIyldvtjN79i4lgKN8SQ8MTZkiP+mTfws1gB9YO1Hwm3pQrDXW7 w==;
IronPort-SDR: G0cL+pcnCmxbtl6MpVeuobK0cLfnMbHTnpYpRAXzZEi3R3gk6l5HvIMEkREAeIQG/4nT5WGyqh
 0jCcu+7T38DofoAxH6drlQLN4yfFhdQk//0hnuenLJbVsrayR5rfl4mi+n3+GpTktfCdfZHFel
 6PTdPgAY9o8VpHHLP/NPHmQYvZPHl5WA0fimbbqBPPAh7dM5g0H0A4IjHjI8peIT+y5W9xVbZR
 zVh1JOTn+PIgtjm/Ep5zOaF4lLYHH+tJkDYYGl2HuZzDI/tTzpj4Rhe0TfK9zym9CPy/oYrzzD
 veo=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="171275817"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 09:07:15 +0800
IronPort-SDR: yS95HpU1zaLCnTKP2D5vwAhTPMR1QCXSdZOaXDEoOZ7a4it23QK1z/WEhDrHvs7XgemRvZms61
 HgzbQokpsKs+Krxiv1zqVXUHYCheqbsa6hh8FEIzEpO97AhZKVt4TTbJKqyXHodx1C0/fXYiNl
 tFclSLce/6gWJICxTnzTLpJ7JtR/FlU1twXQOrmEyLq2+uhxx6TDBYQPVL/M5aKn0mcj2GDmyq
 Oz78slfpum4LCN3EIHdAwjOEZ5mBkUav6BPo8UTdx2FrxZ3YrMLsNNEl4SRfuscV89MUW4osG4
 22BD7oa9eq1Uz/C7XIYJGItY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 17:47:33 -0700
IronPort-SDR: LALuOdpMfiFP7lrUvnUfV98udbxbl7pl/CWwSn1DNf3bTEZ8SzaHp0jOgxkM/xUPGFZiS8w+Jb
 auHo+j1Gg6+D4sdkpnex2Ns5Fp0Jz8XFQrOHxRuzjoyufQ+olDOVqKAdmjumaPI2XmL+xeWjkF
 GVcZDq+09PN41PBCbcW8S+ygIfV329A40C7/Paniv0w2KoK12WuagMFb6ihl+hLcfx/Ggj62uy
 qOFPngrYojQe49k4xF6xFLhnJBRjjeo6RkuNJGwMbHd3cZe2oUW4rMVNHi2hD+JS04GsCTlzNQ
 bgw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 18:07:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/3] nvmet: demote fabrics cmd parse err msg to debug
Date: Thu, 29 Apr 2021 18:06:51 -0700
Message-Id: <20210430010651.36736-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_180717_015078_4257CB67 
X-CRM114-Status: GOOD (  11.51  )
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

Host can send invalid commands and flood the target with error messages.
Demote the error message from pr_err() to pr_debug() in
nvmet_parse_fabrics_cmd() and nvmet_parse_connect_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/fabrics-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 1420a8e3e0b1..7d0f3523fdab 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -94,7 +94,7 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_prop_get;
 		break;
 	default:
-		pr_err("received unknown capsule type 0x%x\n",
+		pr_debug("received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
@@ -284,13 +284,13 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 	struct nvme_command *cmd = req->cmd;
 
 	if (!nvme_is_fabrics(cmd)) {
-		pr_err("invalid command 0x%x on unconnected queue.\n",
+		pr_debug("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 	if (cmd->fabrics.fctype != nvme_fabrics_type_connect) {
-		pr_err("invalid capsule type 0x%x on unconnected queue.\n",
+		pr_debug("invalid capsule type 0x%x on unconnected queue.\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
