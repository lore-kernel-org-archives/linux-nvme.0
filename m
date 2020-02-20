Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809AC11D10
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 17:17:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B91124672
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KKcgq8LN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="I1EvyanV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B91124672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R8ewaRBsqIiNU/tTUux+A34QcTwNbGxmM2zJ2UT8Iqg=; b=KKcgq8LNWaaKg1
	LRURZiy9SDJzhsm0H5L0dpaVHtctBEqQ76QOAcN1XtoUkAvEiBQZtfkG7mg1XCzx5xds8jnuFo7g4
	u/QJkkHU+S/CZy/rUpG0Df69K5XVbpoGygg+yg7I1LyedAaL4QeJP8h0m70WwOR0mYm4Kn3X7vAPf
	k/oMvQcEOZ05q2pbvCSv45C50UGY7flgj/lzZgoLGBwHEqcEVSsVYYhsQb/YaiT+OrTUIjWfCrkDR
	wRMK6GbNsbgviKzotoCpbxoshhqH1dZtkMBpDZAeumRiprDxxRsmgBmsJaliA/EU89I0xyNxMm0dF
	MrVfSrC8u6XtK+MAEsJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4pS8-0008JC-3j; Thu, 20 Feb 2020 17:17:32 +0000
Received: from mail-cys01nam02on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe45::626]
 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4pS4-0008Ik-Lr
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 17:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgXnR5RJRcWSGSsRqbtHInHVcLXwr8bVpVNxq7PTj3o9lA1OxJrjfReVXK76UtGIQF2LGc5juE5Psi/wRyA3hGlD4AnixU0PLwhkdwvwGUEMkcZA0h4MpRdj4XG/j6denLDkjjuCa1I9doKYKbsXLZBIJxEP3Tbi45RFvbuz/6ELnvF1LcFqAl0bzCZuL38F1tHzs7EGMmKofJynJO3lMwXaP3BaaORnemfKgjTVoWO8IWckl0jGMthqVsivxw/PWuLx0hgrZ1ThokkGzJ/SARD7phiGxRHDwmdxgtTAYXl4ZiqkncIXyJTrhSwKOyIZ81Mjcrdn+SrOaPWsnmSW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acA2UiccCYCfUrD4z17GkD1HTIQWSEwxts73Id7DC2E=;
 b=FyPHeY+Z/TK47+m8bcqFqTXHnzWorcNfv+j58zlf484f8qrgqQ0hvf6NM5egBKQLmzVT6WL2qLmoFtY65S33dFvjEXeBxeGCcEM1ItR/lX4zG2xEQ/fs0feO3dxfdElo8BhtKOcRH/IcoKL8hmr5hizNgIRq+ATA5Je4/L1cp3j339oupKiN6y+fQv1WiVXGOtLgUIIxbZ8BP6/3miIrcFqdQAfbacMMWocEo2Qn7ai5m/UKmtAs3vmqpMe/Ps20gnl0PnRsSCxqH1fkdwI06K+Li8OvPi6YlnGssEJ31icdR3g3xU6o2OpM0bH1UVOC3sRshC7VnGIsYd545KLTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acA2UiccCYCfUrD4z17GkD1HTIQWSEwxts73Id7DC2E=;
 b=I1EvyanVoju0MizFCktaedz5RWUwUtF7hmFhbmW8ilU6M288DpPpe9uCW/34JFjTnXEO+6PyWOGSkkNZKnygJx9ucK1ZabFvfku+T7Ximi7EX0QR/OsTdfockRI/HeOriIFLyoXpqAp4DDDcqiUonvIYqtBmrZrxANL6tAHqiBg=
