Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0AC4332B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A9C205ED
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="apqQJfce";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="caXmSJ+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A9C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jDZ7IqtCHUqHq487H7B2W+HXtwn8p8sVYzoVml2ydeQ=; b=apqQJfcedhJ8ugzGnzGYC09DQ
	FDvA0uYN/0jwcgF45jRzjZbv4jpSE1FVGBpglHQZ2AcYmeoJt18xkXq5N5Fdj/4f6TC7JnAz6G7X2
	oePGDA81OPh7BmHDc6LqLRCDFLWTb2/93wKZ1Nmb7wPtCY82gWMSZvUpGdUou2cy/7zRuQPF4tg/1
	mBU5Asq4llTo44VB4YzqlqdsFFepSOh901f9ZvBDFcOqQ6xlX6MgcRaon0JGMWWQtzu6L3UJFtm3X
	NHlt/e84XROk01P8UcEQFCUp0vLI6U4v+KJu+KxvcfSkwfbTmV/cq0hRIUJkdIOArsxRgwpyfjG68
	DCjA3PLPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGfV7-0004c3-DF; Tue, 24 Mar 2020 09:05:33 +0000
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGfV4-0004be-F8
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 09:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDVACsIjMj768HwV5eD0QpYzGZJ8EN3+zvm3S7ryC4TaXNTYq+y9xDAocxpDzUxYxqIaLr3OyQWcUGYSmGPZC+y2lSajNQ23nxC1LqtizUwGq5jKcwk5URjB89/DB/vGxUf/ozlPMI9c14bb1/cOz6ryPB5haL1nfAdUA8cgf2eOZCZZY3/PvHsfrPf8QcV0hLLB4WOyzseTwQuQywVoXz+BeRLjAkD6a/7OsBqjX0TZRk8N4KMW98i/owobToVaNQmab2/NuHaooW57Rl7tqbYtloueimwA9JaOvvEKQ/nuvnBSC1vfaiY9TagxMVmXknlZB29/nApzV76L90OZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D12Ix+FnBiKJptNypX9AFMls7nNm1so9LNQRv2v+Jp8=;
 b=LDILRcFebARacaIsMj6bx4F99LJta5f2rRHvDquCCNoI584JhyDFzRS6XrbEZ4RbKZssutNTuSw4Aiha2yNpENSlsuGp568sl92XS9rWEJ+FyASiiw5bnUyFBnYoAHdkYzNIr+BpkIAFI5q6MHcI4246zDyKu038V8Oc3/LTJLsbHb2U4A0cDTrfEnpdbDIWuLQe/7fRF2PjiJbmUorCvCT/LoespHdWOhqipTNPFDTrGmhUkkBdU2nGwL8R2ZE6cZ/+BgFvEkCquizmszPPKCarMXHqdJKAgEl8WfZliFRcSb/+ySyiJ4TPyDYjIYFwFYlrPGEhmTogY/NYtSvNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=acm.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D12Ix+FnBiKJptNypX9AFMls7nNm1so9LNQRv2v+Jp8=;
 b=caXmSJ+nYuBxfqULTWUN1X9EoNjvAmk9PAbWIDD/kgsrtCkCQNYUNGenA1Uq/8Uu3Ra/uBE0XZzYV684zltgD8cbnnlreGeVJD+8oK+zJjHLWY5PVzP8/OqSprB9UemkyM39bsx6vp65SyHP7pOhQX4q7NqRtynm1wjQgDw8psc=
