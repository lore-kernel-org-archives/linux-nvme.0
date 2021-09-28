Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 05:38:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A197E610A5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 05:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A197E610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l5zeddY2Le5hd1don6AfZ7EufAlWod0mRMtW0pIul2A=; b=C2W8L2L/wwqIBE
	YIbMpMhgrFU3TBs7ZjWKv31ehUKQIfjvH51dtrscTnk7wY8Z+EnuYGq7XqUFZ6HweWhygspbZBChR
	MWH4SYQln5Qprbou3a+ILxwCIB5GDd9RG3QPiyfDf3IWVJQHz6pPCnZblzYx52G5wuq3QlSazwAg6
	xepPrYtNdMNGaNKs6Wr6tEQ+J5O37iZGwiPAkMWAG13Bj+GGGAXOOJR7bPsJN4ONRkDgAIfkNLgBM
	MoXaY5OsuUn4zAfYZv0Tl0Rj0kqT+TGvdkFyoPrhmJGdTe8Pp4nHk8iIPI0lEiUAviwlG3VWgMcEN
	+4rBCbk4bGdEZ/+VbckQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV5ou-005fTo-UW; Tue, 28 Sep 2021 05:38:24 +0000
Received: from mail-bo1ind01olkn0140.outbound.protection.outlook.com
 ([104.47.101.140] helo=IND01-BO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV5or-005fT4-GC
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 05:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS1d4TldWV0Hy1VBPkpQYGX1eIE1R+7qaBRfU/zziZM+UWqAIKrM2k1UKI04Fslgd3xPwSDT3hiEELvkWaKaqM32EA+97e6UY7XZmsozDjqLIn6ZJ/E8+gv0P2Ef/hXKhOn09gnLwv+Wu8YDxHsdcH5A117bsq1uazz5bhiB37NAdgZXSNAWsmjAbgBJPNMkpb8zLBUH4C2XR//ne7LWP04+LOHbjdZ+y0Fq1yl4tw2yADhLxfWS0njRkv3x2VWVBknR3gCHWtsFF+wXK8rFA7pK4YBbBvd3qognGwcpO5EATyTkes9+2CR43KWO7syEgrcP6k6Chn16ViOebOLtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=n/dglOcWIpnFrvbnxh3vpzSAEknKr0fQW0DHzX/vmvY=;
 b=aYWANDDjX1GFI8C6OmsNJ7zAObCeSYzLOQjqwTLbr6NN0auv4cb4N107g19DUE5XgQ3DFrQFn6XIN5c6EFRWr8vqZMO8mzOUq9uzE94etRj6h2W5PVmZOCXmtgimfiw2H0DoI1BRi0iGsW9pJTelEe3hwIgdLuEKXzGPOLwh7BZpckIwIuSxPAwfC1zk1H3gmaTQWod8oZKsAbGSZLrTAwM9VTZVXy8EUc6o6Dm3OEJcDEBVFRqQSqjz9CaztAbUpCzdcX00W+B0fiPAGJW7VKlOji/+XpwHTAB3xpLUOojrD9b68+h+8vkoCatDSpD+AvXDZs7jRimc10csZqiQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/dglOcWIpnFrvbnxh3vpzSAEknKr0fQW0DHzX/vmvY=;
 b=eEzvptCkpbiCpu5jnAFUu1OeAvHhnK0cuMHSabbzgXXX4FZXRQANCbitJzWhXZ7CNTLuVgihYW8IfjYbxIE45bG8LxoiLxq0mz5x587d+xE/9pPhjXzr6HybFrSxxnwzfZbBXcbTQHQWRXT62+R5VGHyLPTgPQ7EYm32oZAINV0+ZnldqXRHpg36E2GZFbE2GjgqmAGtsmtXolbu0s8YDCtNj26PcvcJWI0u5yFlxtjfXtbo6nX6oEU57cvDvz3syJQBDRzG2qFE5JyzQqqfflrxUiVpaNAKxn65J6tyjpqLUpHZj0/e7KGBpgvIo8rrXA4ay294cjs+i4ocWPLtpA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNXPR01MB7090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 05:38:10 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 05:38:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sven@svenpeter.dev"
 <sven@svenpeter.dev>, Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Thread-Topic: [PATCHv2] nvme: add command id quirk for apple controllers
Thread-Index: AQHXs7ZsMiAV1bP6xk6nzlpopYUoPau47ZWs
Date: Tue, 28 Sep 2021 05:38:10 +0000
Message-ID: <PNZPR01MB441530003CAF17304C0B3329B8A89@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <20210927154306.387437-1-kbusch@kernel.org>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 902e148c-343e-0077-3ff6-4da4a8263db6
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [u6CnXFU/693OFAVgogW6mdB6VRkeC3IC3ZMcsOhXqBKWszVS6gPH8cm0Nf+QOFpi]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7e560c0-7b33-4883-113e-08d98242285d
x-ms-traffictypediagnostic: PNXPR01MB7090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwoBWT8sou3XX4hTA9I75LF9mYOlx3FTJeLa1ZtS5+/7k/OIPpjRmuJ1yeTcwK2Ipr1+KA+2BkzE4aLYRKxMBBAJZRgFUPub5oVaA2zCioqpErK6XRT7f1iWmrQ5C9Rwm7cLl3wHzfAmLNbDhRlOApVIw+oLrjxmbUj10YpMLTWVwHMFduIbR5fZzHiLNYE9uENNobkS0FJAj0um7XKFRXjaP92ZWT2TNDeyPP2ekFas3c1k/72Tx6KyQtVXnGUYGXzufc5yxCCNnMS1OhScZl37Ak/LhsOmDifjAsKnt9FRgm6+qbc4uoaYSXXNpNCmxGILkH3410Ly7Vud6riHO9+aGB0VDJ0YtroYZNLfc1Kf1HPU+PSpocPpgzz7jTGUb6gGMEBdI1702VWHon/KuqDif0zmKU02lYQqcWNMQJHsBHLVqMJt1FR8YDyEmXRVueLsOgT23fOWnViIYVPuXQajT84HgcZVkEK0byLN4Dc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: L9Hm+cN1XYDuAwF2bcWBPb0OMDzj5Zu2eLrc2UqzbNA+Vwnx/URGHdzxF3C1krevOlePHtY/zTk3Jx6VpRlKhVCu7ThdGunaUmW5h1Ch/SJHZjcpR2MCysv9AuCS8qaD389LIQWvxC/sTHJiTVK/gUX3nQjnzZfaPCtdK+50n7UWxCzVsxhUgvpi+bKCjrVPb6Y5uShnGExFcCiuucf6Hw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e560c0-7b33-4883-113e-08d98242285d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 05:38:10.5818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_223821_588554_4632C715 
X-CRM114-Status: GOOD (  14.15  )
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

This patch fixes the issue on my MacBook Pro 16,1. I have tested this on 5.14.7 thus it has fixed the problem on stable.

Tested-by: Aditya Garg <gargaditya08@live.com>
________________________________________
From: Keith Busch <kbusch@kernel.org>
Sent: Monday, September 27, 2021 3:43 PM
To: linux-nvme@lists.infradead.org; sagi@grimberg.me; hch@lst.de
Cc: linux-kernel@vger.kernel.org; axboe@kernel.dk; Keith Busch; Sven Peter; Orlando Chamberlain; Aditya Garg
Subject: [PATCHv2] nvme: add command id quirk for apple controllers

Some apple controllers use the command id as an index to implementation
specific data structures and will fail if the value is out of bounds.
The nvme driver's recently introduced command sequence number breaks
this controller.

Provide a quirk so these spec incompliant controllers can function as
before. The driver will not have the ability to detect bad completions
when this quirk is used, but we weren't previously checking this anyway.

The quirk bit was selected so that it can readily apply to stable.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
Cc: Sven Peter <sven@svenpeter.dev>
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
Reported-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: fixed logical bug checking the quirk setting

 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..7712a8f78337 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -978,6 +978,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
        struct nvme_command *cmd = nvme_req(req)->cmd;
+       struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
        blk_status_t ret = BLK_STS_OK;

        if (!(req->rq_flags & RQF_DONTPREP)) {
@@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
                return BLK_STS_IOERR;
        }

-       nvme_req(req)->genctr++;
+       if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+               nvme_req(req)->genctr++;
        cmd->common.command_id = nvme_cid(req);
        trace_nvme_setup_cmd(req, cmd);
        return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..ed79a6c7e804 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -138,6 +138,12 @@ enum nvme_quirks {
         * 48 bits.
         */
        NVME_QUIRK_DMA_ADDRESS_BITS_48          = (1 << 16),
+
+       /*
+        * The controller requires the command_id value be be limited, so skip
+        * encoding the generation sequence number.
+        */
+       NVME_QUIRK_SKIP_CID_GEN                 = (1 << 17),
 };

 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..456a0e8a5718 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3369,7 +3369,8 @@ static const struct pci_device_id nvme_id_table[] = {
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
                .driver_data = NVME_QUIRK_SINGLE_VECTOR |
                                NVME_QUIRK_128_BYTES_SQES |
-                               NVME_QUIRK_SHARED_TAGS },
+                               NVME_QUIRK_SHARED_TAGS |
+                               NVME_QUIRK_SKIP_CID_GEN },

        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { 0, }
--
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
