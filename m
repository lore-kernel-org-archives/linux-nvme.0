Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D714AC48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N55QZPWhT/Cimh0fasP3prHSxTPpUc5DZgpSghW9wmk=; b=OV1DzEgbbxY3C9Wm/LT4+1/IJI
	6LfN6P+rgy0TrFge4BwOEn/ur/EP/R5mUFZhkEMQPSogE2h2ep2BKobXsjLD9ySh3toJAVl6rq3Vk
	ckjSyWAltIrgp9hsFDD6u5CPHubzhynKsqv6oqmm2wGTi/JYzqu+wuO/+2orFszAn1qQP/2gsm/dH
	lt+HVUU/NFuPKzh34F+kDna9ydCk635cmAl4Q8Wgn3qxVEtEq87EMEXzfgsAS+95MdT8W0OJGEAiT
	bIxJsGaeFDcPqINI86MCip0K08cHE8wugvkYh3L2f5p8kmhxeygQz7oQFNBo5LrQOr79NyV7dsadu
	aOU9idWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchmK-000000001ws-0zG1;
	Wed, 21 Feb 2024 08:16:32 +0000
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2408::600] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchmI-000000001w0-137H
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 08:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm/sBO+wHjT+7h4OH40UwQqiUNFiJNmHDr30w3uT7az2axp/7cSQQ+cnxppdfflALzFh1tvfM0kAQVl4F8ysXM3KcXt8cxJxdgtGwElHXAnAwThECYuOXPmeVBlLPVpzU/8yhr/tbkHMylVe5+mhjiF+m4WWxUBnQnxhSO8NX/MeDY6T+mm1734kNIyca1ffWbD3QKkhn746hRU2rG2OGNZ/ZqI+qL+QLCWFhrdRrYq0cqdTacinLukBiESY12nGrgKCCyWheR/hI4cyB65wu+F7DL6fPFQZTr+Sm21p3AECK/Lq6idmWVafCfRJiEga8UzZXZGJ/J/cPxf5vcmSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N55QZPWhT/Cimh0fasP3prHSxTPpUc5DZgpSghW9wmk=;
 b=kuX3b3TQkO9AyoXmxYrrgBkSK+dta/jBd9d4i6Coe1Av0c+vvFrnLmLUQr30lWjG+wdHMSEP/7BhzHqcQhKO9BN8YkpakP5t+MF5wBtNqZxQoAL+mnP9FvE6TRgjygsxNj9dN9K2wtGszla1cDhq801KtTNVnrVNqprQuXRySpNvSVR7A1O235xlHZinmEaMck9bHuuFTXGN1QqDeZd0ipTWQa42tPnGR8QRdleQhtrDcoJeJBbT8IlzM3P7wTAeFuuafYxAH3Gswec5sxsXjBI2wRPov7Rmi8wFu2Ll4e4n5/ZbfvclZ4UxnBAWfXzZHRTEzMBMLXr1MjoNxwX+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N55QZPWhT/Cimh0fasP3prHSxTPpUc5DZgpSghW9wmk=;
 b=UtETK/C0B7unmq7B8dsUw3Stb+fHzl+XQPGnv2Iwob7zuiQYT2+w555tz0y957LhO11opCIuYtt8SJENvqBrfSKfViuFEAG29LanScbABYIVMVZm6Ba8Q7OwtU2Pj+olmduJBvR2bwsT/+Hy/eed4WmGHJX+VTmp/x4ddIOA2I+drHpN+jYUAt9kqFD15F+DNmjgOn826GWUEX660gc7G1PwBHwCbUj5YKXM10vMdxfgn7ox2iX08WTxfHBFfHsdtEqD5iRmhCD1j99VmNyrQ48BjJh2sSqpTbWlDEsuJiOFOK7QQT7B5UPcuno1QEjC7AniQ8W6mc8PWdonaSA3Ew==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 08:16:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 08:16:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests v1] nvme/029: reserve hugepages for lager
 allocations
Thread-Topic: [PATCH blktests v1] nvme/029: reserve hugepages for lager
 allocations
