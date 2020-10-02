Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC1C4727E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FCE206CA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNmgDVIq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oh2EnZlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FCE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+TZKuE6EIQIPXyw3V00MNOOZMXbfYoAMyTM57DBGYYY=; b=TNmgDVIqz0JRxVSwzIfU3+vqz
	IO+wtnj4VCUQ4IK9dXHl9UGBV1cvqWVR9SakDUpNtSYvh0qoxKr4zJE9zmfewm0i+/5Ai9k7sfhLD
	0i4GgfL6u384CnxtRQYlOTEHRGeJ7Gzg+gVWgR2xoqprv49Wd0zEHbrHRU3DBumzmpoo0/vI+2D8W
	+tir1By2B2uETJEKuLPpHJhUN7WP3lYN0etz6tkRuajyuAPV4IgUREKGn3EaPGu69eielqafzvxAK
	5VHf6JDGGu6p+5znPVWDB3K8p10A3yNwwfLqmlLpC4EEv+3U0pS/mNz9+iuK0f3PFMLaHPapxJQQN
	WmSDI+fWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOBG4-0004x3-Ep; Fri, 02 Oct 2020 02:57:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOBG2-0004wO-8x
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 02:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601607438; x=1633143438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d/u/rfZRFriUML9PCM7VSqfroFNcRMuro/i1gWpJ0lo=;
 b=oh2EnZlvHsMsaU40dV5GN8o7qcChWiaDaDH0PyZPlS5yxq1AmNFhGd/L
 paTYQiR44TRm38rBhDVON8sZNb1fuGIjcHBv+iNandCbQtmK3L14p14En
 mFipIt/3PmrrWVQqaH+v3ZWGxTLO6M0sLH0Q2J4kA2Qx/rf7hjCWTSmf5
 AL/V1QM6x19hvb+mJGeJ2fIsAo/csT6uJy7FaobABkI+oBW5pI3XK3mQO
 tDyzRBPMrgf6No6jSX8I7ff238f70wD4NqZHqquGAgTX/JWBCwRU+xdI3
 7eu7IE4VB8kp/YIuRxeMl5SRSILtyNj63OEkhL/3QqNdGkVM7STcJm7BC A==;
IronPort-SDR: 0T3uMmvH04qEo9wVksaV7qjZAluto6ohZTP+slXO7zEcp9OvsHxks1IX4BcbFo7Vwu0QT3Hp8/
 euweAftvmPiu0gRkA74zrDrZwzMbyd1lVSdB2Eu69gvHDmBrciXhcm0x4zwG585PAVKllolGes
 049AjHX//EmGIaSx9Bp2rgvoiQtGl9npAi1qFOVKx0HwAtQ/4uWMnA1DBcFkX7etsq89jqE30I
 2b4GtD8klyz0zrkmgJfhdHXdOvKm+JxMCt1s3avfcoIGPJg8cN0zlRORJ2SHKlTyThPwxs9Tc4
 fcU=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="148784390"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 10:57:16 +0800
IronPort-SDR: O6O0MscpXEeIQ6Ohjmm+xEEyzDx2ZL9VwCA8bEJ9WJX0Ps5hXhV46D5SyKVYieJcfpAW87ra8f
 3iaaBi+XlnXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 19:44:08 -0700
IronPort-SDR: k5WDm5aVsqPyvqNWtEuP3SfLT4SJTIPNZRgNKte4rCngANjvqItrbL2cwl9mIVD3lqqwsBeSjn
 CGNe3JthCQag==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 19:57:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/4] nvmet: allow readonly file-ns to be configured
Date: Thu,  1 Oct 2020 19:56:49 -0700
Message-Id: <20201002025649.30724-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
References: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_225718_465055_031F54D8 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now we open file-ns in read-write mode. This doesn't allow us to
export the file which is marked read-only.

Allow user to export the readonly file by considering the
ns->write_protect configfs attribute when opening the file. Use O_RDWR
when ns->write_protect is not set.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..9270626f0758 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -41,7 +41,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
-	int flags = O_RDWR | O_LARGEFILE;
+	int flags = (ns->write_protect ? O_RDONLY : O_RDWR) | O_LARGEFILE;
 	int ret;
 
 	if (!ns->buffered_io)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
