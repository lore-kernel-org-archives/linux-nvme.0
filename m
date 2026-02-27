Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479CB104891E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YW585wlDaYdc21wQAmz+pF0FypG+qj7RS16MBTsLffQ=; b=ySZ1UKO6qRQw6wqVhhmlaqk8ga
	uRDVLmoQzIu0krrXyxLv+ES1Wd9Y1Uzb9WwmjzGyXOg4RCw/ohIQfpPqxFPhSAPibdwi8TW0w/80X
	1JCYiY4xj0F1EK3DvrtTq0cO5v9+KjQvL30Iuk/mcJj7mYYFxkPQM1nMap9WP7uRjxSiTlHMk047c
	6sddO19c2qVKWVTsLOL7LsNpzR7qtTseYAqxzWfIkfE+SLV6dvyiz1Jmx4aLxMukNvCUXtBwpp5ti
	iqd3C7DuQ9lqs+e4DAp7lOFmmcIRXDF7TK0uJarHWk0s73VXQXAjNFLGVx0MzA/9yB59a1+PBjg7U
	ooPRChpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw710-00000009FvJ-3f72;
	Fri, 27 Feb 2026 23:12:58 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw70v-00000009Fur-1p3T
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 23:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNeByzJeqGVrunj9cdIfdvO3ICoszCuz0Woncglygd1cGecqjc2UErK5sLo6g1ikuIAu4Iei8MaW5viZGa5sPGHHwCdZ0sSsYA7ZgXwVjV5tojd6zWE/hMWIgFOGGbicMtaX0jICQy7ItzaAMh/Y1hRnr27mNxo03DbtMtdghao5iPkjciiBQcl3J3Dh7KNeknyTjN+0E1pmnrgsZulO0zEMq8aIfNTfxpvxcHwdrGQLxm7hxrEF2BW/PNnrasuDOi1BXjl4qLR+up64h1nBxPTfoSe3U3780wAkyKOCMHgcGrrOMHrQhTEQ9HQZC+HVa4zKscVVH57gXKeMWFRWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW585wlDaYdc21wQAmz+pF0FypG+qj7RS16MBTsLffQ=;
 b=BUBrIYwGF29L2maSPZog6RVIkCIsvutOn0eo6XCDholnGno41iZiVFUE99BHjHkoutEIAKlnaXGnG1sxuNabTO565X5IGL/9ghXJ9GJM33AlEPKChRKLN3B7Y5yxcxJUZTwefORG22h0bRoVBYp+GXwfdq9vBHNFlvB71uj8rofADTop/oaiavoY7OmQ86Ub54Jc53Kl4fd1Lk9q/PPPYzQeV1La9s9jvhhuKV60rmJdTyf5gAmoloKU+EB4KUQmYcH6R1g1ll3OWqsSyELUbYjiDuw6y4k42BQzWyahuUnAfDEbMHzpC9MYwY10pviJKjx6zCpsT8P+oo/cphpgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW585wlDaYdc21wQAmz+pF0FypG+qj7RS16MBTsLffQ=;
 b=WMFOAtjSkh4L72CLg/puDqaX8VXXRkQGcOHV3ZCaEts3e10jzAssaSebjIHp1GfwVp7I0I7dDfqwr4B35OpHC6znVZIvcBbVh8hG88OiY/k4ABFvbV1HHU0+yutkrtXV5LbnC/RADLW+vuUj41IvsrwF0mfa1bHdCibeVKWjJQbwsDbS45KNSW2ReI/pL1nmyYAx3cAsYw/bgfaDBJPKo0d+z/AuDh+8KHE7urLKnB0yHik6NOSLfkzxZ9ZMPdS/9hDQzkQQVC1/Sd/QI5ihoKPEKdAM3YRib5Q6C+QQ8E2PD1ph4MM9YM9z2TkaMqax/6FAD/Bz8GAuPdyDePEj3g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 23:12:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 23:12:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "nilay@linux.ibm.com" <nilay@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Thread-Topic: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Thread-Index: AQHcpsuyg0Dk+C1Zik60fgvuDocUaLWXL5GA
