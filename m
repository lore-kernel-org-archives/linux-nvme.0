Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907E2C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UrK6jkNTg+J6jKtxLiO6/b1+6D6N29foVuziKjl7KaA=; b=4lqTVhC+N6M2YyisVJ9nygSlrN
	adAwoN+/Z1KSe+bcPXpn+pY0ueeRdGAlsv7JiewZF2jv+lrg2JQp6uiwLeSZicDsAGDEOFpymavoI
	7Z+3HRuTrmY81cipU3zFLiFzwxD/uaIMvIqWHGt+DNlK47U6ojCVrKEsUKU4I/iGAujmER7vL8TFX
	h8yFgzMFofc/ZxCkWJZKZcoj1JS+bwBZlhLoEDgtdCO78P0ESOvpPyK84nrlYvuXMisOI7fG7ZGnu
	F0T+IqOR4etyH6VT0xykB14wP0A5xYr5ZCgA4frueoU6tLrRqkf2XYmS6QTRqSCKC++t2S3YSthZm
	ko4hOIig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCip-00Fh5O-BW; Thu, 28 Jul 2022 23:15:15 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCin-00Fh4X-A7
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 23:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6sW+SBLuCCvlasUKT+wy9MR0SZ5O0P3HDcwMuMcsodv5cvvEoOJiAz5CUNPy0XBp2iHUPZ1Fic9gIpn5bgTarLIkRuDKtvJYSs/GYwwo/9igtvz+gT1Oszs5BA5PuSfWYYg+6Ipw3lgEF+EZkctXM36GL9OzHsJTfg6P/4AU+WdIYWFoBeECtK6YvL6+04QE9VjFIAbb672rgq222kCeftXc+CerINgesTVdIAuC0H2WGL8aiYLki7hMD4nn6upV38teFiwBjmJPE71MzoWNb7L8TjOtOZX0JyIVVcEiDo1w5Sui3K5GFgv1hs69lABGgY/TdjcAHLpkpfTcG+Bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrK6jkNTg+J6jKtxLiO6/b1+6D6N29foVuziKjl7KaA=;
 b=m4Q1jOcSDe8UP2hPEJ6Cw78b7h2NEnz6bKN1xCNMETLWpb7guxVydwg4YR6Ds7c2eg0gN0UMTBixXWPMpUaKH9h3+XnkUP/DT2zFgj3cGVz3XDNb+FbGRQclXi9tn2neAvFl8ibKMZR0AfPbjWaa7bGhnOHHaPY0lVgmUGJrv5cIJwkI3QfA9OdP1Og++bagU4TSBnmKraXSXw9LK6PU+GHI+GX2embsMS3WYX5PJ3mFVRHRPptmqOY2yJefpU1UjCQ/6JtTYTvGUnFLNnY75I4gA0Mu7jn3TKL5f7yb2XZ2ZYiqQWVwSuTMMMHRme11IQBuuNDTnhKQdQAmjeN6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrK6jkNTg+J6jKtxLiO6/b1+6D6N29foVuziKjl7KaA=;
 b=tOQblWAVViRuiMeguwNZ1iJfF+HB573k/IP6v5JEN/iPx9LPYM8PzwmrfK7G54fL49CIXy68Ev0D1UISLAdSdsjGyriEFApqMFINvtrSIFZKAMgiIKg8SuCtFfrywT5mMWQMKPLMWrUcgkJc/zJMTcrDofB8ETh4Uw8kY2dx0eIdSuBjFPrSDGDvydAl6V69vtBR8mI9NT8hOk+LPsj5FwAE7yVFNg6Qu83ITMWh+GOKEanG7CXVJP+dW7xpm4nPW20HL11a1WWWZYYN8p5hStfvvm/4rqNyvGd4sMLRZBymiWo+d7z3BArLByP4c+o7y0ciIpVUeEQd8Zis8wC9RA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 23:15:09 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:15:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] nvme-pci: iod nents fits in s8
Thread-Topic: [PATCH 4/5] nvme-pci: iod nents fits in s8
Thread-Index: AQHYos87waGnx6Ed50WhjTZspyLtp62UaiSA
Date: Thu, 28 Jul 2022 23:15:09 +0000
Message-ID: <d3157807-acd9-e0d4-e51d-4ea49ca479ca@nvidia.com>
References: <20220728221152.538648-1-kbusch@fb.com>
 <20220728221152.538648-5-kbusch@fb.com>
