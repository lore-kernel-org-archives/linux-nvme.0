Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED02961168
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED02961168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSDA1oV+g9kq9K70v2C5coO2fHWiTIRuWFxiHiYNlc8=; b=pRQT3gsfwFcPH76XK6TSH4Xv5W
	VbVEKOZeYab5qHZ48tvu16a4Ufi2pgKMq0/Ox7ueKYwA6BH/HxinIGH+JGsSUmeBzH4CwP4wc0xbC
	bgoz85M5Nk+/WwyuMYvIfgopUC2y/kQ0/hcuovVCeB+CQHo2UAduk7Rd1uf5SFNztvgo9ZKziSn/L
	s8nutN59tbC6Ern0piyy479atG+QASnMiOJwEZZ7lCXLzsmA7RabRUuxgA7lS8PAc4iBbMfGCNvkI
	qR69aB8W+gHHJLp0idrbFrdwY1aBKKURTfnVU+ZJScO4gRMIUxWIEOUJaMhZiyellvtdXgwikgyrx
	EJ6mFvig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwnB-007Kpv-6i; Wed, 22 Sep 2021 07:35:45 +0000
Received: from mail-co1nam11on2058.outbound.protection.outlook.com
 ([40.107.220.58] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwn8-007KpP-Sl
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiCzqogLzKas7o/E38fuIUoa/hukPJnBg9qgvER401xcZ3EvvmLHjmkFdnB8XvFLl7R4V/KoNkOzVAx5eSS/k3d89wS3IgZBtH41JblQST/NPu0aVBpqLtloZ+sI+VSz5ebGroIB8mxSOgba3mO5igkT8i+cVMQuP0twnkSz4b0JLBU8fkf5b47ovePfWh/Ubj8TpTeUMxZyKiskn8eVjjVta/RCNKYJ0ERtKLLZ2aOyJJFZ+T4fIp7h7wzfDt5vxRBUNXznjo5RkLvt4VV3rnPO5cTU/KXWZabyHeXgH98c/+wLkMnaf9IM3P1XdgOnwrtIrZphZP51xdCqA5/hFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NDm7n4lXP5yDYtZeEj6HFQZYzGVLZqCuc9N/131/SnM=;
 b=XECBCZNxAQfHBCbfXm8uz6hGehEK1o2FpqR63WEyyPG9YTPAGNnNdMpQP8bq8cyrVmxA+Pq2n0rhs9l/fnyJRCjWV4gC2kZSeuiVtG9BaGqOE5xo+O28lYz29Ixx/I44dYrhjzyljOCi+Plt6fvwO6bchBhnnugesQOrP91Q2EEUh4qzqoIZ3lmVgEaohazIWbE//LstAAHqKOhw6fWKEs5vktrDQQJLzEnVPsi81oG0xbsT7fYHiIvZdEQ36QTyhHHZyEFyIK3OP4IdNDQIMO6Wi2g83aMN46izCTxjb4/zRfHDoF24VYg9/uyyrPZL7Mz8CmGftDh0ZtPwi7aI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDm7n4lXP5yDYtZeEj6HFQZYzGVLZqCuc9N/131/SnM=;
 b=sGhs8D+ufdCmjAv+NNpKgWeJ4oBmTo7jpQGEXAMkewmPWf5HDkEXwDTsgT+cN7hrVAUhuZN9NUc5VNKypXAaor99hpF0Ex3dP5EgWZml/thpoG65WOHn30IkU7gbR8HmNSUboLwq0rQRKdKGSkAN7m88kEGq9qQ2LhcxpQwkxLn9RxHfjVYbiKn96VqsVvf07vC5Rs3tMbuCYRwU8RfsM5zo51e6NI8JSAx4FMqz3FnSnGxVqdrjRQ4tIutQIs2sUoyde51/lCocXNk47LTq2a2mldWwmOxI+/02KIZDm2r8eCZaga3el9ZnxrW8pC/ioWVL0T4AYqgVfYCWc/YayA==
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Wed, 22 Sep 2021 07:35:36 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::d1) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 07:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:35:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 07:35:35 +0000
Received: from [172.27.14.84] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 07:35:32 +0000
Subject: Re: [PATCH 1/2] nvmet: add get_queue_size op for controllers
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-2-mgurtovoy@nvidia.com>
 <62df9e92-1530-2fb6-68f2-4040fea02fb4@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <1e2e2da2-35ee-2f9f-2a8a-c5c3008008a9@nvidia.com>