Thread-Index: AQHaZJm9GZ2RGRfz+0qZ/jqNNwcUjrEUc0iA
Date: Wed, 21 Feb 2024 08:16:17 +0000
Message-ID: <e17f9433-8814-4a01-8532-59384d949279@nvidia.com>
References: <20240221074353.27646-1-dwagner@suse.de>
In-Reply-To: <20240221074353.27646-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB7784:EE_
x-ms-office365-filtering-correlation-id: 7cc2af33-954e-4596-a4ca-08dc32b5611e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRln8J65QgW9bfaur9BVdrSjANrz0+H9VTD1B1Yck9wTA/UWRFAG2s/3K6OIRbcAB2gjIoDeT3Cye6VhRJpbbP1d2rftXFN+IIILcxMjFNFli2etQjXcOJk1YHR0iEQntFYFiSAi7FseFBb5GPjaquyBHAzxSpOCslTzItoSBI5H9zBJ3yLakH8gc7SkvxRVd31+iu0AqJyjTkGou9v0vVWu1hBoqCmdiTpkE/ptfNBRXxgO1p4wklAuhZq8/GPnWBuvIhHdqVdtgCc9Li5JYuzei16FM5VqvskmVQOCWPrwQmkoc65IXQ70kJqwybHMZz3MUDsfMZgIIaghDTlLrrjzCN6SPJPcC9S4lXgCoiKJWp1c3ZFPj+o9pEVW7FBknbH8I8twT3mwiq24m0cUcwk+q4Ac8NCwvH1hzYVABc2ge6/iVJaS7BFRaHeTWH0oI123Pr17/dByXFrmDNqzL8wt5z/GgupBOxgTWaG18zRmqCXu4yLEZQa/mNM+b1Wpc4ajepGLMAHavXtTAVlTTSHK4CUgRcVMSo8s9P8y4ffNr2KGutoCNE8Mze72pCXCtV+Ny3l6m5YT3zeQxk7oiMI/Zm69Pa151l0/sIugKFRvZ1+NKJmtszrLz+L8b2qyquOEfP/GSZNP0duFS3j9yQFQEuiiuQxN870eXdA5Wx0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ZiV3RiMzlGRTFPejZFd3pZSDJIbVRPRUt4bGVGSTFCQmJtTHcwYUtwYkw5?=
 =?utf-8?B?V2FPT25yRWl6cjZnaTFYQ1lFTVJsRHRqc09mVHNNbzNzdlVjeVNrdkRmRGxy?=
 =?utf-8?B?ZkVwR1VXUVdoUjI1ZHdOM3R1ZndCNzlGNFd0V2NqOXZpcDUrMDFmRDhmeVJI?=
 =?utf-8?B?TGQ4SVliUUFJV2Jiei9Kc1ZkTS9VVEtEQXo4YVJXZElScTdkQnkxZU9Rb1l5?=
 =?utf-8?B?Q1dYNjZoVXJOTzdYY2tvdFFVbjNqdmVxMEltQytLWkxDQlZBd3dObzhUdGZ4?=
 =?utf-8?B?dFE4Vkw1VjNyeFdSSlp6TmJhVER3MER1QjZUZ01yRkI0WFlIOVVndlc1RUpi?=
 =?utf-8?B?TmNVT2J6cnpiY3BvampSbGdDYlJ1QVF2eTA5MTlieXBOMzgwTHAzMlNYQjJP?=
 =?utf-8?B?RHNVSHE3bmtCb3Z4Q1VzMTgxK3dkc1ZJU2tyL2pldHM0WERURHp3b3NIUmdQ?=
 =?utf-8?B?VytjR3Bxd0pIcHNJbDBGRXlEdXZOUVIzdlpadzN5c1FPVEtPVlZXZW9rREVa?=
 =?utf-8?B?UVEvUTVpVWorWC9sblFSMENvcnk1RVhQZUZ6SW15YTI5SkhUZW1aeVdBY3NH?=
 =?utf-8?B?NE5GbnJJMmNteU0xMTNsNDUwckRGN2UvZGJZNStsTlk4SEQ4VGpCY1FvNnBq?=
 =?utf-8?B?d2xyUHJWTXdBY3hnbGtBeFpMN3dVREpIN3NIc09zTVllV3Qxa3BSTllKbUIx?=
 =?utf-8?B?TDJNRzQ0aFVnRC9KR1hyREJhaStINkVRNmtxZk5UbytmQmsrZ1krNlhTbnNB?=
 =?utf-8?B?TEVnU0xqTnd6VXlMdzY5UFZnSGdaNVhSVjdPK2R2ZU9jWEF6emFkcmx1TGRl?=
 =?utf-8?B?U3hUc2oydHl3ZHlzeDNoYzExQ1pWM1JwSmRrSm80K0hueUl5akxHYSt6Yy9x?=
 =?utf-8?B?YW8yK0xxb1RBeHJveW9jKzhaSzFZbFhHdThMVnlnTEM5SVIzUDBlOHFXQ0w4?=
 =?utf-8?B?bUUzYi8xeWtMUGsrRjAvRGpXblFYcHVhQjQ0T1ZmQkpaMTVyeHZBY1JYeHd6?=
 =?utf-8?B?KzlWZW1tMHp4dkpFMnhPR2xTREt2TndoWHk5cHlYUVkrcFlZdzkzb0xIY2R4?=
 =?utf-8?B?Y3k5TlBLYWJnZVJlQ2EwZUh4MlpoZjJUdS9pc1pORUtod3BJK2ppcThMNWRs?=
 =?utf-8?B?QWFLd2k5TzdsaXNTWitWeGQybXU4VUw4UUdOK0ZtWGcxdTBSc3QwWHJ3VUNy?=
 =?utf-8?B?RTF3VzljSzY5cHlKVFV0emh1bzlNVS90ekZwR2czbFJQU2dNbG5FZUdpZFRM?=
 =?utf-8?B?YVhlcGV4WVZrU0dFSHdIYW5wYjlGbExaRzlPaytRQjFmamVQaU5OS3FBZ3lz?=
 =?utf-8?B?RHZ3QXBXY1BhODRXUDM2N0psMDVzRG1JbkR5VERQZDl2YktuS0xkeEl2aXBo?=
 =?utf-8?B?RmZlSXI2dmZIRHpydXdzTmpOU3IwSnplc0Zhc3lSRWdYbFNySElnb2M5ZTRF?=
 =?utf-8?B?MG1ORGg4RUcwME9tRjk3UG1IbEc1NWpaV2kxNGNmd2k4OC81YnMrT0hTeHhy?=
 =?utf-8?B?SjdicUtFWlpNRElpMlRlM0JhcEx3MDRxZ3NJZ1ZNRjAzZFJZUzBCTkJyUUs4?=
 =?utf-8?B?ekVKdnRVU0I4cUxGbnJMeTZKZE1lTm40SDU4ZU1iVUhselE3L1hWcDV2M1N4?=
 =?utf-8?B?S1gyemdlYXFPMEhSYTA0d2NtUFZQYmk0bDNDa0ZCSXJTVTcwM0JoZDVvNFhi?=
 =?utf-8?B?VENKdnFucjd0WlZOTVdCZmQzZ284azdIN2RZNGFzeEt4Q0UzM0hQNTdlSFJP?=
 =?utf-8?B?ZkhwMk9ZVldEM29PZEcyNEpCdUR1V1pNVzlkTSsrNFBsU1RicW5tMm9UWDND?=
 =?utf-8?B?UGlDZkJYNS9rODRVUHZXUUdiT1VsbmI0ZVVLdjZ4azNhYm9YaERxL0pkNkdp?=
 =?utf-8?B?RUcyeVp1RWVTSTV1Yy9iaDZzeWpoOW12bklFQlZ6Wi8xMnVwd0dzYmhuc09F?=
 =?utf-8?B?OUxSV09EWlZJRUhzdHdDUTJqZFo0YnNqdGo2TVR3WE1yNlVYaytnRk11V043?=
 =?utf-8?B?UTBhMmpUNnlpK21uVkRLY3Y3a2tqK3R2RFlYYUIyQytET29jRUZkNnRIY3gv?=
 =?utf-8?B?bUtXSFFhLzRTbW1GQkkrbXZFQ1lIcE11YnBFYVV6c1hZYVA3Uk82NlZBcThC?=
 =?utf-8?B?bXFibTZ6cmxQK3AwTDBEUms0TWxGdkhBZzhqaDF4andMV3hJZmQ2bzBSZFVt?=
 =?utf-8?Q?OEwmjRjEpXbQlirpTQX2CEt2Ba2GWENEEPBqd8K9S8xy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3684A88F52C2FA4AB494DFAF52C4E76C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2af33-954e-4596-a4ca-08dc32b5611e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:16:17.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWBTRS0PCkzriN02UMzFKE3k6Rn+LX3lUYmwV8iPn6C9umEonL0rhJyzHu/7nRORe+069lJhBylzh99LaoHjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_001630_297903_FFE027DA 
