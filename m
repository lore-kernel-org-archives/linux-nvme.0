Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB29C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695902077D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B+aLz8Of";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Jp19JOKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695902077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sRJjR2JV3+VB26ko+7VKefaIuQKOh2Ww7ujo9I4d3Pk=; b=B+aLz8OfWsMtWW/r4d4zFZZoO
	03kXCLNFd6YvMYfcaVWcx8xiyBzs/9UGcLfgFj07ADJUe2S3lfM3EbfP2mtFOIxnFK3iH11Z2gjQC
	QC9uFWVL7TDrkbl+14nV5iG2eNG0J2wkT6AOnCWmYHwiX+o3vfGHFP+KRYrCvfWyhixBp5/PV602r
	iGOb026YZugLGYbH62QetnloxBq7bvU4e+s40wDHoyhgxlIMwAUCtfn9NHUUOKDMAcYQ6ljNZZU+v
	OOiXojZSH7s1kZwlWA7pr+rO9Fy5+YBB9KXCGSKn4jaqPk8NVJmsaP9tJkptQsAED3aWn34EdQ+fm
	8O3PVSZJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jH2ww-0004IZ-Hj; Wed, 25 Mar 2020 10:07:50 +0000
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jH2wt-0004GJ-M1
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 10:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLsBc4BT48sC/nDb/h02i07CW4mU2yUev/zcrOjV0xORw2g8F3GBl7ZFYqDvH/Z2fe2ERcdIu2RRw55sQK+Cw6mZA7wCMbuCRPtXpD70hBnk/fCuFeZaQV1yusoBLSoZDy+M/PEdKd+pu1JBQMNOq3dT44xpxd096nUlFeiVzUMjI23TtAWWMhjR4FB/wmOJlAaDgxx2TrUYSfbK+ht/t+4EVy9DVYk3JGktHOzFzrYfaYn289kXrMOQlIfp9YH9lEMhIO0cC8TevlvvfXFBj/jPE9IGUULvPIcvLJ37IFq/LO0CLDpkqePMECxe89LQVZ5AFQ4Xn0Rt5Acl6Ey0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3al6HnQL/7XawQVw7/7WSCKHBjyQq38v9HYre7hMGQ=;
 b=SeMlWQTKaTmFKN0nNG5V5CMkLoWAMox4KVLGQj6M0eeusbaWxucQ2oek+QCKZvAC1kM1YqgOiTyC+4vtaLc7s/S9yDsAN+0kT55Fs74Z7HPKv4YqS2e0Mtfsk+iCA0QwAMbz2gQHxisi219l+/L3fRBS9GGkwnkr2S4IrzbgZCA3YVnIsKhbIQ2k6BrSj/2e7zBk3o+jmlFOL3NzB34q5pAFQl74xJBU9MV1zOGkvF0+D8cpjE9QPcZ/AJv47L4NLOWkhhRHsQyZzXFW9klk2UKWHnjsFyx4Nxv6kNJPjkshb4bEOVVQHuxgmT30eaXb7tsBFfPOXs7w3irjR66IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3al6HnQL/7XawQVw7/7WSCKHBjyQq38v9HYre7hMGQ=;
 b=Jp19JOKICHofFONeyvsFE4ygQXfuIohb5M3bDVB+gYsPhChD55qF6YxnAKFiV/SgwIBc4W9OYCtm07p/+maqFnNrs8MWNqpSn/rS483084CWVRP50oNPQgefwY5qqIE16v+vsSuRYXRDFjfaVhRdgh+VgcVIL6EeWN3CEfSUq7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3796.eurprd05.prod.outlook.com (52.133.47.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 25 Mar 2020 10:07:44 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:07:44 +0000
Subject: Re: [PATCH 6/7] nvme-rdma: Add warning on state change failure at
 nvme_rdma_setup_ctrl
To: Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
 <1585063785-14268-7-git-send-email-israelr@mellanox.com>
 <b49bee23-3041-9e35-5359-efbc861be595@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <660765ef-6394-28b6-279c-78656cdc2771@mellanox.com>
Date: Wed, 25 Mar 2020 12:07:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <b49bee23-3041-9e35-5359-efbc861be595@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::49) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.14.112] (79.183.233.221) by
 AM0PR01CA0072.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Wed, 25 Mar 2020 10:07:43 +0000
