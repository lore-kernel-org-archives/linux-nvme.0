Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEB9C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TqfjBhS0aCEjdVI0oa0vRP+mPBhdF1m4AfUspNEzgM=; b=T3D+XGcA1lvFUsDZKUhXz42B+K
	Z/b63x1aMf9ZB3xJb30yvmcnZxUbltzTKexj7sdhgTd5Dxg+/44znKOr+IW80DDlyQAMKbjgjwwH0
	hvnhFf09suasbEBM8gX1xDzaJYcmAbcM8rLiuIUkh+LAog6jGE3skjQeeAwM02T5cfiwM0B53OTaA
	cOpveauKx5id+c23khbHJ86QiFlmB9Ge0LVAP2ZvKOW949kVuofgMEPC7ZYvmAkPFVKH2x0S8Fh8K
	7NqJ5to4UHeL+RYUmXeQLPjRT1aovaqVFHq+4QcRC+OrSaL4xWof80qbttkuy7TPGtvgZuEf6NMX9
	G5jXOdiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgsb-0000000FMKP-3jPV;
	Mon, 24 Feb 2025 22:24:49 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgri-0000000FMBc-3kj3
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:23:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfnUGt0jivgt2V78R2gNvuxFHgofsS8T3vEulVlpiML4iNsK9/nBhqEF6MTe6yXV3SJmP2xduOjXviUqD/hJ7OM+cFNHYe8fapVn1jzbirgyAKcbX1UIU1Nzi7PV3ywF9i5X6VJEQeCND4lCb+YcZ7BrlLmSDaUuZobXqfkxZ8ESmX7CmY1OEaAq72K+d4c8oCBiBVkPPD8wqxzJmq8EpNNaL0R7m18XfK/ZESUY9G+/LTnmXH2LzmqaqLqfOjH3I5IwKmEcZWn+XE+VBiKPPqrxVj4TNcrUDYnS65Nn2+YA8iglik3W5W3TidLJVjVWsF7TsZo1FY2upTkUTne9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TqfjBhS0aCEjdVI0oa0vRP+mPBhdF1m4AfUspNEzgM=;
 b=NvZb587WBDNxKfoTrsLFXYwr3cnRGdw5Lz/0AJi/Gq1/Gj6vMnP4xT+D+JuZ4jmHowhees52WXARXPN6p4/essh8kB9xppINW3Kblm1qUuJ8V/iuXgN0WjWzySZq62q22aTi11+lPDIlG4IwQesoKNJyHXkXRT1+la0HH0cXtrYC0QUZbvGobEcoAPy/f+n10z7HMCBeiccw97IgwReODZpN3mBqz0MtUI9OyLL07WL3nFFhFfMRnmwS4gPFprxF3XU7HldSxZaOKYFh6Iv2LzZonS5ZLPhiz1NuvWbpueo5Tf6fJp1rm6BMNaWYtPYR3/oqBqT5r8sZHsasdAxMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TqfjBhS0aCEjdVI0oa0vRP+mPBhdF1m4AfUspNEzgM=;
 b=KuDklI1seIxgXRWOvOktaTN4ssmySXzbKjIRKtB8OhlodGHJhlLC+VVD53oKp0zjws6uI5k9aHdgXfK75Fz5syAlt6zaJWSBjO4rQW6Kgnx9nKP3OSm4osHPPH76MSxb1XIuTuJroHwoUK9aQ5JJ4CYxXuQweF5k/Fe6pFqHZeMMfyT+ExDYLM78e6jqvTnhGX+erBn/R/+Wzo4IyZ2qfoKf+nORALGv/v4oZNmKXQLd1iozutzMdb8UKz39bdnkPALsFDjuK3V0WHCCCRvBlGwvZdmH/YZsUXhwoRlqT6J0nfFpJDQrZbv9hUQ/NkEDXmrTSkZOodDMNe0Lq7pnPg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:23:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:23:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: fix possible UAF in nvme_tcp_poll
