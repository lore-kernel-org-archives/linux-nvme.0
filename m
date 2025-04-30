Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A4C369DC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 00:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sMrvYAZdNOgTFSqosOABJBtEKR8gdMiaVnPNAwJPJto=; b=oSQMQvgizGb2SJdo2vjdUUakDJ
	kBxrdBQMISwsOMSGs3MSELhJKfkMKISW3udA/HKXG0TLyuD8unEXcFQVjwl5BKdL+4RxhIE5X5IkB
	0x4KS/nAqB6k3iVM1KO7D3TbTvo7TvMYCIFPtFo5iQ5Ut8Ad/OBrLOQ5BCYTAW9xbqfvX0KX/s+wD
	dDT3n+3waqaOXMD54in5/VjtLv03XL42qzTQcsUcBulXQ2fUY77K4bgwDLE5OtYFmXq/kbBYyq9Lq
	RhL7DRaLC7gBqxlOsqXrYJa9D0KibJErMNW4gN9yi4EE1QN/AXUg03r3TiN5CazSdkdzbd3j/fgaR
	DUDvGrQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vaL-0000000BMv5-1Bww;
	Wed, 30 Apr 2025 00:46:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vaK-0000000BMul-2DQH
	for linux-nvme@bombadil.infradead.org;
	Wed, 30 Apr 2025 00:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=sMrvYAZdNOgTFSqosOABJBtEKR8gdMiaVnPNAwJPJto=; b=WkNG3t17OJxDR68TiyYEa749IV
	vIOWVJq7IXJ+9IS0NHvGuw92dyf6H85zNsAdTbj6ywGCMH6l2tfV98RSxtNhwelr4iWsHCRp+XzJx
	40MJl0PriWbLNMPA6gupZyQUdL2UYLxlusYdoBQHXZ6UFTLO9SVT5MZRZP75l7Na43kXTClj13ocU
	ew6QoXWFFA4KGXpQd5OXEuEkp/F3F3R236IjTWFz4+pyT5sZrm47rPbbigsguY0+h5+6D/Ap/CvwL
	dVfurQKVM3It6xmr2JzPjvGwZY90EmuspOQYt5+UIPpI3WXKR8HOLKSNiyp4WIU9P2hhhShgxRKYZ
	Yr+Mfogw==;
