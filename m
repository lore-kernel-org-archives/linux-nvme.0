Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5FC3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:30:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CC820732
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUBv8j7x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Kt+nk7bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CC820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iTzrcI+IkayRdGVQbzs/blRJRDDI02hmTHYdbdvYNWg=; b=DUBv8j7xY+Ogsz92XqZyLInJR
	XXxfaNbzVl0r0Qqnwzzv94Ux0w4W+B/bGukwN+ppL+QgwNqFihAF2jOgcRwM3iuVZLExwxiP6DzVU
	jLBa3u2gcCF8lwPwzUKQRKXMfJYXvPtaVZ8TRIkGc3i93CzILw6htC4c8mVyIP/3e7cKodKXvLlTF
	IIUTXVhtf7PYCEnNinPm3V5PhL8t131fIao2pMgs+kioS5nu9IS/b4VZ/jvBhfnDNeO6RdPzatqBx
	F3skDYqqp2DAWa4CKbQcaf3CGe/vXrWZpehSM3hS07tzM+QxTn+vQhdNsqc9iWqDSh82D9CrZ6Cuy
	Rp1SkJ5Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wv4-00089w-GT; Wed, 04 Mar 2020 16:30:50 +0000
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Wrc-0003S2-Qt
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPeHqKjEl76VMuJjHzTgThQ3n1v51qlEIUDX3EYogZplqEE0tRldLhVSiwRk6djNxxBUuBQsBdL8ShBF+qLqWua77jF0A7qu0Q7hJBmzAavjGda+bKp3qdozLpnMquhxt6vgKDqXPjRO/norP5kibW2lLRSPooFV5hqGNS1C2GHj06HUcYOCUe0AuuTYf02JiumpMa7fR1E9kDBrE2cKuJjX0a9DVsyC71hNHTvTJA4EiicIjpoUSScChNQU8SPCWjRdy9EuJPZZ3z/wRkB+hdU5Y2T1EosivCcLtshZCrm7pG/gzxZEGlY3lAzPhwyRInm/+cFo7IshQuQ3B6k3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UjPepjQ4Njv+rZKby4wkrEyxspna1jpBbajc7mgNQg=;
 b=DTumEEokrutbAWojDsNfKtJMr5G8qk/KXqyGzr0+pb4ilT1LJyEraLYtU2j6i6KCtSUkTJup0vXRpfiZXexd2/0h3yljLmZqXCroh1iV2pUEGNxt0D1lPGZwgXp6u5MQvvTerHFj6ACLTfZS+Qie7pa8Wba6n6O5Gc7L3cfX0QE1+vCQLQDxXBJ5xzqw+g30uEg6uJDb2uBgsb9Dhrww0yeeCY+zjKPVLTVVNWV7vpopAB+QrhpogMalo7ZleOyEcv30T1xsYqmcyMDlrxSrs3FD/+1MT/kga7gTprD++jM3vzDah8Wu/SCTNnsqLf6JgGWApIR1a4SrVwMmgDhLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UjPepjQ4Njv+rZKby4wkrEyxspna1jpBbajc7mgNQg=;
 b=Kt+nk7bBSfAVmbN/uKiH4l8n/kExAfmrU6wqKiAhmgGVKpYV1g0AEzKwbUMB4Bdj4w6ETWHWET98S64cxoMnm0KTTwkjlLeGD/dO2VVguO6ic1ufOLKiZGT55vWi4W1+bTc9AZED4oFg9btjiv44DuBhiWh8e6WetuJ9MM39NNM=
