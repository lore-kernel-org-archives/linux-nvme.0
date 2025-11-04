Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B983BCCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 04:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLAESb5UXBpSuw9TmBfRqvOpc3yg+cTyxLniINlmOwE=; b=KZ/rLTJJS9eWcq/6na6O4kpO9d
	4irswu3UXcNiGg59zSSn7Osfe+/99PoI8C1Zb1v1bhmfpvFy0N0rlI1U1aeELKJwVcBsErwB2fXC9
	eSajhzpfD8A1NlscD1xjS4rBgXDunX7+CKvidUCXTG6ZnqNIOVjHY6FF/cXScz9J6Vi2Gkd+MNRBK
	kqA84sakuPBxbJjT2snXyN0ddR1pdgmQhur0SCUWv/LUTZ4v7NrxnBhHvPLwUEJe+oOt96GriUlPS
	rvc18/DVbW8PF3Ux4LWzHRk+ypKxbCqAPF5jIedF2HYbBKtXVMNNKS61skhS1wCqc9EeqGY9UCguu
	P76aUHnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG8M8-0000000B7D9-09mz;
	Tue, 04 Nov 2025 04:09:16 +0000
Received: from mail-westus2azon11012066.outbound.protection.outlook.com ([52.101.48.66] helo=MW6PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG8M5-0000000B7CF-2Xrz
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 04:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxJwSxVPPdNV3bEzI4CTG/VwtPbVGSzzxwOWJ2kvNVCNXdDlrMe1QWQ+gM/9OkcD30fV2+BJK8UkxZABIH/MkifyVnZ5RtxGv0b46E/lW8Q6qUex5UUVFimrsLJI8rCnOqgsMWXFVe5hKD5SuQ4SDOWC9vw0qBpC68OWuoUMuJSovM0GX7nzNEgy4/bg4RwxVmTwXdEJZk5KOjv7xmRMLrjEhoLTFyiS0s39tNFcvE4F0rMJvH8ZRis7AmqthBQmZlnbaojRSygodcy6muV0X3jb6WFt2Es2FI3xe4y2lY/5BpqQ6K4ZFuS9tM1/Ouyr7CY8HA7fdLz9rcxhSoSWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLAESb5UXBpSuw9TmBfRqvOpc3yg+cTyxLniINlmOwE=;
 b=Q3nWQ9HtxfvDgtebEDaTKWPt6cosQTODPnkN/EzloBdrTtuSALKspywJK73wKXqFdbO8nCOcJhVWpQujxWke/NzbfpVTjjYXUzAgEKyydGybJaJL0eIyK/h2wM9nPyveq0k2Z8Mh9jcO64Nlstqy96pSqDM2QptTYGL/bEGUMnF6FHJPFWuEGKHTQqzVS4SH3K6UWPjmct7lmpjibEqkytgNTvU1IuHmubGmKHiPIyj+v7hHMZqor30g+RgWDjB8SD/YiOj/mO9XUvzHifm2Yx7WV1N0aUNxjPfj9a/5FEkPR1B1L3Cp+vpLWcrHMaXLWVPFimYdUEsuuu7gMJc0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLAESb5UXBpSuw9TmBfRqvOpc3yg+cTyxLniINlmOwE=;
 b=UgK6bz2D4QVHGlZ3igDjW30/JHLfEXMAb7bsc0P9Bc628RoYxyoXOifvncdI+ltedcM/RLxWq6CJvlY0ABZ812c3C9V1FY08X8n3PVa8dBHCWi/cSiQifNLRBw5taNBlgxPPsm+Dumi0BUyVZbeYhO6anEooHFNsvsKzict6/KMOFd6tsaY5aNga6lu31wi0FCuBo9KGH4LWDcNJY1S2Z2YXjouhBiYos8AM32is/7XHN+N0WYi6aTY7PG7hqvCNQCMeKiB0dI9NSU8sdfbWja8djeHfKHK3z6M/9b7QUsDn6Lua7z+LCIwjZaNiVWHg3vA+73aA/4ESXu0Oq/pNhw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:09:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:09:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 08/15] block: refactor blkdev_report_zones() code
