Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E711FC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 04:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X2kkxQwJ3qfw16cmYAgmXKO6JNDuBSUDNqRbwieQJvg=; b=HNWRaBkTO85EGtCaZPVtyTIUWY
	7cP5SORCk3etx4n3ygPg/m2tx7xIPdgA/1mmYs3t1YbrpwSzMryzh1estexZyhE5ZzsOjZIYPYjQN
	6/LINbUVY5NxdsalRMA4p9Is+FY922+xZiW6fvU1jwkBZqz/pjhPrUyr+fR5HfdhFEFW+pPV7/6qg
	LMIYcBDAI/CZAwqCS+meP0zLUVm0HhzzdKxclKA2G+oEosUV/1c0868Vdg8Me9Txh+ZwnGPeFAH4m
	uMPtQg31+xXcUL4f9Ra5zdlZH7Vo/lDz/A0quKJTaZyf4JaF7NfNdz69rQ+TLEpMnEj05AiiS1XnL
	rbCUut/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsGO-0065tg-R9; Tue, 29 Nov 2022 04:30:32 +0000
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com ([2a01:111:f400:fe59::619] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsGM-0065rU-NM
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 04:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFykI2i1eZwwg3REqNltiNat7+dZ76OBOyu/qFPZU5cBnoLPl2BU7l5shdeaafpkXEuUYNYTmzkuOjZRcO4TTbIR89CTG8KTfx+RB8+xDcZrdcS+v8gRp0Qn6RtHykl3amUPThk5/lXOsgqAmuEmSvKuFaXqWIIRPx4pMml1gHPnmhWOrjypakGZimOOPbISh469SGmYOuScgdYikR0kJZ/vIjNby2aPdd+w6PyRqyphX3xvcZgpGVgNembnZRg042+Ka0z1K34+ZPw7K3/zuCOnxLxomhT/2G3BjtD+Q1LgVZ8Ot5pDLUQX/6wlWxIAncPoQxYUwFb5AKrMAWUGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2kkxQwJ3qfw16cmYAgmXKO6JNDuBSUDNqRbwieQJvg=;
 b=AlFwJU1nUx/j5I3dAquVkEhZYHXEJ2INP4uHFSvmtmvoopK5q2XzClOU8p5T1jg7V/9/b0gsZELigvs5EcofhgnC8rT1asxGifT/K/kxL4JfzayIPAj7HiWgIdOdCMCQhIt0tv0umxu2/WU3yp6mYRU9+egPA1rfgq1DGchl+FKtxNJdMuy1ezaYGIWTl2cp7lm//zOYZP/NySW9Xb8B/VP8qj5SMuMwvOoXkBDxIWtFJnk2VqH0DLo5UbZ9ZvmGy3xvFj5fALoWVAOiA0rCpALTvUmORdQPL1w9GURLEwLKn0vjQObMoe1RG4DqhyDfuZjtn/l/rSpNItgp74hm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2kkxQwJ3qfw16cmYAgmXKO6JNDuBSUDNqRbwieQJvg=;
 b=cZL89bKi+HSL0pTDJ/CCQmNeYEL+QPAWRCoDH3ChqC9iaZW03wOuTP9h/PnJOX9D9YZ95YdWNbVo0pWlKJsin1SJgk+8hU1twxAQD6FdDE6ur/Md5A2ohsoTb1/Ex51Ziq2UcoKXs5OaTKs3h9K7mCh8hgtsNsKCgzw3GooH128PwOZtjFbIDhUFXCRdeeIZJptst48igNRHdy7xGLAEKnietiGdtZHG3XbFedz2LPob8bgoXWUmSk7Eh/8j4lm8gCBNWt99tFVwYBAjGBLG7dRylx2sANifoz9xM/2NJcpgO5TTXtbFScj/3CWYeYTebFZZnTNhAbVJLTCeX8DJFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 29 Nov
 2022 04:30:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Tue, 29 Nov 2022
 04:30:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-pci: Netac has bogus namespace ids
Thread-Topic: [PATCH] nvme-pci: Netac has bogus namespace ids
Thread-Index: AQHY/mUoneHIa9SzIUOPrkWnY1Of4a5VWdKA
Date: Tue, 29 Nov 2022 04:30:28 +0000
Message-ID: <177bfcdc-4d98-9ad2-a3fe-207f5c5678cc@nvidia.com>
References: <20221122112428.1573353-1-sagi@grimberg.me>
In-Reply-To: <20221122112428.1573353-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB6989:EE_
x-ms-office365-filtering-correlation-id: 3dfb9ab6-bd97-4a73-19ef-08dad1c2714a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1nEebmfl6mygqUMPYErGuQeHLNZm+o5j9NTZKOCCMwlOiwnxU5mYATednvKOQwUJK1q3WRlLVDFthB5GfHn4RqsHD+qCdXqlItAXJoIlAzM/xFcb2i0SSjb64fC8jLxXb9eSA7VevWAa4Kd1eU8S4iLZDlqLd6Tn/p9yQoz4rz8ePK3yRqi0vMMGVCeNr6ueXziQWr5cPU+8pBldReWSNTTT4M+zLwj0FdKOXki7SsVpVG5ZgapoVRUpoqiVvLe3atM/LFJf11SrUXNrjHGry/Lya/KXWctAaDXk1sXjZs25gq2qZsSjFqblOqNGW3FFRWLwLQ117FogqyCe/XVi0nC2Yf5LQo27tBtPJV7kzf0JcUOEgYqqXerx5s32kyP8qik0t75Rsbq0uFOs8EgBb/5o14eSWciPhgColAIR18Ix6zuqTsgKc6VllG7gCuYbIYmyLZvia/uKWHIPvEnIl8S/O5PSPsMGIni51FIGMiZV2AqW1kXCmmaqP7TZTzBwQgQ6F3/flGEqctWOO8vvntrQawCEeubsE34kcq49KO6y8CE3qUqz5Fha6BUtcvy5r8EAdCI3Q63A27Sy6bIs8winri0tZFqmFYcC5IUNo8qadIRu8C7qt/OizkVDnz5t4tgGxFf99FekMWSB4EJAPyetmT1stG81toeM0hgwxCtBEfmS1vfScBMvP5FNzU4tt3lAhRcMDQoS1dBY+2Ec0K5KPc+G/zVeTKFWEiJAHbTSja84PPmrWFh7K2hM1Xo+eQSOBrXDS6ZxSwkd/xoRUaOIbH24b9IYco2ZfbWP4lB781C/gOW84+n3H9ut96Ii0n/jc/sXQZ2R2MEobePUAdge/f6BEOKcrPM5q2NaVx0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(31696002)(122000001)(86362001)(2906002)(38100700002)(66946007)(38070700005)(41300700001)(8936002)(5660300002)(6506007)(4326008)(53546011)(6512007)(186003)(64756008)(316002)(2616005)(76116006)(66556008)(66476007)(66446008)(966005)(54906003)(8676002)(91956017)(110136005)(6486002)(478600001)(71200400001)(36756003)(31686004)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RWM3SE4rNE9MdThKc3dtL0Q3ZnArVGhUbEZKbnAwZkF0ekdOaEZtMmlHeTR5?=
 =?utf-8?B?UkptVHdZVG9RR2MzNzVITmkxYVRBdU1HVkZyQklQUmo3bHV6OTNtL0NZaGVw?=
 =?utf-8?B?MU5ka3pTdTZJK3JOS2JXdUFpbWhHSXRTOGZkYWdwTGhENjgzUU44Wml1cGRo?=
 =?utf-8?B?TWxQeDZRZDBhWXEwUVEzVUw0ZzRGQlZKc1NOSmU3R215UjQwVTU3Qk92bmF0?=
 =?utf-8?B?MXJJRzdMaExFbEplYXBJanEzVDJIdnNDMHBuenFlbHVqRTVNTUNuTTBUUk9q?=
 =?utf-8?B?eEppM0FNUUw4MEpGcHo2NENBb3dOZkJQMkxEaWxlL203Z0d2VlpnSCtTTTZP?=
 =?utf-8?B?T083aDRPc2xqV1VTeWtRSkMrNENvc0NLMFFqR1ZzMEQraWRheDBnMHFpVW9t?=
 =?utf-8?B?dEF2NkE3UDZ5N29jTHk3VTNaQjd6ZW8zMk81WStVemx0Nm9OaU1UcXE2ZlFE?=
 =?utf-8?B?R05LeGJuS0lmcUd6MzZrZUxWb0VWLys2aUN2b0haTGxqTklOZzhFaFpoc3VW?=
 =?utf-8?B?ZE9FbkRMdEVrUlNHdldnQXc4UXFwK1ZwVzJqaE9hQm9TOVZZdG9NZ2ZmSlNw?=
 =?utf-8?B?TGZ0bmFaS0U4U0FoSFJ1SXJZV1N3RGZmdGMrQ2h3VjZEOEtRcldvWXFPSGNI?=
 =?utf-8?B?V1ljMGFINlNNTXFDVS9aZkxMbGZkbm9IWGJDVk5EK0RNQ0hXRWtybjFaek1O?=
 =?utf-8?B?cTB4RFovZFJzZU5KdVhlVmdXd2JlQkpzVmJncSs4NithNUNzSmNzbHUxU2lH?=
 =?utf-8?B?NHA1czVtUC82RXRJK05OUDZMa0NUNzNYT0U2L2xUV1NNRGU1a1JScWhCSlNR?=
 =?utf-8?B?RU5yNG9MaTY4MnZBNWJVK0VKVzBacHF4dDVRR2VYaUtjQjdhMUlzRXh4Qnk1?=
 =?utf-8?B?R2h2MnBLaFExOXl2UHhlbFg3cGVhTWl3Qnd1VkpOekNtYU91RW0zc2o4RHFU?=
 =?utf-8?B?OW9ZeGFUTDFaVWlZOWFKQlZZNVowOVRGUXZtRTBBZytaWlAxdHg1Y1Nmem1F?=
 =?utf-8?B?WXFIelAxUVdGVXI5V3drVDJEZ2hQbDFhbitXbjFyRGlCa0Jhc0pPakNVVHh3?=
 =?utf-8?B?QkhMT1BLdm1TbHlSdlVUQW1SamhXUCtpZEN1VnRrZUN4eitLQVhVTEFQWWxK?=
 =?utf-8?B?MWloOVd4T0wvdWZKSmV4a3VLSDYvc0cwZjFlVHh3WHgvNUUxRk53ZnVlelNJ?=
 =?utf-8?B?UEcyVXo5WnJkTnBGYVVhSjN6K2hOYjNEaWk0Y0tsWXI1TnJwWkpnOXBJVWty?=
 =?utf-8?B?a2Nram91anIyQlN1VTNoSXlwOUlaMVNOaUdjdi9qMkZmQUZLK1JrbUxRcEFJ?=
 =?utf-8?B?ZFU4WVQvOEd2Z2IzMnNUSmhpa2FhQTkwUHlCeXhsT0I1bmJaVHpCekc5V01y?=
 =?utf-8?B?cWNibzlmZDRTb3l0MDdOV0hrUTUzWFBJUXV4bm9VL1JuaTgvUzVFeVdIbFlN?=
 =?utf-8?B?OWx6eWtYVTdoYTFFdGdNOEJod0ovcnl3VktWMnVydTlMZHpHSDJhZUJPNFh0?=
 =?utf-8?B?UmFHYWNtSW9wNnpFOXRNWDhCMHdlVWdhU0pvUE5aWDRiSGVmWUtJdGdqbjdF?=
 =?utf-8?B?WEpGWnd5MWtEWDlJeEQ1Y1Y3NzhPaHNmaU91ck41WFkyU1kraXRQZ29wekJu?=
 =?utf-8?B?a1FJWmszeUJsNTJKekphM0ZSd3RsdGJxdithelJtSTNjN0FyY0IxYnp2OE5U?=
 =?utf-8?B?SWpqRlIwQ0V5M3ZvZzl6MldyLzB2VGl6b0djMGQ0V1N1SnhtY1d3enFDeGg0?=
 =?utf-8?B?QmJOclJrTFdwZFpZSVoxS3pFUDkrS0FQb3d3enRsa0dZcHVYRVlrZkEzYUNT?=
 =?utf-8?B?Y1BTOFFFaHJRMDBoMWl5Z2xZNTEzZjRicko2L1FYb0lJTXZQcyt0R1Fhdnl1?=
 =?utf-8?B?SmJpWXEvTnhmZndXOXBJVnJwMlF2Rm5lbGpJMkwyUzBCRk1SdVJCNUROTTRC?=
 =?utf-8?B?YWJhaFVaTDYvYUIySGRtWXZQOGFuR3pjZ0pPRDJWSWJKWndiUVZKZW9FYVZF?=
 =?utf-8?B?MEQ3QitpblhYU2N2VUY3RWZTSjZBZ3Y4eU9ndWIxbW92Tjd5TTRGTDk5WVFk?=
 =?utf-8?B?VVFudHZ4VElXMlc3Y3hYZ1ZmeW9yQjc1NnBtSlJHS1NYTU5GdDJLZHpvek1l?=
 =?utf-8?B?R0JUdEJ0T3Bsbmo3YnkzeUUyWGh4a0Y4QjZsOERnb3dxcFozVnRJOWNwd2dW?=
 =?utf-8?Q?AsqwoucVhKYjYwClxSSUcA59vSSs54e4X5295UP0dBes?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6788A8678AE0742AB77849246CE6EA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfb9ab6-bd97-4a73-19ef-08dad1c2714a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:30:28.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VK00n5wppqMdSxWSrs2nrmJCc1kZnJkA8ZzOrHBJY5SSY7rJzu8JbhRhkt5pG9UiCkIM4quYuMBn8W/GrhBFOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_203030_792462_69142945 
X-CRM114-Status: UNSURE (   9.00  )
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

T24gMTEvMjIvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IEFkZCB0aGUgcXVpcmsu
DQo+IA0KPiBSZXBvcnRlZC1ieTogQW5kcmV5IEdvZCA8YW5kcmV5Z29kODNAcHJvdG9ubWFpbC5j
b20+DQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MjE2NzI0DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