Received: from mail-bn8nam12on2060a.outbound.protection.outlook.com ([2a01:111:f403:2418::60a] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9vaH-0000000DbBg-0OIh
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 00:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyeXC+CtFK7ltLZs254Ed3Dak05UEI9R9zHyNZFCCiB3wScqcEDdZ3RYd1XCezXpGecFPj8qZte0dwsjBYIz0qB8W9vOvXznYQ4W7iY95RdWVjxie/BL9NF4vSO6NelAto8FePtg9GyIvpnLc1/PVQDzFJUR+hwcpfCEcoc5mc50x9lE8KWqGx8+8vHR7HFzqgpp/i5VMZ8tnGRAaa2T/+DZait4lwekpPpcrQDDCst54k4Ggeu2LDUjZAGQrNpoTxPo2XKua7vWjpiFsmfdgQeUq3+8UHXfIa6Tk6ZXs6qRIfLO8WvxAAb2VQbmbiC+7qXY8zZAyiZ1d2LdpAm43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMrvYAZdNOgTFSqosOABJBtEKR8gdMiaVnPNAwJPJto=;
 b=HFrbtCzZFtdo/8ywwjtJHtE82uCDCNcHEqWJiafcwrDlVnH0YwzDWsSRBEWS+4ciV7d7Zg8+bTTYzMOqIZ933mXlUIydPoc6DfRt7BHip9txttkXL3SL+WShOLLj7l5fxCnUampZIAg6JKP9zgpDb98K+xDedD/I1v1cb4RebYoGoBvj5fGfiwKLMJne5jB7exGLhsNgZTLIvOWOpYmOuDA1VDnZm6AaTzcRoWIlkfpKupFzWpzRCYCCGWMXCI2VNOfDS50qcIfEU5g/lL+A67qFz4V3odGbuGFIetnUcvxI2Z58Kn2/MaYYb4UeBXXj3CXBdRwylzxwhyhWGbtOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMrvYAZdNOgTFSqosOABJBtEKR8gdMiaVnPNAwJPJto=;
 b=iyrtAQ1GFMLa2bFfJbkksB8Ifxo7bRNF15VjlbXIKpJ9BVxgiMwrh2HUgll7aaIDtrWmieiGFZ9AGzm+GUO+m5FL0MAEklUTcQsM7htLwuA+ylf9MnXaO692Dci4+tdgCQgMS0/ajRWhRpxw4GVhKJL+Lyj7gjOw/d0FKx4fSB2nuO0ntDXTAHWvasM4WIUWL4wixzvk8M4gAbfiz3FUhDjB5O2P6PSL8PODlXV8vkNJpKSdTTNKIeUjLG52Z6bAYUf2Q7zbtNAK2Gmg8Za4sZuS+ckBntDIeiUoW1AX5nt9wJvHY/PWx5ZIUWdhopfap238QeEbOlDGjf+BA/GvkA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 00:45:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 00:45:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: select tls config when tcp tls is enabled
Thread-Topic: [PATCH] nvme: select tls config when tcp tls is enabled
Thread-Index: AQHbuVfKhw3G85ZUT0am74OLLcLKLbO7X74A
Date: Wed, 30 Apr 2025 00:45:48 +0000
Message-ID: <c3d064b8-4901-47e5-a686-a17d56c05314@nvidia.com>
References: <20250429224025.3077488-1-alistair.francis@wdc.com>
In-Reply-To: <20250429224025.3077488-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8706:EE_
x-ms-office365-filtering-correlation-id: 9db1a2bc-95f6-4eb1-e4ec-08dd87805997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MnEzT1BmTkNpK2RqWEVzelM1UXFYV2RMc3BUZ0VweXB3K210dzdSS0U4R2pq?=
 =?utf-8?B?Y0xvdnFYNzJheVhlL0lOZVEvQi94YlZyUjV5U0hwNDJyV1drdjRWZU1aeWU1?=
 =?utf-8?B?SjY0cVV1SGhRQ3hpRytVL3lHN1JhYnZCalFoVXVmWkdQZFhNbkR5aVhCSEky?=
 =?utf-8?B?Q05YSUFCdVA4c0tkcG1udU5EYlJXV1NyaDdlT3I3OHpJUDFXT3N2Nk1Tb2Zv?=
 =?utf-8?B?UWJQZmJpMXpsYmV6SWlOalBxSWJncU9HTzhuVGVEaGhQWU5qN01aVm4wWFhS?=
 =?utf-8?B?S2J6SUQ3NUlmTVo4V2pXM3NzaGlFb0FMc3NJRUgrblN1OGxNN05TQXNOSzg4?=
 =?utf-8?B?eXYwT0oxbjNnVC9YVkZ4WUtGQmF6SGFtcVZoMHBwZkJuUithSlptTlpVV2VT?=
 =?utf-8?B?QmhQdU4zYVdnTnRnWm54SVpUU1JsTnNwZGY0QWl4ODNxbVMzNFUySkxWY3g5?=
 =?utf-8?B?bXNiMi9iMHNwVVA4Skdza3JKbWExVHBXdzAzODVFcXB5blFKY2ViL1R2TzNP?=
 =?utf-8?B?a3lUOGNRaFpuQXFMT2ZIM0dLTnRSbjJrNE5iYXpPa0tuWU9wM1NHR2cyNWNX?=
 =?utf-8?B?ZGkxdjVKS3JGblI4VXQzN2pMaGJqaFJZd3hsMXR3ZFFwQ01JNERHOGg4blhR?=
 =?utf-8?B?T1BsTk12OTZYQThpMkRKdHk5b0V2YWJTOE5jMUVuNkcwbEZ4cVhIVG9tWnoy?=
 =?utf-8?B?YmdCeDRlQ0I5WUs4dStuZXFxNmluSFpSZGdpWmNadWpvcjUxWnY1SmpiZCtS?=
 =?utf-8?B?T1Q4UWNjRVhUdTA5bm5kM0F5WG9QZG1Db1Y2N0xaQ0tKVmphV1hlRm80dEVS?=
 =?utf-8?B?WGttRmIwQzljYTUycjVYamdOaG9MVk1MTjdsTzVEazNEYzg3Y0xxQldnV1o3?=
 =?utf-8?B?TUZ1T1Uxa3RMNkh4dkJLM3JBaEt2VHQzdGY5OElmaXlGNVFuWVNYVVNMRThw?=
 =?utf-8?B?STRGT2xNTzBlRU5GL0NZcnl0SENQeGx5UmV3T0Z1NXg3VVBqYzRlK2ZtYVow?=
 =?utf-8?B?ajJuTmNDWUhkS0QxVXhBNzVCUmFvbVdzVy9PR1JnQXdQUXRFMUo4eSs3eC9l?=
 =?utf-8?B?aXJqSVBNYUc5YllnZ2lXczFPVDRmcW1BZGxHaFExOEZwKzhqQmtsS1BtSzRJ?=
 =?utf-8?B?R0dNak1hU2dKVW4vT2RJaitUZ0t0WndDcnFXYkg2V0pwMnM0ck9WSFhocUNn?=
 =?utf-8?B?UjgwOTJRM3VteDMzQWYyY1loTnpKZUFjaVFQZ3NmZ0k1Ny9Iby9oZXFSTGpZ?=
 =?utf-8?B?YStDbG5PU011dGlwNXBCOGRxalZrdHFiMmthOUZsMmVTbmFVeWQ5K1NsVWFo?=
 =?utf-8?B?a2dWa2ZMNys2OVBCdUY0SkNtMStsK2FvYjg1NWY2YnAxRzNIVzVzNHBPclFI?=
 =?utf-8?B?ZFN1RUdtZ2V0c2VMN2pQR25UQ1VYZGJUZFNUYnpsYUNUbjVqV25UanJzd2Yx?=
 =?utf-8?B?S0ltY09jcGphMUU1cmFPVnJHWmFBNURKWFFyTDRPcy95Q3VqKzdTdVFsWEg1?=
 =?utf-8?B?WlFDL0lWRXk1eFBldE8ydUVRWXRiVHZzK2tldEJudDY3YUlFVHRTSlFkUWRJ?=
 =?utf-8?B?UkNpa1phWTBLNFowWFZEK3plYzB2SmdFL0xlREhIbjE5MWNSRjhTRkJrTUlF?=
 =?utf-8?B?OGFXNGFxTGE1alNvNWhsZWhDc3hJTCtRekFQcjUyeFRpbExCQm90ZmRaRmU3?=
 =?utf-8?B?WE9veGxDd0NieWdQTzJEcllQb1hGdVlmSFpnSTgvSUdQK3BCb2pVaVl4cDhj?=
 =?utf-8?B?VjZiUDhJQWMzUEI1ZFJBR3A0S1BxQ3NsRlp3OHo3elgrb1Z0eXZYclVuU2dn?=
 =?utf-8?B?VzRzNWRRWVZ0VVRLT2NtYkxxR2dvNUlQeG5Ma293eDU0WERjR2UwZ2J2VGhY?=
 =?utf-8?B?RHVvS2poOGZ5aEUyWCtkclpRY3B0djdPNTEvdlhUdU5WOEVHUFIyRW94R0gy?=
 =?utf-8?B?SE9mTFF4Ymc5NG9ZTWNaKzJGaFFWZXZ1S00zUTRIbzlLQS9TQjVYLy9jSVZ6?=
 =?utf-8?B?eUt2ci9yKzNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkpXSVA3LzRkbGllcGx3WE9UbGwxaGFYcVhndHFjRC9FZ0hIQm41aVc1Q1pR?=
 =?utf-8?B?S1Y3L2VrZ2FoZ3FoUkVrczBoQU14SG1WZHY5aEtlOGYvZnROSFdINGdRZFly?=
 =?utf-8?B?L0J3YTQ4eVhaZ0gzYVR5THF5K3JhRkZ5MXlDemVZZFJHbzJXV21VeUpnK29Y?=
 =?utf-8?B?Rk9DRUMyZVdBZWd6dVAxa3EzenNDc0hJODNiWlNucWdRWjgwNnhkMGFwTDdt?=
 =?utf-8?B?RGZVTE82ejQ0NllBUjFkd1VFckNKdmtWUDd0dy8wcFkydFFtc21ZbDI5T1cy?=
 =?utf-8?B?WGR1Z3dsZFh4UDlaNmQwdllsWjFFcTRUcUcvQytxTDQzclhrRGlxbmduODUx?=
 =?utf-8?B?MDFzZ2dJaVkraWFoVlFhUE5uZTN6WVhHMXJacnFSb0pLeC9RK1k1eTd5UGow?=
 =?utf-8?B?SDNyamdsK1p6S0xmY1FoNVhjd1lOOExMazNsdHZOWDFuSjlPUmkyZW5wWjlD?=
 =?utf-8?B?ZjlpRHhMRkt0ZmsrSGdGOCtCV05nNDVaTk1HSWllbjhFUmQxcER6TExHaDlU?=
 =?utf-8?B?SzRjUTRwNDNNRXpsYlNOaW1QYTByOUhjRHBzOGovaEMyaUxxTGV0T2VhVVdi?=
 =?utf-8?B?Tk1Ob1l1SklsN3RzOEQwME01bXY5MkxIaWlTUG9kSUo1QzJyS0I1T0hEUGJ4?=
 =?utf-8?B?azY2MHplTzVMbjRza2Z2SGdGbkcyYjV5N0gwaHQwbjAwMVpJOEROcmZ6Y1Jv?=
 =?utf-8?B?TXdyM2xHWGpEeGZxZUdYb3FtV25KdEF0aGdFckJvVFZrVFZxVDBtYjRSMmJr?=
 =?utf-8?B?L0I2VHk3ZzBxN0d0bGhUMkMxNHBVaC94Skk3cmlNVmU2bTNsSXRpbTQ0R240?=
 =?utf-8?B?eE56aU9Ba1FnVXR0Vzl0U09rd3FIU3N3Y0x0dnBhdXp4ekd6aDViTHNNQW9J?=
 =?utf-8?B?YlgxbnZFU056RFdCUFJZNnBhdWVoZENCSnEyTXBreTA5WkhCQ2tkUmhqMVAw?=
 =?utf-8?B?Y1BmU3RyNnBiOTVTaCtJOWVPU2ppT3ErTm5renlLY0tkcmt2NFdHM2M4WG40?=
 =?utf-8?B?Mm9PNDZNWDd1bDN5QklJajNxNTJ5cVRtTytxMGgwejBNK2VRdDY1dDhFWXh2?=
 =?utf-8?B?TVBJN0dTbEhMY0w2dmlzMEcwRVRGYS82UTV5Tm1vR0ZrZU9WaURqWDV3TUwz?=
 =?utf-8?B?ZDcvZ2Y0MEpKZDRZK1JmUExLcE1zUFBITTMwWEY3TVFvUjlTSXErbEFNQ1Rx?=
 =?utf-8?B?bWV5eUE1TzRLK2E2M0duZXkvQzNGWHR4Z09leGNEcVNqWWtRQUxuV2t1QVd1?=
 =?utf-8?B?aUs4NWUrTGQxMHpkVnJIU2tJWlVyeUxwN3JNYWcrKzg2TW95UkE1WC9FanA3?=
 =?utf-8?B?MHRLUi9XVkhLTitBQ1hyblM2VWY0eUt0U0tielVhVzFvSUFWUkRLdTZmS3Jm?=
 =?utf-8?B?cGNzUzQwQld2djh5TTAwTFRYRm5JZDJLbHltUHY0S2I2dS9EL3NqbzlnZ1ZH?=
 =?utf-8?B?ejd2K21XeXAwT2J0VHZaOS8wcVdWUWRnRFpET3RSbWhUbWwwUDhUdWVVTlho?=
 =?utf-8?B?K2htWTgxbjJVRVZLTzAyZElQWHNIY0tkN0NHbk5JL0xaM1EzWXc1VjY4blNU?=
 =?utf-8?B?aGhhZE5oelV4aEZVc3dHTEwxWk1mQ24vV1gyVlN0YWl5d2x2RjNiRWpuNUhP?=
 =?utf-8?B?b3hZTi9pYXJxNldIYytzWUNJYUxjWS9KR0R3eTU0aUZ1VzdQVVBPZm9RczNB?=
 =?utf-8?B?a0xQUlhxU3ZlUkt2UzdSOVdyUjNCRGhUSnR0ZEU5cGd1dXIxalkrYnc1WU1Q?=
 =?utf-8?B?YWZ1eG5PS1pML2JPT1pmV093dlNoVXFXZFNaK3VncVgyRFh3bG9VTm0vVzdI?=
 =?utf-8?B?TEx0cVROTGM0U3Y5OU1iWEhrNHhWZHBmazVVSDRDUmE5V3V6VFVaRkVnWjFW?=
 =?utf-8?B?eFVrWitXMEtySHpqUlFLbjVZM2JsRHVzMG5lblJLVzhOQTBPRXl1aXQ1cSt5?=
 =?utf-8?B?VDRpQmYyQUlTT2F3a3Q4N1BCdHdJVTRxdTdnd3hZYlpqOGlTSmV0bE9mQjhK?=
 =?utf-8?B?R2FNY2VWZlZjSDJiN1JMNVlTU3JMYVMxRm9zUW51cWJONFczY1FDbWlBRmhi?=
 =?utf-8?B?eFV1MHpQV1RJMWs0Q25jcVJqOVJVaElHMzR6TllsRE5iRWJ6NTJPUHBiYml0?=
 =?utf-8?B?LzFMUmJ2ZjVxamJoNjdIelpndTBrYVBaMXFKT1RjWkVYeUY5Y2RobUhUak8v?=
 =?utf-8?Q?dPLbdy/DQSQQjXmkxVCww9ZzHaWpMTYzDg+UtTM2OC2V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A56C20FDAF8268479F2592ED7588E896@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db1a2bc-95f6-4eb1-e4ec-08dd87805997
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 00:45:48.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mZ5ETlIj24VfJeJ/RTUIQJ/ztr4M8+Pm/makeW3/yzYsIt+0JkovCCGa/a000wJ/P0XMzFAp/yLFamhorLAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_014557_217664_91E32639 
X-CRM114-Status: GOOD (  10.05  )
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

T24gNC8yOS8yNSAxNTo0MCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gRW5zdXJlIHRoYXQg
VExTIHN1cHBvcnQgaXMgZW5hYmxlZCBpbiB0aGUga2VybmVsIHdoZW4NCj4gTlZNRV9UQ1BfVExT
UyBpcyBlbmFibGVkLiBUaGlzIGFsbG93cyBUTFMgc2VjdXJlIGNoYW5uZWxzIHRvIGJlDQo+IHVz
ZWQgb3V0IG9mIHRoZSBib3guDQo+DQo+IEZpeGVzOiBiZThlODJjYWE2OCAoIm52bWUtdGNwOiBl
bmFibGUgVExTIGhhbmRzaGFrZSB1cGNhbGwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBG
cmFuY2lzPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KdG8ga2VlcCBpdCBlYXN5IG9uIHRo
ZSBnaXQgbG9nIGJldHRlciB3ZSBzaG91bGQgbWVyZ2UgdGhpcyBuZXh0IHRvDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=

