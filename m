Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609E8FA373E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7NGWyS0lraHQTNbs9z6Jm9kLsSiSj9urUneVpLBwhA=; b=R6eJIfnDhMXVFUP0noUySVufPz
	xDsQPHTFd4OxM/jUtFTWqAJihrgZk9jmIvON5zOEbyWXlPpMF4kikRM10d9GRbpJQFyTvuwnw1reh
	9WW6GxcxptxEMcQwHFMgJepg+Nd5jzENoWB1UchWhcZjiZnh4T6PbiXw53HXVAArmlBb6q9lr2FkC
	BKq3EErOeDGawwHe/8dOBmFcN6d7tL1QzCsqcCsG5TxgzmP6h86FB/cAGW7LkqgT+cSATiivQb1i1
	4DzykREuJwNRu6Pic1fi6b5D/xG38As+h1HuKQdgCls2sfZ60EWg0xYGnK+2NMbPkGA7dWJMCsp0T
	UUNCKLjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNrO-006Vn7-3Z; Tue, 25 Oct 2022 17:37:06 +0000
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNrK-006Vj5-NK
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRKEgfme/HUeXKKouSwIYQcDN29RJQ5vT2pfbIQAOy09FAFSIrhsA6kbiXf+ZfZSZKcMQex7txUhvhOsJIzHYYupdi87XwvfJQEBygbH2JTInCT0++1RXL+GFMCU6zYs5tQ1hudgBnGo8E0uncZSh7mWogEDsvc7jXMFPf5RYTCeGo7L5k1zYIMWAvqe05cxVCqYC8oE2dm4zjovJ6NzpcAL03mSIVjQiZoMmb3rKUnAo3x6rSO5EsTv0eyoY3o9CcJW60YOkpx61nRSTqWui/e92E6UXyto9qadgSCDvbN9OotdTiYOPmOzVbyNyHKqHHK1GuP5scNlylnfPZQxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7NGWyS0lraHQTNbs9z6Jm9kLsSiSj9urUneVpLBwhA=;
 b=ClazjJvvnfTCoAIOyZHJSz3rVgvenlMLgKx5TyJDTO+1DhbyqxQpvAlyYXpZOmVCSCrSsLZOWYG+mqkW01GcFXJy2his1h2QgK0sDM53mziD9XjZ7qaCeGkM8FaQ4rhlZlEgH3A75A3lpWtvtndsX10XXB23HgNzrqpw9vEXZNaH05zhvAC3fm5++x3ftClKEeQuENvcAAkfLYXMWqaOLynEpDSX2G7c+/vmqR1tmHZeWN/C7fvv9JwyRDevgMxIj7axQrphPa+KOLi6VNRlCbnlf3j8QDG9ibugUNp7Mq8bjVmwILIbLHprcokdBctNS1n/Lrx20T//ZUPQokOJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7NGWyS0lraHQTNbs9z6Jm9kLsSiSj9urUneVpLBwhA=;
 b=N/El5l7Sp82qB1tn7L8xki9GDnf56IsBBsbGgAoSrJdhcl6uvDCZZ4pnHHwoXCXpjMnizp7e3xNXAQ9duGN1jb5rP9kMV5GY/hu6p5HyiEej+elgBbtfIGRnrZfeIHmQotdUl3rpzyzME4+2A7aIIq9ENTzg0r9BQChDxYjPaUiiL+CVOCCMQWPFDIRfiFzm3h7ScgtIo2Mplq3kugwl9u/5HmT7t4t3BHitkqtUF1rhZ8D+UavRyfQRnGPqHrMOUJ5bN5mELk9tn1nfdfFtKI6gKEEkCDfzzxdxPJ+4BoL6S3nUCB3Y6lxQ6RqDMUJDfJkP+2U7E/ZJJY3VLT3xlQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 17:36:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:36:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/6] nvme-auth: remove redundant buffer deallocations
