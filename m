Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED53C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF0120789
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IfD4P9mw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H+hZ/hCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF0120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KOFkwW4GD5h14XItVU/sT23AUomxwSagvAxonCEUSY8=; b=IfD4P9mwVNbilsGa6QMVFoR7f
	e+NiCDe2N8y45GAPk2ahIy5VUcTqkDHHsfZX0zlqwAoQ2hSwUmVdOOvU9RlTguiWWjpTq8ntokUc7
	vfjtBHDWJAPpN1pj5O7enlNnODwF2rlFW4cYlUtDjz/kvt82UbFVM5dqQUzDRIR1+VvseMBazCTJl
	slo5c2eBLa0UpBE1Qm/Ip2E8s60d1s1S6/G1w0vq7IfB3jgJ7cTNp3gKleV2+wBV5S6E4dJtv1hGl
	/uBBkOZDm/35Hj2tYdiKfb0Ej13i80pGTbn636eBTkHIlrVFyY0jmiilfChy1It70wVAsDjX2iFzh
	Dm7fRrBXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcHbt-00020g-Th; Tue, 10 Nov 2020 00:34:09 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcHbr-0001zv-GU
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 00:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604968447; x=1636504447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hJyI1UYvjxxbiNsJEDE/zMh5vNp1iB+8yYDqGvRjq3g=;
 b=H+hZ/hCzHUxg6zFlIryMfkpz1yZJk/cAyqtjpAnWTC1ef9zofBzMFrvl
 CH1h4vctRRElgReK5ofONerSB3j7byVnNbV/NDA9xCH5QlbFyfLJt04OU
 Q1J5iyguW9r5+RjaSc7E46NfJadRPh9gyrpig5aZ6YWpq4xtKZ9Zjvcf5
 kHHRXT1pSqqtlqgq4nwdqbSXIDY3CxG6oJeE9zqsc5Tc2JioDn3E6Iq4I
 rZlOBEUXmMGI3VskGRptSuw+Tmv9GJW4+MVz0yNfMNqstl1UMeLM+6sjW
 axX1nks91zCMM7rfV3OwCeMU+5TfkHIdiqOeFO4LOJmirq69OZB30+JeZ Q==;
IronPort-SDR: 3c9XrQits6MrngI/BpbyVJVdll7zbXqM1E7XTKv6F+wQ74r2BdK2oOehraju0RB+djZejcjPfV
 94fieTYjkmtvOqx96FuYMl1SVdsKFM5PzDBGcTOxL0seTN4KIoWRkp5iGaYE0r1RXqVzcxQVAK
 YBa4Kf9yiFsfQduXpwNJ9bS9KSQbJGdsKaCAmfsue5b02Agd1t//YgWSWbiFvtM7ni6VlnVIZf
 VT8qeEFw5pUhtw8pDZ/jwQ4PA6BaMxcj83vTzBLI5c1/o3C27DwwQarc7qgi+wlGDGUXt+1T94
 5cY=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; d="scan'208";a="156713272"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:34:05 +0800
IronPort-SDR: OaA2QpwK1ZcfH0h8JkIdhrcZP9nCCbk5AUQupSRtFa93Q9a5hCyLFowU/o5VS4j+B+rC1zC2wQ
 GGaTXlwxhEyn05kj2rxfbW93OZVmJCxq/38xrr81w/g32dn4QOSNKBmK8vYxTHk33RLafSLOsz
 MppDMd7vu3O8BEOHQeFLzBU+eeTwHe641Sk5pDa8JZjOsEamo0L3VCaUTFkKLEyY3fsDu6R/kz
 7ob0mnPBdBDWgw7ekC0cyxOMwX1+/xKKZLNvn99LtbA/88q2MyeOlCHiDLGKjRaehVBEobje2Z
 3AFt1NkHOxtqYAXdlpQvk349
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 16:18:54 -0800
IronPort-SDR: ZK4B8mCcwwtldSV4BX8Ln480I7tQh6iLigtmy3bP8BXsym/M6AeRji2TvnJ9low97eOPFgfwqL
 FIc/xTMZa6CPxmUvSBd7wahifXeoidCsVZajD2WlnyueHbiHg5T9YjYFZjSPYgshNryscyVn/y
 DUDrJikEu7FMXiHxG1YK2rxeyQUpsH05SjSOCXnFFOYyl06yv/H6/m3tVaQfMyRRks+AKoDoX3
 La2h//ba3Vj1pgZjS+NQnHBrAtP6b2g1aPw1NVycxwaEofacpZGZ8XZB2pUii+DDDl2NtOrGDH
 Nds=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 16:34:06 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 3/4] nvmet: add passthru io timeout value attr
Date: Mon,  9 Nov 2020 16:33:44 -0800
Message-Id: <20201110003345.8191-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
References: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_193407_745665_F1502733 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMeOF controller in the passsthru mode is capable of handling wide set
of I/O commands including vender specific passhtru io comands.

The vendor specific I/O commands are used to read the large drive
logs and can take longer than default NVMe commands, i.e. for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:io_timeout).

Add a configfs attribute so that user can set the io timeout values.
In case if this configfs value is not set nvme_alloc_request() will set
the NVME_IO_TIMEOUT value when request queuedata is NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 24 ++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 67e231e3df2b..160fdad3ac39 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -759,10 +759,34 @@ static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 
+static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
+}
+
+static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int io_timeout;
+	int ret = 0;
+
+	if (kstrtouint(page, 0, &io_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->io_timeout = io_timeout;
+out:
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	&nvmet_passthru_attr_admin_timeout,
+	&nvmet_passthru_attr_io_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a0c80e5179a2..2f9635273629 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -250,6 +250,7 @@ struct nvmet_subsys {
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
 	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index dd17d314fa3e..a062398305a7 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,6 +243,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
+		timeout = req->sq->ctrl->subsys->io_timeout;
 	} else {
 		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
