Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C744DC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/ghtAF9f19wyD0t/xFnkJMhDBpfHEOelpLcsj2nX+o=; b=JRMH2FYa9OdS+JuYx7LOPD0j6Q
	qQFgehkFC+RDK9+xiDye5cNa7BpNztq/edBm68zYhmXq4YAK47ffEJ1wJuD0JN8CMJPkGexJUzNIM
	wnsAaF08B45DRuMuUHC+r1kos6F+Q0QfV2ajNnFZqTcznan3Ii9cGtGNmMBRzHoz1XsLjA70dFDDV
	A6iF0OADSfp6dGuPULl64+r2BqMPbw0Pjb4R2S76W3x/M0vDFMTlGFMejsRV4lt1ipdGZ0x6iF9PP
	caEfEQRDi2vfH94Aq9grg7+KsLCg1Z9HsF0+BVw1+SzctT8rp84211BXios+hW8vssvd2SefaOEIc
	e4HtLEgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfSzx-0032pz-00;
	Thu, 23 Mar 2023 22:01:29 +0000
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e88::62f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfSzt-0032pW-0M
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 22:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv0ENqMU6gNEGbKFPbQOCEDWAIlzqzZY6XMtwFMXNYMiJUx1Vb9UE0sBj3qRGwBxQfiuU9dTaF/FY8q/fkhBtVUmFrDrHAfKQo36irWNtqorQu9ZlGi3rHXZYq26Ly21mK6j4iEiD7R28YOTTOZgVP1iAAeiWQqSpJ505Q11Vu1aiXWRfMt4UI/12rjVkrsVPc35nag05rfxKpGI+DPE8qB4MP7nhZnlAujcmPhZqLvXjXruVnHmNWm6QWKnFP7sRfuhFYxWpzyaYNcRWyJ/7sXPfVgwN+9bGi9PccpWU9hPotlF/zMJCuCpQgYnnMHQYpN6ODOjiTt55+Ojt4/Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ghtAF9f19wyD0t/xFnkJMhDBpfHEOelpLcsj2nX+o=;
 b=FU9HejpTL+xxnYlO6sG5JuTgv8juYgx4xawRZu6p6sXz1zUQrgH76wE4Imc6H3ycPwyGhXPWub+/zj4wcC4JDwpphMOyACVQ8CTjfo6xcKSeXU+zobMDP0xyy9JuvoZmIDob6f/uwCERbqUs9EUCqXJsMOASuMxqW0YMAfo8FPhzMYO7gD3rj58F0V9CGXk3c2cV4AV7AbLyrJpxZLH6p3Pc99ipgLVbvOmCrPiL6JoQ6THFnTHPPcEfblf+BKUqU2JKBnXYvL2nMbb1E9uL5V1/6MRR15F6GFYux1qsau3xj7FSme1sY8WslKT1f3vkdhXTnLCTBC0xcWTC/PWYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ghtAF9f19wyD0t/xFnkJMhDBpfHEOelpLcsj2nX+o=;
 b=CVZV54R0m1Ljx2CQkCeChTkkUWXww9q2lnNt0k95nIXTopppFCDSHZzoBedCR7JuMYYTMcZzeLIn2ycY4xQwgNZkn3rA0V7FdYuk2/xK1YDi64hsQT1x6OS//1MALv8oPaKHq3CtmlV/PwxkFE9Vn4UeXgUenw6Gi7bJMccbkYbxLcTSdUKUN8BZHe8LBMjcU4PI/TdtcQwkDLOox+ylna8vvHLQeVPl2tyH8Knv2T2j1E4zaVvXv2Yxpx8YIZdOuR1WSAG23XwOyjNzqxe01NDd4f5oK2460VUMQRJFP6xl/nfLjWjVM77spMqfYisNMEeMCcP62xofzs35Z3uUTg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 22:01:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 22:01:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 5/9] nvme-core: use normal pattern
