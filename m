Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D6C43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 07:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBCE2077B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 07:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLnhXki6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="kkNWGvER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBCE2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7VLHA2xh6rFQ7ZYpraHwO3gLquDnRbPARuWkFPRt8Pg=; b=eLnhXki6KDrK5M
	mbPrRSTv0vvTXzLb9U5BgxRpC6zNWcQ23XtXREXtuZKZs62j6U5NdrApTy9G81KVLwFAHRuS+vYIC
	GdC+p+ztNB9S2xA+B3pa4SaBSsaK9w9283x1Z5xU3iBcI6/rHftcyu3hCn2fcKpSgo2H566snq6dE
	b6dUpRZm5z9qMIsbDyJIgTcQwYIE9E6qdPaRpG/w3oFaouMN/Zc0Acpj9epcfwfM4u2hVwn4Xqxng
	hLtiIs2KD+pro9LX1IzA7qxISbNlhjSyDDp71wpoGA7ktxsERdT8ejx2jWeYkuiwhxc9J4EMGhnho
	IHcSWl94qhrosQcT4/dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iffXM-0002G0-Av; Fri, 13 Dec 2019 07:38:56 +0000
Received: from mail-bn7nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::631]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iffXI-0002F0-78
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 07:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw7R5KtzgciSuw9UvqLAulUFXn9DTqExUcwKU1W5rn9ugCJajcAgrJCg2v52FMrr2twHjY++nP6Hsj8w6UuFy9swgfnvhY66dUkI5krKrSB+0MYytVph/uA12Om6fMA3dLrqETy2TN9Kq1ZENg3Dg7WM+EiKq4YDmYx6rGKMqw03TXZKGJxxTj7tsHeXe0ymdgcPGPHDxfiBZgsXxGlKmFVimUn/R80svSqrLG1C+A59b3Z1M3DsX8qS3BDGwW6EamwGf5/Ti1weXmuh8SUFVJREENLY0Kh2+IMeH7K1LWPFPjV/eZr4ER408jIQAe22Hg9OWopOvWw1tjGTrwKYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sySrlL2dPONQDDWR6CPnhVCbd+P6Ox0wRyzPzEIFAw=;
 b=IZ50tzdLKUsWWhRLsrvo3Z/OJ063WK4aEtPYmfFEfYiMuZDZc6xV3XUha3PPGFWADBPKPpJYlsHe7tDCLTZ/p8B5vbI8UUaeQZgC4ixWNDtvI5kF0+wR/JkZlCzbPULwdcZDS3+44qvNSxokoi0vKuMdfpgaijJtkdc4af/CYI9O9f7A9ccKcGMnKuFPDeaxsWTJvC/rsuaNNJBCHTFZkXO1rsRNodBx4Q4DwR9UvjNdBb6Ypem4NkevFciOUzmDnNXypV4tWa5dvwKmmxx1bpAmTjt4wfMctfezKkCDcNQYwIFHJXtmih0dkYw1gg1VirtLCjWgbml9zWAy+HmL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sySrlL2dPONQDDWR6CPnhVCbd+P6Ox0wRyzPzEIFAw=;
 b=kkNWGvERYP7TIiQmnyBMusnQxD3pH19v9ir5AOvEWfU3LvCdtGE59y3yRSCqEUXqBes/988ZZEUtZ3m6qtfiRhdSp1IcxLy2h2uRQVIOV1oNZyiVx6y42Bwc5G6qmdixk2SDJJNIaGri5j4bVDnL4IFnkzbfLxaz8Ce3zRmCZOc=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5396.namprd06.prod.outlook.com (20.178.210.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 07:38:46 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 07:38:46 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: fix REQ_NVME_MPATH retry logic
Thread-Topic: [PATCH] nvme: fix REQ_NVME_MPATH retry logic
Thread-Index: AQHVsYhaRE6mz8d3PkiH+twoaxREkA==
Date: Fri, 13 Dec 2019 07:38:46 +0000
Message-ID: <CA37C39A-183B-40FF-9033-DE0AC320E098@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06394777-5bcf-4da8-d14d-08d77f9f7cbb
x-ms-traffictypediagnostic: BN8PR06MB5396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB5396B68E9E6EBA5808366E9AE4540@BN8PR06MB5396.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(81166006)(6506007)(110136005)(4326008)(66556008)(64756008)(36756003)(66446008)(316002)(66476007)(478600001)(55236004)(71200400001)(8676002)(81156014)(186003)(66946007)(107886003)(26005)(6486002)(6512007)(86362001)(2906002)(5660300002)(8936002)(33656002)(2616005)(91956017)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5396;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pd8HTEYTwvwHrEw+5eRqoq2Ao/ODlETmqBzxlpbdQa1EV0pWmQtiSR5oz+gD05vGV9BW2eYaArQYFkISV8P7DoP8tS2RTB3xJmxJvu8w6/MbUVCjWYdB/s6hDxk82xNJ/XcVdRFdgRGEaMTG0rYq/8hn1Y/me5bWulbfNAEXdzYIqF1tcEqrrlTW6xHxnb+elrs8lbpIFuuW4QnRTFtPEX7KlqcVaubpi5xz66I2ibC0u39LVqFd1bYv/SiHvRbOGnLHo9Y4CiST/9C1dYixrs/v7gfRLEeRiuUAY1HfBhYMoXMmDVrNkILWDZAKmAMizvNax1J0yIySWx4nUr6YJ/6g02hUI4jWLZWlS+p6SDEm+xjL9ThKzaz7/6nOUgpktwnGZtJvGTvcek+tXWAYgUtNk44G/ApYAQ/RKvhIFRiFKddRUq6fm5tBKOowDjtS
Content-ID: <B63193E381AE0B499F31F9D01F651154@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06394777-5bcf-4da8-d14d-08d77f9f7cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 07:38:46.3236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYM95ZEpudZDhg+tbx4vkXYnmGcvERMZtUPCP+jGxqXjaPqnIPrWHtwSXEBle0LAKWwP/MtX+peOhKMXKyRpTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5396
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_233853_753900_8F82405A 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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
Cc: "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: John Meneghini <johnm@netapp.com>

 - Make nvme_complete_rq error handling logic
   equivalent between single and multipath controllers.
 - Non-multipathing related nvme errors will
   be retried on the same controller.
 - Avoid gratuitous controller reset while
   handling BLK_STS_IOERR when REQ_NVME_MPATH is set.

Signed-off-by: John Meneghini <johnm@netapp.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9696404a6182..4d1d44597a40 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -262,6 +262,25 @@ static void nvme_retry_req(struct request *req)
        blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+static bool nvme_path_error(struct request *req, blk_status_t status)
+{
+
+       if (blk_path_error(status)) {
+               switch (nvme_req(req)->status & 0x7ff) {
+               case NVME_SC_ANA_TRANSITION:
+               case NVME_SC_ANA_INACCESSIBLE:
+               case NVME_SC_ANA_PERSISTENT_LOSS:
+               case NVME_SC_HOST_PATH_ERROR:
+               case NVME_SC_HOST_ABORTED_CMD:
+                       return true;
+               default:
+                       return false;
+               }
+       }
+
+       return false;
+}
+
 void nvme_complete_rq(struct request *req)
 {
        blk_status_t status = nvme_error_status(nvme_req(req)->status);
@@ -275,7 +294,7 @@ void nvme_complete_rq(struct request *req)
 
        if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
                if ((req->cmd_flags & REQ_NVME_MPATH) &&
-                   blk_path_error(status)) {
+                   nvme_path_error(req, status)) {
                        nvme_failover_req(req);
                        return;
                }
-- 
2.21.0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
