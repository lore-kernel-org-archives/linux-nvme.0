Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2614C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 09:11:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD85610E9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 09:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD85610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qklOLPA4Aj23BvG83LWlZDKEvf1mGUqotKrUIejiuJU=; b=fqjjzOZaOhI4HQrbysAzStvI1
	sDhCuu11xYHLr6YdF0FymUEMc9I6d9RSwVyEBh6d3r/wwDC/tC6ZSN1tfT+vFKPXPMoGPTEo1mjK9
	zxoXF10yDDMkYye7vipGYcJ5qcEk9T/tphr0JeWtV8EsD+CCc2WkCDuXRC744FnY/MCl8/EYBaVO2
	A7WHACaq5tJRyaOHKSRlO0CxAzdIv7Xn0dr+EsXHmK5TPzCdflwui3YuqRL3REOGgjClYY8JtPCVZ
	I3rYw/BaFPqVbbWT5icoc76fnyhAbnFJwUZvzPCJXpBNXNimhCaGV4K9NLNOInahEDetqdLfnLGvw
	RdO1zEvBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVW7N-004D11-PQ; Sun, 11 Apr 2021 09:10:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVW7L-004D0t-My
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 09:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=592+fWKJuw6iklV343DHg8CwYAHcBrUL2ttX4MjCEjw=; b=N74rw9jKyQExhD197cAbPZYJJ2
 xxhHjgiskvue/XvsugBIiRsDMvSveZYb1sy8aIU1AbMVAXfwFW0ktvXslG+DcjBhJk2ZHsy6OHL1X
 XL3m5QUO+Eygep3GEWxhEDxTHtFJ6JzIDUoc46jJMz58bVxU0agi0fv1hEVcTKmimXTNPJIMeIadX
 us0tkC8XXUzFap/zzilKDpLJUc3FfOn8hI7PPRoYwSWuv2ewX5EFr01NE0YFiZyk+LlfNpp7LBUF4
 F1meG0cUMkJlKSLZ4oDLnBKSisJLKm1q+hYc/95P+rwbDrOE787Fyf4Mq5XCw421JYUCiKldpT9MY
 Y48YFJ2Q==;
Received: from mail-eopbgr680049.outbound.protection.outlook.com
 ([40.107.68.49] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVW7I-005Qhy-O9
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 09:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzr8W6LwC0F+8fImef/z9WNpQDS8fg0c0jIUakq/EXOeMixv2VOYa92OZwvLN7lY05IIuAb1n749DIDsP+Me1dbPPaUlAel3KURzYbe0ZhfPC+G7g81LMnUx3ezZOPlwC64hHe8WDeBbTIyewvvDkS7/q+685ka6d3si0l3vw+9xVshsRLwbZkTxUdOvNchY1hdpzJgZ8j1xgaT2oymH6DvbJ8yCDy/bH7BzlqidFtopGXNICu4wV3GsSFfpqGJBl6nZnhvAHYbxeLVFWn3dt0QrMIcC6aTdczcQAn9oe6yjMGegWJRTG1ZtDsHm0F3/Pwhn6YHWNgiZuZ8JJCguFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=592+fWKJuw6iklV343DHg8CwYAHcBrUL2ttX4MjCEjw=;
 b=k4Ey/4q+pZiiL5JDpwroOeGtTH2cD+EA2Gk5qXCsVjFCdkBlFQC13jYDiQ5CfPX1z9RCbS9r75PGSVwVhLVglS7lvuB+Fa1UZgnUobEocADQVdM82qd8xPBuotqv1BNSzZKqejlbLFPOv+fsYVAZfHSz1ssVEbpDtZ8SYtv32x99tn4sor1xcsoQkUn16QaWM2U8VI/clz09mrgYuLL3mi2jwmcQyF2Swhh/KjJcZiOLIPr6JP7eP0/RF1xwIxJqlEriObnRbwTmY0LiKIlpy0Puy+Y6Xddb/p/T9qCkdPHOsiBBw7M7HddM9geNAwQQM9drqYZPdM0aeI9d1c640A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=592+fWKJuw6iklV343DHg8CwYAHcBrUL2ttX4MjCEjw=;
 b=VpVsuSIRrMvsR0g2kiUnOsZ53QUMlO3zSYbjQLCOJC6yx1yIF23ogs794f5IShfPlrdMuPkGbmUBJtfq5SDZULR4S1SIoFgotoaQoPMy4JGnUIiHMfg/Rw5iyridm8dVC5ecysRew0kofAM6q1fWuHP7w6imA4hUmRrP15+fUSJrawJQDNOu0ySMEBHJr8OgAiaUv3GdUwciQ1nrcxGUqNLUcUbwX5bfTMAJEaffLNRyayKA1YaePLTQgoItgbJaHyFt/Arb6+9w02AIE7FuEd10aDRXd3vVM6FjsY48MnKYhTE0pRYcJK1YOPegrffxR84ZsEvYMZ+byo0xz7CKRA==
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Sun, 11 Apr
 2021 09:10:42 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f8) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sun, 11 Apr 2021 09:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 09:10:41 +0000
