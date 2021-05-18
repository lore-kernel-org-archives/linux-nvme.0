Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9997C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:07:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2746008E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2746008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2nKCy0cNHbEv4nxBUiH5CAgBYXanRm0PvqLXYAaq4xc=; b=X1DgvKKagPd+1bDGKs4IB+pvJ
	cX+jxAYd+YCQ4zLoof/ga4OGUvLiYYSX995cfs0ZC0+5zCqEW8xB5Bdvw5dsuCJ57DztwgNFWh2ge
	MahQumRMXZDLDNQ8+y5eDyWLhAxHAWTw0sq1zUBU31hdwbZKhoBrpt/jjvvqHnq6uhRUc7e0nsJn3
	Dr7H/IRjtKOZY58AkyxrVPHGvbnrK30VEBK5M1OQKr4D6x9/tpKocxLUNdX38B5TX6eghbdf55FXI
	Cw3l8SA+BgZyDUMM6HzkkRocn3gJ0ky1RqjjK8YSlU2FOPWr8VsQW0Jfr7GNMbYTR0qFo0dgeYz89
	ykN5o+XDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirwI-00GyL8-CZ; Tue, 18 May 2021 05:06:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirw7-00GyJV-GE
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 05:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=GKJXXUBifVniRSZdbgEr9B+IRgeOTzggNs3o0WiyjPw=; b=igwW1aQ93wszeM8HFIBOk8fwob
 xi4WI+c+2blSrI6ILh7jqQp8o17+S6bP5xVQucjkPNJp/KzwtGQwP2lEXoMMBvhxiD0gnjzCcd91M
 7xkyXbIbzIbgkpCNpyl9NdE08MXzT+MRAxDga4JtyBo6MiGLqjmqVoIYbH907bXTeyIfEA1Y2+sEE
 iqD5MNyeUFYXJF6OFZ83+0FLTIGt9o180Ugy8E2BCV4+QR9MdLdeBlArOe4O9OGnO2OI6A0+VNNym
 Rocf/blHAr1J1Zj2BKG3kDcK+IESq2GaN3vJNCAI2EtBv7uJ7kcbDFp/veqBIXqTLu3oAYzE8Dr0P
 b2fK12uw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirw5-00EJcZ-6e
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 05:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621314389; x=1652850389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7vaGJ1LIbuqG1RbzQzrO3QEfZ6bK+OgkImpXeug51c4=;
 b=bIDZdouMGA/MBUbN83Us11AGntMgQyjj3aF1GCfotzSndi/3pzOXv/Hm
 QgHCoTOc+ECUV+G8dPFcRaIaFTqHFmbSuM0qyn+8lyoVeowelRXkQy3E8
 9+YpV/xD5RGh5SZCtG6cMTYTWcCkPoICf08fZ2e0M3stMY2nE1V1IIXza
 lfn6XsPdF+rNl9wbw/ubCy+i741yw2Soh0uwrFFDv20N99WrBWFJK2JUC
 T9zAuNjXSfl14YOjOVWRu5I5UXLRAB69J7z4yDsM8jPQLRglGkPyfUrzW
 dgxoJCUWCVecLdnNU9F67JpqWbv2/HoPtX6lDCagRJEmsuGXB/IXbUZ+b Q==;
IronPort-SDR: ughJo5fupCoKMMFY/G5N+BmAvZoY7BaAJleBVKaWXbcDdWrGc1SlEs6PTDC1z37AMlOKG2lZFf
 ygMTa/mW3XhDeFt6omRA01beDUVa/aoPpHusx4NkQxjFv90CYVrICgkyHOtL3S9qiDlj++5DTq
 Rk/UDMIyXdbegfIsDAj3kTpSu3797jIUOjvsOOTkvQuSM5neQs36FnX6CMBUMx04AouFa5IDg1
 K2KKZxXm0Y6Ma88gYDWJdV3JnyO1B48DgOWQK6qoe2BwxJlCAWt+2DBhokN3xjDbEa78+uLcx+
 rTw=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="279745041"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 13:06:28 +0800
IronPort-SDR: aTEoZum2JA8gbtihhPwBn5OweQ2Bm3nyYXqZevJiS+Nlb4e60v3XCYpSgXEpGCPdV3QrunKehe
 wEHAaIKkLOGAYMPLZxyvdaR2Qz+k3YtGn/PJNrPeS6FZg+3WNLvSA1X5YAGAC53x6pyU9Lh+Mi
 bbWKdAbi8X/YQVAlUrpvFa65ECijELSNpo1uSID99yfUjBc58pXWdkwNV29TzrsAgoePA0h/SY
 YTaWbt0450/nA9LIkmLKsq2CSkCImEkcosheqaj5xNu9wFuCFHp2RdDngEZWxwJJrFbSfmUHLO
 qDGdN2v4cWm3O9afxnjjXTV9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2021 21:46:09 -0700
IronPort-SDR: 07aUvDR4eFRc6WmYf4kYRofnHVyZFvVt4iyIBmcI+VDU5+c/yDKYT8jnORD6sI98TE5v9aKCOQ
 JZLgT3w0zDiutyMzhkm9WlJbpqFVr1aZ6aUpsr7htpczyu8v3WyLVmCMJl5L77SgjHsP0Sjin4
 QafzEH/IR0mgZ6/g63pKUSjz191d8ruMlDn3Ogu3iuut0DEirsl0RMQg1VAOIOUkQP9QMs/4rX
 NpC+bbdLFkoUa4lERJOtkrtTOqRcGtCJlaGRvcQKgJdS+iMijkTNhU7VbGkUbHbMSNoFbF5vXu
 FRI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2021 22:06:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/4] nvme-core: remove the NVME_NIDT_XXX_LEN macros
Date: Mon, 17 May 2021 22:05:57 -0700
Message-Id: <20210518050557.14961-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_220629_264936_047C01DF 
X-CRM114-Status: UNSURE (   9.55  )
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

Now that we have removed all the open coding of the NVME_NIDT_XXX_LEN
macros, remove the macros.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/nvme.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5d6b0fe64db1..61a0de4bb71e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -486,11 +486,6 @@ struct nvme_ns_id_desc {
 	__le16 reserved;
 };
 
-#define NVME_NIDT_EUI64_LEN	8
-#define NVME_NIDT_NGUID_LEN	16
-#define NVME_NIDT_UUID_LEN	16
-#define NVME_NIDT_CSI_LEN	1
-
 enum {
 	NVME_NIDT_EUI64		= 0x01,
 	NVME_NIDT_NGUID		= 0x02,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
