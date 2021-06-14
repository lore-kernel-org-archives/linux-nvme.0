Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D1C48BE8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B07E613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B07E613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZHRL4rEyO8jf1fIp2gBhn37/5oVPJE0SwaW/zlMxI30=; b=Md0rQ5KFaYLG5i
	LGUGAw2N0mD0P9ASxu7FxoxaT2PEiAW5Jk3q8b/xIfDblMlf3kCxfe7bVj01aiETWBuYj/eZ1darg
	HxUWO0QULDGPGdGY5GkjVdArvfGUFYGt1xBsJE0z/pQzTnuv31DQ2ySleb6ILNcaNqFgpYobDnv2y
	0YzeSut3SJeX2dmFBFQw8YDaXjlS7vpaX0JDFm00DjsLN3nFC7Buk1lFsQCpU9X5WQ+jmb8QQ10SC
	Rl14CVrscu1g6F4whutLzM7eJ/UrN1sXMf7oKHpoOZKa2RdRy/o0ixB42A5RVJDDBDbN96NGxgxwD
	EvphdafB6PeNW83bku6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbt1-00ByvW-Si; Mon, 14 Jun 2021 01:59:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbsj-00Byph-Bo
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635955; x=1655171955;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h8W51nc19wg6DruuO5Lbk+449/nFLH/gQlvgQoE1WsI=;
 b=TTNaxuSmvnOlRDZIymhOuuiqp5YJ/FmBvpL7GpfEH4vOTymKagd20o/3
 nxoOQqIcKP5zlr2/X4tim0X4BmbM+cLEBAuRaWjXOCrj/SOffwkIjPywI
 7UE+d1sYXW+9A2dVJscgf2wp172/QrDeayubAtX9715I7C3wdfrB68vwc
 hwhehGujMB5MzG1WA3H7kPYJ2OyMv8tK8Uz5LUBosOkH9E/uzNLWes2KY
 Ihq8LcYZ+tBaONiXCZguaITbFzy7LvoatVS74NChNW+kl7PMZOAKN16Gm
 6LCMM3InAXX0X+Fa/DhrNVo0E7ade4PjUi2cYdltG/eVFxTxhbe54GvW+ A==;
IronPort-SDR: ra9d7VFFgRTJjk44IVUggqQvYVPz/50SJBpuglPt8zsbW84Hz/GNa4C1lb0nXUBzi+B0DQuvJn
 JWR689WdV00dUpfPRY2VliWUsPPfK5FUUVV8ODUIcWa11dHq43PIlZPrMmHX4OVNzvajax4cRK
 87PgPuv1U/POOB6Wg3XKIIzw7AiMHG8ODHSCYjUy8ImtCIqXXuaRBY+2OOncdCru6GW0VrZvz+
 mix1LqtKhB40I81jUu6MHMFgKlwll05VKYECa53z93C3m71YC7824E7Y/Jbx7UtGzIETe7QO2n
 pHs=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="171776439"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:15 +0800
IronPort-SDR: nat7+aSroY2FIB+8p37AOPdsiA96QaW6eam8YmdGKTd3ah7/Iv+S5e8pK4n4q9Is5PZNLdjJmD
 EF1zYv/SsAy+u0S1iq3PXFDKrXW4F/dtKvgRRuty50b5YTXgcYK1rBYEoIlSdeyqoOpRijeU3E
 yoDzR0Ah5MXl/jIsh9WLTrhNaJlC33RCNUe7BQ6bpzK15Da8900RKHsGmI9Gi1i8jh7foy5hPU
 SltOWf2nkwIHNwLxbYdfSzznm7u7NIXHpGZIzawRWHCWIauNxhzOj5fuWxvMVY1q87azvol+IV
 5aaGJR2NU9Wh5MaL8AqVxwA6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:36:48 -0700
IronPort-SDR: 3D8Up1M4Hh2rzNsSpA8N7BSoF9sil/F4Rf+fTL/ScxcGcpYT27jonBcU/EWgHWMWgWgu5irU9C
 A26pML1RrNB+PA6FtcPMdWLuSCysnk3lu0w1FJBihKyYuMOQUpA4nWxDGsUnqg4QwhegSrs8xb
 gR9sKubs01WUhqpvtL54vCj/bkcw1+UOWPdDYehEJ8/m+6HrAHN5xj34TX0tWXn4+z8pJGRA3/
 3o7k07awNL3lOMbZFKss0ddlJCcFrHo3zRJVEbxsqYQZoJI9BEUyQqlPnV1eWPwACpoV1rfUAe
 iCM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:17 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/6] nvmet: use u32 for nvmet_subsys max_nsid
Date: Sun, 13 Jun 2021 18:58:48 -0700
Message-Id: <20210614015851.53925-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185917_440462_E1C141BD 
X-CRM114-Status: GOOD (  12.55  )
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

Use u32 type for the nsid_max member of the nvmet_subsys structure.
This avoids the type confusion when updating the subsys->nax_nsid from
ns->nsid. This also matches the nvmet_ns->nsid member.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bd0a0b91d843..3468f25cb4b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -218,7 +218,7 @@ struct nvmet_subsys {
 
 	struct xarray		namespaces;
 	unsigned int		nr_namespaces;
-	unsigned int		max_nsid;
+	u32			max_nsid;
 	u16			cntlid_min;
 	u16			cntlid_max;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