Received: from AM6P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::25)
 by HE1PR0502MB2940.eurprd05.prod.outlook.com (2603:10a6:3:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 09:05:24 +0000
Received: from AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::eb) by AM6P194CA0012.outlook.office365.com
 (2603:10a6:209:90::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Tue, 24 Mar 2020 09:05:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT018.mail.protection.outlook.com (10.152.16.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 09:05:24 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 24 Mar 2020 11:05:23
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 24 Mar 2020 11:05:23 +0200
Received: from [172.27.15.174] (172.27.15.174) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 24 Mar 2020 11:05:22 +0200
Subject: Re: [PATCH v3 1/1] nvmet-rdma: use SRQ per completion vector
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <hch@lst.de>
References: <20200323172234.172786-1-maxg@mellanox.com>
 <38b0b042-a046-472f-3a52-760eca7aa187@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d0bbd174-3911-b5bb-0744-6cd125826798@mellanox.com>
Date: Tue, 24 Mar 2020 11:05:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <38b0b042-a046-472f-3a52-760eca7aa187@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.15.174]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(16576012)(36756003)(31686004)(81166006)(54906003)(31696002)(336012)(36906005)(110136005)(70586007)(316002)(70206006)(4326008)(478600001)(2616005)(356004)(8676002)(8936002)(16526019)(81156014)(6666004)(47076004)(86362001)(26005)(2906002)(5660300002)(53546011)(4744005)(186003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0502MB2940; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7108e117-b6ca-41eb-9065-08d7cfd27d35
X-MS-TrafficTypeDiagnostic: HE1PR0502MB2940:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB2940091BE15205C52FBB04AEB6F10@HE1PR0502MB2940.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iD2+Ci54uNWXyH1ukcpKOGVWTKdGCCCi7sruwo4uzscpZQ6ZUxxxNl7uY5cf0ZHUknOS0yZYs9E6xbC4RiDunPwZCudas6gD/jQGnv2pN2MrPxu+ExxV/lG1eXZtJIvzaz8ScYpqHJPiZ1nUZ1JIbnA3PIxMdWteS0xloseo/6AhJl6NlFwVmNMXO7yaF8EbHUr32gV+NSrLAdpt86O9Kflrcxkct10wqo/9iMSkXSYGP1cMVRG0jp1qpW3JuNwH2yXl2D6/okcinCe07qyrb8qs3HM49EUTecgRaXL05yRyCrww/EHzGi0J1M/HvqoZmvKj1+I5zJlOCFeWE2RrIaWOniLHC5zLui9RLGlfFhB7Tzv4OmThZoHGl83PCoxizwinr0hBF0luzJD9vmIf64q7fGxWC5XvqfwD/OuCcqHHhNCEx5tfu9LaaOE+jkSsWLisfJbdAe6r3K086TPPjnzFh08qMNU6eymb3BU4qg2LwI66vh2zYgNLBW7lmVuZVEHuAd0JdhQABwErzgsEriaE6zpbfH4TX8VPTILK8yA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 09:05:24.4346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7108e117-b6ca-41eb-9065-08d7cfd27d35
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2940
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_020530_829233_721439F7 
X-CRM114-Status: UNSURE (   9.09  )
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
Cc: jgg@mellanox.com, bvanassche@acm.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMjQvMjAyMCAxMjo0MSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+PiArc3RhdGlj
IHZvaWQgbnZtZXRfcmRtYV9kZXN0cm95X3NycXMoc3RydWN0IG52bWV0X3JkbWFfZGV2aWNlICpu
ZGV2KQo+PiArewo+PiArwqDCoMKgIGludCBpOwo+PiArCj4+ICvCoMKgwqAgaWYgKCFuZGV2LT5z
cnFzKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiDCoCAtwqDCoMKgIG52bWV0X3Jk
bWFfZnJlZV9jbWRzKG5kZXYsIG5kZXYtPnNycV9jbWRzLCBuZGV2LT5zcnFfc2l6ZSwgCj4+IGZh
bHNlKTsKPj4gLcKgwqDCoCBpYl9kZXN0cm95X3NycShuZGV2LT5zcnEpOwo+PiArwqDCoMKgIGZv
ciAoaSA9IDA7IGkgPCBuZGV2LT5zcnFfY291bnQ7IGkrKykKPj4gK8KgwqDCoMKgwqDCoMKgIG52
bWV0X3JkbWFfZGVzdHJveV9zcnEobmRldi0+c3Jxc1tpXSk7Cj4+ICsKPj4gK8KgwqDCoCBrZnJl
ZShuZGV2LT5zcnFzKTsKPj4gK8KgwqDCoCBuZGV2LT5zcnFzID0gTlVMTDsKPgo+IEFueSBwYXJ0
aWN1bGFyIHJlYXNvbiB3aHkgdGhpcyBjbGVhcmluZyBpcyBuZWVkZWQ/CgoKTm8sIGp1c3QgYWRk
ZWQgaXQgYmVjYXVzZSBJIGNoZWNrICJpZiAoIW5kZXYtPnNycXMpIiBhdCB0aGUgYmVnaW5uaW5n
IG9mIAp0aGUgZnVuYy4KCkJ1dCBubyByZWFsIG5lZWQgc2luY2UgaXQgY2FsbGVkIG9ubHkgZnJv
bSAibnZtZXRfcmRtYV9mcmVlX2RldiIgdGhhdCAKZnJlZXMgdGhlIG5kZXYgYWZ0ZXJ3YXJkcy4K
CkknbGwgdXBkYXRlIGl0IGluIFY0IGFmdGVyIEknbGwgZ2V0IHNvbWUgbW9yZSBmZWVkYmFja3Mu
CgotTWF4LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