Thread-Topic: [PATCH] nvme-tcp: fix possible UAF in nvme_tcp_poll
Thread-Index: AQHbg4mLWeyHWgCTR0i2JeC+z9gzZrNXDnQA
Date: Mon, 24 Feb 2025 22:23:45 +0000
Message-ID: <90bc54a7-faad-4a17-8ef7-ca91c4c0ce54@nvidia.com>
References: <20250220111830.3185561-1-sagi@grimberg.me>
In-Reply-To: <20250220111830.3185561-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7607:EE_
x-ms-office365-filtering-correlation-id: c9565dde-a6b0-4815-3afc-08dd5521e6d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnNtdXAwYXU4Wkp0bGZ4SkNRS1hLdWJLMVUxM0RSOUFVd3Ira3p2ZUFUNFlh?=
 =?utf-8?B?emwweUJXQTFEeklwMkR6M2IxdHJUK3g0dVFFdmtuQlVBZis2Tm40Z0s0ZURB?=
 =?utf-8?B?TWpmMHVaMVhWN2lJV1M0SmZKa0lVNTE5bkRxRU5CdDA5c2wwWnNrckIwd3RO?=
 =?utf-8?B?ZGhxLzdaUkRPb3UxcUo0aUJpWm9peDJmTDl3V2lmQ3FTMGlwVVZOcHlTUDh3?=
 =?utf-8?B?Z3VqRkdUeFJ3L1hYdnV1TklRUThWSzBKaGtvcGcyaDZRazhFRnZCTjdoZWUr?=
 =?utf-8?B?MTM0NTVETlNiZ24yK3hHRXlPNkVmVERrdkFxMUZqckVFdXVQbUZncXV6d0li?=
 =?utf-8?B?b0YzdnF2SlpKTU5NZjVMVlg0clorOXAxRlJwT1BVYjl2N0EvM1Vhd0pFeDVR?=
 =?utf-8?B?RE5TREhIZzliOXJzTnNSZ2lxQ3JEdzRuOVlpWExOUnRCVUVrSjFSa2NkNUhU?=
 =?utf-8?B?NlF4UEZSdm9OQkFMemtiVzZBVWlQVmZUcEY4L09pWmVaUWhYUlFhOUdpLzQv?=
 =?utf-8?B?aHV2MU56ZmlOSHc5KzNySVNlSTJ2SXJtdUYrYWtHeVk2dUtaSnhCbk0wVEZq?=
 =?utf-8?B?UUhiWnM1NkFNWFlOeThZQUxFaGM1cnVkdzZDNGRGVjhPYmtOTnZLemJ3RWpU?=
 =?utf-8?B?MzVha3RPdVJUOUgxL1JpMlIzYlFWQ09BUHg1eEJUcGlvcHAyb3pYdlYvOFJw?=
 =?utf-8?B?QStRQTBZRTJNUFpjT0tYcDVaQW9QU0RiQVFnS1FncVhVNXp5WFhLQ2tKU0hn?=
 =?utf-8?B?Q3pXbGtQdUVJUHN1c3RaaVovdnYyOXNGNlVYMENSN3QzY1lzeTdFZEkyaUc5?=
 =?utf-8?B?bWxRQ3ZXeWE4NXk3NEJqWU02MjJpNCtwcldiTHhGUWhYY1NZN0xqTUxLRGN0?=
 =?utf-8?B?TVB5TVlYRUlFZU50WVlnMjYyNzN2UXB1ckZEOTIyeUNncVNJQ1pDVFQzUVBS?=
 =?utf-8?B?Rm02V0JiaUwwRDNrV3Z5SDFmWUZSM1Uvb1lmNkg0L3htK3RocHhtUEgxOXhq?=
 =?utf-8?B?WnpweEh3SXNHeFlNbTBYWkRSb1oyRndwSVRMUmkyVndqN0w3WDRaSXdTWTlR?=
 =?utf-8?B?bjRxRkFiUDFDd04xQmMyYS9hYVJmU0hZRjFpaGdFV0QwQytUYUJOSTZiWlV0?=
 =?utf-8?B?MDhYaUF1VW1hUElCc01YajcvczU1OTJMZXM2MDZERUZLNnN4UWdvZlR5V2Vt?=
 =?utf-8?B?S2xPZVJpcytCNEcxNE1JMWo5Z1BKbkdDaGxNZms2dnhidFBuZE9LYjdreEFW?=
 =?utf-8?B?aTJIbFdjWHViYmlIY1o4Slh1MnpPNjFENjI1R1NwdEpaRmxPOE1lazZtTTNy?=
 =?utf-8?B?YWR2b05nUWFvOUdIbUwvV2Jma1dwOWZPZlFQcWVKQ3gybWdxSG12aEhaL1pp?=
 =?utf-8?B?TWJQRnR2TDBKL1RsUU5GK1h1UFdmN0NQQ21PRWM3bkR1a0t6UmVZSFB1Kzkx?=
 =?utf-8?B?Y21ZbXduYWRVK0pFQ1NFWHErSjVoSkJlaGRRRkJ2M2JDKy9MVkJEUDRHZmdC?=
 =?utf-8?B?c3dyVFVUN1lad1RITzdEODlwOW44N1JJUzI1VndXKzc5dS9oZmNEZ0YrZE5r?=
 =?utf-8?B?bG1YcHc0OXlHTjl4U0VBTDFWS1o3REFQektONW1yc2V5RkU0bWxjVmFEb21l?=
 =?utf-8?B?bFEzN0l1ako0ZGhuUVRDNGxyMHp5UzVUWHdWRG0wRUVyZmJkbzVtWU9tMWZq?=
 =?utf-8?B?ajBRdm12ZDJmT2kwbG5pemg3YTFOTjhhYUFUQkZDSjZ3ejVsU3NsT01MakJm?=
 =?utf-8?B?TExNeTNiTkF3eng3WHd5VkN1SjRSRE5GYlUxYTVqZ1B0TkJqelg2eUpmT0RJ?=
 =?utf-8?B?dXJ0RjNPbFhCbkFOdEMvLzgzcTdxdWg1QzFlR1ZQZFFRWGlRME9PQXNaN1ZI?=
 =?utf-8?B?RXdya2NTOG9jTFJqQk5MN2ZaNE9zczBQcWNqdXRmMjdBQjhkVzNWVUtKV0pJ?=
 =?utf-8?Q?ztFvd0NXSkas+dcDqqrsKU3ee3YsRY8g?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVg4Y096TkVVL1JucjJNRzRtYXZBR0JkM0M0YWF1Ty84b01UT3ZqcWd3cnJw?=
 =?utf-8?B?eGk0Zjk0TmZNQUdTQ2FLZmtXSmNvZ2Q3L2d3M3lmT1cvTXlxTjEvUW10Wkpm?=
 =?utf-8?B?VC9rM2k4WS9lUWdZZ2F5cFRtYWY2NG5uVXZZZHJweGMyWXJZby9JZlNNak1H?=
 =?utf-8?B?ek9jQkhJZHVLVkE0Y0NoQ21YMW16S3ZVNGt5ak1Vc3pyaXg4QXBXUlE2Ni9o?=
 =?utf-8?B?dlY4aTc5dFdvd1Q1WjhWUEZjNFFyci81MnJmVkU5NVV5RnhWVEZ4bk1BVUdH?=
 =?utf-8?B?cERGK3A3ZVFqUTNyTEFlNFlHUC9NRThNVUlLMnFweHFoL0Z1OWpmWjlaRjI0?=
 =?utf-8?B?aDdrZ0FUZTBGNDNic3ZueXl0NE95aHI2KzZTdUVZTm1XTnZqeFhiUUN4ajJV?=
 =?utf-8?B?MCt4a3ZHcm4zemptYWZkWlV2dkxIT1NXLzcwOU9SYnpRcW9JRWpZV1VWeEha?=
 =?utf-8?B?NU9VenFWNGNYOUZ1OExNNXJ4eU9DOFF0QjNZNEJyOXFVMFV2SWNSYnlMTEsv?=
 =?utf-8?B?dVUzbERmUXZHVlF1cVBTWTBjeXhvVVY0U1lGclNkbEpvckZscG1Oa0kxdDlX?=
 =?utf-8?B?Ujcwam5lN0pPMS9sQ0FMb2k4VDN3V0hQUXdXNHVCYzlCemJ3NFhEMlpXZTN4?=
 =?utf-8?B?d0taVU5VS1F3TkJta2VMRGJoY1pSVGM1cU9YVWloanNmeUprL1g0SDRVZk01?=
 =?utf-8?B?UThEdVUrcHNCY3BBOG5vbzBHUU5WTDdUcHBZUlpxYUtTaWlvcGwycUwweTJq?=
 =?utf-8?B?TjlTaER5QWNVS3AxRVNtcGtkSFErajFabjZBVlBvQWZHRGpmem5aV1ViRGpJ?=
 =?utf-8?B?dHliRmhOTFplU2RNSUd2UGVyMWU4U1BWZ0hkZHlGRVNXMkR1aGd2MmxQeG5u?=
 =?utf-8?B?ZDBsbjYwYmFDUlNsV0ZkazA3V2lRaWF5TUZXeGwvT0dOVStYUWpVRmZpK2ZW?=
 =?utf-8?B?eWowbURqZExQQ2lwMThBdFA1NjlhUHBJamQwc3djMk40TDlWSDlUVTM1TTUx?=
 =?utf-8?B?UU43Y0RmT1kreEZ6VGc3MXdiTVEvSkplN254Mm56R1dmOVdRK0hwb3h5MFc2?=
 =?utf-8?B?L0dOTktDbFR3SVVUQzZpTFdleDViYmxpZDEyREZ0akx2VnF3L2JDVHBzN0pl?=
 =?utf-8?B?NHdvSFBhUE8xYnhDZmZFZ0dQNkFFK01SVk4rUXhVNUZGN2MxWUkxdW9Ub0xz?=
 =?utf-8?B?SzU4c0RvODZmSVR4OVdURjk4S3FtcnppYmlOUTcraUJsaDZmRXhva01EOVY0?=
 =?utf-8?B?Vm4zRTZEazdoK3JOL2lHVmhrOFQzODZ4QTAzNWNRWHdsUDl3NDRhMWljblAx?=
 =?utf-8?B?ZUl0SVhqVGkvcFhRZDhGdTg0U0lmU2g3VHJyVlhWZ0hRcGgwUG8veFhuMmdr?=
 =?utf-8?B?ZHlEak10UG1LZTdLeU9mejA1SzFkUy92c2hETE9rVWQ1OHlINjhHWlVVMEdl?=
 =?utf-8?B?bDF6cDJVVWdvVzhCTStYbWFBVTNYQnJpZEwzVzJFbEw3K0NJZm9VQXJpa1BO?=
 =?utf-8?B?OXJweGd1RGx4ZzlDM0NEQW1zNE9JR0M2NHA3LzRxdnBoM09QdndjdWZkMzJW?=
 =?utf-8?B?OUVzbm5LamsyM2ZvdnRTbGdVbXNZcFNHeGNrYk5JU2REeEdEQWF6SkNHbE1i?=
 =?utf-8?B?Zmw4NFJsWkxWanljSE8yOVE4THlSOGRkakxQcnRwRU5CRnY3SG1wSVBDemVF?=
 =?utf-8?B?aUtTeVp4bVZxcEdVNzZSN21Vd05nOHlqSHRJcWk4cHdKaHdVWXg2OUV5LzZq?=
 =?utf-8?B?bHBieHFxTXNZRVpEK2tVLzI1dkFpZHBzOWlPK29ZRHB4eUhPTDVrOElvcDI1?=
 =?utf-8?B?Qi9GQVlaYnlKUnVpQlJVWk9GbjZuOC9yYjlSYlVFVTBaVktZMHdRK2MyckV4?=
 =?utf-8?B?YVFTaEFvWmJZbXViT3A0bmxBRDN5RlliWGRTbldRNi9GekIwWU94SkFFYVdw?=
 =?utf-8?B?QlQwWkp3RXNmNXhLMndtbk9GbUhaZmVGdzdCMWFzWTlHOFlTdnZOTWpSZUJv?=
 =?utf-8?B?dVFacDFxUEVRa3NxVEkrSFpHYlJWNHhFM09lczRybkpTSXMyQkhUdTVieXJq?=
 =?utf-8?B?SWdlek8xL1o5ZlI3TlpUY3VBVWRveGtpU2tveVpBNHAyRTVPS1dHNWY5Rmdu?=
 =?utf-8?Q?5xs7jVh8P01yJ3CoQ+aOSE6yQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <823FC679D8C9C246AF66B35B1D9057A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9565dde-a6b0-4815-3afc-08dd5521e6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 22:23:45.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4y/rOhozek8Qn/BXeeZGqKiblaAoZAm/iffzxp3qZi9ak7CEi9yANhLVs8EL9MOIQ71T0tKjpgGiLWcncTHpPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_142354_938872_5363328A 
