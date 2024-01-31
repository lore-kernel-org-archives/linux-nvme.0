Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B206C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJqsJqP8beQ7wAdiq15/jghsefqjoPNx778o7J42gfg=; b=XI8KF5kCs+y3rFd1ajq4qSR87x
	Hd8WG76y1S1IEme1910cwAi7YQKdNmkADxY+nIJVQdg+xTghxsVEUtzhGtVMbCv2lWoYtAmlOzfXs
	HX42dNs0xrP0Tjko6hH5H7WasRLhMnmhubJvTt7I3NvG74R6KVKQabTefvwWC3L6eHTwd94Uny80s
	Iykhvq6QLnM001FJhaOimTh9ORE0GOqNAYtSZuKvmhrPTh1+55Wtd30yhKZ5NC3xljYx6uEwxTcrW
	GiAokVc28A7Lr2p6HU6YAUn04iEAMN6asxbQiE1XJK+qxtHTQIuvB1Lyv8FEA1SYSovXsyxPiIcH1
	p0THg/cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJhT-00000005oe1-2Oji;
	Wed, 31 Jan 2024 23:08:59 +0000
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2409::600] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJhQ-00000005odK-2PKz
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQbWgnEr8aOcxAS0hOnuoyTUVXunJdE4rP6eywapZgfEuPFrNobt4g+Xi+ujB/CnLvZfxGqBFW/dJTc6X9Ll0SSSY0Z0dN4nF5w6GAakkcQFzRpRJKHtJ22SOxnOtVDjFvc5zXF1MR7mhmH1tKqW4JgTs1kVvXfMt0W/skeThy5a+htytIyZ4evlVG5nw/8OqOJq6HBT5MSp6dV0K5nKT5aQD5Z7meRMVS0cJSEy0aAQ6odoSZV1VFyr29hmIpEF/VGXBsDCk+K7RZe48Qw5+AxNG+yzWtBiFhUMryordNGzcAtRwQHUHOuZ4ejB16L+Q1rzv5ymt8s7OC9OvvAGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJqsJqP8beQ7wAdiq15/jghsefqjoPNx778o7J42gfg=;
 b=SpyK+AGfmDF3o2cviOsNj75HDMyKCEPaiIfQE6gGbsUQNb/8ej93SnPg31HYuk4/PAaU+zKsBKRL/XXvggOvPjN5r25ZyX2u3w8MUWhGVWfukOWy+EgFpXylEKa2YQfT+pMRC06OgPZjmkEkSeOQ2KwsU7t0e2KqhFynyRtZk2c5cJxBNmuX9UeK51vo9B9jI47WuxxR0iBeGQzeMcxexNGCHFuUUsZsFgi0SpiU11FBsxQfLjaav5ZIHKLBOurSIz/LmghWJA7WYISsBxvH5saf9YQ+MPNZCXFc6e1pIlTf2OSzQsHJ4jInxah3a9OMwFlRjN+uC7VebN+un0c1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJqsJqP8beQ7wAdiq15/jghsefqjoPNx778o7J42gfg=;
 b=D3mAxoeBTNvGdosy/7dyc0b/ActxXXC3+q3WH18JhDayHwanrcoMyQhCWk91i4o3ZIUN5HFLUQpNXX36dPeKXySnyoFKZpqGBKAppGd/nYtjR/nvNnThyBHpzPgoF4zBCGI64sMZGmA5MOk4JyG+BAVDDnO+JV3b9o2zoQdPOWdhWwp7tgAMQQFzXeuj/vz9mCWAp40OqB+pDpq7y8/NGYd4eXrqbhtM0v2e+3apHpaWAkzKChPKZqiA8Txp3ftMDpeJojI2XKpEVysvPmRKRSH5z/PYkE8gOADDP6G95Qp3BE78ann+hDayMzKSW/4EnurHahgpdC6GDYyzybqPxA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:08:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:08:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>