X-CRM114-Status: UNSURE (   9.91  )
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

T24gMi8yMC8yNCAyMzo0MywgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIHRlc3QgaXMgaXNz
dWluZyBsYXJnZXIgSU8gd29ya2xvYWQuIFRoaXMgZGVwZW5kcyBvbiBiZWluZyBhYmxlIHRvDQo+
IGFsbG9jYXRlIGxhcmdlciBjaHVua3Mgb2YgbGluZWFyIG1lbW9yeS4gbnZtZS1jbGkgdXNlZCB0
byB1c2UgbGliaHVnZXRsYg0KPiB0byBhdXRvbWF0aWNhbGx5IGFsbG9jYXRlIHRoZSBIdWdlVExC
IHBvb2wuIFRob3VnaCBudm1lLWNsaSBkcm9wcGVkIHRoZQ0KPiBkZXBlbmRlbmN5IG9uIHRoZSBs
aWJyYXJ5LCB0aHVzIHRoZSB0ZXN0IHNob3VsZCB0cnkgdG8gcHJvdmlzaW9uIHRoZQ0KPiBzeXN0
ZW0gYWNjb3JkaW5nbHkuDQo+DQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1udm1l
L252bWUtY2xpL2lzc3Vlcy8yMjE4DQo+IFJlcG9ydGVkLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdA
cmVkaGF0LmNvbT4NCj4gVGVzdGVkLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0N
Cj4gICANCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

