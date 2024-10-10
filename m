Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B998CF11E9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcmf7w+OiwLmdPkHU7Tj6zR6S+No4edofLVh/f0x3GA=; b=zjTTq7KeDWccCtkyLKBWLciK0S
	qgNus5F0R9M8aT7QDeJU+5608yzZEQdhxFy/Pws6uglM0UMxV1SZNly8T5wEYo1owqTxLJYuZDLFM
	tUbO/8yxvNsO0UCuR2DsLNvPBhUveSI9zWXtEySEoXggjYecHxDeYblgKpuwSDVckmiwdwwGsv925
	pG+v58meZvXazrVIwR5puk97yS6jZsW0dPfx1rdWVCcZsZlAtnfXyIdZKZhEWwAhVpp8Sb91N1kje
	v/0z6Ddg6nRLRSeVIPmagInMZYcSbsJfeaED9W2teyB62c5WkoZ5+/ZRcLQBQfBmvU+2KKo12AAPH
	O3ATuY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sysdz-0000000CnLc-1P43;
	Thu, 10 Oct 2024 12:51:51 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysSg-0000000CkF0-2Dyl
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 12:40:12 +0000
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DA27113805AF;
	Thu, 10 Oct 2024 08:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 08:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728564009;
	 x=1728650409; bh=wcmf7w+OiwLmdPkHU7Tj6zR6S+No4edofLVh/f0x3GA=; b=
	bHzeC+7M0VPl9BzJsxdbjiI8R2st+LE38rIRyWUZaVMWTG3rA5JPQCj725gb9c5P
	YjkRTnzFXwRV1a37AYcVeX+u47WgE7rhVKVO8UM8EVuS3wYDIbM8RnsLlHvx+ABY
	nTFJlauK9CzsH3xPq48oKWNSJ1mIcE2G6Oby9ud6chi6SgSPMxAs/cNwwX8nonPQ
	G1KKNFvRtiNdH+Ha0VvQWe3+f2qH2osOemXcuLR2v4Meji9LOFxziATL8n1Wu2RK
	xAh5Xe177XF+Ii6efpYut0MQ6JVYp6seE77kj4jxVY5+4bX76VkI0e/47SfNwCNM
	v4DFWFiMfehkxaPE4ieNsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728564009; x=
	1728650409; bh=wcmf7w+OiwLmdPkHU7Tj6zR6S+No4edofLVh/f0x3GA=; b=L
	LAxc+ommX//Ps7YDuDIu4MvziG6IKkpGhm+EDZ6TGHBOkfGf86mThYcgDaYctaK0
	KehTSe6YyzvcsC2U+okreQO8VzPBTWGRgK3fbZ9GV3FY815vSVUY60fAu4ZFJIMz
	QqDhi2868PItn7WWnlz56WOZ7wRkPBWxZowrypVCj/7Gn60WKCz4G1IPtXPvS7kj
	eXzRig0OAaxEMvo12qkdL4KOkdIXaQyKLX6kvHGJ2gf+Yc9kzvgi/hXh51EzWexl
	/ma+KzeGNJpx0sEC0aRWMqVRrqmyEZpXAPzLXCv7Zswz8ejXrE/SGWRiySc8FRsk
	lKslYgQDjqL58t7JuptBA==
X-ME-Sender: <xms:KcsHZ7Qi_0oVYie0HPRdXWr5Nnb1svYgG2-2jRQ9QVvErygU9o5U7w>
    <xme:KcsHZ8yatYU9rPjBNFWnrd7pZwMwb66akCUueUTb01feZPbc_Awm5NNDcYTfCx7W9
    JbguGSrmzldkuBXAlg>
X-ME-Received: <xmr:KcsHZw2J1qrOzF_XjOwsBEA8cwhJt5psxygtpxaNzNDNM4ON9WY5pJO3FSk8THY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhl
    ihhnghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpeffkeegvd
    fggeefgfffteeghfetteetudeiteejgfevudeifeelffeuiedvueelheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhngh
    drmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrd
    guvgdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmh
    gvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    sghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghih
    uhhguhhisegvudeiqdhtvggthhdrtghomhdprhgtphhtthhopehmrghrthhinhdrphgvth
    gvrhhsvghnsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:KcsHZ7B0WV9Hp48ghkmVtCxnyRmNA2x6fOP-9TlmJ0v1LI9YStfvVg>
    <xmx:KcsHZ0iTcGYwEuZaYBs5eo7oZ_97cPTm3O9YpG-or3RZ54X95m9jcA>
    <xmx:KcsHZ_oBiHk5pHnZ-Dt0c1EOsjtI4IP4vddBgVqWHDDlQ_PIAVTBBw>
    <xmx:KcsHZ_gExQHojmDv5fWjRhFy_Np1TwveEPsWXa5U0Mkb3RKcZiKEmQ>
    <xmx:KcsHZzqHas9WJaJMOEW1ha2J25bz48Al_MPRt0tlsBA_jMANvEap8DvW>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 08:40:07 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyugui@e16-tech.com,
	martin.petersen@oracle.com,
	hare@suse.de
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/3 v2] nvme: make independent ns identify default
Date: Thu, 10 Oct 2024 14:39:49 +0200
Message-ID: <20241010123951.1226105-2-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010123951.1226105-1-m@bjorling.me>
References: <20241010123951.1226105-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_054010_735706_503346E8 
X-CRM114-Status: GOOD (  13.00  )
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

From: Matias Bjørling <matias.bjorling@wdc.com>

The NVMe 2.0 specification adds an independent identify namespace
data structure that contains generic attributes that apply to all
namespace types. Some attributes carry over from the NVM command set
identify namespace data structure, and others are new.

Currently, the data structure only considered when CRIMS is enabled or
when the namespace type is key-value.

However, the independent namespace data structure
is mandatory for devices that implement features from the 2.0+
specification. Therefore, we can check this data structure first. If
unavailable, retrieve the generic attributes from the NVM command set
identify namespace data structure.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..9cbef6342c39 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3999,7 +3999,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
-	int ret;
+	int ret = 1;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4015,10 +4015,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+	if (!nvme_ctrl_limited_cns(ctrl))
 		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
-	else
+	if (ret > 0)
 		ret = nvme_ns_info_from_identify(ctrl, &info);
 
 	if (info.is_removed)
-- 
2.46.0