Thread-Topic: [PATCH 5/9] nvme-core: use normal pattern
Thread-Index: AQHZXTjWtasgjTin0UuPlcWctrH8j68IpXCAgABGGwA=
Date: Thu, 23 Mar 2023 22:01:19 +0000
Message-ID: <1d12dfa4-6dd8-5d95-52b9-6702bf8678ad@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-6-kch@nvidia.com>
 <ZByRXlzJg2XaZAXh@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZByRXlzJg2XaZAXh@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5105:EE_
x-ms-office365-filtering-correlation-id: f3cefaa3-afa7-4879-05cd-08db2bea21d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vaxXlH6LVdL+YbmJPUX7dXQgQEr11OCwnM1ZfEikDhgFvOaRq1CSzcghSRgL6zUpOhYH1YQngSnaFz+tx/AJupn1IurwpIYreaO9zjgza17oD+LYZXAX6HN792V4FwCxDXvSsJOlg2N+GsK2Mp5mxCh0hZ4x/DamM+F11V6+/8cuMHqT1sog02ee3RHXcHo80JLUXdd3jiVAaoW6kAyUFKz8+qX1bwK2AXOJD9vxT5cFQ8sYJjXvVgDuuwcobgZngiSg5W7qSrLlaeAJxeuU354sBcur2RqBshm9R+L5Mqvmkw+t95ZtsKVQu4qpj7ako0ppqh/0K3KFhIfb/5xInzp59DakeeZZ3U+ThNZnrJ3QIjPEbONb6uoera92nhKbcGzFfPzhD/Xdh9W7G0eGIzvfY/eOdD2np9kAi8knSCRAWM/UUoQuiXZNvriu4iVnbtSvd93WI0LcQqhyGOM/Py4Ycg911MR6ac1+p/dKh7GzBtadIQ9KajfKBwSWvIXpRa3VPsSHKlMBCVDZnE1JvDOC2tagWyUafrhhH7HLtxdy+uXw/rBGshlQBzw6hPqXDEQ+qelHqCrOv07k1lqgCfE6HPYsg6o8Q3AOQ+7X3Sy02+GhXYFUpAWlgcEEp57SI2Y0QCiaO86VYYHgTIBMqbKyUHKFnq0EKDiA5aNTDdeP4GTWOXQNfgNYW9+D7LafgbuBy3MNUPqhZbEVXIyQBDxW2O8flBuLNuOsJRRBrOilz4FGpoQRkqy3xdcWYe88uDfwd+7HdpP35MWe6SZXqw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(86362001)(31696002)(36756003)(66446008)(38070700005)(66556008)(122000001)(64756008)(38100700002)(41300700001)(2906002)(4744005)(66476007)(5660300002)(8676002)(4326008)(8936002)(66946007)(2616005)(53546011)(186003)(6506007)(6512007)(54906003)(91956017)(110136005)(478600001)(76116006)(316002)(6486002)(26005)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NVE2T2d1YWRPU2J2Vld4RzR2T2JJRGl2S3JPMUZRZHNFTnc4Vm5NVjN1bnEw?=
 =?utf-8?B?K0JOS3VVNzBIQWhvZy9RZkZzRHlRU1lKb29rMTBwd0NwVmVZdnpHMDFUQ2x6?=
 =?utf-8?B?SzQ4L3AwL2doYS9XdjU2Y1pHL2pxSjZzalM0NEVzTVAvNmF0cFUrTnlGVWp6?=
 =?utf-8?B?QmQzd0xhSWEyNkJiUitYV1hIQkZEbTZFSGtVaUo4MGx1UDlyQzZJUFJlcHdR?=
 =?utf-8?B?VHNnV2RYWHFSaWVPUXl3REF6dWM5SFArWWtIUW9Od2RLVE1ncVhyMk4zZE9s?=
 =?utf-8?B?ZjkzdHVuVzJLelBwNlZ4YWxaR0prR0REWVp2SGRBVHVVL0dCaEFiSHIyY2Nh?=
 =?utf-8?B?Yk1yZnBnazZFU0haK2R1eUs2bTdvdlcwanJoSnVzdmNRVktpbGVJS1VaVERr?=
 =?utf-8?B?ZktLeVovTHYwVnJlZGF1RXdaSkdkQkpYNGp0RFJIV3hGcTBzYUFVWlFtOStv?=
 =?utf-8?B?NHZkSFFSUFFnSkkxRHFMZlJhajFydVdOSlBtc1MxQ2RkSmN2SFFDQjdJQUhw?=
 =?utf-8?B?WXFsZ24ydFRxTWptSWJCb2Y3R3c2aXFnZG5aazJDZWs2SFdna3k1OEY4c3Zx?=
 =?utf-8?B?TFE4Mnc5VHZydWdPamxvZXM5Q296RnZqemx4U25WL0NOYSsyUFU2WEJ5SU1y?=
 =?utf-8?B?Ui9mUTFIRU9tdG9DaC9OWVErNGtsREN4ajJ6cGVOdkExZFhyS1h0dEMxK2Q2?=
 =?utf-8?B?S1pOYlpMSitUbnhNM1d3YmJMTkRVWDV3eFUyazEzRVdUaEpuYWhQNXo4YUNX?=
 =?utf-8?B?dVJySlU1NTMwRlhWL2huOHJiUzlqb1cwc2FQWmdCWk9hQWFmZ2dsMTRsMlBC?=
 =?utf-8?B?SEdUd3lLUXBZbUczUzJmRDQwQzRPTkJNOURzYUp5V1p1aDJZdUEzcjRhcTlD?=
 =?utf-8?B?SEMwZE4xaldCQlhsNjd6ZDdZZDQ5b280cGtWMUl1QjhiZ3Rjelhnb1hMQlpE?=
 =?utf-8?B?MVhJQkE4VEVGVTd0ampLSHR0bTJiUkdmK0lKNVJhS2UxS1F1aXRqdEhVV0g3?=
 =?utf-8?B?S1NCYnFwalBtQ3plSG13bEZyYlFCY0d3ZzdxRS9YOURpUWFqaG1iU2pZOG1J?=
 =?utf-8?B?MnJJWlRFUXNmYS9MeW4xUFYrS2FodCtoeDhVM0xxNFZ0aWtWandKNUpaemxj?=
 =?utf-8?B?S2dwR1FiV3VLWHZ0ZFdKYjRZL2hyWDVzeGprbjNqT3VZSEJaQ004N3RrSUVm?=
 =?utf-8?B?UEdLRVcvT1Q2QXJheXJLZDY2SlJlLzV5aGZHYk1rTk9BMTFJSzVOSm5jSFR1?=
 =?utf-8?B?WkxjeGZFWHFxVllJTU1mN01VazVpZU5TUXJXWDh5bjdBS2g1NHh3YUJLTTB0?=
 =?utf-8?B?SlE1QXNDdEp6U0lSZndHcXJVdG5DU0ZwZmNVSm9NQVMyeWw4aWlIRzY2UHFz?=
 =?utf-8?B?TE1Jb3drS1psZzFkS0ZKZXowWGFwdUlTQjMwa3pVZUdyUjMvWFRYbjhFUDJ3?=
 =?utf-8?B?QTd1MnYwZkVvayttTUF5WDl1b1EyeVRyUk85TlQ1cTdYSHNRTzVhQ213M0w1?=
 =?utf-8?B?MHdNeFI2b1BWK1FRZjNiaDAxSWVheTZrdkFWTEFCakFtZmgyVkFVaWVjNmZV?=
 =?utf-8?B?RWJKV1JLdnE2UXpiWnlzaTkrdTdkODVzVWdFNlA5YW16K3J0TiszS2F6N3Nr?=
 =?utf-8?B?cVB0TEU5NzRqeWk0akRrcFpRam1mcG9paFlMVGowdnM2a3RQZWhqcExZdXkz?=
 =?utf-8?B?c0M1Rm5VQVBWbXVDK2dsdElGdS9xbWhmVUVDL1ZkWXVtNVRRUHJnbVJMNWpU?=
 =?utf-8?B?K0tGSlUzMGw0Tm1rSUVMNEJLdHFjU3FGZU92TjY0RGE5Zlk1L2FMUmpobHVB?=
 =?utf-8?B?VU54ZlJNbXZQYnlnbWxSVFkwQ2pSNVdUTjJKR2FadWtrSXpxTzJlS1ZYenIv?=
 =?utf-8?B?NUhGQ1cwS0pzNVBHWjlSV3NaVm1ucU0wOG9rQStudlZINnczN1JsN25kS3Ni?=
 =?utf-8?B?UVRVb1llM3htblc3Y1FYTVpCcDJKSk9aNWZJa2VVbTJneFlMODJHT3FJSlpy?=
 =?utf-8?B?YnNlWlArb2xTOXA1UmFCdWRHVEl1alBKcnhDMEo3V1BkTXNWTlo4L3JXNEti?=
 =?utf-8?B?WmFDcWVDaU9zblB5dVdrdTE4WTFGeVplSzhDS0JuWGdzbFJIT3drOVhDUi9E?=
 =?utf-8?Q?4xpJUCqji1LNRLwT+RT9e0v9H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23BD661235D6494FBA0975F74F18D505@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cefaa3-afa7-4879-05cd-08db2bea21d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 22:01:19.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtKfoVB6zOxbfFocea0aktrJry3qhaG493P/tD495iT00mbt5TjpGjCjzniZxsRuaJKxmXk+e62ozuCUmsJdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_150125_487365_3C9F43F7 
