Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88EC74A5B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Mar 2023 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKFhU0bchdfhcysR3yeMNaU5/wiAlIOUetf6y2kdMjc=; b=eSVeboaoyEpKquZOm5LVpkfHge
	H3bPNSXKHwlb7SfOKOeVQQ74BgvzRexp1RDYAHvARbbnjm0hcH9nBUM/KgKubn9XqMR6gBEEEU0PJ
	2sEYd+BYCzKOIzXsC88fsBvMGZqs0oHrSFDBpADzlRyQVPzLvrWuy15jBq0F+7ggrEAmgpwlY9omY
	m8N97g4DPForFP6LD+pxAwE9fkTtNtsRFQmC7+87MfuBe1O16FILviMOsgIDaXUSDtoAUhlYWnvNs
	U5615S+Qx7n3cj8T4yuXQXUJMTiZhaysD6ldYlUz3LaBBLbgKri9nZO2BI5eiM4B8j6BtYX6aqX9B
	fpu+04Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd5hv-001XvC-05;
	Fri, 17 Mar 2023 08:45:03 +0000
Received: from mail-dm3nam02on2062c.outbound.protection.outlook.com ([2a01:111:f400:7e83::62c] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd5hs-001XtV-1Y
	for linux-nvme@lists.infradead.org;
	Fri, 17 Mar 2023 08:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mndeHsE0mmqpPJRnGjCnl4xWvVoPXZNHbTifvLHPfEfk8H50xA+cNSEKJK2Badx7di9n7N08nlhmhKIWw0Skr7Xa/cadsqUQE8jfgZl95tGmkbfAMlM+e5MJTnQnmkpNy/kPNuuo8GMqvYv7NyZhLnftL6ZPJWGjNM1JnGJNyRcpJpXr17IW/X/k+jV7JDOBQ4MmdKDxMVWimQle6ZCK453701ZdMFmcNKaD3We7lVEOaD4z6jlZvf53iCgOgKLf8ThcgwpUZIOllM3FOJDlg4PsLaJp0fWJfn8Qe15tO+/h3F/ftZjTC4rHAtnHCTzWy6/HQRTwbGyGq8o+kueOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKFhU0bchdfhcysR3yeMNaU5/wiAlIOUetf6y2kdMjc=;
 b=HZOiZnO5Jo53zeE68Br0fL5JnLKkmDHlb2jKjG18cQzRJucGwULMgVFYhjbk1Tld+r2AsfR5DnAiZBFJfyAvq+tOp+yhJWpjRub0Si8YY14PyAIN7qmMwVDXTQWDlD51C1dD3jVlD7inN+VvyRtZDQkm/Wh3mjQNDSgCyC0FRLb/1p16bumyGzau0IRczIEJ9x5+/RfaeSDmzluS9OopAaoEHNH2EA0jooccKB+pCl+7WCew8xstEg+j+HB9rjAZmHgPJGeB1nk3Hn9Tg7KIj2TYZ9a1Do5rOx1EFca0v0dwILvBGJ3UwdDeBx24NCujD/X7m+YPzB292WFlvj7yLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKFhU0bchdfhcysR3yeMNaU5/wiAlIOUetf6y2kdMjc=;
 b=b8kosa6uPDYDhiNVYefPUKXB3pr3y53Qcdh0l5NVijXJwDU0cNTLs0tQHl7qLtxhYQo52hOwrXrZk8Zj+ovLwmRsFeRwOjpueSQ/cM5o7i66hvQYQRqPkw95WQDJh7lfWZmmEuoFziRQG1pcAqUrFz490FyFMf23BxoRRLIC2SvlcU8RI7mIVJF7/AMWNQ2vLPUTiG0xahEe11HFlinfqWPd/0NrHX2YlmLpTIDII/eD0boxaAWOoCD5b0C0lbtMD2XP7+uE5MRIkmML7CH9V3tSNpJc3Qmx3EpGjYc4XXqwUzuQ3ctWZm4oWvaS66RvCxHqmjwDB5cWlDx+Az00Zw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 08:44:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.033; Fri, 17 Mar 2023
 08:44:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC 2/2] nvme: add error logging opt-in
