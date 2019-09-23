Return-Path: <SRS0=8MmT=XS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C06C4CEC4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 15:25:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FB020820
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BbWq45ip";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hfjp0K7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FB020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Iyl+vENaj2B1n9T4mlEfBsN/cmyQ/T2wa5imlHkjQI=; b=BbWq45iprNds4a7QMuegsCLDp
	OuwlkT2z47XLKzQZ+Vu1Dvp97UuWvFFY6iIM9xEsNuKTMoCKJCUHZxbHn7NjaB/PA3lZ4i2/i+HX2
	lU5lIEpler2s4AAubExHLEi/yQGyTsOMrid6I4kG6+az2uP/ayAzgwS6IIBuOsnQbN9UuHNhHGecz
	r3z3NKaiL3tBeFHjQNovKnbMma92g36L4pzJ0bI5EkV49UIXWrBEUHuNuN/xwqaimiDqdvNZYQVrK
	S9JOPh+lU8oOamnbpXrWDP9Ez/BTNs9zUMa6H4XXQn3NXaJDhGdDuzN9zPooaqKxqO4LxLPTMah0e
	5mRa+c5Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCQDd-000723-BR; Mon, 23 Sep 2019 15:25:41 +0000
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCQDa-00071Z-P0
 for linux-nvme@lists.infradead.org; Mon, 23 Sep 2019 15:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7pwR4EWD4n6r9ktoysmkpJ+o2f/P+EuSf8pR/3BZ7/SZJoVVHFYwqS1nwlxIGs+Ee2w9emGw7FkB3bZh8KLqM3jfMvfRoVP3szt3fEOJW9uRJjrf+U7jvFAvydBJpC8zE3IhP9C7/HWrvWZ1VDfmUidemJoM/7eyicDmOFtztvYm//2IinbAqB2KbKHGZDRDg+zU1dicPpptMDRQcK+0lmxQO7qVWBxZ6y5V2/XmxwFfuYdfg1a2cT4TE9TzVNqtV0hcGY0PbXLJnQA0/xNIPRgtAuZDjdWyO0MH+JS8XTGpNUEO7bWQjbNh0lihbYYp9TatFwyBtIcXSEqCK+GLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKSpc4TBrvYIUyOSw2jU7era9375Ffb53N5XPriq6Pg=;
 b=SDS/0k54cmYtr0J0np3kob462D2p7eFCSuzfe2xkKM1YBZfDu2bBTfgIFivE0vVU9In6vc1Xa/ZUXf17LaFJON1I0ykNyk0k1Sd6u9i9h+IAqe/m0CwaNgvnCZg9jArtphgGe2ldCk/VDGNhjS7Htlp4RemBwMA3OglX84LGdFvI3eBFPch4YjUJKv92SQqpuwBYdsgsRo6NqV5HHqpsHCzFnWvJZfCEn3xYkw87Wa7orXcgyW+IRqnyU+K4paGG0h5JRs1eFHjc5n+yKIyvpROXqIASGPDHcLp0/rsCROteKTx9iFDcH5pottd4ssLe50VHBjTNWbrtxRShotQVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKSpc4TBrvYIUyOSw2jU7era9375Ffb53N5XPriq6Pg=;
 b=hfjp0K7Fl82PEnppZbhYJUyUCGZV/HW1tgk4rGxb/Ysm/d211sHRrj858dqJMeyOeBjhu+zvlPmJmjR4b2XK5wX2Te4tCyYoanEJ7GEgl9YKhCnHuUNpFfaQlwHl1Gh1+Vz0EpaGWUZewIcxh/5SZL48VSUAnW+Y72MSoyNkcBo=
