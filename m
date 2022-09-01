Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F1ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6QvfBYhN9pBP5s0TSg2eXFTAWo12WJ53vWRKmP8sso=; b=WP8E2t3m3CRFMQMq5ZcwcyOLcK
	Fx8pxGhWF903Cp6cfbrUhDKoQVFJ3D9knLx5mwuxhbwn94HqoieDwuze70yUmbyXeqR5v6jZTB0Ij
	k/WO2lSGlNjs6cYPuHpICgtb1pbgvA1PZlJEpN+sIR8KryZb8uenyluQjO3tFlVLonZ3xbTR0b8TP
	UxDtTKy5MNTDXRLOkhf7xvc58fzNfo9Nz9U+LkEHylLZFxdy+ExKZHxJUnGe2DLFnzic+QwfH8zDa
	ZJMFbqOgfbFxGEvWe1zGB4G36B4o0TseHZwQupgbZqghox0a206m9OJFhKaeyM/xNo+xJZ3wykXzr
	WjJfG6PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTjdp-00BlpR-6l; Thu, 01 Sep 2022 12:49:53 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTjdl-00BloP-JR
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 12:49:51 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281AbcTq004167;
	Thu, 1 Sep 2022 08:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=O6QvfBYhN9pBP5s0TSg2eXFTAWo12WJ53vWRKmP8sso=;
 b=Yyf7//02B784+Cg62dZCqGikDKA20UlKabuojW0AuxzbLPEP9atkF8cetZPnVEjtL5MI
 JCPO8SAblA0DBPk/+/1hzpumJCSF+fiNb7T6uiQB9j8Y3f5VqmcXc8sHkrmYl09vYEKy
 xSriV2AlzH6LaZWbtLTk0wPMMILXLmvpn3E+4KvPFJwmHNk3uQJQQRqpFRmN/be4gU6c
 YYsQIdNQhPwqXB7IRBNRl/wOfIcdLJjmDZpzlyFVLnKNwcswXDtEeUE1KspAQrDombMY
 bKmSeIAC2/X0m7e2ReY1cvBtlObnW5wmboPuI90TTcq5pjeS52ynS6atHzezQd/gOkyF 3g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3j7ee0f39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Sep 2022 08:49:24 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281CYO1Y013904;
	Thu, 1 Sep 2022 08:49:23 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3javkkgfdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Sep 2022 08:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLc3W/+UyTeqk4NrDiVd7feNvCv9ngXUuh00BS4/aDrBkgjkKaOr/7t6fHHFD4ctRk45kaHXbct07c05WLU9pYD3P2NyzkljCXEWSaGuEIQ5ppFlCMYCUN3NwNmOqjx/bR0c2Pgm2uN4BFWjYIyRtunbSgb9ph9GdgWUoILdKzzrJBYzGOM/GW/2ez6J8cSQFWn0K6DOW/G0R2ZIEn1/QctMd9Usb2IcG1yAp7kVsjTIGr8GIItdVV3XWy0LOPFw6PpYAnup3PcOfmQssjpnlLgUAq8YkCuO2w7ESv0Lu0q8VxawtbOXFMesS1sgTDoCgipNl6n+enVwmZl1yWHBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6QvfBYhN9pBP5s0TSg2eXFTAWo12WJ53vWRKmP8sso=;
 b=T+C9Nfql1pzm0ROw1PPGEK+EApN+V6lzOUxa9+urAkrm7g5ACFdoUY2vwlsLIc2kTB6BwlxdK71R70IrQn5Az0T0iyK8odK4RK/a4Ye950ecWUf5YoViklfsqf0KsYJrIV4lNL8dlEEGLi7sN0tMeYr55i0m/B7goHebSjqQqK4ATPllPB9+fQJYjfGuDG0BmBwNGpaWIor7nTprnqn6hBFA/ObhATSdRqGuwEPJHv+80GhOv2ZZBVssY1eTXbSri+X+CsGN4FrhY76GAEAGBrJotS1/3HLUfuvFBADySVmxmnczDDaibQiyLgkGAg/7RsS0tLqgZyVcF99efL70Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB3855.namprd19.prod.outlook.com (2603:10b6:208:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 12:49:20 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5%8]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 12:49:20 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v2] nvme-tcp: Print actual source IP address in address
 attribute