X-Originating-IP: [79.183.233.221]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75843967-09a2-4416-1fa9-08d7d0a45c9e
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3796:|AM0PR0502MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB379674E10FD1C23726C301F9D7CE0@AM0PR0502MB3796.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(4326008)(8936002)(16576012)(8676002)(66476007)(956004)(2616005)(36756003)(31686004)(26005)(66946007)(53546011)(110136005)(81156014)(52116002)(16526019)(81166006)(107886003)(54906003)(186003)(66556008)(6486002)(316002)(86362001)(5660300002)(2906002)(31696002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3796;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRE11G4RnW6ZlpJPyImjzwWGdS6WgiWE1GD5IcXZVQPilF7iegX4AP8E3AY21hKMLoesrB1uiS9iqfmXSrkdA/miZ7cYr8ZgApzawvPVTw3Qz1M3zUql/6l/T0pZ/oArxrMo2VZSiTiUbzlN46bjooNp2qomEKaf7CXiZm//sY1PaWbqfC6yqpRT0MrOyUH1gnlBbYzEoIwZkcOhhA0hhg4j6i9xmhiLBHYEaXJwBGXuxRDBa5MqMkwoVOYSvJ9pMGRdQu5Ww/8VP6AqrEAPm5UYc4Qhmgo5I5zsYmVthThzRXQz8kWHm9RTqv0czND9g6IzbjPLeIh5wYfr/n+VkM0Lcr8F8xiZHcOL+yF4MVZpS70Y+lAU1sPmxdFkvX2zFzSMy9gBjRp/h7cTrcJuzNjKWORr0YEcmIY7kQp/F+RjchS54MWDGoo5Oh++6V0H
X-MS-Exchange-AntiSpam-MessageData: /vBCy1BaIC1D0GmeOOzksX/EvFG07yirUeWrYQjBlVgdeA53Bt6MEVahk6Klp0Zq05KJFYZ56WJgSOD5pqj1Pd5Op4w3QHuZA2MzWiC8fEs41n52diZAChgPW8D9XAGyK9BMd9QFAvqxZxU6yaPzVg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75843967-09a2-4416-1fa9-08d7d0a45c9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 10:07:44.5773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiGcA7H+APihAdFW4QNsdEvrXT/HVAEK6p+0FiZ+i8FjzdbYXIoNI1OtnhqYC6jmyYP3WnAiZQ1yh85/ctYcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3796
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_030747_724736_E790F1DD 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8yNS8yMDIwIDI6MTkgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4gVGhlIHRyYW5z
aXRpb24gdG8gTElWRSBzdGF0ZSBzaG91bGQgbm90IGZhaWwgaW4gY2FzZSBvZiBhIG5ldyAKPj4g
Y29udHJvbGxlci4KPj4gTW92aW5nIHRvIERFTEVUSU5HIHN0YXRlIGJlZm9yZSBudm1lX3RjcF9j
cmVhdGVfY3RybCgpIGFsbG9jYXRlcyBhbGwgdGhlCj4+IHJlc291cmNlcyBtYXkgbGVhZHMgdG8g
TlVMTCBkZXJlZmVyZW5jZSBhdCB0ZWFyZG93biBmbG93IChlLmcuLCBJTyAKPj4gdGFnc2V0LAo+
PiBhZG1pbl9xLCBjb25uZWN0X3EpLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBJc3JhZWwgUnVrc2hp
biA8aXNyYWVsckBtZWxsYW5veC5jb20+Cj4+IFJldmlld2VkLWJ5OiBNYXggR3VydG92b3kgPG1h
eGdAbWVsbGFub3guY29tPgo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA3ICsrKysrKy0K
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hv
c3QvcmRtYS5jCj4+IGluZGV4IGM5OWE4ODIuLjNhZTMwMTEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4g
QEAgLTEwMjIsOCArMTAyMiwxMyBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9zZXR1cF9jdHJsKHN0
cnVjdCAKPj4gbnZtZV9yZG1hX2N0cmwgKmN0cmwsIGJvb2wgbmV3KQo+PiDCoCDCoMKgwqDCoMKg
IGNoYW5nZWQgPSBudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBOVk1FX0NUUkxf
TElWRSk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFjaGFuZ2VkKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCAv
KiBzdGF0ZSBjaGFuZ2UgZmFpbHVyZSBpcyBvayBpZiB3ZSdyZSBpbiBERUxFVElORyBzdGF0ZSAq
Lwo+PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBzdGF0ZSBjaGFu
Z2UgZmFpbHVyZSBpcyBvayBpZiB3ZSdyZSBpbiBERUxFVElORyBzdGF0ZSwKPj4gK8KgwqDCoMKg
wqDCoMKgwqAgKiB1bmxlc3Mgd2UncmUgZHVyaW5nIGNyZWF0aW9uIG9mIGEgbmV3IGNvbnRyb2xs
ZXIgdG8KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBhdm9pZCByYWNlcyB3aXRoIHRlYXJkb3duIGZs
b3cuCj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBXQVJOX09O
X09OQ0UoY3RybC0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJTkcpOwo+PiArwqDCoMKg
wqDCoMKgwqAgV0FSTl9PTl9PTkNFKG5ldyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAt
RUlOVkFMOwo+Cj4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHRoaXMuIFdoeSBhcmUgd2Ugd2Fy
bmluZyBvbiBuZXcgY29udHJvbGxlcj8KPgo+IEFyZSB5b3Ugc2F5aW5nIHRoYXQgYSB0aGUgc3Rh
dGUgY2hhbmdlIG11c3Qgc3VjY2VlZCBpbiBjYXNlIGl0cwo+IGEgbmV3IGNvbnRyb2xsZXI/IGJl
Y2F1c2UgaWYgaXRzIGV4cGVjdGVkIHRvIG5vdCBzdWNjZWVkIGluIGNhc2UKPiBvZiBhIGZhaWx1
cmUgdGhlbiB0aGVyZSBpcyBubyBwb2ludCBvZiB0aGUgd2FybmluZy4KPgo+IEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcgaGVyZS4uClllcywgdGhlIHN0YXRlIGNoYW5nZSBtdXN0IHN1Y2NlZWQgaW4g
Y2FzZSBvZiBhIG5ldyBjb250cm9sbGVyLgoKTW92aW5nIHRvIERFTEVUSU5HIHN0YXRlIG9uIG5l
dyBjb250cm9sbGVyIGlzIGZvcmJpZGRlbiwgdG8gYXZvaWQgcmFjZXMgCndpdGggZGVsZXRlIGZs
b3cuCgpUaGUgc3RhdGUgbWFjaGluZSBhbGxvd3MgdXMgdG8gbW92ZSB0byBERUxFVElORyBzdGF0
ZSBmcm9tIENPTk5FQ1RJTkcgc3RhdGUsCgpidXQgdGhlIGlvIHRhZ2VzdCBmb3IgZXhhbXBsZSBt
YXkgbm90IGJlIGFsbG9jYXRlZCB5ZXQgd2hpY2ggbWF5IGNhdXNlIGEgCmNyYXNoIGF0IHRoZSBk
ZWxldGUgZnVuY3Rpb24uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
