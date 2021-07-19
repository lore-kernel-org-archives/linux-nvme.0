Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20EC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:04:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1B5610D0
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1B5610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxpIGwL7ymwGzVhRcuHv35zrJhpgLmBJudG5XXaGbZY=; b=NJE95lAjIqS4oV58i4X5Rzwf2p
	sHRaVlWXyJB9Wg+JPoraz56LP6x+s1xs7S3McgdEh84Dl8MOUzQczaBOAsGNZCb8W8hCuB4rmZkcc
	A91qePt1Gx1eXAtyKe/+o7TomAfn4Zec2Suz0KhLdt28CtqACzaW8RK6jeVoPiKAo0nUgxP/jeOR+
	a5qdVA7iUGCaRSK2WVp66ZNcf5Hd+bCL2ysxFcPBYc3YDR/uVVsybA6/uKH+3wNmtdQ1e89zNihEE
	S7ow+czfj4XLW2Ciw/zMpaHyJ2yoZ//AJ1LOGP3wjwa7c1fS6C0rK90L2TVxmFIWo6PA/HNyjXJWa
	W1ZEyofw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Q8E-009BUC-96; Mon, 19 Jul 2021 10:04:14 +0000
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com
 ([40.107.237.58] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Q8B-009BTC-2w
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 10:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsiGVOMIsios6tkViDvhSfTpkNY8PewCfLhsLao093p6jB7ZytEvL6NyiNpP5c6bDUHMUflwnjF2csgiM4nsN2dwUFl31NTtp99ZKaMzoLlNB4kq7/Kjs43eteN55M3Q6QcMfdtXz3rzn7e7uC2cUCqmCvIa+a+uZky4iDBxg4mU11OlpQ4wkI/P0e6JExLpevcY9dlfvOW5vNNQxOCJSkYotzsecf0f49hBdpmeiV1vphq0wwEA6ySC8UEHqWCj4fNQQDc5wgAb3HcJCbydHpTiXBeyt6SsH3IV0tyLwRuu8goaV4rv8iOdnkUQybbhkD6ETPNu0jws63EscY2j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvPttV6RiHVUlP/XLSMS3MCSZzxB0IgxwblXuo1edbU=;
 b=AoA3gAP46x1xQeQhXaJHJwVARRQs1ArC34XER4YeVC4DDahg7RZ+4B/SLtZHQQRoMkQg98SOeQIf3YKqjbRvx/opPOEY958hOtMxecxsnH006S4Alblh4mgWDj/mjRAgNcAqamk5rL1RCK1Fkn7i5YdEZB84s/fx7m0RnuNaWT+FwvfHEV8DxNKt2twOY5Nh/5a3ay0uj9M2zoktciFvpU41tB1SnNBfTLq33A3qomA8g1N7fMOicGUEQN2tEnH2YJJMQASSuC+5vs7ItiAB3ZJctNgNfrYbPQu44TGEsR9Qm5ZL8LiGEg1gquqH8DJhDBui6wQyGGiooNv6W+8LHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvPttV6RiHVUlP/XLSMS3MCSZzxB0IgxwblXuo1edbU=;
 b=HiLTvfRIWD5+Xo8/4JHw95ymPKIRIfK0bLzOVY/J6vhPqAGha7gxIH3U4eiJOhHsLOBy1ulP68K2WEoPpI04x119LxgnsnW6Zyv2T/fyboGtwVmEDdL27+BgCsPHDl/R382hWhYSvAwtczfvh9FWv17sX1V4pvB0WPy3ofimfyKWIc7NI9T8IpyljKb1KMko2gp2J2AI51JBCpwaQ6nHdjxNxK1+7gfCtDNmxpirPGRNqzIKBW2UWY4/V5Dm2qaz09O/xNyICiKibV7PzPymknfNrcWZoQOxnV/IX/VL0NbEWzZPkGb+9/fuovlmzRU4+f/EjcfxBBSNYEnUeNDpIQ==
Received: from DS7PR03CA0264.namprd03.prod.outlook.com (2603:10b6:5:3b3::29)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 10:04:08 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::1f) by DS7PR03CA0264.outlook.office365.com
 (2603:10b6:5:3b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 10:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:04:08 +0000
Received: from [172.27.1.34] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 10:04:06 +0000
Subject: Re: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <james.smart@broadcom.com>, <oren@nvidia.com>
References: <20210719095309.7777-1-mgurtovoy@nvidia.com>
 <20210719095703.GA1880@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <5e4d1b8b-0003-d861-4a94-d9c0f2a37544@nvidia.com>
Date: Mon, 19 Jul 2021 13:04:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719095703.GA1880@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7766dee-68c6-4184-d49b-08d94a9c8ccb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-Microsoft-Antispam-PRVS: <MN2PR12MB400032C30311CCB3147307E5DEE19@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+YwRWoWnvfDtGUyouIdOAZB/dAsoYFJOixf82d/2zvYy92wf3I6oxvyRuSIE+rmlzDrfLLCAOv3xetk0wacTVNvKKso7f8ohQGpevQRhlsPha1inBUfaFbxEFyqEP3eZ3xnO9M0MzqS2w0d4U+MAXBDdErVAoPdUcHjtoaQz/q8vjRV+gSQ0IVTzQYNVmJTsRBEvD1kK+qXHqkB9UJg4HHb3dsuy2RVu7hiYr+OpGpCD4kGkGD2xbiQvyYmKM25ONjhprOVKRvzKfSOAvo6W5WLOBSpJd0WI7IbhXxB1R2/YOpQRM0VJlURT/7R2C4TJI6EXdXNPbPwzroMH5/tKY8bgI0AK1RdPzFJmF4FtFuf8qF7XftjkcPu0Jf4HVoKlsZWiOKQzu48c9quzg7RKISgolCNsszg0JEVbmrr5ivzomd/ghgfQIurVvCJt5zpHX2WEO83Af9l0q/vlJIvxotOFR1IVBVdRe9VVPPwZMk16/XHZZtVA2a2lTbMGkCu4zv4jXWEuAlRFgz+oUc8vjl+Y4+yG6CxSwkWpZPjEk/3cEiEBpGvCC2qoW7aRD/r8Qp4DkeNnv4c1MI4CWxOMm0PP8mHiMTRCQIjPXMd9LLw9s1J7TTfTmxEuvNZCbygf+N+JlMmY1sOU8jHA4wPeZhco8BZtWdYfpV6kKB4unCgpzpBxiiedFzhSt86xbMPEI/TEYuyUxe4/X76gZhSBnHDx0eTz9zfD6eQ/xoZCJU=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4744005)(426003)(5660300002)(36756003)(82310400003)(70206006)(7636003)(70586007)(47076005)(16576012)(508600001)(336012)(316002)(2616005)(8676002)(54906003)(36906005)(83380400001)(8936002)(86362001)(31686004)(186003)(16526019)(53546011)(26005)(356005)(2906002)(6666004)(107886003)(36860700001)(6916009)(31696002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:04:08.5918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7766dee-68c6-4184-d49b-08d94a9c8ccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_030411_185140_2D78FEA8 
X-CRM114-Status: GOOD (  10.95  )
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


On 7/19/2021 12:57 PM, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 12:53:09PM +0300, Max Gurtovoy wrote:
>> Currently the tcp and fc transports use nvme_sgl_desc structure to
>> describe transport data blocks. Replace it with a new structure that
>> describes the Transport SGL Data Block according to the NVMe
>> specification.
> What is the point?  Note that we should probably still clear the
> reserved space anyway.

The point is to use the correct structure from the spec and not enforce 
some weird casting.

This makes the code more readable.

Reserved space should be treated as for all other reserved fields in the 
spec.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
