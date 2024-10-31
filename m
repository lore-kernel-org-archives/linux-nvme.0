Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261E9E68957
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2lg9QEtkxNYE9FInvkBDf9RqIpaJb5rPvF4wBOTa5QA=; b=EzopdDGXpTvxOZaTqrlfr2/hbg
	VyKptfVFlWuOeTA6DGIBDYhZhtA4Ys9UvK9dH8AoaIdX04VvnEuWPZKoNrerkSh6Dq0FoTGxH/fQJ
	lBsm/aYVyIYAymepyNPwIa8ox1uNb09mdCN7sc0szFCNKW8JCzMcNlgBVg3PC7H/N5Nb/QRB2OJDo
	nvTN6n0d2+4RtoZJOVLJMlYF5UkKnqnFjkBzMJ8du7bzOsX87pCYB8/BFj+W9uGXzoQxjXIy/S0O0
	PfBvodJ5v4aBL2x1Bl1nSrKEdBa92a4o3Uai+EbNU4JqLviqA61M+TAUWRzWZXgTdFlhmNOnuUB95
	0plpwlMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Oq3-00000002hiK-0hSy;
	Thu, 31 Oct 2024 06:39:23 +0000
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com ([2a01:111:f403:2415::623] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Oq0-00000002hhJ-1cwD
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL8c1N//oflvSauC0PG2OUKeg/8RfJ2oYWZPAZxD5GcbogI96te8v88l9YtPXoXlq//CXbco5RLujTT2gPvnZuAvk+Pz0Trl6pAQzJ4Jx20E7bq179tbKfo34Pe+G9aEp3w3Zb10eXUFf4AqtUNaOXe6q019sA0i3DPagsSP4wefcXxoYhSZ3Ag6RT4h3Av7VeksSeHCBXlc8dUINFCz4ew28J72N2aMz8ySIETiPXWj/pVw9DXspvQxwnxQ01DDg5u048vsFC1I7K4QbdKYD+zlgIwPyR9Qq5iUH7Ll8lpur1OAg3r9NY0uR2DVQ5A2VB3x/jghE7TOU+P5UiXT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lg9QEtkxNYE9FInvkBDf9RqIpaJb5rPvF4wBOTa5QA=;
 b=zLUH9+b8jIbI5LP7gNpxJy1gNFnmL69gFIiMh3cVhwo9DJjlqioXmAbC+6SfbWnLtI9mlz/IEH0oSy2Nn2pHCNcapJofYnFyhvXmXFkaO+GcRN6oES66C829JMi+fyHBAVZJYo+R5heEBkFZC61H8pCrDO2DXvurHaEPZdwfDMJBJuEB0gEz722jcLRwbmn0Zvz35pD1vm75dqajbWJqlfeUmaswWnpnaSIffgbF1nEnqe5cT78A0dblVJepeWf6K+gMXko7qMZ0TS7EH4AApIPgDHP10SSfgmV40o6YfBjgll4lZpoSowfV4GBgTC63zG8zAgdWljbYoZppJIjiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lg9QEtkxNYE9FInvkBDf9RqIpaJb5rPvF4wBOTa5QA=;
 b=jzQpfo/pbIHD6LVRQEGH6aQiUpZN+Xbv1fI1Uw+9c9r2iXf7xgZjWUL5sHVTSyt4uEYgHrG5vbxKUxU3qYwYfC86suYXo6f99DRkT4d6auZOLwRF74jpIkvb46Annk+VRNvxaaT3ER1K07pttwOWLj/Ta+n6MAQiph/c/mtKOK543B0o0E3byz+RE1qblFxuEDBUFlEQPCFdqTrg1SNPQlHng5bAZsNsym5k30vvuI2CLbbg2r+W+rwdJHZSrsBQwmLed3XGyRTHhnqdpmz0AhcE2LlVZ131MVyYh5NLw7ziRlVf6sauScunUu24WUy60F4f8Dj5wapbvNwVxpPjeQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 06:39:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:39:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgIAAYlyAgABQ5gCAAFAFAIAAekmAgAB74YCAAAw4s4AAQWcA
Date: Thu, 31 Oct 2024 06:39:14 +0000
Message-ID: <613fd580-6faa-4b1f-96e9-ce306da27fdc@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
 <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
 <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
 <ff0840eb-5b41-48df-9887-3539275761a1@linux.alibaba.com>
 <8A92B3EF-64FF-4ED0-BF4E-5BB6680B8FA8@nvidia.com>
In-Reply-To: <8A92B3EF-64FF-4ED0-BF4E-5BB6680B8FA8@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8839:EE_
x-ms-office365-filtering-correlation-id: 1cb43225-6231-4718-cfe9-08dcf976bccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWN0T3JFa1MrTWFBZC84dCtxUzB1QTRPN2VJYzBxbnhGSUV5d2VoeGNrdGZC?=
 =?utf-8?B?Y2NxZzh1bXNMR0xJMDQzWkFMRVNqNUpOU2xnMExaa0FxZ0M5Z1NOcnFGN2kr?=
 =?utf-8?B?WXk5R0dnMHk5ZE5oaHdQUXJDUUpHYXJsL3cxTmNvbCtIMDZkTU14bGZkY2FC?=
 =?utf-8?B?bHZjWjBQeDF5Rlh1U3U4TlQ3ZXRJL3pxdkVUbEZwUG9ZZ3pKN3g3ZlpHZVVN?=
 =?utf-8?B?UERTUDJNeU9yTHUwMElPQUFWa3l1NTFzcTdKUU9PNm9ER3ozd3RiZEVmSlNG?=
 =?utf-8?B?VWd1eThodlZXeGJpL2hBbmN3b1VHalBudjRKVkEzS2VJU3diTVhFWkxPZkJ3?=
 =?utf-8?B?Qzg4TGxHUEZZTjhRYjF1MGgxNktWcVZEUDZQNm95azU3ZWE3NlJrY05TeUNy?=
 =?utf-8?B?VEw4ekdtRm0vbXNobmpyclIxQTRXNTdCK2REQmMya2laYy80c1NxSnkyODlt?=
 =?utf-8?B?OE05cFBpWXorM0dKVGxqVWZEVFpkMWRkYnluWi9TVU1hVVdkZVRxYW1iYUdL?=
 =?utf-8?B?cS9QRlM2b2paRU5tVThHOHU3RHJtZUd5MU9sUzNFVzJoRGVRUjRuV2dCeEFm?=
 =?utf-8?B?SG5ZYTcwR2RJamZyREV3Tzg2cGdFKzdXVEg0eHgzMGVEcTRhUmpPVVcwZ0tN?=
 =?utf-8?B?MUJUTDhWQWFldzRHcU5WM3RjcTBIL0hERFQ5ZFFYYjhNT2FHZVBma0VCUzZW?=
 =?utf-8?B?ZnlWQWpuZURrQUt5cWQ2WVhHZVJQckdNMUJFaFdPTVV5YTM3RHJGZTUvQkZI?=
 =?utf-8?B?Mm56b0ZHbUVQa3pNcHJJWjN6b29xV2sxYmJOMm9vTkN4NDVOb3JIYmUxT2FN?=
 =?utf-8?B?V2NPT2FHUGgweXR4SG9kSTRtV3lnL2dTWnhOOEhSNTR4TXJJVzJ4QVJXSUJi?=
 =?utf-8?B?ams1alc1NUJDQ2wzVlZMeFVET1ZqekFYcXp6VHZYYk9SdkJ4T0NodWNDOEor?=
 =?utf-8?B?aFQyanRBem1KaUxObHV3QmZPb3NnU3VUMUdSN1Q0cG5hblhUK1pYWVNoZUtm?=
 =?utf-8?B?eGowTzUwYmUzNUsxTnhnVlNKMXdFaWFGUUFaWHYwUXhwaU9iUWN6MldpeXZm?=
 =?utf-8?B?UUZib3RRSGt4Mk81UU5oL0Y5RUtXNTRzUkc5WStFWmtwcGRWTFFqN0NsQWF3?=
 =?utf-8?B?SkdNWE8xNElpaDFrK1JXRDlpYW9aeFdVNWNybERiUGE1eEN4NWtNbnhzRzg3?=
 =?utf-8?B?L1lKYldlLzJBUDlwdk5qZnZSSUx3TVhUMzFlS3ZWRkVXWnI1dVN2R2JjN21Y?=
 =?utf-8?B?NVJzWjdKWUo5UWl1N2UybjN4cmI2dWgwTU82ZzJpOS9aK1FVcjVOWjBPT1RO?=
 =?utf-8?B?VTdUbUJSUWZ3ZlFWY01DNE0xZTdxeWpSOFBOUXFsd2RCWlJrSC9LUmFQakVn?=
 =?utf-8?B?dlBSZ1M0RE9Ubjg1Y3J1U0tKMUwzcXhGNy9jRVkzWmtueUNUUnNodWNPVmdx?=
 =?utf-8?B?VEl0N2JCY2s4bGhhZUdOOEpnQ3NrWFRaS2VWRDNGVEtIclMzR3NkQ0RVVk5y?=
 =?utf-8?B?bWpYaDJoRm9VWHEwYjBxL3hZNlFYdkNGd1o0MERhQ1gzMWE2cGoyeU5KMXIx?=
 =?utf-8?B?NXNTNU9adzZqRmZRWXFCelhIVnBEOTJVRE9KQ1dXbU5UNkJBdmRMKzlickdh?=
 =?utf-8?B?NStLWEJselBqQy93amlEWmhocm5sQ0dyK1pHakFqOTdzUDNFdUFmaUU0TUli?=
 =?utf-8?B?R1k0OSs5endPUHkybFhNV2JkMXRHQ1dNYmNYU2F3RXF2TVp1eWZibFlvN1Jv?=
 =?utf-8?B?elhoUjFEWEZjTzE0cDhXRm1nWjk5Zk9lVmxWU3FTblVNaHhLMHJpVTdqRTJO?=
 =?utf-8?Q?ShSlzHrWUexUNg6K0qqCQGE33C1QQkCDyJI6c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVhjZ1gvRStFeDJKSFdLSDE1VWx2ZmpGNlc5d0luejVWRVdXY01BZ3d2ZmxC?=
 =?utf-8?B?UlVPV1Q0elpRcXJxSm9UZ1VRRW1JOU0rdXR6T1JTc3grWUdIVGVUdTVqeTBN?=
 =?utf-8?B?S21YZTdLZ2hMMDRuak9PNE1CNTJxWGNsZVhPN0pyaGhQSWVodVNGSXBPTG5a?=
 =?utf-8?B?aCt4OGdVTnF0eGVWSDBhSHRWb0dEWXY3RWQ1bTJsaXpYb0hsN0djL0g1M2F2?=
 =?utf-8?B?cTBsUDEwSjVkcHA3M1dkLy9IWHpoS1dWU1VSbDhaeEVNU0pKWUxyaFlMUndB?=
 =?utf-8?B?b3FSRmQ5N1dNcDBCL0hNSndoUmUvYXBPTEpKdVpLT2RKRi9PS3VqMlRIWVFU?=
 =?utf-8?B?bjlrYnZkMlFVZjFhbG1pNzRYelRKNit5TlBCdHRKWk9pQlVwUlFYNXpmQ3ZM?=
 =?utf-8?B?NzE0MUpqTW9qVFZFbk1TNlBUci85MlMvZU10NWduVjR0NjVkV3RMR2NNc1Ra?=
 =?utf-8?B?NExPUEtZdDlTUWNFMnlvZ0plK3ROWGpJVzkyZGhWaUx4dXE5ZGFpNnJyZlR5?=
 =?utf-8?B?SEhzZFVXc0dIcmJQZ1p0VGhMejBHYlFtY3hUUlhISUtqdUdKK2U5OXM5ankr?=
 =?utf-8?B?UTM5YU9lakdqUG1idlNVM3FTUnNSTHExdm5tUlczMm1QMVJCdEJRak14ZGhJ?=
 =?utf-8?B?QURBYm5ONkpiTjZjaFhhbWQ3TkhHelJKR2lOeHRnalA1ZkxyanlGK2RGdjNu?=
 =?utf-8?B?SEZBQSswaDVZOFZEcGJDTFZnek5oaTNydWVtSWpiSmNIWVN2RHIxZEQ0ZHo4?=
 =?utf-8?B?UU9HQUo3b1llZTZjWDRHMmg1MVFCZytxU3VGR0pjYU1iVEJxTStpUTR1dlZh?=
 =?utf-8?B?SjhYYWRjcEhGOU1meUI2MlZvUytzcmJmcktpb3ZPamxKeGJDV1hBTlhsYm40?=
 =?utf-8?B?aVBKa2R3V21wQXJQOXJnNWREMHlKcmxkSFUyNkNkdXMzdUtmbVpnOEZSNnUr?=
 =?utf-8?B?Q2dyMGxMSHBQaXVFVnBycUlFelp2dnN6SWpCN1ZxaXdmVGp5ajNaME9YZ2pl?=
 =?utf-8?B?Y1pMRE1zakpWL0NqK3RaR05PMDF5VEJ2S3ZtV3ByTUtxUzdXNm5SRktqUS9h?=
 =?utf-8?B?RXh1bi9qTEFHeURvalFoTDZuRWJDdk9nT3MyT2lTd0U0bkVlUjBVR0pBRjBU?=
 =?utf-8?B?K216ZDdiNEVhckVkdkdVRG1UMnlmS21WdFNZelFOM0Fxby9ML1RFSHZ0OFFH?=
 =?utf-8?B?UmRkTmFIdzJDZlcxSHhwSFlDZ1Q3eGZwUGJ5MlhJdjl6MkU4UFh2Z25wVDFv?=
 =?utf-8?B?d1ZEeXY5ZGVQQ1BJbXZ4SVpVcUdQUkdvNzBJazNaQnRLclRmeVFBZ0R1VmVz?=
 =?utf-8?B?ZDRHa29YdFNmbllmMlVDOWtJSjRsS1RPY014c0dISjdSSzNVNGd6SFVqUzRX?=
 =?utf-8?B?SlRoaXdXNUw2aFdJWkxYM3Bpci9LZmZXcnhkeENHVis5YkJYSXFjU3BEeE4r?=
 =?utf-8?B?VTBOc3RleGc0VURvZ1BXU0c5TnVBZHMxUy85Y1UydDM0WDFFVnk0Vm5TSS9H?=
 =?utf-8?B?TkJJalEyRjlDME02UW14NDhIT1dMeXBjdjBoM3UwKzFrSFhuMUlsWUhUNDdJ?=
 =?utf-8?B?RWN0ajRFWUh2YVhSVmpZZjJ3Vm1HQU82NGw5NE0rdlI4NmlKWEtqcWxPbjNB?=
 =?utf-8?B?MXU1MGVQWDNXSzB6ZTJ1dVRkdFd1WVBOekd5bWNORklYNURkQWFDNlBLS3cx?=
 =?utf-8?B?ZDlDckFBc2dLV2hVQnFsTmxXNS9WY09TVDRwWjJqVWVLNVEvc3JwNGpRTTJt?=
 =?utf-8?B?ZWN6ZHFHSm0yRzJBcFo0V3gyRjZselhYYm9ZRU5wV1hqa0R5UjFKam1kWEc3?=
 =?utf-8?B?TUgzNHQyaWVVSXF3N3FNbnJ0R01TSHpySDluWHdLRFRWN3FJZ09qT1plVGlV?=
 =?utf-8?B?SWN4MHd1ODFFMzRZNWxnNzNUMVhDM2VtSXNDeEhnQlVDN3Vzc1A4eWMzSVVX?=
 =?utf-8?B?MGZETHlERmUzLzQ5dklEQ0ZlZW43M0s5VitXZU42UGlNR09QaThydVhSaDg0?=
 =?utf-8?B?RnQwVG9veHRwbjVrcEhHeGhMUldHZlV4OVVaSlB6OVNqRlk5UVJkWWYzSWpC?=
 =?utf-8?B?bkVNSmNYMTJ1MWp2T25mZGFVYUxxSkIwT0VleEhoN21tZE1lNlFsN2l5aXR0?=
 =?utf-8?Q?A4dBQosbVrN1nqlqW1kc57Jnx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5403B38D136EB468A6FDB457EED1B61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb43225-6231-4718-cfe9-08dcf976bccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 06:39:14.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j85GINGhyBSQXyRfUGMZ9HUCGX0IysODVqewJYoxg1wTjQDgKss7XkAIhr/5nyBXg1VbKTAs/7OsV4WdUFKFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_233920_496536_B5E806D0 
X-CRM114-Status: GOOD (  11.75  )
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

T24gMTAvMzAvMjQgMTk6NDUsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEkgd2lsbCBz
ZW5kIHRoZSB2MiB3aXRoIG91ciB1c2VjYXNlIHRvIGV4cGFpbiB3aHkgd2Ugc2hvdWxkIHJlc3Ry
aWN0IHRoZSBjcHVtYXNrLA0KPj4NCj4+IEknbSBjb25jZXJuZWQgd2hldGhlciBibGt0ZXN0cyBj
YW4gaGFuZGxlIHN1Y2ggY29tcGxleCB0ZXN0cywgYXMgaXQgcmVsaWVzIG9uIGRlcGxveWluZw0K
Pj4NCj4+IG1hbnkgRG9ja2VyIGNvbnRhaW5lcnMgYW5kIHNlcnZpY2VzLiBTaG91bGQgaXQgb25s
eSB0ZXN0IHRoZSBjYXNlIG9mIHNldHRpbmcgdGhlIGNwdW1hc2sNCj4+DQo+PiB3aXRoIGZpbz8N
Cj4+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+Pg0KPj4gR3VpeGluIExpdQ0KPj4NCj4gRm9yIG5vdyBq
dXN0IGNwdW1hc2sgYW5kIGZpbyBpcyBzdWZmaWNpZW50IHNvIHRoYXQgd2hlbiB3ZSB1cHN0cmVh
bSB0aGlzIHBhdGNoIHdlIGhhdmUgc29tZSBzb3J0IG9mIHRlc3RpbmcgZG9uZSB2aWEgc3lzZnMu
DQo+DQo+DQo+IC1jaw0KDQpiYXNlZCBvbiBteSB2ZXJ5IGxpbWl0ZWQgdW5kZXJzdGFuZGluZyBJ
J3ZlIHdyaXR0ZW4gYSByb3VnaCBibGt0ZXN0DQpmb3IgeW91ciBwYXRjaCBzZWUgaWYgdGhpcyBo
ZWxwcywgaXQncyBiaXQgcm91Z2ggYW5kIHRvdGFsbHkNCnVudGVzdGVkwqAgOi0NCg0KIyEvYmlu
L2Jhc2gNCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0zLjArDQojIERlc2NyaXB0aW9u
OiBUZXN0IGBudm1ldF93cWAgY3B1bWFzayBzeXNmcyBhdHRyaWJ1dGUgd2l0aCBOVk1lLW9GIGFu
ZCANCmZpbyB3b3JrbG9hZA0KDQouIHRlc3RzL252bWUvcmMNCg0KREVTQ1JJUFRJT049IlRlc3Qg
bnZtZXRfd3EgY3B1bWFzayBzeXNmcyBhdHRyaWJ1dGUgYW5kIHZlcmlmeSB3aXRoIGZpbyANCm9u
IE5WTWUtb0YgZGV2aWNlIg0KDQpyZXF1aXJlcygpIHsNCiDCoMKgwqAgX252bWVfcmVxdWlyZXMN
CiDCoMKgwqAgX2hhdmVfZmlvDQogwqDCoMKgIF9yZXF1aXJlX252bWVfdHJ0eXBlX2lzX2ZhYnJp
Y3MNCn0NCg0KdGVzdCgpIHsNCiDCoMKgwqAgbG9jYWwgY3B1bWFza19wYXRoPSIvc3lzL2Rldmlj
ZXMvdmlydHVhbC93b3JrcXVldWUvbnZtZXRfd3EvY3B1bWFzayINCg0KIMKgwqDCoCAjIENoZWNr
IGlmIGNwdW1hc2sgYXR0cmlidXRlIGV4aXN0cw0KIMKgwqDCoCBpZiBbWyAhIC1mICIkY3B1bWFz
a19wYXRoIiBdXTsgdGhlbg0KIMKgwqDCoMKgwqDCoMKgIFNLSVBfUkVBU09OUys9KCJudm1ldF93
cSBjcHVtYXNrIHN5c2ZzIGF0dHJpYnV0ZSBub3QgZm91bmQuIikNCiDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMQ0KIMKgwqDCoCBmaQ0KDQogwqDCoMKgICMgU2F2ZSBvcmlnaW5hbCBjcHVtYXNrIHZh
bHVlDQogwqDCoMKgIGxvY2FsIG9yaWdpbmFsX2NwdW1hc2sNCiDCoMKgwqAgb3JpZ2luYWxfY3B1
bWFzaz0kKGNhdCAiJGNwdW1hc2tfcGF0aCIpDQogwqDCoMKgIGVjaG8gIk9yaWdpbmFsIGNwdW1h
c2s6ICRvcmlnaW5hbF9jcHVtYXNrIg0KDQogwqDCoMKgICMgU2V0IGEgbmV3IGNwdW1hc2sgKGUu
Zy4sIENQVSAwKQ0KIMKgwqDCoCBlY2hvIDEgfCB0ZWUgIiRjcHVtYXNrX3BhdGgiID4gL2Rldi9u
dWxsDQogwqDCoMKgIGxvY2FsIG5ld19jcHVtYXNrDQogwqDCoMKgIG5ld19jcHVtYXNrPSQoY2F0
ICIkY3B1bWFza19wYXRoIikNCg0KIMKgwqDCoCBpZiBbWyAiJG5ld19jcHVtYXNrIiAhPSAiMSIg
XV07IHRoZW4NCiDCoMKgwqDCoMKgwqDCoCBlY2hvICJUZXN0IEZhaWxlZDogY3B1bWFzayB3YXMg
bm90IHNldCBjb3JyZWN0bHkiDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDENCiDCoMKgwqAgZWxz
ZQ0KIMKgwqDCoMKgwqDCoMKgIGVjaG8gIlRlc3QgUGFzc2VkOiBjcHVtYXNrIHNldCB0byAkbmV3
X2NwdW1hc2siDQogwqDCoMKgIGZpDQoNCiDCoMKgwqAgIyBTZXQgdXAgTlZNZS1vdmVyLUZhYnJp
Y3MgdGFyZ2V0DQogwqDCoMKgIGVjaG8gIlNldHRpbmcgdXAgTlZNZS1vRiB0YXJnZXQiDQogwqDC
oMKgIF9zZXR1cF9udm1ldA0KIMKgwqDCoCBfbnZtZXRfdGFyZ2V0X3NldHVwDQogwqDCoMKgIF9u
dm1lX2Nvbm5lY3Rfc3Vic3lzDQoNCiDCoMKgwqAgIyBMb2NhdGUgdGhlIE5WTWUtb0YgbmFtZXNw
YWNlDQogwqDCoMKgIGxvY2FsIG5zDQogwqDCoMKgIG5zPSQoX2ZpbmRfbnZtZV9ucyAiJHtkZWZf
c3Vic3lzX3V1aWR9IikNCg0KIMKgwqDCoCAjIFJ1biBmaW8gd2l0aCBkYXRhIHZlcmlmaWNhdGlv
biBvbiBOVk1lLW9GIGRldmljZQ0KIMKgwqDCoCBlY2hvICJTdGFydGluZyBmaW8gd29ya2xvYWQg
d2l0aCB2ZXJpZmljYXRpb24gb24gTlZNZS1vRiBkZXZpY2UiDQogwqDCoMKgIGZpbyAtLW5hbWU9
bnZtZXRfd3FfdGVzdCAtLWZpbGVuYW1lPSIvZGV2LyRucyIgLS1kaXJlY3Q9MSANCi0tcnc9cmFu
ZHdyaXRlIFwNCiDCoMKgwqDCoMKgwqDCoCAtLWJzPTRrIC0tc2l6ZT0xMDBNIC0tbnVtam9icz0x
IC0tdmVyaWZ5PWNyYzMyYyAtLXZlcmlmeV9mYXRhbD0xIFwNCiDCoMKgwqDCoMKgwqDCoCAtLXRp
bWVfYmFzZWQgLS1ydW50aW1lPTMwcyAtLWlvZGVwdGg9MTYgLS1pb2VuZ2luZT1saWJhaW8gDQot
LWdyb3VwX3JlcG9ydGluZw0KDQogwqDCoMKgICMgRGlzY29ubmVjdCBhbmQgY2xlYW4gdXAgTlZN
ZS1vRiB0YXJnZXQNCiDCoMKgwqAgZWNobyAiQ2xlYW5pbmcgdXAgTlZNZS1vRiBzZXR1cCINCiDC
oMKgwqAgX252bWVfZGlzY29ubmVjdF9zdWJzeXMNCiDCoMKgwqAgX252bWV0X3RhcmdldF9jbGVh
bnVwDQoNCiDCoMKgwqAgIyBSZXN0b3JlIG9yaWdpbmFsIGNwdW1hc2sNCiDCoMKgwqAgZWNobyAi
JG9yaWdpbmFsX2NwdW1hc2siIHwgdGVlICIkY3B1bWFza19wYXRoIiA+IC9kZXYvbnVsbA0KIMKg
wqDCoCByZXN0b3JlZF9jcHVtYXNrPSQoY2F0ICIkY3B1bWFza19wYXRoIikNCg0KIMKgwqDCoCBp
ZiBbWyAiJHJlc3RvcmVkX2NwdW1hc2siICE9ICIkb3JpZ2luYWxfY3B1bWFzayIgXV07IHRoZW4N
CiDCoMKgwqDCoMKgwqDCoCBlY2hvICJGYWlsZWQgdG8gcmVzdG9yZSBvcmlnaW5hbCBjcHVtYXNr
LiINCiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMQ0KIMKgwqDCoCBlbHNlDQogwqDCoMKgwqDCoMKg
wqAgZWNobyAiT3JpZ2luYWwgY3B1bWFzayByZXN0b3JlZCBzdWNjZXNzZnVsbHkuIg0KIMKgwqDC
oCBmaQ0KfQ0K

