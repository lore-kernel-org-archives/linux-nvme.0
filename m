Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A64C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC061242
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0CC061242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U13GTSotBjE+Oqdq2S9lI23venuZRqJsv9mr5utGLak=; b=f96lm0XLGfesyuaK90Jd/lnIVn
	ArbOntMekd/5dbFN7qnzWCtlJytutPDrYNCcuP+e06oniyTW4mETaNmMyYrz17O3EMp51i7CUJ9kk
	YRuZ5vBzddortyERw+zqbrRL9Qws58PP8RGNrDQrmhg0F6szMX2mCSSo4oXtqsuP9QN/zyFtlKk96
	G9UVRLso5vbjXkow7zbgkCjkqV34Pdpm+Ho/s3MBDhXS5CKHwveOYfX6TCTQxMm7kiqeZYPVEhdiU
	kRF93YM5fiaKzG9/MPjTMsQ+uXX9UZZmMfPmDs5R+tM83XqAyJENQYm4OcciBfon9JVLHqJ8HvLsc
	pkL2R4Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5wC-00Gi5V-Cd; Mon, 08 Nov 2021 14:47:56 +0000
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com
 ([40.107.243.40] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vf-00Ghxs-Sa
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0EpAKejDwKCH5gxWZZ9SRGUvCCTCj08bAStb15zFjbl965dlJZOYranJaA776Ei/acJALW4rd2gOSR0+TyhmR2DyDxdpIVHKVesNpyuWtNMab5Ie/KWBJIc9ryvya9MI3fI0tTHOjPueEc+rWjkNpa57cbBt6uaeoMHI38TNlw6yFDpDuM6kKAS+K9Po2JoFSULkZ+RQhJsl7wdJ8Po23eXd8kU67O5efAngZXPOQp7QNlARk5NHh3QlVAVGkCv77vy4MhDS63ZCpg/7pxxiLdWb4nicWgdNOCgzEj0HQ0aR+/U20WqPst9jY4Y1NcNo61H1fAWl0fQtiFvpIbvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U13GTSotBjE+Oqdq2S9lI23venuZRqJsv9mr5utGLak=;
 b=jxxNXaz8rKN5bPgA9rBzHixXO19oYsCLcyvr2ysH1s5yg6rNoJCWlV119DpRdPNndVivl1GcGfXCv2FNMa/cSkG4hoNSpeCVCWlpSSe35pNegZrHbF2/r4iimgn11J6RZeZ6utrLdQDR8TUilSlEHVB2d23ELms1r4t2eTNfd92uscRcs/FBg5p+V/yaSe+hl2d6/LYeYYltseVI60TMF/xV8vLFyxCxBQli2JsAV+Ofn+4o4d4wGn5vf5XWtpcs9vP/Fw+5aHC85Jgw19uy3eIaqDXewdl+d1rKESKnrAxWSBusa2tSwzzdzc/6x2eGdU7ZM0BkBAS6VUzPJP0ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U13GTSotBjE+Oqdq2S9lI23venuZRqJsv9mr5utGLak=;
 b=bN5K/0FIi/jwEI0VhIPfdf4/y8VD/e47yueV5bZ9KG1Mk5VKp466VIxfUQZuPSUvt8nXpnEYOd9Uc/+yvMQaNN2D7chVEseQxDP8BMbNHy46gH94hq4eIKfZawoCVNvsjU3jsQ5FXZeXauct4Eg7bEA3z+ujLUxOBe5twqbTpTpFwsxX1xM0riNQ55bZvyZZMCbtaOUCgVJrZbAf2I0rh+Ihl7Zj3GbaPgjr7ZY6x7bxeJooThNItPI/839SQi5/W33iiUZw8fVG+IoBNcXm6Uzka8JW4UwjShEjNNM4705KPFOD6vm0O7c0s3xxFE7ETo+xgkoJzVjtnVRnqZr29A==
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Mon, 8 Nov
 2021 14:47:15 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::a1) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:15 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:13 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:11 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1 libnvme] fabrics: add support for new cli --skip-cid-gen
 flag
