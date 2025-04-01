Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A74C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 02:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAOwMBbulql6QJn1hjxDwrMPwzX/EemNZTuj/KnlqlI=; b=fHCz3Jixfzvbb2voJjnqsSbbSH
	bG2tzTxUth/2odTDSqrp5YIhG8KZNySDGd8vVLRcD4fzZyWQ0+lnE7EI9ldCQN4/QuXF+EsqdToqU
	qoQcCYUOIj2rA/gjrj4q2PIs38l2Kzr3QwWWhhd8LlfjQXOzQ53jmQA/d3IHQCYbDJGOIDuep0Jan
	+ynDAIXpT6c6KsecfZDtgrrnpIPG3ctLg8NuJzw9j5haZ8tEu8t9CYV2DTjSN7SOvbl/CG/nPi1Vr
	sJ3rV9A4Pwh9Cz0O4Ldqqw6SN17fgPGRZ3q/kFo6DUJU5y+JDICs/LMykW5wNLkN+fhRPSAKf0ycF
	6t6qw3aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRmf-00000001p0D-14HX;
	Tue, 01 Apr 2025 02:55:25 +0000
Received: from mail-bn8nam11on20626.outbound.protection.outlook.com ([2a01:111:f403:2414::626] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRmc-00000001oze-0Atn
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 02:55:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOoAcP0QpH6hk5SPllu9t/N64HIiPXC2pc50pyQ6GRD5fMadqte+FYZrHgLQn/+ysOTGnYatXQ0hp+Gl2EvWQGoxkEEuUMR8+QnJO0Rh0HTfDz7CAgFL2VVlUbshXyoJP9QorjAN1y2/cpxYe+ZgXwYMKLJyuW8F4DE2zoHvKQLIylfx75H6lPqVuWyAuiK4n02iRVj3s6DnDHf6BP6qdrJHgnyv8qxaCN+H0gCsXO72E00M4D76UCCaX4NaQeMZlVzV3hSzdsdk5fXdLVTYjcyUQsSXNbJibHSi3Ue2AqyHnkofFnTaMQPT7DA89x3dPNrdhVW0o7PrFGpl2LvDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAOwMBbulql6QJn1hjxDwrMPwzX/EemNZTuj/KnlqlI=;
 b=TeLKXzT9ynl3e886YSqwbhJVYWk+MBmGhnPXjRy4FSSlTvqH0Ejzzd5Jd3CIZbXMMT8ElOFCMMB1RH6Su0AcsB0P6TUiXzfJHxoRj2X/Wj3heDKZxv3vW8WHZs5h+toO2WaEl9shXrZ5lJDmYbpsRazwUwb25YfjVB7oy6qntr6UQ+VDcOJ9VZUfECTzDwioP2OLv7Uau5Of5KwhrzX7YsZjVyB8qrxQgY89RrgdLWsFU1H/NNWIOVvdL+JPiNHJHCj/LOxLzRl8+rVOzm2B+CYHHKxsCeoF8m/mGz1aVeYSwHkRSa/eKDP2v4Itk5AZIWi1c5Q4g+Uexxf81izSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAOwMBbulql6QJn1hjxDwrMPwzX/EemNZTuj/KnlqlI=;
 b=YV2/1NdUta7Sdc44dKFfZIVb0SXhYEHSJpoTEmN8+mTfSjRRNOlbiTYbQw6wqsr+KI0ONCL3Kr92biNWBJnERCAQeo+fOaQmcUUfKYt1yBLU+NaRM4zcUIQZ39pnRraqEomqkvCCjk6IbuiHPvH1jmRCDrvpYhlw/UHpkW0lrda6nxa+C6ZXDhxRsjI21N7l+oRcqKh8tL+w3XQmWPU6XSYql5fepAPtsZaosugsa8IucHW1rKhU3T4XmXWxak7ZiONVJ1N0/f+R8e2FNGKfgxNwT8yg6q/I3Jjxmk5mkQI4txk4X/M4ACJffvfnj6IA3c3QlgJbE34Bg9v0jUC9rQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 02:55:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 02:55:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yaxiong Tian <iambestgod@qq.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yaxiong Tian
	<tianyaxiong@kylinos.cn>
Subject: Re: [PATCH v2 2/3] nvme: add sysfs interface for APST table updates
Thread-Topic: [PATCH v2 2/3] nvme: add sysfs interface for APST table updates
Thread-Index: AQHbn4J1h1EoIRAA1E28sp9lJMu/i7OOI/YA
Date: Tue, 1 Apr 2025 02:55:15 +0000
Message-ID: <d89c3460-cacf-4df1-bc31-3b710671d699@nvidia.com>
References: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
 <tencent_29C768845246A8732C6D233A857EC74B6809@qq.com>
In-Reply-To: <tencent_29C768845246A8732C6D233A857EC74B6809@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: b153788b-2879-42ac-e102-08dd70c8a101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXpUOGQyRkZkRWxZd3o1dkd0N1hMR3NYL2h0ZTZPMlFNc1dOOVgvcUFNYys4?=
 =?utf-8?B?eGMwSUcwOG9XWjZ2dmtWR0FiN0h6a2s1WXQ2dE9xYVhqK1V3K3BRb3JsQ1JB?=
 =?utf-8?B?VEloUFduS05hb250aG1Rd0JoWDh0a01WN1NUZXZ4bU9nOGZiZURHRWJ5ZCt0?=
 =?utf-8?B?YWVJL0NvdHNEV2hpNlh2OHY3VVJCMFlrZ0x0ZW1vcmtqbXh4WmViL0ZsS2Ux?=
 =?utf-8?B?bElja3dlVmpxSFlRUEExUUExOEFCK0FyeCtDS05XL3FLYk1oMGVtVU54RnZE?=
 =?utf-8?B?YWNQU01UTTZyQ0ZSM2RwaUFLWkxoWUY1QmRBblR6b1g5T2t2Z0xqMHVQd2Ni?=
 =?utf-8?B?Wk9QQ3VFREZBY2tDTG1mVnVMc0J4Y2ZsaC9neGxmWlJNN3RtbHJYNGM0OHJl?=
 =?utf-8?B?UmFzaWlISGJibkczRXlWVU11eStOdFVHUHJkb2NrcnlaMy9QZkNVNmVqMytz?=
 =?utf-8?B?ZC90OFpiYTZMcVlCblU0aHpwQ1lJcXcveXhzNDA1TkpOb2FnbmplSGFMaDZv?=
 =?utf-8?B?V29nSHRyaXd2SS92QXJqYTdON3RKUGZWVVArVGJ0RENDS0NtcnJ6N2c0QTBj?=
 =?utf-8?B?NjBQcmkwRUgrb3BUdFNVWU44K25qSmloSGVoaStZaExDTXpaa1VuU3ZPSFN3?=
 =?utf-8?B?MFNLZHVGZkp5TklXb2pRcnlOWHNRclpmL3dNQzVjMkx2bEZZWWpRMnF4Ujlj?=
 =?utf-8?B?Si9xR3p4Zm1XOWJaZjJFU1B6MlZuZUNrRUV3RDNidWpHTDNNOHY2ZFI4dEQw?=
 =?utf-8?B?RzBGc2ZpTStQemdoUzlBdmhlVDFSMFl3WVoxNXNlQkluZnZYd2xWYmU1ZDZt?=
 =?utf-8?B?Zk9QMFdmNjZneVIxNER5SFRLSkJadGU4VzhpTGN4cUF2dUJrR0tQYlJUeHpy?=
 =?utf-8?B?QnlCM1FBM2gxSlhiYXdVa0ZLU1RWK2ViRnlrdE5QTEhnQTJtT3NaY0RRVnE4?=
 =?utf-8?B?andldVlnYWJIbG95VWFiQkJBY0xpcFdtRWZ5N2I4Mjh5SS9leTkrL3lsWGYy?=
 =?utf-8?B?c1MzQnpodUZlbEdIQk0va2dZSUM4aHZvL1pxS0kyd3ZlT3JpVkpES0V3NTJk?=
 =?utf-8?B?Z01vejc3WXh1eHlYL1RSMWVjY0pGVGQwa1pWMGF5YXpZQ3FXVDNPR2JBZDhW?=
 =?utf-8?B?WUZiWGxjVit3QlFVcGc0NWpsUGhLdjBDeWlXa1grYmw2Umpsb0I3Q1NacERn?=
 =?utf-8?B?b1h3cndMYXIzT2dWZkVXSFd3RWxwNlFYdzczWWJGZWNFamtlSFFpSUlzek5q?=
 =?utf-8?B?Nzd4cHNMN3JUaTZlLytJMnZ5Z243VllkWkZaK0I2L013MFBOSHpwRzNEaGwz?=
 =?utf-8?B?bSsrWjMvREg2T3gyVlVVajIzVXBRK3F3d2FFSWp2aThtSkxUYkZoOGx4RC9H?=
 =?utf-8?B?OWZxUlhkVS9Ubm1jZTQzVWswZzkyaEMwN2tpc3ZwS05td1c0RW55aVA1b29t?=
 =?utf-8?B?NGJPVGd4U2MrRlNZdjk1Rjc3YmgxVHpWSjZCVEw4dnRQQzdQME5SWnREWXBr?=
 =?utf-8?B?blZvUEVMbFNMSzV1VVpoVXg4M01nZ1NCeHByWWduRWxCeGIvUUQ3UTNRelVj?=
 =?utf-8?B?dG4vaEtBT3U0V0lRVVdTZDY1SWRGZXRETkRxNDUvLzNQSlRLQnhDOGdBeEI0?=
 =?utf-8?B?dlhFdktGSFM4SXVNTThUMDZmcEcyMU9rVVFrR0poZ3dVQjAwUjZSNlp5Qi9k?=
 =?utf-8?B?MkxlM25aWTVmRWNpLzZwL1gyY0dmOGZ2c1BVL1ZmRFlSRWVvNEp6YU9KVkhs?=
 =?utf-8?B?Nnl4SDgzUllGdmRObDBSUHA3ZTdlSHJRalFydHc2Z01CREFPa1FpQ3FGbFU4?=
 =?utf-8?B?R0NRdDVSU2NTMWRTdVFWa0I1SVZ5RGdLM3hIN2VJdGZocVRHREp2ZUhVbjZJ?=
 =?utf-8?B?STJ1NmZOQnlOL3B2dWtHZTBBODdKUWZSUFRsenRYMWIyeWFja1RNVjdlRndF?=
 =?utf-8?B?Nng3cy81V0M3OVJ5SXlUZXcrNExDM0tEZmhNR0RCV1hnQS8xQjE5Z1l6ajBS?=
 =?utf-8?B?NFdCRGNHa0Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFNqeTVMRTdYWUxwZThCYjZJWWlPM0psVzdMaEVJS3N3VjBadUM3U0lSbVBN?=
 =?utf-8?B?ZHFaWkVzSFU3U0VmMjB0TFV2Szd5ZWFsMVhNUjYrRnZobUxuRlNmeFJHT0pQ?=
 =?utf-8?B?NG1URTFjOWN5VzB0Qms0THRUbG04Yk1KRE1WZkhGSkVCNEkwNHRiTlVsbXd4?=
 =?utf-8?B?R0l5Y2k1bVVzdHVvVWROcDlQa3Y3T1o1blNQWVZuNnNuS3JlcTF3bXZLZ043?=
 =?utf-8?B?UE9ZMlJrd0FHVUd3cGhDUkpOYlZlb2hpUHhHcUFqV1NzNHFEazdOTXFtbVMx?=
 =?utf-8?B?c1NEcWJKVEV1Q3VNQVJDRzBMTU55SEs5bkVXQnNabThvcUxsdS9RUXAwZ1FS?=
 =?utf-8?B?U2xwUnRybHdqRDdZN1Q5enBOdllXUTdiNWoyTkU0SmNmRGRNZHhWU3UrZDZM?=
 =?utf-8?B?UzhwZTJrRlhzRndFUjBRR1oyeDBid2NsVVh0TnFSY0ptWWFTMzhJTzh4Mm5v?=
 =?utf-8?B?UjlnK1VMTWxBcDhWdFRSYjFrOTFCaWl5QWt2b29WbEpURlV4Qzh2bEdkTTBl?=
 =?utf-8?B?Tm4wYXVQQTB5ZUV0WE80K1RYK3A0eXd2cXQ4b2V0cFRwUGJNVEdTbHdTN1Bz?=
 =?utf-8?B?OXRPcUZRYWZTakJsYWVOWUZFNmZzYzU3M0lKSkxtZnJHcVh4L1pERzJxdmEy?=
 =?utf-8?B?THVZV2pJRWRGd3E2NjJ0MVFMVU84NkRHWERNN0Q5ek1xUXZ3LzBKd2I1VnZ3?=
 =?utf-8?B?Y1hETVZ0cDVKQ2lWUU40Q2N1UUxyeWJ0VUZoR0hNZ0pvK0hMZ0F1WWErUDA3?=
 =?utf-8?B?RVZkMTNLTlh5bnVsczF2Uklaa2krOEtYQ04wTTVqVzZKNFVvTDVnMXAzaTMw?=
 =?utf-8?B?L3dOYnRGRGE3dUo1alJETjBYK3VhcndaVk0vOVl5N3pPK29lN0RqM1d3cXp6?=
 =?utf-8?B?bE54YkhaU2F1dlFVU1V1amFOeER5UU5Wd1p0VXhOOHV6YnV6NEN6MnVwZi82?=
 =?utf-8?B?YlJ0MHZ6aWdhTFlLaFhIcVF3WmIwaVU3OTZqU0grVjhqcUtpK1k2WCtnWmIy?=
 =?utf-8?B?cVhoNWdpV0NodTVPS0p0N2ZxNGIzK0RpVlNnMWNsUEwzNXpheEc0bGFtZHp0?=
 =?utf-8?B?dnV4K25HT0hRN21yb29keVlKYXFGTXZzSzU2cDU4ekovUmlSV05tbHV1NUlP?=
 =?utf-8?B?Qy85ZTUwcWhtUi9Yb1FOaUF3c2R4dUh3UHNWK1ZjQ2I4OWJoNGN5MGI4eElO?=
 =?utf-8?B?anVJT3Y4dURlakRRYjdwd1plRW0wRFBhWEFoYTNHUEtvem43cTc2c2NZNzZW?=
 =?utf-8?B?Vm5HZ21ORlRDZnB2ZlZzMVJKbjRNWlZ5aHlZa1NhY04wTFp4RUtRV2lwcklQ?=
 =?utf-8?B?TERrdDg3YXVoRGlYTkV4cElSandoc0pLVkdEQ1VVTkZYQTRESTcycUVodHpp?=
 =?utf-8?B?S0RRcksvdnNQUlRBekhKWnBCbmZUT2xpRm5jSHFDSTltRGc1Y0ZxZU5LMWQ0?=
 =?utf-8?B?bTExdjcreHlGajVqSmtrNDBYZW5xMjVVU1JnK0k1UGErZVoyT0d1MUN2TDU3?=
 =?utf-8?B?ckZ4Q3ZIREp1blo1Qnd2Q1ZmQnpZUGMyMUNVcnorWDQvemN3OHdybGRnb0M4?=
 =?utf-8?B?b1l1SFBFWVYxbFJWdHRDMENsZ3NmNklaVGVidWltNUUvdEJuOUVRYjVVVVkr?=
 =?utf-8?B?QUV2WHVleXcwY215OEhCRnplQnlDVC9vMnZQLzN2bXJVcVBhUGNqLy9ISktB?=
 =?utf-8?B?TW1vN2ZFNWlrMklxR3l1b1VzNFFPRDlPQjZqdkdNQUhHSGxqZW04KzBqdENz?=
 =?utf-8?B?QmhFL0dYWE9IZ0M3VlZnZ0I4ZlIxeW9JVkd1WUFkM0IwWVVmSlp3WGZiU05K?=
 =?utf-8?B?MmFqdmxldjBLOVRHbkphd0wzS09HK0xMV055RFhkSEF6aXJSb0pQVEM4eWc3?=
 =?utf-8?B?bGtEQzluSXdGRm85cFpMcWVnVmVWM08rNGNMZjRTS3dEY1FRMkVUcW9EeGJ5?=
 =?utf-8?B?R29Rdkg4MEErTU03MVlUaklvNDlTYkxZN1JkK1Z2RytMMkhWeElPRGQrZmg0?=
 =?utf-8?B?T3BvbmZseWgzeVM4eXZKM2w0cDYwWjBpYk5wbEMvSmhCeUNMK2sxS1pkMjdn?=
 =?utf-8?B?OEVTc2ZOclF5WitrZVFmK2JWME5ISkl1ellsWFhqcGUvY0U5Y2xXbzlPZm05?=
 =?utf-8?B?anN4cU5hRWNmSXNCQXN5aXFJb29sVzVtMFhvbG9PNXFNcUpVM1Jsd0VPc0h0?=
 =?utf-8?Q?SaE7bm/iTRDJYEMJsuuLL5JS7+2Wo8POhNCp33lRhtdD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5292F199A3EAA42A8FE86CAECD0069A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b153788b-2879-42ac-e102-08dd70c8a101
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 02:55:15.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmgGGvbi6n3z4X8kLzczrd34bxjweWHPxd4zWxBIL2E11N1qesmwhOuIwtVTNexIsHPiP2Q2rkf+BJhDWV5JlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_195522_171926_44A7A3AA 
X-CRM114-Status: GOOD (  23.44  )
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

T24gMy8yNy8yNSAxODo0MCwgWWF4aW9uZyBUaWFuIHdyb3RlOg0KPiBGcm9tOiBZYXhpb25nIFRp
YW4gPHRpYW55YXhpb25nQGt5bGlub3MuY24+DQo+DQo+IEN1cnJlbnRseSwgdGhlIEFQU1QgKEF1
dG9ub21vdXMgUG93ZXIgU3RhdGUgVHJhbnNpdGlvbikgdGFibGUgY2FuIG9ubHkgYmUNCj4gdXBk
YXRlZCBkdXJpbmcgbW9kdWxlIGluaXRpYWxpemF0aW9uIHZpYSBtb2R1bGUgcGFyYW1ldGVycyBv
ciBpbmRpcmVjdGx5DQo+IGJ5IHNldHRpbmcgUW9TIGxhdGVuY3kgcmVxdWlyZW1lbnRzLiBUaGlz
IHBhdGNoIGFkZHMgYSBkaXJlY3Qgc3lzZnMNCj4gaW50ZXJmYWNlIHRvIGFsbG93IGR5bmFtaWMg
dXBkYXRlcyB0byB0aGUgQVBTVCB0YWJsZSBhdCBydW50aW1lLg0KPg0KPiBUaGUgbmV3IHN5c2Zz
IGVudHJ5IGlzIGNyZWF0ZWQgYXQ6DQo+IC9zeXMvY2xhc3MvbnZtZS88Y29udHJvbGxlcj4vYXBz
dF91cGRhdGUNCj4NCj4gVGhpcyBwcm92aWRlcyBtb3JlIGZsZXhpYmlsaXR5IGluIHBvd2VyIG1h
bmFnZW1lbnQgdHVuaW5nIHdpdGhvdXQNCj4gcmVxdWlyaW5nIG1vZHVsZSByZWxvYWQgb3IgUW9T
IGxhdGVuY3kgY2hhbmdlcy4NCj4NCj4gRXhhbXBsZSB1c2FnZToNCj4gdXBkYXRlIG52bWUgbW9k
dWxlIHBhcmFtZXRlcnMuDQo+IGVjaG8gMSAgPiAvc3lzL2NsYXNzL252bWUvbnZtZTAvYXBzdF91
cGRhdGUNCj4NCj4gU2lnbmVkLW9mZi1ieTogWWF4aW9uZyBUaWFuICA8dGlhbnlheGlvbmdAa3ls
aW5vcy5jbj4NCg0KYnkgYW55IGNoYW5jZSBjYW4geW91IHBsZWFzZSBwcm92aWRlIGEgdXNlLWNh
c2UgaW4gd2hpY2ggc2NlbmFyaW8NCnlvdSBuZWVkIHRvIGR5bmFtaWNhbGx5IHVwZGF0aW5nIEFQ
U1QgPw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgfCAgOSArKysrKysr
LS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggIHwgIDIgKysNCj4gICBkcml2ZXJzL252
bWUvaG9zdC9zeXNmcy5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMN
Cj4gaW5kZXggZmIwNDA0ZmVlNTUxLi45ZGVhMTA0NmI4YjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4g
QEAgLTI2NTQsNyArMjY1NCw3IEBAIHN0YXRpYyBib29sIG52bWVfYXBzdF9nZXRfdHJhbnNpdGlv
bl90aW1lKHU2NCB0b3RhbF9sYXRlbmN5LA0KPiAgICAqDQo+ICAgICogVXNlcnMgY2FuIHNldCBw
c19tYXhfbGF0ZW5jeV91cyB0byB6ZXJvIHRvIHR1cm4gb2ZmIEFQU1QuDQo+ICAgICovDQo+IC1z
dGF0aWMgaW50IG52bWVfY29uZmlndXJlX2Fwc3Qoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4g
K2ludCBudm1lX2NvbmZpZ3VyZV9hcHN0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAgew0K
PiAgIAlzdHJ1Y3QgbnZtZV9mZWF0X2F1dG9fcHN0ICp0YWJsZTsNCj4gICAJdW5zaWduZWQgYXBz
dGUgPSAwOw0KPiBAQCAtMjc3OCw4ICsyNzc4LDExIEBAIHN0YXRpYyB2b2lkIG52bWVfc2V0X2xh
dGVuY3lfdG9sZXJhbmNlKHN0cnVjdCBkZXZpY2UgKmRldiwgczMyIHZhbCkNCj4gICANCj4gICAJ
aWYgKGN0cmwtPnBzX21heF9sYXRlbmN5X3VzICE9IGxhdGVuY3kpIHsNCj4gICAJCWN0cmwtPnBz
X21heF9sYXRlbmN5X3VzID0gbGF0ZW5jeTsNCj4gLQkJaWYgKG52bWVfY3RybF9zdGF0ZShjdHJs
KSA9PSBOVk1FX0NUUkxfTElWRSkNCj4gKwkJaWYgKG52bWVfY3RybF9zdGF0ZShjdHJsKSA9PSBO
Vk1FX0NUUkxfTElWRSkgew0KPiArCQkJbXV0ZXhfbG9jaygmY3RybC0+YXBzdF9sb2NrKTsNCj4g
ICAJCQludm1lX2NvbmZpZ3VyZV9hcHN0KGN0cmwpOw0KPiArCQkJbXV0ZXhfdW5sb2NrKCZjdHJs
LT5hcHN0X2xvY2spOw0KPiArCQl9DQo+ICAgCX0NCj4gICB9DQo+ICAgDQo+IEBAIC00ODUyLDYg
KzQ4NTUsOCBAQCBpbnQgbnZtZV9pbml0X2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiAgIAljdHJsLT5rYV9jbWQuY29tbW9uLm9wY29kZSA9IG52bWVf
YWRtaW5fa2VlcF9hbGl2ZTsNCj4gICAJY3RybC0+a2FfbGFzdF9jaGVja190aW1lID0gamlmZmll
czsNCj4gICANCj4gKwltdXRleF9pbml0KCZjdHJsLT5hcHN0X2xvY2spOw0KPiArDQo+ICAgCUJV
SUxEX0JVR19PTihOVk1FX0RTTV9NQVhfUkFOR0VTICogc2l6ZW9mKHN0cnVjdCBudm1lX2RzbV9y
YW5nZSkgPg0KPiAgIAkJCVBBR0VfU0laRSk7DQo+ICAgCWN0cmwtPmRpc2NhcmRfcGFnZSA9IGFs
bG9jX3BhZ2UoR0ZQX0tFUk5FTCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9u
dm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gaW5kZXggNTFlMDc4NjQyMTI3Li43
ZjhlMTBmNWJmN2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gQEAgLTM4NSw2ICszODUsNyBAQCBzdHJ1
Y3QgbnZtZV9jdHJsIHsNCj4gICAJa2V5X3NlcmlhbF90IHRsc19wc2tpZDsNCj4gICANCj4gICAJ
LyogUG93ZXIgc2F2aW5nIGNvbmZpZ3VyYXRpb24gKi8NCj4gKwlzdHJ1Y3QgbXV0ZXggYXBzdF9s
b2NrOw0KPiAgIAl1NjQgcHNfbWF4X2xhdGVuY3lfdXM7DQo+ICAgCWJvb2wgYXBzdF9lbmFibGVk
Ow0KPiAgIA0KPiBAQCAtODI4LDYgKzgyOSw3IEBAIHZvaWQgbnZtZV91bmZyZWV6ZShzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsKTsNCj4gICB2b2lkIG52bWVfd2FpdF9mcmVlemUoc3RydWN0IG52bWVf
Y3RybCAqY3RybCk7DQo+ICAgaW50IG52bWVfd2FpdF9mcmVlemVfdGltZW91dChzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsLCBsb25nIHRpbWVvdXQpOw0KPiAgIHZvaWQgbnZtZV9zdGFydF9mcmVlemUo
c3RydWN0IG52bWVfY3RybCAqY3RybCk7DQo+ICtpbnQgbnZtZV9jb25maWd1cmVfYXBzdChzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsKTsNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIGVudW0gcmVxX29w
IG52bWVfcmVxX29wKHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtZCkNCj4gICB7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMu
Yw0KPiBpbmRleCA2ZDMxMjI2ZjdhNGYuLjUwMDNjYjI5NGQ2NSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3Qvc3lzZnMuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5j
DQo+IEBAIC02ODQsNiArNjg0LDI4IEBAIHN0YXRpYyBERVZJQ0VfQVRUUihkaGNoYXBfY3RybF9z
ZWNyZXQsIFNfSVJVR08gfCBTX0lXVVNSLA0KPiAgIAludm1lX2N0cmxfZGhjaGFwX2N0cmxfc2Vj
cmV0X3Nob3csIG52bWVfY3RybF9kaGNoYXBfY3RybF9zZWNyZXRfc3RvcmUpOw0KPiAgICNlbmRp
Zg0KPiAgIA0KPiArc3RhdGljIHNzaXplX3QgYXBzdF91cGRhdGVfc3RvcmUoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiArCQkJCQkgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4g
KwkJCQkJICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3Qgc2l6ZSkNCj4gK3sNCj4gKwlpbnQg
ZXJyOw0KPiArCWJvb2wgYm9vbF9kYXRhID0gZmFsc2U7DQo+ICsJc3RydWN0IG52bWVfY3RybCAq
Y3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KDQpyZXZlcnNlIHRyZWUgPw0KDQorCXN0cnVj
dCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCisJYm9vbCBib29sX2Rh
dGEgPSBmYWxzZTsNCisJaW50IGVycjsNCg0KPiArCWVyciA9IGtzdHJ0b2Jvb2woYnVmLCAmYm9v
bF9kYXRhKTsNCg0KYWRkIG5ldyBsaW5lIGFib3ZlIGFmdGVyIGFsbCB0aGUgZGVjbGFyYXRpb25z
ID8NCg0KLWNrDQoNCg0K