Thread-Topic: [PATCH v2] nvme-tcp: Print actual source IP address in address
 attribute
Thread-Index: AQHYvXFMr1T7fUnAe0W72+OWxMJttq3KagKAgAAZoIA=
Date: Thu, 1 Sep 2022 12:49:19 +0000
Message-ID:  <SJ0PR19MB4544D615D132BDF5B8FBF141F27B9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <BL0PR13MB429186CED76BA96A2AD3D7AE9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
 <f9a17bb8-a101-6478-db5f-6573c8a472ef@grimberg.me>
In-Reply-To: <f9a17bb8-a101-6478-db5f-6573c8a472ef@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-09-01T12:35:12Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=eef5ce90-e8a5-483e-b9da-5b47bf6dc658;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 810a1c13-cc68-4798-85e2-08da8c186359
x-ms-traffictypediagnostic: MN2PR19MB3855:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wYk6hY5aRl38+CJqLSHKQk2+ivDTw2tuk0vWgvLjBUuMoU8Lun1tQCHk0YvRajE5jWgD2JsHjXhCA2R66SfBsf0QV79jH2utR1hS3Mw5PvYtZZ+TWqIMna+doJkgC+f+lVbHyD5kVb97wSBEgi/5j0hLXTv0lIKGYha+WWxclAw+LJMbDSfFBzbxg03Ba7/zRoDJU97qpgTojV/UpajRbSsV8wZ6iXMLsOWdzwyeuc6inXxDrA1OOo5057meNJQnm0pXskvdEotoqubgeXJ9hzE6r3UTYl70daMrrVmCdFFPxWTyxkBEk3NWB4ZsNjzUUn+7C85ph8IMYYXll3tplb34qIGGO6IY8VAUtGEMDGwULLDFSFmCPvnv0yibvkXBmXrAG6fWywHRTLymE3nS0fW3CkezHo13CYdvD4CiJuCu23ChVEdWa67gJqwkLeI7xQSIca9LFkYum45V8zfN7IgGHPFZ7zClL4IxAFEOYX/PsTjzxEVj5H8jke/mUHgNHD1D6e6psd9WTT18/vr7P8YnXTEMSbR+1aWwvJeTvMK9YM33BrFNTGor8PTLLTArJsopRx9EtHxpqMko2Tbr/P+ke7kc8EDCHQY4HUAG3r77TTnZ4AsUvSru9iR31tA1J1uo4RvUp2T/WAnGX7uh0lDyiMqME5ad6tmRUnHl3C1dFOnUxDb0j8TR8mVNh4oGxmHvATmXg7sC/dtmN30VtKc8U/8+W3i9jlesKue48o6fZ2NdMQYROPJBbwkPwIhJpZBGZsKbOMileP7Txv2t/w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(7696005)(53546011)(86362001)(41300700001)(6506007)(186003)(26005)(9686003)(38070700005)(82960400001)(38100700002)(122000001)(54906003)(110136005)(316002)(5660300002)(8936002)(33656002)(786003)(55016003)(52536014)(76116006)(4326008)(8676002)(66556008)(66446008)(64756008)(66946007)(478600001)(66476007)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UzJDbVJxNGZnOGFTVEk1N3k5K2lOZWRWL3dSVTdpYmd1NllQQWdJM0NWMEU3?=
 =?utf-8?B?eUV4ZzA0YlRWV1RLRjhpVStLVkZOYTFWRHdSN1VCb0cxUWtOeW80bmlEUkMx?=
 =?utf-8?B?dHVzMGRiaUJSM05qNElmOFRPYTQwQTE0Q0tLam5XTTJmci8yQ2Q5UHVsVDBx?=
 =?utf-8?B?KzF3ZTk1SVhqbGpLVDRnMjY1dG96WktqSDgrbVNGWEZIbWR4UGhYc1d0WHdN?=
 =?utf-8?B?UkNQOXZoNmZYNmZSRGx6WitsZWxDNm9OVFlqRGxTZmJkeStxb0Rxd0RmRjAr?=
 =?utf-8?B?cS9vQnV4RVpEUFNJRmYyWkVCRmdLb2poYkFDaWFKUnZENlVmVTVLQ1ZxbUNJ?=
 =?utf-8?B?U1BJUmdwSDE0c0FCZWJPbW5BaHB6MC9aU2JUSU5KQ2NUdVg5TC9RRXlLNUo4?=
 =?utf-8?B?WXJEQnZ1eDd3MGZsMy9DZFViZjlCaS9xL29rZzgza3AyTmNNVUw5KzdCZXNL?=
 =?utf-8?B?V25WODlLTHBIcXErWFB2V2xTczhXK1ZRT0ZhWUpra1phaTg3SkJHK3U3cm1N?=
 =?utf-8?B?SWd0Q2JPbkF2SVFkbDVncmZrOFN1cVVGbms4QWZMSEw3cUcrWVVPYUsvTElt?=
 =?utf-8?B?UHdBSXVRelZMZkdRbVRyVkRNOU9oYzk3djRPUFVxbGZLNUhFQVlPNTAraC8r?=
 =?utf-8?B?NjdSaXJOQTZTR242T0czYzVJUTgzRXdRbGdaaG9NTnM2TlFHV0FNTDJadzFx?=
 =?utf-8?B?aUpKd2xIVU1BVVg0bVJCMk9ONjNpN3JjMVFBeWVDQnhRNDV4NHZpbGFZWTlI?=
 =?utf-8?B?UERSZFRHbHVCL2JZdG10aWxoblVIRXp5ZW1CaHFLby96UDM2Z1pCOXNlc2xs?=
 =?utf-8?B?SU9WVkczMGNvK0xWb3lZRXpNMmdna04reFBTU29mUDhNeEZldS84N0V6UFNr?=
 =?utf-8?B?MUVWbmdGd0tjQW4vZkxONGJ2YTU5cmxDMElPRDdZdEFpc3J2aHZMZ1RtMVA2?=
 =?utf-8?B?RzcvaVhTYVlSQnBWQkg4cW1TSmFMZnNRN05FbVp3YmJDbXZwS0FXajhILy9j?=
 =?utf-8?B?U3dKN3Q4REY4cC9JUHhGLzFJTkpvZ3VkY2ZMamU3bEJ3VWFOOS9INlBGa1pP?=
 =?utf-8?B?WGhzU3hTVjJRcHBrZGFnbmlaZ3k2clh1dnljYXIzVWpiWEZIUmdqcjNxc1VX?=
 =?utf-8?B?QkM0T0l1ZzllMnlQVmY1Q0Y1M2V0QU81Z3JmS2xrczJWSExSelJQclRCMlJR?=
 =?utf-8?B?VzJtNDB4ZFB6ZjZuWnZ5WFFQYUk1M2dkNWFyZlJ2aG5YYnp2bFBGMWMxQkNt?=
 =?utf-8?B?Uk5LNDRZZlBHK0dPNms5WkpsdFFyWWhpQW5yWFRXanpJOVRjcDBsa0tsYlpI?=
 =?utf-8?B?czNZeFRodU5ObU55Q3FVZkRVbS9BMUdrUTZiZUpCbVFnNmZyNmdsbC9zY2gv?=
 =?utf-8?B?TTJjK3ZhemVpRXI0V3ZLakxJeVd0MXI4SytYUSs3OXRQeVNhcVVhMXVYSDJD?=
 =?utf-8?B?RzN0eVBvMGZpZXZRUXh2UVRUak9adjUxczhqMENHK1BCUlBSd0gwb09aK3BG?=
 =?utf-8?B?TnhMQjhESzhxbFUzTVhMN0dibnlYbHY5cnFuRGNNTklqcmZpbmVqWkdRZ0JJ?=
 =?utf-8?B?T2lYMEZYemM3N3MzUUVsbDNvMkNNTlcvZ3U2b1grbVBXQUpTbkRrTXJXVVBl?=
 =?utf-8?B?U0RpRVEwcjRKaHhhbWYya0ZmaUdnV2VXK0xlR0NsQ1B6RUVuc1hnNklLN3Y1?=
 =?utf-8?B?QlJFdlBuZXpWY3h6WWFmbVY5WW9NS2NIemlUcXNHUXIzcDhQVThoWXpNazhn?=
 =?utf-8?B?WXUvSWdIQkdheHZPNEtEb2kxR2VKYWl3djVaRUc5ZHpId3lpaVZxTTlyT2F1?=
 =?utf-8?B?ZjZmemNFYmRFNU5qdStSS2pNbk1NT0xIcGRNb0JyNUVCOGJxbkNrQkd3clhr?=
 =?utf-8?B?RmFkY1k5TzVOakR1NFc5RzlraUpDWjJWU2FJbnNpYmFUeE15emgxcGJ4Y2dv?=
 =?utf-8?B?aEcyL3l0V25ldWljTkt0UnhIV013Rm1BaWdxVDZhY29DUjZUcVh6MU5WMzNp?=
 =?utf-8?B?TWxLZDhTYUh5ZW9tQzNYQUh2OVBWUC9Qd1lGZ3FHOXYvTVN4bFF1U1NhVDJY?=
 =?utf-8?B?L0czWVQyWXROUjN5VTdaQVN1eC9HTTJneG1SekFVT3BiTy9KWWM3MUpmcVlz?=
 =?utf-8?Q?BNMcF0sZb5hwGYhuuhtOQmorw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810a1c13-cc68-4798-85e2-08da8c186359
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 12:49:20.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucD2+Ikft9yIsfANhTWsljW+c2Pf5nTe8EPoY2Rr5bpaW/HKXQKenh9Tk15CVnAJOR4CLOJsbrLqsaGnsa+k/QGnTL09VI5VrjbK8I6gXM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010058
X-Proofpoint-GUID: JvphgXqPKOf0YnCLzjsA7WfFLTSnkx1d
X-Proofpoint-ORIG-GUID: JvphgXqPKOf0YnCLzjsA7WfFLTSnkx1d
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_054949_860103_99DCD783 
X-CRM114-Status: GOOD (  39.84  )
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEsIDIwMjIgNzowMyBB
TQ0KPiBUbzogTWFydGluIEJlbGFuZ2VyOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gQ2M6IGtidXNjaEBrZXJuZWwub3JnOyBoYXJlQHN1c2UuZGU7IGF4Ym9lQGZiLmNvbTsgaGNo
QGxzdC5kZTsgQmVsYW5nZXIsDQo+IE1hcnRpbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBu
dm1lLXRjcDogUHJpbnQgYWN0dWFsIHNvdXJjZSBJUCBhZGRyZXNzIGluIGFkZHJlc3MNCj4gYXR0
cmlidXRlDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gDQo+IA0KPiBPbiA4LzMx
LzIyIDIyOjM4LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFydGluIEJlbGFu
Z2VyIDxtYXJ0aW4uYmVsYW5nZXJAZGVsbC5jb20+DQo+ID4NCj4gPiBUQ1AgdHJhbnNwb3J0IHJl
bGllcyBvbiB0aGUgcm91dGluZyB0YWJsZSB0byBkZXRlcm1pbmUgd2hpY2ggc291cmNlDQo+ID4g
YWRkcmVzcyBhbmQgaW50ZXJmYWNlIHRvIHVzZSB3aGVuIG1ha2luZyBhIGNvbm5lY3Rpb24uDQo+
ID4gQ3VycmVudGx5LCB0aGVyZSBpcyBubyB3YXkgdG8gdGVsbCBmcm9tIHVzZXJzcGFjZSB3aGVy
ZSBhIGNvbm5lY3Rpb24NCj4gPiB3YXMgbWFkZS4gVGhpcyBwYXRjaCBhbGxvd3MgZXhwb3Npbmcg
dGhlIGFjdHVhbCBzb3VyY2UgYWRkcmVzcyB1c2luZw0KPiA+IHRoZSBob3N0X3RyYWRkciBmaWVs
ZCBvZiB0aGUgYWRkcmVzcyBhdHRyaWJ1dGUuDQo+ID4NCj4gPiBUaGlzIGlzIG5lZWRlZCB0byBk
aWFnbm9zZSBhbmQgaWRlbnRpZnkgY29ubmVjdGl2aXR5IGlzc3VlcyBzaW5jZSBpdA0KPiA+IHdp
bGwgYWxsb3cgdXMgdG8gdGVsbCB3aGljaCBpbnRlcmZhY2UgYW5kIHNvdXJjZSBhZGRyZXNzIGlz
IGFzc29jaWF0ZWQNCj4gPiB3aXRoIGVhY2ggY29ubmVjdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcnRpbiBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3Rj
cC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgaW5kZXgNCj4gPiAwNDRkYTE4YzA2ZjUuLmFk
YmI3NjQ4M2E3NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+ID4gQEAgLTE2NSw2ICsxNjUsNyBAQCBz
dHJ1Y3QgbnZtZV90Y3BfY3RybCB7DQo+ID4gICAJc3RydWN0IGJsa19tcV90YWdfc2V0CWFkbWlu
X3RhZ19zZXQ7DQo+ID4gICAJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgYWRkcjsNCj4gPiAgIAlz
dHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzcmNfYWRkcjsNCj4gPiArCXN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlIHNvY2tfYWRkcjsNCj4gPiAgIAlzdHJ1Y3QgbnZtZV9jdHJsCWN0cmw7DQo+ID4NCj4g
PiAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJZXJyX3dvcms7DQo+ID4gQEAgLTE1OTcsNiArMTU5OCwx
MiBAQCBzdGF0aWMgaW50IG52bWVfdGNwX2FsbG9jX3F1ZXVlKHN0cnVjdA0KPiBudm1lX2N0cmwg
Km5jdHJsLA0KPiA+ICAgCQlnb3RvIGVycl9yY3ZfcGR1Ow0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJ
LyogUmV0cmlldmUgdGhlIGFjdHVhbCBzb3VyY2UgYWRkcmVzcyBmcm9tIHRoZSBzb2NrZXQgKi8N
Cj4gPiArCXJldCA9IGtlcm5lbF9nZXRzb2NrbmFtZShxdWV1ZS0+c29jaywNCj4gPiArCQkoc3Ry
dWN0IHNvY2thZGRyICopJmN0cmwtPnNvY2tfYWRkcik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4g
PiArCQltZW1zZXQoJmN0cmwtPnNvY2tfYWRkciwgMCwgc2l6ZW9mKGN0cmwtPnNvY2tfYWRkcikp
Ow0KPiA+ICsNCj4gDQo+IEZvciBldmVyeSBxdWV1ZT8NCg0KSGkgU2FnaS4gVGhhbmtzIGZvciBy
ZXZpZXdpbmcgdGhpcy4gDQoNCkkgc2VlIHRoZSBlcnJvciBvZiBteSB3YXlzLiBJIHdpbGwgcmVt
b3ZlIHRoaXMgYW5kIGluc3RlYWQgaW52b2tlIGtlcm5lbF9nZXRzb2NrbmFtZSgpIGZyb20gbnZt
ZV90Y3BfZ2V0X2FkZHJlc3MoKSBiZWxvdy4gQW5kIGl0IHdpbGwgb25seSBhcHBseSB0byBxdWV1
ZVswXS4NCg0KPiANCj4gPiAgIAlyZXQgPSBudm1lX3RjcF9pbml0X2Nvbm5lY3Rpb24ocXVldWUp
Ow0KPiA+ICAgCWlmIChyZXQpDQo+ID4gICAJCWdvdG8gZXJyX2luaXRfY29ubmVjdDsNCj4gPiBA
QCAtMjUzMiw2ICsyNTM5LDMxIEBAIHN0YXRpYyBpbnQgbnZtZV90Y3BfcG9sbChzdHJ1Y3QgYmxr
X21xX2h3X2N0eA0KPiAqaGN0eCwgc3RydWN0IGlvX2NvbXBfYmF0Y2ggKmlvYikNCj4gPiAgIAly
ZXR1cm4gcXVldWUtPm5yX2NxZTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IG52bWVf
dGNwX2dldF9hZGRyZXNzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGNoYXIgKmJ1ZiwNCj4gPiAr
aW50IHNpemUpIHsNCj4gPiArCWludCBsZW4gPSAwOw0KPiA+ICsJc3RydWN0IHNvY2thZGRyX3N0
b3JhZ2UgKnNhID0gJnRvX3RjcF9jdHJsKGN0cmwpLT5zb2NrX2FkZHI7DQo+IA0KPiBZb3UgY2Fu
IGp1c3QgcmV0cmlldmUgdGhlIHNvY2tfYWRkciBmcm9tIHRoZSBhZG1pbiBxdWV1ZSBoZXJlIGxv
Y2FsbHkuIEkgZG9uJ3QNCj4gdGhpbmsgd2UgbmVlZCBhIHN0cnVjdCBtZW1iZXIgZm9yIGl0Lg0K
DQpHb3QgaXQuIFdpbGwgZG8uDQoNCj4gDQo+ID4gKw0KPiA+ICsJaWYgKGN0cmwtPm9wdHMtPm1h
c2sgJiBOVk1GX09QVF9UUkFERFIpDQo+ID4gKwkJbGVuICs9IHNjbnByaW50ZihidWYsIHNpemUs
ICJ0cmFkZHI9JXMiLCBjdHJsLT5vcHRzLT50cmFkZHIpOw0KPiA+ICsJaWYgKGN0cmwtPm9wdHMt
Pm1hc2sgJiBOVk1GX09QVF9UUlNWQ0lEKQ0KPiA+ICsJCWxlbiArPSBzY25wcmludGYoYnVmICsg
bGVuLCBzaXplIC0gbGVuLCAiJXN0cnN2Y2lkPSVzIiwNCj4gPiArCQkJCShsZW4pID8gIiwiIDog
IiIsIGN0cmwtPm9wdHMtPnRyc3ZjaWQpOw0KPiA+ICsJaWYgKChzYS0+c3NfZmFtaWx5ID09IEFG
X0lORVQpIHx8IChzYS0+c3NfZmFtaWx5ID09IEFGX0lORVQ2KSkgew0KPiA+ICsJCWxlbiArPSBz
Y25wcmludGYoYnVmICsgbGVuLCBzaXplIC0gbGVuLCAiJXNob3N0X3RyYWRkcj0lcElTYyIsDQo+
ID4gKwkJCQkobGVuKSA/ICIsIiA6ICIiLCBzYSk7DQo+IA0KPiBJdCBpcyBjb25mdXNpbmcgdG8g
ZXhwb3NlIHRoYXQgaWYgaXQgd2FzIG5vdCBzcGVjaWZpZWQsIHRoYXQgaXMgY3JlYXRpbmcgYSBk
aWZmZXJlbnQNCj4gYmVoYXZpb3IgZnJvbSB0aGUgZXhpc3RpbmcgYmVoYXZpb3IgYW5kIGZyb20g
b3RoZXIgdHJhbnNwb3J0cy4NCg0KSSBhc2tlZCBIYW5uZXMgZmlyc3QuIEhlIHJlY29tbWVuZGVk
IHVzaW5nIHRoZSBob3N0X3RyYWRkciBrZXkgYmVjYXVzZSBpdCBpcyBhbHJlYWR5IHJlY29nbml6
ZWQgYnkgbnZtZS1jbGkuIElmIHlvdSB0aGluayB3ZSBzaG91bGQgZGVmaW5lIGEgbmV3IGtleSwg
ZS5nLiAic3JjX2FkZHIiLCBJIGNhbiBkbyB0aGF0IHRvby4NCg0KT24gdGhlIG90aGVyIGhhbmQs
IGlmIHlvdSB0aGluayB0aGF0IGV4cG9zaW5nIHRoZSBzb3VyY2UgYWRkcmVzcyB0aHJvdWdoIHRo
ZSAiYWRkcmVzcyIgYXR0cmlidXRlIGlzIG5vdCB0aGUgYmVzdCBhcHByb2FjaCwgd2UgY291bGQg
aW50cm9kdWNlIGEgbmV3IGF0dHJpYnV0ZSBpbnN0ZWFkIChlLmcuICJzcmNfYWRkcmVzcyIpLiBI
b3dldmVyLCB0aGlzIGlzIGEgVENQLW9ubHkgYXR0cmlidXRlLCBhbmQgdGhlcmUgaXMgY3VycmVu
dGx5IG5vIGZyYW1ld29yayB0byBleHBvc2UgYXR0cmlidXRlcyBkaXJlY3RseSBmcm9tIHRoZSB0
Y3AuYyBtb2R1bGUuIFRoaXMgd2lsbCByZXF1aXJlIGEgbG90IG9mIG5ldyBjb2RlIGFuZCBJIHdh
cyBsb29raW5nIGZvciBhIHNvbHV0aW9uIHRoYXQgcmVxdWlyZXMgdGhlIGxlYXN0IGFtb3VudCBv
ZiBjaGFuZ2VzLg0KDQpMZXQgbWUga25vdyB3aGF0IHlvdSBwcmVmZXIuDQoNClRoYW5rcywNCk1h
cnRpbg0KPiANCj4gPiArCX0gZWxzZSBpZiAoY3RybC0+b3B0cy0+bWFzayAmIE5WTUZfT1BUX0hP
U1RfVFJBRERSKSB7DQo+ID4gKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIHNpemUgLSBs
ZW4sICIlc2hvc3RfdHJhZGRyPSVzIiwNCj4gPiArCQkJCShsZW4pID8gIiwiIDogIiIsIGN0cmwt
Pm9wdHMtPmhvc3RfdHJhZGRyKTsNCj4gPiArCX0NCj4gPiArCWlmIChjdHJsLT5vcHRzLT5tYXNr
ICYgTlZNRl9PUFRfSE9TVF9JRkFDRSkNCj4gPiArCQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiArIGxl
biwgc2l6ZSAtIGxlbiwgIiVzaG9zdF9pZmFjZT0lcyIsDQo+ID4gKwkJCQkobGVuKSA/ICIsIiA6
ICIiLCBjdHJsLT5vcHRzLT5ob3N0X2lmYWNlKTsNCj4gPiArCWxlbiArPSBzY25wcmludGYoYnVm
ICsgbGVuLCBzaXplIC0gbGVuLCAiXG4iKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gbGVuOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBibGtfbXFfb3BzIG52bWVfdGNw
X21xX29wcyA9IHsNCj4gPiAgIAkucXVldWVfcnEJPSBudm1lX3RjcF9xdWV1ZV9ycSwNCj4gPiAg
IAkuY29tbWl0X3Jxcwk9IG52bWVfdGNwX2NvbW1pdF9ycXMsDQo+ID4gQEAgLTI1NjMsNyArMjU5
NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbnZtZV9jdHJsX29wcw0KPiBudm1lX3RjcF9jdHJs
X29wcyA9IHsNCj4gPiAgIAkuZnJlZV9jdHJsCQk9IG52bWVfdGNwX2ZyZWVfY3RybCwNCj4gPiAg
IAkuc3VibWl0X2FzeW5jX2V2ZW50CT0gbnZtZV90Y3Bfc3VibWl0X2FzeW5jX2V2ZW50LA0KPiA+
ICAgCS5kZWxldGVfY3RybAkJPSBudm1lX3RjcF9kZWxldGVfY3RybCwNCj4gPiAtCS5nZXRfYWRk
cmVzcwkJPSBudm1mX2dldF9hZGRyZXNzLA0KPiA+ICsJLmdldF9hZGRyZXNzCQk9IG52bWVfdGNw
X2dldF9hZGRyZXNzLA0KPiA+ICAgCS5zdG9wX2N0cmwJCT0gbnZtZV90Y3Bfc3RvcF9jdHJsLA0K
PiA+ICAgfTsNCj4gPg0K

