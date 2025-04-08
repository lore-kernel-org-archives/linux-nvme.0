Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0793BC36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WPJoDly7A59Q7IuEJghsy108gSzcO3gEoJcQZ5vZi5I=; b=nr9gQoDfcfaRC2YqUDxyeXjLaa
	Z/LBrCucvKWztSYrXWvTsdUnv6SmIrp1l4ZwlUczDirR6W5gVG9zafo5WukPJ4HVzjEi0uRJyZDea
	5xTL+2hrkfFK5GNAxJa3smAfgjRh8gAs66caPc47bNbv7Daem1Ra9p+qIfnJqDnaG6ADuo8FheP4p
	BuncMOhxHEGCE+tmuBfXo3wyti5WKmDGW9DmNPz0Q24rfbMqjxHCV2e1YLrt7Rnnbd4xLOsMcOnHj
	Covqy71lbDP3urEsQZh/c6LULgeFoRuECIdu3lPYGVszOxPQpRCLWsiUw1x/MoJUXXEgH42Q9gSRG
	WS3rNAlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2G3G-00000005OUr-1kJn;
	Tue, 08 Apr 2025 21:00:10 +0000
Received: from mail-bn8nam12on20611.outbound.protection.outlook.com ([2a01:111:f403:2418::611] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2G3D-00000005OUH-1cO5
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 21:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V25/6NVgehVfGQKW4Wa03UlK3fD/m/kfpbd1qvr6hlcJ+52WQ+oRTSDBhXRqYEylmsx89LHg9gRX9cAkaKvptNxeY27IxMOYKG7zLdQUzxe5DvWyx51Pti/0Ad8+x5Bi5HA3UXoZmSGU6l56YcAdmtcu+c64UaqwkcwpaDqfYYLsizZ5sYL1HKCK+awsqcYbth09WZzI9BJziTp1riPErL8FPsYtbJ/rxwd93hKO6gzL4vjBVWcyHF6CHQaZ/5dGDz0srjrqxilZ3m6B2gshsaFdzINNNABY7FWwzSDI0iZTb2GCZaGaeUzLvmVNlJcFR3ffc2LtAroqBUxDmRU+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPJoDly7A59Q7IuEJghsy108gSzcO3gEoJcQZ5vZi5I=;
 b=IRcOXZ2tbVQDJBQI8Q22AdJvo6RjvPkbCc7wdwUuW9krb9mrOe+EfOxMgqGVNlNzaPdsKGc2i1eIernmXY6pEgombdZeEJWabUewnj5t8RhJ9xVdSuwVoRba3H1CPWEfSRialXXhTPjFX8Bsemxnd8UEyzUosmWhXe3yHX7/GFo2bhCwy5u0GtAnD/sjTz4v0P1XbvDPsAvp1mzhDrV8wYE4sISDDiQ65E0XJj0rpQSyKFk+MVD1UkP8Xm6smYDtJHQ53sreO5YpV7L8L1HRwP8un6DIZGbv0pqWl3EgmWQcEKu29b3sZDclGcBh7T8lI2hxnrpxRRjBoh7bFcfzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPJoDly7A59Q7IuEJghsy108gSzcO3gEoJcQZ5vZi5I=;
 b=fzu8s/zgHk8ymtJiFGuGnSyd5NQcF/oAEPADiE2hszlpdInSyzasLwlSo2ZDWUJOr2JOzJAwDWgz8z0ABwhGX6nig5dwaT8CzJYam+DqHSy0w4E1t3G9pSaO+FkXP7N6FHGhv/PnfscKhwNbGtISKfWwfj4opCKEOMRmc7rA7G4WpHrczcEIO0oAxS4yjxiiVlBMU4apprHPGe+tegKkmKMVuHA1Vl3TACp9Zdj3Q8RcoPMAJBD+qfSJP63OTYAfdjGk5vyAYCvf9T+ICexbXY6Paoa5VbFavkbzZc0oZdvIcUwuFEkanPswAfsSjWQsBjFdajnkHLGHRZLOv9yTzg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 21:00:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 21:00:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Michael Liang <mliang@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: Mohamed Khalfella <mkhalfella@purestorage.com>, Randy Jennings
	<randyj@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Thread-Topic: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Thread-Index: AQHbpe6IgdV5tmzCOUKqR4MiwC+iFrOaRoQA
Date: Tue, 8 Apr 2025 21:00:00 +0000
Message-ID: <612d817f-33e1-4e2d-99eb-0ea87e1a958c@nvidia.com>
References: <20250405054848.3773471-1-mliang@purestorage.com>
In-Reply-To: <20250405054848.3773471-1-mliang@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: 92a241f6-622e-4add-feaf-08dd76e053e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MlNvWEpYcy9tVnhqaGdVcDl5ZGRub2pBeTh6alVTci85ZUR5UklNNjVEM2Fm?=
 =?utf-8?B?OTF6U2VpVkQyZG4zczI3bDhnMjlFK1BqMjVXN3MyUkVVT0ZOUk8ySmFvaisy?=
 =?utf-8?B?bUxJSnJsTkZFU1Z3ZHZPTG0vZ3ZxM2JJaTdJdTVLNEJDT2xLeE1zcW1UQzM2?=
 =?utf-8?B?TGVCMFV6MEpuaytHWTBpeGRBYm5mYnlvQ2Y3T1hRTEJIckpYOEZMMjdOSTdr?=
 =?utf-8?B?K2p2eSs1c2cxT3FCUHRTVXZWM1RUNU96cFdtSDA3Zk9rUjc4d1Jia1JBODI4?=
 =?utf-8?B?YVVIN3FxYS9RSXJFVjRrWlhLRmRNVmo4QnoxbkhNSU9ydGoreXF4R1prd1Zt?=
 =?utf-8?B?RFlRcW0rYnc4bURwMTBoeDduR0tsT2VsblRBT1hVOVpLK2xMZml1a1RrUG9p?=
 =?utf-8?B?MlBMN1kzYWZnUTk0Y3Z6bnp0RHVXcTVVMm92aWVkekhJNXNiQnJLcTVGM1FF?=
 =?utf-8?B?a2lTdUxkNG1HQngrNmRzT25XYjl1eDZKUTRkcloyZDVBVVR1M29EOUFWUWY0?=
 =?utf-8?B?ZUFZNzllU3J4RVBwa3Y0aldGa0VMZVJOWlo3akFKTEVaTXdadllZY0JzVFN2?=
 =?utf-8?B?d2ErUjd5WTBDVHRiRFl6RE0wUi9lTy9TTklBc1JCOGFaV3BLTjBLb3RSN0wy?=
 =?utf-8?B?azFEUCtacGUxazBzQTJWZXpLd1orSnFXekk2VmR3Z1FsaUdyTE1GQ3o0Q1kw?=
 =?utf-8?B?ZVB5amI2MVRJT0RvQTNJeHJQNitBa2ZDN0dlNldtb2VVb2FUcHphb0Q1amJj?=
 =?utf-8?B?Z2YzMVVwY0pCYlRBNHltNGpvWVQwOGJaaWFscDhsWCtuRjZHTkZJc3cvVzhB?=
 =?utf-8?B?L2FpSitQOHFHZE5tdUt2K1ZDeWpqTStxeWsrZ2t2L0o0UEVaZDY3L3dhVFlx?=
 =?utf-8?B?YW1CSmRGbEpCbEZRN0lWV0lKcjVDSUZmeHh6ck5aY0NuQWFHVUJZL3RWY0hO?=
 =?utf-8?B?YlE1eERGaUhNMjd1TFB6U2h4ejl2blJ2WXZIYTBJLzErQUtXVGVIWWhYNFA1?=
 =?utf-8?B?c0lxdC9XNUc3UFB5YUlIT1hFTmZCS3cxb1ZKVTNXYmpCcnBSMS9NODFlSzA5?=
 =?utf-8?B?blp1Z253MDZEUFMyRnFuUHhoN0RrclJXT3ovZk1TN085TTBJbkM2YnBqejhp?=
 =?utf-8?B?c0FBR2J5Y0hVcU1zdzArNnBGaS9GdjY3WTRwSDduekx1R3JPNDVSc01BRmhU?=
 =?utf-8?B?SkQ1eU84UGpCdExET2JIU2pHNFFJUUgwYmFLMUFBMWdmaHF6K2tsam94Qysx?=
 =?utf-8?B?R1BRWkJsZ3RUeDJRWUJTbnAranNUckVrVE1PV3RmRkVLOVRNTDRQMjBzZTRN?=
 =?utf-8?B?MjA2VnY0a0w2UjhQSWd5MUtMdzdtTXBJVWFvY0tuZENoUEJjRGdrUkhzOFI5?=
 =?utf-8?B?dDI4ckJqQ2swRTh5dVZ4NzBhZDM5R2oxVGROY0JjaWczaVArMU1pODNNYWF0?=
 =?utf-8?B?N0pXQ1VvZzhiNkJkQy9zTDZ3K1k3WUFTY05xOUVPUUNSclZNN3ZUT1lVTlhF?=
 =?utf-8?B?Ym1mcDlJUW8yeVNiSE5OWlhZZFphWHRwak5EZ1JvdXFhalZmVjhRS0VOVFBD?=
 =?utf-8?B?a1ZzZVEyM0tWeG5GeUtSMjFPbE9NeSs2ak9lWHNFVXJvQlBUazZTWVE5VUhO?=
 =?utf-8?B?SXpnU2RWZ1cvRzNlVDZFd1hJeGlJUmlrcmpoQVNmNFBXTXU0UEdZcjZQR0VK?=
 =?utf-8?B?YUUxMGFmVTFCZCttM2UvdTlMb3UzNzNaVE90WFA2bHlldXlrWDhMb2FOL1V3?=
 =?utf-8?B?VzArWHMxaXFlYVJTUE9LSkNVNWZOeitnSWhscm1KbU9MTmloMndTd29hUmky?=
 =?utf-8?B?NzJXQ2dsWExhSUk5V0FKdUpxSXVrZmw4dktlQitDRVNhYTlGajJhTXBSV3ps?=
 =?utf-8?B?SThqZmZrUUxsTENjdEx0akhiblZjMnhqK0lOWTJ3Sm14RjQrTzZFK1pKdUU2?=
 =?utf-8?Q?daPpTOhcV3VbntzLLSxGjdPsQTZNjeim?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUlmUGFjb0h5dGV0VnMvc1FEOC9LcWFwa2VkN1cxdmxBdnJrVEkvOEdvK2Jw?=
 =?utf-8?B?Ukt1RjJRRDFpUzIrN2I4RHc0VklXeWR3QUN0dnV5U3BZVkgrN2dzdThqQk1m?=
 =?utf-8?B?ckxuTHYyN3FTb3ZEUlpBQVRFL2dhQXk3SE56T1pNUk9lZys5aDZVSVNMWEYw?=
 =?utf-8?B?akZtTVBBYklXbk9YN0EzdU9yR3lhemtlZVc3SDVzaTJ2b3ZUTVNWR3o2UDMr?=
 =?utf-8?B?RlNnN0d3T0dreW9iUHdGWDR2OUdtcC8rSnFLcDArRlNjd045WklHRnhqOUN1?=
 =?utf-8?B?R0JhQzNmWmVCZmpHMXhHWlNPWko1TG1VU09rQ2h0R0R4Yk5jaEtuRUtMNHo2?=
 =?utf-8?B?SlhxbTVZN2g4TzlJNFJKZk5BdXlZYzk2c21CYU9uWmw4aFg2bE9uVEM0S3V2?=
 =?utf-8?B?bjNqNk1TbWN2aTlhcU84UXlIY2NPa3hkbkpSWnBEQ3pYVVhFZUhnQ1lWQ21S?=
 =?utf-8?B?c013dWQ3cDM4b0lzbXRNdkF3Y1RZNlo4NE5Nak90N3ovZGtjSGwxckRzZkVX?=
 =?utf-8?B?ZDhtNXpYUzlmY29id21QOHVQK01FYUVROU92SWxGSVN3N09VZTJhbGcyYzhs?=
 =?utf-8?B?VmxVZWZ2SzR3NWVsNUM0Q1VucDN6TlAwblc5dzd2MG9XMjQ0MDU0OGF2ZWpk?=
 =?utf-8?B?eUFhTU9FR1k4cU9GMFJDaEZleUxpU0VBUGphVXBua3U2TlBnZ3RkQkdsRXo5?=
 =?utf-8?B?VDh6aG5aUFpLMGZiQ2lVVk9mS3FuTkkwQnpJQnJpUXpEMGlQaHNsWjBWelhk?=
 =?utf-8?B?UTUxdU01K3RTd0hxU2ZRMWMrRFo5cUpJdkFEMWJ2VFo0eVhVODB1Q3ZFVHFB?=
 =?utf-8?B?UUljTHl0TGRHaW5KWkhUSGRTZWJxK0VDbzNDdm9MKzRUVlh1Ukc0R2JtcER1?=
 =?utf-8?B?S3RVZWNjVmtwRnhuaTZadmh4cGJDZHNZYndOa3l4dHZNZVQzTVduYTlHbU9Q?=
 =?utf-8?B?ZHdrTG0rcmFvRVZMblU1TEFaU3VVYW9jN1FNb2xQcHUrM3U4SExwdzVxK29I?=
 =?utf-8?B?cVRTREdiUmVXbjAvekdZZkpJVmQvaTdhdnV0OGZxUEYzNlExUFN3SWlMSnMx?=
 =?utf-8?B?dU5Sa05iMFJjRHhadm9LK1IxOW51QWNsTE93cHNqTWFKUmV3eUlxK0o0NVNs?=
 =?utf-8?B?MFhtM3FsL2NmbU5MOGRVYk5WajlSSmdNL0xrNURsaDlLUzc5RGZ6NThENHZ1?=
 =?utf-8?B?RkZtREJnYnZ4d2hraUdYVUVpNnZsb3NVNXdJUDhSTzdDbHVCbmtmaTBTWXgw?=
 =?utf-8?B?cDljUzZoVjRRQ3dmL0hrWUhnQkxQektmUHpQVndXSy9TT2hvc0YxWGdEa2pj?=
 =?utf-8?B?a0dDUWV1Uy9PcHl5S1I3YTJGYk01TE5SaEpYZXVYeGNMWXZzRzBhNWI4ZGJT?=
 =?utf-8?B?RkNBOFY4UGc0NzVUWjJwcnQyWktkdk5FMG93UGlBVW1UWjdGZ2FrRVVQUGQx?=
 =?utf-8?B?cmhhRGNCK0FLWnptclJjbm5TMWl2NEZ0aE8zUk1GQko3SEs2bHlwZFVjYWVq?=
 =?utf-8?B?QlVrS0xBMXo3aDhVUjVpZ0JwejBDUzN3MFlmbjYxaytYSlBuRTlBTUZkc0ZZ?=
 =?utf-8?B?T0hmUlJCQWZWOXlVTXJjcUJZejNCK2thWmh5cmY4cFUvYWpWTHVuR1NkUXZI?=
 =?utf-8?B?S29HYTFQbzZHMWNZbThFTm1qQnlKVHIwZnVUdUxYaTQ3d2U5d0VmUENvVklS?=
 =?utf-8?B?RzR5TW9xMy9JNThES0trNFVWaTllYTFoM2tzaEhneFVtamlHTVBaS2E2b3JN?=
 =?utf-8?B?QmRkQW12ZkhPOFpEOHpIMWUyOUN2UmprNUNuL0pVWTJJNEc0bG9DcEhsSmY5?=
 =?utf-8?B?dXlTVnFNdS9oKzNjdmdiUnRaUklneENCMm1ZZE1DY0d6RHRHNDBiNkowTjdS?=
 =?utf-8?B?c29EUHJRdE9Zd0lidFM0aWl1VzlwUnFpaktYa0RveDFOUDlVQTlsd0NxcjBV?=
 =?utf-8?B?QmVzaitGTkFDazhaSEJjMzVlUHFUdjd1aWROcHR5VktpRVplQWYwVkJNZ0RX?=
 =?utf-8?B?a3ZYTUsvTDY1Zk11NDNQOWxVRzk5Vi9jTWIzOVU5YzZ5UjFPUmVnQ24wTmcy?=
 =?utf-8?B?NkpYRXl2WHlzbitVdHNUSlpQVy9oWU5nQ0RWSDdIOFVsOFhsemhNOUV1azlC?=
 =?utf-8?B?MzJpRkRiZVc1K2QvaWFBaFNFMXJqcUlVcGI1RTlWZmtBS1N6dkJnNXR4Ymgv?=
 =?utf-8?Q?vq4cWjRKGspaOoVp24ol3eLoDDSMhQiUTTyBSqwC9Cld?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D45EF7EF9964F47927F5296B563E3D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a241f6-622e-4add-feaf-08dd76e053e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 21:00:00.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pii2Gy3gFKr5zLxfDAk8cYEWYk1ZDtL6XOZ/SdV4mcZLPA0e7g0XlVC/iEzPHjF4Pb61gGpmt0NsNoe6RsBueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_140007_428564_4B6A81DD 
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

T24gNC80LzI1IDIyOjQ4LCBNaWNoYWVsIExpYW5nIHdyb3RlOg0KPiArc3RhdGljIHZvaWQgbnZt
ZV90Y3Bfc3RvcF9xdWV1ZV93YWl0KHN0cnVjdCBudm1lX3RjcF9xdWV1ZSAqcXVldWUpDQo+ICt7
DQo+ICsJaW50IHRpbWVvdXQgPSAxMDA7DQo+ICsNCg0KaXMgdGhlcmUgYSBndWFyYW50ZWUgdGhh
dCBhYm92ZSB3aWxsIHdvcmsgZm9yIGFsbCB0aGUgc2V0dXBzPw0KdXNpbmcgY29uZmlndXJhYmxl
IHRpbWVvdXQgdmFsdWVzIGhlbHBzIGNyZWF0aW5nIG1vcmUgZ2VuZXJpYw0KZml4LCBkbyB3ZSBu
ZWVkIHRvIGNvbnNpZGVyIHRoYXQgaGVyZSA/DQoNCj4gKwl3aGlsZSAodGltZW91dCA+IDApIHsN
Cj4gKwkJaWYgKCFza193bWVtX2FsbG9jX2dldChxdWV1ZS0+c29jay0+c2spKQ0KPiArCQkJcmV0
dXJuOw0KPiArCQltc2xlZXAoMik7DQo+ICsJCXRpbWVvdXQgLT0gMjsNCj4gKwl9DQo+ICsJZGV2
X3dhcm4ocXVldWUtPmN0cmwtPmN0cmwuZGV2aWNlLA0KPiArCQkgInFpZCAlZDogd2FpdCBkcmFp
bmluZyBzb2NrIHdtZW0gYWxsb2NhdGlvbiB0aW1lb3V0XG4iLA0KPiArCQkgbnZtZV90Y3BfcXVl
dWVfaWQocXVldWUpKTsNCj4gK30NCj4gKw0KDQotY2sNCg0KDQo=

