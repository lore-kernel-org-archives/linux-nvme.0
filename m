Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E00C4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 13:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C7920776
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpFGx5N/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Sb/HU79K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C7920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ESNMATsZNs/W2TjluAhZ+tGZkoW49YJjZLG1rjkyJn0=; b=MpFGx5N/BXY7OXzycrbIdlnyx
	8nhIJZo7vh+qcskYMWbSgTUdW0jQxoeIrl/XsYDs/Q5PRsBrtQ496onG+7vWN8V/4cxD/nxc4C0gZ
	XL6CSi8YOA45WZ8XWpDDwrQwcTy0/6R8yImjQjf1V0G/Yy7BnG0c1BWj52YBVLB67NUVKpcXzrkXd
	gS60jSkCW7BmrM1chonravlxklXnaZwspMcAP+1EIWjcrNARRvhUBeIMn9ii9dSSzkv/sE4TcObNe
	2oht2ijZm3gPLn2tIUEMKacX4k84XqpBORiCdPoZXMlT6JABe0vf/MKp9Q6RtqMv8h0+rPJsO7PrT
	LKUucGE+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFHbJ-0001vc-Rh; Fri, 20 Mar 2020 13:22:13 +0000
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFHbH-0001ua-QQ
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 13:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bifQwc6esdCWrE7OqDqKrJ8wMh9WytpATDR75K5lyiL6Rc5tOAhRCoJHze5d01Qil/MRFfxQB/47WfKDu/0KVngmjc9HUkqC8TY91jNScOWb6EdeT6Ea4fOUfu2ATeW02wpBYPsquY4EX5wPN2nvRelOiPD98ZUcXYe1xwnfNzuMA1H0JroNAy2wezXWm+LeG+7ZZd9QsfzewGSoYQEC0ob4oUy2D4gJPFAkbQURFP1hSzokpsSRmHFvzJ2j95qSH3wVFbsSrvPH+45JM7klrbTg+y+RTcmaxIkx0ncdlNBalbkY5Z0FSrZF6ulQ/Eh1z3ItMzJ4VUrBzvtcC80vvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0K72E0GV6h1qM3Ob6LPzD9pP+ikH1EdXwO4qTOeWoY=;
 b=ej2oojIMB52iYQn32lYAuSAts+QeyXtwx8b0AUp0AWkFKKx8UpvXHrYKgqj5yHYn+JZBIHTGTcehbqy8bTlfIki3pf2aoiZwW9XOatCemRVUv6eY9YIO2t3spVfc2vTSW6HIflMGvekbGn80Cn6VBLorAfTKBqA4Kg5GQVw0LUtz27yO2Gm1tkxMTvDES+BDSKncXwk5W2Z0lXUUM5qP2Va+63o/H53jpJcu7k9MzZdXDcpuBpvqUe2OuXgyQpnrez2h845DRMz1lN+nkud105EwPrYdHKq8pYkvmub6xhybd6R06Y34ROsVra4Ysx7ub6PFHxxqnrzprVMNNvV61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0K72E0GV6h1qM3Ob6LPzD9pP+ikH1EdXwO4qTOeWoY=;
 b=Sb/HU79KzwtU+bUWEkBDoMnJsWwslIlYUp8x8D+7D04a4VQPfTaJk55QUvQtRhPHUQq2O5PZkyz1rBxKhqPVxN+JpL1Hfjvgsh1cyrFGbeE2cWH2oldbzyzeuOzxkd186/9sVu5lmCTkvfk46YBoDup4RRIvadeXsI8otNOoy5I=
