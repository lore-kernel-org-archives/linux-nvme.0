Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A24C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233CE20658
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JS3+64h4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="b/mmtBz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233CE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v5imbGiBjUgNrF86P3Wr1dAZVXlCTWSoA1fM/sIh3R0=; b=JS3+64h4IxCLxJFBlwRpwSAQj
	X3poGSUp3Bcdqr5PJj5z/5QNIsKNwTxr6N2gozZ47oQX0wyUrBeTPkgOqHoBhr1BWCk2elPIVgUF6
	w2lJDghQYF4evf5TM0zqLb/sE24rijhIQiGDeO2PqtQBtFChz6rnHUctm40g7+comlx6RV9nvhctv
	olt/QI85BziXlNHxmkxw26MlRPy/Cdfi90uCMWPjFlDmOYjAkwNFe1cqNLBEiPZhxPKEIU//Weirz
	B7JkzEs7mflFHIBPIvQ6P3j/WZPO/zWpEZd745fnSVnQr8KWuKuTc8a6c5SOQOVqlNiOmHgw85QW4
	UFfzQjRRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEAjK-000144-Ac; Tue, 17 Mar 2020 11:49:54 +0000
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEAjH-00012u-7s
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 11:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZvooqCbCy6LhediSmBAUFZYc9dp8OyOaa6OlTAU5STB97w/WAXxxTlqQr+8iK5SqWoezozs47QLwKHetKon+3CASX0SDvgoQZP4Z4TacyOHcP0W8wWqJqR5MYURaCe/BACpDxS4NNu3JA5DdwtbEZ/LmX4H+l3zAIkVbz12j4koCKARkSo5gT4ft6VItip3LS9Th7rvx952s5LnXrQc5qnICH/oFWFGJ3s9wogIMZE0I9bKHVgSNpXWmuAfBpabsyEWxfOP9F2cIqMFP9xgNdpkzbjLp6a1IuHMKTVz3tffBbsQlpqpFwaJUi7wtDOZaot1+qEMUQNm8FKB/pVj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW8JKDx7b7nRx+pVxit3EsSoUlfZ3mRclyiP6xGd5LY=;
 b=F44aOI6Vpdp6gh2/LkTEucss7YekeLgbP+qZ7jctwvevynEnjcB8jctEHui8Qi7SzdjnTq16WqXGV2XwPkspfGrrwR5XC0u21jRtHNtBooOrpqPzmcgJddYZaeZivIlQ1X/Ung6QaaM4MwkOiMQi9Zm13KqwvKSuzM7tNPH4l6iebBJsCkyQjm5iGrcDhtiJgU8VgDBtGYmPTePemPeBRV8RLS5bs7NDNJXV+4WK1gOkSM4ouFZ7wND4tDdXeSn8EbgGjSaVuwv+rU/uCwOYJURysByEENyG8eUJmCAPXhQtDXJEcmklbtLKfdXJbikEsAUzLAaDJf6pMgcIbABIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW8JKDx7b7nRx+pVxit3EsSoUlfZ3mRclyiP6xGd5LY=;
 b=b/mmtBz838cprI7tTGkU2TWvwM2sjle5U/IlaO42cZrXmEcGZuIpMt90sTRh1EiLI/BcZmKlFw38S62QAM9zI716O9K1auACsdWjDRTrDNABgs2ENMLVqc21JinoPaTmqg3lHoUHHo+QGh5t41dmpJVozileUjmpUK6mDNlsaY4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3620.eurprd05.prod.outlook.com (52.133.46.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 11:49:45 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 11:49:45 +0000
Subject: Re: [PATCH 4/4] nvme: Fix controller use after free at create_ctrl
 callback
To: Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-5-git-send-email-israelr@mellanox.com>
 <8d294ef5-ca01-4458-441c-b987a173d39c@grimberg.me>
 <e12ed56f-6bfe-dcee-9967-f6f58f06a9f0@mellanox.com>
 <7710cc5f-850a-f260-fb02-423a46867534@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <e010bbdf-a28d-5ea5-2764-d624845bfe63@mellanox.com>
Date: Tue, 17 Mar 2020 13:49:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <7710cc5f-850a-f260-fb02-423a46867534@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:208:122::40) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.3.91] (193.47.165.251) by
 AM0PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:208:122::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend
 Transport; Tue, 17 Mar 2020 11:49:44 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1f7760a-88d6-48c9-473e-08d7ca6949be
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3620:|AM0PR0502MB3620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB36207C57F7656830F1806D43D7F60@AM0PR0502MB3620.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(86362001)(66946007)(81166006)(81156014)(66476007)(8676002)(8936002)(4326008)(66556008)(5660300002)(478600001)(52116002)(53546011)(107886003)(31696002)(6486002)(316002)(110136005)(16576012)(2616005)(2906002)(31686004)(956004)(26005)(36756003)(186003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3620;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRlLkwv3f/yOz/dHXxeQHcuEl98+Uo/0vLB1kV9Eu5+wX1OGmpgnpgVfCcmAym+X0QrCTXlpNu1lxz5/q9jDdRLiTSoOcFhSW41vHFUdnz7nmTPM5KWzG///V+r1lr4fbdJpF72RGL7wRbEiBuxHPQ5HUREzQ/42KG1uskumYR+qIWT7P0H+QrbPQbdSWUKNMsn3iXSQQ27VSdFj7W0YE3n0TLJp/ii8vOX9xL+pg+VmBNpxfFinh86vVFF5PRVbBObbMwk8fdKEYpaDij+uz+Lrw2kY3qgrTwu6gKNFLcBC+kf+xKn3M5BNoF763PpHUqMOhEGhnfO18KZI/uGeu8zMI7tiQd01ydkWtoSTVd3tT52bCWrNlOZ2iUIIL/FeEyc97zWJtBZFK9oPDJd0PW6IsuVm5jIIJU8//Sa+prKAK4PRDBwDkmcjEmAHh/QK
X-MS-Exchange-AntiSpam-MessageData: VWH65B+jWlR00WdFgZk1sdG3biAcpfTS7Gpx+l7r+lINIsmkZI6Vb0eQn6zdBUpqWrpjoSYdEdNB9ZyMOwHZ7nE2ekRNYMBu6uf4mIqZP6HpZSA6KY0ixJUY7VpZnKCfZxz+1YPDcd0dsARUc67ezA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7760a-88d6-48c9-473e-08d7ca6949be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 11:49:45.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HXSN4gbgqfky0MRhUaFaMHJKw/ifYxHSkCqYhUBN7yP1xrMLBvbGhsZ56Hl2wXkNzZB0JEy19on3GroZ9HYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3620
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_044951_345686_2B5DC1A9 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xNi8yMDIwIDY6NDcgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
Cj4+Pj4gaW5kZXggYzBkOWIxOS4uNzk3Njk1NSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKPj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4+PiBA
QCAtMzIyNCw2ICszMjI0LDEwIEBAIHN0YXRpYyBzc2l6ZV90IG52bWVfc3lzZnNfZGVsZXRlKHN0
cnVjdCAKPj4+PiBkZXZpY2UgKmRldiwKPj4+PiDCoCB7Cj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4+Pj4gwqAgK8KgwqDCoCAv
KiBDYW4ndCBkZWxldGUgbm9uLWNyZWF0ZWQgY29udHJvbGxlcnMgKi8KPj4+PiArwqDCoMKgIGlm
ICghY3RybC0+Y3JlYXRlZCkKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQlVTWTsKPj4+
PiArCj4+Pgo+Pj4gTm90IGlkZWFsIHRoYXQgY29yZSBjaGVja3MgYXR0cmlidXRlIHRoYXQgZmFi
cmljcyBpcyBzZXR0aW5nLiBNYXliZQo+Pj4gbW92ZSB0aGlzIHRvIG52bWVfc3RhcnRfY3RybD8K
Pj4KPj4gSSBjYW4ndCBtb3ZlIHRoaXMgdG8gbnZtZV9zdGFydF9jdHJsKCksIGJlY2F1c2UgcmRt
YS90Y3AgaGF2ZSBub3QgCj4+IHRha2VuIGN0cmwgcmVmY291bnQgeWV0Lgo+Cj4gQ2FuIHlvdSBl
eHBsYWluIHdoYXQgaXMgdGhlIGlzc3VlIHdpdGggdGhlIHJlZiBjb3VudGluZyBmb3Igc2V0dGlu
ZyB0aGlzCj4gZmxhZz8KPgpZZXMsIGZvciBleGFtcGxlIHlvdSBjYW4gc2VlIHRoYXQgbnZtZV9y
ZG1hX2NyZWF0ZV9jdHJsKCkgY2FsbHMgCm52bWVfcmRtYV9zZXR1cF9jdHJsKCkgd2hpY2ggY2Fs
bHMgdG8gbnZtZV9zdGFydF9jdHJsKCkuCgpBZnRlciBjYWxsaW5nIG52bWVfcmRtYV9zZXR1cF9j
dHJsKCkgd2UgdGFrZSB0aGUgcmVmIGNvdW50IG9uIHRoZSBjdHJsIApieSBjYWxsaW5nIG52bWVf
Z2V0X2N0cmwoKS4KCkluIGNhc2UgbnZtZV9zeXNmc19kZWxldGUoKSBpcyBjYWxsZWQgYnkgdGhl
IHVzZXIgYmVmb3JlIGNhbGxpbmcgCm52bWVfZ2V0X2N0cmwoKSB0aGUgY29udHJvbGxlciByZWYg
Y291bnQKCnJlYWNoIHRvIHplcm8gYW5kIG52bWVfZnJlZV9jdHJsKCkgaXMgY2FsbGVkLgoKQWZ0
ZXIgdGhhdCBJIGdvdDoKCltUdWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdIG52bWUgClx4ZmZmZmZm
YTB6d1x4ZmZmZmZmZWQyXHhmZmZmZmY4Zlx4ZmZmZmZmZmZceGZmZmZmZmZmLnJvZGF0YTogbmV3
IGN0cmw6IApOUU4gInRlc3RzdWJzeXN0ZW0yIiwgYWRkciAxMS4yMDkuNDAuNjE6NDQyMApbVHVl
IE1hciAxNyAxMjoyMzoxOSAyMDIwXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0KW1R1ZSBNYXIgMTcgMTI6MjM6MTkgMjAyMF0gcmVmY291bnRfdDogYWRkaXRpb24gb24gMDsg
dXNlLWFmdGVyLWZyZWUuCltUdWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdIENhbGwgVHJhY2U6CltU
dWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdwqAga29iamVjdF9nZXQrMHg1Zi8weDcwCltUdWUgTWFy
IDE3IDEyOjIzOjE5IDIwMjBdwqAgbnZtZV9yZG1hX2NyZWF0ZV9jdHJsKzB4MzhjLzB4M2U0IFtu
dm1lX3JkbWFdCltUdWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdwqAgbnZtZl9kZXZfd3JpdGUrMHhh
NzkvMHhkMDAgW252bWVfZmFicmljc10KW1R1ZSBNYXIgMTcgMTI6MjM6MTkgMjAyMF3CoCB2ZnNf
d3JpdGUrMHhhZC8weDFiMApbVHVlIE1hciAxNyAxMjoyMzoxOSAyMDIwXcKgIGtzeXNfd3JpdGUr
MHg1NS8weGQwCltUdWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdwqAgZG9fc3lzY2FsbF82NCsweDU1
LzB4MWIwCltUdWUgTWFyIDE3IDEyOjIzOjE5IDIwMjBdIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDQ0LzB4YTkKCgpXZSBjYW4gZml4IHRoaXMgYnkgdGFraW5nIHRoZSByZWYgY291
bnQgb24gZWFybGllciBzdGFnZS4KCkZvciBleGFtcGxlIHdlIGNhbiB0YWtlIGEgcmVmIGNvdW50
IGF0IG52bWVfc3RhcnRfY3RybCgpLCBidXQgaXQgYWZmZWN0cyAKYWxzbyBwY2kgbW9kdWxlIChJ
IG5lZWQgdG8gY2hlY2sgdGhhdCksCgpvciB3ZSBjYW4gdGFrZSBpdCBiZWZvcmUgY2FsbGluZyBu
dm1lX3N0YXJ0X2N0cmwoKSBhdCByZG1hL3RjcC4gVGhlIHJlZiAKY291bnQgc2hvdWxkIGJlIHRh
a2VuIG9ubHkgaWbCoCAibmV3IiBpcyB0cnVlLgoKPj4gQmVzaWRlIHRoYXQsIG52bWVfc3lzZnNf
ZGVsZXRlIGZ1bmN0aW9uIGlzIG9ubHkgdXNlZCBieSBmYWJyaWNzIG1vZHVsZXMuCj4+Cj4+IFBD
SSBtb2R1bGUgZG9lc24ndCBzZXQgZGVsZXRlX2N0cmwgb3BzLgo+Cj4gVGhhdCBjYW4gY2hhbmdl
IHRob3VnaC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
