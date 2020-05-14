Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7833DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:48:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4699D20575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T47InH2A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="k68bRCQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4699D20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XTCUDqcaZWr64DkipJXbTgqx6T3w7u+arj1Rq0M092c=; b=T47InH2ADG7eEye9iR1X9GUzF
	EL0FmMNHTWmBdBE5yacVN3CAARgbLhiY/qdRZ6ICQlHNwitHAjzJ+uK+XTvWBGszbsNEsdZNxuWe3
	KP8bjf8817u3ZewKWFYHVqaWT+tfBquEiGFFmWJ5f2Qofyq8Wu4jzWFcEfR3+hvhXwd7L0ZJ8B0mz
	gpuNZT2ZPhcTDDvxj+By3j4RWhhVXsRd/3wr24J3bbHn5oqtfY7CdWWQ8wABpRSRdxQmpPmYwp3GU
	jQ6san/b+AhrHQknd2wrILHHgF4J7VUYnAuh2ChfKQ3qyoOjE4c5y09DpV+z/jV6+2H82jQ/k6YnY
	q4A2+P33g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ9XY-0006Cx-TW; Thu, 14 May 2020 08:48:28 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ9XV-0006CQ-P3
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 08:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNF5mYG+mf4FC/+TWFRh6tS38j74xbLznFtBCJIbVihoS+rka2/oxoC8PpDbrSegDqMKsDUFYEefKLvaovZm68QbylZ+sz68WLJT7whPcFiidAgQffyN6nRy8YusC915A2D69ttdfy8K19fZ+v0RPnVtWVB2RqSUUh6UJa9ljLwm6GW4MvzD/3KPBTswOOSAH5504TcU+ZhLPfomslO5YnvDtWjAX1OUqClOfsFMMwPRkqMq5WSnVWVBRzGa27uOQ5rsto0FVpAiJ9yZsmhs3nmW851uB/qz7mCAG5uqKvUzzo51nVQS0lJNzAoaCXs8ciJBa8npOZFrNPmNaRJfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9h8rDvmO0JbORXmYSZIfKLYAorHO+QI4HUgjuPiefs=;
 b=BzVKLTL5TeANLTRZXqhX30kgyp2S40nLqbT4/SELPUhZg3XOIDzcPQ7qcCfTYHkgp1ws0Qnsn64daW65zciaBq13ejilqmMCT0NIR0MTd/oobmfKIxDA6YnIH4tquANsoUCfzffkfUDMsdb7Iu23M4p4bPB4RzDTHK9LA1FVliymlUxo5O+RDvfCPwSRYsFEPhxYZVXwRtFypJ+ZO0D9+oIRUB+phe3G6ugrPjV+si3raKg8Ow0bKBFpWR17UxAD2nr58FGrmZakLILSehxKpRE+OyFvVpuezsWfX+GMwFu71ZR0OdEZXqVqMYf3e+8/ZVmyp2sbeGXfUWVPmeXfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9h8rDvmO0JbORXmYSZIfKLYAorHO+QI4HUgjuPiefs=;
 b=k68bRCQgTZmw8uqJmx4P26FBCSJ2dPscgBBh7AJqUY5I/2tE1L7iXUL4GI7VjdhHmJvOHEyVNKHxJ8u1k8kdFhHIHq7acKVxYcntxf1VN/QG7q3Eg5BEwsH9850UeSpForssbS9edkioITbrTVnn+YrUm9+rM9k1tgEPBMNqAGQ=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4548.eurprd05.prod.outlook.com (2603:10a6:208:ae::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 08:48:23 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 08:48:22 +0000
Subject: Re: [PATCH 09/16] nvme-rdma: add metadata/T10-PI support
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-10-maxg@mellanox.com> <yq1r1vnw74v.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c7f3151e-a401-56f7-735f-476b01337b17@mellanox.com>
Date: Thu, 14 May 2020 11:48:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <yq1r1vnw74v.fsf@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Thu, 14 May 2020 08:48:20 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27b02613-9f65-409f-204d-08d7f7e38ef8
X-MS-TrafficTypeDiagnostic: AM0PR05MB4548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB45484E528EA7379B950AEDF6B6BC0@AM0PR05MB4548.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwjdE7UMM+BsRJNEAPyaXQ/0glVjA4lFXUR1MPjRUWR1An5TvZxeulPet4U/U+ZIRwFmGYSAKI0G/x6DenkeSBIaAAeyAuXKX3bccMUV256Y0Egm0fGy8VHfWgU5taoqU2r1UmMiijSte5ftTTLFfZsiaCXWJqUiyHKhushYqOKGJOXp5MIFIwWuWVFITL6YGt5/iU0kuzpxb8d8xv2IQcg4g8nTbj0hJVULALjyDA+4foIjjZtsGTf3YMVAfvGHOjWuW0NPAcqfiXEmkNtbppWEfl257fpvdFdszOrtOIsYqDhq3swcr808+eUfaMeRRBFh2rFidcyzQFKkFVWVeNaQlE9tX9frenxVBx2ig8H+O1htTUhD+725+Ots7ph7l19ba9K+oA58RVQjSS/MUCV8Sv4naLznnOLda92smp+1DkOairDBSkoxdKknL7fWuC6YeOs6AeLyJ01pV5rmcBzKlp9MWyJTescLHDEUzN5s+DfkBCrX6zg/pM6EU9bk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(31686004)(2906002)(16526019)(36756003)(186003)(26005)(6486002)(478600001)(86362001)(5660300002)(6916009)(52116002)(8936002)(31696002)(66946007)(66556008)(66476007)(107886003)(4326008)(316002)(2616005)(8676002)(956004)(53546011)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fIJbIt3Mk5ZIIrhSiDEVcCwucrlICqb+ky4pC7hei3jK1ds+495KeBAS0tFlovio2mUFCKebJmAvuWRwG4LNrgXoty7MeK/VSOmFiuOuT7rQhmblw+8ry7fbCKSCcymZAnA0RoV2/bWOUsglfJZXvbMEen9FYq3QNE8v1MSKykuKJ+0a5wsNFezd1DsmFEt/pSVCZ1ix8p8x51yz+zxVf905l40hrvO9zPSxCA2ssVqdyTG0K/IJZbzSGBjiKVrGerH8iIHeKlf+9/Ig4IDWkGI6PST/x7BVbkwEVjynL356fPOt2SPzg/fo4nPgIuhSXNAvTX4XjUX+d/yRGWkwcxhVYLweGV+Yjg8M0KqI5O0oiuAuisQKcU5upMxKKwbxXlAfHkA6NUc3sev15/gPaBKS16QRS5tj3Mg/z3gZfsScMfLJk/QdDpMXeYq01oM6o7qovFLMqTj0B8MARSXXqKM3QSClJApaqDsGZjPrkYyxyCkJW5RubNnLpU4pOfcY
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b02613-9f65-409f-204d-08d7f7e38ef8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 08:48:22.8025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfTxOhO+tIYoQRio+oxC46OZYaGqGbgKOqs1fuHi9bfx80EYmmCGEeuui2TaGPvlWplDjmrRjUcXIAipQyKF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_014825_813993_692945C9 
X-CRM114-Status: GOOD (  12.66  )
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
 vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDUvMTQvMjAyMCA2OjAyIEFNLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6Cj4gTWF4LAo+
Cj4+ICtzdGF0aWMgdm9pZCBudm1lX3JkbWFfc2V0X3NpZ19kb21haW4oc3RydWN0IGJsa19pbnRl
Z3JpdHkgKmJpLAo+PiArCQlzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQsIHN0cnVjdCBpYl9zaWdf
ZG9tYWluICpkb21haW4sCj4+ICsJCXUxNiBjb250cm9sKQo+PiArewo+PiArCWRvbWFpbi0+c2ln
X3R5cGUgPSBJQl9TSUdfVFlQRV9UMTBfRElGOwo+PiArCWRvbWFpbi0+c2lnLmRpZi5iZ190eXBl
ID0gSUJfVDEwRElGX0NSQzsKPj4gKwlkb21haW4tPnNpZy5kaWYucGlfaW50ZXJ2YWwgPSAxIDw8
IGJpLT5pbnRlcnZhbF9leHA7Cj4+ICsJZG9tYWluLT5zaWcuZGlmLnJlZl90YWcgPSBsZTMyX3Rv
X2NwdShjbWQtPnJ3LnJlZnRhZyk7Cj4+ICsJZG9tYWluLT5zaWcuZGlmLmFwcHRhZ19jaGVja19t
YXNrID0gMHhmZmZmOwo+PiArCWRvbWFpbi0+c2lnLmRpZi5hcHBfZXNjYXBlID0gdHJ1ZTsKPj4g
Kwlkb21haW4tPnNpZy5kaWYucmVmX2VzY2FwZSA9IHRydWU7Cj4+ICsJaWYgKGNvbnRyb2wgJiBO
Vk1FX1JXX1BSSU5GT19QUkNIS19SRUYpCj4+ICsJCWRvbWFpbi0+c2lnLmRpZi5yZWZfcmVtYXAg
PSB0cnVlOwo+PiArfQo+IFdoeSBhcmUgeW91IHNldHRpbmcgcmVmX2VzY2FwZT8gSW4gRElYIHRo
YXQgbWVhbnMgdGhhdCBjaGVja2luZyB3aWxsCj4gb25seSBiZSBkaXNhYmxlZCBmb3IgYmxvY2tz
IHRoYXQgaGF2ZSBhIHJlZiB0YWcgdmFsdWUgb2YgMHhmZmZmZmZmZgo+ICphbmQqIGFuIGFwcCB0
YWcgdmFsdWUgb2YgMHhmZmZmLiBUaGF0J3Mgc3BlY2lmaWMgdG8gVHlwZSAzLiBXaGVyZWFzCj4g
Ym90aCBUeXBlIDEgYW5kIFR5cGUgMiByZWx5IG9uIGJlaW5nIGFibGUgdG8gZGlzYWJsZSBjaGVj
a2luZyBmb3IgYmxvY2tzCj4gd2l0aCBhbiBhcHAgdGFnIHZhbHVlIG9mIDB4ZmZmZiByZWdhcmRs
ZXNzIG9mIHRoZSByZWYgdGFnIHZhbHVlLgoKClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyBNYXJ0
aW4uCgp3aWxsIHRoaXMgZml4IGl0IChwcm9iYWJseSBzaG91bGQgYmUgZml4ZWQgaW4gaXNlci9p
c2VydCBhcyB3ZWxsKSA/CgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwppbmRleCAwNWRiZWQzLi45YjlkMTFiIDEwMDY0NAot
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRt
YS5jCkBAIC0xMzM4LDkgKzEzMzgsMTAgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3NldF9zaWdf
ZG9tYWluKHN0cnVjdCAKYmxrX2ludGVncml0eSAqYmksCiDCoMKgwqDCoMKgwqDCoCBkb21haW4t
PnNpZy5kaWYucmVmX3RhZyA9IGxlMzJfdG9fY3B1KGNtZC0+cncucmVmdGFnKTsKIMKgwqDCoMKg
wqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5hcHB0YWdfY2hlY2tfbWFzayA9IDB4ZmZmZjsKIMKgwqDC
oMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5hcHBfZXNjYXBlID0gdHJ1ZTsKLcKgwqDCoMKgwqDC
oCBkb21haW4tPnNpZy5kaWYucmVmX2VzY2FwZSA9IHRydWU7CiDCoMKgwqDCoMKgwqDCoCBpZiAo
Y29udHJvbCAmIE5WTUVfUldfUFJJTkZPX1BSQ0hLX1JFRikKIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkb21haW4tPnNpZy5kaWYucmVmX3JlbWFwID0gdHJ1ZTsKK8KgwqDCoMKgwqDC
oCBlbHNlCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5yZWZf
ZXNjYXBlID0gdHJ1ZTsKIMKgfQoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
