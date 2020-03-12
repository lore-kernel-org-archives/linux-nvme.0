Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB2C10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 09:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E478206F1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 09:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oG9cDYf2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IuheHopv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E478206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=inbkU0Mk9UDKEQgwkJuLYASdEErpqw/LOCP/3TEC6VU=; b=oG9cDYf2gRKFg3PcX6kx6fLEg
	5Z6bqW3/IMuYqiY13QbGfu012B3Oo5Oux8+CbsxComAFy3y75jjcAdtpkSsUqThGrD9T9xq91BRIE
	9aBplSXBFpqMinCPhf4C+mBGW9PGSMW4E+2h1mLIJG6VR4x2mGFxJalvLPrFvp1+khVa7O14OCHl7
	lnmdLHmLJZtRJ2QgbLKLJYVrADAiYqdB4NlE9PNjezv3YUk10+1H1kaNs1u5yxFMiY1JXxxBSykIP
	x+q99nSMrQVK/XG7154A9SEh7nctVby8lYNRx3ItlGdmYPRwT+WSoBE35JEUOMIcx5FCekSh1PQ8K
	xRoNJ+SWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCJlR-0000rE-I6; Thu, 12 Mar 2020 09:04:25 +0000
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com
 ([40.107.21.68] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCJlH-0000k1-SC
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 09:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzMjHJploFQkkbzTCxYA0Ez40maqRbQhfeEQvkqHZ0bNr0Po3TA82/L+Fibo2B22c+ZlYdYp4A3UHHij4IrWvyHsHJ6o3yDBhodSiriuFdEO8iiZTgTwPNIIEKQ5IaBmM7NTH3H9p3htalzX3thEUltO49QwlCN8mGzfPedF06BDUlXoD49fmWoQBbeS84EsdoVa7tasGmnv2w/4PfpoU7HmR6veFbTT+lX+ZvtWdn/AGynbyUREkS1TT60kwYdQ3baGoOlvfZteTuWXwOPkrduGeiJudU399evVK6xo78SLrpriGYzVdgUytK3LSWb3/KN5Ojb1WOlu2Pk7UlOQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g0wbRvG/DhawzU3/AjtwwKBT6vLiKUiHyTIDvBgNcE=;
 b=j4lrjmYdMefbE8+ipPu2SmUGN4wX04QsNgSPf5YBE3JGpR94vqZR92A1nTyM/QWTkR1J2Ky7jL+1ECOPNHci04QzT1P7kEuc38p3NmdN7XLRR9VLw0teMYOo8a0BYEA4vteUfaKfBXtih1UCVUgJchhSarBl3K9CX1XD13drFJdb3jlDRLFGCHdHpWet5td7Q0PTECDh0984T5/OnFFDABb4XK9bReP8z0yWgYqTixdnccBgh3EipYmiw35G4HfclsidnXArSGEHqaR0S/ZncSx4z955djjsRk7OkTryDzpUZ8vVqkxmiVQBzFuOkDSteeFee8x8L/cNORxod34BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g0wbRvG/DhawzU3/AjtwwKBT6vLiKUiHyTIDvBgNcE=;
 b=IuheHopv0rTr/1nFcsxozazILjUdysRYU2U+4XiUOzDT+cBYs3shLUrk8eFdQwZZF17pN1vSlOK357eH5F7YlzAX9ae+7mDbf0XWeBMW4kBY13B3eIZYiTWx4zeemZyxogQM56kYoyuCLPNY4bSpw5DUL8JNvFam7xqxlakHoYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3843.eurprd05.prod.outlook.com (52.133.47.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:04:12 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:04:12 +0000
Subject: Re: [PATCH 1/4] nvme-rdma: Fix warning at nvme_rdma_setup_ctrl
To: Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-2-git-send-email-israelr@mellanox.com>
 <974e3bd2-3282-5703-eba6-bc2675c98c8e@grimberg.me>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <e15f12ab-bf40-423d-956a-199897a5b3f5@mellanox.com>
Date: Thu, 12 Mar 2020 11:03:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <974e3bd2-3282-5703-eba6-bc2675c98c8e@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:208:55::21) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.3.91] (193.47.165.251) by
 AM0PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:208:55::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20 via Frontend Transport; Thu, 12 Mar 2020 09:04:11 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fac1e41-204c-4db7-e1dc-08d7c66454f2
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3843:|AM0PR0502MB3843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3843C2548C8DAEE2D59C6AE6D7FD0@AM0PR0502MB3843.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(66946007)(956004)(2616005)(4326008)(5660300002)(66556008)(66476007)(478600001)(2906002)(53546011)(6666004)(16576012)(52116002)(86362001)(316002)(26005)(81156014)(81166006)(107886003)(6486002)(8936002)(31686004)(36756003)(31696002)(186003)(110136005)(8676002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3843;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpBfrnV3c7GM1vUY1Xvm+JXpOV5SikrGsAVz3koq2pX5RjcZ+A6jhAznCNZEeuTNCptDqnG3ktgWDCtCMoWLAcHVSacsKABO9n6O5NJ+tXuC7Q1FQAyYrxOGcAATa5VtD/9n8KXkR2Al3Gm31C8Xls61nUJJFHKknlQOC0H1qO/MuManfXvrItycoazNAOL2LUZGiy/ZoJqb4+Vd5ZHXrkexfj4LKAZU9tkcMedk8XgI1toyVHiti49m0L7DwUuSXoxoWSiu/Hs7NJeMbgHvOLr2lWIH9tCz3fMR+Z0t0NlRhMz0vMYeWwRG9kmeKf/Oj+ZccBxl8Ev1t9MB6pnJG8MNRg0FZxR+1ThUVLwLfsN7XjpqhdEqSTEvbq7rP4IcQnSga07H0hngJQe4Bi8p0rmoPS5ST3J/LVdTr+XE99BLqBgBJe10E8UbXXugz8ls
X-MS-Exchange-AntiSpam-MessageData: 2Vv54Ui3H8actdSu0lTrV9aaJikPZAij6zhsDZUhRuT7zbJDTywtcRPq392MLEbK2pcn3ot7H4y6O95e4ruNpSjKrIb4c3ijjhIeHsGs4CT6rjAYTpRHeIs6fRj755bYnq+y4zS29IXm229Mfrd07g==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac1e41-204c-4db7-e1dc-08d7c66454f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:04:12.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J5Rauhizi6hjeWKVHX48y8VosPTZfC4H0efij53jEZQFvnKeAWc4ei+hLshJwjd9oBrCx5baTG0Y6ekctVyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3843
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_020416_054531_9C1D74BD 
X-CRM114-Status: GOOD (  10.64  )
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

T24gMy8xMi8yMDIwIDg6MzcgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+
PiBpbmRleCBkNjAyMmZhLi41N2Y5MDMxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9yZG1hLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+IEBAIC0xMDg0LDgg
KzEwODQsMTIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfc2V0dXBfY3RybChzdHJ1Y3QgCj4+IG52
bWVfcmRtYV9jdHJsICpjdHJsLCBib29sIG5ldykKPj4gwqAgwqDCoMKgwqDCoCBjaGFuZ2VkID0g
bnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSgmY3RybC0+Y3RybCwgTlZNRV9DVFJMX0xJVkUpOwo+PiDC
oMKgwqDCoMKgIGlmICghY2hhbmdlZCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgLyogc3RhdGUgY2hh
bmdlIGZhaWx1cmUgaXMgb2sgaWYgd2UncmUgaW4gREVMRVRJTkcgc3RhdGUgKi8KPj4gLcKgwqDC
oMKgwqDCoMKgIFdBUk5fT05fT05DRShjdHJsLT5jdHJsLnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxF
VElORyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHN0YXRl
IGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlmIHdlJ3JlIGluIERFTEVUSU5HIHN0YXRlLAo+PiArwqDC
oMKgwqDCoMKgwqDCoCAqIHVubGVzcyB3ZSdyZSBkdXJpbmcgY3JlYXRpb24gb2YgYSBuZXcgY29u
dHJvbGxlciB0bwo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGF2b2lkIHVzZSBhZnRlciBmcmVlIChj
dHJsIHJlZmNvdW50IGlzIG5vdCB0YWtlbiB5ZXQpLgo+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+
PiArwqDCoMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKGN0cmwtPmN0cmwuc3RhdGUgIT0gTlZNRV9D
VFJMX0RFTEVUSU5HIHx8IG5ldyk7Cj4KPiBXaGF0IHN0YXRlIGFyZSB3ZSBpbiBpZiBub3QgREVM
RVRJTkcgaW4gdGhpcyBjYXNlPwoKV2UgYXJlIGluIERFTEVUSU5HIHN0YXRlLgoKV2l0aCB0aGlz
IGNoYW5nZSBhbnkgc3RhdGUgZmFpbHVyZSB0cmlnZ2VycyBhIHdhcm5pbmcgKGluY2x1ZGluZyAK
REVMRVRJTkcpIGlmIG5ldyBpcyB0cnVlLgoKSW4gbXkgdGVzdCBJIHdhcyBpbiBERUxFVElORyBz
dGF0ZSBhbmQgd2l0aCBuZXcgPT0gdHJ1ZQoKVHJ5aW5nIHRvIGNoYW5nZSBzdGF0ZSBmcm9tIERF
TEVUSU5HIHRvIExJVkUgaXMgbm90IGFsbG93ZWQgYXQgdGhlIHN0YXRlIAptYWNoaW5lLgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
