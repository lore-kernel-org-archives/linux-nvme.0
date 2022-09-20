Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C0C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PhvRIDmrXrF5ec6/jynNa58mcQPqCxuM/VGNI7Wqx0=; b=AFXZIhT2UirV7/36CzA/u4aht0
	WGoOTHB6PjSk2nEBtCGuq9WJWBsCXB9Jpmul3AjMYnhp/X710y4ePbiUvncocJSpHySB1hvHrMTOi
	LaRjUCG8PvrhErVzH80O4Y2Ndd/GWYYtaXu1sUGCyDX2tCxST7vdPsWFM20ZilAauh+dvgSS83/FS
	OClotd9KtDyMHZwQDpFRUwpSH4LsJwad3RsatdGiEjujHdU8Q/Y9imurbQCc1oP7K+CJHhMs5DXLX
	+DldtgQ3+pWY5NZLu8H6MTW6Y8OWBV6lge+2htlfzDo9Oe1i0Pj0cw1PS1Gd6WKHef2Kq1GHdfzaT
	oqmel2jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal5B-007CnL-Vs; Tue, 20 Sep 2022 21:47:10 +0000
Received: from mail-mw2nam04on2043.outbound.protection.outlook.com ([40.107.101.43] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal4m-007CaT-BQ
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnyNESX3Pz9wZ/CNEeQUG10/2O1gYbBupJHBYGn+fpLf2rYuc6w37DaGIrMwVaSnPw81jjS4P9/HA3b3Ul2tf0FotE5U60rErDDREKa57J4nDRyaezGL+LvWI2js6J+yPel1r6KAPcREuxeb2tquf3X6rKfF9LClLGaAtXYbtwO1he0iqfr4aNeDLeiluiAzZgjk14Mjdjub18zFD2ODgss22PDlv4S4ArmSSxowJhsgmklxz6Lzl3Jo1ZoJlwFw7j4+4IXT8z5MKoeidzy2BT4OqHBCTJgCSpHH6mxqjhY5ue+cmSm0uEsEoMGsBhDa6yLJClCr8cUcBeSko/xl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PhvRIDmrXrF5ec6/jynNa58mcQPqCxuM/VGNI7Wqx0=;
 b=cMDHeVib90JmpMCyxspaohTZE/hXPmX1wa1CNgXEMubxJjVq2f2OoqrGwDOHYGn9R9fG79h9czMo2I7Y+a1C3oCGSitMeMD9Ioz6zQfnQeG0hmKjnamWYn0fvtnxFPtPIiRZV2hr07uOyxIa5PacqkQDWwe2Nv65n7C5E558b6RdG8QotPjFJwcHT2xNEYDq6qFHXujoj9z6jkyNUKQmQErAepDbStByfoBGWdJt5bWXT/7g4PA/sLX/6NaVnCZTwSuBB53Tq43z6fu5I8RufEtNuICWMA7lXLGqUPoX/reTA8JQ2Ydi3+koDf9kK4tlywDCKbqcgnz9X1Lp6CMooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PhvRIDmrXrF5ec6/jynNa58mcQPqCxuM/VGNI7Wqx0=;
 b=e10QlOtVtcutn+mao+IDnjgNAscUfImdGtf9zgeQdmrkIg8D9Y+egMlx7Pd/IOqLwLro45yfg1tMwuTEQTHj4zufPnpqT7ZGHc/Pa8cNBmqTuFvq9+l5O+hXNGtlR3PqjUrcQ89cmgy9vKtSp0fbsxuQbnPPfgBxih2NM40DiuRTBAaUAk9uyrcftq6aJUdEGcK8Vo3NhvBUYWYI1Tx6xuJscayjvtkH4N9hBhHCyCI42vqNLOJPwyJJsOhdzPvGRBb88Wkdl1ZY2mliPI0KArSFEADwYLrfd4XiVY8tI0zSJMRmNuOwDeUFpRxAEmBiUQPRwBr3OqrwQnqDw98oyg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:46:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:46:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 12/13] nvme-loop: use the tagset alloc/free helpers
