Return-Path: <SRS0=YB39=7N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEABC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 May 2020 09:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2ED2070B
	for <linux-nvme@archiver.kernel.org>; Sun, 31 May 2020 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqzd7mQO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="q/GSoRD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2ED2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TvBg8tHONM9pbLSVTkhy65alKzHY5iQXna22X7GVgPo=; b=lqzd7mQOpy5LBw2lzYJfr09JI
	5c4t8Cjm2aIJNSeONYJEN+HwEU+k1c3pGviwIrjiUeEPb0HdY4qg8TpedozjFyfMT0ebZctr23riF
	YRdW98UDCXIP6hFb+M4eTlZXfqJMTKJi1Mf/iyP5PuxoQbz+bbZmvnqzHN/Sfz/Clf055WYBYi8UX
	g7FQTa3AOAf6a+xS6cWdB5C/qCg/TV7ysvXRyfJ+soYXUFwfifZftVmHerEsDh61ejixuUbv/7kb+
	XxXkmanf1vfi9YY/xuO0JhBF9Vgb+RDFlhERYQ2DihpPlS633VinLN/fvIs8sBW+g3Hgt7cWO8l/c
	0cLdPiuVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfJts-0003TC-10; Sun, 31 May 2020 09:05:00 +0000
Received: from mail-eopbgr140058.outbound.protection.outlook.com
 ([40.107.14.58] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfJtn-0003S7-Gl
 for linux-nvme@lists.infradead.org; Sun, 31 May 2020 09:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhLCIAhxJBEE6vlKec9KlNg2sYU0CoAsL7Vsi1xqFT5UTt6oyblYU/dpvrN+qV3U7j369AO/TjsDsVoE/tidVCXbfchVDcItfViaeO5HZYdhjnNP80R5Ao+c+qDUTudepKS/XFR3C2dJFdNgjri2JZG7TuFgFphSMQdWgxx5CVCXNUCI1za/jCDkwacvpDZ8K4fcRkP0y0sdv5ymjaxyIKgIqj7y4pnCJHcIQzPG8t8leMfYEcnUUfW7ycABMfByAy3YCVfTnAlWmWPXteoGJG6A6SNZPdcOXtd4bCeemUfkR0iGhhpYX0yFqKxy8+XPPktsUFDViwe+S8J5Ey8XTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=hObdg6o845jYmOh09UGSwC4nHd/swkBifco9VR5Mz+0sZt7uTwac+g57Wu+9OKBtWTj3YvTIXcX9DId/irIDhDrEzryiP+SbOcO187tJjW+e4lB2R6m9FOe1j4cemVAB14QXfSdIjTusrA1rw72+nwi1HB2el+zLJOTJvaIyDBAExhmai98Kv/80rcdalj+n7tOjVku9JOAnWBwutgY0bMIhs3QHSr3j85AdcA7UePAx9AFTw+mk2gn1zzqkO6twVZDm3Mn7wO48XoVksndjnnwOTlw+daEBX8ypubd2iJlYji0OdifF4q0I8Va0GTGO/LQO5lX1CTDVYFSmBqDW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=q/GSoRD4XGqak7zno7TYJMywRkUvIZFHpf8XJ9E2M+ti+mxPCWqrzt0WW55Pupb2iR/ESRHnkxrUSwGs4ubQSWFfVJ+bdknuSUzgOjXm32bqXguW9Y8kwMdO42ml1Dd1+6JTLurmSGavNi4TTSi09DWUah7ybomDcgWmBYzFiqU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5714.eurprd05.prod.outlook.com (2603:10a6:208:114::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sun, 31 May
 2020 09:04:48 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3045.022; Sun, 31 May 2020
 09:04:48 +0000
Subject: Re: [PATCH] nvme-tcp: constify static struct blk_mq_ops
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0a5e1752-95b2-f5c9-b6db-7c7830561ea9@mellanox.com>
Date: Sun, 31 May 2020 12:04:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:200:42::12) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM4PR0701CA0002.eurprd07.prod.outlook.com (2603:10a6:200:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend
 Transport; Sun, 31 May 2020 09:04:47 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0607691-ba06-4f64-675e-08d80541abae
X-MS-TrafficTypeDiagnostic: AM0PR05MB5714:
X-Microsoft-Antispam-PRVS: <AM0PR05MB571447C6F9B61A382F8EE467B68D0@AM0PR05MB5714.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvgmH7jPhXJErlXw6Abdk0oH9KYMFhXE1qPsxKuC1VeSvEI8G0iG5M88gvkEavbk6dw6qkwCKecyqDDTvdSD/nf9zqdWl9ubp5Yhs8gmAnrEH3tXAvFZhj/ezMftVSrywGHQJpAwLtxxDZsrVW7bNQY0detXXERSz2LeYz0+VyakXbgZxAcUUIQZX3cWSmKin4i3j0+NxBPrOwkMyAJNZCvJpaEptW8OzxaSXhMCu144SPP/eYaxhBTYrDnvkFrSE95gJiAYfSuvCkhaP/AG+6hYSMCIJ+/yxaU38qyeJ6r7lbdJc4iV1Wc4BEpVi/uodVvlBjI6x5cHjHQ8L2ykRl5ORl/mSvoaw9CfdQm0iGurTL76flYmJ4RobTswgAHf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(956004)(16526019)(186003)(4270600006)(19618925003)(478600001)(6486002)(52116002)(2616005)(316002)(16576012)(86362001)(31686004)(8936002)(4326008)(5660300002)(31696002)(8676002)(558084003)(2906002)(66556008)(66476007)(36756003)(26005)(66946007)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xhhLkWzZy9VQZM8K9phvfLnw9GclgmYokAJkWmxpM/tFi7PE0IQzwmxZi05o67E9oq6rhDHZgMhhMhJTTMRcOU/eLXm7OZmTgIFUffw4V6kQoFJRKfIOH2ybppz18aYzVGKymd6WBPCTWNLuk4OuryPUaN3bNvpBVjnN5wSCEJKdIdN1xTCl5H6Q6nutyKKesyVg35a45lgOCjKp1PlhFOiY2CpcFYso1QcWGq49cNUCVOSP32qC2lZjYYqIwKkqTFk5bm9g6CWwikwrHyjMNcrWcYED+OF8TeMo//iXFbxRuficINCA382qBZgvVMkBBc0DJTEBUDdDjYNlDoSQG2obcxig8SJf7gv76JKLgq8lsxikEbam//C6WFZ+dnw0+JckgLdz8CVTrBsAJ9ZfQnCpJaTAPr8iRJcU8ffvf/k+DmLYL0ddxylPSqjVLudb2WWRRTSGoGNYkpH8y1QxopvHqzv2BSzz66LlcQdv6Pg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0607691-ba06-4f64-675e-08d80541abae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 09:04:48.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7DYWkJL97aFzdVfFITbab2vsgBgP0YL+cijes1sUH/EexDwXJJUpZGeInRAlDDn73WsyFX6GHa8bCayHzaHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5714
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200531_020455_557400_859A149D 
X-CRM114-Status: UNSURE (   7.73  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