Subject: Re: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Thread-Topic: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Thread-Index: AQHaVCWyLNL1w8hkYki8mpO38aX0x7D0jJ0A
Date: Wed, 31 Jan 2024 23:08:52 +0000
Message-ID: <f7eb8e6b-3833-4b68-812a-b533f7931b5c@nvidia.com>
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
In-Reply-To: <20240131091222.116190-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: bf3fa47e-3f96-42bc-5896-08dc22b1978b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZIIqQbFecV0PztsQkEOqX2UhbUqcCCZzbYeDFWAuIseWbSI9WJbSU9osFc6Xk2Y5DYQj/EEFAEJIilvakSWn/2M8BLUlXDqskp9/2z4xvnrVO+m4wFLA+nhqBW0KWffH9V7mfjFDKly6sHol8SRwvY9OX5eTbg5zEiWvSRytHJpzX6m2L99lDuYnAqK4UWanLK/yJJPDIaalggFYicLeFXXHtZZk1fePAanov/Wbsd6FDgTZhiiJ0j6YiTEeD0QZa54efY+jMhC25FA4IvFVlJPeNY/N0nzt8M0aU0467ArZk9Uku87DPwh5eDk+qcB+vHYUF7J0Mt2W8SyKKCUJltkIquGgMIlhx2S8VKccjnvc+G5VqxRbbafCH5RJhcorf9qERdelqlKQbfiROF8vapG7H0nw+K3irYVJ35oLWos2e8CygcTyAeLncDhbKYa3RVm7tjC+s9jgr8vLY6ioHxIHbSs0X2a/EVNJFpLwJ10lDXzeDvFJsfVB4xuAISXVujYTBOSKxlQTmAO/Gnf+w0qx792GAgg0rNOA9/g1iNopfWviWIGqlUeXyl8j7ZpP6Ln/YZdgMtYBXAzbUljrQjjt2tZ6WkiyhDOlDmH3r3XSiZJto/mFCG25yxFvFru+9q3B8nMqKQL5n41qN4pQ8cI+9WguoQaXF8zlg88Ma8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(66899024)(83380400001)(41300700001)(86362001)(31696002)(36756003)(38070700009)(38100700002)(2616005)(6512007)(76116006)(53546011)(4744005)(54906003)(316002)(6486002)(6916009)(2906002)(6506007)(91956017)(122000001)(66946007)(66476007)(71200400001)(4326008)(8676002)(66446008)(5660300002)(64756008)(66556008)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEJJZDlPUjZXVUhkN3puYUlJSU1pU1FZbGwyQTFoQWx5MU1kckFKU0l1MUVM?=
 =?utf-8?B?eXZ3dUNGSVhpWm1IRmxiWGVVbEpTdFVVVDdSTWZ0VGZvTzRPYXlQY0hXSlVk?=
 =?utf-8?B?Nm1OOFdYc0xQZ1dPUWZaZXVwVVVRSGwwemVMMGUrSjgycFJKRFNDekdWWGl4?=
 =?utf-8?B?WXRBL0psVjN6bjZmMXp1ZnF4NHNZY1JuQ2FQaE8rSTRERUVJQk9mQVFWOTRY?=
 =?utf-8?B?V210NEI1VWkyMVVITzdtNkhkTnZXTTYzaTgvcjcrNWt4M0N5SEV5aDVQdHRt?=
 =?utf-8?B?eUN3OEJVZ0ZBdDFhT0diMnNkazVsckpPU2ExK3N4ZE0vL2Q2QU1scDNvMUVP?=
 =?utf-8?B?TDFPQ2xyb1dnN0h5Q0pBUlRoRkZ6R3QvMElLNWZYT2FGSWwvbVpIeHhhaE53?=
 =?utf-8?B?QktaS0hDRk8zV1dhd1RQWmtuTVpadzRGMUxpZ1Bzalh0Y0JFQWhEQWNIRmRF?=
 =?utf-8?B?bTlMWGlDN2dNNDlXbUVCSTVkeHFvT3JvYlBYN2VRU0t2ZkFYQ1VHUGtvc0ph?=
 =?utf-8?B?WGRadDZIRTR4TUNpOHNRMi9WSE1JcTNoVWJlQTlET3lndzF3WWtvNldHRzhq?=
 =?utf-8?B?QW9Ba2ZKWnoyNHhaNkFJVDNJNFVRajNqcExQa1VvQ0RLV2xMNU1qTStLYith?=
 =?utf-8?B?U2VDNnBrWUVwWm94amdVbEIvRzhmQzQ3Y3pWZ2pJWXF6ckQ3ZXppd2pPc2dX?=
 =?utf-8?B?dUV1eTIxZ2VtblRIR1dLV0dVZ2NTTDVmZXdPWmVITkNGcUppSGhLcXQyU0xt?=
 =?utf-8?B?N3BINjdvamhieUFLVlJpSklIV05kcHJDaWdDd2hCMlI0a05aUlpJaU9vNkxw?=
 =?utf-8?B?NlNyOGpjSkhVQWIyWkl2SEJWZEJxS3o4d3NQTy9mNFRmOWxxTG54N3NmSFQ4?=
 =?utf-8?B?ZjFwbHBqeEdQcGpYSzdjZlIwbGpsTTRhR0JueWFsa3hVSXlseHdoOEE0NUxa?=
 =?utf-8?B?a0NJVnRUMkZZVmI3eUh5SFZlSjFwL2Q2OTdLNEpXME9OU2VvYW1JMDVKN1N0?=
 =?utf-8?B?dXdrWi9XRXF4STN1OXU0QUpHSk9idGhuRlNHSDFUZk9RL25zTTgrUWdaODA2?=
 =?utf-8?B?WWx5cjVyMlQvRVRYNWpleFRkelFBRlpwUGErRXM1aWl3N2xVZUdUaHJVSTNr?=
 =?utf-8?B?WmxkclZwV3FqblRwMTQyenhIdkF2RFd4SXNyWlc3SGU1UEpxdEhFWUxWS3Bp?=
 =?utf-8?B?T1BRaUhvNzhhSDdNVWNwajlxemFlV0IzZmFITGpuSGVmS2hLZ1prSGNlMlZL?=
 =?utf-8?B?eW0yR0l2NUlxQzJWckI5ZDE2ZVJPdWpBVmwwSFdmK0xVcWNudjZwYW56TkpR?=
 =?utf-8?B?WDdOb1lGbERqUXcxYSsrbnB3K1hTSHVZRkJ5SzczUnpQaW1IVmFITFVWQTd0?=
 =?utf-8?B?S0dTSm1Ram1lSDBmVnJaRHNMVDV4cmQ4QVk4Z2dxM3VsWUxHZ0FrY1JDR0xl?=
 =?utf-8?B?NEhXRklIdmpReW5wMldRL3Q5UkUyaHJrZ21qd0xadXZ5Vm9kSXV0V1AySHNK?=
 =?utf-8?B?bStJUUtqNWFTaEg1bDYrWCs0OFllaThGczRybThvcjAzVzJMRmZaMWpaSkNU?=
 =?utf-8?B?TllxRUZKK0JvS2JFdG5oWlJYWEUvaE5xWUFTVjFEelZVNHhjUFhtdTBpS2Jz?=
 =?utf-8?B?YkcyT3dLQmJQMkQzTkc5em1QbXhTeUFSdis1MFlOQXF1V3lJak4ycy9hNUZv?=
 =?utf-8?B?bUtIbkQrNkdvSnpLWlF3L1p2dU40ZE05QVYzbFhXa2d5eDR1TnFQNTZzRnVS?=
 =?utf-8?B?a0lzMXR6dUkvV1JaanJZNFFkUE1aUzJCSW1XTFFPYnY1RzRNZTNNSXJpbFMr?=
 =?utf-8?B?QU9uNjkrcGZDSndaWkZaQW8zdUVCUHVKdkVtajVWQkdKa1I0NEdpTU93bGxR?=
 =?utf-8?B?MVpqMXZnaFZEYVpIUUNhc2xWUFM0ekFCenNnaDFNR2xid2tZZ3pQVlZzSmR0?=
 =?utf-8?B?Z3FmaFJZR3BJb1V5dlhzbTMvaVFLbzV1em94cXY4dVlBYTd4eW03eWcvSEtN?=
 =?utf-8?B?VlR5NUh4bE0vQ2RpejE1ZTJxZGNLK0FEb2FJbkptL2pWNGFYdGxDV29NOGJR?=
 =?utf-8?B?dHREVi9zSHBDOFU0eERCYmFXdXprY2YzRWpaRUFxbnJnUmhxcXpOakFqaFhk?=
 =?utf-8?B?TFR4WUF0aG1ZWFpCemVWcFIvQXB3Sitma1hQT3lMM01EQUJybndMQUVtelRN?=
 =?utf-8?Q?YImQOh40xoKk5BWK0aLmEqENXLDJMs133hBUzeVU1l6k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A94FB77456D0E74E8B1713F51FF17D54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3fa47e-3f96-42bc-5896-08dc22b1978b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:08:52.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTa+BrXI4D2sCw53a90x45KA6RGv9wchm1WeTpCCB9+JWzgVPDytAk39ZaYrXGJBxW6eLWzeBjtWkea2KCS4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_150856_636669_2ADC9D97 
