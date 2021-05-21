Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234DFC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:44:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95298613D8
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95298613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vKwtTOfd6JQRfudZ2hbEWG9wj5jwQmHAH8Xfbl14Hk=; b=DiNOSf4nWc3BGanItyDGu3wlEk
	9dX2HRJjcWZdN65DnK0fks/eE92jjYCq4GTTenMOGqdMy+e1BRbilkmRuUKGqykwVtiBuBhjD34X3
	CGVVESDaDCOgLky3BDXb3+0o6XWaPk1ue6apSTYNv2PitvEkEhn/oD/Z3R/CLjTyQm5Wog0n5aVix
	W//q+OOcC4uBaXAZnkM7XQy9nmPH6v+9gF8KcOf6T/UziwQeu3rb8693viqqKuwDaoR+DkyLfploc
	n33PKxytn1FInd3/BtMidyIDN9s8eGXuEfjDtfu8ipRBC4AtRA5K85/BT4iPKjf8QMLXWesg0J/5Z
	K6FwdJHQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDrs-001HB9-1E; Fri, 21 May 2021 22:43:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDqe-001GtI-11
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=u1ruVdLLXt+35QemckHZzC4Kdvq7uGwJjbXpFh16BeM=; b=gjNEcD/SsHujq+hBYAQAC+nIOx
 2P8IQWnLb65x5OyM9buaX2/07qgRxHcpdPod9EdX4eQQnq6ut4bCqPwS1XePjvOp/e0XgHxrdGXqH
 K42cXV7g0LW+2rK5s2n4dEljuwWBZ0w0e+73dFld9SO+d2kIrBVhjFYAGnNAnduhoba1zrC5yNVgn
 ee7dnZBzWciNwfoekEINhuGbfLo4hWdIkLtvWPdDhRxucpm+lxwXhGY4vElkkhDL7Eqav8YaJEdTS
 wcm3b9ZWnWyZg2alpOPyg4Su0RtoDAjVgpF9xVA77NheHL0OW0CjSZtxe17JjpUzWFsfHjxS2gL/X
 cZMnHnOA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDqb-00HTfb-Ic
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636946; x=1653172946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1w1gszukIB6+NGWwfoUtTFXD9gUf/d5SyOLkT0uElUw=;
 b=gcUfvX5Jpemxf6uw54lHodPoib5xnjSLAN0V/0qd1LI7xPuyFWXiUJrm
 KbDMV3TJLwzq8qffomfcI8x4TU56k1Lb8VPU4EAZB1hEX1FGVyv4dySGj
 rhXCMOV+T/9NuPgzZgFI91MjXIs4cdh8Fu5prO3FDqPb/VteKYOVmpFlT
 sClIOR3mTTBpIVSstLxrasIUhJ/Scj3wM9JbwzBAl06p3W+XdUUaY4l3D
 AQos1+d9j7NOGQjyNMqCMiMCp53tx2EscqkKe54d9oo2yTrb7yUt6nGmf
 G4Qkjng5tW70GnfwIzfdC/JOEFo0aPAOSJl/NuPPoW3PaWVfAe3ILL6WU g==;
IronPort-SDR: fAbOMoL28aDwsx4pKw6TqkWLXrYDwIH082DEgXF/oE55AUW1WCU5DYHNneiVYMIhefpwfgyYU2
 w9IDvFFAbJDN3HWP0h8zc5TK/1AMzRcem0v0c2uNpPYl/UkWU0l0DKLOQIthVi5wr7mGrbsbNg
 Yo/5aeAztB8bNp4NqNVCw/vhAxU1pHdsntLfcfHD1jC7s5fVfL+QmWzEMZ+dnERljronY+pufX
 Z1x2Ge5XBTYj9bm8ebn0TD0jvjEqc2XMrVWkg3ARq+mz0PDoxksYQSRv8q9diuS8YL0VCQK3LP
 Kj0=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169598968"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:42:26 +0800
IronPort-SDR: 29DDS0zPsa4JY3IM+zoXILcJqiH1rBBfcaDxTZxH6Rl/nr3ut3g4kXmTZv7KQc/FrmOhx6YRLH
 8ikaK6H+xtZsFzuqlwQ1Bzfhtugfe1EOl+epx2xXcLHGp7QslcoZCZAk2/TWyGRmjp52ZcjA4x
 SAgvNQvOTS8MzvlbihZuhU3NaLIu3yL65m9HhLO10a+5z/i3+4ZMSQRd992IMIvu3yCyZbybts
 o7Rhiv3GiFJlXsYSDj4hFMf+igcQmB86Iwr5Vzh5JajicoqhTkJw2NGmP6A46s8Oj7PTM5iOoW
 XMAkcy8HuEW+gL5pW7fPczCk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 15:20:46 -0700
IronPort-SDR: iHewtkMT4DN5CP0bYBbDeC7ZZxnYOZn0nknJQU5mv+Zr36XPc43I6fERacZzwYQq5aBdIjn1tP
 lsnj355EANqBm/8sVVcTaUm8EfqwRcps+8zw7/pOwlBnOjjvCxKR5IQDUsXXg6s9lWJ91VA79m
 HQyitlSbbOAwoYfCZLwBaQqw+vGMGWSCzuIk2Ra07wTRDWUqO6GChxOQSIJ+c0R6yUp3wLdfa3
 KcZ+k7Zr4oj4DdQoznVuNVqR98V8ud07GbjtvuR2c5n25/65egaleQQ2BajkX/NrMDgsZpLwtI
 TuM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 May 2021 15:42:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/4] nvme-fabrics: remove extra braces
Date: Fri, 21 May 2021 15:42:00 -0700
Message-Id: <20210521224200.7380-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
References: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_154225_696020_08A020F4 
X-CRM114-Status: GOOD (  13.06  )
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

No need to use the braces around ~ operator.

No functionality change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6bf775c7fbb9..9eb88ef409fc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -268,7 +268,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		int errval, int offset, struct nvme_command *cmd,
 		struct nvmf_connect_data *data)
 {
-	int err_sctype = errval & (~NVME_SC_DNR);
+	int err_sctype = errval & ~NVME_SC_DNR;
 
 	switch (err_sctype) {
 	case (NVME_SC_CONNECT_INVALID_PARAM):
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