Date: Fri, 27 Feb 2026 23:12:45 +0000
Message-ID: <1f2272c6-f6b8-4a82-a49b-d651fe19a823@nvidia.com>
References: <20260226025658.86496-1-kch@nvidia.com>
In-Reply-To: <20260226025658.86496-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7109:EE_
x-ms-office365-filtering-correlation-id: 20743a5c-b0b8-4b7c-fd42-08de7655b799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|13003099007|38070700021;
x-microsoft-antispam-message-info: QwiWkEmFh6owVnNdXr8RKW4ZNwJb0GxdyHgloYshw9vQLTNEe1aqwjzmgoYqB5T6x2Uf/Mgfs8zDUYeeFbMSymkJSEojQzAw9x/M9nmhBF+W5IvdDTsPud040G8T9p+A70hjkqTBhPHwGQxpE++mrfSNGt3eB1nIm+nNDkBaarjLsTyFyWWQhhPVlzDFIv0vsVMF5X58iCZBMkC/+6N2/nAOblt+PKKuRUmCrOdDdLK+Fm4+8gQoovtQ7ON5GpDtzPqgnMHsBbvg7vkES32CTXW4gMMMmpic056yGyQhswBehbq9h7NEH9rtue0vPKK4Q4u9ellcrPWvmw+s2dcmoOY+amvokJ6dHLpuj8qAbS8A1U+hMr5NmO3FZRXLr+0lOW7ez95y/nF4u9sBwIyCVmY1eqR5Hu1CILsVE42YvIR2c4dvkOvGwQA/7Ph3eYF/u+FP49eqxBUtlulHI/r7A+Ec3RTgEWR/fvp21hR3EdBywYsWMAFpuK02g6FFPIN4P4bPWoWETOoVHxYYIVfVr9o0GktFxiZFH1/eVHvMuSJysU2twVqSE5sBi4iJTUd02QcV2LQm+eKOXZVH/gudKvF2l01mvYNUEhJq8n3eBuTj4if+0PF72xxHOHXCK6N7zEWxUANmslvd+7ID+mpO1FYtyqVdJFX5ad08/8akUD6DxjE8MJnIdRvUIwflmeEwlHnxO0cDQ47rEqTNxs5upFrWNaPUqJ1swV7eT8UUQ3IXWjRPx52/PqwrLbNjF/trJyNbFMmZpwMgN9J7WcLMrR/7kit/CDNtkz2QtPpKaFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXk1Ulh0Qm9va3ZrRkNxWGw3TWl1MDZpakpkR0k2N2c2M09Eb1hmb0JGbWZw?=
 =?utf-8?B?bHl3aVRhb1hIREtWR1RKSmlScU5SSlJVVGxuMEE5V0JiMDBrcEJHc2JoV3kr?=
 =?utf-8?B?Sng4V1lZWkc1NTdKM0hCc1YwazlRQXNNdE4yQWRYdVQ1MnpZVVhPT1ZkR01G?=
 =?utf-8?B?amdCU0RFRE1WWEJrNWRhTWx1L1lCU2NBdFMyMXBiNndaOGdkSmFhb1NUbW15?=
 =?utf-8?B?UUhodk5CUWhrRjY5VlZwTFBpQ3BsZE1QLy9oWTNiQzlOWDd3MUlRWWoyMCtJ?=
 =?utf-8?B?UWVvUkp2dW45ZXdBMXdTeEV4S3FBRXdlOWhRdWl3UFh6dVUrbzJvSjgvQ3U1?=
 =?utf-8?B?V0JHOHFQb2FPcXpjZFA2UDNNY3RCNkoyTVdZVGZ6SkpoY3pmNHBUeWpsRE0r?=
 =?utf-8?B?YXQzWUtyb0cxUE8veWgwcnVsK3lPeTFOTlJLNUdGSks0bXo5aEthS0ZlellT?=
 =?utf-8?B?SmFmVThlVjYrZGpBUXR5cWFuVklJM09Wc0NzNGphRGV6c3NrSXU4c05oNmk0?=
 =?utf-8?B?V1pCMmw2SVpMVVFtdTNQMkM5QllQVjE4VTk0QUFKMW5PY3ZhR1BGSXRXTno4?=
 =?utf-8?B?V25MajlLdExHdllhOUFwVmR0RHhWVXRiZzBwRDNMTSt1bzlEbm43djZrN1Vw?=
 =?utf-8?B?bjZyN0N6TFpWRzhHa1pPdWh1bjFGWDdJY2Z1cW40bHlBc3AzRktzNTJiTzZH?=
 =?utf-8?B?S1JRWUtqMWdROXlYY1FmMmt6T09ub0hqZzVwajlJT0hTQ09hd2xqd0svTjRJ?=
 =?utf-8?B?TE9nTkpOeHpvTFhWNXR5NTZSMG9rcFQwTWF3MXRKaUhMZ01KSHoxTkRLWjkv?=
 =?utf-8?B?MGhIdkxZQngwbTV6ZWpSc1pGeGJaUVIwYkNzOEFmZUhUWFc4WWticlYxWitx?=
 =?utf-8?B?S1VDUmx5Qkw3RDZqQ00rb25NVXRHK2FUTm5sWXBXZE9Pcy9rbFh1SmpJUUNp?=
 =?utf-8?B?NHJ5M0ZOdk5MMTdaVC8xcGU1cFBEQ1Z3L1JpWkY2WTh1TGJ3OGhzUlhraE1j?=
 =?utf-8?B?K0VuaXFaVENIeUFoajJETTQ4VWRyR1UrblVDaEJaSWQ5NFFmRHhiU3ZQaEFu?=
 =?utf-8?B?Qy9TeTlnU3cxYWtscDgzRXJLQWRUZTFnOHFXZGNYUjA5U0lMK3F4QUZCOHhE?=
 =?utf-8?B?WDhUZk0zSnRwQkJYaEhob3N4aVAyTzJCemxOd0hMc09BUWNNRjgrUi8wejZG?=
 =?utf-8?B?WjdWeEpTRUUxOHJESllyR0NsYUNmTUh2M2w1RSs0RThnMjZiUHQ1d2djSHNo?=
 =?utf-8?B?cmFUMXJ2MjRRZ2hWMzd0YUNxRE4yaENzNWxmYnorZ1dacEYzUmE0bXhFYUlJ?=
 =?utf-8?B?R2RUb2FVaDMxUGtkWHlZMjVTN3N5MENSd2lDLzcrZ3l0VFhJT1BSeFNpZFJm?=
 =?utf-8?B?Z0hpQnVyZkxDekxUVkt4bmFZRFZTUkx0cSthemZTeGJUdDhwRHJiY2d0Zisr?=
 =?utf-8?B?MEgzajhXZ1lKZFpEL0ZjZjZhbXh2RjV6dVZrUHBaaGE1RTZVUlkvSmVQaEpN?=
 =?utf-8?B?TStwYkVucWxkMWRVT2gzc1ZISHNkN1JjTnBWRWxhUkFzZjc5Zkg1T1kydDc2?=
 =?utf-8?B?QlQ1VVM4OWlHSGEwck5pWE1yanF4SHFoMUhmckV3NVYyVXAxNzI3Y2hGQjNE?=
 =?utf-8?B?aUhnaXlRN0c3bGZPUmxLUWVhT1JoRkVCVTZLaWlyeFBjaWFOOGtSMGtCY05y?=
 =?utf-8?B?djJkZXVCTk1KSnR6YWsxT3ZWNmQxN2FIRGFGTWJaMmR0MmQ1b1BtOWVHTzN0?=
 =?utf-8?B?aDZnd0lMN09vMzhDaEwxTDZqZjgvSlh4WnRVSEtqSVlGRVF6T2U4Z0xQL2NT?=
 =?utf-8?B?RkVhUWZIcHpGWDlqZTJFamhxTVM5RjV2eTRobFZpQ2pFenFIV0VZWm1jSTFz?=
 =?utf-8?B?TGZ3YnVqcUpxcWFGc09IV1FOc1p1WUFUbFFyeHMySXZiYjVLenY2OFZPcVRu?=
 =?utf-8?B?bTdBOFRrcFhMZVJiREdHdW1ndjBGVlNmZDM5WXVHYVl4aHh3QW5DQVJIZHFE?=
 =?utf-8?B?MzR4RzBFM2ZBeVhsSXZscisvREg0RG10SHhZUmRxTlJiWHBqTFpQbGRjbUln?=
 =?utf-8?B?a0FJcFl3RWgreVRMT0pIUTRpdW1sMmY4aUZMbHI2aHFSSEZSa2dOR1o5bDdJ?=
 =?utf-8?B?dnBIWUF3ZVBGcXNDcjUxWVNyaVVJc3pFV1NicXZCK0lTS2RGbHlHRHY4ZTFZ?=
 =?utf-8?B?L25PMkg0NExvSlNVeG9oMDN2NE5yV09IdW9TaFhqRUxVSG8zVFlWZ0VCeTdM?=
 =?utf-8?B?dDhEVVJVUVZoLzRUb3hib3ZwNmd1T0VhUVdRbld5b0ZiVmZWQ0QwTUtKWTli?=
 =?utf-8?B?VEdiSVpzL0JxNG43UHkraktBRzZvajlGV2JyL3pESVdtYjMvaEJxem1KNG0v?=
 =?utf-8?Q?DT/F6tr4yT+YJChdFV9aqkHoQwI/vq8I17n7Fu8fxoyQg?=
