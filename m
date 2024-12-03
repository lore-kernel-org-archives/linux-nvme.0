Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19BE6C600
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xQ44493JAW1ad1fKsh7Ya3cLVEP9x10HxSVm02e+NQk=; b=xGhFz87VuRhYUDSfIanjIg5l3r
	Rj3b5w1wVLJ72QWF4wvBqIeDnHA2SzqvSkll9NKwWogxjXA5glBvXf+oHLveQSxSfzz6pSwyBbtTG
	7tdzbcxRID2GusLr2vI4dLPPXOIeVy0WmHBRutgunMUGpkAmLLuA4r2F0oi8XUIfaQUGdIO2wOZXu
	K8zpfYyR8rGImVguqEj9C8EPDNysm9hnFcqi77F5A1QwH7e2uA52zxA8ewiQrAVBWUJp7Ud2s1SFZ
	p1ZWONEIm9CZ21OKM6Aqz1VAUsgFLlLad2WGtbwC2wq4wTnY44vveF8Md+XoSnHesRCV5T4akDa3V
	qFN8ppog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKzP-00000008GJy-2xrj;
	Tue, 03 Dec 2024 04:58:23 +0000
Received: from mail-dm6nam12on20622.outbound.protection.outlook.com ([2a01:111:f403:2417::622] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKzN-00000008GJQ-3pf9
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID/L8KsuT9fJh3V1NjM6vgcAAzxckIb/WlDdmdqKxK+n2qLWYxr29BN+VvvHkZr0Ww4TxBCbBcffOJD5+HTKl2W8HvmWawOlpIIPN5rLD62wA0tDFNdP601WwG16wrMBKBbkwst5pY3VUJXBYvzsXMF+5rj4uUzmJInpXUEPQ1HQt6bvnoZmaAqSoj1h0Z3glILNgsvGLqkhLE9zHnZZ6xAQfdAOx3aVr4F3SZwEe7saIMz46yBiMNxdX0wyPox12y9x0syLnKdZ61O0xtNtJCz1CJaMLB3G4mn1nvR7rGOTWMiBIIFIE4e4U8joq6y2TO2jEdj7myQMckdCgr8G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ44493JAW1ad1fKsh7Ya3cLVEP9x10HxSVm02e+NQk=;
 b=yMLuuNpktcPxSuaYAmjljL63CbLKEWoXLOVZEnakW8Bk7GOg6FSoP71g9EyJMCfIdmMqF+b3eaj5jXpAJ0/3PHtGIwbtNkst338irdq04AQtBDZsRQo2W6Bi4b4OPuirlRTVANi8xiBBIGVe0Q+hvJvFRhP0VqfMmnC4SccZHYG5ecAh5bzwsOHU8FduGzGUOutlPP92Ud5475vCiKmIRf4AqKUrLxGk4+QXhyMsNuQFQ8jcEKEAAwdpOPfGAOxwZobUELpcfUR2XhewE/rHuqeXclwBvBLYPcgK/yfxiF5VbuSjPAToDAwNsbHkp2ij1010TiJWk6/UuVrp+qVPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ44493JAW1ad1fKsh7Ya3cLVEP9x10HxSVm02e+NQk=;
 b=hi5ENZ+KoNpZ7ykuxZSvIRKWb8+yWdINmVcyZKSbxCcW/TD+LfHFVvqLro9sxAhmKOeiPHXXdi4JIvGVWX41JKZ0ADfAE3dgyArZ5ECnM+f2Vno81zN7PeiKMTTPu2jfvu8Iud9ZHP9AD2f8AUNQ+oS+GYbH5gc+B8f4nj5oLGsfC5DCSI87+PuhorF7/ooROnfUK/vjiM3sx+B8K60rwxlfsofpEXtKuAYl7cnGP+jVQa4/3mXQlINT6hP3x1Oj6/DU6MpChZLBi8Jn/rg6LhkunKOGNW+5HusXcfHwc6jsEDmJngZd9DjQlYqlIHzZBOC+9vi3NDxYtE+5wrArBg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:58:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:58:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 5/7] nvme: delete all ana_groups when removing a
 port
Thread-Topic: [PATCH blktests 5/7] nvme: delete all ana_groups when removing a
 port