In-Reply-To: <20220728221152.538648-5-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab2f6676-a97a-41f5-358d-08da70ef0416
x-ms-traffictypediagnostic: MWHPR1201MB0062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JwNn4lfzOjwAmTpD07qLoIRfKyOPqdEzORrRVNJCg0w3CNpgwpalxfo+xw2W6Qo1X2qO4wRIklJUMp0U/gnr4FxbCmX9QfzdW0yRvaA9i7IbjWz/2XMTaxTN+h+NEpoS4WT8n209Ku9ks4ZridyJn+58wH2rJltuYxhrDEn51VmaA+cymVdFiY174fU1XkY7e1Ocd0fiYs1M0kxO8lxAzz8e6Y27GvPC3lCpiQio9TITMGqGTjSvSGNaYYQ7sjwFXWxifF9LqpWOOvidQhT0Q0oAK53inz8fl3YVhiyPInI0Lx0OBw767DTvNVFjBMS7sqRnBReG8ZMhm7s9Y6UWe1eZXDoPB0NCRasxUvFGbR+5oNydoVqKiEzmrp+RVlajiTj8JSxhfvg4mIlYO4COFj4ApmvEVO7ScmaNRW3W/fnK73AV1fUFYe4MEQZJ7ZU0a84o7Pz41Hi88OK3KhA57RSEQMIgC/oGS6u5wRWj0qFIK7MRyZEB9qeJ5vhxv628WLUI0n2kCylNtmZ5REbwUUGaIcndzA7uAluNnrP1Y0AmfXyayWQb7aCBDqhwugHGbJ2iQlOT/bF7l14P7MutIP42g1XItIwK74jljSjJlWlYDAj17X1M1qz3Lw5F+jMTxvimTxStVtyPyQoSMxMJyMp0vrL44rYUDbPobj3ZbXQohC8iXw0yo7XONt8Ede1f3JQOzFXT6/HYCfoIvv2+N1PbYk0cGgkhX8i3cXW+qdKHn9AfnIm8s7ZGWRYSipjtiJYZFcLbZQzXEyHzihLKHgM75HxqQZs9CUaG8eoXa7VEqadK7Uz1QV4xey3BywiDS2JBs5lcHTsc2ky+uJRw28wjS4pDWN4vE3ULVwR0xq867IP3c7T86MHBSJF7dGp5
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(31686004)(478600001)(6486002)(31696002)(86362001)(71200400001)(122000001)(558084003)(38070700005)(6506007)(36756003)(66476007)(6512007)(8936002)(41300700001)(54906003)(64756008)(6916009)(83380400001)(316002)(2616005)(66946007)(38100700002)(5660300002)(8676002)(186003)(66556008)(76116006)(66446008)(4326008)(91956017)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dURuZFJGUUxCejJqbkNEUVdlcnBZbjZZOUhySEFmUlYrTE45WDQwTVRNV3du?=
 =?utf-8?B?VHZzT0xDczlUQkdBbGcrYUhuMlJGVi90ZngzdHpUbGlyK3orWGVzbXh3NWVh?=
 =?utf-8?B?MTJCUmxPYytEeHQ2Y1EzYWJFNkZSbEFnSjA0Mm52R3JOMVY1QzcxdWpWakhT?=
 =?utf-8?B?MStUeWFnWDZtajY1bjNObGd1b2dlUW56QnlsQ2xyKzExMTd3L2IzVVZYUDc0?=
 =?utf-8?B?cVZsSUNqUXJFN0hTQ0RncnNJaE9zMXhYa1MvVW01dW1oamxsaXpoOGxTaEpK?=
 =?utf-8?B?VjdJUVRvWmJ5MS9FMGVYNkdnbU9lalY1S3RkKzBqWVF3dWRwdmtBdVZBT3Yw?=
 =?utf-8?B?alVuZGxJVDEra0xac1RFOWFVUmdJcmpTQmt3eHFrTlVIbTlPYU9PaFQvSjVZ?=
 =?utf-8?B?S2pUTDUreGZKTGxOdXBLbDVyVHdFVS9EODBUTmJnL0NidUlCREU4RW4rYVVT?=
 =?utf-8?B?TDFNQ2Q2TEJnaldGYXRDa2NIVDdaTDZyWmlPOEM3ZGt4OVhleGI0RDJ0RWo5?=
 =?utf-8?B?Q3BEMVV1V0V2Vi9rOG12NjVaRjMrZjNYWkF2RFQ5M1RxaG1QM3YxZDJycU5v?=
 =?utf-8?B?RE15VWFValJGRk84RFVBOUhnMGtJdkpKUjZ4c3U2c05seHdDWkxWOUFaRDFQ?=
 =?utf-8?B?OGhDcHJqUGVUMlNMUDhHSk9saTA4Yy9raEVXZnZuanlmaHEzUWo4d25sWGlG?=
 =?utf-8?B?R0tzRXpzcU50T3NjN0lSdzJqY3BhZDhsZ0hwM0Q1Rko4ZTdlclhGK1BVOTNX?=
 =?utf-8?B?RG9ROUtTMEloWjdsLzQwckRneW1QRzg4cUU4eE10VVZpbXQ3UDJHUDYzUXZn?=
 =?utf-8?B?ZGlYTjFxQzRDVk9kcnl2SzQ1ZHlBVDkyOTJIVlF6TWVnN0w0bW10djV5dWRV?=
 =?utf-8?B?WnNtaUo1c2dJVmdZZ2lTZ2xuM0xNdGJRM1NqRVdFa2tVT1pSbXlBM05zY0s3?=
 =?utf-8?B?czg4ZURWNzlQSTRoSmVGc3FJS0c5cWZvVkRCNlEvTk9UREhYbllvQVVvcGc3?=
 =?utf-8?B?MGZKQ0I4T054TEgvWXRFSDlqYk5IYjUyTjlkYnlqV2VVVmVZV0VtU2dGQnlU?=
 =?utf-8?B?dUJGTjhrTURtcHArNWlodU85U3Q2Y2xhYzdqWjFSTkZSbFV5bVpDT2I0WlNS?=
 =?utf-8?B?SVFZLzJCcVg2MUppU3RtOFFzS1VWdU9IWVNMMWdHc0hzdjlUb1ovTjJldTht?=
 =?utf-8?B?dlU3VFRib3NLVXhBKzZrSTl2NVZWM25JSFBHaWIvVlh4dFBkOTlWMXZudkR0?=
 =?utf-8?B?TSt4SkE2VzJOd3JxR1VpMEo5aXNrTU95aEF4ZWs5QXY2SE52VFQxTjZ2UjUz?=
 =?utf-8?B?TDJPZkVya3VDRXZ1a3hITURUTmVmZkdPTVRpd29LbTI3RnpzbFhyMU9iQllX?=
 =?utf-8?B?aTY0YlRxTkkvUm1kNCtnYUxxZGE3MmVoM3hrUXd1YXVhSVMzVWNsZ0hURVBL?=
 =?utf-8?B?OXBzT1l5Wk9uZmpjSlFXNFppeExIREtCR2pLVXZ5OS9Yc3V6RndqSStmSFNr?=
 =?utf-8?B?RjA3R0pGY1hkVUd0dk5WV2JRUGpLUVFRNzZrY1ZKTUl1Nm42WGQ1ODZFNm55?=
 =?utf-8?B?TFlSLyt0OUMrckhmZXlySTRCbHdUcUVMS2xTbHJVUUM2cEd4b0NaQUZFdzJ1?=
 =?utf-8?B?QzNYa210eUdGRVNXcU41M2tOWHZGZUNEOGxwZU1zNGhvWEVNdlFoOEVrZjZ0?=
 =?utf-8?B?eEtKVHA2ZFo5amFzaStJWE9jNEpGcmVzU3JzNW9JMUVJQjd0Ykx1SVhGVHR4?=
 =?utf-8?B?dXpQUzBqWGxoQkoxaitoMTJGWXo5c3pZUFdsekhxeC85UnJuMUJpQm5Gczlv?=
 =?utf-8?B?dTd2eHA5SGlJdTlyVDFzZzdPUVdoSnVpbkExOGt5ZjJMWlhGQ3RkeDdmaE8y?=
 =?utf-8?B?V2FnRjFwM1FFdUNlTjkxUEhQU09wS2c3SExnUzVzSFhyOEpTK0RFV0dLT3dn?=
 =?utf-8?B?VWdJUURqWnFhdVV4SjVmYUxPRWhkb1RhWEl6dFlScjF1YllGVENrbEZJekhj?=
 =?utf-8?B?aGN4NW1vbHpRd1JvMGJXNGZ0RXNMQVdaZGZBdU4wWmp4d0xteUVrSFBYOHp6?=
 =?utf-8?B?aWtramxCZDF2Y2VFMElmVnlCbG80VkRFeTlsYjVjL3dvelQ0VzBNZzdWak1U?=
 =?utf-8?B?TkppOUtDV20yQ1V4cTRXY09uMVJnRlhDZzY0c0RsRVhDSGVYNVlNYkpQdk4w?=
 =?utf-8?Q?+KwNQlqg4sfSxM06TTeF/SNfwW4wsuSekTVRgBl5y90c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CBB1EED72BDDE41A8018F6F950FEADD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2f6676-a97a-41f5-358d-08da70ef0416
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 23:15:09.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+xTjuU3BYvbRLmeAZ/tfm1pce+6NyOEgyxycdGt2XdRI67zwqBZzzCFr/fvjWpOlECAZjMXpp9ZSlgsSHPfmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_161513_387062_AB71F70B 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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

T24gNy8yOC8yMiAxNToxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBtYXhpbXVtIG51bWJlciBvZiAnbmVudHMn
IGFsbG93ZWQgYnkgdGhlIHF1ZXVlIGxpbWl0IGlzIDEyNywgd2hpY2gNCj4gZml0cyBpbiBhbiAn
czgnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3Jn
Pg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

