Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E655CC5B549
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVT0hrjTGaoTZXbkidfErtqtX9N2NEZxZb9NMrB1OCg=; b=fy/xFEW60LEjd2YlMR2kiuiqUA
	3RNdid3sn3f4vqoEtjuGV8sjWSYEf4+YT0uW6pk72rMKaiqwVO9G6TwMUUgxUZuTsgijl9OAySD51
	96Hb+TUUWpUhJ3aX4WAurHH0/wLMxXftCf0ekwFMz1Twz0q+wYVw/tSK3XSdkZl3Qfhyx6n0mgE+i
	XB0NIm1OHLThSbUzDCja6mQPFcbxZQc5AHUK3KeQB4id5Wto9mxHBUGAesoYha5ogAhQHZVWxunnJ
	EVxh2i8fYSURyWgy22UjT2pgXYV4BH0o44hGZUbBTXYO2NtbHEqA37W/YZIt3yyxdiCftjfyKeA5L
	hVxDEvSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFqH-00000009RDw-3oeI;
	Tue, 03 Jun 2025 00:49:25 +0000
Received: from mail-bn8nam12on20630.outbound.protection.outlook.com ([2a01:111:f403:2418::630] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFqF-00000009RD4-0RXU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 00:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP93IUPAk/ZYELPpdpUTzkTMf4X8zDIL8s/vYnu28TbXb/VX6h6XQ8DlEt3T9i5gYPLdLHZe1EIj0j3v450pVleK3LPg7BVwFRWA2j1hS+Vu+O3CfF9ADNQlHAeZC1BL3Jpmbv9HkRwxGdw5g2SP1ZcxD/kyCt0pF7l3LvvI8KAJCZflu3VTIgeHGyR4bJOvz/oII8iYnkYYcRE3JySTT4WXS7sr29/F8Iw7WJZQ+nlANK0ivnmvFfIsBHFhpBngaQuHAPrn3GkdKldjWZcxb1aJMZMHv1n4usEhW/3+T4NQKD2JkG/rJfFuoXAzTaIPs9qzuPYAWY26VTvthkembw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVT0hrjTGaoTZXbkidfErtqtX9N2NEZxZb9NMrB1OCg=;
 b=pt9DYXLxR7bstv9ojlp68k8t1rihyrg0zTheXlabiEEoCIhe8WHIS+PI58Jq8lH9gCD5aVEKm4VJB7E2FKVf410XoR3daR9ZlpUUR5TaIdRCBsoQsyqYUp2k8GMGRUYIHP/tVgV5NSHWHi39rX5njDtzPPDDpMIZVteQvKC7HvTwt+PfaSzlujlHbTePbaxyQce5IPfhmQG1XQXHpDqo3ashBk9mgVNokW6p5S51NFntaL2vk20BW7K0XUt2RFXSo/o32LLi7S8efUXytw/5L4lpNRIatc26p0yl8g8Zwh//x+7q2WuPib/YffAjWjpxkacaM+WgxDc7u7KPkXgOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVT0hrjTGaoTZXbkidfErtqtX9N2NEZxZb9NMrB1OCg=;
 b=VxBOVHGbG6sqccpg9DqvlAWrXzz94d+5RySyGPcHxihtv+cKyWFi1gWmTniDK01O+/mYLjSbJR2JKl33OGHfpSSNrP3ugyNzAUwZulA/HWJ9/5eevfW1j8tfLmX0f5D0qAvxHsU6TePaLCt4gY0PEdB6M24atYok8n9U79YeuJOy1qtwFaV0RqRBw5WCLYdksOM4go8zND0XPiGH6/e2R/f8ItjbfWlnu2aQTWV2zhiTFDuDiyR3QNuvrRyqJ1AjzjUaLRcbbPA7ryZZfK6LBroh+kFyhJZ7edV2CiaWgIGIIONp4rnsRKfads4JT5bbzVWjkB5y9sFzaSYz8ItSZQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Tue, 3 Jun 2025 00:49:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 00:49:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue
 config fails
Thread-Topic: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue
 config fails
Thread-Index: AQHb03fUW+hRw95LpUiJfjehG7wiFLPwm7uA
Date: Tue, 3 Jun 2025 00:49:17 +0000
Message-ID: <be9f0e25-1bc8-4b6e-8887-dae825a0adc0@nvidia.com>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5769:EE_
x-ms-office365-filtering-correlation-id: 1f86b95c-d194-402a-550c-08dda2387882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGg4RzVoNnhBU1RXb0tjUHZpLzl3UzVwRnlVTmJrTU8yU0o5Rms1amwwMXdx?=
 =?utf-8?B?NXdBMFlxajNRcy9JREhMWjJDYVhIT0VHUVAxVkRrTFNTWTNoYUx4WVBGZStV?=
 =?utf-8?B?L25XanBDQ2hZcmNiTDFRZjhBMkt5UHp2S0dSL3Q1YzFiNks1QmdTUXNkeWdN?=
 =?utf-8?B?Y2dqMHNpRjVHS2VUK3MyZ2NIZ1doUmc5M0VDZEdXaVFMdmhtemdzTmR1UWF3?=
 =?utf-8?B?ZzBpV2F2NGMzRVo3NlZUYWE5TDJzY21vSFg2dUo3OXo3aDdwYzZ1c1VBR1FV?=
 =?utf-8?B?MWdYSlZpL2QvK1E4aE5aVnQyOHRnZjNlT2M1b3Y1WEFrVHVLdVRqVGF6Z2VY?=
 =?utf-8?B?Vk52VjFYV0ZPckxCWDVTbDRSREpjdjF1aFRLSUp4SmdRQWlvVDFVc2pvL2FL?=
 =?utf-8?B?RjduWnNjL05HTVU5T3RPaDEwcXF2Y2RVcndtS0draytRRTFHdWFDY0xaZC84?=
 =?utf-8?B?Qi9JTnBOSitnZW9NR0dlYysxNHJnZWVGc2JiVi9lOGhOOVVwSkJLZ090VTM3?=
 =?utf-8?B?MXR3WFFFdHI1QjVub1hCdHpDQ2pyRHRIdklPQmVNRlIzSE9EVFgyelh5M2Rl?=
 =?utf-8?B?b21ZOElrdmdlWnhneG1pSVRLYkpNZXdLT3RtdjBnbTdVTnJOTjZsV0VxaVdI?=
 =?utf-8?B?RWhKN25uZkNFOWppYXV5ZTFlb2tFSDRoK2lDUEdQSnNteHdodWprS3IvTHI3?=
 =?utf-8?B?cWdQenNkdm0xUWptcnVyaElTdFpKVGdZK0paTjRiVHovcVlVVEM4VFdqUGMy?=
 =?utf-8?B?d3VKQkNQWS9FU1I1ZytGMkhObWNUYmlxV2VJQ1J6YTlGS204OFUzSmVkdWxH?=
 =?utf-8?B?Nko5OHIvbTZOakhOUm93SVJ5ck03eGRqaGZGN0puZWF5U01wTXFQOE9xVkwv?=
 =?utf-8?B?d3ByN3hnMEZ2bDNUSDQzSkMvaUZQMU84bStoRHllalVidFJ0eUM5bmZrSjhl?=
 =?utf-8?B?ZEtBMHdoZDkzRjN3aThxcnhNTGZHWVYzTW5qU1RHdjdRQXZKSGJOaG9Sa2xI?=
 =?utf-8?B?Q0NqZUlLdlNjaXlwVyt6UDRpbWR6LzdLdk5mcjFYMTFVcE5MSmtINHZRdExG?=
 =?utf-8?B?L3dkRDBoOUVWUWtwek9kSUt4MkxaakY3RkNpdnJvMlVITWpYbDFhaHlWSHpo?=
 =?utf-8?B?K3pQeEpFMGt2YXhoTlIvNUlUZzZwS2h1SmVZWXBQOHovYUxibm83bU5GRjB0?=
 =?utf-8?B?dHVXSExSeFoxZWg1MURSbkplMlloL1hBblBTQ0I0bFBVMFQzMmhKY1VIY1FO?=
 =?utf-8?B?aC9kaUV3VS9DMGJuY01LU3NGRjMxbzI1TjFCbDRYcnM1dUVmdTlsRllvRGZt?=
 =?utf-8?B?Y25wQVRjMUpGbXZ5K2tBUzhHUGNHcjZVOGF0V0kxbkRESnlJcllTZ1VXVUwx?=
 =?utf-8?B?Z2Y4UXpUQ2hraUFSSFhuckxCeGZHYld4MHlBdjdMandoMHZWY3VFQm83UHBt?=
 =?utf-8?B?MWdSakRHL1k2M1JlYmVHSXBjOHo1RFo0VTUrU2x3VXNvR2dUOG9jcWVMNmNP?=
 =?utf-8?B?QUtTWEExVmVVd3V3dXpRWXdNT2tIbHZPR0NpeU1XczdGYVd1RndJaGhDTXFm?=
 =?utf-8?B?QlE0QmpBTFdzaUlRaGliMXB0aVUzN2xNZVhuSlNOYjd2bzRwWkVsZnlBVG15?=
 =?utf-8?B?RTN3SFY3clhDN1B0a2dOOTk3VmsxVXRRbzlkZEx4SHZsWFRQWkl1ZWpmT1F2?=
 =?utf-8?B?NTZVWWtzWjI4Yyt6djRUTmVIQ1Eyd2JLR1FpNHY0cU5aK0k4elU5elliWDJw?=
 =?utf-8?B?N1RPUDUzbXVVSElneFdUU21ieVZIWUNSVG1RUGt0Mk1iclhZdEF5empXUEJ1?=
 =?utf-8?B?cWZEaERDckdIdE40SjJVaWdJakVXSjFhaWlBSm5weW44M3c1TXJXM215V1l6?=
 =?utf-8?B?Qmp3am1NMDdSYlI5bXFhOHRhZFR5T1BRWXlGNExTS25zbUFqc1hWUXorU1hj?=
 =?utf-8?B?aUN0L2ZZUTFsWnA5VHl3dldpNzV5WG9mTVQrRzBWSFBQVTJEdjJsMGNlc2pO?=
 =?utf-8?Q?yoXQ60FfXaRWKn+IaGZrpl6mjKLmcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZmd2ZibUhSczhhM2VzZEltRDVHREhJRjNrVkM0L1NYMTlaVDE2QVJsNklo?=
 =?utf-8?B?Q2oyN1JmeU1vNmxDUFBVdEZHSkxRRTdLT1hTUlBUSnUrdnlBbCtEWWwwcFNi?=
 =?utf-8?B?L0duOWN5b0VwU0czN0wyQ0Q0UXQyeHpqMmRVTTdnZEZLQzV3ZDJZbDlZSXJt?=
 =?utf-8?B?MmM4RldGTTNrNXQrSjNtdC9NdU44OWEwT0pDVjVINVV0TDRTRzBaTm5TbzRz?=
 =?utf-8?B?R1hFS1lpR2hORFptNXpja3d2QnpyUGp1Y2dzdm1UT1d1WlFMOFV3RGQzQmVJ?=
 =?utf-8?B?ditPWmg1UWNBSU8yWlJmUW5zU3pyMEVVOU5yejVLR3ZzS0c5dkozSWxQb3U2?=
 =?utf-8?B?WThQUnN2NHRlQy93cWxVU1hSWm4xYXhuWmdMVnJ4eDhTUDBxMmlSa0kxbVNv?=
 =?utf-8?B?blpCblkzcXk4Y0tzWkRnT3V4dXYyeTJoTXJCa2V0S3U5YWV1ZlIzcjl3dFgr?=
 =?utf-8?B?RzBBRExXdDh5YU1UZkxJSHFYbmdIWjRrL0dWWENEcDJZaHFIOXhEdnFhWjFN?=
 =?utf-8?B?V0d5U3NFcDd4blJyb1FhMFNiMUF6Z2o0R1VNVGI1Y1IrT0ptdnZPK3FnbjQ2?=
 =?utf-8?B?bzJUZ1JKMmRkUHM2L1JSTTJ5MTNpaFFhOTM4NTV1RjAwRExJaHRQNkV3YVZw?=
 =?utf-8?B?YzhnM0pKUTVKdGxQbFNJTGZ2RWtuc3kxR2g0dldDT2IreG1OQ1RBbGlONHow?=
 =?utf-8?B?aHhSSWxDZlhUblp0U3U0cUNUNHM0ODNZZlVSbmlWSHI5a1Q2Z0RSOWt2aTRD?=
 =?utf-8?B?KzdvQnBTakIzNWRMeElqM0w2R0tOTUdTeE5mdHZtTk9PSDNwTXJsaFkxK2x4?=
 =?utf-8?B?T3ZYc0lrcGhrYStlV0E5Y1kydFJRUXBra0VqcHVWSGFZa2dLcy9ySDVldVFx?=
 =?utf-8?B?WTZhM3p0N1NlZTJhb1NEZlliaEVxbjZQZG1ocXBZRG9PT0FrT0VVSkpzYTI1?=
 =?utf-8?B?RnJpaWVMcXNZQ3hHTmtoMnVMWXhLcmY1ZFpPMitsNFNpZGlMVGZtOWIyN1Iz?=
 =?utf-8?B?SXo4Kzdjd0VVbnlTYWR4Rm1laUV2V1A0M3V3TnlWY3ZMUWhvL1lScGRCRVhk?=
 =?utf-8?B?WHR4UkpnQjdQZWFBNDN1VEdGclJSY0RvU09FY3FuR0xzbzFJN3VOdEtwU0ZL?=
 =?utf-8?B?WWxTZFZIcHYxMHFtMXpTUURRS0xBcmlMcnM1VzR6TmJPbk1HUUpYbHJ6WGJx?=
 =?utf-8?B?ZFRNcUFNb0xQME8yTTN6dlVTVFRucFUweE1XckN5ZFFBL0d4ZkRPemwzMkdp?=
 =?utf-8?B?NkNwWnNEanVLVnMwN0M2aE9QM2F0QzdmSUhEbTZVeGliQlhrMTUxVEE0YXBw?=
 =?utf-8?B?RjZLQThJMzJiNVFFVEVvZWkrYlVXYS93NTB5RWdUOUFpUHk4azVFQ2RYUlZs?=
 =?utf-8?B?anNaRUQwOURBdElTUmxvVTNJazdKOFFnanNWNzdieWlNbDVWNVJEMCt0Q3Y1?=
 =?utf-8?B?cFVMSjEwS2l6aldvZ0hseVh3NUdmOGxsNFVOL3BlMXRpcHl1Rlk2KzN4cEh6?=
 =?utf-8?B?eXNRc1RQK080ZFh3eGgzK2xjM2ZIRkt6VERiV25xRjFxVllDZmhhL202TkNl?=
 =?utf-8?B?QytxSFYwdjEzT0RjUXI2THNjNlZlSFVxcFFaMmdVdHUxZUNoVjFFbllJa0VH?=
 =?utf-8?B?aEhWd3BUbzgzaE93NlJsZnJ1Z3lRQnFYb2QvSHRuZ3h2QmlySGlJekRBSWl4?=
 =?utf-8?B?b1YydmtNWUxkdnhNai9WQ2FNWHhPK2hvOEkxdm5OMmZlL0V1OEROR1JYY1Nh?=
 =?utf-8?B?Rlk0ckhOTjdYaHRtREZRSG5xSDBndzFqaUJmWndpOEhYM2d5NVozRFRwYjhC?=
 =?utf-8?B?Z2xLYzhwR2g2ditQbXZDdGY5MHloWW9wbkswUXJ3Wk9mTE80OVNEWVhtVkx1?=
 =?utf-8?B?eVBlYVhoU25sNHowM0hQdmlvVTNHeFBhcHF5RUdVcGkrcm1odVlBVmF6R3hG?=
 =?utf-8?B?YzF0MEFXNEhyRU1iaC9ERWwwK3RGdTFSNXVyZHo5WWtCcGxPN2liN01sOUZm?=
 =?utf-8?B?dTVCcGMzK1VJcTBwMEc3RFlXa3J2dWY5VVdRMVhmZndWbjF2M0l4UHBCZy9R?=
 =?utf-8?B?bEx3c21mQktYL3JQL3ZFN1pWSjViNk95c3FiNTYxUHRER0FOdE1NRDRXRWMv?=
 =?utf-8?B?dXpTOU43TXdoTzJjUmxFWDhrOGx3aHVnRVpzRzUvRjhvZTRJYVE1eElhOFRj?=
 =?utf-8?Q?qzZDYXe7C6Cl1utASUZmcC07UrQ8AjECOqlltShu2RNj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA73D9E673D3A4408CBF57224B6DE097@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f86b95c-d194-402a-550c-08dda2387882
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 00:49:17.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmiBevd1As7mW3kZE48fb4wucurO5GKVbeZFNBbiJQBE1SHfDawOp3wkj8eNhO66mgkLWC57J+C+7AuvyWFfJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_174923_139297_BD400EE1 
X-CRM114-Status: GOOD (  18.29  )
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

T24gNi8xLzI1IDIxOjM1LCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gQ29tbWl0IDEw
NGQwZTJmNjIyMiAoIm52bWUtZmFicmljczogcmVzZXQgYWRtaW4gY29ubmVjdGlvbiBmb3Igc2Vj
dXJlDQo+IGNvbmNhdGVuYXRpb24iKSBtb2RpZmllZCBudm1lX3RjcF9zZXR1cF9jdHJsKCkgdG8g
Y2FsbA0KPiBudm1lX3RjcF9jb25maWd1cmVfYWRtaW5fcXVldWUoKSB0d2ljZS4gVGhlIGZpcnN0
IGNhbGwgcHJlcGFyZXMgZm9yDQo+IERILUNIQVAgbmVnb3RpdGF0aW9uLCBhbmQgdGhlIHNlY29u
ZCBjYWxsIGlzIHJlcXVpcmVkIGZvciBzZWN1cmUNCj4gY29uY2F0ZW5hdGlvbi4gSG93ZXZlciwg
dGhpcyBjaGFuZ2UgdHJpZ2dlcmVkIEJVRyBLQVNBTiBzbGFiLXVzZS1hZnRlci0NCj4gZnJlZSBp
biBibGtfbXFfcXVldWVfdGFnX2J1c3lfaXRlcigpLiBUaGlzIEJVRyBjYW4gYmUgcmVjcmVhdGVk
IGJ5DQo+IHJlcGVhdGluZyB0aGUgYmxrdGVzdHMgdGVzdCBjYXNlIG52bWUvMDYzIGEgZmV3IHRp
bWVzIFsxXS4NCj4NCj4gV2hlbiB0aGUgQlVHIGhhcHBlbnMsIG52bWVfdGNwX2NyZWF0ZV9jdHJs
KCkgZmFpbHMgaW4gdGhlIGNhbGwgY2hhaW4NCj4gYmVsb3c6DQo+DQo+IG52bWVfdGNwX2NyZWF0
ZV9jdHJsKCkNCj4gICBudm1lX3RjcF9hbGxvY19jdHJsKCkgbmV3PXRydWUgICAgICAgICAgICAg
Li4uIEFsbG9jIG52bWVfdGNwX2N0cmwgYW5kIGFkbWluX3RhZ19zZXQNCj4gICBudm1lX3RjcF9z
ZXR1cF9jdHJsKCkgbmV3PXRydWUNCj4gICAgbnZtZV90Y3BfY29uZmlndXJlX2FkbWluX3F1ZXVl
KCkgbmV3PXRydWUgLi4uIFN1Y2NlZWQNCj4gICAgIG52bWVfYWxsb2NfYWRtaW5fdGFnX3NldCgp
ICAgICAgICAgICAgICAgLi4uIEFsbG9jIHRoZSB0YWcgc2V0IGZvciBhZG1pbl90YWdfc2V0DQo+
ICAgIG52bWVfc3RvcF9rZWVwX2FsaXZlKCkNCj4gICAgbnZtZV90Y3BfdGVhcmRvd25fYWRtaW5f
cXVldWUoKSByZW1vdmU9ZmFsc2UNCj4gICAgbnZtZV90Y3BfY29uZmlndXJlX2FkbWluX3F1ZXVl
KCkgbmV3PWZhbHNlDQo+ICAgICBudm1lX3RjcF9hbGxvY19hZG1pbl9xdWV1ZSgpICAgICAgICAg
ICAgIC4uLiBGYWlsLCBidXQgZG8gbm90IGNhbGwgbnZtZV9yZW1vdmVfYWRtaW5fdGFnX3NldCgp
DQo+ICAgbnZtZV91bmluaXRfY3RybCgpDQo+ICAgbnZtZV9wdXRfY3RybCgpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC4uLiBGcmVlIHVwIHRoZSBudm1lX3RjcF9jdHJsIGFuZCBhZG1pbl90
YWdfc2V0DQo+DQo+IFRoZSBmaXJzdCBjYWxsIG9mIG52bWVfdGNwX2NvbmZpZ3VyZV9hZG1pbl9x
dWV1ZSgpIHN1Y2NlZWRzIHdpdGgNCj4gbmV3PXRydWUgYXJndW1lbnQuIFRoZSBzZWNvbmQgY2Fs
bCBmYWlscyB3aXRoIG5ldz1mYWxzZSBhcmd1bWVudC4gVGhpcw0KPiBzZWNvbmQgY2FsbCBkb2Vz
IG5vdCBjYWxsIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoKSBvbiBmYWlsdXJlLCBkdWUgdG8N
Cj4gdGhlIG5ldz1mYWxzZSBhcmd1bWVudC4gVGhlbiB0aGUgYWRtaW4gdGFnIHNldCBpcyBub3Qg
cmVtb3ZlZC4gSG93ZXZlciwNCj4gbnZtZV90Y3BfY3JlYXRlX2N0cmwoKSBhc3N1bWVzIHRoYXQg
bnZtZV90Y3Bfc2V0dXBfY3RybCgpIHdvdWxkIGNhbGwNCj4gbnZtZV9yZW1vdmVfYWRtaW5fdGFn
X3NldCgpLiBUaGVuIGl0IGZyZWVzIHVwIHN0cnVjdCBudm1lX3RjcF9jdHJsIHdoaWNoDQo+IGhh
cyBhZG1pbl90YWdfc2V0IGZpZWxkLiBMYXRlciBvbiwgdGhlIHRpbWVvdXQgaGFuZGxlciBhY2Nl
c3NlcyB0aGUNCj4gYWRtaW5fdGFnX3NldCBmaWVsZCBhbmQgY2F1c2VzIHRoZSBCVUcgS0FTQU4g
c2xhYi11c2UtYWZ0ZXItZnJlZS4NCj4NCj4gVG8gbm90IGxlYXZlIHRoZSBhZG1pbiB0YWcgc2V0
LCBjYWxsIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoKSB3aGVuDQo+IHRoZSBzZWNvbmQgbnZt
ZV90Y3BfY29uZmlndXJlX2FkbWluX3F1ZXVlKCkgY2FsbCBmYWlscy4gRG8gbm90IHJldHVybg0K
PiBmcm9tIG52bWVfdGNwX3NldHVwX2N0cmwoKSBvbiBmYWlsdXJlLiBJbnN0ZWFkLCBqdW1wIHRv
ICJkZXN0cm95X2FkbWluIg0KPiBnby10byBsYWJlbCB0byBjYWxsIG52bWVfdGNwX3RlYXJkb3du
X2FkbWluX3F1ZXVlKCkgd2hpY2ggY2FsbHMNCj4gbnZtZV9yZW1vdmVfYWRtaW5fdGFnX3NldCgp
Lg0KPg0KPiBGaXhlczogMTA0ZDBlMmY2MjIyICgibnZtZS1mYWJyaWNzOiByZXNldCBhZG1pbiBj
b25uZWN0aW9uIGZvciBzZWN1cmUgY29uY2F0ZW5hdGlvbiIpDQo+IENjOnN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gTGluazpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzZtaHhz
a2RsYm82Zms2aG90c2ZmdndyaWF1dXJxa3kzM2RmYjNzNDRtcXRyNWRzeG1mQGd5d3dtbnloM3R3
bS8gWzFdDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgcmVhbGx5IGdvb2QgY29tbWl0IGxv
ZywgaXQgbWFkZSByZXZpZXdpbmcgYm90aCB0aGUNCnBhdGNoZXMgZWFzaWVyLiBMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

