Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A9C2BA19
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 09:22:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDC22075A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 09:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A7zw7PEm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LmGabd5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDC22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9EL4plINJKPk3aTAkJ+XCMNnCrMrqJRLbMQEOQr3LVE=; b=A7zw7PEml48HLJYsBvTkVqFiD
	pKUy0aGxcp2+XaF6Ry2GvQpRD9LEwjQR8TqoBXGZ+b0T99nvtEPpwvvfyvhtOuFfWjWuZiqaimaos
	38W8640bY/wAu6YZNr48lJicbuT0KKSfLjQcmz2UzKFYclHhjkDTvl+d15Ovt6rVjPjRQOFpA6t2S
	eaEVbgjWYFvzJJZ+9qFalLyDkTDWrU/AIhrKPT9DYTlTCYz3+eXvuOIJr+akRVBzpRymWDsdiIvtO
	L484778KBGplI64vZu4G0CLSrzKagA8gkokx8F4+PmAOLzQCa8s8XzZGrOwH6+AYKXwtydgWDcniY
	EKqFOk6Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRY47-0007GR-KY; Thu, 23 Apr 2020 09:22:39 +0000
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRY43-00076K-P7
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 09:22:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5M+MgsUu/budCfAjNUwrpxXLb6ZgahxZbxZwetLwzWDnMV2dg/Gyf3ZFqK5sza4QxE+pmSZ/320/3ngwwU6KHTiN1CcBZhzbSQcEx4SOaKF2WFq5Wix5ZsEDTqZq2w+ly9NLmPLLCGVEigfFAH7BWE/yTEIJ3/vNb7AB71xyTtIggIX4XeQ6diYfeKV1SJN3Rb7+cF24h0kk3QsBA2y4LLoIQB95+znfihqPC3kZN5bMIxTpdtU0QK3rkKYfmkKykBPmLHkXKmujkPWP8jfE9XH6PdLjDwJAbIYTM5I8Y9npEGMiVD/B1XZZtR9oFkcrez5pEZr1y+dXf12IRkCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJuarDSoufJgjMXcgf5FRRL/DBmwL3iA0n9t9GJP2jE=;
 b=EhyZlLr7te129BBNhKSFJACuHj/H1tlojy91SiQU/i5A+VLbgBisK3OWnhzrs6cayJNlWAI0BvOX1gNnNKvGaloHzeCXPssLPtqEi/WL5IMNxpbvV9680JH7zIO7Nt88RZTREJ+4dTBi2gjroKzJTrTlOAuZPpeLvFRdL6Qayy80TpTGvxW4QS2opW5Cxw0cw2pYh9lxakIh8I6aPgmWVzjxVssJTQgx/y6xlXbBaRm9xjxBq88Ti4AoWkOT41hPioN7NBFmKrebw18E/Xrxc1jrwtZrT3vQTUgKU1sJyWBotwBODSaql0vDZAGtUIOY/3uSySEiHlqrqwEiCcjfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJuarDSoufJgjMXcgf5FRRL/DBmwL3iA0n9t9GJP2jE=;
 b=LmGabd5iywADn8LKIJG1Y/UTXAz3mf8VqCyQqk9g6QNKB2rrQ1sUU2yUyeJYaxWOg6gtcePmdu7Odz3jL1OqiyR+Oj5KeYZdWjWkb+XXhuC1ZGB08CjIsx4Kz4qeFX5HWNdv2eCvlNTSioZBf+zHGUMt3QjXhJVRXJQlF40giow=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5059.eurprd05.prod.outlook.com (2603:10a6:208:c6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 09:22:32 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 09:22:32 +0000
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-10-maxg@mellanox.com> <20200421122030.GI26432@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
Date: Thu, 23 Apr 2020 12:22:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421122030.GI26432@lst.de>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 09:22:30 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74235d15-c595-4c01-4201-08d7e767d9cb
X-MS-TrafficTypeDiagnostic: AM0PR05MB5059:|AM0PR05MB5059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB50596042CFA380FAECD2E56FB6D30@AM0PR05MB5059.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(8676002)(186003)(66946007)(66556008)(16526019)(107886003)(6486002)(6916009)(956004)(66476007)(86362001)(52116002)(53546011)(4326008)(31696002)(2616005)(26005)(31686004)(8936002)(2906002)(478600001)(36756003)(81156014)(5660300002)(16576012)(316002)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOz410RHSVd8hCDHKUhrmP65xI0zZ07SHlKOGE4qEO56MBuqJOL7VuXMNIGBMWJKVdSP9ULTqpt+LJ10weSCZ5iOqkdjLQzCQDgeuyWRn+LI+XMY1mRKBjFpBthclU4QQFiDaRAZYi5gLa3FgFJ72GG5lgeAiMFl6c1eo5r4N33exy/8bGIQBP4NkepNfphcQAeGeaUPCk5xiWXDNm5QV98mcKbcSud2FABErrH4i6pvj7XbC+SeEzX30R4vD6D4TKSVFLZqsT/GPxe5tny5H9qu1FRelDgyPxrXkh5mc2rvxays25fjHm9KWGFl6+cpag+k+6SI/ILdWwqr0TCGfUl8edaP53nm1kXLZnYqiFIDEDB/t6jjmOHg6mYXkAVXdLhTlUtxTYr4UtGU/U8iwTUUUDObcqdCmCfn3LnWsNUI0GJX71VUxYAy26nWseI5
X-MS-Exchange-AntiSpam-MessageData: MYMqaE8oYQm2S+8xA8INIE0b2MyWVHJmLGiXJ/XJn7j/ZR7vtFF7I+N1kRV/hcV2rBIKOki42yhv2vOgQVHs5mvT1w8J9VpNOyRQTOWhoCKXG+SP1Fs41TYK68iEFkjDF7El/LxI501xTwtLqR7Dn2FQJc2xPqD7VOpXp/wn9uLmJfess30+bWNNUvdQmpWlAZuyFdmXVguXh+gfbnhiNXTU+qka0rU3qPH8at5aidITrqqzYfJS7mAu4+02kpGTi8ZR/ix2oC+NMwVMa5voiqa6gFSHgE173uzrKhNmriWW6/FqKe24FOMjLoOORzp85uq+/YpsxGyOqrw4CZj/xTUU4+APSPm5NUTzC+g4cNdXX7AbmuxxV3JUQ6RshyJR318q6f/ozLT/uJzomV7rKm6hVHfig9knaIyslk2f2ARq9hAd2jh5YXIGeWnqBu1Yz6kO9GoAYjlqWY/x0vXhqd18C4qvcKYDslRGu1ngMqXvx1bil4SstsXCkOfD7xxt4vd/UGHeWmReOBhjnC1goDcREAdCyMjPwjZJFRpvuVrWjnDXjTtcdsjBXPHDmplvulEPiNqHGHPMbeVvyBADhGiHFhy1X8ZZws0QKsaaRiQCFsffMipb8OMNTaV1W80iPVujckUe7CrbttnxPpsl4OkgF3ZDT7qVFariNkugk7GKusBM2y2TUWu7lFG9QOEmmC3fx7+wo5pNDP6FYnjfkaM2NFudnyqVUsVgHccQBiHv0HflvXJ70gmKoi+hIywXKWDMcvtC/WoJjaMS1SDAF51dNtowPuhh7/CSagPkgnWNggGnbcyEiYHrDBXHM07S
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74235d15-c595-4c01-4201-08d7e767d9cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:22:31.9947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWu++Q6O388pJvhltdLe/QHWwTenKoOyeo+POWMpTMHxcBa24qr6Qt0GZbMXdCwC0Cu8I5unrKMru13WWWCv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_022235_881513_416BAF8F 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMjEvMjAyMCAzOjIwIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmks
IE1hciAyNywgMjAyMCBhdCAwODoxNTozNlBNICswMzAwLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+
IEZvciBjYXBhYmxlIEhDQXMgKGUuZy4gQ29ubmVjdFgtNS9Db25uZWN0WC02KSB0aGlzIHdpbGwg
YWxsb3cgZW5kLXRvLWVuZAo+PiBwcm90ZWN0aW9uIGluZm9ybWF0aW9uIHBhc3N0aHJvdWdoIGFu
ZCB2YWxpZGF0aW9uIGZvciBOVk1lIG92ZXIgUkRNQQo+PiB0cmFuc3BvcnQuIE1ldGFkYXRhIG9m
ZmxvYWQgc3VwcG9ydCB3YXMgaW1wbGVtZW50ZWQgb3ZlciB0aGUgbmV3IFJETUEKPj4gc2lnbmF0
dXJlIHZlcmJzIEFQSSBhbmQgaXQgaXMgZW5hYmxlZCBwZXIgY29udHJvbGxlciBieSB1c2luZyBu
dm1lLWNsaS4KPj4KPj4gdXNhZ2UgZXhhbXBsZToKPj4gbnZtZSBjb25uZWN0IC0tcGlfZW5hYmxl
IC0tdHJhbnNwb3J0PXJkbWEgLS10cmFkZHI9MTAuMC4xLjEgLS1ucW49dGVzdC1udm1lCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5veC5jb20+Cj4+IFNpZ25l
ZC1vZmYtYnk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG1lbGxhbm94LmNvbT4KPj4gLS0tCj4+
ICAgZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIHwgMzMwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDI5NiBpbnNlcnRp
b25zKCspLCAzNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBpbmRleCBlMzhmOGY3Li4y
M2NjNzdlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4gKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+IEBAIC02Nyw2ICs2Nyw5IEBAIHN0cnVjdCBudm1l
X3JkbWFfcmVxdWVzdCB7Cj4+ICAgCXN0cnVjdCBpYl9jcWUJCXJlZ19jcWU7Cj4+ICAgCXN0cnVj
dCBudm1lX3JkbWFfcXVldWUgICpxdWV1ZTsKPj4gICAJc3RydWN0IG52bWVfcmRtYV9zZ2wJZGF0
YV9zZ2w7Cj4+ICsJLyogTWV0YWRhdGEgKFQxMC1QSSkgc3VwcG9ydCAqLwo+PiArCXN0cnVjdCBu
dm1lX3JkbWFfc2dsCSptZF9zZ2w7Cj4+ICsJYm9vbAkJCXVzZV9tZDsKPiBEbyB3ZSBuZWVkIGEg
dXNlX21kIGZsYWcgdnMganVzdCB1c2luZyBtZF9zZ2wgYXMgYSBib29sZWFuIGFuZC9vcgo+IHVz
aW5nIGJsa19pbnRlZ3JpdHlfcnE/CgptZF9zZ2wgd2lsbCBiZSB1c2VkIGlmIHdlJ2xsIGdldCBh
IGJsayByZXF1ZXN0IHdpdGggYmxrX2ludGVncml0eSAKKG1lbW9yeSBkb21haW4pLgoKdXNlX21k
IHdpbGwgYmUgcmVzcG9uc2libGUgZm9yIHdpcmUgZG9tYWluLgoKc28gaW5zdGVhZCBvZiB0aGlz
IGJvb2wgd2UgY2FuIGNoZWNrIGluIGFueSBwbGFjZSAoYWZ0ZXIgcHJldiBjb21taXQgCmNoYW5n
ZXMpOgoKIgoKaWYgKHF1ZXVlLT5waV9zdXBwb3J0ICYmIG52bWVfbnNfaGFzX3BpKG5zKSkKIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPnVzZV9tZCA9IGMuY29tbW9uLm9wY29k
ZSA9PSBudm1lX2NtZF93cml0ZSB8fAogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjLmNvbW1vbi5vcGNvZGUgPT0gbnZtZV9jbWRfcmVh
ZDsKCiIKCkFuZCB0aGlzIGlzIGxlc3MgcmVhZGFibGUgSU1PLgoKPgo+PiAgIGVudW0gbnZtZV9y
ZG1hX3F1ZXVlX2ZsYWdzIHsKPj4gQEAgLTg4LDYgKzkxLDcgQEAgc3RydWN0IG52bWVfcmRtYV9x
dWV1ZSB7Cj4+ICAgCXN0cnVjdCByZG1hX2NtX2lkCSpjbV9pZDsKPj4gICAJaW50CQkJY21fZXJy
b3I7Cj4+ICAgCXN0cnVjdCBjb21wbGV0aW9uCWNtX2RvbmU7Cj4+ICsJYm9vbAkJCXBpX3N1cHBv
cnQ7Cj4gV2h5IGRvIHdlIG5lZWQgdGhpcyBvbiBhIHBlci1xdWV1ZSBiYXNpcyB2cyBhbHdheXMg
Y2hlY2tpbmcgdGhlCj4gY29udHJvbGxlcj8KClRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gYWRtaW4g
YW5kIElPIHF1ZXVlcy4gSSBkb24ndCB3YW50IHRvIGFsbG9jYXRlIFBJIApyZXNvdXJjZXMgb24g
YWRtaW4gcXVldWVzIGFuZCBwcmVmZXIgbm90IGNoZWNraW5nIChpZHggJiYgCmN0cmwtPnBpX3N1
cHBvcnQpIGV2ZXJ5IHRpbWUuCgoKPgo+PiArCXUzMiBtYXhfcGFnZV9saXN0X2xlbiA9Cj4+ICsJ
CXBpX3N1cHBvcnQgPyBpYmRldi0+YXR0cnMubWF4X3BpX2Zhc3RfcmVnX3BhZ2VfbGlzdF9sZW4g
Ogo+PiArCQkJICAgICBpYmRldi0+YXR0cnMubWF4X2Zhc3RfcmVnX3BhZ2VfbGlzdF9sZW47Cj4+
ICsKPj4gKwlyZXR1cm4gbWluX3QodTMyLCBOVk1FX1JETUFfTUFYX1NFR01FTlRTLCBtYXhfcGFn
ZV9saXN0X2xlbiAtIDEpOwo+IENhbiB5b3UgdXNlIGEgZ29vZCBvbGQgaWYgLyBlbHNlIGhlcmU/
CgpzdXJlLgoKCj4+ICsjaWZkZWYgQ09ORklHX0JMS19ERVZfSU5URUdSSVRZCj4+ICtzdGF0aWMg
dm9pZCBudm1lX3JkbWFfc2V0X3NpZ19kb21haW4oc3RydWN0IGJsa19pbnRlZ3JpdHkgKmJpLAo+
PiArCQlzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQsIHN0cnVjdCBpYl9zaWdfZG9tYWluICpkb21h
aW4sCj4+ICsJCXUxNiBjb250cm9sKQo+PiAgIHsKPj4gKwlkb21haW4tPnNpZ190eXBlID0gSUJf
U0lHX1RZUEVfVDEwX0RJRjsKPj4gKwlkb21haW4tPnNpZy5kaWYuYmdfdHlwZSA9IElCX1QxMERJ
Rl9DUkM7Cj4+ICsJZG9tYWluLT5zaWcuZGlmLnBpX2ludGVydmFsID0gMSA8PCBiaS0+aW50ZXJ2
YWxfZXhwOwo+PiArCWRvbWFpbi0+c2lnLmRpZi5yZWZfdGFnID0gbGUzMl90b19jcHUoY21kLT5y
dy5yZWZ0YWcpOwo+PiAgIAo+PiAgIAkvKgo+PiArCSAqIEF0IHRoZSBtb21lbnQgd2UgaGFyZCBj
b2RlIHRob3NlLCBidXQgaW4gdGhlIGZ1dHVyZQo+PiArCSAqIHdlIHdpbGwgdGFrZSB0aGVtIGZy
b20gY21kLgo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuICBBbHNvIGl0IGRvZXNu
J3QgdXNlIHVwIGFsbCA4MCBjaGFycy4KCkl0J3MgYSBjb3B5JnBhc3RlIGZyb20gaVNFUi4KCkkn
bGwgcmVtb3ZlIGl0LgoKCj4KPgo+PiArc3RhdGljIHZvaWQgbnZtZV9yZG1hX3NldF9zaWdfYXR0
cnMoc3RydWN0IGJsa19pbnRlZ3JpdHkgKmJpLAo+PiArCQlzdHJ1Y3QgbnZtZV9jb21tYW5kICpj
bWQsIHN0cnVjdCBpYl9zaWdfYXR0cnMgKnNpZ19hdHRycykKPj4gK3sKPj4gKwl1MTYgY29udHJv
bCA9IGxlMTZfdG9fY3B1KGNtZC0+cncuY29udHJvbCk7Cj4+ICsKPj4gKwlXQVJOX09OKGJpID09
IE5VTEwpOwo+IEkgdGhpbmsgdGhpcyBXQVJOX09OIGlzIHBvaW50bGVzcywgYXMgd2UnbGwgZ2V0
IGEgTlVMTCBwb2ludGVyIGRlcmZlcmVuY2UKPiBhIGxpdHRsZSBsYXRlciBhbnl3YXkuCgpJJ2xs
IHJlbW92ZSBpdC4KCgo+PiArbXJfcHV0Ogo+PiArCWlmIChyZXEtPnVzZV9tZCkKPj4gKwkJaWJf
bXJfcG9vbF9wdXQocXVldWUtPnFwLCAmcXVldWUtPnFwLT5zaWdfbXJzLCByZXEtPm1yKTsKPj4g
KwllbHNlCj4+ICsJCWliX21yX3Bvb2xfcHV0KHF1ZXVlLT5xcCwgJnF1ZXVlLT5xcC0+cmRtYV9t
cnMsIHJlcS0+bXIpOwo+IEkndmUgc2VlbiB0aGlzIHBhdHRlcm5zIGEgZmV3IHRpbWVzLCBtYXli
ZSBhIGxpdHRsZSBoZWxwZXIgdG8gcmV0dXJuCj4gdGhlIHJpZ2h0IG1yIHBvb2wgZm9yIGEgcmVx
dWVzdD8KCnllcyBJJ2xsIGFkZDoKCnN0YXRpYyB2b2lkIG52bWVfcmRtYV9tcl9wb29sX3B1dChz
dHJ1Y3QgaWJfcXAgKnFwLAogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBu
dm1lX3JkbWFfcmVxdWVzdCAqcmVxKQp7CiDCoMKgwqDCoMKgwqDCoCBpZiAocmVxLT51c2VfbWQp
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWJfbXJfcG9vbF9wdXQocXAsICZxcC0+
c2lnX21ycywgcmVxLT5tcik7CiDCoMKgwqDCoMKgwqDCoCBlbHNlCiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWJfbXJfcG9vbF9wdXQocXAsICZxcC0+cmRtYV9tcnMsIHJlcS0+bXIp
OwoKIMKgwqDCoMKgwqDCoMKgIHJlcS0+bXIgPSBOVUxMOwp9CgoKCj4+ICsJaWYgKGJsa19pbnRl
Z3JpdHlfcnEocnEpKSB7Cj4+ICsJCW1lbXNldChyZXEtPm1kX3NnbCwgMCwgc2l6ZW9mKHN0cnVj
dCBudm1lX3JkbWFfc2dsKSk7Cj4gV2h5IGRvIHdlIG5lZWQgdGhpcyBtZW1zZXQ/CgpqdXN0IGdv
b2QgcHJhY3RpY2Ugd2UgdG9vayBmcm9tIGRyaXZlcnMvc2NzaS9zY3NpX2xpYi5jLgoKSXQncyBu
b3QgYSBtdXN0IGFuZCBJIGNhbiByZW1vdmUgaXQgaWYgbmVlZGVkIGFuZCB0ZXN0IGl0LgoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