Date: Mon, 8 Nov 2021 16:46:59 +0200
Message-ID: <20211108144703.7971-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fa04d06-ecd6-4837-8a52-08d9a2c6a7f0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4906:
X-Microsoft-Antispam-PRVS: <CH2PR12MB490680DD68D32624C3BC54ACDE919@CH2PR12MB4906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQkz0ZIFVohblx4h7dupOamYk4tFvlORjVk0/ODOY8IDYIGRksq4GUw+EpfwVwCJt0cACvDNu+byoyM7Bpzut0c8rOHjpH9AXbnuwUqvW8+Me94CwCqn4O9kIH5ku7G1t3r0DbziZRxuWwVgFlAw+jJ0Q5vmLkeR1LkfN0obUX4RdAZlg/mQV5r3zRB9cYgH0sfz++q6GwzXRllmp5hQSmatdiHat2WfiEYN4d06s3ZPG8UCLmquSP7HQQeK48ASB8qfF2/3S65GrZe+u5UcIpVevyfwCp7JbOEORQ7/U42KX7ojoBVRGpQ2WH2qh2ldcCEFoulM8Whvad7IyYzNB4a81OhPtw19RE4GT/48zGPwVXN9lUbpLdjH77VYMXIbLVJifl5WXtR4paxVje+Cjs4oYhKTnOndC3HhWmEQSQBLoYoMDpohaVIFNeo6MQfn9R9PterPRBgVj2f5L9iOjC9ZnSGguaykMq3++X4Jt0fxCOWfvt57/fk7o4eKK0FwRk+bic1kID832ahMRS71wAYTQ+GtLZgjCoPp/yDIBaiRQIMBYyS9iab4r4oYbXY4GlG7mOsdNcJbv2qx2IisYE2GBr/0Ocro5p3GJ88gXosVYuUsgc/U2/Y1aCyTztwfcIWXSjpCuxANjYwkZsS/yq0lqIAuHP7/3ZbaaNiYWvnzSSPvfrDB5R3u/rsL5Wlx00fDtHeL4PqWBwOfU2GVtA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(107886003)(7636003)(86362001)(4326008)(356005)(110136005)(54906003)(316002)(36906005)(5660300002)(8676002)(6666004)(8936002)(36756003)(1076003)(82310400003)(508600001)(336012)(426003)(36860700001)(26005)(2906002)(186003)(47076005)(2616005)(70206006)(83380400001)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:15.2640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa04d06-ecd6-4837-8a52-08d9a2c6a7f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064723_954882_FCA93A1C 
X-CRM114-Status: GOOD (  15.23  )
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

Setting this flag will enable NVME_QUIRK_SKIP_CID_GEN quirk and will
actually add the ability to ignore the command id generation for
other transport alongside PCI transport that is possible today.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 doc/libnvme.rst          |  3 +++
 examples/discover-loop.c |  2 +-
 pynvme/nvme.i            |  2 ++
 src/nvme/fabrics.c       | 10 +++++++---
 src/nvme/fabrics.h       |  4 +++-
 src/nvme/tree.c          |  7 +++++++
 src/nvme/tree.h          |  9 +++++++++
 7 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/doc/libnvme.rst b/doc/libnvme.rst
index d52462f..e2555f9 100644
--- a/doc/libnvme.rst
+++ b/doc/libnvme.rst
@@ -11435,6 +11435,7 @@ errno set otherwise.
     bool disable_sqflow;
     bool hdr_digest;
     bool data_digest;
+    bool skip_cid_gen;
   };
 
 **Members**
@@ -11496,6 +11497,8 @@ errno set otherwise.
 ``data_digest``
   Generate/verify data digest (TCP)
 
+``skip_cid_gen``
+  Skip command id generation control
 
 
 .. c:function:: int nvmf_add_ctrl_opts (struct nvme_fabrics_config * cfg)
diff --git a/examples/discover-loop.c b/examples/discover-loop.c
index c2a2385..66e9d8b 100644
--- a/examples/discover-loop.c
+++ b/examples/discover-loop.c
@@ -70,7 +70,7 @@ int main()
 		fprintf(stderr, "Failed to allocate memory\n");
 		return ENOMEM;
 	}
-	ret = nvmf_add_ctrl(h, c, &cfg, false);
+	ret = nvmf_add_ctrl(h, c, &cfg, false, false);
 	if (ret < 0) {
 		fprintf(stderr, "no controller found\n");
 		return errno;
diff --git a/pynvme/nvme.i b/pynvme/nvme.i
index 4c45a04..cfa0a44 100644
--- a/pynvme/nvme.i
+++ b/pynvme/nvme.i
@@ -145,6 +145,8 @@ static int discover_err = 0;
       temp.hdr_digest = PyObject_IsTrue(value) ? true : false;
     if (!PyUnicode_CompareWithASCIIString(key, "data_digest"))
       temp.data_digest = PyObject_IsTrue(value) ? true : false;
+    if (!PyUnicode_CompareWithASCIIString(key, "skip_cid_gen"))
+      temp.skip_cid_gen = PyObject_IsTrue(value) ? true : false;
   }
   $1 = &temp;
  };
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 94cecd0..2005dc4 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -162,6 +162,7 @@ static struct nvme_fabrics_config *merge_config(nvme_ctrl_t c,
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, disable_sqflow, false);
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, hdr_digest, false);
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, data_digest, false);
+	UPDATE_CFG_OPTION(ctrl_cfg, cfg, skip_cid_gen, false);
 
 	return ctrl_cfg;
 }
