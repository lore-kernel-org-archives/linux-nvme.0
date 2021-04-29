Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B6C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 10:48:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79B661409
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 10:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79B661409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	CC:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RQoD0IN/FhTi6V8S9KK+SNI00w+PnwJtpgiz4NgiZVw=; b=Jv1JJBsV23lkg4z6xcP/AsCT/
	qVlKlx4bWHPcE0OtB/7XZbYhkBC7R7lbCxHUW29ybZNHpDTuobpvJ5AgwRNevXSQubdSx8Cq2vUG2
	z2xcoZOwOJ3SX3HbpT5UJlAA33lUcyDF6Q4YtgkgbTmvgXStvJPr0HHx4oQiwJwtkHjiekev4LaLl
	ghOzYYeHGYHELHCzUeVTzBe/yNDsc2hc+h2jaIGv/Y043caBDn7zazP5W3lvBaeQhRHEgI5ewWN1I
	CXTrHG6c6foz9eRq0zbnbe0QeRTU5r3/0vcqEDQbW9i7mp0h7ceJKviNRjaI+NcF4uZ1PnyNjeToz
	AjdS89GKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lc4D9-005VnT-GI; Thu, 29 Apr 2021 10:47:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc4D6-005Vn2-Hy
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 10:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=5jZX4XPhw4xlkqkAhKsTK3yuWz2dwt0GujBT3wBJp/A=; b=e/JD6SQBHlu72bB3MiWddYBtw7
 jd4sd0rrmAPdjxa1XnRP+zCpvVonOF8CnfwowGY9oegeG+q4T8JXszRKrCUufh8bdHNZkR+zJzcCv
 RWkWZFn/Z8gruqb84UmST1NnbJdR/vr2qojrNU4pbU8bodBMC8cyyn2klvTUdNfb3laFeLyxeFaRr
 8Q9Mkz9HTyU2/CmvTpSJRhpGIkv52iWlk+8JOyUrsTJ2+Nxn5Ffkw5cJH3owbmYCP2k0yZYK/TD1I
 wr5O3px0DzwKCt7FBGufr02vbgdt9mnCYHnNQRS8lhVl0QyUVa++rrU6yy+6ry9uj8s/TwDBxvsx8
 gAk57y0w==;
