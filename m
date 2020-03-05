Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B109DC3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 23:01:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E9120717
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 23:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvM5i9Go";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="F6756uaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mo0wZ8grXigHTKJq+lTjddSHH/uGKrGhBMEPPH7y7sY=; b=LvM5i9GoUUbJKNx1gdhWX9WKr
	kKsf0XHyD1qEr8vwzg+niMjHbdQiX6V8ETmIn57s/d7rZjqOB2ZtjvGZf147nUyliAHmSkVm/B9P9
	XtDTRVCUyqsbEBm1aj3LtPdLhsTDehpUsPG2l5d51SzYHUe7oN4mqXDI/7x8iPRtEb7ySc69J9eW6
	yngQwzetp/9/qAFORHVpcKUNHyZHs9/MRoPxponLdoEZTMU3IeExhdFY0kY0VqbUVOf0VFALYzYXa
	9JDFPaC1Zv4vO3gza6Rc5SKfKtqf6rBSA+1NUItyE+PGcGOzH+K5G20aeaYnebgQ09j1D7rJb6vhe
	yJpDIPFTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9zUl-0006Fl-Jg; Thu, 05 Mar 2020 23:01:35 +0000
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9zUi-0006Ey-UC
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 23:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LakJ8dxIIuVJ76JRHtUdTO+P/z1dScNscN/H7q8ie//p3tJQWGg1xW9IfnWed5BGZGdmNiItMhosECcWDij2qjpwKMWD16ix0dTuvIi2Z7t5TvQcvW/HEx/Gm64ow1fSM8ayNejchB6EPjbbJgE6VyQA1sCLpzQYwj5vlTVLKSL8l1v01/ilOWIpnCks3AWqIEp0Bq5yKxbI0Pg7kpWOww3Q/d9alRKqcEa5w4VC/qRQel/fwxQrlUc08lcWu3B5JZwRGiTe8QGndtFkpyXqSvNlKYsVtRoFMqdP+l7qhXpgfDjib6D8ggyM1aPlwSnqMLvdDlQUglZ3Wt9Ey88Uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFux7Uw/y1hPEH5i2/kRWLrD03Qh21AQW8+U+C5qv8=;
 b=mh/Wo7zXlj9WkhpyTO3Cfr+/hamJ+uSfSDsCwlN0u9ArLjomf3Mpa5mYG7jEhw4MiEXqHr5nBeZUGS89O9kqLxwPu12QHA6QFi6alZ3hGVoSvP3aOBaw5rkorU6H3xl3FVQwGZPpPoKK4Zbs+iJXPNu0GrM1MsiqgIVwbDry7azGqm2zzFfEW9vWG4Nkc53AbcQ7ZPTeiVgI8Hk4NvbM5ScgWYIA0bzpd3xDVKbj1N1UAqm/xfEyorX+rKMJZk2n1nkjExb9bpsWuF7th2HcGDZPTulQla50lae8qzl9o2tcpZ8ig5n1MGIlh+cOIrRrOx00dEK6ew2K8lDJP1UeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFux7Uw/y1hPEH5i2/kRWLrD03Qh21AQW8+U+C5qv8=;
 b=F6756uaT9/Vs/ozDAtMXnMBgkNuK2RPbQDdv46fAAQt7X+w+BG4IAh7fri1jhSXBl+dy4UOV3CpBV25JgP3f5CuluOKfVrEYbMGGEgHGQzmU6uoR+vD7UPInhwR7IVdcYexzvWvvRvUeOCAuj7CWqmKkE4vQuI6yr4SjVnSxD78=