Thread-Index: AQHbQmJXbCI4sldD8EyvjUW6p3F+H7LT+ymA
Date: Tue, 3 Dec 2024 04:58:18 +0000
Message-ID: <e237466b-4316-4715-a305-c2d2003d256b@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-6-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-6-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: ea81fe18-b064-4c0c-b7c0-08dd13571a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzQ5d1RmQ2JZL0lORzEyY3B2SG1qOHJxT3ovbG5uNzFadUMrRURtaHFCeXZD?=
 =?utf-8?B?a0FVajE1S29yV1drRXd0SWgweGoxSTZJcXVlT0RRc0IrS0JueXRNUTdPYWVa?=
 =?utf-8?B?dTZmUUF5ZEJiTUJnTDVSTU9VbWp3Zy9jNkZWakhMOVNsaE1ERllWWnRpZlpF?=
 =?utf-8?B?UGNMUXV6Q2dLVThxUTRncm5xZHdtd0dib1BDcTh2TC8wNGFXcXpFbGdLcmg0?=
 =?utf-8?B?bGlBMCt2Q1pYUWZoa1IydTFDT2pmZ2czU2ZMRkNrcVhXd2VaLzV4aWhRVjFU?=
 =?utf-8?B?QVg2REx1b0F1ZmxTRm81RmtZVE1lYk1SOWZqamo4YkhBQ1NMbU56Rjk0Ni96?=
 =?utf-8?B?Nzkwa2dXclpZQitFVUtZMU5odWkzYllyMWg4N1BHZk0rOExCVngzWVcwYmd2?=
 =?utf-8?B?NVd6KzJWWnBaVjlWSFV1TXpwdTd5L3BQNDlWRCs4WlUvQmoxcEtRMHNhQ0dM?=
 =?utf-8?B?b0k3OWRhRUxraWlOdGdVLy84Ni9iSDVENk90eS8zMzRFMHZ5NWFuL3dtaVBh?=
 =?utf-8?B?QzVHbjJzUm96U29ELzFIVlpDeWhidW9sSStJZGFxM3hLeDRMVllOUDV0UkR5?=
 =?utf-8?B?b1BwcUV2d1ZlSERCbVNneUxDOC94QmxzZ01pSlhoUlpnMWhEa09WbWozYzZN?=
 =?utf-8?B?QzJldU1keGx6dUVPdmZZdVRwOWFxaUc3NWtvYTNVRGJGUlpQWldTVEs5aEtD?=
 =?utf-8?B?Q0tsUzM4cUFCNTVsUE9WVzdpM0xneGJQY2lLekRFVmM4cDVYL0QxYU83dkNR?=
 =?utf-8?B?ZVFJUnFTV1ZHazhFNHpGUm52UGFUbHVEYjFyeGh2bSs5NmRjajZUR0ZrMGYx?=
 =?utf-8?B?L0VHTWVrUHFyVUxVSHU3UGhmQy9RV2t2dWpNNUhxMlpOVStHcWtmQjRsMTRR?=
 =?utf-8?B?ek9BZnFuaEdiUXBGbW1kYWRpODd1ZGV0UzEyQmJyWGdUOTdGWTQ5NkJjMjFM?=
 =?utf-8?B?dnVNU0sybm5GcDNrYlNmOGdiS0dPNFNLUUtjMXZJZ1NXNkEvZUtBMnBwRUtY?=
 =?utf-8?B?eDhxMUNEN1A3SnBrSUJ5TWtITklpR0tscEllckRtN1ZNYXl6V0cyVkx1WnBB?=
 =?utf-8?B?VC9Ja250MGVJeE5Ob05TdGt6d2hEMzJBcngzcDFpbGU2bkZMMnNEOTVSZ3Q1?=
 =?utf-8?B?UXhBc3ZMRmpZTXJWdHhndXowWEt0VmtqRVUzTzJyMlpBVEFEdWY1bE51Z1hl?=
 =?utf-8?B?dnQzblNwOWJJNUJtVWNQYlowSnVpREJYd3VZRXkxV2ViTk1adGJTOExBbGMz?=
 =?utf-8?B?QWRLR3BTeHFjN1E3L1I1cHNZeEVmVC81ZWFYcG5LNlJKaUZFR004b1hGdVJL?=
 =?utf-8?B?NmY1NVhBd3lLTWtIUkRkMjkrK3FpeUVoa3ltTkhVeG81VHVKYUh5OE1XT0ZX?=
 =?utf-8?B?blZsaVppMnp1bGZqRVVueFVOT1FtemNSU0ltbWt3YUM0ZkFEWk5DSE9oUXpx?=
 =?utf-8?B?SUJEQW9xcEdxQjNnSHVSSjVxS2xORThBdEJOSVRLeURkZXVvTncwVTRFdDRy?=
 =?utf-8?B?R1lxQUNpVWVvR1pmRjV2UmV6TWZxeUx1Qk5MRWpSS0l3QWhJeEVSTXN4b0JV?=
 =?utf-8?B?d1IxcGdKRDl6ekFCOHAxWjlmb3FmZEZ0L0tWWmYzYVVJbEFkUDJ6WEZTdnJj?=
 =?utf-8?B?VmRzNXVpUjE5ZDNHdjBpT2FsVWFSOFpCRDZNTVFzMlNwV1JPS01jbllwWkRq?=
 =?utf-8?B?Y2RlN1JvS2JkYTBScktQSGxmZnhNdzRFQno2SmlKUzhkcUJTTUkwc09ZeUFY?=
 =?utf-8?B?aFA0TmxHZmRXWThoWmhCUk40blhQOVNoZytaeDBrRHBHL2VMNTV0aGxrL0hT?=
 =?utf-8?B?cmlQWnc4SDkxc0VjekozTnBOWkx0Y0RKblhIT0lYOFl2dU96akhUSHMrRU1W?=
 =?utf-8?B?cFJ4c3cyN05EV3hYY2N2c2J6OHFIMXhkcnlBMTFjR1d5RUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3RYQ2xWdmhIaks4NTNIQWdGcEpHNkl3SXZyL2Q1c1JNWkVIc2EybnBVQ0Rl?=
 =?utf-8?B?RDdyU0ErMFdQcWFneVhkRDNuY3NENzZNektuWlBTdXI2YkYzU0E4ajVySHc4?=
 =?utf-8?B?QVNsWlZKOFUrdkFoalI2eElmcE11K1NVOTZoanBHNHVRaENQbTZoSTVocjVE?=
 =?utf-8?B?Q0RFcFI2MS8yWnR1MFdHbGt3c0ppRCtwSFRnTzhhR0piaTQ2S0Foa2dtWjNm?=
 =?utf-8?B?WVFiRG8xbDdCbERTTjBsbktlQ2NsK0pvK202a01TRW9SdXVzSkhtQzhnOE5w?=
 =?utf-8?B?ZURDMVJ6K3I4bGNycDh5enkrQXdaQW42NUwvdncvQ2s2YWRCZ2R0eEFzSmVx?=
 =?utf-8?B?ZDJ3eVJBMkpNUHdHbUN5UmVoRE9aNU83dEJocXQ1S1VYTjU1b2hGZFF3eTNF?=
 =?utf-8?B?NDRCRHZzeGxIZTdVc1BjNklMR0daWEUxZnNvbG91bHR2cGtjQ0g2OGQrekpF?=
 =?utf-8?B?Y1prK3F5VlpqdmxwSUJHRnUxRzhtYnArNEtFbk5SYXFNMEJ3blJQbTllalJS?=
 =?utf-8?B?Vk9sKzlrTFR4cE00ZWZnMHRnU094MFB6NkV0aVQ5ajRTTG5aUjRkZDN4b2xr?=
 =?utf-8?B?UWM1Ujg1K1p2Tnd6RVU2eGVzcEQrWWZVUDlTUUZ3MWQzdkltSjA2KysveXkr?=
 =?utf-8?B?dm53czNXNmd0K2ZDVkpqekt4aExhT0ZUWHo3SkJUN3JUbndtdGNtTHQ5SFEw?=
 =?utf-8?B?ZDM4TDVDK1drdms1czN5NDU4ajJFMTFsVzhXdGVnV1ZmVnhtZk1FbDRjUnhU?=
 =?utf-8?B?dXFLL3J1Wkl1cGVEWG5xMEx3YlNxcFVFaElzMXAxeldWL0J6dHppc2FRaWpC?=
 =?utf-8?B?ZkRjdCtKK2FZdWtNMDJUL2UrUlZsTzRsYVFEcHhSUHRtTVQrWHo4VDdCakF2?=
 =?utf-8?B?Z1RZWmlzQzNXZjkzV0N4bEFMZU00SnBHYjJwNlFoSm1mMkZEOFVTQmRDN2Fk?=
 =?utf-8?B?S09LR0VWWXFOZk9Jc3FOcU05YkdUVlVNMjVsK1g5WW1yN2hFUXBWZzNISHlj?=
 =?utf-8?B?SXhZUkJWOG9yRUJBckxlTjlvTmtRQkpycTRnZ1VPU1Z5YmxCcVNCbUg0L1Js?=
 =?utf-8?B?em13dytlakZGOWw0ZkhWSEp6cXk2N2ZlUHZpNUJpMFNzdnF2dm1LdFFmZ3FR?=
 =?utf-8?B?L1g3MFR6Y0VralFZQWVYK3B2cEZpajNaMTFhNytCMFB2R1lLNGhjYU4vZUF3?=
 =?utf-8?B?VlF3UWFwVmJ0Tk9JN0pYT0d0MTE2R0hqM2NYR0hsdW5uY1F1b0RhZ2YwVVQ4?=
 =?utf-8?B?M0RLbG8zeUZCR3FFbnVDUldyUDJuZTZTelZ6Zzg4Q29Ldm9jemtaSllRaVBm?=
 =?utf-8?B?OVVObmZGc0FEVEJtUm41RUl0ckZ2eGFpa2oxRTZjM0RkdWhEM0p5bzVvYU42?=
 =?utf-8?B?Y1kwbTF6VlRuWmpwNjBpQVRVSFI1M0x5Sm1nNXBOUzlzZHJIdVFLaTJRWHYv?=
 =?utf-8?B?VHloS3I3U2FoS0RocTVjUlg0eFdTbWFjcnNlM3lWdnNySm5RTC9qZ1liMXBp?=
 =?utf-8?B?OWwramVqa3ZlMnk3REsyY2ZQU1VyRlAvKzBCc0k3QS9CK1BKZVFmS3lFQWta?=
 =?utf-8?B?ODVaUE1sSHZySlJpMzJIelBvcVEzbXR0ZzhlNTR4M2xYOWNrZzl0Rlk4WTJZ?=
 =?utf-8?B?SjhRY1g1aFJrY2V0c093eTdEMWVhbHhTcThsbzU1WmtaZVFZZFpCWUZUTTVU?=
 =?utf-8?B?NDZFRjErWTVZbUlQUDkxZ2Y2L0ZhTlpQdkJiNFI0amxReElUNlRWbzZOYUlS?=
 =?utf-8?B?c1dZR3dydGcxSERHRG9ESm0wV1lCZUNrOHlXZVpJeEo2bWY3SmhnKzBYK1JD?=
 =?utf-8?B?YmpLaVdBSTZYb1k2Z0FnZ1NKOEw5YXpVenFJbmJTOXduVUt5QUsxRFNDYlBT?=
 =?utf-8?B?NEF2QUkxTFpxaTJ1OHRnU0JWK1pHb084WEk0VWY1eWt3RHdNaElrdi9PcHIy?=
 =?utf-8?B?VFZKSjhvY2VKUHdpNE9iRWVPWEFmWlh1RkpEOUhEcmR1b3F1a3BvNjBYTWdJ?=
 =?utf-8?B?OUk3dmRJNzVpdU5FQ1VGNWpJY2RsaFF4cWFvTmN3MkdNMlZnbTJmMnR1ZFFJ?=
 =?utf-8?B?clFMNW8waXoxaTIzNE5KMXErVVVVVitIYWlWYXVHcC84WENDcTV2UGkvYnpY?=
 =?utf-8?B?STQ0WGxoZGtFblByN1VZbGZoNEZaZkd3WHN0Q0VGVlo5enJnd2JPaU1rQSt0?=
 =?utf-8?Q?2XiIE9c7ndm0HJbF0EDohXFQoOUvc7A/CMaKSU0C+m7T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0030D1DDC2E5704A9CEB0285E9EBD113@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea81fe18-b064-4c0c-b7c0-08dd13571a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:58:18.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qh61wPDrgRBBoVeJFINSUEuqKNCe1UvPuSOvyJ7AnIW7zFhTHAlWJE65h9h6x6eSUadat1w5/35j8QJxb1K84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_205821_950386_2D713D6D 
