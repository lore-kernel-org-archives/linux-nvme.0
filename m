Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Mar 2022 03:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQgVKZgurPt4RtFrEcXbJL8+yGRVFnTxcFWPCuBOePM=; b=zTl/5lR1ZNckE9i5aEWw55P+Sc
	8F0KW80qCF2geij+U/VVEG9pgzMSyMVfGs+jVOZPoiiGP0xFXK3BpsHFdplGn7W1kmjqexKn1xs+Z
	afVJmCMjciz6o1h3ygFlb4j6DsW1sME+7jGqCPuoeLLuSFTdWy1KhxGfEwO6InWTztwbkCYIXOBDN
	7PdEizSplY9nTycAOuGqbjEfA+kXInixEINAQ3bFdByD6FytpKXPC44VvnSVBu2ca0KjTTpVgYN0N
	k9Y/HOBzkrB6CbxeG1na9mlhiIGRTbz6mFgBSFCIzI+8jJVJCA1fkPYmadwuu4fcyudyk25Sik5OF
	ha/8MqbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nR4MN-00Fp6N-R6; Mon, 07 Mar 2022 03:48:35 +0000
Received: from mail-bn8nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::612]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nR4ML-00Fp5J-P3
 for linux-nvme@lists.infradead.org; Mon, 07 Mar 2022 03:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwLi28s3ngwwP4BRQvXtHl5Hhtf7fDfvawDIUW6A+KZjFlwbAV05unETweveb8/mxP45qvCOyhX3Nc+zVa/I/Bt79lSZpO+WFHUaKWmbBwy2EOmIxFLGIGOyd9KRgupaZI9XYMNeEVgAJyUpnqr3Jy7cCH6mgYmNNKWP3bS/J1Wh+1CY1w2PYyods0kA+9Y9abin58qmL3M1iNPUOmG8Jx/WZ3l2w+lwcAWUjWX80xj3YaKhSHX97y8F8zsZq0JgTsXsRlnsPS86WMjZuz8eUjO67aThlZMcwTu+qVMZUb++eApmji8rK3HHiZQQ1+tbYa+Do8/a8DPqhN+hZhkjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQgVKZgurPt4RtFrEcXbJL8+yGRVFnTxcFWPCuBOePM=;
 b=PY9GkaYXivHSpe5CLtCQ3tWDg8F5fKHk0O7Fblgm64MrFRqNrpMv2WW4NvEczj1eqET76OgJ/yjuc+Vs+0JwHEnF7/HDgsNXT7+D/o04Yf8OrvWUTOHKd0qxlo3XmKdSTTuoLAPVHDTIRSReibnAtOjvLTyN/UHoNzsRqgX3Gi/9S8ijwMVZ88HtU0sbztZjW0M83Lmgo7ebV0JmlULCuPHL8j+bzB0jvu25KDoM6z3ZHG2ApPTeFojoHQLGk0ah1LlvZtApHNSGa5vBTSYR546VkGnyI5DxhPVvfZzo5kwffr5H9rnMruOYrhlJYD4ndurwgFq7+bM822reBs3lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQgVKZgurPt4RtFrEcXbJL8+yGRVFnTxcFWPCuBOePM=;
 b=JQMcMFhs+D5kafjTsqKxbzRT0sui1anYQykj3FAoSTNy6q5iOWLLGjbkyYo5miuLYBNRDatjLJ3YSxWkbTlK6oFJX+6+2XH5YwgvSWYtvTZU/aWb/Zrobbb2ZRARDW3T9SHz5Jc1HRi+QR0AOprqa4IJp1aUZG7j7ZCTegvQNC+b/CxfkfYRTEiTZvOBCR7cVJSC/66MrZ7itEaziDq2q6wjknoYYzI8UQAiiJiqt/IX/wXGK5cLmhhGyibfqgJtPYZ/15SVUOIUXVK4Uu7jHmGwOuza/fIlFF5K7DI2jCE/od87UVe2bUdO6cieMAE8dAXKwhhZQn6mBHa9tREaeg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 03:48:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:48:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-tcp: small cleanup
