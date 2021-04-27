Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95855C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE8661001
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE8661001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8bKnb9cD8jKOf1ftVZvngy6uYooZtmqyUWczdraJBJk=; b=LWMyKA1y+hWjtj9jy6Ge2C3pOR
	NZx1ULhWerZ1l8KtOJibxYtHVOm+mmtYXIY7xQrksezi75NXw/Zow674PVzTub1mNcc2czdBiXBDV
	uFSR1igI5skb71QJ4Xaw4O6H2+FpytVV3WBeP3Az3b8CyMlsEvnbPexsDHNNw1F/qscHncsTn0RgT
	c9eZOsgbWptMSd7f4mPlkkwY9dtrjfk8LJaq6a6EaXw8ZBYuvbQKCjJrq3gmr9MPFA0WnfkrxcHDB
	fSiih2tP9wIA3loZsrAadttUtLC/OgdnOzz8ZWs7Ez4636V5fKjtikNiS4iJQ0OtPSREmMI5jeOnf
	CU6HHrVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbO7V-001ibb-TN; Tue, 27 Apr 2021 13:51:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbO7T-001ibC-1l
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 13:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=; b=yCCINXIoHV7p/fOopeXcgAS44M
 lBB6tX1g+oPhpG3SXFTsSBsV8AWCXiG24Dc+3Nh0qcAuju1mjI6UPKzbIEYN+lXv7MfTyp3LN7IaB
 BRLk1TH7QoGd5paW4boRn6fP4IW8CpVw28pwz1EgIm3b5sqswl7HlTpjMa/vP7HUTpQNalDVeoVOH
 VbaA9isTlmvBB1Et8QVPwwY2c1wENXKA7kksYstOIWflyBnf1hn2j99GuaWrFJDVzScd4G+wuvg29
 ZRYgJl0zvId+yyj5UrgRcTB17hcbNng+u0v5lgrwqiDyxqTNEJH2HKi4J+b1XP1xJSWbCJaEehR1M
 ZbBSS0JA==;
Received: from mail-oln040092009079.outbound.protection.outlook.com
 ([40.92.9.79] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbO7P-00Glz8-Qj
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 13:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDQWKv1h/4vlkWzWDftjmUp6A+ORMLc477P0WCZvH1MdbxR6QSLg2IX7cYvQcm5RjrhkgPY3YOGdd0JI77Ry8DF9PGn/MrNidXLctZmEmByz5n+StdtmRzs2OohXAbKuth5cKLI8gev33yYRYyCouBm+KXpz2+tzqVAFwFOjfloNgR7xgLqLqgJTap72KRe234NI+AnlXlx5wyASwSk6fDwJuuwGvq5e3ucgaBmR6ZR1mliaJ+EzTn9FTDe/VPZl2djcJirh03WLC6EbkInN9zcP0fMLvTIzezWHIxjxK0G5L68EBFyVwq4CAxasqYL4COBM7KnKq+6QS6YMRFrNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=;
 b=GofdGwvo/IzqI295A3yKXSWTzJ/lk08Sx0fv8MslxzAl8SyE+IZ8OvSEVM0wV0j5a8GF23QgCyeM0T7NmRN15x5GZ4ua/w5p41+kV37DUJO5CTDbw3o/5ntAqdrlTd0yKO7eKA+FDyRBXGB2zYf1R9rtC/qVhgLOnBdy9xuHhJJ9uXxOn915WeohdrA1d7kdKx8j/DWJIVYN4bqIZQNNiEYEB1LZEhG8+uQtcZGVw5DR6zBSlUvlvLjpt1FLKgx1whUH5j+jMQFtv+HXUaV6qjG/XFCG1T+IlcUKZclGh4bJsEEoiM9laiyGATCV+0iV26s/etxFec440aNjOq11yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=;
 b=Yk2wkHSqi2H2wQHO5EyR8ql8zSkuAS+79zPZQYLFnwYU86fHd4EXCCKYuKWtgeK6TkVgggJt43/LgjnoFlD+bg31Obh960ArVf+QWLMCS2kF1pLWfu8S0O0GYkljiktVbBMdXUjwz+lhwuao+FyoH0JIjFmBu9GgV/9g5Qm0I4qBvWKM17XO4runV/MIqGlw+P6dAPPMSagMPwPRBk5kEA8+MvrRCj/2l+ZWqo9eXXxtuPbwa5I7BFp9i+U/EGKfZMVmPf2tD6zx2pBrwzKTzahGvzguGd8CoOrkhNepCAMfFWYXlnygtNYhj0xKcmpRs7bhq2F3Kh7StFryz5znAg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3440.namprd13.prod.outlook.com (2603:10b6:208:165::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.22; Tue, 27 Apr
 2021 13:51:11 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4087.026; Tue, 27 Apr 2021
 13:51:11 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>,
 Martin Belanger <Martin_Belanger@dell.com>
Subject: [PATCH 1/1] Generate uevent on namespace AENs
Date: Tue, 27 Apr 2021 09:50:56 -0400
Message-ID: <BL0PR13MB4291371B4FD44B93D187B2319C419@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [FSKUDndKpsTkd1cO8Y707hd7gV2xBauP]
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210427135056.17833-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.16 via Frontend Transport; Tue, 27 Apr 2021 13:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d1db99-a954-4931-8445-08d9098383c9
X-MS-TrafficTypeDiagnostic: MN2PR13MB3440:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtyZMzbMetYHCwDy4IO44sT9zQf3jCVPJeXN/7cEnFoU0pEvXsDg19Iyy48f/OgMVGacxvmT3u/XLaaK0nUqPb2FmYWMmSn9T82IYCxlaj6kTz71nnR52UfVYK5d+hKSFnRtTkhUqal1Qz1vU+8zghOlgCcdfpIvPrnfzKN2T/lVhKdJIGV/4vnBIVTM0tdD7hBfje+Rn5m0a4inzdA4XQefMrqLbzJHb4qsZNVMXM33uGINwYLmyN+d5KiC0tfzuxNb1Q5Z9W5kaUDR8IpUbhUYHsnvAkQX5qb5nnq+xO32gK3mXOenGqR29gMHq7qXsyre46WJ77YxmKR9m6ByNCyeT/8gMh0dRWK3pOicPRhmdiGR3OS8GWk5b+0Xk08cwh/+IQEHqdFq4Lk0yXDi6w==
X-MS-Exchange-AntiSpam-MessageData: dt8oT6Xua12CSdwvWf07fcOGgK5SXkQgT802TYWwsxsNAnavgIb1iaB2qdDNntvsoY0hWNbwwRAUBIeJP0Tuawkj3BIvmLFvLokQBLFrXH2eibOdOhKbQIMfzekdT0vgPZOcK+sw4OqbGmZ4RrWQeQ==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d1db99-a954-4931-8445-08d9098383c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 13:51:11.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3440
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_065116_088489_0119CC0C 
X-CRM114-Status: UNSURE (   9.86  )
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

Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
(Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).

Signed-off-by: Martin Belanger <Martin_Belanger@dell.com>


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