Received: from AM3PR05CA0086.eurprd05.prod.outlook.com (2603:10a6:207:1::12)
 by VI1PR05MB6719.eurprd05.prod.outlook.com (2603:10a6:800:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Wed, 4 Mar
 2020 16:27:11 +0000
Received: from DB5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM3PR05CA0086.outlook.office365.com
 (2603:10a6:207:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:27:11 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT042.mail.protection.outlook.com (10.152.21.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:27:10 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Mar 2020 18:27:09
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Mar 2020 18:27:09 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Mar 2020 18:26:15
 +0200
Subject: Re: [PATCH 2/3] nvmet-rdma: Implement set_mdts controller op
To: Christoph Hellwig <hch@lst.de>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-2-maxg@mellanox.com> <20200304160105.GA10897@lst.de>
 <2e4190bc-a12a-5eaa-af53-01889f2fbb42@mellanox.com>
 <20200304161812.GA11453@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <265567a5-56d7-4d82-48a9-496bfb25a97b@mellanox.com>
Date: Wed, 4 Mar 2020 18:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161812.GA11453@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(70586007)(36756003)(186003)(5660300002)(16526019)(26005)(336012)(478600001)(70206006)(4326008)(2616005)(2906002)(54906003)(81156014)(53546011)(31686004)(356004)(31696002)(86362001)(81166006)(8936002)(6916009)(16576012)(8676002)(316002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6719; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eefd54ca-3118-4eb3-6fc9-08d7c058e3e2
X-MS-TrafficTypeDiagnostic: VI1PR05MB6719:
X-Microsoft-Antispam-PRVS: <VI1PR05MB671931493F09FC64B08E6F35B6E50@VI1PR05MB6719.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TSBZ55LgHgjxB9KfQaOFBnvS+sPhoe8PMW3WwiV8SmFbMQKWKOUE/VMOBRtSd3+WmeVDXTd6iU4CL+qxDjp9YTWnh/nOQbOviiyZb0sC0qPEOyXTIyqOVzU9btxL8S3H28YFoGb+oy0FummYOVO+PPE0AyFc4n2yZmwWkxZp4fBsntqY5OkDarvVe84cwrFZiSOt88u6coGoP6eelgBabYxPc4qNpajZSLBeI5ctdokSwSjR/S1tC0qDvW7YiCstelIYlOkGeDTDgksNh1GnADD52ln3HgLAzETtpE/tY/K/c8xmgFv+5fxoQYiAMHqYaERqUweowIy5M9qSxHXB7dLVCgS16yzxAIcz4ug4OfPGp4os5W/WRYjVzEkQQZp85lJdUdM2IGZ2GQNaYt5Hqw4LMqRkTGJ6NeNy68+X2Ez4ScEOk4JNcfguEwCyqrMznyHqDQIxktVOY43qoFHg9Z6ol70c4TACGQmg7UX78NtpJwOaROv9UUF1/vkep48
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:27:10.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefd54ca-3118-4eb3-6fc9-08d7c058e3e2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6719
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_082716_886002_74422CD5 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, krishna2@chelsio.com,
 jgg@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/4/2020 6:18 PM, Christoph Hellwig wrote:
> On Wed, Mar 04, 2020 at 06:15:55PM +0200, Max Gurtovoy wrote:
>> On 3/4/2020 6:01 PM, Christoph Hellwig wrote:
>>> On Wed, Mar 04, 2020 at 05:39:34PM +0200, Max Gurtovoy wrote:
>>>> Set the maximal data transfer size to be 1MB (currently mdts is
>>>> unlimited). This will allow calculating the amount of MR's that
>>>> one ctrl should allocate to fulfill it's capabilities.
>>> Do we reall need an op for this vs just setting the field in
>>> nvme_rdma_create_ctrl?
>> This is target side :)
>>
>> But we can add it to .add_port and limit/set it thorough configfs as we do
>> for inline_data_size (with default of 1MB).
>>
>> Let me know what's preferred.
> I'm always in favor of avoiding indirect function calls if we can.  But
> I don't think we need a configfs interface, just do add_port for now.

wait, I forgot that this will not be compatible with adding MD/T10-PI 
(under review) since a port might have a pi-ctrl and non-pi-ctrl.

So better to have it per controller as in this series..




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
