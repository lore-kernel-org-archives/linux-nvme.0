Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A3EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:44:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CD561178
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92CD561178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kG9B6tYEUIKMZwaWjJcj4plBrHfgwa30M17nT88raI4=; b=GSjUnMIlTBJ4hPYqMq6uSy18fj
	rerSBoIHX0+JPF0aG2MOwN7keyWto2rpQMo3/MOLUhJ7quBfGW/vlWJLSiYZHEfuEAN831g9TCQYi
	C1YgbLLsoUFtb0jbZJUbuUn0KaOTbUEjlRVfAFilNsZsWyHi3WjKzNRrPaNYNA9Umfi+FPcbkuSzZ
	NX8z/1DPtXkd77rdBdA+l9SMdT2NB8bXu/F95q/Z+nKH19V9MbY/nOWazkUDdMdu5wzYsPrNGjiib
	VLOLdaf2u77GCNNWTJiPeGyI1dcH/JC0nKsyjS7hWmovN6cQL+5JJSO6O6Ki8xyVT02G1R1E9+ZWg
	Irlw+qyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwvm-007M8g-T6; Wed, 22 Sep 2021 07:44:38 +0000
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com
 ([40.107.236.65] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwvi-007M6q-Sc
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBMnJXAAkB2Bdxz1WSyQrU6FEujerFgBuW5gn2f2j+y0LmDf33dFKqOGE6fVcZ10JZyygjTr6TwuMYhHqf5YpyfAy6Fcwju+hrRJ+AwZEGqDzoIOAWyIpHMQVbxfVWCMTcaWbhM/j1Nq6J1VTLCP8v8gJa6MeENF7aLCYzF0i5CRPEqarT0zTUMmYHMbWAwVZoCQgRna4HPC2qxKg76bl8j6X009ux7CAYnPYzpAUV/XWCtEMbCQvE07CT1bayEiv2lpxYb2HVPoC2yUpTq82K5lZ6SCZMK+AX056jcyRmIfMI7oqOCkwKAwF4LOSlvDHfFcTgWSAhaxdRBPwkWODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NJT/FEt77tNtz0GnclgvM+VmAwoGJhAjVBoK2yoR5is=;
 b=UALNi/LT5cPWQHRfH13jqoA7D725b9ELfHKYip3u4G1F2Y5l5o7+wunzHg1D6RDKMGzhsr9sMx6qaND62ypq3yB9fof34YhGB0xzZtkK6Qw+KMjYmYCvSrvE52fOKQ4RqbDVhqq35jZASyljx1geUawAjMBeUwPxVLAAKQ/GiFafedxuxsIFnuYVYHfA34SPujE8LJLj8A3rwx8knZJQXfvlvL/IODJhtjG3KaFinme7FlJf+eIkYkH0c6twRfWdyFCYgSXYpqWG9NdV6IaopSfrK/bwCR9MqS8o+o4idwN1ESjGjgMFrqg29c6hopN/R86ncuHEpvrgiLRSfCMqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJT/FEt77tNtz0GnclgvM+VmAwoGJhAjVBoK2yoR5is=;
 b=EfTEVcO/hpoDC59ihLSv06Pe0/AVQbdcC9TKt8f+VewcnpdZBVgA9MsWYmtM4mZDGIsIho/iADBMBeUkJ4zmtgvPSPskrYyh7y2Oat+uK3IJSk+7SsasSE4q7NikZdKvFnDe2+Q+xalNUNPmKbdl0IX0g6iH2c+fbahU0eGur/viD9Dcl8eJz8e8HHbZwfSi0DP7VhT/XpULx71zud8B/sqTJza8Jz52JGW/P7mKvNIFm6AYUfBDNTFTmD2CsW4wv8UOtFqluSGAMLZunwXLUa4Nb6V6lLVWwi3fZhNT6RRkzZQ+Q5YEMNh7OtxCcQ7l7UBFBXPS5O8uEFua5Fe+OA==
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 07:44:32 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::6a) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Wed, 22 Sep 2021 07:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:44:31 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 00:44:25 -0700
Received: from [172.27.14.84] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 07:44:22 +0000
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
Date: Wed, 22 Sep 2021 10:44:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc14e3b5-6064-40aa-5411-08d97d9cd0b4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538430B1308981CDD93DAFEDEA29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnT9h1mdSEK6Bqf1ymYZuO/B1L0Qt2EwturSMGy3cC5RMYeE9/DJLnurRxeZs20pOZ/CQCYj0UpfziAd6ZEPScN25aEtXKGfDK7f+i5OCqIG11NNlRwfFZHrBQN0tmRuZ+3qk5E9qR+F69o4Gas8Yv44o89XA162eN9tuAEVKxZZpp9UKmmPP9zmlufQxeqEZQB7vry+bm0K3aa8q4T8AA/D6npvUpBqkhEg9ct75UTQabNHE/hA1Z7Mje8oEzG8afB34sGI5syGM0Gn/IASAHk1Xoc5J6kUxLxH1FT+Z1GK8lsBiLayuUW6f/WDBmpQFBvSs5u9hh5Jjb51jB7rQafDY71t+7LEGeNGtAKAU/C20DGTXDMvmRL9qF3wN76y6rNwVa6n9q2aWBmtJ3nKQb360NQu42Jtc5QkzPbpQqaWK8wV/oGhSrJA7oonyo/cxwS5E31KEoW1MqkgeElJnReyfgrRGr5gRi8O2f0HSSYiVg9Tk1UBCqV/DSunWrNopNRmbY4GmaNo5Wxrymev5QZnsfvJuGq/raPJWUTqeYuvCkqdKt56FB+BQovfAoVOLyhmGmAxAH6dxRrhC4G/g2ilSShgyer8G04ySy1hIuSO5BBKjlgeUtJSAEgS/5R4f1xR59xWD64HzpQ26NWIAp3vPTA/Dj1BRTpNyC6SNZT3a8KXMSJ5fyZiLIQqIKLyHeePky8wx88GF4xCOqix/evdKDsIRtw5zGjtcY7Ajmw=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(16576012)(186003)(107886003)(31696002)(6636002)(16526019)(70586007)(54906003)(8676002)(110136005)(336012)(36756003)(2906002)(4326008)(47076005)(83380400001)(426003)(8936002)(508600001)(7636003)(36860700001)(31686004)(70206006)(26005)(4744005)(356005)(82310400003)(316002)(86362001)(5660300002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:44:31.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc14e3b5-6064-40aa-5411-08d97d9cd0b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_004435_005318_BB3DEEEC 
X-CRM114-Status: GOOD (  10.75  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/22/2021 1:52 AM, Sagi Grimberg wrote:
>
>> Limit the maximal queue size for RDMA controllers. Today, the target
>> reports a limit of 1024 and this limit isn't valid for some of the RDMA
>> based controllers. For now, limit RDMA transport to 128 entries (the
>> default queue depth configured for Linux NVMeoF host fabric drivers).
>> Future general solution should use RDMA/core API to calculate this size
>> according to device capabilities and number of WRs needed per NVMe IO
>> request.
>
> What is preventing you from doing that today? You have the device,
> can't you check attr.max_qp_wr?

max_qp_wr is giving me the maximal amount of wqe's one can issue (the 
minimal unit). In reality we have WRs that constructed from multiple WQEs.

Initially, I wanted to divide max_qp_wr by the maximal WR operation size 
in the low level driver. But that would cause ULPs that don't use this 
maximal WR to suffer.

So for now, as mentioned, till we have some ib_ API, lets set it to 128.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
