Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9384ECCD19F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9S4I9GupyM1B8odfQ+68I+uis3Y6XvWV/DaX63cbIw=; b=cTgKLDG8yyE8S7n4u6pGM9C/fX
	FvJqTkfh+6+pLF+36JTzjo2fPR6unIEgnMoQlN7IY1Akb2fkbxO2nVXQg02h3ppuZgj9k/pLoVXpP
	fU5QA7DP0SbU9LxHupzdL1i4kRWBbyZMmQJeQPA/x94fx/Ax5dQvf9C0j87ws58+tKJ7UobhoN6Ib
	HxW1QhZGBk0IiEAKMC3XKszEB9DIin6aHNTtRdzWt/OIkMtEFF5QrfCKeUscV00fMXl9RhSH7/jc6
	6mcCdZGC04fBwR7sedtVYVjYOSss86Nytt1vziUiU8C0gM3XpaAqG9Pmd4DQN11EtlYdPgVUVdZ+i
	ovhu4AKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzSx-0000000FHRB-401y;
	Mon, 20 Oct 2025 23:39:03 +0000
Received: from mail-westus3azon11011030.outbound.protection.outlook.com ([40.107.208.30] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzSu-0000000FHQc-1LPT
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 23:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8R/wC52uMPx6KbtZJ0sR5SVTZgTzNVgy+EE1XKQ206hPz0d9YthdoUIUgZBbbzELtEAHC3UeTFFJ7SE04OPc+mzbnQKm3z6hNOD67Yv/kxpLU3KUelGWIVCNajh8WbWPD8ObREbwgUkv7xQOBmjtW5eFVw9PcXs3HThHvpi/ygiYpWie53pMNcRovwM8py+luebK1tsC6VYF+Xj70m2TNkIpuOD14KGv74ZL4xeb6L+VbkU1HIJGusfauMtjP5A7vq71fjT8QMQ5Sb3mLNneJAVHQNT3DYkntzEsLrnVjodvCVRFF81Q+n0ZallcWzMTKRrCpigo6WQmmnQXVwHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9S4I9GupyM1B8odfQ+68I+uis3Y6XvWV/DaX63cbIw=;
 b=mqhNwEa3f+J1b3yN8szNDZ2DnLlPSmIcXFK7+finCFPgcJUxhWlEZ3PxYXx2HorK4SIV/I0xeQ4VjIy+nhkH3NVh7EpM0k1fZQsaHVJvPnYhooSWNmqVBEcPV+7NkyPNWAalZtw7VhusWKKBlKUVhlnvuj4UbOW0uyD1TQzFFpcESnx/1/MMUrxCQODtSqOP14tXa3ffFZC4QK2r0czI2OwyKI2wHrTQqiMneq5ZPGmrIMFuRfpyo6yDydfuqWfZaNPZEv3k0aIMzKMXtd4TMN5QmmD9Avdp6xJjEW+9gQOFsrCEHURpYL6gw+crXtx1S+FsgJorWGFBwxw9rn6BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9S4I9GupyM1B8odfQ+68I+uis3Y6XvWV/DaX63cbIw=;
 b=gRKDgXt0M0S32YrfTvZEjqgUsn4rq7qV9/SRqtKM8l/gzsl5noOmGTyOlX7dPzgqZzMKE+FNRClYN0CkOg3wRmCXLw3lQgLunrkuktUHI68DvChJlJZ0mEip/ZLpcTb16dbLMB7UEoNjhtUfU6w8f+2u+tIBWRScc+BLTgbKqDc+TND1eAdor20v4RF1N6Pi6S5mDO0EDvr92COyV9Tj6e8me+mSL2l/Q1r9ZHEA/ofrrf5cwNHngegs3vVExY0LMBpACzlyhFeKb+E6Ut52BAG2nt1ototm/h5z1eH9I3gWFJqVAUcZXq0thnwNvLmkDQaOC4VeLsyTc3ELoZk9ZQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:38:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:38:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Thread-Topic: [PATCH] nvme-pci: always use blk_map_iter for metadata
Thread-Index: AQHcQe7wql/Mqkgc7kWnqsn8dmsd1rTLsYEA
Date: Mon, 20 Oct 2025 23:38:50 +0000
Message-ID: <844a742a-466b-49b1-831a-8c2b0311cea4@nvidia.com>
References: <20251020182444.2587155-1-kbusch@meta.com>
In-Reply-To: <20251020182444.2587155-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5827:EE_
x-ms-office365-filtering-correlation-id: 51a303da-7390-4353-9eff-08de1031d2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZWxGS3lIdFpIVzRydFgwdXd6OFBRODRJUnlTSTdrK01FeDl2RSt0RkhrZENO?=
 =?utf-8?B?OFZIK3R0bmJZdFZTbFlld1RiTmU4QTZaT3k0UVNvakFFWVpJUXlZY2ZCUzZt?=
 =?utf-8?B?eGptTWd5MDFnQW83QmtQak1wY280R0VNcXhoNVZmbGFKNkFhRHorN3hBcStj?=
 =?utf-8?B?NHZ0Z3dpQnN5ejdjME1nVzduNmFNTGhncWphT2ZGM1hsaVlEeGNjNThRUTRo?=
 =?utf-8?B?cElYWDVlWldZa2RWZHRBdlRpZmkzdEI1OERqSDlJUEIwVHdBcFNZUk1Va2ZE?=
 =?utf-8?B?c08zREp0L01nWGV1aHlzc3JjQVUxMWJrWWdKQm9aU2ZyOUVMUnNEM09vNGYy?=
 =?utf-8?B?cWRFejQ0ZEh5aHpmaVZBa2R5NlExaG9PcTdOalRLbGVsaS8rSHJEV0RhQUVh?=
 =?utf-8?B?RUl6SmREeThpSzBiL21CWG15RUJFNmxrc28wVXdnT2ZCR2VuUlNZZEFnM2Nu?=
 =?utf-8?B?bldlQlVJYlRaQTk4QVlJOUpDKzYrZldhdW5rRGJ5SmpmYS94UWI4R2ZmVDJ6?=
 =?utf-8?B?UWZySXZNZnMvRk94VVpRV2x3azJtbjlORzNjYTkvQW8zQ2Znb01KcU4wVTMr?=
 =?utf-8?B?T3JJUVlKWjhHWi9hWncrQ3lnVE9KbEZIOGZITng1QVhTRlF5Wk9wbmJ1MXYv?=
 =?utf-8?B?bk9ienExSHBKMTlVbndndVBqU0xlUy9OMWFEQ2lkZGJNU01wNENZSzVBZFJo?=
 =?utf-8?B?eDRtVG5FRHJKSW9vbGkzQlpFcVRQV0IvQjRtVjFDOE4vcW1TM0xZUHl4ZDZr?=
 =?utf-8?B?OWNiQ1JGZG9OeEJXcnJ5NUpKb3VORjhyRHU2NUhLK1dxM1V1M3hkVjZKcHI0?=
 =?utf-8?B?NmQ3ZTlESjFsMFYycVBwbHh2YXRFRjhLVXpTUHR2a3dnYktLWDhFMStSbTdM?=
 =?utf-8?B?d01oS2c2eXFtaEsvWTJhMDNQcVBOSzV1QVB4cDVZaldQZHZvMnQ4a044K0JM?=
 =?utf-8?B?TThNY09JQUFEcXV1NmFoRm5QV0JScGw4d2JHRmt3RXJiNlU4U3pkV0hGSEcv?=
 =?utf-8?B?TWVpaWRZL2ZrdkFrdWtWZVljVi85TjI4SCs1RHJLbnF4cysydXpJb1Nvc3RX?=
 =?utf-8?B?Y3BkS1dFdk9nK1Azd00vMUVHYTllallBZ09UeTFmWE55MnppUmdnSUJsWUFB?=
 =?utf-8?B?NExXN05jeFdGYlovcUZLTjd6RjcrSlZBNzZnOEhraW8yTlhtTTkyZXpTeURG?=
 =?utf-8?B?TWswd1Z1Unp1bUR0ekljbmlLU1NSUmNRbVNEaG96TVEvaTJVYUIyZFVNVitD?=
 =?utf-8?B?ek9ERE5SdWhzODhDdGNZZ0MwV3phR1lLcW5uU1hPK0YvRkhzNHRGaDI4cDZR?=
 =?utf-8?B?UUQ2V0FsMUZoM1MrZGFMaWt3L1RLRVNCT1ZMSldrL0JsT3Z1aGJzNFEvb2JH?=
 =?utf-8?B?Z1J2L0p3NDhUa3lDemZHckpPOEZTME80cEtPV2VLdSt1WCtwaEk3U1NucHBM?=
 =?utf-8?B?ZHoyYjVmblM2bnNHUVBEWEFiaVk4YkZtTEEwN2sxWUVBL2VrSm45dXZsTElW?=
 =?utf-8?B?bjUrRzRjMVpYbmo3ZVVEdi93VjRReTVwYklXL3lodHdzN2llR0Z3Wk42cjh2?=
 =?utf-8?B?dEEwQzZqeWw4Y3FFM3RPd3ZpdmZaT3FUVU02OWhaR216LzN3bGpZQmhkOFND?=
 =?utf-8?B?U2c4R2owNzFEVW5zOEJIWktrWDlveDlHYjhBOFBpdWhzN1BIMEh5ekdtZnR4?=
 =?utf-8?B?b1N3cXMySWZQWVdTWjU2RGY2enVUeVJwaDc0cEcveDNGTVFZbmhQNE9iWVFB?=
 =?utf-8?B?MHpoWlBoeXhBblhJdXhHQ0xEV1R3T3UxMlJKelZTZ1BiNm9zMC9nRUpEamJx?=
 =?utf-8?B?ZXlJMzlpdlZCS2h3VFBFaFFHTzBJMHFkNmpDQ2VnMXdqdzIzVmhNZkphZEdq?=
 =?utf-8?B?eWJxVWJ6OUd6bElTTEp5UmF4Y2hMSklFUEFMRjVZczhKQTBlT3ZZZmRRT2FH?=
 =?utf-8?B?M1RVR2RVbFBiZ3J1aDBRV1ArbmhVbEtSQWx1UW43R1RENUZCVkhrNWE0b3dT?=
 =?utf-8?B?cHpvZ05MeDROVUxPOEM3aVc4Qk94bjN5SEJramszVnhhaFVQZnFGN2g0UEN1?=
 =?utf-8?Q?wSfZuQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TklFUGRGWjBBNGExSWhEelNiR2xIbHZNOG9xd0p0Rm5uNTlndVZwSFA1Nk9O?=
 =?utf-8?B?OHB5OXVTTG9GYUY5RjhkdWdSeE9uZlJzeFp6UnZXUXZrbUdwcWEvM3JEeGVL?=
 =?utf-8?B?aEs1UEt3M2ZnOExycjJMZmpzTnFmQk1ia05WdHFub0YzcStRWmNZVTB5dTZv?=
 =?utf-8?B?QmxRb2F5MEVVZ1Z5cHRGRkMwT2hqTEFkbUs3aU5WNFhQZk52NlFwRE85UWZ2?=
 =?utf-8?B?bDNJTFh6TjhVajZZa2tnOVhkbGdjNmtTemt6c1MvREpmdjc3V1hreENKeTJE?=
 =?utf-8?B?alZHc1J1WHZnQzRiQ2w3elVvMWJnNXdJZHljc1hoWWxSOUUwNjZYbHAxTmQy?=
 =?utf-8?B?cjR2UVE3YXZ2U3o2SEFqcW9RMUVCaDdJaFhEQnJoZXBKWUZBVlBDVEJVVlVz?=
 =?utf-8?B?VGIyZTVOLzJIemE0c1RDMHp2bGlhdzZFS2RwbXBWTm95TGVZRHV2QkVSanRU?=
 =?utf-8?B?SFVQZ0tKencwWitSdUF0MUZQVXA0TVB6NE91dFdnS1hYMUN6bTdJV2pRVDdP?=
 =?utf-8?B?TERPakh6WmtKU3BLR2orVkw3MDdKN0E1V1M2K0tVdTVHLzJDald0VlVUM3d1?=
 =?utf-8?B?aDA2OG45KzltWTZWU1E1eC9tdnhuSWtCUEFLRTFrYmhSQnEwNWFzU1A2Wk5L?=
 =?utf-8?B?dnVvSi9WQWhpK3BaSUlBb2hTa0h2N3EyaWU1MHlvQlRxL29SUjBha1h3aEQr?=
 =?utf-8?B?d2F3L1lNelMrUkFHczQrK1VjRStqbGp3Z0g4VXNOU3kwT3VheFIxZW1EZ1ZZ?=
 =?utf-8?B?Qm9ENmYvOFkwR05Yc0x6MUpYNDN5VGR1Z2Uyb3F1K0tTSlVnVHdQNDgwcFB4?=
 =?utf-8?B?bUx6blJkRXJkOXVyZS9JL1lsZENGQWllTXJqRWlDMDd6N1dvempaazI5MExV?=
 =?utf-8?B?bkRNLzZvMDRJcGtGNHVyTzZEWWI3RGp6aFhsNG1Pc25KcHZUcjJoMkJONHIv?=
 =?utf-8?B?ZHpnNFFmNDRoZVZ5d0VxWlpNU1BHZ1d4dng5NllWS0s1K1JXdTlicHczZUhO?=
 =?utf-8?B?bk0zM0RSK2VHV3czVVVrZmFYK0s0ZWpDdU5GR1JVdUhhci9YR0dRbUppeXA5?=
 =?utf-8?B?Z3RLYjJEYXkrOFZ6M2hxZ3RzRFVyMzNRVnRtNEs1OS8ybHdjWC8xRjFRMVd6?=
 =?utf-8?B?SjdQOVdiRnBXY2Vwa0FhK3JnOVNLOERjUzNaSXpJclRxRFExaFZ5MmxRUElG?=
 =?utf-8?B?MlRERHVNUExTd0orZm1VS1dhUTV2M3FGZjVNdk82RUxVcFhRRWU5T2ZSOFFu?=
 =?utf-8?B?WGszbE4rRldpUG5UU3U3MTdXb1FjbTJraGRRVnpaU2I0OHl2a1NmbDQ3cTRM?=
 =?utf-8?B?S2JqT0ZIYXAzeWtpaW9KdTBCU2paL0VBYldYQit1UnV4cnVBMGZyU3AzN3dU?=
 =?utf-8?B?SVRXV1ZENXFuS3lmQlFoK21KTG1jN0VoN3pQbVNaQ29SQUZoSHk3S1NvWkUr?=
 =?utf-8?B?MlpKUWZvVmlaeFBtbE03WkZRcDQ0dmgxYXI1cDIyMkxOLzBXcmJTcDM4Q0Zk?=
 =?utf-8?B?SjF0OEFoTjkwRzlSZER5amwrd29yYjZYSlNPZ25HZnNCOTVOSGdicXdRSDNW?=
 =?utf-8?B?ZVZrK1owN1dLekhOVllpY3VpN2xQMjRud3YzcXR3SHBtK3hSYXVDYzUrVy8x?=
 =?utf-8?B?aXhVZllnTkhETW1JK3ZnRytTNFlMNXY3YzdMWURGQ1kyM3Vjd0NHNnNlS2lK?=
 =?utf-8?B?K1h4aHYvSmgxWEd0dVlxOU1vd3ZGVFRDYmhBQ2pzTXk0dndHRklldERmUExl?=
 =?utf-8?B?UG1ubUwyMy9CRSs2RDBYWGpkNG1Uc0VubG5QSVRWSUtCem5naHluOUVvVXBo?=
 =?utf-8?B?TzNralI3VlMvYzJnRkFqTmJ0VXBoaHU1d2hCTVVRdFRYMFo2cWxxNU95dWsy?=
 =?utf-8?B?OEFjSENNUHBEbUJGVmk4b3dSbGxmL3Awa0loNEFpZjZlYWE1bTQyNSs3T2FG?=
 =?utf-8?B?VzQ5cEFPcVVuUGZkcFloYUI5QVdQdDg5MjFQS1M3REk0eTM1anFkWUVPZWRQ?=
 =?utf-8?B?bkVLVkFmLzJ3TFBtT3ZxcFh5V0svZWU1K0JzeUZRM2tDMjVUZEVBNENGeU5x?=
 =?utf-8?B?WGttRS83Q1JwbWlQaU9KZUFjL2ZOOUhnU1pJcUZRcGQ3Z0lISVhURjJ0K1k5?=
 =?utf-8?B?djNVNkNkUDZobFF5RHMrN2pwMk0rYlp0Z3hsV3ducitjYlJjN012RDNieFdQ?=
 =?utf-8?Q?YIiij9Oi6UosHtoE5NI4jYoNGFaMymgWgtIr2du+tZCr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AA44938FBF54D4FB047E9EB68AB15BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a303da-7390-4353-9eff-08de1031d2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:38:50.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayh41mvH/uLaLLo8Yke1PN9jUdlUgRwVyATRfBDEGLsHCXZ6GktETvIRmTAh7gAdsBCqjD5m/OsCiqqTX9RCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_163900_359698_22C8ABA5 
X-CRM114-Status: UNSURE (   8.10  )
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

T24gMTAvMjAvMjUgMTE6MjQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGRtYV9tYXBfYnZlYyBoZWxwZXIgZG9lc24n
dCB3b3JrIGZvciBwMnAgZGF0YS4gUmF0aGVyIHRoYW4gc3BlY2lhbA0KPiBjYXNlIGl0LCBqdXN0
IHVzZSB0aGUgc2FtZSBtYXBwaW5nIGxvZ2ljIHNvIHRoYXQgdGhlIGRyaXZlciBkb2Vzbid0IG5l
ZWQNCj4gdG8gY29uc2lkZXIgbWVtb3J5IHR5cGVzLg0KPg0KPiBSZXBvcnRlZC1ieTogTGVvbiBS
b21hbm92c2t5PGxlb25Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8
a2J1c2NoQGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

