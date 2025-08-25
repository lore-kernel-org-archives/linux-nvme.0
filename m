Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B50ECA0FEB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1PlIK2//Qrp061pUQzqqFWyrlXQrSDRDH1vic5rcnjA=; b=DC05NijnptXnDAHO8HwmNiGcfL
	lTawWGfGwcoIhNrb1K2crCFuDEenloB7J0gIFmmF7iiPDo4hGbk7zZqdnKPHCofbxYBRePmyJLcCt
	a9s9Cf//cf2Dwsz0q+HF7xJgPT/c0iB8/2/Wz3mvByD4x1oeTDc9ZKLcS0HaLq4tDoBymbQEZFzoc
	UAOle5LiYwGFqem2P2E+j3L84rrksPzPfbfH4qllStriO2iBWZoDzCU+Eyd+aHJpnoAVu86cXRx+L
	DHoFFQjpwTeH6jaXDOYB+OvBkcq4vTw5f9cZzbV1jHt02GFT+dvbTcNOUh3aFkdKt/2kAWVcr/Q81
	QAqVVrFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqcYL-00000009B1Y-2SR6;
	Mon, 25 Aug 2025 19:08:25 +0000
Received: from mail-bn8nam11on2062f.outbound.protection.outlook.com ([2a01:111:f403:2414::62f] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqaop-00000008nyI-38AO
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 17:17:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNmKyNym7Yd3J+df0d0nnQj+pnsNXoL+dOHHUIWHeBd/d9kbcCB/PwoXwvC+YxOqldXcvdwKIfK9DuVDfRVB1dCj2nth4XDvVQgLONbcSUvi38E8MCyTWE6oPRdvjZueb1N/HBB8kg5t9ywlC7rlYXxP2LEbE3ykeWszA9PDKn+n92tMjmZrcJAFV7wzDbZjoeQ4/X9L7ra0YMl65kirfhttAT0lbKJGN79Km/b6rST91BJp2+iUf4Ri/OvjRsqezn4S6TzCIeISEwHAO8islh/VzK+ZDnhXKuFg6mx+K4P6EmdyTGpyJxw4WJBYfwlj9iySlEoc/tfXEqIYfcagqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PlIK2//Qrp061pUQzqqFWyrlXQrSDRDH1vic5rcnjA=;
 b=c9gFEbydS4GLoEnWqOEyi5B1nzQxHg8OS1VsZAZBCearscBiZYOGzOUIkXsiJVf9R0i4AnPa14qAnKx3e6OhAHycqGyiTExsRdRrXnqZGPwh3CIO8nKZz9qvRjPcKl0P+8+FX8TltgYJiEO19xU5njh6fJdkotcRuu4qc9M0eQLCecXEHgKUYzfYo8OFaDq3gf8D9eK54YBNoSOmP9eraDO9CqtfaLSJJillSvKb0ajSBZPaS4ns3OZelKYXtQhdeDAJaAHNHwnjFCLpJoyrMzS8iXc7/Hc3CfBEFPqEc4QqumHNmztrOAl0SYm6o1l/m4DNPiRaWDe5TsqLpZlWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlIK2//Qrp061pUQzqqFWyrlXQrSDRDH1vic5rcnjA=;
 b=R9X6BOX9EMEXy5TqrmfcueoYgshNiPKPf0Aeca3ZqyFyA0hiX7ZmfkcuMeyWVPbGD6iI9eLfD9c1i5L+rnt/NP8zxFdrPtPCXCVE7rOx12F/WreZeFE5uFdC3XTYu1Kjlg8L4Xw8fIb/WxWocixjVriCu5TqKdRFhEPmRB4b2aPYJMb/L7z6twtPq4spjxsHCmN7PrZWZD4xVy8QW7BKsH+jU5166rDdui3B/BUGx1HdIMl/ZyALAoszPaCK8SZOoZnSbhEOYcma803NVkfXlJ9QHbyReTPwcSoTWXSUntZ/ieJ7utrLXFTUT+XrsSKqxgHe/BehmdwsJ+Z0b8bZuQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:17:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9052.014; Mon, 25 Aug 2025
 17:17:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to
 _nvme_connect_subsys()
Thread-Index: AQHcE3sAB6fi+PlSkUOPmDrxXqmJL7RzoT6A
Date: Mon, 25 Aug 2025 17:17:16 +0000
Message-ID: <e0a4b776-2efc-420a-a582-5312f9e20aea@nvidia.com>
References: <20250822151053.3248822-1-yi.zhang@redhat.com>
In-Reply-To: <20250822151053.3248822-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8309:EE_
x-ms-office365-filtering-correlation-id: 86cdf2b6-0899-4769-774e-08dde3fb3d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0pqR3JRRUcwcDFKcFU5K1FMbTFpVTdibXdLbU5teXhMNU1TdHJvZ1FSalZr?=
 =?utf-8?B?Wk1BWXBneE5oM1RQMVBWOTFHcXBoVzVraUw5UndkcU1JV2NJSnFYelVDcjIz?=
 =?utf-8?B?NEREeUVLMW5WQjU2blBiRHkxeUI2clJJbkg3NUQ3eXdXRVNoMHB1UEdHbUpP?=
 =?utf-8?B?NkZDckVBRUhwQmFIQ3RzZFZSR0dMaG5OL0plN3dzZTBpTjZRVVZBRXBhTUVE?=
 =?utf-8?B?S3p4N2VGb0ZTU2FWbWdaRmlraFY2VkFqYU1uenVGSTV4dzZXRzFLTzVaMDRI?=
 =?utf-8?B?NmZwWU5aNTA4b3FPbEkxWE9kaXdJVTdXY0paVlhuWk9ZOHdsV2NUQ0xRaC9l?=
 =?utf-8?B?OUs3Tm1ScFdFd0pXc3ArZEFPWng0Z0ZWbDV1QVlkUkZhU1paanJOT1dEZlJF?=
 =?utf-8?B?di9MbmorQjNlMUN3SzMzOGN0RTlyRE10Rmt6bC9kNmsrbU12TmdEdkp3TE0v?=
 =?utf-8?B?UlFuK0o1ZjRvUklrUyszeHR4LzdGelVrcjc5SjB5b3ovSy9lSmw1Q2o1blh5?=
 =?utf-8?B?YVlZa1NFOTJvdUIzYlR0QUpWaHRlTDRnVVdPdUJtdkk5aE1sZFNvbnMvNVpB?=
 =?utf-8?B?OWJlUHJvWXhsMzlEL0dCdmxuTCttb0JjZDI3V3lFMnM2UzlIMGpiVnNSUVZt?=
 =?utf-8?B?aDdsYWIvbEc5VytCUEVhSWVWeGlBd0lYUjYyeXVwWVV6ZVFpbjRBK3FBMm9O?=
 =?utf-8?B?enByc1lvMXM3akFWQVFWVXppSjFFQ3F1Njl1SVdUMzJuNmpMTVVPMU9NZFUv?=
 =?utf-8?B?dkhUOUEyWEVTUlk2blpFOGZ5dEhwL0tOekl4ejFCVDc5bzVSNHZWODRnMDBT?=
 =?utf-8?B?M0tFRTVxOTI2dEViekN2MWI1SW51YnM3a0xmb1YyQW92dkUyVndCQW5KWi9l?=
 =?utf-8?B?dWdYVVA5MDJzaVlJREI3dUtRTDdsNGhFWjhpZFl4RzBjeGFkd2FoS285Tlp3?=
 =?utf-8?B?ZUJUdHJXKy9vWGdNMzBhc0dKTDJuNlVtU0w5bXZXa1Zrbm0wRDBHTiswQ2wx?=
 =?utf-8?B?djZXVFJCTURZS1ljbjFndEYzYW5jRTBpSG1PUi9rQU9vY0ZCakNhNU45V24r?=
 =?utf-8?B?L3dlejlVQ1E0bVYvVzZ2QkZQNlFoTXhvcTRnajh0U1IrRGFwYWl5VGJFbTYx?=
 =?utf-8?B?NXJVVE51ZURIa1Y5NFU5NFg5OHpnVzg1YXY0NjRodXlWQjNuMUZuMXdXbmhy?=
 =?utf-8?B?UHVzUW1yTUxsY3pob0kwbG54azZNdzhadXUyVUVpOWZEYzQxWEJqc2Y4WHFH?=
 =?utf-8?B?VFpWMTFrMkx1RVpDUXBjdElpd1FKNjNqY0pXZ3dYRXZnM1V1Y1Jrd29BQVlL?=
 =?utf-8?B?RjA5dm1uRkg4cGV0a05wRW5ENUM4ZWRDd0lFRTRyY2xUWGh0T1F1SWJmV25O?=
 =?utf-8?B?VTdvN2lSVnRkS25XRDJBazZ6VS9lbGp5ci9JZzFseXpJWWovaXFSZkV3NFln?=
 =?utf-8?B?bERJcHM3QXpwWmhZVDl1RmdJNStWMEx6NjVZZVFMdWdQb0F6c0NLUmZGNVZD?=
 =?utf-8?B?Y1p3QjJ2WENYWVlvVlFuYzFWU1BBUDRxN05xYnBkVjhYR3hTRkpxT3NDaUpR?=
 =?utf-8?B?WnlidCtCYmlzRFhTZnVMaHpjVE9yQUdvQmFlb0dDWjRaTjh1dEhUOXlZNGc4?=
 =?utf-8?B?eDlPQktXS1VyWGo0ZmorakEyN1MyUnRqeGlnRFVJQ1BuYkVsMmswZ3k3S05E?=
 =?utf-8?B?QmpPMW5ha3pPMHZrVUN5dHJXT0p4V1BDVmc4a096UDZqZlpERnZVaWdsVUZq?=
 =?utf-8?B?dTlZSHA4VkMwUlNBRHhHVXE5UDFTWkI0anZWalIxOVJ2Zm9hTldGZ3NTbmNR?=
 =?utf-8?B?QUQ5d2d3WllteER2RDB3THRPckczV1ZLalFNWjJZV2thbWhwMmcveGZmMFlE?=
 =?utf-8?B?b3FTemY2Umx1bU9Ic0YvK29wbU5nSVBhdWdSYVFsY2ZkYnN6UExSMHpWRzBZ?=
 =?utf-8?B?cHpTQUY1S1BpRENTZHZnMDd3MUM1YmU1VWVEUFF4dm1IRGxSMlZFNWFzRmZ1?=
 =?utf-8?B?Tm0xRUlFQzBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmU2SmlibE41emh3TmJnRzhnZkxDUm9mbDdTQ0N4UG9QcXBxVHN0dVJJVmVl?=
 =?utf-8?B?S0ZtQVFpTjJXVExaOGFiT3EzYzVIUUlHSDE0MEJ6T2xwTXVhak1EdEJrdUFT?=
 =?utf-8?B?Z0VXcGtaTXJtMWdkTnZnRnJHSXJxRjVQQnpTQnNDTWg4a1VHUXZUeEpXU0pm?=
 =?utf-8?B?NnFnZStyOFo3dHg3WllMd3dXMTJRVkhTa09hSHZvb2I4SVBtWFpxY3A4bGNp?=
 =?utf-8?B?ekgyNHV5bThUdmlsMnBlTHlUbXRlOGhwS3pWcmdHTmpFdGFJZXc1cGhkaTJX?=
 =?utf-8?B?bVJVNGp4U25td0d2cUFpRVA2TC9oNXRQSHByS2FjMi9ta0JlWjJSaGh2RzFD?=
 =?utf-8?B?UjV3eFFtRmMxV2VvckN2bnFvaFIyaWhDM2dWLzRCVjVrMXNVb05NeGRlQ3B1?=
 =?utf-8?B?aTEzekZXdXlOYmQ1bS95ejdNKzAxZnVlWC9FMmdTLzBMMzdqUjhNZXlYZ3Jx?=
 =?utf-8?B?MitkZjJ5YWZWRlJOYlFTRE5GSFdWZFVGdnc1UkpyeWJJMUxQajlremhqbkQr?=
 =?utf-8?B?RkpaaEpVdkVHQndLMlMvNWlMWFhjZGd4aTNrWWlDbUcwUnEyaHJSamx3VmNr?=
 =?utf-8?B?YWsxeXlhVEpDbWV5Wktvc2J0UXVqL2tLYjFoK05hTHVBbXREazBSTGVxNTJq?=
 =?utf-8?B?WGMraS9FUzJPNUtxZnVpOG1FR21SNUlxSzBIaitpMUljT3RYa2RqNlZTcHRR?=
 =?utf-8?B?bWpBWEZBVFZtdnhSSENYQjRIdUVEYUlMdmtVd1RLbWJiWlpGWGVaa0I2ejE1?=
 =?utf-8?B?Zm1aRUljdHlvU1RKQ3NDalRsbWdmUkk1eUh0eWd3bzcwSllCRmcrcWpKTWRR?=
 =?utf-8?B?Y1JDU1N6b0RWcG9KQVBOK0NTeUpNaFg2dDMxOHptR1doaFVIYkpxbjhpMnBl?=
 =?utf-8?B?bXhrdTJOa0xOSDlhN3NuV2JsUFJOOEM1Sk1Mb2U3MUQ4eitCdmhzU2JzQmdx?=
 =?utf-8?B?bjBhQTh6VVZoVmpZd1hvczhtRmpDekdsN2gzS0NZd1ZTOFd6b3gwenFtMHJq?=
 =?utf-8?B?Yi9hbnJydzBYT3BIWmhubnY5RmY3MTZvdFdMNEUrUnRWWnhQME0yN0oyRlBp?=
 =?utf-8?B?SmI5MGdhZmtENnFzRnJtQ05aaGROdGpCNWJUbmV3R0RuQkdYTXl2cjNWOXhI?=
 =?utf-8?B?ZXE5T3pkWWdaTEcyeXVzdXhKT0xWMXk0VjhKeGlzU0hIMFh5Nkw2UWhpLzg0?=
 =?utf-8?B?akZBZUdKTnBEVzlCeVA5Z3BMZmQ1bkJ1SXUzR1BjYW5lcTdqbWRnbEJkQldT?=
 =?utf-8?B?K3g1THRKK0RXb0VOQXFldzRBNzBvWnJwZkZTQWlqY0ZlWGpqL2NMMjNsYlBP?=
 =?utf-8?B?bE1vMSt3UDVtcllCeWQ5K0hReEQ5NWRQT0hpc1pFWkZIRThtdGdQajluMTY4?=
 =?utf-8?B?VFlnRmRCR25DOVg4Nm9ycjlSV2E4b2N3UCtzSnp4dXpaOVFtcEtZQkF3SFJr?=
 =?utf-8?B?Y1hUN01kcnpCaWdCdTk4ZkZaR0c4S2FpOWpWd2FWUk5TdDlJZ0tFeVhFdCtU?=
 =?utf-8?B?VVBkbVlCSzNSQmlORWhTQW9nS0o5UEZVZEZYL2kxY3ZMMGhxMFFqUjBIbjVw?=
 =?utf-8?B?TGxXbElBQUI1dDRXYkt6cDJrcmhlZjB6endFVUNtQnZzY0hlTHJjdVpGN05M?=
 =?utf-8?B?K2JaQU1UOUxzNWU4NHFNbE01eEc2cEVPTE1wNnQ3TklHZ0xGUFNaR2pIVFFZ?=
 =?utf-8?B?ajhJcGRxU3g1dXg1K3JNUG8vMmdWM2ZxWjd2TGJiOEVzMDFqSW4rZlVJakIy?=
 =?utf-8?B?N2V2dnE4b2ZibitTTGE4MU5Cb0F5NllyVmd1SlhWdjR4NEt4NjZtMDNmTVFs?=
 =?utf-8?B?VUNuK2VlSGhsOHFFcklUSGFTNlBLVkNPVy9SalBqVTc5czZoRHFRS2Y5dVlZ?=
 =?utf-8?B?UlgrRkJKMXY4WTA3a1pUTWZ0TEhnUmNzVkozVDhZL2g4MjlLS2hkSldVVXlF?=
 =?utf-8?B?Nmszb2ZwaWNFUitiL2hNUW1aMnJqRXBQRS8yZENYblNRc3FuV1lBWElObzU2?=
 =?utf-8?B?WGpmTkhSZWlFV1BsYVRZbXh2QSt3NTdWbW1ma2F3dWdycWdSc2s4T3VraGc5?=
 =?utf-8?B?dzVZcmtPTDYyaFFMM0FkRnlXSFRjRXVBY2xyZlYzQTBCV3VxRm9FK2R4cGdE?=
 =?utf-8?B?QnNxKytqRnV6MnNpZW9xN1JvRnBESmlEeFY5bFVsQlZFeTVnNVBSRGlaSEdi?=
 =?utf-8?Q?XUit11kMphZAclmBr3DwVrRTG5djmZQWMtgshysqvNIS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50CAF7C7EC78884C9753CDEB0773D802@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cdf2b6-0899-4769-774e-08dde3fb3d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 17:17:16.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Jv+aBPwMHHQYh37vZx+KFH46Y/QGF5nzp77iVWBS8O9vp9ZTvG0cyvKSLic4c3ZPZHzAh2DbAn/oANQJMjayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_101719_786894_837283F7 
X-CRM114-Status: GOOD (  12.52  )
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

T24gOC8yMi8yNSAwODoxMCwgWWkgWmhhbmcgd3JvdGU6DQo+IFRoZSBkZWZhdWx0IGJlaGF2aW9y
IG9mIF9udm1lX2Nvbm5lY3Rfc3Vic3lzIGlzIGp1c3Qgd2FpdCBmb3IgdGhlDQo+IGNvbnRyb2xs
ZXIgcmVhZHksIGJ1dCBzb21ldGltZXMgdGhlIG5hbWVzcGFjZSB3YXMgbm90IHJlYWR5IGFmdGVy
DQo+IF9udm1lX2Nvbm5lY3Rfc3Vic3lzIGVzcGVjaWFsbHkgb24gUlQga2VybmVsLCBpdCdzIGJl
dHRlciB3ZSBjYW4NCj4gaGF2ZSBuYW1lc3BhY2UgcmVhZHkgaW4gX252bWVfY29ubmVjdF9zdWJz
eXMsIHNvDQo+IDEpIHJlLXVzZSB0aGUgdGhlIGZ1bmN0aW9uIF9udm1lX25zX3JlYWR5IHRvIGNo
ZWNrIG5hbWVzcGFjZSByZWFkeQ0KPiAyKSBhZGQgb25lIG5ldyBhcmd1bWVudCBgLS1uby13YWl0
LW5zYCB0byBza2lwIGZvciB0aGUgY2FzZXMgdGhhdA0KPiBkb24ndCBuZWVkIHdhaXQgZm9yIG5h
bWVzcGFjZSByZWFkeQ0KPiAzKSB1cGRhdGUgdG8gdXNlICJyZXR1cm4gMSIgZm9yIGNvbnRyb2xs
ZXIgZmFpbHVyZSBjaGVjayBhbmQgInJldHVybiAyIg0KPiBmb3IgbmFtZXNwYWNlIGZhaWx1cmUg
Y2hlY2sNCj4NCj4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIGl0IHdpbGwgYXZvaWRzIHRoZSBmYWlsdXJl
cyBsaWtlIGJlbG93IHdoaWNoIGVhc3kgdG8NCj4gYmUgcmVwcm9kdWNlZCBvbiBydCBrZXJuZWw6
DQoNClsuLi5dDQoNCj4gTGluazpodHRwczovL2dpdGh1Yi5jb20vbGludXgtYmxrdGVzdHMvYmxr
dGVzdHMvaXNzdWVzLzE5Mw0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBaaGFuZzx5aS56aGFuZ0ByZWRo
YXQuY29tPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

