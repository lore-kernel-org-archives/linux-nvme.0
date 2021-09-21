Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39ACE61002
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39ACE61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2wdDYdODK2m+bf56EsLFD/kOjQ1rNlQssrpUNFCJ7co=; b=KfHRk0cspod2In
	lW7sa34rRuG0Cj90sFCr319OYC1GqhcQ41vvlOyfbRXe79VPRt+ocqRybazFgS2H6KCcosecOdpyV
	kds9M5+JCXkI/vf6PKNsbgYBbbbfGenoOPYHACO29JHoLPnlDe+9Sfr95wnNi6+3lee6oH2nfDH2b
	wr3vOmCG0I9NaLMU67R7hRMeIT95HP5SdXKTqso3XRq2mjBsrB59sNUVcEvOJfU6JTQhsC5xE5U1x
	URjf9xfClRpu+stBEcfItVEyOZB4/tusfTkQysq2JD0Rh/kZBfcYoQQv6lqgz2D8ci3nGb4Vi0txw
	2qupgFcroe11yFIVmKmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mShVM-004rFi-BF; Tue, 21 Sep 2021 15:16:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mShUn-004r6N-9Y
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 15:15:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 752581FEEF;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632237341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKiMiB+uedWZeccfphkNViNPXb+r6xQVS8MLz+Dn8e8=;
 b=TIaDVZ1mnGEOkE5o6ZyF28COT+wVrtjLtSIEqDwEIPNZFbqvM9Torg868faOzDnRWnH3R0
 YWsZhiAS6TuUGfiAroufouLeLbnADQW5FvuyHEV9kNZEqatbFRj0eEXn9J+f90vGlhIQ/t
 5lmdR91Dl725E2y53xK05wvy/qLCZ24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632237341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKiMiB+uedWZeccfphkNViNPXb+r6xQVS8MLz+Dn8e8=;
 b=WgT5hEiT2O8DoarOhK0E7B0i2VeWaHRwI++5iWf07k5UrYxuzu+B067QewGuCd4ykYbPVw
 QwMZmsUYV6ONhOBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 44598A3BA2;
 Tue, 21 Sep 2021 15:15:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 72C4C518EA8D; Tue, 21 Sep 2021 17:15:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] nvme: add CNTRLTYPE definitions for 'identify controller'
Date: Tue, 21 Sep 2021 17:15:25 +0200
Message-Id: <20210921151529.29419-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921151529.29419-1-hare@suse.de>
References: <20210921151529.29419-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_081545_524552_B8542002 
X-CRM114-Status: GOOD (  11.76  )
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

Update the 'identify controller' structure to define the missing
CNTRLTYPE field.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/nvme.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..ed2428918bca 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -31,6 +31,12 @@ enum nvme_subsys_type {
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
 };
 
+enum nvme_ctrl_type {
+	NVME_CTRL_IO	= 1,		/* I/O controller */
+	NVME_CTRL_DISC	= 2,		/* Discovery controller */
+	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
+};
+
 /* Address Family codes for Discovery Log Page entry ADRFAM field */
 enum {
 	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
@@ -244,7 +250,9 @@ struct nvme_id_ctrl {
 	__le32			rtd3e;
 	__le32			oaes;
 	__le32			ctratt;
-	__u8			rsvd100[28];
+	__u8			rsvd100[11];
+	__u8			cntrltype;
+	__u8			fguid[16];
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