X-CRM114-Status: GOOD (  13.15  )
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

T24gMy8yMy8yMyAxMDo1MCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgTWFyIDIyLCAy
MDIzIGF0IDA4OjM2OjMyUE0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFs
dGhvdWdoIHJldHVybiBpcyBhbGxvd2VkIGluIHRoZSBzd2l0Y2ggLi4uIGNhc2Ugd2hlbiBmdW5j
dGlvbiBpcw0KPj4gcmV0dXJpbmcgdm9pZCwgaXQgY3JlYXRlcyBjb25mdXNpb24gZm9yIGZ1dHVy
ZSBjb2RlIHdoaWNoIGlzIGRlc2lyYWJsZQ0KPj4gcGF0dGVybiB0byB1c2UgZm9yIHN3aXRjaCAu
Li4gY2FzZS4gUmVwYWxjZSByZXR1cm4gaW4gdGhlIHN3aXRjaCB3aXRoDQo+PiBicmVhayB0aGF0
IGlzIHN0YW5kYXJkIHBhdHRlcm4gZm9yIHRoZSBzd2l0Y2ggLi4uIGNhc2UuDQo+IFRoZSBwcmV2
aW91cyBwYXRjaCByZXBsYWNlZCAnYnJlYWsnIHdpdGggJ3JldHVybicsIGFuZCB0aGlzIG9uZSBk
b2VzIHRoZQ0KPiBvcHBvc2l0ZS4gV2hhdCdzIHNwZWNpYWwgYWJvdXQgYSB2b2lkIHJldHVybiB0
aGF0IG1ha2VzIHRoaXMgYSBzdGFuZGFyZA0KPiBwYXR0ZXJuPw0KDQpSZWdhcmRpbmcgcHJldmlv
dXMgcGF0Y2ggOg0KSW4gc3dpdGNoIGNhc2UgaWYgd2UgYXJlIG5vdCByZXR1cm5pbmcgYW55IHZh
bHVlIHRoZW4gaXQgbG9va3MNCm9kZCB0byB1c2UgcmV0dXJuLCBjYW4gd2UgcGxlYXNlIHNob3Vs
ZCBhdm9pZCBzdWNoIHBhdHRlcm4gYW5kDQp1c2UgYnJlYWsgPw0KDQpSZWdhcmRpbmcgaGlzIHBh
dGNoIDoNCndlIGFyZSByZXR1cm5pbmcgdGhlIHZhbHVlIHNvIEkga2VwdCB0aGUgb3JpZ2luYWwg
Y29kZSwgSSBjYW4NCmFkZCBicmVhayBldmVyeXdoZXJlIGluIHRoaXMgcGF0Y2ggaWYgbmVlZGVk
LCBwbGVhc2UgbGV0DQptZSBrbm93Li4NCg0KLWNrDQoNCg0K

