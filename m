Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39780C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC0F214E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VbKnRo/o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="esrwQRwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC0F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w8eyGufTKSyDg25/zmkh7vb4voCo+zAqVh7mFJk+HN8=; b=VbKnRo/oGKLKQZrFp6Z6Usvze
	2doIV+pcddYGC01mfWHj6MYYVdsHGpoHy0Y0aVy9ozDGzaWSIGlElO8x+kGHvCMONWgESZtp6QGjY
	A7E5waM1HY0Hz5yNZmwuaohRSjvBBNQ3/fh4yVbMsrHh/oM+qLTTQBFTy1fjIcusKSA9ASvspSdpe
	MfmfXC40zOtFcARP5EL26hlyKbQMNZJWly0ZPB8W8qhVeB/cCK9S+w/9BMGCa1f50QTVWrsWy3+kp
	QL16TvlroJt21SwF4NkronAn6k4NnTYEoidYdJ4szVWrRNRZB5VJMwMPISDt26Ywz+MTSAMf6227U
	ysPmBrSiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIaMD-0004nu-KQ; Thu, 10 Oct 2019 15:28:01 +0000
Received: from mail-vi1eur04on060d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::60d]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIaMB-0004nI-8d
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 15:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM/iPoDoBnIOBsU8vL2Hq8aSrm1XOQ6iR2jOG15aeJ0VON04aO5XpdatmlbRa8tL/uPqASzOlntZQTInyAw5qa8RR/fwYD4FRNGJRBN54yMrrjmHOjPCdYHASHpzomK6tVWxRKDoZEmldGCGt5j4xOsCa/TkyAvM/4ZvFfBG/y5/sR1RRuc8tXbfVCEPkuGUed+0p7KPiOSZv89XOxysx0Bno1Z3zh44K4bPNqdE4kK6zO+TkypbLu+lpbocdp4pKaqE7KHiZPNpbZuVepSK3WtJ92h/LI5C5h6+taphYmSKq3B38YLRFh4VLxA962wG7fYh8Xx9TtvKCo9CvhMYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdZ9d/Hknf7vI4Dc9IMn/VoUxB6i1BVOG1Kqh5BjOFk=;
 b=IM8qp10HYSC0i6YLB8iwsi/rMOBI+dFwxo9ISBAZX83yXG/+AEe5HLFwVJZ4phXk0HCjhvKScLyXAc6gdUZuJ8uKbq1xyAbOG6L8bwZ9S2khrz45A5Mk5aRL9jRYXYiduOTfoWkAI340cndkzzzNTttUA3dKcpiTMiP1fkba4P9iQ09BB2ieMHt3VnmsmnVNtkQnabfxn+FiA4FyIhbtpAnJvW/kO7mFz4oUBdYyVdjPSuTjUimxmFtS+WtvrPgobRi1EVx031Q/CASjoZTdYy+jo1fRWTmCVa7uInAzjLgJ99x71zM3ER750eT8s1LEGGoWzTQAWyZJ9g1zn4I7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=broadcom.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdZ9d/Hknf7vI4Dc9IMn/VoUxB6i1BVOG1Kqh5BjOFk=;
 b=esrwQRwciI7Sti7Llxdsmn4Io53JBnqXa+oYnrR5IlvPHKm5iHYu1ZggfRQEtdAo8ObVrf49puYYVODq6azvac8OMzLYNgvS7n25z/wMb3b2EImfni5kEGEipb0lB/71CfU/nnGlS+93zKdtaPUJDv/EaPkywwqMaSW99V45cJ0=
Received: from HE1PR05CA0332.eurprd05.prod.outlook.com (2603:10a6:7:92::27) by
 AM0PR05MB5939.eurprd05.prod.outlook.com (2603:10a6:208:128::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Thu, 10 Oct
 2019 15:27:56 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by HE1PR05CA0332.outlook.office365.com
 (2603:10a6:7:92::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 10 Oct 2019 15:27:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 10 Oct 2019 15:27:55 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 10 Oct 2019 18:27:54
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 10 Oct 2019 18:27:54 +0300
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 10 Oct 2019 18:27:53
 +0300
Subject: Re: [PATCH 3/8] nvmet: add unlikely check at nvmet_req_alloc_sgl
To: Christoph Hellwig <hch@lst.de>
References: <1570714100-15520-1-git-send-email-maxg@mellanox.com>
 <1570714100-15520-4-git-send-email-maxg@mellanox.com>
 <20191010135142.GC31487@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e60d33b0-4cc2-4cd2-24ce-cd792ad71409@mellanox.com>
Date: Thu, 10 Oct 2019 18:27:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010135142.GC31487@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39850400004)(346002)(199004)(189003)(36756003)(305945005)(4744005)(446003)(7736002)(86362001)(6246003)(336012)(11346002)(6916009)(31696002)(2616005)(5660300002)(478600001)(229853002)(81166006)(81156014)(16526019)(2486003)(23676004)(76176011)(476003)(2906002)(31686004)(16576012)(230700001)(106002)(3846002)(126002)(356004)(186003)(65956001)(65806001)(36906005)(53546011)(316002)(4326008)(47776003)(58126008)(54906003)(70586007)(8936002)(486006)(70206006)(6116002)(26005)(50466002)(8676002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB5939; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cdc2221-9d8c-4b03-65f0-08d74d966c97
X-MS-TrafficTypeDiagnostic: AM0PR05MB5939:
X-Microsoft-Antispam-PRVS: <AM0PR05MB59393CFDF5BE63F1AEDB51A5B6940@AM0PR05MB5939.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 018632C080
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6p0cpRtBWbiP0Czn454e//4RvmsF5M7P8ueC4sFcf1rvipaPIN9QTLXE3B988Y1mw4oxMwyjHLz7oeFLVBDtwHl688IKGEDtv2Bah5IXVSNIf7F7DNh+GbS88k5TrPd4XFtqGtkNthwL1s+mxDL5Qjl6lec82eDM6L5P2cspDnxp2kmbNOMpC2iCZE5VAaNEfM+sYpXcgDSsV9L2uNd0ZbBDmvJq6/obW2h3zvE45XrB56DMwaXeivFDqMyX1FVxaMHsDRjrbRnv/6TvsBK8KyfiUk/UjE2EYOEpUwEBfXWiYCUOs6oemeNq0Fa4SVgjlNRkjyczZe68cyff1/rjDNjrZb+M4DZdK9C2C0cndQdwaaSLQysvCpT3nS2NuvdGcwvWyzLupSasK04SLXPVH6/3G3AurOQVxO2OURFMuE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2019 15:27:55.6117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdc2221-9d8c-4b03-65f0-08d74d966c97
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5939
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_082759_369023_CD5E5ED9 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/10/2019 4:51 PM, Christoph Hellwig wrote:
> On Thu, Oct 10, 2019 at 04:28:15PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> The call to sgl_alloc shouldn't fail so add this simple optimization to
>> the fast path.
> Does it really make a difference in practice?

one adding of "unlikely" will not make a difference but 100 will :)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