Date: Wed, 22 Sep 2021 10:35:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <62df9e92-1530-2fb6-68f2-4040fea02fb4@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be90f827-5a35-4128-cb75-08d97d9b9146
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5397502D48C6913BE69A8508DEA29@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1f7GxKg1LNp6lRWdM7pXzzzk4XVYyaPA86Lc1RHhPAuX0qFND1utkMpQXkigLlk+PC1I1yz7ZwPbbhGqpvefHG/ika7VstqFneIJrXvolujDXYEAv9638dYIA85r8gmnCI3xageHE7rOF0cTeNd/8JY/hH4HojWCd4kKjeBcpzwHEav/UvBp3P/fk2vvEcI623kVt9CsbUpTy4G9s17TEaAvTAez+zPYAj4P0IITolbsumrg7786BVyMzX7v+rZsvdS00IUCzdicupopemTW8uZTV0w1pZUhM1T9mA9fWax4pgb7z8rg/gEprdPGIavB6wEflB7WoIhI3LDze8ZUZsf6jSiPaksB4pRHkLEPvcOlHJDqH85POE6oD6qiYY4GAmncyFdeCrBA0awebeE/7ruzpmdoRR96/509XRIOsbWpDJgGAKrV+jV6zeeGeYwhE6jlpHZ2RoVX5CAhTdSBXd2VIOGZEGVetBV+j9QbbtfEi8S7YECerAddJ0Oc4O4zNaDuzoe4QPzC/owGA88pbV/lPMoXs9DQ2remG17StmdlIfGqN0sC1B9bFJIfWZb1zjHeX1QQtsUtVkbgu96/jUbzI0hEPg6U/m2e4GfOyz/PxUejfb3EpdM2m++/icLRT5gCZ8EcWtTOY8BuZJZkZ/JRq0cNiJ7y+i9Sp46CFZW90qMScl74bAaNa+3XLBHXk2BvtwiDxPcMHfdsImLlnD3/KoEj0j7wzaBJhUTZ9ss=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70206006)(70586007)(36756003)(36906005)(316002)(6636002)(2906002)(54906003)(2616005)(82310400003)(16526019)(31696002)(426003)(4326008)(31686004)(16576012)(508600001)(86362001)(53546011)(7636003)(110136005)(47076005)(186003)(6666004)(8936002)(356005)(107886003)(36860700001)(26005)(4744005)(336012)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:35:35.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be90f827-5a35-4128-cb75-08d97d9b9146
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_003542_979580_17A362D2 
X-CRM114-Status: GOOD (  10.79  )
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

Ck9uIDkvMjIvMjAyMSAxOjQ3IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29y
ZS5jCj4+IGluZGV4IGI4NDI1ZmEzNDMwMC4uY2Q0MjY1NWQyOTgwIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Nv
cmUuYwo+PiBAQCAtMTIwNSw3ICsxMjA1LDEwIEBAIHN0YXRpYyB2b2lkIG52bWV0X2luaXRfY2Fw
KHN0cnVjdCBudm1ldF9jdHJsIAo+PiAqY3RybCkKPj4gwqDCoMKgwqDCoCAvKiBDQy5FTiB0aW1l
b3V0IGluIDUwMG1zZWMgdW5pdHM6ICovCj4+IMKgwqDCoMKgwqAgY3RybC0+Y2FwIHw9ICgxNVVM
TCA8PCAyNCk7Cj4+IMKgwqDCoMKgwqAgLyogbWF4aW11bSBxdWV1ZSBlbnRyaWVzIHN1cHBvcnRl
ZDogKi8KPj4gLcKgwqDCoCBjdHJsLT5jYXAgfD0gTlZNRVRfUVVFVUVfU0laRSAtIDE7Cj4+ICvC
oMKgwqAgaWYgKGN0cmwtPm9wcy0+Z2V0X3F1ZXVlX3NpemUpCj4KPiBNYXliZSBjYWxsIGl0IG1h
eF9xdWV1ZV9zaXplPyBpdCBpcyBhIG1heGltdW0gc3VwcG9ydGVkIGluIGVzc2VuY2UuCgpZZXMs
IEkgY2FuIGNhbGwgaXQgZ2V0X21heF9xdWV1ZV9zaXplLgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
