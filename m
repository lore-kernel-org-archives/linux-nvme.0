Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343CC761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q27vNnSpV+NZayEHyB85l0ahKa9r12IXaQeDywpTIi8=; b=ymeP87d8hfLMRLEdfSMJfMsSSy
	TzfkWxqNLF7tNsp6GBU+EMr1SHrFygV6b+SVGCZR9EqoaauXJRxzc7lOMtcxctpnFMZRoKAHjKc0v
	Iz7a+5ubZkYHW2iwHvHysYog+KpW85G9ocrGYXOXEWOq2LePf+FLBDzA9zD+zhdEpG6oxD9rVQm2A
	gQPYUp7g+Rm31CFOHCqjGa07bEhrHWHZq6ATnAIZ57h2klU7ChzuQ1MqQ1w9U7slHGAjbSsQYHzP1
	OZkBfBKkO7g10+/MDViU7xs0kI+4WaZc/Kb6stXkSem9JK2yNXfTqsS8hdn6ZOAcxFQ44nwXSpKjl
	DJaEs02g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrN-00D8Cb-0v;
	Wed, 15 Mar 2023 10:59:57 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrH-00D87t-1u
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877991; x=1710413991;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TdWHUhWfDuHGy+YA5ALlphc2i3ijlHhSYD6y45I7fw4=;
  b=I0cgzt+nB+Fs/qESvIgIPWqQRoJFzMQeyHwVHnOsloaHAkiFWAGrkKwM
   x2428fu7rCK6l2YMRj8NPF6HYreUZhsTBNFT5fzg47RRQnyIGid3Q5r6G
   ibyZXsvjh5SjRd0ihuWDYZmWwEhrUN34R9ntVX8bGLaBSzZh0vu8TzKJN
   KmTqXiG5B98BX6SMXZ8wGZzePbk/tLUA5W3yW5t+II6lZHq9b1N+/Zuv8
   nZI8t6b2IHgkdeKHCWSTK3D3kIYEbNByrq4ngElvsh1rI8S7DqjU6wtuz
   mtaosd5F4inYFrbzN9mq8NW5lNccni/KF5Ej2lgWxkNmJuwryU7ePKfQC
   w==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:47 +0800
IronPort-SDR: VauqpTc2FYPgqHqDbv7wmysn9/8+cylOYdQXpLDi9eLYLzcAFa12rXWNyVEenDRbWokSN2mH1f
 tzhir947gRTmB9l/B7MY/FnxEPpbREFypYb/fTpVkWxSHdH5Q1VS+jTK4jwc9+pbpydMd/4HH0
 RpONlAVYKAYhONaiE3YsUC09244Fgq4Z+18vHM1cFE00WkaBONOcAIgqBu8eMD88xFhmAUoNC5
 nb5BEZwikFYpPF23DQPpXFLorPM6hi8lmet9fG7cjGK2/nCqkMB88izwrmYQQi+DPr6O/Vf3ub
 f9I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:14 -0700
IronPort-SDR: 8WT9c0W5fkyur0l7sG5wHMarNPr7aMEXRn/iwckWpd5YMwaJoyaUYVH23XgwfXJ5RNjMBf03Fc
 /FQiSmS6rbW9LCUOIAYDprmbaMmpgAZ5F8dadgbBya6heFW08j6FeYNYuxSll089zc4Lfjcxze
 /+LdTnSZKhGk85aeQFZucPkixb/ZhHfensOrPuivWwJ7tALeZzTRxcWd5N9VlWPLiEp95dEUVk
 UDA5lB1Md+Ldkw0CUwNOYXgE8BHKVJK1I7Gja1xU4ORZfGdO42DKFZYYXDZsfl6EYYVS+DS3mB
 tB4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q70mHJz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1678877986; x=1681469987; bh=TdWHUhWfDuHGy+YA5A
	Llphc2i3ijlHhSYD6y45I7fw4=; b=MLw1BBAtyZC14/29GAUAW2xOlLy7lP0yct
	ddkUN/6HKDIuseEXqEzcSvA60MPhYi8y6bkBWC0+1KfMbr3a029LqEr/Kx+2Ht9V
	nsKYjf9z+jZKWpHm6k/Bv0lWEtzgf6H110k+f+pkbseywJVrHRWHIqT4SQ2HTIqI
	E/sxpxqbHoDeqw+yLs3lSVmxWNxItAUqr/sfQlBxqH788MjyiUc0/RHqYpxLivDV
	Wn3mZ77AR1m65qGAXjQhY6qgCA5G8ZGmrdSCs/grEMPTr6/gDFp31HoaoWcG7WdC
	PNzKWxOYlOeHkv0nv+DY0tdtwBNJrPJ9f0WhbXojvLIxygfV5Teg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ohAwATaI7-EM for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q602lFz1RtVn;
	Wed, 15 Mar 2023 03:59:45 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/5] nvmet: Cleanup nvmet_execute_identify()
Date: Wed, 15 Mar 2023 19:59:39 +0900
Message-Id: <20230315105939.305825-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035952_103146_4CE3DB19 
X-CRM114-Status: GOOD (  16.25  )
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

Change the order of the cases in nvmet_execute_identify() main
switch-case to match the NVMe 2.0 specification order as defined in
table 273. This is also the increasing order of CNS values.

While at it, for clarity, make it explicit that identify with cns set
to NVME_ID_CNS_CS_NS does not support NVM command set specific data.

No functional changes are introduced by this cleanup.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 545f98b2cbd9..007064aca179 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -684,19 +684,28 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)
 	case NVME_ID_CNS_NS:
 		nvmet_execute_identify_ns(req);
 		return;
+	case NVME_ID_CNS_CTRL:
+		nvmet_execute_identify_ctrl(req);
+		return;
+	case NVME_ID_CNS_NS_ACTIVE_LIST:
+		nvmet_execute_identify_nslist(req);
+		return;
+	case NVME_ID_CNS_NS_DESC_LIST:
+		nvmet_execute_identify_desclist(req);
+		return;
 	case NVME_ID_CNS_CS_NS:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			switch (req->cmd->identify.csi) {
-			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ns(req);
-			default:
-				break;
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			/* Not supported */
+			break;
+		case NVME_CSI_ZNS:
+			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+				nvmet_execute_identify_cns_cs_ns(req);
+				return;
 			}
+			break;
 		}
 		break;
-	case NVME_ID_CNS_CTRL:
-		nvmet_execute_identify_ctrl(req);
-		return;
 	case NVME_ID_CNS_CS_CTRL:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
@@ -710,12 +719,6 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
 			break;
 		}
 		break;
-	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		nvmet_execute_identify_nslist(req);
-		return;
-	case NVME_ID_CNS_NS_DESC_LIST:
-		nvmet_execute_identify_desclist(req);
-		return;
 	}
=20
 	nvmet_req_cns_error_complete(req);
--=20
2.39.2