Thread-Topic: [RFC 2/2] nvme: add error logging opt-in
Thread-Index: AQHZWGJBOSpOZ1qQk0uZX2t+Ui1I+K7+qLsA
Date: Fri, 17 Mar 2023 08:44:57 +0000
Message-ID: <2885104f-99b6-6dbc-7759-57434f1471f2@nvidia.com>
References: <20230316234958.1486700-1-alan.adamson@oracle.com>
 <20230316234958.1486700-3-alan.adamson@oracle.com>
In-Reply-To: <20230316234958.1486700-3-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6911:EE_
x-ms-office365-filtering-correlation-id: 69a6e75f-1090-4370-048c-08db26c3e2f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2r18GoMPq7PLKETQKmsBPe+zU07j4tiB5JKNjTCxj2Cb8JRLVg+ODlH3hqTnZjD4MsUSElLI+HCojqip5McCEXCRNgS9aaHiHRpbcOziFm6o1tPOdAIuiUGF3K0pVPAylvxHcXDVCTt/vCPa4ifVONo9VTT/CIqQjzKdYBn6EP3GNGY2TCEP1F9LjOgVdidRraFEIJeIJxkOlqVhACDSBvsirX/hy8jQxFrha/x+Yyh5kfq7+UnytAyW//TBrDOQr1q9hzvlba6iwO4oSyR7gquv8DV8sKHL/55Zar0o2N2+UcDS2/CvOZgg+96GOIVtmwr8t32CgeCZiAkShW59EvJC/BAxjnAGbvY7qqGM04M3Fw8QFVF1eqECPUKUYe5Yi5EFOxesYF3cW9IV1yqWAs8+FmM1aip3KokUYxjmazKnRWeHg5sMvnOKW0+Ea0aFXeYOXULuv1OvS6X24WjCAq8MABnJKbKz4NG72eGwXrkPgVLV5+SxYxVjDfS1NLSOdo3/vz+fmM4GP2U52R7z5UGMoZm0y6RM/RsT8nw2onRpsY48L6bosLbL1727lmPWn0TDFtsqHBWOx33GawBee2Usw8qM7ykQyUvHGXUXScipL22uTPGifB6GZJGmvMhYsgbI2ran3A2gtRcb9Y10KLDaeQRgSFfGZgR8JZ1J2ql7I2tOFBvRdDb9ihP6lV5AMIXd+kM8bCATkJNr/dY/1CYONMS7rP0P0nAFOAu0m/IJwiPVXLtmOJlvh0SbeQtquVHTo3ZxGPkiwww1KjlLBw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(71200400001)(186003)(2616005)(6486002)(83380400001)(478600001)(54906003)(91956017)(110136005)(316002)(76116006)(66476007)(64756008)(66946007)(66446008)(66556008)(6506007)(6512007)(8676002)(53546011)(31686004)(4326008)(41300700001)(8936002)(5660300002)(122000001)(38100700002)(2906002)(31696002)(86362001)(36756003)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dTlkSlVwbDJFN0w4L1grUXhyKytMdUY1UEptbzJHdDU2OTNtNGJFRjVaSU5q?=
 =?utf-8?B?aVVtZDBRSi90b3VEWEZhRTUrbGdsR2x2NitYeGpBLzlKUFNNMlk0RXBmNlJH?=
 =?utf-8?B?cXFNV0JSZXNtbkFSYmltRWN1UUs1REJ6SmE4WTFzV1VOcExYTmlSWGcwajBy?=
 =?utf-8?B?MWI0UmZXWm9xQUVKU2FKVXZHdlg2OTk5QUJ2Ujc0bTdFQitXYWhzeGlaY3dN?=
 =?utf-8?B?b2xHN2loMW1jSlFsanhKTnBOUU9UQWpJbVJ5NHFGRUFiYVkrRCtXMXdsbFVW?=
 =?utf-8?B?REJYU2lzRHQrYjBBOTEwL0xQeXZEUGJTRzVEVEVhYWpCTlZndDE1MnUrd2Na?=
 =?utf-8?B?RmJZYnNGTTVzZ00vZjhDdG9rOHpSbkd0L2FXdEZ2cDI2a0lZb0ZPYVdQZ1p2?=
 =?utf-8?B?UW54V1FpdytPWmVhRWVxSXgxRUV3SGRuWGpxV3ZuRGY4M2x3WDBlbkFkNUpT?=
 =?utf-8?B?K2JBQ2V6LzhXaFNpcU9CSkF5bnVlMnUwSlc5QVNlQTUrNXNWN3phVW9nczFp?=
 =?utf-8?B?RnBxNXY0Q3pwUUgyaHhvOXdHRXhHcUR5djBXVnk1eFZzUWJJcTBGK1gybWhv?=
 =?utf-8?B?S0cwVWM4QzlUY2JxdkxJMnhLMmZtTi9FMXhmdU5zMm9sQmhCNDd5ZkxGdzVK?=
 =?utf-8?B?WXI3M2krRjVqSTFCVnNFUExyMXU5UXZ0L2lnYndrYnJpcFM2Yk5pMlJxWlZw?=
 =?utf-8?B?MVp2c2lJYmxkU2dvQzR4NDd1OEY3YmUxNEFoNDhGNTE4UXBHa0tOYVdROGpt?=
 =?utf-8?B?SjJHR2RHWHJnM3BjZ1RHNmZLUitzMGxzZWpPTDJuTkc2b043OE9ZUTE5Q2Nz?=
 =?utf-8?B?cGxnVHZYSWRjZHhqWGlZT01ZcFh5U1hyMTZRYlhaU3RsZVVMWUc3bWl0NEpv?=
 =?utf-8?B?YmJ0ZGppbFVWQWtlT3hWd0E1VFV3MU5qSklnRkFqZXVxb1ZkdTJKbEQxRjJB?=
 =?utf-8?B?My9sQ2hlK3U0WitlSVA0dDJtQ251RUNYOXJCc1d2ZEpuekpFdjA1RFUxc0c5?=
 =?utf-8?B?NXV0VGozc05BTzBuVkg3ZjI3bU9ITUllZmFlclNVODFuWjVSR2huM0F3REVn?=
 =?utf-8?B?S0ZuU2k3MFk1SjhYZFNDcE9wQUVLR0xrY3YzWWMvcWM0TzkxQ2NrcWhadXRG?=
 =?utf-8?B?Y1RuczB0VVZIdWI0VTl6ZGcreXljdHcyWXhmNkk0bmZFSi9pdnozdW9XN1BB?=
 =?utf-8?B?Q28wZEIwMy9UdGNSa0RBbmtqUWhmbHZCUTZPZTJmMWZsaWZTWmI3REpkVG9I?=
 =?utf-8?B?Yy9pMkVoRnFTSzVLTUJBcDdTcWZuUVZCRkROZVlabUVsV2ZPRkpPY3ZYdlRm?=
 =?utf-8?B?QjgxZ2dkTmN6Z2N2Yy81WFRLakVPWldpem5hT3VmSTlvR0hPRTJQcWh6SzI0?=
 =?utf-8?B?cGlqWUc3Ui9wckpWVEdERWU4ZzFvN2VTeXpWV3U0ZEpvWlFpOVVmZ1paVVlT?=
 =?utf-8?B?eTJjZXZNamdFc1ZjZEVNQ3pQVzdTUmdnb084aWpFY3RGeFNmTmNrQmU3OWFk?=
 =?utf-8?B?L0R1SEdBNWJFeGhlNzZxdHN2TzJNUmJndHJ6enMweEZSRGxBQ1dwQTl5bGds?=
 =?utf-8?B?OW9WK2hvaDNYbFBCcE9udFROQ2YyQUFsd01HQnVmcDVNQ3dFR1R0MGFBcENH?=
 =?utf-8?B?NTByS1NRU1hoZ3BrZ3h3bjlaN2hWNjFVK2w4RFZrdkhoYmZLalovSWUrMjNU?=
 =?utf-8?B?MXVkeHZpaDNsUE5kYk5tdkpydmZUVVdscTlwTXl5N2tmaDNVdTZ2Z1B0ZmRW?=
 =?utf-8?B?clJRKytoTHRMclREQ2p4d1ZtdEwzOVFaMjZrczJtZnJDWitRbEVnRmptZEds?=
 =?utf-8?B?N3RuRGU3RVRLeGdsb3R0eHNRSjJYKzFjWjQ0VFJQMzU2cVlTelI1dWUxV0I0?=
 =?utf-8?B?YmVsWXp6Snp6YXV2TkJYRjExWW1YYkF3S2VBSFRmY2NxN3FjVEppS3htQXhv?=
 =?utf-8?B?bFdaeGdVSy9NeEZKcEtobVVsZ0U0ZFd2Z2RpUTVDN045dmRJb2xUWVlITFc2?=
 =?utf-8?B?amRDcWhzMU9VWU9XMW16WDZ3Q1N1OHVyM1VuT1hWU0VDMXJOL3VqU3ZYRGs4?=
 =?utf-8?B?aWMyVzhEcU5KYmxEcGdNeFRRNm14YlVXN0xVTXZaM0pCZ2NyaXJBQzYyMG03?=
 =?utf-8?B?MkNRWjJiM1FRd01FNXFvYm5STTgydzNKZTBRYnVBMFlKSjFLS3l3UDVSWDVx?=
 =?utf-8?Q?LSK6oUjpsvxb5SkP9HruPf7mIi/j+/eBMgGHYsz471RS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E8E166CC071D04197D4CE39EBB9DBAE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a6e75f-1090-4370-048c-08db26c3e2f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 08:44:57.1021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fo5Tm7f9no6t++ZNa6u5qLBtoPO/uyA/5nqFJ3OGyrpDAPaNTFQZPemVtYEBff4QuMKtRrQs8q2iqlfyPZMnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_014500_810806_85A8273E 
