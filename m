Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F8C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 20:29:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093976105A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 20:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093976105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IWMhPyggXfyipEORmqkZ8Hidi/QgXNwWx9P4IVM+Ag8=; b=Q11eeNfk5idJ2P5dSIQ681VnF
	k2SXi0yOAZvFpUB1qWVbwmfzBgIKFsJaYRRBi+je6R6eACnSzTRVgx1549/aaayn0vXAqPe4/NFPY
	UZMaaiCQyzLKYhQplRLUpbrXXbwtf1YhZdxNRmCFwBvWAYQevYw973IkPFBVGcEONweQUBZ+aRkk5
	bsggT2i7wiCSKQ3EN13r6oVJtEvbBHZlJ7Ljm6/NUuuIYQd2af/4LUOEV3Nynk8f3U/WKI1k+G095
	4fRGc1EOJwOmRCv7nAJ1iEUn8UjtbeUzB8HQRLTd/oigqNtq0SXjRy9nqPkL1OqiqYsfjT9S/DkX1
	ny5oIXO/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb7rL-008Tzw-AW; Mon, 26 Apr 2021 20:29:36 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb7r5-008TyJ-Hw
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 20:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=gZobDWRWlbbRjHur8qr0lOtukO4tGvtamF1cZwcQAAk=; b=bZc6jP1WBTuaeNNf45J1rx6vfx
 xj789PZODg2IuO36R8roGnLXhqY3id9sgAnpzT07JHxR78SxQxlMcvLspsbJ2ocvDvr/fw2BlCpEw
 VOXqNT5h0kjaDn4BwaUad3/S3WC4uvKH3JLktya7NQRfYQbQIIWhcfu79N/tlOmMNACAGB1nNeSdM
 q1Bf189zeNP4BMMYUJsOdAlhTQqIUPdpitLGVb+x9FCTrNpBVh2JMTbeVrx3Bli6RAjvky+EQST7b
 MNMMhpCawWMzIeXiGw3QFI+CiEU+QD6bpR20VOekk7igB/Qe4dd07yvIQ8w6r5vxr6w7XzuDgGxWp
 NfCwmPtQ==;
Received: from mail-oln040092003067.outbound.protection.outlook.com
 ([40.92.3.67] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb7r3-00GCoK-41
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 20:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoUkoHj+8Edc75/0WaCDcD2oi0NCCd+Av0rZZjCmYKuyMQLpCJLvFo4UY3KLekVVx6o31hNJWVJ9Rrunpj7gG7yuEZQ1O67DTvTFZuMAG5vsa3JMJO0eecLqs5qXZI/+2IJYDB5CGCdOOYzEWBfCtj5hpasGL+o0MIbGEVG7owsXEBWATBA2gnE0LdrdYu36vbR7IWg5vOLPDS277strc2wR4ObFfQwh0EyFWfPoxoH5HbLlNzLlxO2uo6FtxuXStxs4G9eo0B70d2VfqziQIzMTe/Io1OI8E1Er7ElrxDYIrnvh5/2pM3Csvhpg3CJXQr8/LVMYYdFoa0SU72Tjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZobDWRWlbbRjHur8qr0lOtukO4tGvtamF1cZwcQAAk=;
 b=DRkqqzJfvlY2f6oMuwUXZ9v62kb4mUg6Q/VlrGtCis1v5bbQk9WVYrXQTO5Ex/Qd8QlydOi3zJN+wsbftVcydiVb9OYlK4spORpPgPOB7QsAiUkB5LmSal3d26xbPqv1uDVOI4lJGnVmgQHas5sNpTuwQv1Js3H/wtcL+gHEZ3eGNScUBX4yZ3VRTNyoYiOlEM5lPMkFxqbN2+8+QzT99mAF6JID5NupMu1u9FoTrZmbxCOKlBGX8W7kF2lUeRb/8+cFC+XvQ7QgmOEA0TIMtwO7LKas7xhJFTQXCpqJRV5TjUr9JyTnnC8KW2P6yTxmO6WqtDBXUM0uGiovQ6+GSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZobDWRWlbbRjHur8qr0lOtukO4tGvtamF1cZwcQAAk=;
 b=gcvQFVvZF7gQoXKkbg4EmKZRBSEqDaarL6tRrk/5TPTLFbIcnkdqgrya9pjzfJk2ZVm1e5KQtP5FnaEfOOSxpmZg2uaQf3Zht7cxdc5qgTBKBPZRRdRQQDa5ueJ3FEUc3VAdL6UzfJ1yprzWDippB9Kb2KYgaZ5x28iMr56WTUss1RfyphKLTbs4B9amogQy3tyCL8gdjFffyiPYVCDvIOXm3T0JYhWc/H2XBM+JeVoxA9R7K7KGQWFd1h2UPOTDdq48xlMjybrD1CuPAfmAYZdDGVc+19lj8Sk62hh0e83J8VVFCsWTyLyiggR05Jwztm+Nznihqkr540W9CStKnw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3837.namprd13.prod.outlook.com (2603:10b6:208:19f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19; Mon, 26 Apr
 2021 20:29:02 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4087.025; Mon, 26 Apr 2021
 20:29:02 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 1/1] Generate uevent on namespace AENs
Date: Mon, 26 Apr 2021 16:28:42 -0400
Message-ID: <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426202842.42096-1-nitram_67@hotmail.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
X-TMN: [ByX0NBQRo+B4Y7joxCiSNVpQSLEwVmve]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210426202842.42096-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Mon, 26 Apr 2021 20:29:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe772bda-50c2-490b-9d3b-08d908f1ede2
X-MS-TrafficTypeDiagnostic: MN2PR13MB3837:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9eqI8OmpfcxgdkFwLUkOlJjuBDxtk8FKmNSrjHp3iRgr8iIWuE+HSlbTAMI1htk1Ewx+iMSXkICa4gEqdZV6lEf7p6Iji3xk2cLoKlCOFP+nM4MnYPPtBVuHsaRlVPozINUcz+FDLwVm7Y3MUJfEGRu+5uGihZMttsa4b0/EkajXfXfl7XJp9Oc5PSVkZzr4j6h32bXB5BzNqBbxThbw0UVY3dFrq9KxZIkhAW1QOV/lH3WNMSYzuWCW88UXMSaYMuD1nN1uMNGtt18rfq3LQ91sGuy21PcDFOAVLWEPQDVHVMW9JzMSUtRZSfrp7RCQn8EHFgpVhiXt22rObKEllufChGCyxaFhIm2NKNhOS49G7qkFP3UDDxj26HP3yY0
X-MS-Exchange-AntiSpam-MessageData: Fj3asB5mr6TxjtROCZzCqdOiWX9sPlkhfx/V07Jjn1CdRtBwguQ97BrChnhnRKaOEI6ONaeaGu3CwgA7vUHB+oM1Jpd8/JdzmUVpj0xxPzrgYlqLLUS+r8K/MuNBvK+O0hdQPpaL7F55MSfLvf/pIA==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fe772bda-50c2-490b-9d3b-08d908f1ede2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:29:02.8673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_132917_184280_BE8D785E 
X-CRM114-Status: UNSURE (   9.89  )
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

From: Martin Belanger <martin.belanger@dell.com>

---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f45e8fcdd7c..bd37ddb172de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1115,7 +1115,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
- * 
+ *
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
@@ -4133,6 +4133,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
+		ctrl->aen_result = result;
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
 		/*
@@ -4148,6 +4149,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
+		ctrl->aen_result = result;
 		break;
 #endif
 	case NVME_AER_NOTICE_DISC_CHANGED:
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