@@ -445,6 +446,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 			      cfg->duplicate_connect) ||
 	    add_bool_argument(argstr, "disable_sqflow",
 			      cfg->disable_sqflow) ||
+	    add_bool_argument(argstr, "skip_cid_gen",
+			      cfg->skip_cid_gen) ||
 	    (!strcmp(transport, "tcp") &&
 	     add_bool_argument(argstr, "hdr_digest", cfg->hdr_digest)) ||
 	    (!strcmp(transport, "tcp") &&
@@ -531,13 +534,14 @@ int nvmf_add_ctrl_opts(nvme_ctrl_t c, struct nvme_fabrics_config *cfg)
 
 int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		  const struct nvme_fabrics_config *cfg,
-		  bool disable_sqflow)
+		  bool disable_sqflow, bool skip_cid_gen)
 {
 	char *argstr;
 	int ret;
 
 	cfg = merge_config(c, cfg);
 	nvme_ctrl_disable_sqflow(c, disable_sqflow);
+	nvme_ctrl_skip_cid_gen(c, skip_cid_gen);
 	nvme_ctrl_set_discovered(c, true);
 	if (traddr_is_hostname(c)) {
 		ret = hostname2traddr(c);
@@ -644,7 +648,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
 		disable_sqflow = true;
 
-	ret = nvmf_add_ctrl(h, c, cfg, disable_sqflow);
+	ret = nvmf_add_ctrl(h, c, cfg, disable_sqflow, false);
 	if (!ret)
 		return c;
 
@@ -654,7 +658,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 		nvme_msg(LOG_INFO, "failed to connect controller, "
 			 "retry with disabling SQ flow control\n");
 		disable_sqflow = false;
-		ret = nvmf_add_ctrl(h, c, cfg, disable_sqflow);
+		ret = nvmf_add_ctrl(h, c, cfg, disable_sqflow, false);
 		if (!ret)
 			return c;
 	}
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 9b796be..e9e4b21 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -31,6 +31,7 @@
  * @disable_sqflow:	Disable controller sq flow control
  * @hdr_digest:		Generate/verify header digest (TCP)
  * @data_digest:	Generate/verify data digest (TCP)
+ * @skip_cid_gen:	Skip command id generation control
  */
 struct nvme_fabrics_config {
 	int queue_size;
@@ -47,6 +48,7 @@ struct nvme_fabrics_config {
 	bool disable_sqflow;
 	bool hdr_digest;
 	bool data_digest;
+	bool skip_cid_gen;
 };
 
 /**
@@ -133,7 +135,7 @@ int nvmf_add_ctrl_opts(nvme_ctrl_t c, struct nvme_fabrics_config *cfg);
  */
 int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		  const struct nvme_fabrics_config *cfg,
-		  bool disable_sqflow);
+		  bool disable_sqflow, bool skip_cid_gen);
 
 /**
  * nvmf_get_discovery_log() -
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 0f72320..df1ac31 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -700,6 +700,13 @@ void nvme_ctrl_disable_sqflow(nvme_ctrl_t c, bool disable_sqflow)
 		c->s->h->r->modified = true;
 }
 
+void nvme_ctrl_skip_cid_gen(nvme_ctrl_t c, bool skip_cid_gen)
+{
+	c->cfg.skip_cid_gen = skip_cid_gen;
+	if (c->s && c->s->h && c->s->h->r)
+		c->s->h->r->modified = true;
+}
+
 void nvme_ctrl_set_discovered(nvme_ctrl_t c, bool discovered)
 {
 	c->discovered = discovered;
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index f9e7d37..c819556 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -822,6 +822,15 @@ bool nvme_ctrl_is_persistent(nvme_ctrl_t c);
  */
 void nvme_ctrl_disable_sqflow(nvme_ctrl_t c, bool disable_sqflow);
 
+/**
+ * nvme_ctrl_skip_cid_gen() -
+ * @c:
+ * @skip_cid_gen:
+ *
+ * Return:
+ */
+void nvme_ctrl_skip_cid_gen(nvme_ctrl_t c, bool skip_cid_gen);
+
 /**
  * nvme_ctrl_identify() -
  * @c:
-- 
2.18.1


