Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378FC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E504460FE7
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504460FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xHJATVoWwPa+ZolQpT8sbD8b+Crat0XCdjdX6J4nqlo=; b=ZHluW/d32tCyRnex4yTgPfRf4
	vO/GUji9bOD4D/OP6mxNhUuAYj7lv/lRXUC416psXF5M3wm7weW47KY5Jb1ACL/1fnSWk9IIHCYP7
	maCpC8tDoPjMTc66ctF3eGSRH5GCTk93r4cXTcDmtn2kddQ5lh7tQtS7HhxoQiPWQCDLpNpQtJHQw
	+keC30tYj4zngmA8A9Zkx+GkqGoKVMAa/PK9tuukWrLIjMjCjs5HmFLvQK7EgAFKyGI2rEeNvBOCv
	wphmqF9D53Ny99kfO3TyX+3nNi7ifCkFDgyg7tTNGO2vmaefnksGSzg7jlyQ0L+MVBHP3Mo8/W7SL
	wkUYgCPKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBOG-00FWZw-0i; Mon, 10 May 2021 19:16:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNb-00FWT2-N4
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=HE3R4PdbRe6YNK/5rshpseNr+0ONuJonr+tfheICdXs=; b=fmnS5F6dZ4v6FXrw3XqNxllkCj
 QEq3zicfJMwdUQfAuDVZcvkHlYNJQKY/CP9ELWuf9ttVUA+YXLn1My1Kl+X+BOFAfOfOgOHCDPctt
 WuDT6ZHA62vh9CKR4gW99Yo1nPco25UIKKYfsMVBVkut9t/g7bVWHFsPtJtZ0zE7lZbkSlc4WxwcZ
 pzsJ5KUO57N2tU8rMowvGzixD7SsMP3YasRKFhoTeUqge+DX6z35pYwnA6ckoaOVBr2ThAsUFIpJB
 ehvn+AQ2juXvESuDEiEDBpybAWuAxH/WAHOLJkEf21Y7SB38DsYiiYy1LA8+Gf7r/BJe+BUqaHlgy
 n/vIQgKA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNZ-0093sw-7I
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620674145; x=1652210145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ImtvA5VkoWj7l71VVbw0Jjv0EfmfGHkHHRhK69ya3zQ=;
 b=KQ8dhqQ5FdoP/PS056UX3475tYtswURIKOtgdnI7U3T8H0oRBoGWRD4j
 B+G1ANwIZEVa/JqUfEtzRlkJwmtNMBrbXYm4xprVbE+go4Sc80tA/R0oj
 4TdDRoZKWYHcb9isv66Pc8jdW+VU+4XvL08EMafd1BBZY2QJaLLSOUdmA
 FmGVLmlhvPCP3eozPkUyTx4BPTm8VacOZOj4lOYBthF416JJDQOWjiGNy
 q1flAa5VgN67WhUwsATsTmCYdZkfdYzHEcs7R57EtMMHrjAxm5VbGbdJe
 FN2GwxEZJqg+7Mw3nAEmauCXqCPSJAjrq2clZ8z2pRc6jRKuNPVEioYLi g==;
IronPort-SDR: GPEqNJkqlExK1wK6/GVKuUtgOjU0Pc0Y1PbCvv4BiXzng6XcwL3+xgfveTvkxosxsItHZ2ouCX
 qWWfqPouUs4PGS7z0fEKyl0KvfLmFP2Uvq3G0ttWBg5GVELgkjLb0AIrR/riSt7kc2GxTDJh3s
 66GNmSljNirVX/I3F5ujvBS5dPSo3yTdOk0SS2gyhtpnuD+NO94E2U/Ps+cctCxDonHCjwv0My
 QoVIokZzJirIJ9HoGX6XwHdNp48PdIZsjOrj5GgB+3ZQ/hWaQ/boKs/WlPWOeBC5BCwzsdFT9P
 OJ0=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="168207429"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 03:15:44 +0800
IronPort-SDR: hqyanQjwZYBtM8jSKnEfezcLeVU0N47/vsbqiBeIz6io8rBdHS97pqUD6Oun4pRtwvC7ckwdlC
 TEmt+v7Hg8VX5D6bBEpq096+eu5JLNYIsUgurqopqjxMyaK+Ck6Zl9LB+OmkZWihZTSEvkKfbp
 8JZVpYqjJA+QJQuThhS1lBBmi5C12WsknVw5FguI1PRg7i22geYVAmHv+gIue2W3hjLnCt9qrW
 xiQvw+dg/fvGYUX/fWhpqlMD+1p71ZB28xv3F6ljpxthT/qrvvMmNn9ZFnKyisMMsEffyam0S7
 lFca6PKblsPBgkAXqlWc0Oxx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 11:55:43 -0700
IronPort-SDR: +4APcn6ZV4uHuVQGSFC6j/3mriWS4PoIlyzuSlxxBF0XkqOIMoFyk2j6sKsUpbHsFMhwrvQkOn
 QqjNElmw61d2IyYAEUoPUbVD/bfz8srQutAlkKTWsdHvWGizjeJ4OdRlkukzobD2LdngroPc2S
 DD5qDiIre5vhraW/KLBtLnuVlOcGXw8rBfn3yInraA/9I63dLaRdD0UWh5yL7zUDpXO16bdaSc
 h4ErQZV9oU2C/THafqQd2WIOtvh+aK2U5vzJkW/c97wjnIp5wSdp5v8/0EuSJCci+BoeuR6n1u
 AKI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 12:15:44 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/3] nvmet: demote fabrics cmd parse err msg to debug
Date: Mon, 10 May 2021 12:15:38 -0700
Message-Id: <20210510191538.38306-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
References: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121545_343739_5E6C90A3 
X-CRM114-Status: GOOD (  12.64  )
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
