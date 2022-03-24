Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30335C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szsjLPPcI4cdMHshn9Kf4d0iwYbrKj1wC8SoS/DYo7A=; b=16VV+o6kRbfgUP5elj0V8UN1iH
	i2CgXj1+AcIKQM5u62zbbsBhvppCWi+yBmIH1LTyZZmL/SWcyHT/Dw8Q1ezMuuCQN/sGBS9WA7NVk
	tDuSasp8U8APpkaI4Mz5TA+tH0ujncB9jH10losSIuxDNEjF2cMNrUP+ASAXXK84X/VfrX5/jJetM
	gv5cS/onKWeu7rbfKq7kclasu/vQL2gMkn+hBZAzcPhrX8HMRwwIsaV2SO/WAG7FOJ/WYQ/hUEAC3
	DmvsGoywJFMyrycnnF9xm3zf8iVcPChJM8VBMdtanMy8fNHio3B/XufJDA9nzdw5J13C70aVcqgSA
	d9aGzsfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBFc-00FC6l-Jk; Thu, 24 Mar 2022 00:22:52 +0000
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBFZ-00FC60-LH
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:22:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi5QShlImkvVM54HmB30J+dt0raI+7xe/YQ5bY9rzUCRQdIPWJHilI9uYS19KUolRvxj6WmOGX5L97E9MRiYjFYPcFdRWYSPNRP60t22Ef7pdIBNeapv16OdZEPrVI0GR6GAOIEf/diZfphSbQiuJdm1lDy4Jew+EXkd9TAtq79QQcEiQJnELn7UTtgOkH7sSyhHLhQreU9AXrvce3DAo+fGixlN2ERq2SqWRI7Us9iQtxlrxh4OPSpFNnRFy5w1LRUn/00bCBFm2Pmf1RVSopcvAM4VgUJG1OvjZDr0IzLnbJ4o2DFxTSW3io8oXS8zY28Xt9Iwiy4zMAHNNMUzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szsjLPPcI4cdMHshn9Kf4d0iwYbrKj1wC8SoS/DYo7A=;
 b=lScTMF1WCViN71WNVxaaX6eaZDRV2scV5Pmsuy2F+lSMvV1KPEQFk+90ylwkB4WLLcjieUnimdPbXaO4HIULFbKhyVebfIXKDKhxoIrdOnIaAS2lAqjXhE4UmBY7Btl2UDVNzYP/iZvYCR4h4GNRAQGJK6wFbkkKPPzuTakt0miMqPK3QmLBpkuv/uyliQEJyxb/oItpqCX8UfUncM8b7DMWxQDTiGvL94cpaOPZ+81t3Xi8yw1mWHIj+dXFfy5QlZ8pGRR4z8SIFemJNkmDf7Jpi0k98cs37qZNU4iLV0gqRjCcDBnI62cZI1dS5x8Jul+w1ULjlNSqj3l62bq79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szsjLPPcI4cdMHshn9Kf4d0iwYbrKj1wC8SoS/DYo7A=;
 b=CQg0fns0Orh4eAG71ivDtRIMgdQfyoVLpPh7hbvKvIQZIZbnej3lPHkL5wAFbKscVrZ0mpP18QsBRX6FUiBkRdFQnHF1NPCTVOgoKQmTlksusrPIbUu1HT8RTldUUzrwOOUmRk1DjI/NnjknBlf6XJe6PXsWTdB0LHlWt2Z5OEavbmngd7j6qSwt++lvIkn1SLk0K1f77f6mllWN4dttUN+ST1ivDMLg1cY6FzU85McF8JhWjM3MyOmtFWeSyQhtBDfwBLWB0ViClKkZQj+PS+1Xs7DK8TOjEWH4fE8ch3RSdVQg9iMHF7g0AP3j4hpJ4NCXc64EeJ50BQa8WOdy3w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0014.namprd12.prod.outlook.com (2603:10b6:300:e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 00:07:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 00:07:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
Thread-Topic: [PATCH] Revert "nvme-multipath: fix hang when disk goes live
 over reconnect"
Thread-Index: AQHYPxMGovbrWCUKxkOcEQ5HOWtqQKzNqCoA
Date: Thu, 24 Mar 2022 00:07:32 +0000
Message-ID: <db210cb5-e077-5885-23b8-5c3e18684fcd@nvidia.com>
References: <20220324000620.4127-1-kch@nvidia.com>
In-Reply-To: <20220324000620.4127-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc10973-96f2-4f8c-efcb-08da0d2a4b3f
x-ms-traffictypediagnostic: MWHPR1201MB0014:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0014BDB53C8D3BAA096FBF25A3199@MWHPR1201MB0014.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndcWJVS2xw/QrvlgqYroCvshSaFj8vXqXzTSeAvhTT5osstAWbi9tgvjPc3vQCm6bCC+BnMhuMruY+OX6Rs+2bpgNu/Bu5qModudWrTZqqwMF7dSRca37roZ2xpOogPuGslETrYCEebNUvosx0abixWlakdTfl+6WhbZhiJrnnGGiIyZ2KYVdDbNZh78Jq1GHWJePH+UXlvNQIr9k1WE4S4VCsIobZhuT7L/CYMiO+o1fN4xZBDBfVH2ipMtRCrds0qXlRAFPFuBuVcnSiV7LlvVQ95FD0ulTWMNkJg3yePfdI6zkdEblBLonv7u7K5AsGo0Q9psP7lb9PdHG1ZF1+JCu3bw84Y1Nf0oZvWpSyOjWsg2TseiMkiYD8QWknrvrVmeS+qvAeLKBc+ylIlA7Kex/DMaGhGb6YQkzlJqssDU+qq5vCQ3c9n5MWko0L2aoiXNHXZwYEmXhdj8ddRTqAewIosfOSuMp54jnkRYmQUnOzectqTj/+bLVprS+KgKek+dBIC8zkM9k56jyD/HLteLuHEkQ3kSduOBPaHutsG2BRPSIxjpBk73xBMLZ6f8Y9LydyrtYpodudGwrgZJbLJcDGfiCtuBj4LUzMekyqnabh/ehU5+7s+3R2uM7iUWFB1R9G2vchUdDYV3C3Vw15013JrUmglrbeQ1L7HGXRl/Ce6g9sXAHeW4gKBwIFwPzpXDZfuA1RL4QP1GbpzOWQkwJjNl34WeEnOayzItIahTDi+aJBuG0cOzhNU+CVbYt3RyLnyP32aFFcQISDOKNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(2616005)(122000001)(66476007)(83380400001)(66556008)(2906002)(76116006)(66946007)(38100700002)(64756008)(66446008)(6506007)(38070700005)(8936002)(26005)(31696002)(53546011)(186003)(8676002)(6486002)(508600001)(31686004)(71200400001)(5660300002)(4326008)(54906003)(36756003)(110136005)(316002)(86362001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGVSNlh0MGxRRWZxc3JpUXBZZzUvd0hmYUM2VCtJRDJWeTFHN1grT1M1d2Fp?=
 =?utf-8?B?Z05rVzZZejRzd2J0c3JOWnRtY01VRXhxUjMvMjdBSDJmQWpLTWdreWYzNHFY?=
 =?utf-8?B?ZGJnNTRoeTliUUZlbzQxZk5NSUdxeThzOWhLTWdZbVZGdWJCUmRobkg1WXpl?=
 =?utf-8?B?RXZ5M2RLWEJJaDZVdmxLRXB4dGtVemhBMnl1cWlWM3JoejFjb25NTDhDbEtM?=
 =?utf-8?B?Z3hJcWN3RmZqZGtLdTMzTTB0NkJYenpDRGUraDUxL1E1SnI3MTgwd2JBR1BU?=
 =?utf-8?B?WmhqYVdRSUFBUDR1VnQrUlc5czJPbFpCZlNPTmpxVE9kdHBVdmlDRU5yaWN6?=
 =?utf-8?B?NDAzdCtFVm4xZU1DQ2JuRFZmVTdtWHFBZG9BcXFPK2drQ2pnSFgwMkIyRWtu?=
 =?utf-8?B?a29RRGU4UnpBcDlkSWVTeWZQYUpFS1hNbnZZeTRvbjY2dTNxUm5RZ2c5ZHhv?=
 =?utf-8?B?Qk1wd1F5cU1qN25ZUFc5RVBmRkhwc1hBRVFmWWNSS2oyT3NHNDZDQjVKSFhU?=
 =?utf-8?B?UTlYeDBrMVB3UVF5K0ZqcnJBSHJERFJrSlBNdTE2YkMwTnFRd3dEdXdFNVky?=
 =?utf-8?B?T2Y0S0hER0VKbGtUVXlIaFNoeitPVlk4MmFCak8rMXcreFdoVHdVOFhiSDVx?=
 =?utf-8?B?MmtRVjNEM2gyYnM0WEZlTi9iMnNSZE1pTzJUUVFFZVo0NzJMa1dGVlpia21v?=
 =?utf-8?B?THVJZnpIdWNTdGI3WGlGRVZGcWk5TEg0Slg4MzFqbnpZOGxyOCsyS0RraGxr?=
 =?utf-8?B?S1JVOGZzV2hZdTVtNTZmRDEvQ21LVjJCRVpBVXdvZmNCWmk2RGExNXBnVlhI?=
 =?utf-8?B?MC9YK0N1RGtDbkxJS1FiSUxraVUwWStqSnphR2JrcHF1SHNkcCtyc3dWUFYz?=
 =?utf-8?B?eHRXSTJCYXVBWkhQL3I4WFM4T2l6SFNhOS9tNURreVFkNm80a3NuTnNWQWFv?=
 =?utf-8?B?QVEzVnU1RG5tRWNXUnNYWGUwdGpqbitWQUU0QzVBSDF5cVBLZFZubmVDb2xW?=
 =?utf-8?B?SEZiRDVoVm4yTk1uRmk2RmpWZXQrQ2F2VUVGRTcxRWwyMTNqbGNyTCtFeE54?=
 =?utf-8?B?L1VjTXVrNm43OFY4Q2lWOTZMVmxuTFJwMldXWmhlUmdwT0g4OXBma0RTV3dT?=
 =?utf-8?B?K3MwR0pVNGJiWFQ4cEM2elNSb0ZMTEFrNEk5RTBldXZtTDhUdDRPQnRoUEJR?=
 =?utf-8?B?SGNiV3Z5MjFoM0V3S1pOaFU2NjhSMVNSaEE2OU1kK2pzTE9jNC94cFF1Sytu?=
 =?utf-8?B?OGxLamZ2NklDcjg0bjBtOW8yaFQ2VlU5OUV3VG5TZkZDbW4vY0VwRXNqRklR?=
 =?utf-8?B?a3dWcVBGSTVpMGRZdjFwVytkMlZPbFZYYkovWkN2SnhUMGVZUUcvNGlWTnh2?=
 =?utf-8?B?M2lKM0pDZzdRZmcxdzZlRVdxRlNPY2h2dCtiQmxqOStsMTQ2QVY4Y2RUOHp0?=
 =?utf-8?B?dzdKVHdPODgwelQ0djNqUDVDTkFQeXhoNUN1a1JVUk43bWwyZHppVURLR3ZC?=
 =?utf-8?B?MUdxWWQ1N1orVzdXYmZ5anRncU5kUGlPWmNrU2VUbmhBY1ZBVTlSMXJJK2lV?=
 =?utf-8?B?Q2VOUjl4dHN4YWRUQ2VjKy9QaDRoZTJFN2NFc3hGMURpVHpVSklGVlp5clRK?=
 =?utf-8?B?MDRHQjNCMG4wUGl4UGRDdE1VbnBHUEx1aFhuT1YyM2w0Ly96M1ZRbVNEdGFP?=
 =?utf-8?B?TXpzekFUVE8vWGd4aDg2dXMzN2JueFpQZHFVd3g5b3Y0MjRibnBiRld2S3J4?=
 =?utf-8?B?eFhTK0poNUlzT0NiRmJDUGluaUNBTXJud3hNM0JEYSsyeHIxYkppWFJ1Z3Vo?=
 =?utf-8?B?aU95NWtINTlZZ1BHZWMrY1RUdTdQM1Z2anVqV3JuTkdaZGhQNmFjUmVQdEYv?=
 =?utf-8?B?NjBnWldGWG10WGt6TjJSYVNjdWI0Nk96TlJXb08wN2ZpNGp1NUdRcWg0Tmhm?=
 =?utf-8?B?NnhheW4yMVMwTEpPMkdDME9JbkxGU2JYNlNpZXR6V0N0NWtKQ2tjbnpvMGxU?=
 =?utf-8?B?aEpRUjZRVUpHbGxkZWJmZEg2NUlqWmc4dnc2cE1HRk43MGVjZTViMnJ6TVZT?=
 =?utf-8?B?ZkpILzE2VGlNODIxcnhhdERWbEp0WVBWYXJEVURXSm5tdVIvaFNJN0NxeFpm?=
 =?utf-8?B?Y0o5ZTM3S0NsWTNmblVJZm94ejkwajdjYnlBcmdnRm1LdExObHdvbFVFbG43?=
 =?utf-8?B?ZGtya2tjTldUdWNOTGs0Q3dvZDFSaDdPek5saWdIclpNZ053MWVVWWE4K2I5?=
 =?utf-8?B?K1B1aHdrTWNmRTYwNGxkc2cxODVNYURCamlZdFAzRm5Pd2c0eHBrVmwwTHJm?=
 =?utf-8?B?NFhKRnd5cGF5cnhGaWZSbVVaTzlaNlNjaXlzdml2dUtRQlR3cEpRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC8028D646C53A49A473069BB757041F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc10973-96f2-4f8c-efcb-08da0d2a4b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 00:07:32.7365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rObDUrx8IL/Gm5m5gdw8fo/k3kPInsrS7O7Vw+5/x0o9r1IWUWiAVvp08y12l2cVhhZ8tZYY8U/zxqmGd0uNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_172249_784610_0F631FD1 
X-CRM114-Status: GOOD (  10.56  )
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

T24gMy8yMy8yMiAxNzowNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBUaGlzIHJldmVy
dHMgY29tbWl0IGQ1MGM5OTJlZGYxMGI5NWQyMDM0MDk3NDA1Yzk0ZmVjZmJlMWVmN2Ygd2hpY2gg
aXMNCj4gY2F1c2luZyBmb2xsb3dpbmcgT09QczoNCj4gPDE+WyAgICAxLjk0MzY0Ml0gQlVHOiBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDA4
DQo+IDwxPlsgICAgMS45NDM2NDVdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJu
ZWwgbW9kZQ0KPiA8MT5bICAgIDEuOTQzNjQ2XSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5v
dC1wcmVzZW50IHBhZ2UNCj4gPDY+WyAgICAxLjk0MzY0OF0gUEdEIDAgUDREIDANCj4gPDQ+WyAg
ICAxLjk0MzY0OV0gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+IDw0PlsgICAg
MS45NDM2NTFdIENQVTogMCBQSUQ6IDcgQ29tbToga3dvcmtlci91OTY6MCBOb3QgdGFpbnRlZCA1
LjE3LjAtcmMybnZtZSsgIzU4DQo+IDw0PlsgICAgMS45NDM2NTNdIEhhcmR3YXJlIG5hbWU6IFFF
TVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0xLjE0LjAtMC1n
MTU1ODIxYTE5OTBiLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4gPDQ+WyAgICAxLjk0
MzY1NF0gV29ya3F1ZXVlOiBudm1lLXJlc2V0LXdxIG52bWVfcmVzZXRfd29yayBbbnZtZV0NCj4g
PDQ+WyAgICAxLjk0MzY2Ml0gUklQOiAwMDEwOm52bWVfcGFyc2VfYW5hX2xvZysweDFlLzB4MTYw
IFtudm1lX2NvcmVdDQo+IA0KPiA8ND5bICAgIDEuOTQzNjcwXSBSU1A6IDAwMTg6ZmZmZmM5MDAw
MDA0M2UwMCBFRkxBR1M6IDAwMDEwMjg2DQo+IDw0PlsgICAgMS45NDM2NzJdIFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IGZmZmY4ODgxMDNmZDQyMTAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+
IDw0PlsgICAgMS45NDM2NzNdIFJEWDogZmZmZmZmZmZjMDBiNjJjMCBSU0k6IGZmZmZjOTAwMDAw
NDNlNDQgUkRJOiBmZmZmODg4MTAzZmQ0MjEwDQo+IDw0PlsgICAgMS45NDM2NzNdIFJCUDogZmZm
Zjg4ODEwM2ZkNDIxMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmODg4MTAwMDUxODI4
DQo+IDw0PlsgICAgMS45NDM2NzRdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IGZmZmZmZmZm
ZmZmNGE5MDQgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IDw0PlsgICAgMS45NDM2NzVdIFIxMzog
ZmZmZjg4ODE3ZGFhNjUwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiBmZmZmODg4MTdkYWE2
NTA1DQo+IDw0PlsgICAgMS45NDM2NzddIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpm
ZmZmODg4ZmZmMjAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gPDQ+WyAgICAx
Ljk0MzY3OF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
Mw0KPiA8ND5bICAgIDEuOTQzNjc4XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDggQ1IzOiAwMDAwMDAw
MTc4OGE0MDAwIENSNDogMDAwMDAwMDAwMDM1MGVmMA0KPiA8ND5bICAgIDEuOTQzNjgwXSBDYWxs
IFRyYWNlOg0KPiA8ND5bICAgIDEuOTQzNjgzXSAgPFRBU0s+DQo+IDw0PlsgICAgMS45NDM2ODRd
ICA/IG52bWVfdXBkYXRlX25zX2FuYV9zdGF0ZSsweDQwLzB4NDAgW252bWVfY29yZV0NCj4gPDQ+
WyAgICAxLjk0MzY5MF0gIG52bWVfbXBhdGhfdXBkYXRlKzB4NGEvMHg3MCBbbnZtZV9jb3JlXQ0K
PiA8ND5bICAgIDEuOTQzNjk1XSAgbnZtZV9zdGFydF9jdHJsKzB4MTEwLzB4MTQwIFtudm1lX2Nv
cmVdDQo+IDw0PlsgICAgMS45NDM3MDBdICBwcm9jZXNzX29uZV93b3JrKzB4MWFmLzB4MzgwDQo+
IDw0PlsgICAgMS45NDM3MDldICB3b3JrZXJfdGhyZWFkKzB4NTAvMHgzYTANCj4gPDQ+WyAgICAx
Ljk0MzcxMV0gID8gcmVzY3Vlcl90aHJlYWQrMHgzNzAvMHgzNzANCj4gPDQ+WyAgICAxLjk0Mzcx
Ml0gIGt0aHJlYWQrMHhlNy8weDExMA0KPiA8ND5bICAgIDEuOTQzNzE0XSAgPyBrdGhyZWFkX2Nv
bXBsZXRlX2FuZF9leGl0KzB4MjAvMHgyMA0KPiA8ND5bICAgIDEuOTQzNzE2XSAgcmV0X2Zyb21f
Zm9yaysweDIyLzB4MzANCj4gPDQ+WyAgICAxLjk0MzcxOV0gIDwvVEFTSz4NCj4gDQo+IFswXWtk
Yj4NCj4gDQo+IFdpdGggdGhpcyByZXZlcnQgbm90IHRlc3RpbmcgY2FuIHByb2NlZWQgZm9yd2Fy
ZC4NCj4gDQoNCnMvbm90L25vdy8sIGNhbiBiZSBkbyBhdCB0aGUgdGltZSBvZiBhcHBseWluZyBw
YXRjaC4NCg0KLWNrDQoNCg0K