Thread-Topic: [PATCH 0/2] nvme-tcp: small cleanup
Thread-Index: AQHYKGanBaCybOH5GU+H3/oTZ4qAy6yzW5sA
Date: Mon, 7 Mar 2022 03:48:28 +0000
Message-ID: <766cc6c1-9283-b31e-e47f-d8be1ff39f1b@nvidia.com>
References: <20220223033657.208747-1-kch@nvidia.com>
In-Reply-To: <20220223033657.208747-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89d4c11e-a780-4fa2-6be4-08d9ffed577e
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5158BD62EE1A36B48A0D0118A3089@BL1PR12MB5158.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tazSSiA9QWXqmnHfn5eYG9HSx44vAXm7uOsUrMJQIBLoeCphjPgAXUG8yJD2Mmpc6J7Y+DE7fvFw8EQAFWxOxhuu8SfdT6j+h1IggBVuXEykwK5yK81DOzZNk9RSJ1wjBFQPs5BQlRfPBdwV8AwwjovzLsiqBRDvxW6ZrOG4aXNTB0hhK4RaVS9zEbmIDjoXm9SVluJARq30hf9FqOIX7MDf6EujMG5oeI04ejOiEv1DQ1uh3VknrKv5sweSPTg7rfJf7hjxdIe1TdYQ9RgVITtTzkWJWdzlTvaYhBwjvw/HXbKJaRIawdRQsRkuA9OxcefnBqjVIKEvT/F2yIY4gAMwjXQ1YHuikAldqssljR+YvFlZv8wlEVaWgA5UkyDESUj7oJlFDXq7W0v7iVkmVIUvC6bTsf3Eyz/qfd7f3ctXsYbLkWIhiM5YG6d6XIlHH2wji9F2Uc+ovdCQj2qzUO7iNinyXUhp/JDnWZq7DYKU/Uz2emDNycM9a4UrImJzI/cmNZERjuV3AFAJ1BNqlDgDqa72GJOeuRvAd/fzGK7xzzlSSKnO74zA4e2TzzcXyBRo6hwkXzBAclbP+Ow/FfahGov21J0m37aHS57Hx/GMN4OChwBQh/sfqbOP9e+9FJl45CuouwSssY4DefwyjP8DKpA2ii3vPSG6Ycv5ieCsxwf1Sh1kOB3XslCq0D2xQ2kNqMo8xvHVq1t4NqJRooajGmyyDT53pWcqFdJr0tBn6K8oZsUHarihNERhwwI1JD/yXJXY8mK+h7oTksRlfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(31696002)(83380400001)(86362001)(6916009)(54906003)(186003)(71200400001)(316002)(5660300002)(2616005)(4744005)(8936002)(36756003)(91956017)(2906002)(64756008)(8676002)(508600001)(4326008)(122000001)(38070700005)(76116006)(66446008)(66476007)(66946007)(66556008)(38100700002)(6486002)(6512007)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVF6bzQ3aHhmbnpEMVpCMHNaQWJoQmp3cG8zb3MwZnhOTHlTN2M3bGJyd1FZ?=
 =?utf-8?B?aTIzVnFEVVlOQXNZRXpGNVB6VEJXaUtxdzk2VWNkZVk2U0RPc1hYb0F1VVhE?=
 =?utf-8?B?LzB6U0tjaHJlK3o0TytLUVpYSHA5Szc4Mm00T2E4bENtNExZUE1ZT3FwUVNK?=
 =?utf-8?B?QWliRFJwNnRrZlJ0TG9MZFY2Q3cxby9LNmxSVlJ4MkNXenhGUC9TbVhpZFZE?=
 =?utf-8?B?ek9TZ0NGNWhVcW9RRnh1akNzWmZ3b1VDclhYV2s5S3FqWUpjNlFtQkhTblpq?=
 =?utf-8?B?c1NXMHpnTmh1TXdGTFRjQ2dsdlJISmIveEZ3dG9mcVZKSnk1bk5Wc2Z0d01o?=
 =?utf-8?B?eFJnbWY3a0padEp2MlRFcTVYcUliM3hZOXU0dW56S0RyVHQ0L0VRc0RSdzdY?=
 =?utf-8?B?b29uUEtJL1ZjOVVKYW5DVjEzdVdpSEZWZWFaUkVsK0VQZ2RPMHBzNm4vbDNm?=
 =?utf-8?B?UnJPb2FBUzZjc2R6UGdrMnBFRENZK3grNm5jYXNyV090d2Y2cXhrMStaMDYx?=
 =?utf-8?B?Y2F4aXErbTA1UUNpek5IL1JyUDNxSzZRQjVEcGNHRVdJaG9zeGJNZjhtT2NG?=
 =?utf-8?B?MDBzOXVxdC9YbXQzeE9TSmhxSVA2K0ZIa0tSVENOMGZjMmdNWkp3U2hFbTFn?=
 =?utf-8?B?cEZSUGU2alRrVlRmY1cxdFlpZ0toSldSUmNNVDUwTDRRbm5pdVJDV2d3VGtq?=
 =?utf-8?B?TnpCQk0wQWwyU2V0R3ZSdHhjSFlWQ1MzWEtaUVVpNWZiOFNBTzdaNjRZckhW?=
 =?utf-8?B?Vzc5K1R1MHcxYkRYcld0eGxHWUxrbUFBcXdTbHpCdDQ2YVc3RmplaU1KaEFt?=
 =?utf-8?B?aU5WdVFTVE9EZWI4WGoxc0FZZVJQQW9BcTFwQkJ3QXlIaE4zYlpuRFR3d0hG?=
 =?utf-8?B?ZDJ1K0hsVVFONXQvRm04V3pRbElucm1uLzZBNzhhWGJ6S2RNWlBIVlhFMWZ1?=
 =?utf-8?B?V3Q1SlhISURmZmdUZkVpampwM1lPMG90UHdMbDVJUnR1UXNmbUhROUZjc3FG?=
 =?utf-8?B?RzRzL0F2OWRzblM3TW1tNWMySmIyYzRFemVKRmpkVDNuQTNzRkN1b09Bd2E3?=
 =?utf-8?B?RUZTSFhPWXg0d3d5ckRiY0VCRTd3THhUa2ZjaEVOd0JXVlM0d0dlMUJuc0h4?=
 =?utf-8?B?ODBWUTlNL0NGL1kvT1pGcTc4aEtGTkNpY2JXRVpCRURkV0FwanRaWFFoY0hX?=
 =?utf-8?B?Q3JqSEI1ODAyRmN5VDBPY2trNXVqME1tUWZ6RFZBTWJHUTZlalhNa0QwRFJX?=
 =?utf-8?B?QnN3MlhOcUpqcXNFb3hrLzl5WDJiTnR4UDJnR0llU3UxWm8vK3hLeFZjYWRB?=
 =?utf-8?B?bGdyQVMvNXlpSnhmRG1UNSs4T1NndTNZMnNJays1bUhZdU9YR1h2Sml2VVlk?=
 =?utf-8?B?ODlrSE05S3JZaFN1TDVRYUdSNnVnMUpmQnNqWVovVTAxZkxNRVM1RURWUnI1?=
 =?utf-8?B?NDdjUWh4SURnRG5YM2Z6WjFydE9mS3laWDlGMmUvR25vNk1uRTY1YkY2dnV5?=
 =?utf-8?B?Y0oyUS9TejJPWWw5SVV3eDlSaXFSZTByYTRVaWo1MW9DT2dPQ2pralhnVkty?=
 =?utf-8?B?VWp3NUJVRUhlVXE5SWR6SktPdjEreTRwZWd5d2NTZTc4dHEwUi9NNEllZW9K?=
 =?utf-8?B?b1l0M3BXcjdFb0poZ0lRaHJ3ZWlRdWNDQ3dmSi90SVluK3EzbytKaWdzOFpm?=
 =?utf-8?B?TWxoamtPbXF1K2RkVE91Wm11UzFObkVGM083aVNGZ1JSaWdaa3dVK09mZ1pu?=
 =?utf-8?B?Wnk5eTNVM2tsVE1nc3VwejBnMTJMdXFIcXV6dERUdllOUnNFTWpoMGZ0ZkhH?=
 =?utf-8?B?LzhGU0hIMG50N0o3S0taeUdQODc2bkY4eEtzWnlNZXBHbXlVL1FqMklFVUtr?=
 =?utf-8?B?VCtGTzMySUE2VHNFTGIyUjJ4VUVwTGdkZTM1Y0x6T3pHRjB6eWVGWjlTdXow?=
 =?utf-8?B?eW1tMEJZTnNCakVSODBac2QxSFhxdFROaWdvd1pxeTFPcVdwNnBQNFJVSmZ1?=
 =?utf-8?B?YzBvYXl4QzBrK25JWEw1QkhuV3FOSHB3S25kc0RDNyszZXd2alEyekl6LzhK?=
 =?utf-8?B?aHZCQ0NnSEs4bCtDUVlQZG51KzNqYWp6SEdka1VyQjFobkhETlJCaU9wQjhE?=
 =?utf-8?B?S2lIMUkvQ2xTc1FkRUFhbWY4Z1JLQ2o1Qm1iSDErKytEV3VzamwxZERYUStp?=
 =?utf-8?B?UFllMElrVUxZNVYwKzR6S0xKZThhMzVYNnA4MzV0ZjhyM2FtZE1jSHdWMGM5?=
 =?utf-8?Q?urQsl1XLZF9PMDUsequjT23uyuT/cjKItptk71A7Yo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ABF83A8543E6E4785F3BE9E04A0FF98@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d4c11e-a780-4fa2-6be4-08d9ffed577e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:48:28.8620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSO3gtk4hv4OoijDodspWmeKBhP//ZvJe2NjwI0BbjlKSW1GOfT2qfqn2NLjj2j1NY7IgDk/V3NcwxXp1rnqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220306_194833_860296_8808AB29 
X-CRM114-Status: GOOD (  10.78  )
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

T24gMi8yMi8yMiAxOTozNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IEEgc21hbGwgY2xlYW51cCBmb3IgaG9zdCB0Y3AsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLCBiZWxv
dyBpcyB0aGUNCj4gdGVzdGxvZy4NCj4gDQo+IC1jaw0KPiANCj4gQ2hhaXRhbnlhIEt1bGthcm5p
ICgyKToNCj4gICAgbnZtZS10Y3A6IGRvbid0IGluaXRpYWxpemUgcmV0IHZhcmlhYmxlDQo+ICAg
IG52bWUtdGNwOiBkb24ndCBmb2xkIHRoZSBsaW5lDQo+IA0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0
L3RjcC5jIHwgNSArKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KDQpnZW50bGUgcGluZyA/DQoNCi1jaw0KDQoNCg==

