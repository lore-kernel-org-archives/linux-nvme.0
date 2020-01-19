Return-Path: <SRS0=Eo3O=3I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E3C33CB1
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 11:21:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A268205F4
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+9P51I/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jzXP4VAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A268205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zDUcrvSyaVBWTgAJIWpbAFHBI3efolyoi03PWVQs9WQ=; b=W+9P51I/r3quBBql2YkfxWGlQ
	DlP3Qz+J5DeXoy1dZPE29uP9bh7TJ9Xa3rawmjHbz4gxd/zwwvCFJPwDOkSu9NkhUDDz2bNrpuorA
	DEn8l0m7nwp8KDfXEFGoYyGtDFqgGmFTVihpDl9MjreuUf5BkkcWU6jSpLqVl27AA5TjfelQFwqlb
	4CdAFEqeNCNPmcb0gkflzq6bhsgflb2sQH1YTldg49UeANKUb99ZdvZj0zmgumVroNzZCQr66cD35
	iyqBvlw+HFObJPyQWvcO1pI1jrg5OojNCKJ+ymDSzkXuD1kWNMuH2k2p/UB4Nm5qQyt7fxdh7Ch5k
	JLV+Kdkog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1it8eE-0000ax-9o; Sun, 19 Jan 2020 11:21:42 +0000
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com
 ([40.107.21.63] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1it8df-0000ZC-Hg
 for linux-nvme@lists.infradead.org; Sun, 19 Jan 2020 11:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClOSn1P27/xM40SO34S2VCNGJBImF+vb7ZHjG2MhG2ZimEkxhBQo39+tHdgB1/TuHuFFU9QWRkN1Qc/2aMH8pv4+rwSgJhmpxKaeIptFkbixglaGaPG3WLv3d5UrMoo3Z5zG46mA7Assv28yZIdBj/V3uNY0ito/GjvQ9VjdF6sJ6TreGUHQTRmTZPHb7KrngH/eLbdjk3jMORC5R45629XWcjxBXI2Qc2p+YL84wAYlrUONsLjeXjTaCZC7Jtx3Q5je9EBakwhLpd08sMhv9CscMo/JI1db5bWbn1opUxygZJ1pf0YpnGb2z/lPuv8G/1XMCJVOO8DMHaKYlD9hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk6NlHeCwbI29BOxUcTQjp61bdYIX9RE3YyhrH3bWgs=;
 b=WTFecQb4gTxbSOb7+YWTCCqM70EK3tUqGG6mZWCNdZN5HXVt3f3olliD3MIjlRGY5piYsa6u6uWJhU0fBY6zre9YjpbvuXAoRbIRCSprb+Wlf1vw/UrgdKq90GlhF6n4m658b1LbeI2FWEoAs3JDGbve5KmFlqvYLSGVunpb4EPU9/cuvKK1gz5RqKTXo46HMu0RTBt+DFOeczFU1VfBypgsTs6d9ODvMe6GVClrvr+1hJ2UNz2gKLW3pvnT2HI3duc5XRPW5Ssl3bmipKKe5scN1MpaoQE1b2c2XZFolqOge/48nEt61zrBh17aMedP8HzmY3q5d4pIz1VTQBfpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk6NlHeCwbI29BOxUcTQjp61bdYIX9RE3YyhrH3bWgs=;
 b=jzXP4VAZY3+nxxmIi/aOpQ53ro+nAWYx1+vwqrco/XOtSFi2AYAZR5qJHUGuDIxC6HnjgYwhMfytJ46D+cKOJROKPHlwa2chU/kEsJlZxKKDwomZImUrsS+21jke+POvrbMr8b8iSmAiC+Mt9gw0FsKDTEa0BuBJnRFnMOoHolM=
Received: from DB6PR0501CA0047.eurprd05.prod.outlook.com (2603:10a6:4:67::33)
 by DB6PR0501MB2792.eurprd05.prod.outlook.com (2603:10a6:4:81::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.25; Sun, 19 Jan
 2020 11:21:00 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by DB6PR0501CA0047.outlook.office365.com
 (2603:10a6:4:67::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Sun, 19 Jan 2020 11:21:00 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2644.23 via Frontend Transport; Sun, 19 Jan 2020 11:21:00 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 19 Jan 2020 13:20:59
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 19 Jan 2020 13:20:59 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 19 Jan 2020 13:20:56
 +0200
Subject: Re: [PATCH 02/15] nvme: Enforce extended LBA format for fabrics
 metadata
To: James Smart <james.smart@broadcom.com>, <linux-nvme@lists.infradead.org>, 
 <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <martin.petersen@oracle.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-4-maxg@mellanox.com>
 <57aa8b5c-b8c9-7617-bc11-b6797587fdc8@broadcom.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d7b94f4e-4a75-941f-3cf6-22001c1850a3@mellanox.com>
Date: Sun, 19 Jan 2020 13:20:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <57aa8b5c-b8c9-7617-bc11-b6797587fdc8@broadcom.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(336012)(31686004)(478600001)(2906002)(36756003)(70586007)(2616005)(8676002)(54906003)(70206006)(110136005)(107886003)(4326008)(53546011)(5660300002)(86362001)(26005)(31696002)(36906005)(316002)(81166006)(16526019)(16576012)(356004)(8936002)(186003)(81156014)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0501MB2792; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 855bae2a-597d-484c-604e-08d79cd1a9bc
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2792:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB27928FFC13F32CA2F04E0A65B6330@DB6PR0501MB2792.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msUxlTR/ksnihYTLqrL+HWk7/YSLN79qdl2Fo4FR9qHV4gPfp2W92vOZEOL+gI57+6gWqEATVNAUVxA8lo18xiOtd3VrNaO3r8WOvppGSRdv8HBws3b2ZWpfjrTHsBpbCriEpu+58fYaGfImodDhkIJH8aQJmfIWkV9WWegpcuxt98TbvN+imEIKQwFpRCjnmH9d2gADEGh4sG8FOcmL/0+wHGgKAThF0js64oV8+uzDM6hj4caBhSoSNbxKkI0xcGp3bXChw9I4/V61Kd5AnPiEB9iQYPTIORIfMNygi+86nJ436CFAsZ0azB4b4CYgMCJJztXQRDG2wFm7uzxYcBk81XBUfafMa/A7YCzzeEIvGZUJ3qppI519kIrcdy6ICGH+lThE8SnVBLFmzNDTx3q8eqT8EEIjREqGN/OO7tCF097MGZMtg3Ne3+KmLMZdWk2ONKBjAZLY33mzHQaphExaOvZkP899sjarQ17RuyRP8XQun45hv/6JnTbqwLUO
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 11:21:00.2794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855bae2a-597d-484c-604e-08d79cd1a9bc
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_032107_617099_841F9DAC 
X-CRM114-Status: GOOD (  20.88  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDEvMTcvMjAyMCAxOjUzIEFNLCBKYW1lcyBTbWFydCB3cm90ZToKPgo+Cj4gT24gMS82LzIw
MjAgNTozNyBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBBbiBleHRlbmRlZCBMQkEgaXMgYSBs
YXJnZXIgTEJBIHRoYXQgaXMgY3JlYXRlZCB3aGVuIG1ldGFkYXRhIGFzc29jaWF0ZWQKPj4gd2l0
aCB0aGUgTEJBIGlzIHRyYW5zZmVycmVkIGNvbnRpZ3VvdXNseSB3aXRoIHRoZSBMQkEgZGF0YSAo
QUtBCj4+IGludGVybGVhdmVkKS4gVGhlIG1ldGFkYXRhIG1heSBiZSBlaXRoZXIgdHJhbnNmZXJy
ZWQgYXMgcGFydCBvZiB0aGUgTEJBCj4+IChjcmVhdGluZyBhbiBleHRlbmRlZCBMQkEpIG9yIGl0
IG1heSBiZSB0cmFuc2ZlcnJlZCBhcyBhIHNlcGFyYXRlCj4+IGNvbnRpZ3VvdXMgYnVmZmVyIG9m
IGRhdGEuIEFjY29yZGluZyB0byB0aGUgTlZNZW9GIHNwZWMsIGEgZmFicmljcyBjdHJsCj4+IHN1
cHBvcnRzIG9ubHkgYW4gRXh0ZW5kZWQgTEJBIGZvcm1hdC4gRmFpbCByZXZhbGlkYXRpb24gaW4g
Y2FzZSB3ZSAKPj4gaGF2ZSBhCj4+IHNwZWMgdmlvbGF0aW9uLiBBbHNvIGluaXRpYWxpemUgdGhl
IGludGVncml0eSBwcm9maWxlIGZvciB0aGUgYmxvY2sgCj4+IGRldmljZQo+PiBmb3IgZmFicmlj
cyBjdHJsLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3gu
Y29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBJc3JhZWwgUnVrc2hpbiA8aXNyYWVsckBtZWxsYW5veC5j
b20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAyNSArKysrKysrKysr
KysrKysrKysrKystLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IGluZGV4IGQ5OGViNDguLjA4OWNkYzNjIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCj4+IEBAIC0xODE4LDcgKzE4MTgsNyBAQCBzdGF0aWMgdm9pZCBudm1l
X3VwZGF0ZV9kaXNrX2luZm8oc3RydWN0IAo+PiBnZW5kaXNrICpkaXNrLAo+PiDCoMKgwqDCoMKg
IGJsa19tcV91bmZyZWV6ZV9xdWV1ZShkaXNrLT5xdWV1ZSk7Cj4+IMKgIH0KPj4gwqAgLXN0YXRp
YyB2b2lkIF9fbnZtZV9yZXZhbGlkYXRlX2Rpc2soc3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVj
dCAKPj4gbnZtZV9pZF9ucyAqaWQpCj4+ICtzdGF0aWMgaW50IF9fbnZtZV9yZXZhbGlkYXRlX2Rp
c2soc3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCAKPj4gbnZtZV9pZF9ucyAqaWQpCj4+IMKg
IHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9ucyAqbnMgPSBkaXNrLT5wcml2YXRlX2RhdGE7
Cj4+IMKgIEBAIC0xODQ2LDExICsxODQ2LDIxIEBAIHN0YXRpYyB2b2lkIF9fbnZtZV9yZXZhbGlk
YXRlX2Rpc2soc3RydWN0IAo+PiBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgbnZtZV9pZF9ucyAqaWQp
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5zLT5mZWF0dXJlcyB8PSBOVk1FX05TX0VY
VF9MQkFTOwo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBGb3IgRmFicmljcywgb25seSBtZXRhZGF0YSBhcyBwYXJ0IG9mIGV4dGVuZGVkIGRhdGEgTEJB
IGlzCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogc3VwcG9ydGVkLiBGYWlsIGluIGNhc2Ugb2YgYSBz
cGVjIHZpb2xhdGlvbi4KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChucy0+Y3RybC0+b3BzLT5mbGFncyAmIE5WTUVfRl9GQUJSSUNTKSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChXQVJOX09OX09OQ0UoIShucy0+ZmVhdHVyZXMgJiBOVk1FX05T
X0VYVF9MQkFTKSkpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
SU5WQUw7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRm9yIFBDSSwgRXh0ZW5kZWQgbG9naWNhbCBibG9jayB3
aWxsIGJlIGdlbmVyYXRlZCBieSB0aGUKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjb250cm9s
bGVyLgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KG5zLT5jdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9GX01FVEFEQVRBX1NVUFBPUlRFRCkgewo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIShucy0+ZmVhdHVyZXMgJiBOVk1FX05TX0VYVF9M
QkFTKSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5jdHJsLT5vcHMtPmZsYWdz
ICYgTlZNRV9GX0ZBQlJJQ1MgfHwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAh
KG5zLT5mZWF0dXJlcyAmIE5WTUVfTlNfRVhUX0xCQVMpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG5zLT5mZWF0dXJlcyB8PSBOVk1FX05TX0RJWF9TVVBQT1JURUQ7Cj4K
PiBUaGlzIGxhc3QgY2hhbmdlIHNlZW1zIG9kZCAtIHdoeSBpcyBESVggc2V0IGlmIE5WTUVfRl9G
QUJSSUNTID8KPgo+IFBlciBwYXRjaCBkZXNjcmlwdGlvbiBhYm92ZSwgRmFicmljcyBzcGVjIHJl
cXVpcmVzIG1ldGFkYXRhIGFzIGFuIAo+IGV4dGVuZGVkIExCQSwgdGh1cyBpdCBkb2Vzbid0IHN1
cHBvcnQgRElYLgoKd2UgcmVmZXIgRElYIGFzIG1lbW9yeSBkb21haW4gbWV0YWRhdGEuCgo+Cj4g
V2hpY2ggaXMgdG91Y2hlcyBvbiBhIGxvdCBvZiBvZGQgdGhpbmdzIHdpdGggdGhlIG52bWUgc3Bl
YyBhcyBpdCdzIAo+IGNlcnRhaW5seSBwb3NzaWJsZSBmb3IsIHdpdGhpbiB0aGUgb3MgaG9zdCBp
bXBsZW1lbnRhdGlvbiwgdG8gaGF2ZSB0aGUgCj4gaG9zdCB0cmFuc21pdHRpbmcgZW5naW5lIHRv
IGNvbnZlcnQgYW4gT1Mgc2VwYXJhdGUgRElGIGJ1ZiB0byBhbiAKPiBleHRlbmRlZCBsYmEgdHJh
bnNtaXNzaW9uIG9uIHRoZSB3aXJlIGFuZCBhcyBwcmVzZW50ZWQgdG8gdGhlIAo+IGNvbnRyb2xs
ZXIuwqAgVHJhbnNwb3J0cyBjYW4gY2VydGFpbmx5IGhlbHAgbWFrZSB0aGlzIGhhcHBlbiAtIGFu
ZCBhZGQgCj4gZWdyZXNzIGNoZWNraW5nIGFzIHRoZSBkYXRhIGxlYXZlcyB0aGUgaG9zdC7CoMKg
wqAgV2hpY2ggbWVhbnMgLSBJJ20gbm90IAo+IHN1cmUgdGhpcyBoYXJkIERJWCBkZWZpbml0aW9u
IGJlaW5nIGltcGxlbWVudGVkIHRoaXMgd2F5IGlzIHRoZSB3YXkgdG8gCj4gZ28uCgpSRE1BIHRy
YW5zcG9ydCBpcyBjb252ZXJ0aW5nIHNlcGFyYXRlZCBTR0xzIChub24tZXh0ZW5kZWQgbW9kZSkg
dGhhdCAKc2VudCBieSB0aGUgYmxvY2sgbGF5ZXIgdG8gZXh0ZW5kZWQgbW9kZS4KClRoZSBpZGVh
IGhlcmUgaXMgdG8gZGVmaW5lIG9uIHdoaWNoIGNvbmRpdGlvbnMgd2UnbGwgYXNrIHRoZSBibG9j
ayBsYXllciAKdG8gc2V0IGl0J3MgbWV0YWRhdGEgaW5mcmFzdHJ1Y3R1cmUuCgpmb3IgUENJIC0g
b25seSBpbiBjYXNlIG9mIG5vbi1leHRlbmRlZCBtb2RlIChpbiBleHRlbmRlZCBtb2RlIHRoZSBi
bG9jayAKbGF5ZXIgd2lsbCBub3Qgc2V0IGludGVncml0eSwgYW5kIHRoZSBudm1lIGRyaXZlciB3
aWxsIHNldCB0aGUgClBSQUNUL1BSQ0hLIGlmIG5lZWRlZCkgc2luY2UgdGhlcmUgaXMgbm8gY29u
dmVyc2lvbiB0byBleHRlbmRlZCBtb2RlIGluIAp0aGUgbnZtZSBkcml2ZXIuCgpmb3IgZmFicmlj
cyAtIGFsd2F5cyBhc2sgZm9yIGJsayBpbnRlZ3JpdHkgc2V0dGluZyBzaW5jZSB0aGUgdHJhbnNw
b3J0IAooUkRNQSBvbmx5IGZvciBub3cpIGlzIHJlc3BvbnNpYmxlIGZvciB0cmFuc2ZlcnJpbmcg
aXQgdG8gZXh0ZW5kZWQgbW9kZSAKb24gdGhlIHdpcmUuCgotTWF4LgoKCj4KPiAtLSBqYW1lcwo+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