Received: from mail-eopbgr770044.outbound.protection.outlook.com
 ([40.107.77.44] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc4D3-000ZKT-LF
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 10:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPmKcEBYxG1kfkMWPwMdcBwGUtHWadxobtkZeq0ZOELWM+GDXF/SKnxbM1jxPGgoew/R7PK0y6q4u7BN1pWdMUqpHHUD+2x/wDy10uvExaXYkZBKIjhOUd0IaRTMA4FPhWhcQyRjVDt1Hr52o/2Aq8+rDGQeeX8O47WBePTAzR87A2k9pz/mgdNLwYvy4Ff4gnxZ0cqLLut/RXawPnGCsM3Ou825rovuFcGL+K+EYGc7DRe3m0GK/KrEWLIr1fr4rt6w/BPPCaqgrev8qHx2MZqtg+xAuIewnfkEDjar/TEizQ6D1qBCh6YcA1zwV0wHk1NkBbTKkzsjQzGNNW2Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jZX4XPhw4xlkqkAhKsTK3yuWz2dwt0GujBT3wBJp/A=;
 b=adL+dQo3W0Zgv8soHtUTyYfYjNv6+YPpMekq4y9KFwGXqBWipaukJZ2GCFAyAPpgBMtYJrPwpLqiFDp/OPNAERE/CUus6FRw3dgh9x5foDZkJQLpcVix4AWfL6sE7RE7+NQeWSZOUiRNgGCRoeuQfyt+ASG8T42KYy9K+6RObQ8LqBnQWwN4rTSNqYifZ9hicKt1KaTJ2Kpy0Tz94RbxZIJcjEZpP9pv1OdSx6pulwx7LX1SR7fP8tL7GSKz3OIetj3bn1K4c2ozm7Whg7ojRMNUDS1Us7K/hM74sMp3ryM37qcL2KYEFs0ApszFw+nxZy8SHm/ycny7YLhHYwV7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jZX4XPhw4xlkqkAhKsTK3yuWz2dwt0GujBT3wBJp/A=;
 b=BPXXozplNXsRRC1nXPDxkQj9N8C110HWDbaf20qvpfWoygbg6t2cIK10donVjlqalDSqH5T/Xxt3JtzidLuZyNwFezvZNg1nrGddwIXpG7wg+V6/bN52wqGxezpWvLaEYJhpSja5u3463GCt+sqLDBaE/zrvydILQc1oV6Tpa8IqnGa3Ox435vpw3TOLfGLzU+SchIX+vZ6HFW1xtpto2uc+AhXoXwH5UNeqfkF2ttKTgmHQhaV7KoTuMSlraWnZGvXcSpUW9CvUNP/5TDB/sdNNbevtd9UDnTEQQE9MgJ1FdpQWO0ti/eb524kMcMvw21VHzPAOl+I/FVgTYky2CQ==
Received: from BN6PR1101CA0013.namprd11.prod.outlook.com
 (2603:10b6:405:4a::23) by CH0PR12MB5124.namprd12.prod.outlook.com
 (2603:10b6:610:bf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 10:47:50 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::db) by BN6PR1101CA0013.outlook.office365.com
 (2603:10b6:405:4a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 10:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:47:50 +0000
Received: from [172.27.15.116] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Apr
 2021 10:47:48 +0000
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <chaitanya.kulkarni@wdc.com>, <oren@nvidia.com>, <ngottlieb@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <20210423155139.GA3621038@dhcp-10-100-145-180.wdc.com>
 <535a2c22-5de6-6253-5e25-4004dfe6f681@nvidia.com>
Message-ID: <bd0853bc-ed39-6ad4-e1b8-e3f264c83e5c@nvidia.com>
Date: Thu, 29 Apr 2021 13:47:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <535a2c22-5de6-6253-5e25-4004dfe6f681@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25bc5b55-e65a-4874-ddcb-08d90afc3c38
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5124937F81085B45D93A0592DE5F9@CH0PR12MB5124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8m9Uj4C8y9aAahf5wnDCUKixLNYF9XjIAjMn3Sz5bfh6jVFg95bPzvuPuMedhkfvnUR8wJPi2QmCzWB5TQZpXFd82SaZpxI0rEb13JVYTthsV3huBfWmK4kgT3W+UOIDVvG01VTvU8DJte/VBfBZY0+M7dipE3a8y5ZPCPnBsIytXLh4+aD3lAye/zRXtWb4XaXe8wLWn49A1dVU3pnMWBT7scMrydNY1cpJP54wHvss+tK2Vy91DI4F0YhTI1myRH2lSNPlwhHc9QlXch3pZOv6LQRMGDLscGi4bkIwXEeFSieH0hZOa5RIOfT0t7IN7ImcNNCr9D+pONUeb+0Ws8/62jBlJE0iqL2CYd1z1KXt0U/O+5mOd07rZN6fmwB9gWk7Ys/eBXwYue9n+fGWk/C4sYnoCHUw7wt6QxoCxWos/yVK1fsGjxFvT53ZaRAsCIYD1XtAMyxDZ8CPG2Mq03jQdOgTa7sz+GwPy6WOOElyeU0awo4SXEDGA77QQoeh6oIprt8JnsSjAGGJ8bxjmOC6kffpLJAbXOtYQwAljEtgvH1DEiR7en6n+0qHYQoEAipJWz5vtmcsPSXvvAZn8CL75+t5eWFpjM14H7wU/apkv/sFaUm6/qUbxIewRK8NjezedJgD4ZLz37Ouin4KejRA9RaoIwSW35dNbuEpFSAoky+pze0PtnFGslygf1C1
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(47076005)(6916009)(26005)(36860700001)(478600001)(356005)(5660300002)(53546011)(426003)(86362001)(31696002)(6666004)(316002)(70586007)(70206006)(4744005)(16526019)(2616005)(8936002)(16576012)(7636003)(107886003)(336012)(8676002)(2906002)(36906005)(31686004)(82740400003)(82310400003)(54906003)(186003)(36756003)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:47:50.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bc5b55-e65a-4874-ddcb-08d90afc3c38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_034753_743171_AEA2C2FD 
X-CRM114-Status: GOOD (  10.38  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMjYvMjAyMSA0OjE1IFBNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4KPiBPbiA0LzIzLzIw
MjEgNjo1MSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IE9uIFR1ZSwgQXByIDIwLCAyMDIxIGF0
IDA5OjA5OjAwQU0gKzAwMDAsIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4+ICsvKiBTZWUgU2VjdGlv
biAxLjUgb2YgTlZNZSAxLjQgKi8KPj4+ICtzdGF0aWMgYm9vbCBudm1ldF9pc19hc2NpaShjb25z
dCBjaGFyIGMpCj4+PiArewo+Pj4gK8KgwqDCoCByZXR1cm4gYyA+PSAweDIwICYmIGMgPD0gMHg3
ZTsKPj4+ICt9Cj4+IFRoZXJlJ3MgYSBsaWJyYXJ5IGZ1bmN0aW9uLCAiaXNwcmludCgpIiwgdGhh
dCBjYW4gcHJvdmlkZSB0aGlzIGNoZWNrLgo+Cj4gVGhpcyBpcyBhbiBleGlzdGluZyBmdW5jdGlv
biBpbiB0aGUgY29kZS4KPgo+IFdlJ2xsIGFkZCBhIGRlZGljYXRlZCBjb21taXQgdG8gcmVwbGFj
ZSBpdC4KPgpBY3R1YWxseSB0aGUgaXNwcmludCBjaGVjayBpcyB3ZWFrZXIgdGhhbiB0aGUgbnZt
ZXRfaXNfYXNjaWkgc28gd2UnbGwgCmxlYXZlIGl0IGFzLWlzLgoKVGhhbmtzLgoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