Received: from AM6PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:92::37)
 by AM0PR0502MB3745.eurprd05.prod.outlook.com (2603:10a6:208:24::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 13:21:59 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::1d) by AM6PR04CA0024.outlook.office365.com
 (2603:10a6:20b:92::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Fri, 20 Mar 2020 13:21:59 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 20 Mar 2020 13:21:58 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 20 Mar 2020 15:21:57
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 20 Mar 2020 15:21:57 +0200
Received: from [172.27.0.96] (172.27.0.96) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 20 Mar 2020 15:21:53
 +0200
Subject: Re: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <loberman@redhat.com>, <bvanassche@acm.org>,
 <linux-rdma@vger.kernel.org>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-2-maxg@mellanox.com>
 <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bfdb2827-84c6-3053-6191-76e1fff84445@mellanox.com>
Date: Fri, 20 Mar 2020 15:21:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.96]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(199004)(46966005)(4326008)(36756003)(2616005)(47076004)(26005)(186003)(356004)(2906002)(5660300002)(498600001)(6666004)(16526019)(81156014)(31686004)(336012)(53546011)(8676002)(16576012)(110136005)(31696002)(36906005)(54906003)(86362001)(81166006)(70586007)(8936002)(70206006)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3745; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38235008-f945-45ce-e9ee-08d7ccd1ab0b
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3745:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB37457BB6C564F7C469FB1128B6F50@AM0PR0502MB3745.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03484C0ABF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isA+lKQw54aP+gQHIKTupQJNJaV1k91QBvl4iL8dG8IJYu4IEb8J6JoPpiI/4nzaWNXm0h1CK7KIi0UA2e/m/n1kMZlJSe+TggnqpbzOGB8kZeACkkIIqrzGqwljJa5lxDk2BP/h4SkltVgjskUDpkM+dI0kYg4jadY0rATmbEJo8+4UDfszmzBBj0JT3g2SkCNaHSnF2DrhVFthWNNsygARYGyVPpc/10fo+W2COObR72ysYiVdEwtV7krOZYnHfZ5xIHkya2snyudLdmsAiSLMqG0oNRQPEb5l6JQQ9sCRu480hvCgT7VSH/0zCYhiyuTE4+Iqyftfw3AToN5UooVxVJ6k0ldBeQzVUV7RZAVN3DmWu+/11NaFxZN12+4e0yqHYul6Wn0dksSoBHRxVfz3JT+UWv6G41bxIOdyTaX43aKV9YQgtYVCxYaqhIoBGlBP1sAz1t9CznKQK929xaqGT1Q7AiNeHctTgPym0PG0bWys0aKbH9HVM223nfJ7GnRK/Ir38dkHbgmoy5b3BV3b11zGHJE2WbBLeA/gVJ8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:21:58.4369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38235008-f945-45ce-e9ee-08d7ccd1ab0b
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3745
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_062211_859098_AC4258BF 
X-CRM114-Status: GOOD (  14.08  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, shlomin@mellanox.com,
 leonro@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, idanb@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMjAvMjAyMCA3OjU5IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IFVMUCdzIGNh
biB1c2UgdGhpcyBBUEkgdG8gY3JlYXRlL2Rlc3Ryb3kgU1JRJ3Mgd2l0aCB0aGUgc2FtZQo+PiBj
aGFyYWN0ZXJpc3RpY3MgZm9yIGltcGxlbWVudGluZyBhIGxvZ2ljIHRoYXQgYWltZWQgdG8gc2F2
ZSByZXNvdXJjZXMKPj4gd2l0aG91dCBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBwZW5hbHR5IChl
LmcuIGNyZWF0ZSBTUlEgcGVyIGNvbXBsZXRpb24KPj4gdmVjdG9yIGFuZCB1c2Ugc2hhcmVkIHJl
Y2VpdmUgYnVmZmVycyBmb3IgbXVsdGlwbGUgY29udHJvbGxlcnMgb2YgdGhlCj4+IFVMUCkuCj4K
PiBUaGVyZSBpcyBhbG1vc3Qgbm8gbG9naWMgaW4gaGVyZS4gSXMgdGhlcmUgYSByZWFsIHBvaW50
IGluIGhhdmluZwo+IGluIHRoZSB3YXkgaXQgaXM/Cj4KPiBXaGF0IGlzIHRoZSBwb2ludCBvZiBj
cmVhdGluZyBhIHBvb2wsIGdldHRpbmcgYWxsIHRoZSBzcnFzLCBtYW5hZ2UKPiBpbiB0aGUgdWxw
IChpbiBhbiBhcnJheSksIHB1dHRpbmcgYmFjaywgYW5kIGRlc3Ryb3kgYXMgYSBwb29sPwo+Cj4g
SSdkIGV4cGVjdCB0byBoYXZlIGEgcmVmY291bnQgZm9yIGVhY2ggcXAgcmVmZXJlbmNpbmcgYSBz
cnEgZnJvbSB0aGUKPiBwb29sLCBhbmQgYWxzbyB0aGF0IHRoZSBwb29sIHdvdWxkIG1hbmFnZSB0
aGUgc3JxcyB0aGVtc2VsdmVzLgo+Cj4gc3JxcyBhcmUgbG9uZyBsaXZlZCByZXNvdXJjZXMsIHVu
bGlrZSBtcnMgd2hpY2ggYXJlIHRha2VuIGFuZCByZXN0b3JlZAo+IHRvIHRoZSBwb29sIG9uIGEg
cGVyIEkvTyBiYXNpcy4uLgo+Cj4gSXRzIG5vdCB0aGF0IEkgaGF0ZSBpdCBvciBzb21ldGhpbmcs
IGp1c3Qgbm90IGNsZWFyIHRvIG1lIGhvdyB1c2VmdWwgaXQKPiBpcyB0byBoYXZlIGluIHRoaXMg
Zm9ybS4uLgoKU2FnaSwKCkl0J3Mgc3VycHJpc2luZyB0byBtZSBzaW5jZSBpbiBteSBWMSB0d28g
eWVhcnMgYWdvIEkgc2VudCBhIHB1cmUgCm52bWV0L1JETUEgaW1wbGVtZW50YXRpb24gYW5kIG5v
IHNycV9wb29sIGluIHRoZXJlLgoKQW5kIHlvdSBoYXZlIGFza2VkIHRvIGFkZCBhIHNycV9wb29s
IGluIHRoZSByZXZpZXcuCgpBbHNvIEkgd2FzIGFza2VkIHRvIGFkZCBhbm90aGVyIGltcGxlbWVu
dGF0aW9uIHdpdGggdGhpcyBBUEkgZm9yIGFub3RoZXIgClVMUCBiYWNrIHRoZW4gYW5kIEkgZGlk
bid0IGhhdmUgdGhlIGNhcGFjaXR5IGZvciBpdC4KCk5vdyBJJ3ZlIGRvbmUgYm90aCBOVk1mIGFu
ZCBTUlAgdGFyZ2V0wqAgaW1wbGVtZW50YXRpb24gd2l0aCB0aGUgU1JRIHBvb2wuCgpJJ20gb2sg
d2l0aCByZW1vdmluZy91cGdyYWRpbmcgdGhlIHBvb2wgaW4gYSB3YXkgZXZlcnlvbmUgd291bGQg
YmUgaGFwcHkuCgpJJ20gb2sgd2l0aCByZW1vdmluZyB0aGUgU1JQIGltcGxlbWVudGF0aW9uIGlm
IGl0J3Mgbm90IG5lZWRlZC4KCkkganVzdCB3YW50IHRvIGFkZCB0aGlzIGZlYXR1cmUgdG8gTlZN
ZiB0YXJnZXQgNS43IHJlbGVhc2UuCgpTbyBwbGVhc2UgZGVjaWRlIG9uIHRoZSBpbXBsZW1lbnRh
dGlvbiBhbmQgSSdsbCBzZW5kIHRoZSBwYXRjaGVzLgoKLU1heC4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