X-CRM114-Status: GOOD (  16.68  )
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gQSBwb3J0IG1pZ2h0IGhhdmUgc2V2
ZXJhbCBBTkEgZ3JvdXBzLCBhbmQgd2UgaGF2ZSB0byByZW1vdmUgYWxsDQo+IEFOQSBncm91cHMg
d2l0aCBhIGdyb3VwIGlkIG90aGVyIHRoYW4gMSwgb3RoZXJ3aXNlIHdlIGNhbm5vdA0KPiByZW1v
dmUgdGhlIHBvcnQgaXRzZWxmLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4NCj4gW1NoaW4naWNoaXJvOiBmaXhlZCBzaGVsbGNoZWNrIHdhcm5pbmdd
DQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2Fz
YWtpQHdkYy5jb20+DQoNCmluc3RlYWQgb2YgbG9jYWwgdmFyaWFibGUgYSBpdCBjb3VsZCBiZSBz
b21ldGhpbmcgbWVhbmluZ2Z1bCAuLg0KaXJyZXNwZWN0aXZlIG9mIHRoYXQgOi0NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQo+IC0tLQ0KPiAgIGNvbW1vbi9udm1lIHwgOCArKysrKysrLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2NvbW1vbi9udm1lIGIvY29tbW9uL252bWUNCj4gaW5kZXggZGZkOTg3Ni4uOGJjZTQwMyAx
MDA2NDQNCj4gLS0tIGEvY29tbW9uL252bWUNCj4gKysrIGIvY29tbW9uL252bWUNCj4gQEAgLTQ5
MSw2ICs0OTEsOCBAQCBfc2V0dXBfbnZtZXRfcG9ydF9hbmEoKSB7DQo+ICAgDQo+ICAgX3JlbW92
ZV9udm1ldF9wb3J0KCkgew0KPiAgIAlsb2NhbCBwb3J0PSIkMSINCj4gKwlsb2NhbCBjZnNwb3J0
PSIke05WTUVUX0NGU30vcG9ydHMvJHtwb3J0fSINCj4gKwlsb2NhbCBhDQo+ICAgDQo+ICAgCWlm
IFtbICIke252bWVfdHJ0eXBlfSIgPT0gImZjIiBdXTsgdGhlbg0KPiAgIAkJX252bWVfZmNsb29w
X2RlbF90cG9ydCAiJChfcmVtb3RlX3d3bm4gIiRwb3J0IikiIFwNCj4gQEAgLTQ5OSw3ICs1MDEs
MTEgQEAgX3JlbW92ZV9udm1ldF9wb3J0KCkgew0KPiAgIAkJCQkgICAgICAgIiQoX3JlbW90ZV93
d25uICIkcG9ydCIpIiBcDQo+ICAgCQkJCSAgICAgICAiJChfcmVtb3RlX3d3cG4gIiRwb3J0Iiki
DQo+ICAgCWZpDQo+IC0Jcm1kaXIgIiR7TlZNRVRfQ0ZTfS9wb3J0cy8ke3BvcnR9Ig0KPiArCWZv
ciBhIGluICIke2Nmc3BvcnR9L2FuYV9ncm91cHMvIio7IGRvDQo+ICsJCVtbICIke2EjIyovfSIg
PT0gIjEiIF1dICYmIGNvbnRpbnVlDQo+ICsJCXJtZGlyICIke2F9Ig0KPiArCWRvbmUNCj4gKwly
bWRpciAiJHtjZnNwb3J0fSINCj4gICB9DQo+ICAgDQo+ICAgX2NyZWF0ZV9udm1ldF9ucygpIHsN
Cg0K