Received: from [172.27.15.30] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Apr
 2021 09:10:36 +0000
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>
CC: SelvaKumar S <selvakuma.s1@samsung.com>, <linux-nvme@lists.infradead.org>, 
 <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>, <kch@kernel.org>,
 <sagi@grimberg.me>, <snitzer@redhat.com>, <selvajove@gmail.com>,
 <linux-kernel@vger.kernel.org>, <nj.shetty@samsung.com>,
 <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <dm-devel@redhat.com>, <joshi.k@samsung.com>, <javier.gonz@samsung.com>,
 <kbusch@kernel.org>, <joshiiitr@gmail.com>, <hch@lst.de>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
Date: Sun, 11 Apr 2021 12:10:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d11acd94-9406-4c6e-f4d1-08d8fcc9ae9d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48888AE5FF67F6C8E7AE23F4DE719@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36gL4SQ4m6Nq986/CH+vAX6rAaJJDkmwec0q1giSVruF153cYFpySXH/sei7rwFRoVzaBFkdoxATl5ivlt4DChHyeNVdt1sPJNn34yWql1drw2Ro3HFOxozqCPtEVWup3uK3knl6hmRIixtjl/yOrZ3vMzCG0QUadgTW/tJ9mDh2paMbQ404XVWno8T3Y/S1Tx/qGb99ogftVToRv5Sh99JiBy0LPn0OoWvnC/yXwhEx4W6e1yw8nqjRKXk5Qka4e1usTcsR1DuuEXBAui2ApUr2/fyFo83AlCo0ybUcHcSQ9ASMcdfm1ZAag2Lge3a1j3yEB1wBFG8flCf0oE+H+n3y3/sJGGazViV7u5+bofI2HVGPxsBFm1+BCh6wN1IDBS6p9+TctoHSebwX+eEARfRob4ziYk8CTZmnZIHI2Hkz9ZWPzR5mqOJ+HHwxcWje77N6Qkc2YkiM1iYKWuaDGe+vtTvdugfc6U9mf76ExXuB+gX6rRYrQ4BaBNlvO0D+UawrdhehA5wgCoj4hoZBYhn+hmwuuhakvjupuW9oTIDSHRe4Gy7dXc1d+kOc6BdyCh/MNGWDrmLfkBpdwfJR5KzYGdHNSJfZFGKHMrOHASct/a9tZ2Z4BMRNk3lI1dCfpLy+gBjfbK2/zAUsMTriV4c6SP0H+vWaoMG+Lar2qy4n/EjKPQ2ElKPqs1+NaScVtG+FLdSbvrg3sGSuVkTr+kX6POECT4t1ZZw/7pc8ipp5jjSnR+mQSodD1B8eWBCQkP268VJxH04c9AajNAIRhdinJDO5RwnrR+aklkaHN4jIXACtnheSo9SNHwad0a91UYTEX/8Q8DYa9NBg88DFow==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(82310400003)(7636003)(36756003)(316002)(478600001)(356005)(6666004)(47076005)(426003)(54906003)(26005)(8936002)(82740400003)(336012)(16526019)(186003)(4326008)(5660300002)(83380400001)(86362001)(70586007)(36860700001)(53546011)(7416002)(66574015)(70206006)(2616005)(966005)(31696002)(16576012)(110136005)(8676002)(36906005)(2906002)(31686004)(43620500001)(15398625002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 09:10:41.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11acd94-9406-4c6e-f4d1-08d8fcc9ae9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_021052_836227_557BBB4E 
X-CRM114-Status: GOOD (  17.38  )
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

Ck9uIDQvMTAvMjAyMSA5OjMyIEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAxMCBB
cHIgMjAyMSwgYXQgMDIuMzAsIENoYWl0YW55YSBLdWxrYXJuaSA8Q2hhaXRhbnlhLkt1bGthcm5p
QHdkYy5jb20+IHdyb3RlOgo+Pgo+PiDvu79PbiA0LzkvMjEgMTc6MjIsIE1heCBHdXJ0b3ZveSB3
cm90ZToKPj4+PiBPbiAyLzE5LzIwMjEgMjo0NSBQTSwgU2VsdmFLdW1hciBTIHdyb3RlOgo+Pj4+
IFRoaXMgcGF0Y2hzZXQgdHJpZXMgdG8gYWRkIHN1cHBvcnQgZm9yIFRQNDA2NWEgKCJTaW1wbGUg
Q29weSBDb21tYW5kIiksCj4+Pj4gdjIwMjAuMDUuMDQgKCJSYXRpZmllZCIpCj4+Pj4KPj4+PiBU
aGUgU3BlY2lmaWNhdGlvbiBjYW4gYmUgZm91bmQgaW4gZm9sbG93aW5nIGxpbmsuCj4+Pj4gaHR0
cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMvTlZNLUV4cHJlc3MtMS40LVJh
dGlmaWVkLVRQcy0xLnppcAo+Pj4+Cj4+Pj4gU2ltcGxlIGNvcHkgY29tbWFuZCBpcyBhIGNvcHkg
b2ZmbG9hZGluZyBvcGVyYXRpb24gYW5kIGlzICB1c2VkIHRvIGNvcHkKPj4+PiBtdWx0aXBsZSBj
b250aWd1b3VzIHJhbmdlcyAoc291cmNlX3Jhbmdlcykgb2YgTEJBJ3MgdG8gYSBzaW5nbGUgZGVz
dGluYXRpb24KPj4+PiBMQkEgd2l0aGluIHRoZSBkZXZpY2UgcmVkdWNpbmcgdHJhZmZpYyBiZXR3
ZWVuIGhvc3QgYW5kIGRldmljZS4KPj4+Pgo+Pj4+IFRoaXMgaW1wbGVtZW50YXRpb24gZG9lc24n
dCBhZGQgbmF0aXZlIGNvcHkgb2ZmbG9hZCBzdXBwb3J0IGZvciBzdGFja2VkCj4+Pj4gZGV2aWNl
cyByYXRoZXIgY29weSBvZmZsb2FkIGlzIGRvbmUgdGhyb3VnaCBlbXVsYXRpb24uIFBvc3NpYmxl
IHVzZQo+Pj4+IGNhc2VzIGFyZSBGMkZTIGdjIGFuZCBCVFJGUyByZWxvY2F0aW9uL2JhbGFuY2Uu
Cj4+Pj4KPj4+PiAqYmxrZGV2X2lzc3VlX2NvcHkqIHRha2VzIHNvdXJjZSBiZGV2LCBubyBvZiBz
b3VyY2VzLCBhcnJheSBvZiBzb3VyY2UKPj4+PiByYW5nZXMgKGluIHNlY3RvcnMpLCBkZXN0aW5h
dGlvbiBiZGV2IGFuZCBkZXN0aW5hdGlvbiBvZmZzZXQoaW4gc2VjdG9ycykuCj4+Pj4gSWYgYm90
aCBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGJsb2NrIGRldmljZXMgYXJlIHNhbWUgYW5kIGNvcHlf
b2ZmbG9hZCA9IDEsCj4+Pj4gdGhlbiBjb3B5IGlzIGRvbmUgdGhyb3VnaCBuYXRpdmUgY29weSBv
ZmZsb2FkaW5nLiBDb3B5IGVtdWxhdGlvbiBpcyB1c2VkCj4+Pj4gaW4gb3RoZXIgY2FzZXMuCj4+
Pj4KPj4+PiBBcyBTQ1NJIFhDT1BZIGNhbiB0YWtlIHR3byBkaWZmZXJlbnQgYmxvY2sgZGV2aWNl
cyBhbmQgbm8gb2Ygc291cmNlIHJhbmdlIGlzCj4+Pj4gZXF1YWwgdG8gMSwgdGhpcyBpbnRlcmZh
Y2UgY2FuIGJlIGV4dGVuZGVkIGluIGZ1dHVyZSB0byBzdXBwb3J0IFNDU0kgWENPUFkuCj4+PiBB
bnkgaWRlYSB3aHkgdGhpcyBUUCB3YXNuJ3QgZGVzaWduZWQgZm9yIGNvcHkgb2ZmbG9hZCBiZXR3
ZWVuIDIKPj4+IGRpZmZlcmVudCBuYW1lc3BhY2VzIGluIHRoZSBzYW1lIGNvbnRyb2xsZXIgPwo+
PiBZZXMsIGl0IHdhcyB0aGUgZmlyc3QgYXR0ZW1wdCBzbyB0byBrZWVwIGl0IHNpbXBsZS4KPj4K
Pj4gRnVydGhlciB3b3JrIGlzIG5lZWRlZCB0byBhZGQgaW5jcmVtZW50YWwgVFAgc28gdGhhdCB3
ZSBjYW4gYWxzbyBkbyBhIGNvcHkKPj4gYmV0d2VlbiB0aGUgbmFtZS1zcGFjZXMgb2Ygc2FtZSBj
b250cm9sbGVyIChpZiB3ZSBjYW4ndCBhbHJlYWR5KSBhbmQgdG8gdGhlCj4+IG5hbWVzcGFjZXMg
dGhhdCBiZWxvbmdzIHRvIHRoZSBkaWZmZXJlbnQgY29udHJvbGxlci4KPj4KPj4+IEFuZCBhIHNp
bXBsZSBjb3B5IHdpbGwgYmUgdGhlIGNhc2Ugd2hlcmUgdGhlIHNyY19uc2lkID09IGRzdF9uc2lk
ID8KPj4+Cj4+PiBBbHNvIHdoeSB0aGVyZSBhcmUgbXVsdGlwbGUgc291cmNlIHJhbmdlcyBhbmQg
b25seSBvbmUgZHN0IHJhbmdlID8gV2UKPj4+IGNvdWxkIGFkZCBhIGJpdCB0byBpbmRpY2F0ZSBp
ZiB0aGlzIHJhbmdlIGlzIHNyYyBvciBkc3QuLgo+IE9uZSBvZiB0aGUgdGFyZ2V0IHVzZSBjYXNl
cyB3YXMgWk5TIGluIG9yZGVyIHRvIGF2b2lkIGZhYnJpYyB0cmFuc2ZlcnMgZHVyaW5nIGhvc3Qg
R0MuIFlvdSBjYW4gc2VlIGhvdyB0aGlzIHBsYXlzIHdlbGwgd2l0aCBzZXZlcmFsIHpvbmUgcmFu
Z2VzIGFuZCBhIHNpbmdsZSB6b25lIGRlc3RpbmF0aW9uLgo+Cj4gSWYgd2Ugc3RhcnQgZ2V0dGlu
ZyBzdXBwb3J0IGluIExpbnV4IHRocm91Z2ggdGhlIGRpZmZlcmVudCBwYXN0IGNvcHkgb2ZmbG9h
ZCBlZmZvcnRzLCBJ4oCZbSBzdXJlIHdlIGNhbiBleHRlbmQgdGhpcyBUUCBpbiB0aGUgZnV0dXJl
LgoKQnV0IHRoZSAiY29weSIgY29tbWFuZCBJTU8gaXMgbW9yZSBnZW5lcmFsIHRoYW4gdGhlIFpO
UyBHQyBjYXNlLCB0aGF0IApjYW4gYmUgYSBwcml2YXRlIGNhc2Ugb2YgY29weSwgaXNuJ3QgaXQg
PwoKV2UgY2FuIGdldCBhIGJpZyBiZW5lZml0IG9mIG9mZmxvYWRpbmcgdGhlIGRhdGEgY29weSBm
cm9tIG9uZSBucyB0byAKYW5vdGhlciBpbiB0aGUgc2FtZSBjb250cm9sbGVyIGFuZCBldmVuIGlu
IGRpZmZlcmVudCBjb250cm9sbGVycyBpbiB0aGUgCnNhbWUgc3Vic3lzdGVtLgoKRG8geW91IHRo
aW5rIHRoZSBleHRlbnNpb24gc2hvdWxkIGJlIHRvICJjb3B5IiBjb21tYW5kIG9yIHRvIGNyZWF0
ZSBhIApuZXcgY29tbWFuZCAieF9jb3B5IiBmb3IgY29weWluZyB0byBkaWZmZXJlbnQgZGVzdGlu
YXRpb24gbnMgPwoKCj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
