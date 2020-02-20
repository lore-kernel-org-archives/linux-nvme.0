Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A19C11D05
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 15:35:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E79207FD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 15:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEJfdsCY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbxOxRcl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="e8i8Agrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E79207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oyaCWDHmVDKGgl2t9UirIcGLdhGEptXU0ftJGU1xx9E=; b=XEJfdsCYIPZCTeqjzyYPOykAt
	Gs02ZaEtGknDCOS4xdhaHNqXxVXQp3C5LgZwC+8nt0eGh3WFq5lLUl3EvZzTDUnuFAyUyZYE0j8TK
	GRJ2QXqFkwuvmmSgvPFjcJkOsHbRTnICLu4YVuXuY5fSXOWV2a9Fiv9q62eWoGyj++dPNzRP0MyWd
	f6Xt82oHiJACbWvLzJ7PnrVS8mHTZW8df/tfAJHqwqoFSVfhiyKoZXf5nlQliP37BvzZ5T6heP+qM
	URmfgqWWL4IZ7VObqumovu7xSg2Q2IZjIlf/Jlhx3Q+dH6m24eiWGdRZdpo6Jt0L/mGSOB3MVbgRN
	qmziaT1iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4nrd-0000xP-O2; Thu, 20 Feb 2020 15:35:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4nrb-0000w2-Rc
 for linux-nvme@bombadil.infradead.org; Thu, 20 Feb 2020 15:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=NceS6PNWQSp2qXCOfgMHb1I+lCAIx68sSw6BTbJGhxY=; b=HbxOxRclwxleSPlncTyKYQPOH4
 tt2//ZwhRwSA3F7ms9+nnRAdnXYpkyD5LuEkJCAmSjs7uGbg8lJGk3YZXI0eXaeAxEO6glc9i61qn
 qsesjvugJM82jcvBgF/SEWHJtIafkdkqzMa+87YZ0MTYIrXWLT8TvQi0psvqzSYitrHD1mMg55kQ8
 cV1a5lVYHCPOA2C8cMTomD4mTQDvG+OoxFtq+Q2rIFJHTX5Azpt1UqZ9KwuRq4/LTnorrUudATZkl
 mpJUV6kMIB0nd1B4Ak4n0sfxED0xB0ZjEkOOv7Rud9R1qAo24cdlo6ESxEa0iPwSED+anK7ARN8jY
 siLgXzYw==;