Received: from VI1PR0501CA0046.eurprd05.prod.outlook.com
 (2603:10a6:800:60::32) by AM6PR05MB4199.eurprd05.prod.outlook.com
 (2603:10a6:209:42::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 15:25:34 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR0501CA0046.outlook.office365.com
 (2603:10a6:800:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23 via Frontend
 Transport; Mon, 23 Sep 2019 15:25:34 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 15:25:33 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 23 Sep 2019 18:25:33
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 23 Sep 2019 18:25:33 +0300
Received: from [172.16.0.98] (172.16.0.98) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 23 Sep 2019 18:25:32
 +0300
Subject: Re: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 <linux-nvme@lists.infradead.org>
References: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
 <2ea07772-3905-fb82-4d73-7458a963677c@mellanox.com>
 <1a2ef415-72fd-7a78-33b3-5a2656246f77@redhat.com>
 <d8526cc2-e270-baf0-1ff6-728e69e8d86a@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0a8fffe2-f607-26ac-43f5-86182b1c782e@mellanox.com>
Date: Mon, 23 Sep 2019 18:25:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d8526cc2-e270-baf0-1ff6-728e69e8d86a@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.16.0.98]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(376002)(346002)(396003)(136003)(39860400002)(51234002)(199004)(189003)(106002)(486006)(446003)(126002)(476003)(316002)(356004)(336012)(31686004)(8936002)(2616005)(11346002)(8676002)(76176011)(186003)(81166006)(81156014)(16526019)(26005)(65806001)(47776003)(6246003)(50466002)(65956001)(53546011)(6116002)(3846002)(229853002)(2870700001)(4744005)(86362001)(305945005)(23676004)(2486003)(36756003)(2906002)(7736002)(58126008)(5660300002)(110136005)(70206006)(70586007)(31696002)(14444005)(478600001)(16576012)(3940600001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB4199; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb17b1d3-cf46-46a3-166b-08d7403a470c
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR05MB4199; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB4199:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4199B8226020FBD852338394B6850@AM6PR05MB4199.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0169092318
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yEzjJn1eLhKu4iIA7R1jdxEfa1bisSzeK3gtoGx7lB2uuEhVQrzr+6hYmZr73mklrcbgd4IEjWyeO0AOGpCbBYSyN1gfmBLDBbVjq38C+xKUUn4qxYYyQBMnTfhpFQsCKPu38r9tS2sGT0VffMn0EqGTWb3e2QCHcokkCJ5CZLJ7WeOABrGxuHDN/7zXCXP3XrgPcEvZG2os2DDFP2dp7NlGTZNj+ELHDHssSy3RrTwbKkZ6Rmi4eHXnh0mvthi41plHrOVbd51dLctFh5Wgwsm9i0X7h2j9yy/yQRMKHeukj42hV6sz9iKOKVQ8InjYn3qkeSnpP/arADXP8fdBULyRtn+3lVtn/qDbtfjOlgWALfjlZIegGIvj25C5b+bFa92mKCF9lYPNBFemIJ8d6TceShZushjWJCuJwoqIlMU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 15:25:33.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb17b1d3-cf46-46a3-166b-08d7403a470c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190923_082538_867427_CCAC3AB3 
X-CRM114-Status: GOOD (  10.30  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QW55IHVwZGF0ZSBZaSA/Cgp3ZSBtdXN0IGZpeCB0aGlzIGlzc3VlLi4KCk9uIDkvMjAvMjAxOSA3
OjU4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIFlpLAo+
Cj4gRG9lcyB0aGlzIGZpeCB5b3VyIGlzc3VlPwo+Cj4gLS0gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+IGluZGV4IGRm
YTA3YmI5ZGZlYi4uOTgxZGE5Y2UzY2ZjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+IEBAIC02MTQsNyArNjE0
LDggQEAgc3RhdGljIGludCBudm1lX3JkbWFfc3RhcnRfcXVldWUoc3RydWN0IAo+IG52bWVfcmRt
YV9jdHJsICpjdHJsLCBpbnQgaWR4KQo+IMKgwqDCoMKgwqDCoMKgIGlmICghcmV0KSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNldF9iaXQoTlZNRV9SRE1BX1FfTElWRSwgJnF1
ZXVlLT5mbGFncyk7Cj4gwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX252bWVfcmRtYV9zdG9wX3F1ZXVlKHF1ZXVlKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodGVzdF9iaXQoTlZNRV9SRE1BX1FfQUxMT0NBVEVELCAm
cXVldWUtPmZsYWdzKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgX19udm1lX3JkbWFfc3RvcF9xdWV1ZShxdWV1ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRldl9pbmZvKGN0cmwtPmN0cmwuZGV2aWNlLAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImZhaWxlZCB0byBjb25uZWN0IHF1ZXVl
OiAlZCByZXQ9JWRcbiIsIGlkeCwgCj4gcmV0KTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gLS0gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