Received: from AM5PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::34) by VI1PR05MB6895.eurprd05.prod.outlook.com
 (2603:10a6:800:180::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Thu, 5 Mar
 2020 23:01:28 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::b6) by AM5PR0102CA0021.outlook.office365.com
 (2603:10a6:206::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 23:01:28 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 23:01:27 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 6 Mar 2020 01:01:26
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 6 Mar 2020 01:01:26 +0200
Received: from [172.27.0.3] (172.27.0.3) by MTLCAS01.mtl.com (10.0.8.71) with
 Microsoft SMTP Server (TLS) id 14.3.468.0;
 Fri, 6 Mar 2020 01:01:25 +0200
Subject: Re: [PATCH V2 2/3] nvmet-rdma: Implement get_mdts controller op
To: Sagi Grimberg <sagi@grimberg.me>, <jgg@mellanox.com>,
 <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <Chaitanya.Kulkarni@wdc.com>
References: <20200305095530.132858-1-maxg@mellanox.com>
 <20200305095530.132858-2-maxg@mellanox.com>
 <468c65e9-a74a-ba83-9b2b-e372b5bb61ab@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3ca54089-fffb-bfd8-efcb-b68847b6d5f7@mellanox.com>
Date: Fri, 6 Mar 2020 01:01:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <468c65e9-a74a-ba83-9b2b-e372b5bb61ab@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(4326008)(110136005)(16526019)(186003)(54906003)(36756003)(2616005)(81156014)(26005)(81166006)(31696002)(8676002)(86362001)(2906002)(336012)(8936002)(36906005)(5660300002)(16576012)(316002)(478600001)(70586007)(70206006)(356004)(53546011)(31686004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6895; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c7d331-8beb-447a-dc2a-08d7c159230c
X-MS-TrafficTypeDiagnostic: VI1PR05MB6895:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6895B2BA1597B4C6610484AEB6E20@VI1PR05MB6895.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLsP768xSL4TKKy8G1eZmYqej5y8kkMOF3vJr/s65JZzPbo8waFrTjiPz0R7jrAtea924Idlzd0g9/BbrTldHktxBNRQFa5ytmJXsup2wI8P69j1VNCYNXgWHQYRgGhkZ48r1FvHhiMm6g2PQBLMR/NcdE/5vL37X76Fl2R4vkM5CZGyYLGWYo5vT0LcjV36kEHvQl2xvme9V2HBs5dzi1c/14DBiNvGQ+3SWMzT7aUyFZTYtZxseQz9xR3HO+qpdo19gn0lgPsCWthi4L1bf9MKVe4UDCTpXev0R/i64lTLUKL5ccGyX2F0TTfJfVl9rErIjGXs6b4CtOGb9Zi/2qiDKFBd8fK2m+q1+cyrEyQ90IAni2bGj+zDdqMAGKgh1AWkRcA8yqICqgUEOo2fzfG/B3uIeUJdewgc67hHUkuV36CiS1CalXKzYK7mhyT0AkZc9zH5hkwmyXoiQvAS2B+Kqcvf8dPfF4yZz6JJkzRV/NKaDqBT9gcdKoSDqERw
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 23:01:27.8713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c7d331-8beb-447a-dc2a-08d7c159230c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_150132_979355_2690EAEF 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: krishna2@chelsio.com, bharat@chelsio.com, nirranjan@chelsio.com,
 bvanassche@acm.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvNS8yMDIwIDEwOjQ0IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4KPiBPbiAzLzUv
MjAgMTo1NSBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBTZXQgdGhlIG1heGltYWwgZGF0YSB0
cmFuc2ZlciBzaXplIHRvIGJlIDFNQiAoY3VycmVudGx5IG1kdHMgaXMKPj4gdW5saW1pdGVkKS4g
VGhpcyB3aWxsIGFsbG93IGNhbGN1bGF0aW5nIHRoZSBhbW91bnQgb2YgTVIncyB0aGF0Cj4+IG9u
ZSBjdHJsIHNob3VsZCBhbGxvY2F0ZSB0byBmdWxmaWxsIGl0J3MgY2FwYWJpbGl0aWVzLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29tPgo+PiAtLS0K
Pj4KPj4gY2hhbmdlcyBmcm9tIFYxOgo+PiDCoCAtIHJlbmFtZWQgbnZtZXRfcmRtYV9zZXRfbWR0
cyB0byBudm1ldF9yZG1hX2dldF9tZHRzCj4+IMKgIC0gYWxpZ24gdG8gZ2V0X21kdHMgY2FsbGJh
Y2sgY2hhbmdlcwo+Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMgfCA4
ICsrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9yZG1hLmMKPj4gaW5kZXggMzdkMjYyYS4uZDEyZWYwZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9yZG1hLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMK
Pj4gQEAgLTMwLDYgKzMwLDcgQEAKPj4gwqAgI2RlZmluZSBOVk1FVF9SRE1BX0RFRkFVTFRfSU5M
SU5FX0RBVEFfU0laRcKgwqDCoCBQQUdFX1NJWkUKPj4gwqAgI2RlZmluZSBOVk1FVF9SRE1BX01B
WF9JTkxJTkVfU0dFwqDCoMKgwqDCoMKgwqAgNAo+PiDCoCAjZGVmaW5lIE5WTUVUX1JETUFfTUFY
X0lOTElORV9EQVRBX1NJWkXCoMKgwqDCoMKgwqDCoCBtYXhfdChpbnQsIFNaXzE2SywgCj4+IFBB
R0VfU0laRSkKPj4gKyNkZWZpbmUgTlZNRVRfUkRNQV9NQVhfTURUU8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgOAo+PiDCoCDCoCBzdHJ1Y3QgbnZtZXRfcmRtYV9jbWQgewo+PiDCoMKgwqDCoMKgIHN0
cnVjdCBpYl9zZ2XCoMKgwqDCoMKgwqDCoCBzZ2VbTlZNRVRfUkRNQV9NQVhfSU5MSU5FX1NHRSAr
IDFdOwo+PiBAQCAtMTYwMiw2ICsxNjAzLDEyIEBAIHN0YXRpYyB2b2lkIG52bWV0X3JkbWFfZGlz
Y19wb3J0X2FkZHIoc3RydWN0IAo+PiBudm1ldF9yZXEgKnJlcSwKPj4gwqDCoMKgwqDCoCB9Cj4+
IMKgIH0KPj4gwqAgK3N0YXRpYyB1OCBudm1ldF9yZG1hX2dldF9tZHRzKGNvbnN0IHN0cnVjdCBu
dm1ldF9jdHJsICpjdHJsKQo+PiArewo+PiArwqDCoMKgIC8qIEFzc3VtZSBtcHNtaW4gPT0gZGV2
aWNlX3BhZ2Vfc2l6ZSA9PSA0S0IgKi8KPgo+IFRoaXMgY29tbWVudCBzaG91bGQgY29tZSBhdCB0
aGUgZGVmaW5lIGVudHJ5LgoKClN1cmUsIG5vIHByb2JsZW0uCgoKPgo+PiArwqDCoMKgIHJldHVy
biBOVk1FVF9SRE1BX01BWF9NRFRTOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbnZtZXRfZmFicmljc19vcHMgbnZtZXRfcmRtYV9vcHMgPSB7Cj4+IMKgwqDCoMKgwqAgLm93
bmVywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFRISVNfTU9EVUxFLAo+PiDCoMKgwqDCoMKgIC50
eXBlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IE5WTUZfVFJUWVBFX1JETUEsCj4+IEBAIC0xNjEy
LDYgKzE2MTksNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9yZG1hX2Rpc2NfcG9ydF9hZGRyKHN0cnVj
dCAKPj4gbnZtZXRfcmVxICpyZXEsCj4+IMKgwqDCoMKgwqAgLnF1ZXVlX3Jlc3BvbnNlwqDCoMKg
wqDCoMKgwqAgPSBudm1ldF9yZG1hX3F1ZXVlX3Jlc3BvbnNlLAo+PiDCoMKgwqDCoMKgIC5kZWxl
dGVfY3RybMKgwqDCoMKgwqDCoMKgID0gbnZtZXRfcmRtYV9kZWxldGVfY3RybCwKPj4gwqDCoMKg
wqDCoCAuZGlzY190cmFkZHLCoMKgwqDCoMKgwqDCoCA9IG52bWV0X3JkbWFfZGlzY19wb3J0X2Fk
ZHIsCj4+ICvCoMKgwqAgLmdldF9tZHRzwqDCoMKgwqDCoMKgwqAgPSBudm1ldF9yZG1hX2dldF9t
ZHRzLAo+PiDCoCB9Owo+PiDCoCDCoCBzdGF0aWMgdm9pZCBudm1ldF9yZG1hX3JlbW92ZV9vbmUo
c3RydWN0IGliX2RldmljZSAqaWJfZGV2aWNlLCAKPj4gdm9pZCAqY2xpZW50X2RhdGEpCj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