Thread-Topic: [PATCH 12/13] nvme-loop: use the tagset alloc/free helpers
Thread-Index: AQHYzRUQ/hKoD5qTb0a4fCl1ORQcA63o2sQA
Date: Tue, 20 Sep 2022 21:46:40 +0000
Message-ID: <420c9e2e-a127-6f40-57a3-55cd8c17c29e@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-13-hch@lst.de>
In-Reply-To: <20220920171611.1289361-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: b0ff0d50-1879-4757-1c5e-08da9b519a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5P/3OwoiFTrDZ/Fm32Y6rZx+QCnNcTxA5/5uB4qJxoqACtBXMJbl7xp5FHMaaLZiivoRtqeich+e3H2907SrKE2zvFFC0Yu6zAssF8RgqQ4vdUYpt7H/NmIwJRzRZytLegvc+JaNgVzl0hVnrzkg3FGc2YXPH/Krx03Epf6xSxTWBgis+xCveooQN9LA4ZWPSKUjIa5kklsMkniSNuHj3/lRMgoX7ZzJdIiWVACHxESTQQ8aHLwaZ/rjDY9o4UwstxElp5BNXPgau1ADiAOwu4T7vqVSxyGVC+zxTmos1LGb1kwpIYXQhAKn6A+BWg3W6rWAUsmlNzl646aFvXTC5NDFHlLtzsrc5Uh47Uk5woUQAGK+aimmdxq68Jdo7LFzAg38rqiiRFFBVRUi6+YexmVD6DPn0P8hVJZ2jbyuX+dWzr5m97pfEDwni3qn1cnLSggqmPdGkEr6vjhwAJILqk8Tf3mSLZb2vWtCtv4hxjE/PqzTlzn0+4ez0+e7HpRTVDlqhKeZpUeaNwOJf/zK0HLL8/2aWpiScIMP9B/MF11gq6YhPl3qXZoDCZEPoPbAUZmKxZOCnO+IBZ00zPbviKJNGllwH1dMYv2r09ZgG3iEoJTsFi8pkHNxQvWqCxqhZF6gs3nGf+Gr6gWCTZe9VABRtnwNbntSeuhi/QRYxgACs+DfL8ErfwmnVURpspu43MEC9lZ3xiFYZ/Sb9mynsoO2LM1Cg0ei3LlfJKUg0LZRyHeR/KQAIAP7miyA6faJfnGxqOrKeyQBGodC7VgsvnglftjMuC8/5GBs+HqF++ZxJw/Q4NNvYoKIdDPNOCzki0lAQSWOKlBUlXD53OXfKA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(4744005)(31686004)(478600001)(36756003)(66556008)(6486002)(66446008)(91956017)(76116006)(66946007)(8676002)(54906003)(6916009)(64756008)(71200400001)(41300700001)(4326008)(86362001)(31696002)(6506007)(53546011)(38070700005)(66476007)(8936002)(122000001)(5660300002)(38100700002)(6512007)(316002)(186003)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UVNQOUFhZ251NmhkOWRjaE9Ddjc1NlJsUDB5MzIwd0JCcWxoOEV0UnBxS2Na?=
 =?utf-8?B?R2hmMHQwVFpBb1p4VlB3a2ZjaStnV0VzNkNTSlhjT1NINkhNdlg2L3RvRHBo?=
 =?utf-8?B?amFmMXcvS1NGK2xVN1ZVN2lRSGdEQ29wUWEyYXdxSzIzL1ROOXhBZzdVbk9U?=
 =?utf-8?B?SmgxOFFIaGtScVFWYUZjODBKeGZGcnRqdUFHYTBxRFN5V0dYUVdFY0NjSThO?=
 =?utf-8?B?T2t3V0pKRkFlYVZnNWFPZm9uNUU4ZnhMd0ZaWHhWbVJtZE5VVHFGcGhmelhr?=
 =?utf-8?B?ek9UTkFTbzg0S050aU5ETXYxUFpOVXYzY3RmSDh3Z3RKMTJjb1FzemxXUmdq?=
 =?utf-8?B?M1JMVnczTFptd1QrZnF6SHRyZjJidzVTODJ2NnBUR3djeFZtSDBLOVhCWitM?=
 =?utf-8?B?TEtzQWtyN2NVdDZzZHJYMXV0VWVhbEUwNGtXY20yMHBvNnlRZkdBN3cxazAz?=
 =?utf-8?B?UnIvS3laL0ttaVl6eHVDMGZaOTlOUkdKN3lFZUNVbUpSNEVCZVozWkJFblZh?=
 =?utf-8?B?eG5YRmpJeUFFZFNCVEJVVGJZYWVZNUdwYUlqZEUxQ3psMHJaWHU5UTZZQjI3?=
 =?utf-8?B?dHhwcHJlMnZxTEVSaWhJaElNVWlVMHBVQWpzQm5oMStwVTljQk5XSDdkbFhX?=
 =?utf-8?B?dkU4d0I0SjRFaTNLUFdYK21WcFJiL2NRVUw1SXB3M3g4QVJobnFad1NoMlVN?=
 =?utf-8?B?Wk1tdnU1ZklpN0R3TGlRVlpBQjdvdG9rM2piR25nWEhaZEZDbkNSZnpjOXhZ?=
 =?utf-8?B?YWlJUWl2SEJkRzIyMVNlTmt2R1JBZ2pMMU9XaFoyOEM0dmJDYjN2anBGZU1p?=
 =?utf-8?B?cHl0LzZFbFhOdEpveGZpMGdOeHB4RlJmQTlsWUxINWdaRXNidG9nY3pEaXVk?=
 =?utf-8?B?ejhhcTVScEMwRDZ0S1FOM0JZMHNCcHd6dFdQY0p1Q0p4MzV1Yjl5VURQS0Rp?=
 =?utf-8?B?dGdEUXd2aXhESlBYcExlM0JMd0tqdVY1cGxtd004SXBTOG1KYkdOWjdTN2lB?=
 =?utf-8?B?VUJzY0ZVU1podmdGQXYzKzl1VjBSbWFuNExkVTVTZTBRRytOVzd3OHd2ODdK?=
 =?utf-8?B?Q2ZGY2Z1V3lLNjV4S0NLOHY5L0FyUHRSUWN3cGc0Z2E4b2JXdDNHMkRIMXgy?=
 =?utf-8?B?MFhsamlPcFFvVjRkRmptWW1hb1I4a2Fma2ltcjVsVUNERndmeEc5Q2gvWjdu?=
 =?utf-8?B?clFZYzRDSEhTZnh0R2owdEw2cE5IY1hCVmtGakFUWi9VSExUYXhkSzNtTUZh?=
 =?utf-8?B?WEw5VldRZ0RUZnBRQVhMQXBWdUJCQzFUTk9FbFBvRTVEL0dKRC9zcVI4MWNa?=
 =?utf-8?B?bHo5TU9oUi92ZE01UVdnZUtuRUtsSlgzZ1J6dkhRUnlPSitVQyszaTA1WFRR?=
 =?utf-8?B?QUkyaUJ2NTBxYTRLcmNTL1pLdzI4WXhBZjdMR09vdS9aVFBSMmZJa2VaVG5F?=
 =?utf-8?B?SWNPNmJLaVMxRnM1RjhSUmltYmtXaGVKL1MwdHZPdThaelc0aUxhamhLNWRk?=
 =?utf-8?B?OTRUVExyckRnYWdodWdOSEM1QldscjVVYmpUQW03dVZLbFNwWStJemduMi91?=
 =?utf-8?B?V1VtN3lMcHpzaXZHOGJSbElWYllsblhlOTNIV0k5Rk8wMUZyc1pKZzZxb1do?=
 =?utf-8?B?SFkwNXBicEtuVTI1eU9nYlp5VDQ2bkI2c0JkcFp3NDRadUJsL0U3VzV4NFY0?=
 =?utf-8?B?T2w5U0NjNzRuUXJ1Nmp6Ni92cVprSFRkL3BSRi9aZEhmeUJ6TmNsS0xzYW56?=
 =?utf-8?B?TS9oeEdSYzhDODhJNGcvbFRKVjZtakZ4YWxIN2dqMmppSFArQmY0KzJJazZY?=
 =?utf-8?B?RTc1ZWtLaGp2MXVsWCtKNmN1WmJhaGpZazhyRlFDbEpWWm14WVBVTHdQcUdo?=
 =?utf-8?B?NEJSdDFyaDVPcE1Db1hYcjQza1Rja0t5RjZOeXFDWEwrbkNnSmdQYmdzUXdI?=
 =?utf-8?B?b3grbk9wS1hjQnhNZWdCV25Zb29zM0xiWTJLR3FSbkVIcEFZaEVnUTVLM2M2?=
 =?utf-8?B?MW1hSVJZNXB0QnFCSkdSV2c5Tkx0WDd6RUR5UzJDWDVab1ZRcm1oVXI2N1BZ?=
 =?utf-8?B?SmFqUlJub0p1S09ZcWRjaHpGZ0JhNkN1MVZURG44QldGdGphckpYVXpjT2Ey?=
 =?utf-8?B?V1RweHYxQzk5SGlBSU5RRFhXQ25ITGlRWU1ZbmxjSWFBcDN2Wks0OW1jV2hS?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D79D3C3CC06674E8A8F570080538030@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ff0d50-1879-4757-1c5e-08da9b519a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:46:40.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTDh6PfE9WxhMwKGo/dZJ5EQw5enTms3pvRC4mN7DvqFUUoNOdWIbmSSjjaFzavCp4CsmRA+WYVIM0cJOIjA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144644_433137_97A60861 
X-CRM114-Status: GOOD (  11.52  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUgY29t
bW9uIGhlbHBlcnMgdG8gYWxsb2NhdGUgYW5kIGZyZWUgdGhlIHRhZ3NldHMuICBUbyBtYWtlIHRo
aXMNCj4gd29yayB0aGUgZ2VuZXJpYyBudm1lX2N0cmwgbm93IG5lZWRzIHRvIGJlIHN0b3JlZCBp
biB0aGUgaGN0eCBwcml2YXRlDQo+IGRhdGEgaW5zdGVhZCBvZiB0aGUgbnZtZV9sb29wX2N0cmwu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4g
LS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQoNCg==