Thread-Topic: [PATCH v3 08/15] block: refactor blkdev_report_zones() code
Thread-Index: AQHcTStro618+PxTKkiuZYSuTg07SbTh5zEA
Date: Tue, 4 Nov 2025 04:09:08 +0000
Message-ID: <b8c53ac8-1ad2-4ca2-821d-6fbd6f212bb7@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-9-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-9-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: 7d4b2155-75a0-49ca-a441-08de1b57e725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?eCtjZHFOc241K0pDMVlSakttNHJ3aUp5cVRqZ2dYNVlQNzF6VEFlNjRqMTN6?=
 =?utf-8?B?UHNVOCt2SmxyeWpBZlBFWGhUN01lRW9SOFhPV2l0bWpJcFpIY2Jmc01Ea1cz?=
 =?utf-8?B?TzArNGdMbWd3YmpXQVVCSWZOd251c3pxRitmRUpxRmRYRVkxS1F6ZHZ3UVdJ?=
 =?utf-8?B?SXhhNXNYOC9DdlRnVlI4ZTN6YzVpQ2NNenJCNDRWalBRZXRIQUp5aVlUUkp5?=
 =?utf-8?B?RE1tc0p2RzhleW5FcjhNSVZNRG9Xb0dLQmk5M3VNQWtnbU1hL3NDTDloSUU4?=
 =?utf-8?B?NVpQWWNaQXpFMFV3Yzc2Q3pJREZRV1NpNG5ZYm1wVExRZkFjVCtVMFBtT1Z2?=
 =?utf-8?B?VjVEWlNGK09Dcm1CVWFqYVdCUjlOMWIvUXFrOGlTdXZQZ1RwK0t1dlJ4M0pI?=
 =?utf-8?B?SU12dmU1REN0dkwxNWpxL2JjUnl6SkUySklJS2pDMnd3eTJiUHkyNllnK0J6?=
 =?utf-8?B?d1Z4TG1WNytwcE8vd3dCVk4yajJIckRsM2Q5NE1MM2VLY2ZWYWJHNXlwNnVt?=
 =?utf-8?B?SGFta0l2dlozQ016MTlNbDU1SEVQYnA0bFF0YUloZzV6enR3bFJPc2tCUjA2?=
 =?utf-8?B?QURrYXhZT0xsRVVXWjN5akxBOEM0bkxRSXJ3S0xxT3hzaDhRQWMveWtxU1lO?=
 =?utf-8?B?R01GQzZXZ1krYkxRZnI4U2d4RklPM0N4empGM25SL0JaaXdkZ2lQZldaVEdw?=
 =?utf-8?B?ZmU2UW1ONlJSeWsvN2U2K0I1ekQ2REdBOXJHa2l5R09pT3Iyc2FsNXJkSGtX?=
 =?utf-8?B?SjY0bGdkYWh4NUF1NFIvdlRkOGNGTXBaSzQyQWxWS1dwS2oybm82UG1pb3A5?=
 =?utf-8?B?c0hEWXM2UzBPMjlKTUpJeDFFWG1Ccm1sKzE1RXdMY1h2d1lGWkFhWnN6bWU3?=
 =?utf-8?B?UlpNYW45NDFWdCs0NE5hVW1aclVYaVB1SkNCMCtGS2RsRUk1emZGandvMldQ?=
 =?utf-8?B?MzlkWXhqSUphNVgxV0MyS2J1RktCVTZOVHR4MGxldVM0bDE4dHJxaUVyV1NB?=
 =?utf-8?B?RnJIU241VEVyZXJnSTRRdWdHbWt4R2c3cnhzY2dsTCtibUUyUVFlZVdydm1E?=
 =?utf-8?B?Q0d2MG9wZjltK3lXL0YyMTZuVjFySjlvU1pwRFZJUUJKMU9UQTFjNTdoaHpN?=
 =?utf-8?B?LzJtdGpuSnBUaHRmVy93YTMyQzNEaTBUL1VVN3NuSjhJTzVKSTlkcU1DMzhh?=
 =?utf-8?B?V2cxWWtXS3RJMWhxRU9EUEp3aTR0cFVMbDBLMjRaUG9UdzBxM2pNVGYvdUhy?=
 =?utf-8?B?ZXNjSlVWeDhqRC93UjJzeHZKNWdBUmd5dXlMc25Nd2tCZ2JIRGtsa0h2UHIv?=
 =?utf-8?B?Z2Q3T1Z2TjJZQzdMaDBLVXZBT0prK1dxVlNITTlTZWhIMkI1WGp1TzZLWFR3?=
 =?utf-8?B?aGxRSGtxVlUwV2R4RU9kYzAzV044WDgxZFlyOVJ3K0VGS3BxWUIvd2ZnRmNV?=
 =?utf-8?B?ZS9rNEphVUlRTXhkbkZhTHVZYU9FK3A1Y1dHaWxQUnpVOTJnakJ2QXEzRmhk?=
 =?utf-8?B?Q0RCa1pGZjZJSVBxaVRVdHNyT1hiYnhlME5ieThiSm4rWExUMnIxWVJZMUli?=
 =?utf-8?B?bEZ6WGpWZlVaQkNxbGhReS8zY2hOQzUvQ0I4c05yMm5XL21rN2cvN1cxaUp3?=
 =?utf-8?B?SWZqUjNNOXJUbzJxSW1SMVZ5d0NKZHBPbXhKWUFPV2VrN3dQVENUY0F4bGhS?=
 =?utf-8?B?Wllkc01vZ2h5anVKNGptTkZnb1lnSHZxYTdLanBxZzZoM2I3UFY0WDY2UXZ0?=
 =?utf-8?B?VnZtN2x5TENPbkQ2ZFpJUnFYYmNsYStwQ3dySnlJTHdqZTVoVW54eE9ScHpr?=
 =?utf-8?B?bVduVzRXOWRkSDdSOW0xYUhZc3lPQVRXV0F3M01TY09lNUpqRFBieXdPVkNT?=
 =?utf-8?B?NHJYNzJnUFJER01TcUNjbWFXQTJQSi9wWmpjeEZKZWQvQm1kT1VsdzhpeUJJ?=
 =?utf-8?B?VzROaVlvZGQxWGp3SDBGbDJDM3hQRXZraWc2T3FkYitvR2RUYUxGcDV4SFdU?=
 =?utf-8?B?bGZ1aU5mY01yYmRuOC8yKy9wMkhQL0lBY2l6TkhJWm1sV0VSSzU4TWtkUnVS?=
 =?utf-8?B?b010TG9CUlZHdVd0QjkrK084STBTQk5jTi9yUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWswcjJ0UDI2bkVKUWk3TjV3dEdnWjNBMzhObUx2RGg4Q3FXVDlVMUdYZWI5?=
 =?utf-8?B?dGdhL0ZyeWdTS2FGaVgyN3FOVlhJUjFMK2RnK0Q4V1F2R2p6NmM5cVNlanp5?=
 =?utf-8?B?Zk02TGY5RHNjUGVxSnkrVEg0dm1BZTM2Qk52STM5RmtVWXA5c1QwZy93V1NF?=
 =?utf-8?B?Z1VoU1h6VmxSV0dBNnhGWSs1NmFFb0FDWUZ6ZUlvanp4RXpqU2RwajFLYTZj?=
 =?utf-8?B?NXc0MGVzMUo4VnM1b2YyVTdQcDF1ZHRocTFOUmI4MUpqc3dFanA0VDU4NUpx?=
 =?utf-8?B?VDgwSEovcnAyYzBnODBmOGM4K2xMSmJ5K0ZTdHI0NzRFdWRWWDk5WmlLUEdm?=
 =?utf-8?B?UjZoVzg0bUE4N0lab3pJZ2VZdktySDQwTmQyRnFTeTRxeFB5NW1WV084S1pm?=
 =?utf-8?B?ODlKUGRCNnhhUlM3Sy81a1RUTHAvNzN0Y2RNSGZjREhiQ2M4L05JRDM2QVFz?=
 =?utf-8?B?V2diMTNwMHdVZ1NwWmRGaWNwWGRrcTV3K0RIS2FhTE5qd0hVeStuZEE5Z0JN?=
 =?utf-8?B?RkJEYVZzNVNZQ29tVVNYOFp0RlY0MmZtclFQZmprbUgyaCtjZCttaFlsT21I?=
 =?utf-8?B?OSt5OEJXVWRCMGJFU2JIUlp4UndoUU1RUE5DVkdwaVVlbUhnR2dUL3ZSZjZE?=
 =?utf-8?B?dnlBUjYwZEFaNy9iR2UzcHNwVWwxOGNtcnN3ZlhDNE12eTlkVnN4QWxGaTZ1?=
 =?utf-8?B?cDMzeHBhZDdVbk95MGVmS2dML0hJYktQWTBjaTY4M2lnYlk3MjFRWWZRTVNS?=
 =?utf-8?B?K2NYYmIyUGl3RDAxcHZTZGloYTUwU2tQWDZTdEFxVGxqMWNtL0xObGRLTVRQ?=
 =?utf-8?B?WlJJNVpNSmZqS3BnRUxhM2IxK3VMZFZVb28za2pOblQ1aElSdWJtWWJ1TzMy?=
 =?utf-8?B?NG0vQzNSZ2oveDJhem85VWtGenlicm1FNFlSTEM2VGkyZ3A4dmgzd0tYQ2w2?=
 =?utf-8?B?ZWVsN1RpVVRienlOV0d2TWN2YW80Yk04SjV2SkowMHRnc1lsWG42eGxrcXZY?=
 =?utf-8?B?R1hrOTQ3OU9qcS95N3l4Qjl5WjRQK2FybWtVamlQMTc1dnJoYXRpclBTck9F?=
 =?utf-8?B?cGdxVGN6Z2t6T3NFeFRWVU1UTlJaaFlBS0VFeldyL25DclRPalZHT1hOc1V1?=
 =?utf-8?B?Ujk3eEgvZ1hQTE02aXBKWVF4YTRzMGtjMnJJT0M1QTJSYkdGRm5CVXNJTURZ?=
 =?utf-8?B?RUdXRnptNjhPSGxQWEVKZlRzR0hXS3MvWE14cTZQMzVjS0lQYkNaVTJPaTQ3?=
 =?utf-8?B?NGxQZ1hINFRMNXlCSXFmUEJ3YW9EUHlubUdGU2psQXJTdU0wS2dlZmszQTFG?=
 =?utf-8?B?VFJoYS91cUl4eFhleWtvN25jYjdUYytYejJuSkRqaSs1OUNZNm9aek1ZRlV4?=
 =?utf-8?B?bHB1c083USsrUnQ4STVLaWk2QzRQTW9Ga2E2UnUwbk1xMmlkcHFMcFFrbVhj?=
 =?utf-8?B?L0VyVVJ2OTBHNWpITUpkeEtIYUJXdUxXdDgwSHFhN2VGa080a3NnaUFpK01W?=
 =?utf-8?B?MW5pK0d3ZEpUZnV5ditKbDdNT0IzMTJuSlNDWUMweElCTUNaYXdMNGtqRFZH?=
 =?utf-8?B?VUlHb0JiRFNPcnFkQjRua0VYMWFydFRMSEQwVytWa05Ic3UxTmR6TG9rcmQ1?=
 =?utf-8?B?N3JxeVVFVmRzOGpJeGtKT1M4MC93NzFiMW16WmV2VDV3Y0wyWTF1NlJpY1dk?=
 =?utf-8?B?YU9oSFNTTW9KeFpLdWFPTThpMjRpTHRTbzJpTkJIQ2RTbmkvY2s0eXNFSjhs?=
 =?utf-8?B?QVg5b2hSUXVvK0RPRXF5dERvd1RvRjFMd2ZaQlhxVW93dThZbis5VFV3SkY3?=
 =?utf-8?B?QThiYjlEWUJDYmVrUjk0WDZ3NVY2ZTNSMFdYVzVEOHcrdGRLeFRETnFVWkg4?=
 =?utf-8?B?R2FHRlhvTFhzeWttVjB5YlRTemRwZWgwWlJkeFg5b2ZVcE9ydEVjcEFCNWJx?=
 =?utf-8?B?ZXQ2bXB4UEdubGlGQjBGVmsrRldUdTBmSnN4eExCZCsreDdVczE1ejE3WWMx?=
 =?utf-8?B?TS9zNzdBY1lpcy9NYUgySFlwcXhDbjZKcXN0Ui9nc2p3Qm0rYWtTS08wenh0?=
 =?utf-8?B?TGFOem5YWE9rbVF5N2Y2UXBYRE94MzJNM0VJVDJRNUdzUWI4ejJZZmZhYmhQ?=
 =?utf-8?B?TXFvd1QwSW9DNDR2eHBjamhTVitRczVSd2Y2Y3cwaVlFK2puZERnb2VZRWgv?=
 =?utf-8?Q?vYpIMMDRiCalJCRkkdN+OUnM4gtj7MczmMH+kzDiEslp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DAE03B308B2284B8FACA3823C14885B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4b2155-75a0-49ca-a441-08de1b57e725
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:09:08.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mShrA1i6VlbUxCyBeJiAaGq7pTBsX8hKkUt7G8kSOvk6ISB9iOgOt5N5GrIcm4K6/e9665WFjGctJaxYGeEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_200913_649758_1E4BC2F6 
X-CRM114-Status: GOOD (  10.57  )
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

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEluIHByZXBhcmF0aW9u
IGZvciBpbXBsZW1lbnRpbmcgY2FjaGVkIHJlcG9ydCB6b25lLCBzcGxpdCB0aGUgbWFpbiBwYXJ0
DQo+IG9mIHRoZSBjb2RlIG9mIGJsa2Rldl9yZXBvcnRfem9uZXMoKSBpbnRvIHRoZSBoZWxwZXIg
ZnVuY3Rpb24NCj4gYmxrZGV2X2RvX3JlcG9ydF96b25lcygpLCB3aXRoIHRoaXMgbmV3IGhlbHBl
ciB0YWtpbmcgYXMgYXJndW1lbnQgYQ0KPiBzdHJ1Y3QgYmxrX3JlcG9ydF96b25lc19hcmdzIHBv
aW50ZXIgaW5zdGVhZCBvZiBhIHJlcG9ydCBjYWxsYmFjaw0KPiBmdW5jdGlvbiBhbmQgaXRzIHBy
aXZhdGUgYXJndW1lbnQuDQo+DQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1i
eTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVz
IFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

