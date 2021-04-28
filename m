Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE02C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 20:19:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AA3611BE
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 20:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AA3611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8bKnb9cD8jKOf1ftVZvngy6uYooZtmqyUWczdraJBJk=; b=otZhveqd9PAljU00kP2bL7KFKA
	F/XXZppfJ3AMH2RegaiFVi4/ArzizzsNO+UoKjaNephYySOCZ7i+j46IwBPsz88pcaqHAWh//dGS+
	/GxLF4mNYbn4JRexjtuWcTJM6XTLR2AmQ06nJqRsKmo678rXSo0tNXZYQghOL5AdzYv59qjDByYh5
	exw7zmjjwTNQ4Scwsz5J+4eePkIvPFlm7QfVM4ZgxazqPyEttOJ2xsa/DLpveh2bqbnleuyiidcRX
	gAjx0dZR2aFvY9f2Lvw6ILtkxM5OWnPNoprgDu2MCeuBNO+0BYuFxWIjH6EjRT7tYtZAgOz8Zdm8J
	eUV9QhxQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbqe7-004Dln-DU; Wed, 28 Apr 2021 20:18:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbqe3-004DlT-3g
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 20:18:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=; b=dXw3tzTrdpi/naqe5vIZAlisQQ
 M7SDEwTM4dZaf+6vI19w6bDijg9pW5m1FMu+zgBABvW9TTwfQoeud29McD/imJBRXoLU2hi5ymFMr
 203hEjBw67qn+5EgaUXz58grGxaaClyx9jWRFGbg1xXqxMma7QomTUNRrqYepaGfO+zRMOiDzqWos
 C7Qr1oHFdoU2uaoKSJamK2zR2wJYPe/OvDeGOOFcduMlMSY47ETnga4EMaXnjeBkOQV8g06xkz4x1
 V9kzhaIZwIOknY8gR1KlKtZTxzMayd/+I5XwadECBsk0MgMn7ndmyO9QNWJY6qzXefyW1kcgDIJl3
 VglEZZtA==;
Received: from mail-bn8nam11olkn2046.outbound.protection.outlook.com
 ([40.92.20.46] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbqe0-000APH-8r
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 20:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4cotcEr+oHgvjXrMF38n5InIZmO+F+DYpM9W9Y2BwuM0NcFzgZBuAD4ZD68uGXBXl0DrUv0q8tWSeBTo1xLfFkPJn1Km47skOoNuGzjs9y2WDFwiDl/E/AP0HljFNB6S5yMxvaHnJ8PIvW56byLrwJ4vUJ73rAcy0fNVobtc72KwneoT5YHZNs7oTQMRP6cl2XAYkmCzlTjvyBIHvCZ1s0ugm6rQvUIOFmhYSCIes51f5RCDgdcd/2teWDs0dhU469Or1Lae0Rg48Ghv2U51tQNyL4W13jvZXsJKq7bfKRYAzFDifD1ZcXN+CgmQDFRIBka9CZZEygY40iJKi42Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=;
 b=I4Ux+fgZ7sh/zZ6d+dL++j+JmID91N59JpV0aiQ6Y0tSouJQJInOKlSFRxBePs2M17amshM7LuF+qADi8A6AM7BO6uitO4L6L5pLT3sqDsYz1FmVddFTs6pUff2UHJGbR3SjvzmS7s83Ze3TG2zKFBXyd+Ozt8fvSBp1yLM0Oj58eZcu59EoLVIS4GWFurmXVywZLRyDehu/6rxRjErA6gAQ3CQfvHxdmi/pWJHZsUpfgUaufrBWLjK/OXlE9z29eRJROqBL//ZuJVlSWw8oXMgPB9itW8uGHH6QTUtiC4ZpjxcAkYsS9TzSl0+VzHPcKYse1yfDfFEx/3TOrn9cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWGOlQt/o7pWpBiLL73GZ3qQq+4Qn0hZTgYl/MpKGh4=;
 b=eQlL0Fp5vgL4lmBZ/GKUbklBcmpXvfKEumuMr4DuKn9V2ic9TNlAh0/KPmC5k0aCjzkMNW47Jygz8AohOm77+nZbFa1lSorO24kQ4zG7FlUS1M3sHgXw+J0JahL8zXKS7GYFMzWuwjB9BeZ6icjg8kyVTmkrlgiVIWgIuCHR4dRnJOuWCzJbVdFJdR4+z4gdkyCrnEWj+Mu4lVIMPVoPlq50cbRdSgROX0JjVbj5qE+UEbUzG6F4dBHlK/P75/L19iPHhhzhu9goAizVve8c4ep5OawK3nwvC/ypK6KZCf4xntN6CxGvGPRDZ19jnKezs1s5N+2udUWpVTb0ZkRMjg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3789.namprd13.prod.outlook.com (2603:10b6:208:1e4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19; Wed, 28 Apr
 2021 20:18:43 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4087.026; Wed, 28 Apr 2021
 20:18:43 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>,
 Martin Belanger <Martin_Belanger@dell.com>
Subject: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Date: Wed, 28 Apr 2021 16:18:25 -0400
Message-ID: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [sGMoNm12buRXgVz4EBkmhJu2AIcQsR1J]
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210428201825.72181-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from conundrum.delllabs.net (174.19.123.177) by
 SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 20:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 798a4e2a-3663-4b76-67a4-08d90a82d198
X-MS-TrafficTypeDiagnostic: MN2PR13MB3789:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r2faO+jtijnkClB6PyPYNcxEwan5sIzzExz2aDXnVepC4O0ac0QqrhJb1qDVCWAypk/h1GtevXITZ5TG5hbIxMgiiAyIpeGbknZ8YaBFlwXjXsjeoCacJGDtOeAeQiLmn+D6sK+r1BwUvLMbd9oCUWqzh0sehJ+BfFfQUMIT8yWCSEiqGFp5f+PF4Ax4YFB/3TkpQQ4yjZnd/6pLjDU0RPMzjvPZGr9hIhi+25xXg0mmMxmUEPT4QvJkUUovVy3ZtFL/70I9Piaver91zeW8ZJDGBwBGTK6UWPe7MpfN0wENL1ln2JliyEHYpqv1zt5456/RGLHCARH4MCjsQU2xNKVPimRQN1EEE0iJDBPEBgc23qvKUFDSYxb1uk/9RySFVK5VcX6UvR6Mw1MSs/DvA==
X-MS-Exchange-AntiSpam-MessageData: i92umyiZ3MGeIQuhHA14xi4jWQC7Vl4lxruUSxSUSuAjGbi91IlL9njY1fwciEWtpuzUqBynuTYwdb58+DmxvQSJz3mzteO31z2BIkNIewuYpmSvvzNkWiQFN19iT9F/VY4usYyvmaogo20WCQA/GA==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a4e2a-3663-4b76-67a4-08d90a82d198
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 20:18:43.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3789
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_131848_422496_8ECF5B25 
X-CRM114-Status: GOOD (  10.30  )
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
