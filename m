Return-Path: <SRS0=QWMY=3B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F8DC3F68F
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2020 09:41:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCB421744
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2020 09:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U/PFQyE5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="a0cRnOnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xJdATV1LqJx1mvI4HFv66t78B26QfkoLiEPfFhg1ydg=; b=U/PFQyE5NCecaY+zI9WMRxt1m
	RSIGFw8ogI5LfAzxNGjiPomrTzlmKaZXjUAqbWuKiar5ThoqtpRn8saLOPaDhheMVvplcKz3B8+k/
	N9YhSoY2MuBlVUXinsbTv285M/vRe1Fvvjmk7JDYI4ElwO7lD8NaTASxgK5rAjFfNNBQgwUUWTZUN
	Qp4s4OzxhPRdHp9srXcgwYX/6PPILT2f20njt/6ZFTvzpaJw+THeALOoFP1FcKsPlWimwmVFlaSlO
	m7f8g7GGNqL+h7IjzgkwaLE+fHMvK8Ypxmcb4GehVcQIab2+Soa+SMTUZPhsRqnyzdF3gfmeweuKN
	CZ9CTd2rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iqZjr-0000pX-15; Sun, 12 Jan 2020 09:40:55 +0000
Received: from mail-eopbgr140051.outbound.protection.outlook.com
 ([40.107.14.51] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iqZjn-0000oO-8r
 for linux-nvme@lists.infradead.org; Sun, 12 Jan 2020 09:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYJ6wGxQXliLUI9qB9Bl5RyRCx618cTBYzvxqYcvXMNi2txMgNydUR3A2nH1cDm+J0oHBdNcKW23vAkSr/H4pf+77tJIXnS/5SibcfBGdWMkxvw3RhiOj1yRApU9500vsA1s95BJd8l1vbb3yA992Ater+Qqs9TsYdMJUMe3uJ3DLFXqb7bngnw3C7vTy+gThTQBTx3q9XxIX4Mb3H5YEB0VFJXbjfyeSiYHr/7G6ckDSK5nRMublLCsID6cYpmrXI1C6fYLgpc3a994CX6zoHUzHmtz/ZdKER09BarsNDVXpqUQLflblcPAAKHsV/8na6Qtx12fgnlJQUuwaEiAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJBPlsxDAUert7aJk0OexSnrFdjDajRiu2rNhZcZTCw=;
 b=DMLdBK8UKLk2CQZGWkHNdlUyyVEjLw3IFx9FnA9Evvol32wXsiJfvTpu9DPz3KPEwOetUUvFn59G9rpKc32cRweaS646wRxaQT3nVZDU6Xaxsm+COumcyyCNFmF/fLXuml1lSWnDRz0auGtQOJzCTHWy7q5rigKVD6/kZ/G4xVJUcT3i4BK2mauq50BV/AiC24CO0ll1f7BbFu+7VbE7PSEuNwYoo7xLCsZoBmGbLogkAOrs2V9rGYgfbDnhTmNfqFG/feOTDgTyr1r2BC7Ro48uqZuS5zqCJCPwDBQG1WLLa/JZQep+DWrlTFJiUitk+ooFDZcwqoF3LinPoo77ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJBPlsxDAUert7aJk0OexSnrFdjDajRiu2rNhZcZTCw=;
 b=a0cRnOnkVbQaz2ZfuEYK4eD3ELr7K+/E+N+eELjyD6bvlc7IYNiktZEfzfrQl0XwdIOxbl+qecoP/JPNAIls/Z8405ifHif9KntpIj/4QIc/yjyA/3tnleasBvYTSjkvYkePlAzmuP5GH0yWZ/D9SaziajJeSgPFo4PqGpe/3lg=
Received: from HE1PR05CA0268.eurprd05.prod.outlook.com (2603:10a6:3:fc::20) by
 AM0PR0502MB3793.eurprd05.prod.outlook.com (2603:10a6:208:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Sun, 12 Jan
 2020 09:40:41 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by HE1PR05CA0268.outlook.office365.com
 (2603:10a6:3:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Sun, 12 Jan 2020 09:40:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Sun, 12 Jan 2020 09:40:40 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 Jan 2020 11:40:39
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 Jan 2020 11:40:39 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 12 Jan 2020 11:40:31
 +0200
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
To: Keith Busch <kbusch@kernel.org>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com> <yq1imllz5l4.fsf@oracle.com>
 <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
 <20200109162625.GB1032473@chuupie.wdl.wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <84cdf570-4fee-3396-ca4b-762cf3af6815@mellanox.com>
Date: Sun, 12 Jan 2020 11:40:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109162625.GB1032473@chuupie.wdl.wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39850400004)(136003)(396003)(189003)(199004)(36906005)(86362001)(5660300002)(6916009)(54906003)(31686004)(316002)(16576012)(4326008)(478600001)(26005)(356004)(2906002)(16526019)(186003)(53546011)(2616005)(81166006)(81156014)(107886003)(8676002)(31696002)(36756003)(8936002)(70586007)(70206006)(336012)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3793; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a9308fa-8267-4b5c-5238-08d797437cb2
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3793:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3793FAD802B8B026846C36B2B63A0@AM0PR0502MB3793.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02801ACE41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+x2NF0Z3JA1mdiuTktCdbhbNaAvBG5gKrlTVTbGBcgjER+9dxyDomQ/RDmdl8zk2pRNcpLsPD9gvN4isC/zP6zc6WoZfV3V1Q+p+4xy5Z/V3Aa8Q1VOkOvT0ggh63oSXQm2Cp9DC7hegYFBXhy+vFonMc8HX4puqpb1fpKL76hWvvgF4ClELOmB141GyUfhA4J1EtQN7eJLCC9PmSxph38SrhBUx8RB4mSpCENCOXmdjNGQuLqNxmQfmSkJq2MJRhKD/0UHOBPZ54Se5WzA7nwXOhayn9HiKBjOnbyBlMtkS4LZ8R7r9t97ryawbgKBNKfHSwM9V4NwAwQ5tln+b39EsEcckfeAcPJaYSpQoW6sHB6m7s2VKaFHiSqoFte6T+PHkGMrj2+fO/G/4iaDuuwL/h4cqvCno82PLbW/guAiObFeRqGgiC0OCEsTzRRhPpa454thpglwy3jrJ9zDcwW82ZeSE5ZX6okQ4GS3t96SK1z2qpZMut/DGXnGiUDG
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2020 09:40:40.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9308fa-8267-4b5c-5238-08d797437cb2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3793
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200112_014051_525266_6E79A6C1 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, shlomin@mellanox.com,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/9/2020 6:26 PM, Keith Busch wrote:
> On Thu, Jan 09, 2020 at 12:38:05PM +0200, Max Gurtovoy wrote:
>> On 1/9/2020 5:11 AM, Martin K. Petersen wrote:
>>> Max,
>>>
>>>> +#define NVME_NS_DIX_SUPPORTED	(1 << 1)
>>>> +#define NVME_NS_DIF_SUPPORTED	(1 << 2)
>>> Not so keen on the DIF/DIX terminology in this context.
>> Martin,
>>
>> how about:
>>
>> +#define NVME_NS_PI_HOST_SUPPORTED (1 << 1)
>> +#define NVME_NS_PI_CTRL_SUPPORTED (1 << 2)
> Well, I was trying to say earlier that nvme supports formats with metadata
> that's not used for protection information. The metadata, whether separate
> or interleaved, can be used for some proprietary non-pi related feature.

so how about:

+#define NVME_NS_MD_HOST_SUPPORTED (1 << 1)
+#define NVME_NS_MD_CTRL_SUPPORTED (1 << 2)


We didn't change any logic for metadata support for non-PI format.

>
> The nvme driver only leverages "blk-integrity" to facilitate allocating
> and managing the metdata payloads even when not used for integrity. It
> might make sense to give that block component a more generic name than
> "integrity".

Yup that True, But this patchset is already big enough by itself.

We can do block layer refactoring in different series..


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