Received: from mail-eopbgr130080.outbound.protection.outlook.com
 ([40.107.13.80] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4nZD-0005vC-Vu
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 15:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARHuHa2lNEn8KgMPOpWAVu55oS4La5fhUXmaR2fZ+mt/X421pZKkrep85nHCvOIP2aO2IXfmLeSdMfWu6WTEl6YNr9QPVtnRNpzqgcyADD7PRz7kfoPQ3VgJ3YhLLYK76b2LM4zYD84d5gOYsPo5zn8OXe8D8gNpXs3qZdkrYXXaqDf9I/EzGpwH/S6j5i+0h09mrRr6yx4y6ULd6H5355EvY7VzPW2gXaUqscR3vgImwG4zl45Yvp4QkccOVyAU+0IVVIvP+x9eZ5QCUWAZbWWptIZLCFLrL0OFUJNM5ypwApa5MXbNTiMYtSQALorfGTETZ5aQ7JBSauwETie2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NceS6PNWQSp2qXCOfgMHb1I+lCAIx68sSw6BTbJGhxY=;
 b=EFMepT72epufFD1pJ+7ZUiFaHK4NBlSV76EHTZIBWNDLr3RBm1cBqwn8VmTYv3hUjrczH3Qk/Ag7VbFjLGPOliEceXZSlzUrkUL6Wlhq8ZaRUVeGVIA08f8WfXq8YwnkAMKOs1s8AmqasJD+ZCDlL2s6L2CF/IHFQy4Wa7X4Bq7ih+iFrmpfhqO2gS3cVpuS0zcmOUweWF4RBGct8K6bgInj80frwSf+LQi3l9mdZxvslcsHitDJ0MBbStlFRKXoVlYDeaxIFKDFDoAdEdm8SrF+fIEcO2BnfTLHQ3fhtBLHCXOqmmfTzg0+fjJd2UDcWf4528Xryiet5ufKnPYnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NceS6PNWQSp2qXCOfgMHb1I+lCAIx68sSw6BTbJGhxY=;
 b=e8i8AgrgfHnqhUVTaooODK17hgtYl/irQY4RQk8cEqSSooPM83TQ1NNS2at1GtFGGsp98bFtCHliDkveWCVRmEC67W4/dmo9h7JCHMetZPy1bOOYSUgNC5+BjGBZL6t5z3YkAPsgknu0nFsRuzimCjSSVWsUqIWfnWcvUhUefWo=
Received: from HE1PR05CA0144.eurprd05.prod.outlook.com (2603:10a6:7:28::31) by
 AM0PR0502MB3987.eurprd05.prod.outlook.com (2603:10a6:208:2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31; Thu, 20 Feb
 2020 15:16:38 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by HE1PR05CA0144.outlook.office365.com
 (2603:10a6:7:28::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 15:16:37 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 15:16:37 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 20 Feb 2020 17:16:36
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 20 Feb 2020 17:16:36 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 20 Feb 2020 17:16:35
 +0200
Subject: Re: NVMe/IB support
To: Christoph Hellwig <hch@infradead.org>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
 <20200219152053.GA13942@infradead.org>
 <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
 <20200220142517.GA20993@infradead.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <cd2f6306-1c4e-848c-9075-f89ce5f3a9ac@mellanox.com>
Date: Thu, 20 Feb 2020 17:16:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200220142517.GA20993@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(16526019)(186003)(26005)(53546011)(54906003)(4744005)(336012)(2616005)(31696002)(86362001)(70586007)(70206006)(356004)(31686004)(5660300002)(3480700007)(16576012)(316002)(478600001)(36756003)(2906002)(8936002)(6916009)(4326008)(81166006)(81156014)(8676002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3987; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01f8914f-7db0-4ac8-c943-08d7b617e158
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3987:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3987324A470649CF2DF5B64BB6130@AM0PR0502MB3987.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORB8NixkB6L/j1zfn2TsS/6yQUnPyAaW3ITEghhgJLE7xJl+yMqTRXpcONv6hMejm1MPCPn3URnZpZvDWrIqfpA9Gmsm2QwB6QYnpVOYa1P/dR+jM5WiTdpQJokm6DBBm/dPrOsQmxe+KxF0lxMbHqggGUZ1YI0FUtKgjDL0ov1K/PS+wQjGRssRAmOk8vOO2ObMu9RfNHud10m0XO/UBoGwVIYdaRk4Xzf9++HZBODxlkyoqmjDpBs1H7FGiL4HyUfKygrK85X1RIjAsCUcV69tU+VMQYQd2JP18eZVzRnUkR5nwq2V1ucz2DgmGYFPSjrcLb39NQ7vXvNFX1GpRzskhjNCzrLFawqRkXq0wggjn6vDMKBFku9xLHOlIqIJYKvlt31BNS2MaruSsIyrn08acOpKiu5DgqOQhFfccUFGJ4ScRjK7lL7PsIwjSa9bJQMWp8L7jZRKOF3Z6Oy44H/SzEnhKKOzRW1/Xlzxo2Nka7XOPQkTymAy53WnkJEU
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 15:16:37.5558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8914f-7db0-4ac8-c943-08d7b617e158
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3987
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_151759_928019_B4D82D14 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: Talker Alex <alextalker@yandex.ru>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/20/2020 4:25 PM, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 04:13:07PM +0200, Max Gurtovoy wrote:
>> On 2/19/2020 5:20 PM, Christoph Hellwig wrote:
>>> On Fri, Feb 07, 2020 at 03:43:22PM +0300, Talker Alex wrote:
>>>> Hi,
>>>>
>>>> is there really exist NVMe/IB solutions?
>>> All the original NVMeoF development was done on IB, just using the
>>> RDMA/CM IP based addressing.
>> I guess we can consider adding this code one day, for users that can't use
>> RDMA/CM (SRP supports both options).
> The NVMeOF RDMA transport requires RDMA/CM.  But RDMA/CM can also use
> IB addressing, which should be easy enough to implement if someone
> cares.

Are you saying that if one would like to use ADRFAM == AF_IB, he must 
have RDMA/CM stack that support IB addressing ?

seems little bit weird requirement...


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
