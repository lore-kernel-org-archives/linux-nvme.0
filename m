Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 13:16:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A2E61359
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 13:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A2E61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fco3RxkhjdNzMMnL0u96yiyLJcOTPcxHBGTTHrMp8Bg=; b=SLkx2CuR8slA0JSN61exkTNX8
	rGPLNj+gfIEam7NfJfQlVANUnZl5r87mg2KZBJMrK07FECS6ah8a9PfzXfZK0gO9xaOLKfrUD47bC
	4euEV5CrVtt+UwRwOm0z2CaqTw1OX+fOmMwaR4Q3N3oH7jXIGSECe4I5YhlPCsRPXkromKuvZOn4m
	hTpm66EhbO+pc0gDwBaLY1wkE7RSl+VwojkrsBI9O6qRC6RBoacWMugzn1pvCB7hEnV+umb4af3mW
	BAHLpCDot9luIuXGQKLZu7q637dT8zsAhsf+ezFYmmWbAP5zJD6MMKtam4AMY+X5g/NNWONw7VUxb
	eLYDvLHQg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb15g-007gkq-08; Mon, 26 Apr 2021 13:15:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb15d-007gkb-Qm
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 13:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=bCnfglzsIrD0yL/n5XR4QnpwrrUHu1U+oAlew57ZBFQ=; b=N25GrMFWw6QCChtN6YShyb8W46
 OZiCptfDcYG034iQxhF05pnzEQchgOE4p+joJ7rLE+UUFEwAkQioiWZCt8ah5uSg7pthPxyvf9LGa
 uQPd2bBG+1xWDoM4BXGUZQD9aIMxf3KXNXt89u7yKY4DqoFSulSdLtsDWBNKbKrT/XtvRcckC/eRC
 ayPI+ghDUQ1ybLoLWIx3w19kF9vywJEEFr1t33yVWRxAEIKt+Q8F+pv8cv+O9sEk2TMovFeOU/8zd
 aA2unLb4OjocS6/E5e+vmHlHZf1W4zbo2z+LdlZRQIo9IO1/Bgdp9HnzWEiEMttRRLvy1D/Jkqnqj
 mC2OtxpQ==;
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com
 ([40.107.244.47] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb15Y-00Fygu-VH
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 13:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN3MP6aFXKZFYhO17KweE6mYm3vVYVA34v3szY20tc37aZYZQT4hPWe/a0bUZ1WUWgXSaL6YWcDGRkl2Ez292nhsDDsRQM5Z6Y25E4dkCIEt5LfQ2eRIGfV4sms8MeF++cD15EZOUe0t2l3hY2bUHFHggaxmLVqkcxlz/uRXcnkDsFl2cWgtlcZsA1Mz8VedOKhQG9LLlOigD/TmKjgYROgq8GT+X2QhlPeKC8enECe3Jh42S240UQhejZ5Vt3FuRbpX9QeQh9f/M7cuKSg4TnzjLAIYq8xHxHRoklQQchQwsfsFypCDX9drypoyPDISzEiWIWwmszdc4JswNXxUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCnfglzsIrD0yL/n5XR4QnpwrrUHu1U+oAlew57ZBFQ=;
 b=GsfzhxzR369zLB4iUrMoDrY0K+qIViCR4rDd8sy5KW8YgHU8mY2uxB9+dP0TpWt23Mn1rh52SjJgdmPkwwJah4x+18Ai0JECa2GEMMiOkg5GODOONsCsnIsF6Nj4mbjYswG97s9HDcxdjjULi9plJTzOMZZ6VJuxpF02kGNTxLGaxsIlSzchSNILB2lmyGbULuilmA/r6bsCwISWdliDzlkXgZ37Hu+Khpp2yanK138qCMXSqpCt1vc0LHdK8XzDEV/w8zvI8l4biRoZmwPg0mW97BL3A/ouSnCmk2tiaHRijjqpfDu0b4OkLPWFLdwtRqMP0n3v5E3sixyNQ9pVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCnfglzsIrD0yL/n5XR4QnpwrrUHu1U+oAlew57ZBFQ=;
 b=OTl+vWjZDvmJAI5Ds8pGerDqCgZGy3fJbhpA4w1PXQZCt1srzASxStuHWVMQ8+4vmY9IFIlOpA8cDgNLoQBcG4wyon31cLeVpoFDsltGNrztzQqTaAh3JBVYVN6x1qTZWh1l1X4eO4bWifSJKl4CWLl72PSYaaPZXD8CF1hWcgi4sZdJWeGPGsgMycFxYfih/Kf8C3A4FPUyhnHCq6Lluj8yhrgDpJrdsVdm2+9hpRw9v7FRLW50ofMMMT3tkwyxQ+IWu06Ds20vt3+/gYML3KLc7xdH+uAlKLWbFjRpl1tVzDR+fYOfT6R7GvvT67d4e3KhWBBILv2xss/N/cXvLA==
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by MN2PR12MB3600.namprd12.prod.outlook.com (2603:10b6:208:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 13:15:40 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::2f) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Mon, 26 Apr 2021 13:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 13:15:40 +0000
Received: from [172.27.11.5] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr
 2021 13:15:36 +0000
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <chaitanya.kulkarni@wdc.com>, <oren@nvidia.com>, <ngottlieb@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <20210423155139.GA3621038@dhcp-10-100-145-180.wdc.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <535a2c22-5de6-6253-5e25-4004dfe6f681@nvidia.com>
Date: Mon, 26 Apr 2021 16:15:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423155139.GA3621038@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896d7fff-a357-4edb-706c-08d908b563a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3600:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3600C1D3B38D18EB6FD5F360DE429@MN2PR12MB3600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0PP5V+6irg+EXpY8HrzWOeF1AxUkDF4XYJNKcsaoeFgSBun6qfkZ8lh8awlAGFAcXvTLEqg3fSzDefxgShd2BWRPFxQRbxv7onlMug61R8FvmKZbNtigsCy/B92NeHEfrrdBVIhaAbWRPtmbvqXA/F73sVD4G5sBcI58N46bQe9bYv9lffdncoDQloUwnrztbPHQHufqOUcwchkKFLl1IKHnk0b1Hf71KX6v1BKzKhcIeGwfUs1aZYtM7kDRIp/zL2eFxxL68z+dR75SbCVMbDnaRKnV1zXzYoD2pyqjR6L55hJ/0fk+bmBCtxz6xbYx1YC+rC58tz7KEB0JZlbBjPws7y6ZuW/hkx3zLmSWTyBsY3WjE7jbrpqF/GeSbDTMG7y+ZnG2yjnhrPpSdOCB2eD3jwlW9GpBP0jsULl+Hpnfvrdl/bjnpvz33ws23sv2VJUp35OpGhxj4bXZLvCNAyakkgspvvlnfssWDMFlSqf+6bp8vOojiURiHYTdp2dqvBxYIcuFrMBkbdTpUz9i7ehDm1DdMowLSlDm33HUyIb6qJJKW0K7fikrMWOD41Svyz3fI05+yR54rgpxlkMjAXI5NZU2N0VnbA+ZeHYweLiwFbjiE7H8HC7YSzW/D/JfvD4v5hk/O7oqS9dx5z8rYuQe5TZaA5OROM7FSL6O+efHZqp5lopJB2pJNVCrZzH
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(70206006)(70586007)(36756003)(336012)(6666004)(54906003)(5660300002)(16576012)(86362001)(31686004)(316002)(4744005)(36906005)(6916009)(4326008)(478600001)(36860700001)(82310400003)(47076005)(107886003)(2616005)(16526019)(8676002)(7636003)(53546011)(82740400003)(186003)(426003)(2906002)(8936002)(356005)(26005)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 13:15:40.2425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896d7fff-a357-4edb-706c-08d908b563a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_061549_063839_95C1957A 
X-CRM114-Status: UNSURE (   6.56  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/23/2021 6:51 PM, Keith Busch wrote:
> On Tue, Apr 20, 2021 at 09:09:00AM +0000, Max Gurtovoy wrote:
>> +/* See Section 1.5 of NVMe 1.4 */
>> +static bool nvmet_is_ascii(const char c)
>> +{
>> +	return c >= 0x20 && c <= 0x7e;
>> +}
> There's a library function, "isprint()", that can provide this check.

This is an existing function in the code.

We'll add a dedicated commit to replace it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