Received: from BN7PR06MB3811.namprd06.prod.outlook.com (52.132.217.14) by
 BN7PR06MB5314.namprd06.prod.outlook.com (20.176.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 17:17:26 +0000
Received: from BN7PR06MB3811.namprd06.prod.outlook.com
 ([fe80::fc4a:9b42:e2db:5ebb]) by BN7PR06MB3811.namprd06.prod.outlook.com
 ([fe80::fc4a:9b42:e2db:5ebb%3]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 17:17:25 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-multipath: do not reset on unknown status
Thread-Topic: [PATCH] nvme-multipath: do not reset on unknown status
Thread-Index: AQHV5/2PqYkeE5X3R0qtHkiG+ngvBKgkSscA//+0qAA=
Date: Thu, 20 Feb 2020 17:17:25 +0000
Message-ID: <4F3D65FB-8894-4E0D-8D67-0379B537E914@netapp.com>
References: <20200220145241.12982-1-kbusch@kernel.org>
 <20200220164704.GA13560@lst.de>
In-Reply-To: <20200220164704.GA13560@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.21.0.200113
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c18dfdf-ef87-4a38-477d-08d7b628c186
x-ms-traffictypediagnostic: BN7PR06MB5314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB5314AD68589FEEF2BBC405F4E4130@BN7PR06MB5314.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:416;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39840400004)(366004)(376002)(346002)(189003)(199004)(8676002)(76116006)(91956017)(55236004)(53546011)(6506007)(6486002)(66946007)(81166006)(4326008)(478600001)(66556008)(66476007)(64756008)(66446008)(2906002)(81156014)(8936002)(2616005)(86362001)(186003)(5660300002)(316002)(107886003)(110136005)(54906003)(71200400001)(33656002)(36756003)(6512007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR06MB5314;
 H:BN7PR06MB3811.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhr6cq0uNh2XrsLlUxNBocHSn4USBFOPAbJ35ynsdCyrumG7iupmZFNV/z4OW771Z1vXskQqIxeAgTjcyINRC5oD2qqlMLPeeAiv3BbcvNSoerND4Yif/e5DvXdUEWRg1myOAsjNX6OYvdJ7wkBFhSgvXcYiSVGMpucIXlQeQYG0j7hMleVEfVWqSpVOXjlezQIBW9a3o1iESlGcSbgCMaXPBxdzgxqel2emlNny4gCcgG5IJBpzlohbi2F8KRiQRqTr1RZ9elDr5/R3rMpvP/ZAhGzU2PICs8Sa4ZAm17Cnq7JC3oxSirZpi9R+jBbmwliRoAVjenZDXbb+WrplsqbxPb5Ea6sYOApQYT1O7ise14e5NoidrwgWrdIp0mA/zor+7h1QoWu/a8EuvOrTJ8xJHcG5vX2FG2p4p9ycW++PTu6TaFBuuhyxuSmpoSE3
x-ms-exchange-antispam-messagedata: Lmb2jnUlWHrLoNJUTxQ+lFqQmh2s8ZCgNL2G4hY/b9o4XqxZGqm9lsKgNi6a/yFFv/E198Q844GnB1kddFEDk8a86bsRmsCnTti9+WtKqmjVCKDD0GRXUXY263jWX/8KCGAktwPmyWI/lcVBU+3j4A==
Content-ID: <FD665F3CCB22E64E8C77C96A9116C6B3@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c18dfdf-ef87-4a38-477d-08d7b628c186
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 17:17:25.6025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1OJznj12Wd39ZNEasevrbHgXIY1ogi1U8ntyihnXrg8SW01ZFM+D5+Xz0jlNab3WPoAGjHRjcfNegGI3gx6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB5314
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_091728_744107_D1F675DB 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: "Meneghini, John" <John.Meneghini@netapp.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/20/20, 11:47 AM, "Christoph Hellwig" <hch@lst.de> wrote:
    
    This pretty much looks like my edited version of Hanne's patch with
    John's changelog and your edits..

That's because it is!
    
    >               if ((req->cmd_flags & REQ_NVME_MPATH) &&
    > +                 nvme_failover_req(req))
    > -                 blk_path_error(status)) {
    > -                     nvme_failover_req(req);
    > +                 nvme_failover_req(req))
    
    This conditional could now fit onto a single line.
    
    Otherwise this looks fine to me.
  
Here's another copy of the version I sent to Kieth, with the new commit message.

From: John Meneghini <johnm@netapp.com>

The nvme multipath error handling defaults to controller reset if the
error is unknown. There are, however, no existing nvme status codes that
indicate a reset should be used, and resetting causes unnecessary
disruption to the rest of IO.

Change nvme's error handling to first check if failover should happen.
If not, let the normal error handling take over rather than reset the
controller.

Signed-off-by: John Meneghini <johnm@netapp.com>
[changelog]
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      |  4 +---
 drivers/nvme/host/multipath.c | 22 ++++++++++------------
 drivers/nvme/host/nvme.h      |  5 +++--
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84914223c537..e1696fcf0f8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -291,9 +291,7 @@ void nvme_complete_rq(struct request *req)
                nvme_req(req)->ctrl->comp_seen = true;
 
        if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-               if ((req->cmd_flags & REQ_NVME_MPATH) &&
-                   blk_path_error(status)) {
-                       nvme_failover_req(req);
+               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req)) {
                        return;
                }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..8a1697f7986b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -64,18 +64,12 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
        }
 }
 
-void nvme_failover_req(struct request *req)
+bool nvme_failover_req(struct request *req)
 {
        struct nvme_ns *ns = req->q->queuedata;
-       u16 status = nvme_req(req)->status;
        unsigned long flags;
 
-       spin_lock_irqsave(&ns->head->requeue_lock, flags);
-       blk_steal_bios(&ns->head->requeue_list, req);
-       spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-       blk_mq_end_request(req, 0);
-
-       switch (status & 0x7ff) {
+       switch (nvme_req(req)->status & 0x7ff) {
        case NVME_SC_ANA_TRANSITION:
        case NVME_SC_ANA_INACCESSIBLE:
        case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -104,14 +98,18 @@ void nvme_failover_req(struct request *req)
                break;
        default:
                /*
-                * Reset the controller for any non-ANA error as we don't know
-                * what caused the error.
+                * This was a non-ANA error so follow the normal error path.
                 */
-               nvme_reset_ctrl(ns->ctrl);
-               break;
+               return false;
        }

void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..d800b9a51c2c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -550,7 +550,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
                        struct nvme_ctrl *ctrl, int *flags);
-void nvme_failover_req(struct request *req);
+bool nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -599,8 +599,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
        sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline void nvme_failover_req(struct request *req)
+static inline bool nvme_failover_req(struct request *req)
 {
+       return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
-- 
2.21.0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