Thread-Topic: [PATCH 4/6] nvme-auth: remove redundant buffer deallocations
Thread-Index: AQHY6Hf0msGP9gOKKka2bPuGPrJY2a4fX9EA
Date: Tue, 25 Oct 2022 17:36:56 +0000
Message-ID: <70cd108c-c87d-a7c5-3772-681e503f96a9@nvidia.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-5-sagi@grimberg.me>
In-Reply-To: <20221025134330.1028352-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6616:EE_
x-ms-office365-filtering-correlation-id: a90dc406-aa38-4f91-4c14-08dab6af837c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nq/jzD/vbTxlaCMOiJvcf5J+cBDk6ICN52g6qOwTEEH3ZP9MQ/Tct6HzMwjJEADHR4KylpZaBV23Pg3oRRR0loA0jx5/908w7gd06HyaHxmtbJFwuMWJFNAOp/jwR8P0zEVmIGFsgAoixk7z21jxlAjHCm1apYEDWYRjGjU1MSo9wzKGWMm4JjNgukqtpTAiJHDqYOHalBsAt9XwTozhb/meLDJboQ31c3J+RPMoHlszTj1yhL4XfNHrpJKJEpaxZVpbuYLTQ0es6rgeTyqCEhZJHTqGAY5YL3f/lXU3RDnoFpeXSTbsV3oCTEsztzFYulXK3steCD3dFsoWtV//6IDqfY8NIvVzQRZK8SFnicOXg/s/1vXvd9vOqh2DdxWrfA1+K2Rj2FwLBqPsqim5fI3Q1sporsI76Ta+bavT6m3ZUfi7VLD++vIEHicZu5rJACAhkfLuLKV+NW7SqsvGSdnlkVEUeJVnRN8c40hJKGFSsicbqkN/4EpNbJu1/qDPUx4tI0SXoediEVgAd+agbsYQJ7PCgZjV49TohqIaL1+v+cBLBNzTNt1LHC7No+t5u8+Dk/U8s56sENf4xxRmadLCBbWnXU78D+q3/6TaxMcRvh0Ca0QjD3PRVZMloqzzh1aSc5hCvre1htrK15ms9Scpah1mH9G+8Pihkg6BnXRTkfDFLY1fbjIoNVkzz+OdQrVCYARfo39kXwM38CvdyelQzjZkeBxtfZrGKj2259tdp/cAUisqhOINiLJ+MVRgpLPGp8lenUDnUf1mZYPPsdigK66SgR9y+pF9uw7E03qn9+JOn27/CwODrsRchs1R1/foh4F4tCpiwKT1f34+MA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(8676002)(66556008)(36756003)(41300700001)(86362001)(66946007)(8936002)(316002)(5660300002)(76116006)(91956017)(66476007)(31696002)(66446008)(64756008)(38070700005)(122000001)(38100700002)(6916009)(2906002)(31686004)(478600001)(53546011)(6506007)(26005)(6512007)(186003)(6486002)(71200400001)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VDdDTXpBUGU5L25rYWRXUFVTbmZNQ3hnSkdJNDkxRmZwUWNZeldBSm82TkJX?=
 =?utf-8?B?TjVMVlpwVGxrYnRyNDVPUS94YWUwVUxMMHlDRjMySnpldVZOUmhBYlVlRFNl?=
 =?utf-8?B?eXV6RVF4ZDZ3WGpURHMxQW1RV05lUnJvb29mcUxEY2FGREhLcUkyd25zekh1?=
 =?utf-8?B?SUN1MmhNOEszckJDWVNXc2h1YWQ2Nzc0ajZzYkJMVHlkay8xOHhZODYzbmRQ?=
 =?utf-8?B?N1p2cG9zUnRSZHBNaVlEQUpjMWthWldwem9GSjd3bVlEbWtrU1Y4Z0JrQ05V?=
 =?utf-8?B?RDlzaHpvdVh5ZzZxTGMxRVMvdHBuRWRTLzB1NHVsVDJUM3BNRStHMUkxM1Ji?=
 =?utf-8?B?RmdQbUxNNXdjcitvTnRMcEt0ZzZUa0ZaRUJ4UTFMUHQ1Umg0YWtBbXZheWNz?=
 =?utf-8?B?RmJva3EvUDduZFUrL1lzUlFHTUxkaWtyaS8xSWVOYWY3Q212Nktad25tV3Yw?=
 =?utf-8?B?VmhScFZKUDduT2ZnaGQyb0pCY1V0YXZFTmJSRTEvME14MWxNZW1EbzI4SnVL?=
 =?utf-8?B?NWdYRDQzNWdzR1lTRFRMMDZLSm5vT3ZPNVpONVBsckx0bnR3TWZWUjlWUnov?=
 =?utf-8?B?emVxbEd0OHdCdWpmZ1lrUjc0eXJTeUU0QUN5b0kvNDBwdW81N2JEZUNTRWJp?=
 =?utf-8?B?K2NqY0VNb1diVHR5ZC80SWV6U3FrTEdCK1BqWG9wb0RlakRqMGloSFRpc0VG?=
 =?utf-8?B?SW9lb1lBZXU4Y2xCSEhySzRwNkVzTThQZmo4UVRTTkxBK2tjeC91TzJlbDB1?=
 =?utf-8?B?dlJlU0cwT25oR2tFdlpTK2s4U3NveTEzbGx0Z284KzZ1TTdoM2VxYUxzRUVF?=
 =?utf-8?B?Ync2L3FFUk5mQ1dEMmgwVUZFQ2pMemRoVitzUmZvV05yRGkwVjcyQk80b3py?=
 =?utf-8?B?c1FTd09WVjBid0tNZzg3TGU3bmRMKzlxcjV1bUFER2RFd2ZkRmhhdVVSMFRa?=
 =?utf-8?B?RFNsWGJMWGN5bzNIRDhsMzFZNzNuM3lYMkVkUWFDU2RKbUhIc3R1TEJwb3F6?=
 =?utf-8?B?ck1xVW5XZVVWWUpoR1JuY09EbFhoQXE1T1RTT3JrVFo2NGc5THh5R1hvZGRk?=
 =?utf-8?B?UXpJc1QyMkx2RERpSnlrZ3VHWTExN29OT0VSUk1Vb0l6Sy81bjVERWtmUE5O?=
 =?utf-8?B?RHZta1RpTkkrNjNoTDRjcUEvQ0NJNmFCYkFFRDJiN2Q2aHppK0pmZHdpV2M2?=
 =?utf-8?B?QTR0dkc0M3dBbnRxdHoyY2NLTDF0ZDczU1pwMlFHbjNiT0o2QVM5eHBwS0JU?=
 =?utf-8?B?YzU1Z2o3VmFGWFJsbjNwRUZRT2lMeWp1ZndjcFBVZ0d2eHBqeHZxWEEraWdM?=
 =?utf-8?B?K053Y2NnZ3NsdzkwMkRTL0FzTXVFVHI0R2xEYWVLSUVrQXYwNU5CeDIweXhH?=
 =?utf-8?B?dmY1VnFQbFl5U2ZYM0dHSkdYTEIvcmZTcmRUMVkrekEvVFVTU0RsRHdkbFdv?=
 =?utf-8?B?bkthdjBiTllQLzRvNHhETXVobTFCeHBoWGhESUsvRXNYVUllSTByQXV2YUFQ?=
 =?utf-8?B?cGV1YTk4KzBTalRnbjROM3V6RGVWTXdYVnVKUC8yLzF0YmdBeTZIUWNxT0p2?=
 =?utf-8?B?Q3ExQUVLMzJpMU5GMStwdnB4c0JTZHJRNWhQVzNPcFEzVkI4SmtUSDNFL3ZO?=
 =?utf-8?B?WlFyNnJBcXpwTUY3R3RmTlpGR0E4WVl1UmRTcEhQdU9uSnVaRm82YWdJV0R3?=
 =?utf-8?B?ZFVxNm5wWVdEQzBzQ0JkYld5dzh2S2VZTEhxQ1JyeWVwQWh2RzQ0MnNwYlps?=
 =?utf-8?B?VnBkc1Z0UFpjQVZHNEJsY1RrSDdock12MDBkYXppY3U5djdhY1V1Nlcvekp1?=
 =?utf-8?B?eGR0eGRIamFtTWRQZk00ei9HTXVaVXB1amo5V0U0QnFxa3R3WEh6akRlTEtJ?=
 =?utf-8?B?ZWFOQW45ZHR2eWNBSi9aa3FLbERJWktMZjNOZTJrQ1pOOE1ZNG5NM3h1OURT?=
 =?utf-8?B?TGRZcHAwc2d2ZEsyTUh0c001T1RzWDJha3A4YjVKWVdWSmROUnhwb2tiL3N5?=
 =?utf-8?B?YW1id0t4eEJqS0NhRW9PM2tNd3k4QVRMNzZJKzdHMUZRZE9BdDFoL0NBKytv?=
 =?utf-8?B?RUR1Z0tWNjg1TXFtNTBSOHR3ZmwrbVhZamRWKy9iVnc2YU9EN1hnaS9tY2ts?=
 =?utf-8?Q?QJwm7Yyf/NfO1btjUEpyev5nd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5BB84B193E97540A030637B7EFDA5C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90dc406-aa38-4f91-4c14-08dab6af837c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:36:56.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyDbQIOtT8ucX+A80e4QaUIUnV1br0bBiuHUrOmy5lqabIH7Q5IqotrnquAgfEw/9SlEofmM2FvFPy04P218fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_103702_791224_324BAC64 
