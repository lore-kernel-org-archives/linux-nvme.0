Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92589FD461F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ET66becN5NVuXcbgq/7FSqfderU5ByLgjsnH2+P97cc=; b=SqhszK7MJdJrLUzmiP3Hp9u4Kq
	6p7Vj5Y87+kpbYRljYPArY4lbxq5DQGtavHPohMCKuVMyeGhJa28G4gIkLJg0ES5/MDE2mP2ccVN/
	TqmZHfVtXe1jTbgsaL19opgRDIufIOo/X6pdn+8vxLWOEMFZjMEsErY9QLH6RpWa1d8hPBCHq06b6
	mhQz5DCliLDSCJN9BgEaYt7VOnU6ZX6FOXnIZciuPVu/vc1qM2RHX1hzZybnNuVyo23IlFMFt4OQb
	OTvat+JYlp6P6SSzWyNWiQBkqVL43v6GZocPmoyeToUz5eVRSICgWJQJDvakabl45mzq/IqFjMaLr
	kCzsW3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvU4U-00000005Qwd-0UQH;
	Thu, 26 Feb 2026 05:37:58 +0000
Received: from mail-southcentralusazon11011043.outbound.protection.outlook.com ([40.93.194.43] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvU4R-00000005Qw7-0lHH
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 05:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLPTT3hSyyYXaa5jwKVovOcvGBdI0VegWmKxk8SC9KBUfkR6HgE4BoEuEcbnGJ2lZH23l624zz9URUT9Xdro0434Vn7X/e+47U4Fj9XirwsT/phZlNGfZnzUZ6gSwcAgcz4pkQe8vUk0otHmAtPMvnzbSEh7Gv/sb0GbQk8fAqzzKSpSprloRiSAI5xoUlgzbTbNY7wJgYKtWyYB/V5nv+hZUthvrGo48m546UZqw6J0Sp1Syn8V2cyAyjAmtIGgXE1iu/TvtchxTZnHQVp/RyQnS234jH+AMjPO1udWKjWPWwsWq/eZx+WlDgwzzrHmsPeSgmD+7nYx0PHXFRAi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET66becN5NVuXcbgq/7FSqfderU5ByLgjsnH2+P97cc=;
 b=r0xtBFkH7lvQYfZeZ3ZroRL5BjHIS+23oPGaneuC7rP2CRwuFdz4iU6vFbKn4M3ZSPsvZXY0SINNsbqlVH1uBDL0UbQdxrJEYkWQx6xyBiMtw5T5sJiZhs4eOHZS5X6zp8tG4WpdxCaz/N3s+12b124XsCSfjHxx5ExtGbhSPg4ODpalzLbi3DpNzO3rwOowr7y9URAoLfEWtqM+N8h2PYZUP587wL2gvIj7rQLZ0KOI2RJ83fwzB76GV9b6XM1gj6eNu9XUBMOdyMsgqfY6c/BKwi+X8l+2leCO/UDIwCJcgGMNvzb0GcvLvWA0LUKTZypw7A7EYvVVyaplcaEY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET66becN5NVuXcbgq/7FSqfderU5ByLgjsnH2+P97cc=;
 b=rpdvTGdZqpw0Ni7lBvo2XsTeQzEdb6ZcRVAkH4zK/1m0gaQpgIUU+LNFe65zxZLFZn1o9kGVyLvRlJ68OAlB9Zm5F9dU/B3BHIE1GM3g8UN9ZiGcujk8BLoWy1434nCPs4fwfJgllHD8B+2esklwHIPeGyvoOds2+ZDebT815btizXxnZ6MIJER/pK9UsDgZo6Qck4OS5U+yqH7X1H6mq7d5cug6xuQigfbU6438qe1XN7qJJ1z0KGMnf0FMDzy+ktqtBfeNVpVb0QwpU02eaEdAGWq8ATc96ahs6M8DpeQIs3veeHgbEr5n0gQPxJLPTPdYbfecpne72AAcsHzihQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 05:37:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 05:37:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>, "dwagner@suse.de"
	<dwagner@suse.de>, "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>,
	"gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
Thread-Topic: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
Thread-Index: AQHcopGBBLZhmUADt0CXXuiQTAX6tbWUfvCA
Date: Thu, 26 Feb 2026 05:37:47 +0000
Message-ID: <1a1fd537-e0b8-4128-a1f3-2b71965b6f06@nvidia.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: becc42c5-f492-415f-a9f1-08de74f92ca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: fxgDqhb08YODSehTCXdwV4wmg1m/Js0H6VTYcMVQ1s7DAq4XN8d+VGiZLq6jg2Jw45quzJM+O+5B9GK5ep9bvlft97JnPmNPHyyvDmarzFPC89Dq0llhEe3NoBZGLtPC9tOY8AKqwdmnvlwfFhh/Jt+DepxjFss7xrR2v0mcyUXd9jzgVEbFXeyB72cS1c5fWR+RriVhEnDD6Mdcf1rBhilq+BwfyoSrxBFXRmi/WZCo70gzb/VnmoDQWVGKspLjGLQq5hjysV6I2jVJthi5+bQEkXfQMPeW0kwN34+jV4/sNsUYacV0jojq+eiNwFPSsjW2N+wSrJjxviPWt/TGh1RKtJptqhXur4j3oq/cL2KfTePhdT32or3h0y6dNwKPOkxWn8kz9s2ntnBsQskA/ZN8dF2qOhnRvR2AqMNkCG/ja+gurnMcD+uXQeZs5jQiRNlHA63epZPi9KTtU6rIYDy+5f6M3jg9jHEbUb04P7Clu02ngvw4Gy0cMACf8+cLdyb6vnGX+6ptw7tVv1F3h9gj09mLk+ZKAlJKEdyf4YIGhYrgYkbsj1cZmmKzXsOPBo7pYfStHKva8rw3/ojkTF0H1EzCYnMv2wDJ6T5eVoma08eWSfma0yhmtewDMqMQC+eJfC9erH2lgwsyDavBOMryv+UGfGmJd/itgH222V80ZrPOInymbMQaOly7/YFEOSsgWTDCmv1Lo4poFi+Vmh9UXgOFYh8ftltsV8lQ5R5veaPkm9ScS+vwfsIZjkW2IKIPDIYYnVtOFll77k5XVvBZBPEjMjCHxxB/YMoCo/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFMrWHJiZGFCNkdJRUFDRUlMbjhLdjloVUF3UWx6aTdNd244ZW5kZjhFdlV5?=
 =?utf-8?B?M21HTlJPejE5RnlEbUpKdE5nVndvUXc1aTZ0S2pnaERJc0x2bEZMb2l1cUZo?=
 =?utf-8?B?K0MxR013bTREMDBJcTBiTlV6djJhU2Z2aHBsbVJBd0NCTWt2dmY2T1NZaVRW?=
 =?utf-8?B?dm1tbm4raFpZbXZVajhJdjhzWml6MjdrWEZuNElPRjZCWXB0b2dRaVU5Uktk?=
 =?utf-8?B?V1pmQVBEc3hYWm1FejBoemhqM0d4Znk3S1ZnZGpzdHpvT3FmTElVV3d0VVox?=
 =?utf-8?B?QWJFSGVyc2ErWEtWbjNYTmlhV2s0MDRGRE9Gb0tTRVZNcnpkTGtrSlZkV2w5?=
 =?utf-8?B?WkliTlRudjBWZDE3NGgwdXorZHZIYk1FbFpBU2VFdkdLOTRYTEQ2R0VyUDIy?=
 =?utf-8?B?RFpmM2E1ZWFsSFZ4SDNtUjJXWHAvcWdselp6UlVaTE5vQlNqWlY0VmEwcnlU?=
 =?utf-8?B?MTdWS0lFYThIREwwMHVlV3BUdWdNZ29zczdkT0RTOTI2akRpVS8raHhiL21M?=
 =?utf-8?B?OGMwVVdvZE5vYzREV3BXVEZ1ZklITzJEYWFVWDVLTUpIZDJhYjFuaGdVQjAw?=
 =?utf-8?B?N3VieUxiRVcxcTdoUGtlRUU4VGdROUVBZFpLT05yVlQ0bHh1ak4zMmVrdFpv?=
 =?utf-8?B?SzdpcDQwdkViS1lxeFJqcU5rM3A0cWdHTk5SdlFIeVYxakV2Mnkwcm9tbVNW?=
 =?utf-8?B?RlpWbkJDcGdKaFRVUitUSUdDenZIVGRQNEZQTDJhQ2RRbGNJMWpBVEhDRHFo?=
 =?utf-8?B?aE94WUs3ajVJZENGMDFvYVo0V3VPZ2xLZnZFU2U4RW15ZktBSUNVQWd4Y3My?=
 =?utf-8?B?TWxORklmWkl2bkRZMEFUYW92SVZhSStRZmNNR1YrNzJQYWlzbS9oTFV5dktF?=
 =?utf-8?B?ZVM2V3JtWFk4T0o1L1RVY29IdnQxLzRFVkFFUHBDaHNGSTZFVUQyT3hucTdh?=
 =?utf-8?B?ZTk2VnVmTWNrcUF4cEJ2RGEydnpCMzlIWG5mMThKWHlkdzFHM0dFdFhHMTcv?=
 =?utf-8?B?WGpqNk5PNnlwUFpyVzVGck41YjNvT2w5U2xySnV3ZFlmcnBvRm5lcDFmbUs2?=
 =?utf-8?B?QzNTYlZOamhpeE1iNk5wbCtsZE5XYTF0Y1BZdUFwTUp6OExaK0k4ai9vYzg2?=
 =?utf-8?B?Zks3UjQ2cnlHWkdQaE13Vmc4MTl5RVQ3U2Z4eHFQRVNsY0w0RG9xTEFsNUlL?=
 =?utf-8?B?cHE1dEo2VmcxUHVEb3Z3aXhaOXZ6T2hCQTQycG53TG5WaXVOZ05heDJTMmVV?=
 =?utf-8?B?U3VHWFN2cTZ0Qnp1c3RmdVdNTXprTCtndlkxUFFSWVN2YjBwMXN5bUhCVEwz?=
 =?utf-8?B?TjNqNUFkY2hiVk16dXZkVVZTTmR4c3lndS85MHF0TS9HdkxFMVY1TFN5VnVi?=
 =?utf-8?B?Zkh5WlFuV0NFM2VHbjJzMStVS3VpdEhjOUV6MHNMbDVaanA0SGgycGNzcVlC?=
 =?utf-8?B?UDVLYVdrSjZtSnJUT2trSjVrVy9vNzVDVnY2eThmR1gyckI4YUtteU01bUls?=
 =?utf-8?B?ZjJzMUdQbnhZTkVpRGdxR0U0Yjdnayt2WGNHRjRuelpsZzArWk0xWS9zWjF2?=
 =?utf-8?B?aENGY2sweG1OMjIzVlR6RTFDM3p1b0JsTGY2Myt5Sll5NUU5dlNJYkhtS3Zi?=
 =?utf-8?B?VjdBSjhJUkpIWG8ra05nVCtGTmwwQThOL1JMbFFWR2dLVW5hS1VjYVhhL3RC?=
 =?utf-8?B?dEo1Y2p2elljUzg1bDdXcVFkYnVyaEI1dVFKLzI4QmVPTFh2ZnVXRjdad1I5?=
 =?utf-8?B?UDhKUWJtWERhYlZUVktpSFRlUXZqcDN3dkVSayt2cjh3Y3VDUCs1TkIwZVJD?=
 =?utf-8?B?NTYvZVZwN0EvWGVPOCtuY1FBeFgyUUZyU2xZdFpES3A5M045YU5ZU0FObzNE?=
 =?utf-8?B?YTZhRzh5YUg0U2lGbDdCaUkyYTh0azQyOEtndkdEV0hzL0xQS0RNQmVVbmdE?=
 =?utf-8?B?VHUvS3FPMGZFSTdvd0J4eXkrOHNtWDBuNVQxTEk5c0hqYzYzeXJHRU1zMGNQ?=
 =?utf-8?B?Zng0bzZvT0lQMUM3bDJYV3pvTStqL0VEc0t5amFnekJ5WVMwS1VwVmJ1NlZ3?=
 =?utf-8?B?WkU0YkUwelhUUHJUaFVobG9lVnJEVzdXMmVhQnFkYVd2a1ZHbGpiQmVnNnFl?=
 =?utf-8?B?SjMwS1Vwc0ZQNDV3S1lNRmJnc1NHT2dVdGs2WEVPbHJRcEFsYWFXQkpEYkM3?=
 =?utf-8?B?Q1hycmtLVGszd25sVy9QeC81L2dlMVZhRFVFUmhQc3ZOTitaS1hNalVWaXMx?=
 =?utf-8?B?WU1IVVFWeERKRmtSTExIV0FmRFVoV0lUNyt2SGZSVXNuMVp6N3EzNVRsbFla?=
 =?utf-8?B?TzcrSWdheVR1VEttTG9wV1puVGN3cXZ1WVkyTWdIbnVVd2pYTjlBNzR6ZVho?=
 =?utf-8?Q?JbTYunwvEB4jxEkOAyg2McP5mblYTlH98vLbUTpexKnti?=
x-ms-exchange-antispam-messagedata-1: jc/eqFeZftD/4Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <69505990DFC5404FA74F3A82F5530388@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becc42c5-f492-415f-a9f1-08de74f92ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 05:37:47.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob+yaxyucJSdyd3CL07sSKdBk6KWKvDNOtGQtSBISkNCRiRtIml9gJgqaq8CbXGI4IbC7UI20XCaWpY81tgLZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_213755_234458_BA0FE471 
X-CRM114-Status: GOOD (  12.40  )
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

T24gMi8yMC8yNiAwOTo0OCwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBIaSwNCj4NCj4gVGhlIE5W
TWUgZHJpdmVyIGVuY291bnRlcnMgdmFyaW91cyBldmVudHMgYW5kIGNvbmRpdGlvbnMgZHVyaW5n
IG5vcm1hbA0KPiBvcGVyYXRpb24gdGhhdCBhcmUgZWl0aGVyIG5vdCB0cmFja2VkIHRvZGF5IG9y
IG5vdCBleHBvc2VkIHRvIHVzZXJzcGFjZQ0KPiB2aWEgc3lzZnMuIExhY2sgb2YgdmlzaWJpbGl0
eSBpbnRvIHRoZXNlIGV2ZW50cyBjYW4gbWFrZSBpdCBkaWZmaWN1bHQgdG8NCj4gZGlhZ25vc2Ug
c3VidGxlIGlzc3VlcyByZWxhdGVkIHRvIGNvbnRyb2xsZXIgYmVoYXZpb3IsIG11bHRpcGF0aA0K
PiBzdGFiaWxpdHksIGFuZCBJL08gcmVsaWFiaWxpdHkuDQo+DQo+IFRoaXMgcGF0Y2hzZXQgYWRk
cyBzZXZlcmFsIGRpYWdub3N0aWMgY291bnRlcnMgdGhhdCBwcm92aWRlIGltcHJvdmVkDQo+IG9i
c2VydmFiaWxpdHkgaW50byBOVk1lIGJlaGF2aW9yLiBUaGVzZSBjb3VudGVycyBhcmUgaW50ZW5k
ZWQgdG8gaGVscA0KPiB1c2VycyB1bmRlcnN0YW5kIGV2ZW50cyBzdWNoIGFzIHRyYW5zaWVudCBw
YXRoIHVuYXZhaWxhYmlsaXR5LA0KPiBjb250cm9sbGVyIHJldHJpZXMvcmVjb25uZWN0L3Jlc2V0
LCBmYWlsb3ZlcnMsIGFuZCBJL08gZmFpbHVyZXMuIFRoZXkNCj4gY2FuIGFsc28gYmUgY29uc3Vt
ZWQgYnkgbW9uaXRvcmluZyB0b29scyBzdWNoIGFzIG52bWUtdG9wLg0KPg0KPiBTcGVjaWZpY2Fs
bHksIHRoaXMgc2VyaWVzIHByb3Bvc2VzIHRvIGV4cG9ydCB0aGUgZm9sbG93aW5nIGNvdW50ZXJz
IHZpYQ0KPiBzeXNmczoNCj4gICAgLSBDb21tYW5kIHJldHJ5IGNvdW50DQo+ICAgIC0gTXVsdGlw
YXRoIGZhaWxvdmVyIGNvdW50DQo+ICAgIC0gQ29tbWFuZCBlcnJvciBjb3VudA0KPiAgICAtIEkv
TyByZXF1ZXVlIGNvdW50DQo+ICAgIC0gSS9PIGZhaWx1cmUgY291bnQNCj4gICAgLSBDb250cm9s
bGVyIHJlc2V0IGV2ZW50IGNvdW50cw0KPiAgICAtIENvbnRyb2xsZXIgcmVjb25uZWN0IGNvdW50
cw0KPg0KPiBUaGUgcGF0Y2hzZXQgY29uc2lzdHMgb2Ygc2V2ZW4gcGF0Y2hlczoNCj4gICAgUGF0
Y2ggMTogRXhwb3J0IGNvbW1hbmQgcmV0cnkgY291bnQNCj4gICAgUGF0Y2ggMjogRXhwb3J0IG11
bHRpcGF0aCBmYWlsb3ZlciBjb3VudA0KPiAgICBQYXRjaCAzOiBFeHBvcnQgY29tbWFuZCBlcnJv
ciBjb3VudA0KPiAgICBQYXRjaCA0OiBFeHBvcnQgSS9PIHJlcXVldWUgY291bnQNCj4gICAgUGF0
Y2ggNTogRXhwb3J0IEkvTyBmYWlsdXJlIGNvdW50DQo+ICAgIFBhdGNoIDY6IEV4cG9ydCBjb250
cm9sbGVyIHJlc2V0IGV2ZW50IGNvdW50cw0KPiAgICBQYXRjaCA3OiBFeHBvcnQgY29udHJvbGxl
ciByZWNvbm5lY3QgZXZlbnQgY291bnQNCg0KDQoNCkNvdmVyIGxldHRlciBhdXRvbWF0aWNhbGx5
IGxvZ3MgbnVtYmVyIG9mIHBhdGNoZXMgYW5kIHJlc3BlY3RpdmUgYXV0aG9yLA0KDQp5b3UgY2Fu
IGF2b2lkIGFkZGluZyB0aGlzIGZyb20gbmV4dCB0aW1lLg0KDQpGb3IgdGhlIHdob2xlIHNlcmll
cywgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

