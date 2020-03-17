Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6CC2BB1D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 23:27:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFC120674
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 23:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bg7mzt4u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Iw0ra1Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFC120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6qhLdoz48roWcKsXq7MR4Dgep42HVHSw9jkbACGaQVc=; b=bg7mzt4u6iWnAcZSgkh8+CQB2
	ZGoMkVJlOkEOxvkA7G46R5Cgvkssj4mWAHMhCDDXSStg+PCbVwUwKmAwF46MZEyEM7lYTz9vbE+kL
	fYKtwmOabXpm39/Z+3veDDJKsDZgoYprCnbWeLWSMUHb4ud4Lnatf6fAQcO1oGPHi2qcYpTXVwr0b
	Fl0O9/vRvhCCdestGgcNmW90iPpI/qMNo1Sh4lX16FRavmD0ttKVsKyW9L3mpSfMWnx7rImGEhXMe
	kwoyBWlvijidWbBwr10pjQ9P0vTmv/t5BULbANM/eOKpezOJY6GXK1Wy1zxaDnCn/so5CKBdW2TnK
	VkCY99Fyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jELbt-0002jt-9j; Tue, 17 Mar 2020 23:26:57 +0000
Received: from mail-eopbgr130079.outbound.protection.outlook.com
 ([40.107.13.79] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jELbr-0002im-4N
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 23:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL49s44ywdChzD2gkDjDHF0WWfEIeWDmvJC8wG5y77mx2RQvRmYkc/4w+fi7/JwpbjdXNL5fLmZrWabzQM7/H98rh78KLTh/1i2aLlsbO8FfvRD9PlWvTL8e6IXYnQs0EEgvqWmt6HS0CXbex41qIVGNSjvM+cGVVJby5LQRywsKh/HinF77YlP87INhCgO72lwLrhHJgg+34YgkV4rDQ2qDyOU+fmWBbQ2ZMM1V6nT/dy4evIUPVg+yA7nX21irQ11I6a00hdREUjazPcQZe/DBjEwY0YQzoiK2ZJp5pF6LATQps9HdGABE1GDiuzO8k6zUqHMRVlu4UFq1Z+iztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4tUj3LswrW1UZM0em054v56iZjKUiswrcnfGM3WBY0=;
 b=akbaqu1J5A9i+RPah2mdqqt6iclZQvheOIpEwloApJJbBbbvDLqf9m3pSknkDUnyZtBWsB8CFN4gDEvBzC2ouG2c/yihd2jhbbzmBvtnW28lY0OkaUL4CbTN/I+NQ/N+TP5YRuywDYHyJk2bjgso/kyWGp60IMRnoTkOex5yUv61ebciInli02WviVwmJ08KKp3WWWVrWgtDjMbnZPOSwVoTGIbhR9wjMMm97m2HAK29QHI4eI5oReqZxVVeo+/aOtMrC39rYeP6ZQ6S56c8hBdOyieypdAGKb90VRuApGOqv+fSwHcvACFd0WgvjeBpuIYeRp+VEsyXgGyxjB0Pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4tUj3LswrW1UZM0em054v56iZjKUiswrcnfGM3WBY0=;
 b=Iw0ra1LqlJ64F/n1jmSpoEfrqUL3evzdFOqBtynq/hQxbgBBF2tdjACWBWRtQ2lUapZCtUe33yzaDjYD7ByxRRC/IcDPKErcj6rUxSlq2OS/CEcBHQUpjMaJKkqnWrPkicp5FbcyUU2+9JZLPNla8UxvNc6hXYIKrNRVUIt8ikY=
Received: from DB8PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:100::31)
 by VI1PR05MB6013.eurprd05.prod.outlook.com (2603:10a6:803:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Tue, 17 Mar
 2020 23:26:47 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::3d) by DB8PR06CA0018.outlook.office365.com
 (2603:10a6:10:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Tue, 17 Mar 2020 23:26:47 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 23:26:46 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Mar 2020 01:26:45
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Mar 2020 01:26:45 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Wed, 18 Mar 2020 01:26:19 +0200
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
To: Bart Van Assche <bvanassche@acm.org>, Chuck Lever <chucklever@gmail.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
 <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
 <caa4b25d-c669-8a3f-e4d1-88f8d3a4f345@acm.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <dadff64e-802b-72aa-71c8-a92595fc41d0@mellanox.com>
Date: Wed, 18 Mar 2020 01:26:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <caa4b25d-c669-8a3f-e4d1-88f8d3a4f345@acm.org>
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(199004)(46966005)(110136005)(16576012)(316002)(54906003)(336012)(26005)(186003)(16526019)(31696002)(70206006)(5660300002)(86362001)(70586007)(36756003)(2616005)(53546011)(478600001)(81166006)(81156014)(47076004)(8936002)(356004)(8676002)(2906002)(4744005)(31686004)(107886003)(4326008)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6013; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 529f2495-2d10-4a28-d58e-08d7cacaa974
X-MS-TrafficTypeDiagnostic: VI1PR05MB6013:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6013576B8C0B91396B6AEF61B6F60@VI1PR05MB6013.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28+DKMKtaAc5ib7GgFXY7t/ZE3164LoletpTjARYsFEfXsdpHfrfC9BffP9JnjhgoHHMON3EdI0kL0vXDPgAF9EFyqgB92ebCWZYMaPc8yKgACY1BRle40F94FpSz+O/txevKE82LoPg4+1nrSC9Wh41lAvbKZJDjyi8VlrF7A3Nhk6P3TswTJch0NSB57ZgqaPhYH+SRuHZYR4FYHEFuDDpjEz/FeJfaf8L2/xF96o/xYIPRpr1m79jjZXHMPMx2VzbTjww4OFzcGcaNgaBf2KGSaHa1qvvDimDgN9WU2124w5IPHcJ2egNMgCF/dx8jCE0RIgWyuddVSCFYViif0/tBqhkhsy6f2hjucIdyN8Lzxmu2CMvakWnYobzPjYLsb2ygdlc0tnKMNEUOP2rhhYrH4PjHz3IRyiOTd78Juu7HhVmRcmZjMCbPWHqlndgK65MFRMi3NSyZ3ljd6I7UtUacVyt7MuQFtX/xXb2v+VupRF+pmnwiPpoUoozeL8aK2iBxU1S6dy/y1bGdpGWlU1HuNvG21rHqRG7yYldfsw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 23:26:46.9543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529f2495-2d10-4a28-d58e-08d7cacaa974
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_162655_177761_137D394D 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: loberman@redhat.com, sagi@grimberg.me, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, leonro@mellanox.com, dledford@redhat.com,
 jgg@mellanox.com, Oren Duer <oren@mellanox.com>, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/18/2020 12:50 AM, Bart Van Assche wrote:
> On 2020-03-17 08:41, Max Gurtovoy wrote:
>> On 3/17/2020 5:19 PM, Chuck Lever wrote:
>>> If you want to guarantee that there is an SRQ for each comp_vector and a
>>> comp_vector for each SRQ, stick with a CQ allocation API that enables
>>> explicit selection of the comp_vector value, and cache that value in the
>>> caller, not in the core data structures.
>> I'm Ok with that as well. This is exactly what we do in the nvmf/rdma
>> but I wanted to stick also with the SRP target approach.
>>
>> Any objection to remove the call for ib_alloc_cq_any() from ib_srpt and
>> use ib_alloc_cq() ?
> Hi Max,
>
> Wasn't that call introduced by Chuck (see also commit 20cf4e026730
> ("rdma: Enable ib_alloc_cq to spread work over a device's comp_vectors")
> # v5.4)? Anyway, I'm fine with the proposed change.

Yes this was introduced by Chuck, but no contract is broken :)

I'll update srpt in V2.


> Thanks,
>
> Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