X-CRM114-Status: GOOD (  12.87  )
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

T24gMi8yMC8yNSAwMzoxOCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gbnZtZV90Y3BfcG9sbCgp
IG1heSByYWNlIHdpdGggdGhlIHNlbmQgcGF0aCBlcnJvciBoYW5kbGVyIGJlY2F1c2UNCj4gaXQg
bWF5IGNvbXBsZXRlIHRoZSByZXF1ZXN0IHdoaWxlIGl0IGlzIGFjdGl2ZWx5IGJlaW5nIHBvbGxl
ZCBmb3INCj4gY29tcGxldGlvbiwgcmVzdWx0aW5nIGluIGEgVUFGIHBhbmljIFsxXToNCj4NCj4g
V2Ugc2hvdWxkIG1ha2Ugc3VyZSB0byBzdG9wIHBvbGxpbmcgd2hlbiB3ZSBzZWUgYW4gZXJyb3Ig
d2hlbg0KPiB0cnlpbmcgdG8gcmVhZCBmcm9tIHRoZSBzb2NrZXQuIEhlbmNlIG1ha2Ugc3VyZSB0
byBwcm9wYWdhdGUgdGhlDQo+IGVycm9yIHNvIHRoYXQgdGhlIGJsb2NrIGxheWVyIGJyZWFrcyB0
aGUgcG9sbGluZyBjeWNsZS4NCj4NCj4gWzFdOg0KPiAtLQ0KPiBbMzU2NjUuNjkyMzEwXSBudm1l
IG52bWUyOiBmYWlsZWQgdG8gc2VuZCByZXF1ZXN0IC0xMw0KPiBbMzU2NjUuNzAyMjY1XSBudm1l
IG52bWUyOiB1bnN1cHBvcnRlZCBwZHUgdHlwZSAoMykNCj4gWzM1NjY1LjcwMjI3Ml0gQlVHOiBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IFszNTY2NS43MDI1NDJdIG52bWUgbnZtZTI6IHF1ZXVlIDEgcmVjZWl2ZSBmYWlsZWQ6ICAt
MjINCj4gWzM1NjY1LjcwMzIwOV0gI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJu
ZWwgbW9kZQ0KPiBbMzU2NjUuNzAzMjEzXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAyKSAtIG5vdC1w
cmVzZW50IHBhZ2UNCj4gWzM1NjY1LjcwMzIxNF0gUEdEIDgwMDAwMDM4MDFjY2UwNjcgUDREIDgw
MDAwMDM4MDFjY2UwNjcgUFVEIDM3ZTZmNzkwNjcgUE1EIDANCj4gWzM1NjY1LjcwMzIyMF0gT29w
czogMDAwMiBbIzFdIFNNUCBQVEkNCj4gWzM1NjY1LjcwMzY1OF0gbnZtZSBudm1lMjogc3RhcnRp
bmcgZXJyb3IgcmVjb3ZlcnkNCj4gWzM1NjY1LjcwNTgwOV0gSGFyZHdhcmUgbmFtZTogSW5zcHVy
IGFhYWJiYi9ZWk1CLTAwODgyLTEwNCwgQklPUyA0LjEuMjYgMDkvMjIvMjAyMg0KPiBbMzU2NjUu
NzA1ODEyXSBXb3JrcXVldWU6IGtibG9ja2QgYmxrX21xX3JlcXVldWVfd29yaw0KPiBbMzU2NjUu
NzA5MTcyXSBSSVA6IDAwMTA6X3Jhd19zcGluX2xvY2srMHhjLzB4MzANCj4gWzM1NjY1LjcxNTc4
OF0gQ2FsbCBUcmFjZToNCj4gWzM1NjY1LjcxNjIwMV0gIDxUQVNLPg0KPiBbMzU2NjUuNzE2NjEz
XSAgPyBzaG93X3RyYWNlX2xvZ19sdmwrMHgxYzEvMHgyZDkNCj4gWzM1NjY1LjcxNzA0OV0gID8g
c2hvd190cmFjZV9sb2dfbHZsKzB4MWMxLzB4MmQ5DQo+IFszNTY2NS43MTc0NTddICA/IGJsa19t
cV9yZXF1ZXN0X2J5cGFzc19pbnNlcnQrMHgyYy8weGIwDQo+IFszNTY2NS43MTc5NTBdICA/IF9f
ZGllX2JvZHkuY29sZCsweDgvMHhkDQo+IFszNTY2NS43MTgzNjFdICA/IHBhZ2VfZmF1bHRfb29w
cysweGFjLzB4MTQwDQo+IFszNTY2NS43MTg3NDldICA/IGJsa19tcV9zdGFydF9yZXF1ZXN0KzB4
MzAvMHhmMA0KPiBbMzU2NjUuNzE5MTQ0XSAgPyBudm1lX3RjcF9xdWV1ZV9ycSsweGM3LzB4MTcw
IFtudm1lX3RjcF0NCj4gWzM1NjY1LjcxOTU0N10gID8gZXhjX3BhZ2VfZmF1bHQrMHg2Mi8weDEz
MA0KPiBbMzU2NjUuNzE5OTM4XSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyMi8weDMwDQo+IFsz
NTY2NS43MjAzMzNdICA/IF9yYXdfc3Bpbl9sb2NrKzB4Yy8weDMwDQo+IFszNTY2NS43MjA3MjNd
ICBibGtfbXFfcmVxdWVzdF9ieXBhc3NfaW5zZXJ0KzB4MmMvMHhiMA0KPiBbMzU2NjUuNzIxMTAx
XSAgYmxrX21xX3JlcXVldWVfd29yaysweGE1LzB4MTgwDQo+IFszNTY2NS43MjE0NTFdICBwcm9j
ZXNzX29uZV93b3JrKzB4MWU4LzB4MzkwDQo+IFszNTY2NS43MjE4MDldICB3b3JrZXJfdGhyZWFk
KzB4NTMvMHgzZDANCj4gWzM1NjY1LjcyMjE1OV0gID8gcHJvY2Vzc19vbmVfd29yaysweDM5MC8w
eDM5MA0KPiBbMzU2NjUuNzIyNTAxXSAga3RocmVhZCsweDEyNC8weDE1MA0KPiBbMzU2NjUuNzIy
ODQ5XSAgPyBzZXRfa3RocmVhZF9zdHJ1Y3QrMHg1MC8weDUwDQo+IFszNTY2NS43MjMxODJdICBy
ZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPg0KPiBSZXBvcnRlZC1ieTogWmhhbmcgR3VhbmdodWk8
emhhbmcuZ3VhbmdodWlAY2VzdGMuY24+DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmc8
c2FnaUBncmltYmVyZy5tZT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

