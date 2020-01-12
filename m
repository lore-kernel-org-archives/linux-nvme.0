Return-Path: <SRS0=QWMY=3B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB31C32771
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2020 09:41:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3242821569
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2020 09:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSLV8da2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Cjs6dIBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3242821569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xJdATV1LqJx1mvI4HFv66t78B26QfkoLiEPfFhg1ydg=; b=uSLV8da2tELbLMzOaSh054RTM
	pvp86GaVnV72j+zRM0hsDHdvurjqWVjsxqOy+Sf8q32WXvA3ggsWoozo90ZliSExm+WDqs1H6lFJh
	2IRB8SUkyySCO3s2B5ERY/X5W5J5lwT6Bu+zZsuiedGGSsLQefgBK4lj/lgQ2BOMTEYYlT2mvTo0g
	0bEUZAaz7T64j3gyvgon2brah8GFKAjtiuncg/f5TaSmLcGtyfpcQdUknAhMOQ3M4UA4A3p+Vr+Lj
	gAjag4vjSmybW3R+2mCEOu/m/D4ClwKQV9JWuKxzMCmIOpst8omNp9fRkceiroAT4h3L4P/Pr3ZAx
	z7CQyc4VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iqZju-0000ru-OP; Sun, 12 Jan 2020 09:40:58 +0000
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iqZjn-0000oP-7I
 for linux-nvme@lists.infradead.org; Sun, 12 Jan 2020 09:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epoEV1Zqpn83MQ3dza7VdiTpcj5QBidXdcxoNMPsKUdMBreB1JH3FKmXtk0qHL7sgpTvECvokUIXGS3qsnkIRn+Gg/C853h3hrfA72LcRv6/BPRDxEqllwK81HRiZ/bqQd+++4zVgJQDauHJfh0uPEEPauhL4TaWKWpK8gBYRq15c45+3Arzih0SghFfY6sEhb0qJXtdtGNr1BT0FdWShnrmLBx4c7wmsIY4xHsZi10xrVzPah0pvFsDWBmRxgSNmzBMxDHnNIjUTgxUFlxpY2LhvfhImmNf5gCmfWPVf/y+PGvpY25v5pCnnKofuTOVI5oR/gVXfITCZp6Ui9FJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJBPlsxDAUert7aJk0OexSnrFdjDajRiu2rNhZcZTCw=;
 b=KYTSKykurNtHSoLra60ZFILQ8wQPYYq4rZQfMN1Hgp4QNQMDbBs02WsGwSDYWdh0TbvuMJdir9oGLt66Olgc1QCWWAP/h08iWMslDQOLTFymJiVa8z15OpwdO35upXlANfvEgRd2JiLjCZLdiRKrxsJUaOZjb60vDMWNiX0TaV4LUoHdskPX+6Mr7QJFUe9ojmHR67DlefELVpWA4SIXDNjXJ0eMtX5mNRI9NA9KfN/2W7yvgF/foRvnWhgzP5MmN8SzFCv9Uv+QwC9as6nJemD40MXTDCeCbXvFQmimikX2d8dWYvS+Ph7St3HN8zdKygLnUc9gxLGPSn636oeWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJBPlsxDAUert7aJk0OexSnrFdjDajRiu2rNhZcZTCw=;
 b=Cjs6dIBP1QL4jKkHbpwU4vHOT38RsvddNIk1xtqPTeo/+OMVROUe2wWvhXF4qR6xqg6ZrbIJVthHGKBvVGhKjNEci6/g7VXlvZ3T/xIIZY7oG5Vaf27ozGq0PioExG/woXrf+EOlXdU97L77n+OhiK1b+zWQixvGOXYnzgCJKOM=
Received: from HE1PR05CA0278.eurprd05.prod.outlook.com (2603:10a6:3:fc::30) by
 VI1PR05MB4638.eurprd05.prod.outlook.com (2603:10a6:802:67::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12; Sun, 12 Jan 2020 09:40:41 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by HE1PR05CA0278.outlook.office365.com
 (2603:10a6:3:fc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Sun, 12 Jan 2020 09:40:41 +0000
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
 15.20.2602.11 via Frontend Transport; Sun, 12 Jan 2020 09:40:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 Jan 2020 11:40:40
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 Jan 2020 11:40:39 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 12 Jan 2020 11:40:35
 +0200
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
To: Keith Busch <kbusch@kernel.org>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com> <yq1imllz5l4.fsf@oracle.com>
 <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
 <20200109162625.GB1032473@chuupie.wdl.wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <8d054ad9-7f66-9808-7b84-524446a4d0ac@mellanox.com>
Date: Sun, 12 Jan 2020 11:40:35 +0200
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
 SFS:(10009020)(4636009)(396003)(39850400004)(376002)(136003)(346002)(199004)(189003)(16576012)(5660300002)(316002)(36906005)(107886003)(2906002)(8936002)(2616005)(4326008)(478600001)(6916009)(54906003)(31686004)(356004)(70206006)(70586007)(86362001)(81156014)(8676002)(31696002)(81166006)(53546011)(36756003)(186003)(336012)(16526019)(26005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4638; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb08c375-e36f-4251-27e0-08d797437d30
X-MS-TrafficTypeDiagnostic: VI1PR05MB4638:
X-Microsoft-Antispam-PRVS: <VI1PR05MB463856A00EF05C855C43A77FB63A0@VI1PR05MB4638.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02801ACE41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbSGf4+Bn5ZbHbYGlq+JcX9P7V9R5Ry2wla5XaCE2t/FqlhfUdxdCpPcGqjgjueyZCNW6MJ9PlHoGN7/sYqV3v2kBg+61WpAv+7ySii9AGDdPGq7NY03s6Rj/MMexjyKlR73L2WZpq1/vitLvJwV8qJaXT2hOCWD/aOklqCEsa7SKSYekdMWBrV04EcFblu5SZlWcmWiqRHvlcSdP+JrGLnvkgk4u15DdwOQvv8lyqVAGrPlEnF8Kbca/ZtXekU35m4QTDJdTOgSv0rO4foFN4LMeKt0WjF4Sbgbn3IVisCmfcAm6EyC4wM5dBRUGcnhEJF1dSvS+7eDXHjWQbCpMneA7WxDVyb0ygOhLK/5t2jeGwFPPNNfoZ/KSkpC9wZnUzy0HRUCr8i1bXiBgQQH70B70Ulf0QZgPrlOHh9PsJrcFJuXINRyzSWr8HtKsERQqsVLgPn7QFo6tZQnMQMZEH0zn04IzS0IPK/wVwUDZpW8sOXt20QENKXwXkmC6+Ew
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2020 09:40:41.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb08c375-e36f-4251-27e0-08d797437d30
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4638
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200112_014051_526696_354720FD 
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