x-ms-exchange-antispam-messagedata-1: VUF+5XNcESKd/Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1996921CCC5AB42AA41E84FAF2BB907@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20743a5c-b0b8-4b7c-fd42-08de7655b799
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 23:12:45.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bprx3mv8T3QqfZn7Psw+w8FdUDYPGl5FTpsbPCkwz5nIyMUuyyk++6mmV0okvznI0LbpeoeAGh8NnGI+YmvUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_151253_498929_13F9DC14 
X-CRM114-Status: GOOD (  14.32  )
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

T24gMi8yNS8yNiAxODo1NiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBXaGVuIGEgY29u
dHJvbGxlciByZXNldCBpcyB0cmlnZ2VyZWQgdmlhIHN5c2ZzIChieSB3cml0aW5nIHRvDQo+IC9z
eXMvY2xhc3MvbnZtZS88bnZtZWRldj4vcmVzZXRfY29udHJvbGxlciksIHRoZSByZXNldCB3b3Jr
IHRlYXJzIGRvd24NCj4gYW5kIHJlLWVzdGFibGlzaGVzIGFsbCBxdWV1ZXMuIFRoZSBzb2NrZXQg
cmVsZWFzZSB1c2luZyBmcHV0KCkgZGVmZXJzDQo+IHRoZSBhY3R1YWwgY2xlYW51cCB0byB0YXNr
X3dvcmsgZGVsYXllZF9mcHV0IHdvcmtxdWV1ZS4gVGhpcyBkZWZlcnJlZA0KPiBjbGVhbnVwIGNh
biByYWNlIHdpdGggdGhlIHN1YnNlcXVlbnQgcXVldWUgcmUtYWxsb2NhdGlvbiBkdXJpbmcgcmVz
ZXQsDQo+IHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gdXNlLWFmdGVyLWZyZWUgb3IgcmVzb3VyY2Ug
Y29uZmxpY3RzLg0KPg0KPiBSZXBsYWNlIGZwdXQoKSB3aXRoIF9fZnB1dF9zeW5jKCkgdG8gZW5z
dXJlIHN5bmNocm9ub3VzIHNvY2tldCByZWxlYXNlLA0KPiBndWFyYW50ZWVpbmcgdGhhdCBhbGwg
c29ja2V0IHJlc291cmNlcyBhcmUgZnVsbHkgY2xlYW5lZCB1cCBiZWZvcmUgdGhlDQo+IGZ1bmN0
aW9uIHJldHVybnMuIFRoaXMgcHJldmVudHMgcmFjZXMgZHVyaW5nIGNvbnRyb2xsZXIgcmVzZXQg
d2hlcmUNCj4gbmV3IHF1ZXVlIHNldHVwIG1heSBiZWdpbiBiZWZvcmUgdGhlIG9sZCBzb2NrZXQg
aXMgZnVsbHkgcmVsZWFzZWQuDQo+DQo+ICogQ2FsbCBjaGFpbiBkdXJpbmcgcmVzZXQ6DQo+ICAg
IG52bWVfcmVzZXRfY3RybF93b3JrKCkNCj4gICAgICAtPiBudm1lX3RjcF90ZWFyZG93bl9jdHJs
KCkNCj4gICAgICAgIC0+IG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVlcygpDQo+ICAgICAgICAg
IC0+IG52bWVfdGNwX2ZyZWVfaW9fcXVldWVzKCkNCj4gICAgICAgICAgICAtPiBudm1lX3RjcF9m
cmVlX3F1ZXVlKCkgICAgICAgPC0tIGZwdXQoKSAtPiBfX2ZwdXRfc3luYygpDQo+ICAgICAgICAt
PiBudm1lX3RjcF90ZWFyZG93bl9hZG1pbl9xdWV1ZSgpDQo+ICAgICAgICAgIC0+IG52bWVfdGNw
X2ZyZWVfYWRtaW5fcXVldWUoKQ0KPiAgICAgICAgICAgIC0+IG52bWVfdGNwX2ZyZWVfcXVldWUo
KSAgICAgICA8LS0gZnB1dCgpIC0+IF9fZnB1dF9zeW5jKCkNCj4gICAgICAtPiBudm1lX3RjcF9z
ZXR1cF9jdHJsKCkgICAgICAgICAgICAgPC0tIHJhY2Ugd2l0aCBkZWZlcnJlZCBmcHV0DQo+DQo+
IG1lbWFsbG9jX25vcmVjbGFpbV9zYXZlKCkgc2V0cyBQRl9NRU1BTExPQyB3aGljaCBpcyBpbnRl
bmRlZCBmb3IgdGFza3MNCj4gcGVyZm9ybWluZyBtZW1vcnkgcmVjbGFpbSB3b3JrIHRoYXQgbmVl
ZCByZXNlcnZlIGFjY2Vzcy4gV2hpbGUgUEZfTUVNQUxMT0MNCj4gcHJldmVudHMgdGhlIHRhc2sg
ZnJvbSBlbnRlcmluZyBkaXJlY3QgcmVjbGFpbSAoY2F1c2luZyBfX25lZWRfcmVjbGFpbSgpIHRv
DQo+IHJldHVybiBmYWxzZSksIGl0IGRvZXMgbm90IHN0cmlwIF9fR0ZQX0lPIGZyb20gZ2ZwIGZs
YWdzLiBUaGUgYWxsb2NhdG9yIGNhbg0KPiB0aGVyZWZvcmUgc3RpbGwgdHJpZ2dlciB3cml0ZWJh
Y2sgSS9PIHdoZW4gX19HRlBfSU8gcmVtYWlucyBzZXQsIHdoaWNoIGlzDQo+IHVuc2FmZSB3aGVu
IHRoZSBjYWxsZXIgaG9sZHMgYmxvY2sgbGF5ZXIgbG9ja3MuDQo+DQo+IFN3aXRjaCB0byBtZW1h
bGxvY19ub2lvX3NhdmUoKSB3aGljaCBzZXRzIFBGX01FTUFMTE9DX05PSU8uIFRoaXMgY2F1c2Vz
DQo+IGN1cnJlbnRfZ2ZwX2NvbnRleHQoKSB0byBzdHJpcCBfX0dGUF9JT3xfX0dGUF9GUyBmcm9t
IGV2ZXJ5IGFsbG9jYXRpb24gaW4NCj4gdGhlIHNjb3BlLCBtYWtpbmcgaXQgc2FmZSB0byBhbGxv
Y2F0ZSBtZW1vcnkgd2hpbGUgaG9sZGluZyBlbGV2YXRvcl9sb2NrIGFuZA0KPiBzZXQtPnNyY3Uu
DQo+DQpDYW4geW91IHBsZWFzZSB0YWtlIGEgbG9vayB3aGVuIHlvdSBnZXQgYSBjaGFuY2UgPyBT
ZWUgYWxzbyBbMV0uDQoNCi1jaw0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MTEyNTAwNTk1MC40MTA0Ni0xLWNrdWxrYXJuaWxpbnV4QGdtYWlsLmNvbS8NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MTEyNTAwNTk1MC40MTA0Ni0xLWNrdWxrYXJuaWxpbnV4
QGdtYWlsLmNvbS8NCg0KDQo=