X-CRM114-Status: GOOD (  14.63  )
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

R3VpeGluLA0KDQpPbiAxLzMxLzI0IDAxOjEyLCBHdWl4aW4gTGl1IHdyb3RlOg0KPiBIaSBndXlz
Og0KPiAgICAgIEkgZm91bmQgdGhhdCB0aGVyZSBhcmUgbm8gcmVzZXJ2YXRpb24gY29tbWFuZHMg
dHJhY2luZyBhbmQgc29tZQ0KPiBjb21tYW5kcydzIHBhcnNpbmcgYXJlbid0IGZpdCB0aGUgbmV3
ZXN0IE5WTWUgc3BlYywgYW5kIGFyZW4ndCByZWFkYmxlLg0KPg0KPiBDaGFuZ2VzIGZyb20gdjEg
dG8gdjI6DQo+IC0gUmVtb3ZlIGlkciBhbmQgaWR3IHBhcnNpbmcgb2YgZHNtIGNvbW1hbmQuDQo+
DQo+IC0gUmVtb3ZlIGxiYWZsIGFuZCBsYmFmdSB2YXJpYWJsZXMgYW5kIGFkZCBhIGNvbW1lbnQg
Zm9yIHRoZSBsYmFmDQo+IGNhbGN1bGF0aW9uIGluIG52bWVfdHJhY2VfYWRtaW5fZm9ybWF0X252
bSgpLg0KPg0KPiBHdWl4aW4gTGl1ICgzKToNCj4gICAgbnZtZTogYWRkIHRyYWNpbmcgb2YgcmVz
ZXJ2YXRpb24gY29tbWFuZHMNCj4gICAgbnZtZTogcGFyc2UgZHNtIGNvbW1hbmQncyBhdHRyIGRl
YWxsb2NhdGUgd2hlbiB0cmFjaW5nDQo+ICAgIG52bWU6IHBhcnNlIGZvcm1hdCBjb21tYW5kJ3Mg
bGJhZnUgd2hlbiB0cmFjaW5nDQo+DQo+ICAgZHJpdmVycy9udm1lL2hvc3QvdHJhY2UuYyB8IDcz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA2OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KDQpPbmUgc3VnZ2VzdGlv
biBjYW4geW91IHBsZWFzZSBub3QgYWRkICoqKiBpbiB0aGUgc3ViamVjdCBsaW5lID8gdGhhdA0K
aXMgbm90IGEgY29tbW9uIHByYWN0aWNlIG9uIHRoZSBtYWlsaW5nIGxpc3QuDQoNClRoaXMgc2Vy
aWVzIGFkZHJlc3NlcyB0aGUgY29tbWVudHMgcG9zdGVkIGluIHRoZSBsYXN0IHZlcnNpb24uDQpM
b29rcyBnb29kLCBmb3IgdGhlIGVudGlyZSBzZXJpZXMgOi0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

