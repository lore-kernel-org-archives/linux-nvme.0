Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4FDC47095
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085C861139
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085C861139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yZX/BjxgaHqLFuybB9kauFbgI0JXTOHYxuuU21ockwE=; b=J7wQ1P4lnUPK89
	g89KZm9I5njV/D9Ad9oZHij+e+hegpbvSb2d/1KDzQkIe9Q4K/wJURRyv5cUX8LrMvb6UkN1SqCd1
	A6u/1bZSU/EyOzJ3zhSZ9Y5IiDuo2bAC/PKa/GIX6jPPwERqdSrSy36OWJseKdDc28flAbIGs90fg
	xWll4ZV7AwuzrBqggSNEfdgM75s5SmkzQwjxZOXU5PJj696R0WxCwkZbymn7CO5eEhi10DqkbZLe5
	njiho4LejuFqbpD83s+nM0oWMXAxA7STcTySNDYN0oi4Ou+DZvemteFrs3fmefb1Gs3UOI+LcO/vM
	v46qZRwhxfmkMVgs8VKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLLU-005DLy-J6; Mon, 07 Jun 2021 19:55:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLLD-005DHD-TZ
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095718; x=1654631718;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=auKenYFdvCBOgsGw/U2b4lz5FF0hWuuXQoZgQMgNJDw=;
 b=UR1t2MUdXS4dfN1JN5Nl57ZaYOvT0+mmQ7Ot1pFjseCjb/35r8PRtMrl
 vIShfsyo4RMzP4qp0LSKfh1rGqzXfBG1Ae6tmyxoMhalUHaRD8nV8AfVT
 U77UI478ubUMGM8NjBp6tMBu//xDNpDpSw64qAKfhi59HhOiVtiBFv6Hw
 NEZcK8QQWcYCyBW5HzrRsjE/wuOLU1dWOBWtBW+owsTtvYS/Ac7//Ghl0
 MGIlu6eoOMYpa4IrcmedvvRFEcKsyYTc4RNrNrKiexWFpcA6oktRnlHYr
 W52GJFFBmGoGOfEwJ8lUPjdsi8kTrM51fMiTzHWhQYXENV/T8VOnaOqG6 Q==;
IronPort-SDR: vrd5Xizudtf3PR+a0NDGZ1EBE4Qmvey/jU/CFaqVRx3r+FIqB83K02gxTbPxyAhR6LMmE8ugJR
 TsuYEcW7EqcOztHQM8Rd+xnDQeowZXpmMNhkSrKRIX/cFM9A/Md0q9MqlSKXlsLWq8NXjYd4Vb
 w4jUPUnDn/juLsKUhYb8GHM+JtWwb+RrBhsglKiMPM2sVlJvkvLbukQ2TCLHeZ2EiLykSqsSQA
 Fun8R3wr2YNZ+YgMtFlRayQld4hCF/5yhcWIx0h3p6GiBhajGRN57LITv3dpOzvsM5R0g7ooMS
 eIU=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="175810470"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:54:58 +0800
IronPort-SDR: iohbd1p2bparPsKpBRrgS+7Btg1fPUKYjFOJUefFxGZkiaj0d+dnbb/6ONZmI8cdZJIMXqZ5ci
 v5Il4AU+FrbtErxMyXFJGImA8ZVQtZsx437PtvPKqZOY2Ot87s4Qmm42hT3tVfo/rJHensGys2
 gUz2LimuA/wnwcRFDafXNOmqkUCdDMWWpPSVh5nh7aG7juPo1NAeqehoDHg5LKtVfx7z6xEYqU
 9IFbZom1+j4dTfb4vwGtVikfUE5i05BG8ySGaip2Cn4OGyDZOsMGG1gG9RUHNF+10/hP8V0ynD
 YhtFAOx0goYa/LssVUPdjyXu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:34:07 -0700
IronPort-SDR: 2o9yY59XjvWwQtMWPDj8z+5zisaKEbbiloRU5O3Hc86ByxwykbbIFaIGenvXBbUS0CEfsI5NqP
 rXs3qYxSFSHCo2qFNsw/NxiAQFaWVpUazxf9sqglRZizXRO+ia3yK0MyPU4bL13khAIakpJk3b
 Jh7/ct3IpbVNbm5ivlRr481Y43Mhhl1sWjvXjETh06BITZ54ja553jZ492sj1opij1yVrWffqf
 ddXJ/LIuTqaBXgoncl63RQmUhSF1JGhHEQDzxLug2cuCSVg6cVIOnnTG4QBxdQYOY5IWqF+Jwl
 06c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/5] nvme: small cleanups
Date: Mon,  7 Jun 2021 12:54:49 -0700
Message-Id: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125519_979353_64818AD4 
X-CRM114-Status: UNSURE (   9.37  )
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

Hi,

This adds a couple of helpers to remove the duplicate code. The last
patch removes the exta white lines from nvme-pci.

If this makes sense, please consider this series for 5.14.

-ck

v1->v2

1. use nvme_ctrl_sgl_supported() helper in nvme_map_data().

 drivers/nvme/host/fc.c    |  2 +-
 drivers/nvme/host/ioctl.c | 26 ++++++++++++++++----------
 drivers/nvme/host/nvme.h  |  8 ++++++++
 drivers/nvme/host/pci.c   |  6 ++----
 drivers/nvme/host/tcp.c   |  2 +-
 5 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