X-CRM114-Status: GOOD (  13.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMjUvMjAyMiA2OjQzIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBob3N0X3Jlc3Bv
bnNlLCBob3N0X2tleSwgY3RybF9rZXkgYW5kIHNlc3Nfa2V5IGFyZQ0KPiBmcmVlZCBpbiBudm1l
X2F1dGhfcmVzZXRfZGhjaGFwIHdoaWNoIGlzIGNhbGxlZCBmcm9tDQo+IG52bWVfYXV0aF9mcmVl
X2RoY2hhcC4NCj4gDQoNClBlcmhhcHMgOi0NCg0KaG9zdF9yZXNwb25zZSwgaG9zdF9rZXksIGN0
cmxfa2V5IGFuZCBzZXNzX2tleSBhcmUgZnJlZWQgaW4NCm52bWVfYXV0aF9yZXNldF9kaGNoYXAg
d2hpY2ggaXMgY2FsbGVkIGZyb20gbnZtZV9hdXRoX2ZyZWVfZGhjaGFwLg0KDQo+IFNpZ25lZC1v
ZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvbnZtZS9ob3N0L2F1dGguYyB8IDQgLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2F1dGguYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2F1dGguYw0KPiBpbmRleCA5M2MwZmM3MWJjN2MuLjE1Y2RkYzJiYjE0
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jDQo+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2F1dGguYw0KPiBAQCAtNjgzLDEwICs2ODMsNiBAQCBzdGF0aWMgdm9pZCBu
dm1lX2F1dGhfZnJlZV9kaGNoYXAoc3RydWN0IG52bWVfZGhjaGFwX3F1ZXVlX2NvbnRleHQgKmNo
YXApDQo+ICAgCQljcnlwdG9fZnJlZV9zaGFzaChjaGFwLT5zaGFzaF90Zm0pOw0KPiAgIAlpZiAo
Y2hhcC0+ZGhfdGZtKQ0KPiAgIAkJY3J5cHRvX2ZyZWVfa3BwKGNoYXAtPmRoX3RmbSk7DQo+IC0J
a2ZyZWVfc2Vuc2l0aXZlKGNoYXAtPmN0cmxfa2V5KTsNCj4gLQlrZnJlZV9zZW5zaXRpdmUoY2hh
cC0+aG9zdF9rZXkpOw0KPiAtCWtmcmVlX3NlbnNpdGl2ZShjaGFwLT5zZXNzX2tleSk7DQo+IC0J
a2ZyZWVfc2Vuc2l0aXZlKGNoYXAtPmhvc3RfcmVzcG9uc2UpOw0KPiAgIAlrZnJlZShjaGFwLT5i
dWYpOw0KPiAgIAlrZnJlZShjaGFwKTsNCj4gICB9DQoNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