X-CRM114-Status: GOOD (  22.87  )
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

T24gMy8xNi8yMDIzIDQ6NDkgUE0sIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4gQ29tbWl0IGQ3YWM4
ZGNhOTM4YyAoIm52bWU6IHF1aWV0IHVzZXIgcGFzc3Rocm91Z2ggY29tbWFuZCBlcnJvcnMiKSBk
aXNhYmxlZCBlcnJvcg0KPiBsb2dnaW5nIGZvciB1c2VyIHBhc3N0aHJvdWdoIGNvbW1hbmRzLiAg
VGhpcyBjb21taXQgYWRkcyB0aGUgYWJpbGl0eSB0byBvcHQtaW4NCj4gdG8gcGFzc3Rocm91Z2gg
ZXJyb3IgbG9nZ2luZy4NCj4gDQo+IFRvIGVuYWJsZSBwYXNzdGhyb3VnaCBlcnJvciBsb2dnaW5n
Og0KPiAJZWNobyBZID4gL3N5cy9rZXJuZWwvZGVidWcvbnZtZTAvZXJyb3ItbG9nZ2luZw0KPiAN
CmNhbiB3ZSB1c2UgMC8xIGJhc2VkIGVuYWJsaW5nID8gWSBhbmQgTiBzZWVtcyBhIGJpdCBvZGQs
DQp1bmxlc3Mgd2UgY2FuJ3QgZm9yIHNvbWUgcmVhc29uIC4uLg0KPiBUbyBkaXNhYmxlIHBhc3N0
aHJvdWdoIGVycm9yIGxvZ2dpbmc6DQo+IAllY2hvIE4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy9udm1l
MC9lcnJvci1sb2dnaW5nDQo+IA0KPiBCeSBkZWZhdWx0LCBwYXNzdGhyb3VnaCBlcnJvciBsb2dn
aW5nIHdpbGwgcmVtYWluIGRpc2FibGVkLg0KPiANCj4gQ09ORklHX05WTUVfRVJST1JfTE9HR0lO
R19ERUJVR19GUyBuZWVkcyB0byBiZSBlbmFibGVkIHRvDQo+IHRvIGVuYWJsZSBwYXNzdGhyb3Vn
aCBlcnJvciBsb2dnaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxhbiBBZGFtc29uIDxhbGFu
LmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvS2NvbmZp
ZyAgICAgICAgfCAgNiArKysrKysNCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICAg
ICB8IDEzICsrKysrKysrKysrLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jICAgICAg
ICB8ICAxICsNCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLWRlYnVnZnMuYyB8ICA2ICsrKysr
Kw0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgICAgIHwgIDggKysrKysrKysNCj4g
ICA1IGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbnZtZS9o
b3N0L0tjb25maWcNCj4gaW5kZXggNzBmMzgwYzFjY2FlLi41Njc3MjkyNzI3YmYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvS2NvbmZpZw0KPiBAQCAtMzgsNiArMzgsMTIgQEAgY29uZmlnIE5WTUVfRkFVTFRfSU5KRUNU
SU9OX0RFQlVHX0ZTDQo+ICAgCWhlbHANCj4gICAJICAgVGhpcyBlbmFibGVzIE5WTWUgRmF1bHQg
SW5qZWN0aW9uIHRocm91Z2ggZGVidWdmcy4NCj4gICANCj4gK2NvbmZpZyBOVk1FX0VSUk9SX0xP
R0dJTkdfREVCVUdfRlMNCj4gKwlib29sICJOVk1lIFBhc3MgVGhydSBFcnJvciBMb2dnaWduZyIN
Cg0KL1Bhc3MgVGhydS9QYXNzdGhyb3VnaC9zID8NCg0KPiArCWRlcGVuZHMgb24gRkFVTFRfSU5K
RUNUSU9OX0RFQlVHX0ZTDQo+ICsJaGVscA0KPiArCSAgIFRoaXMgZW5hYmxlcyBOVk1lIFBhc3Mg
VGhydSBjb21tYW5kIGVycm9yIGxvZ2dpbmcuDQo+ICsNCj4gICBjb25maWcgTlZNRV9IV01PTg0K
PiAgIAlib29sICJOVk1lIGhhcmR3YXJlIG1vbml0b3JpbmciDQo+ICAgCWRlcGVuZHMgb24gKE5W
TUVfQ09SRT15ICYmIEhXTU9OPXkpIHx8IChOVk1FX0NPUkU9bSAmJiBIV01PTikNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPiBpbmRleCBjZjVkYjE5ZDUwYTUuLmViOGQ3Y2FmMjg4NyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0K
PiBAQCAtNjY2LDYgKzY2Niw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2NsZWFyX252bWVf
cmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiAgIC8qIGluaXRpYWxpemUgYSBwYXNzdGhy
b3VnaCByZXF1ZXN0ICovDQo+ICAgdm9pZCBudm1lX2luaXRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVz
dCAqcmVxLCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQpDQo+ICAgew0KPiArCXN0cnVjdCBudm1l
X3JlcXVlc3QgKm5yID0gbnZtZV9yZXEocmVxKTsNCj4gKw0KPiAgIAlpZiAocmVxLT5xLT5xdWV1
ZWRhdGEpDQo+ICAgCQlyZXEtPnRpbWVvdXQgPSBOVk1FX0lPX1RJTUVPVVQ7DQo+ICAgCWVsc2Ug
Lyogbm8gcXVldWVkYXRhIGltcGxpZXMgYWRtaW4gcXVldWUgKi8NCj4gQEAgLTY3OCw4ICs2ODAs
MTEgQEAgdm9pZCBudm1lX2luaXRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3Qg
bnZtZV9jb21tYW5kICpjbWQpDQo+ICAgCWlmIChyZXEtPm1xX2hjdHgtPnR5cGUgPT0gSENUWF9U
WVBFX1BPTEwpDQo+ICAgCQlyZXEtPmNtZF9mbGFncyB8PSBSRVFfUE9MTEVEOw0KPiAgIAludm1l
X2NsZWFyX252bWVfcmVxdWVzdChyZXEpOw0KPiAtCXJlcS0+cnFfZmxhZ3MgfD0gUlFGX1FVSUVU
Ow0KPiAtCW1lbWNweShudm1lX3JlcShyZXEpLT5jbWQsIGNtZCwgc2l6ZW9mKCpjbWQpKTsNCj4g
Kw0KPiArCWlmICghbnItPmN0cmwtPmRlYnVnZnMuZXJyb3JfbG9nZ2luZykNCj4gKwkJcmVxLT5y
cV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+ICsNCj4gKwltZW1jcHkobnItPmNtZCwgY21kLCBzaXpl
b2YoKmNtZCkpOw0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChudm1lX2luaXRfcmVxdWVz
dCk7DQo+ICAgDQo+IEBAIC01MTgzLDYgKzUxODgsMTAgQEAgaW50IG52bWVfaW5pdF9jdHJsKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gICANCj4gICAJbnZt
ZV9kZWJ1Z2ZzX2luaXQoJmN0cmwtPmRlYnVnZnMsIGRldl9uYW1lKGN0cmwtPmRldmljZSkpOw0K
PiAgIAludm1lX2ZhdWx0X2luamVjdF9pbml0KCZjdHJsLT5kZWJ1Z2ZzKTsNCj4gKw0KPiArCWN0
cmwtPmRlYnVnZnMuZXJyb3JfbG9nZ2luZyA9IGZhbHNlOw0KPiArCW52bWVfZXJyb3JfbG9nZ2lu
Z19pbml0KCZjdHJsLT5kZWJ1Z2ZzKTsNCj4gKw0KPiAgIAludm1lX21wYXRoX2luaXRfY3RybChj
dHJsKTsNCj4gICAJcmV0ID0gbnZtZV9hdXRoX2luaXRfY3RybChjdHJsKTsNCj4gICAJaWYgKHJl
dCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9pb2N0bC5jDQo+IGluZGV4IDcyM2U3ZDViNzc4Zi4uNTVkM2Y4NjUyNGJmIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTI0Myw2ICsyNDMsNyBAQCBzdGF0aWMgaW50IG52bWVfc3Vi
bWl0X3VzZXJfY21kKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLA0KPiAgIAljdHJsID0gbnZtZV9y
ZXEocmVxKS0+Y3RybDsNCj4gICANCj4gICAJZWZmZWN0cyA9IG52bWVfcGFzc3RocnVfc3RhcnQo
Y3RybCwgbnMsIGNtZC0+Y29tbW9uLm9wY29kZSk7DQo+ICsNCg0Kbm8gd2hpdGUgaW4gcGF0Y2gg
cGxlYXNlIC4uDQoNCj4gICAJcmV0ID0gbnZtZV9leGVjdXRlX3JxKHJlcSwgZmFsc2UpOw0KPiAg
IAlpZiAocmVzdWx0KQ0KPiAgIAkJKnJlc3VsdCA9IGxlNjRfdG9fY3B1KG52bWVfcmVxKHJlcSkt
PnJlc3VsdC51NjQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS1kZWJ1
Z2ZzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLWRlYnVnZnMuYw0KPiBpbmRleCA4N2Y3OGI4
NjQyMjUuLjA5OTUzNjI2YTFkZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZt
ZS1kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS1kZWJ1Z2ZzLmMNCj4g
QEAgLTc3LDQgKzc3LDEwIEBAIHZvaWQgbnZtZV9zaG91bGRfZmFpbChzdHJ1Y3QgcmVxdWVzdCAq
cmVxKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3Nob3VsZF9mYWlsKTsNCj4g
ICAjZW5kaWYgLyogQ09ORklHX05WTUVfRkFVTFRfSU5KRUNUSU9OX0RFQlVHX0ZTICovDQo+ICsj
aWZkZWYgQ09ORklHX05WTUVfRVJST1JfTE9HR0lOR19ERUJVR19GUw0KPiArdm9pZCBudm1lX2Vy
cm9yX2xvZ2dpbmdfaW5pdChzdHJ1Y3QgbnZtZV9kZWJ1Z2ZzICpkZWJ1Z2ZzKQ0KPiArew0KPiAr
CWRlYnVnZnNfY3JlYXRlX2Jvb2woImVycm9yLWxvZ2dpbmciLCAwNjAwLCBkZWJ1Z2ZzLT5wYXJl
bnQsICZkZWJ1Z2ZzLT5lcnJvcl9sb2dnaW5nKTsNCg0KaWZmIHBvc3NpYmxlIGtlZXAgaXQgdW5k
ZXIgODAgY2hhci4uDQoNCj4gK30NCj4gKyNlbmRpZiAvKiBDT05GSUdfTlZNRV9FUlJPUl9MT0dH
SU5HX0RFQlVHX0ZTICovDQo+ICAgI2VuZGlmIC8qIENPTkZJR19GQVVMVF9JTkpFQ1RJT05fREVC
VUdfRlMgKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaA0KPiBpbmRleCA1M2Q2MTcyM2NhNTkuLjc0YmRmNWZkOWFiZCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaA0KPiBAQCAtMjM5LDYgKzIzOSw3IEBAIHN0cnVjdCBudm1lX2ZhdWx0
X2luamVjdCB7DQo+ICAgc3RydWN0IG52bWVfZGVidWdmcyB7DQo+ICAgCXN0cnVjdCBkZW50cnkg
KnBhcmVudDsNCj4gICAJc3RydWN0IG52bWVfZmF1bHRfaW5qZWN0IGZhdWx0X2luamVjdDsNCj4g
Kwlib29sIGVycm9yX2xvZ2dpbmc7DQo+ICAgfTsNCj4gICANCj4gICBlbnVtIG52bWVfY3RybF9m
bGFncyB7DQo+IEBAIC02MTgsNiArNjE5LDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2Zh
dWx0X2luamVjdF9pbml0KHN0cnVjdCBudm1lX2RlYnVnZnMgKmRlYnVnZnMpDQo+ICAgfQ0KPiAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3Nob3VsZF9mYWlsKHN0cnVjdCByZXF1ZXN0ICpyZXEp
IHt9DQo+ICAgI2VuZGlmDQo+ICsjaWZkZWYgQ09ORklHX05WTUVfRVJST1JfTE9HR0lOR19ERUJV
R19GUw0KPiArdm9pZCBudm1lX2Vycm9yX2xvZ2dpbmdfaW5pdChzdHJ1Y3QgbnZtZV9kZWJ1Z2Zz
ICpkZWJ1Z2ZzKTsNCj4gKyNlbHNlDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lcnJvcl9s
b2dnaW5nX2luaXQoc3RydWN0IG52bWVfZGVidWdmcyAqZGVidWdmcykNCj4gK3sNCj4gK30NCg0K
c2luY2UgdGhlcmUgaXMgb25seSBvbmUgY2FsbGVyIGZvciBhYm92ZSBmdW5jdGlvbiBjYW4gd2Ug
dXNlDQppZiAoSVNfRU5BQkxFRCguLi4uKSkgPw0KDQo+ICsjZW5kaWYgLyogQ09ORklHX05WTUVf
RVJST1JfTE9HR0lOR19ERUJVR19GUyAqLw0KPiAgIGJvb2wgbnZtZV93YWl0X3Jlc2V0KHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwpOw0KPiAgIGludCBudm1lX3RyeV9zY2hlZF9yZXNldChzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsKTsNCj4gIA0KDQotY2sNCg0KDQoNCg==

