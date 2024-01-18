Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF84C47DD6
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPEdGp/S1s/Y2GUQm/Jcp9KQbeQXubQ715nsLNvVQyQ=; b=BIVVxBOzGGWeR90iIcsPVVP3+5
	fZrjdS5DXYyreZTyCy4tOroWVfcL6DRCvfgZEjiQFbOcqcVZ/tTRo9oERFmcGMUSkdGjZF86bskcQ
	ACEdd6PLPmhsn3kO91yFGagwsUO2bmLLSwo/bdX7X5NcnK1t/ZsW8JXZ5Jo9AtYIPRDfvxLNtlmK3
	6Z1lYOcXwyCm5ynrV2/usJVySEEca/X/MUb/amplaR1JNuJM/5Ouab9VRhHxdXcnTqQKXThFIO0In
	YPT7d+zRWN21l7VBl9v15aldiiDrxD4Re//9bdGa8z5Dth1eMPiZnz6HIh2ebTfvcG60R+b1PWfdP
	rt4OiEhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQX7p-003VIU-2r;
	Thu, 18 Jan 2024 18:28:25 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQX7n-003VHU-0N
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 18:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY8C66/+4ZucJyJv54wy1+OHdE+4aASlg1Z9E+U4pKjachzCWnEOnJgM5rSN5ukecZpyf8gMLVsjagXt5FyFfwSx/tEIzp9uavLDql4UTQP2alB3I5aE+Paz9wKbF3FMecgeipQUFQX7BXNSGUaORjFDnqzWEHWt/bXErEzc8x1QSpqXeraSbX8iPgcfbVQPZhMRCp32Zvrmbl713lVysRPO+vxDuhpQwbViB9+Nbo9H7eaqwy6GWE9jLfkKpsXalct1Jw2mSW2xu+doxsEo+y+UYuIlQ1QUrhPpXqzkcmFsbcA488ikyHNp2/ZOWDJMscxBTWZ5ys4KvvxJu19rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPEdGp/S1s/Y2GUQm/Jcp9KQbeQXubQ715nsLNvVQyQ=;
 b=gfBCJkTuqQxe/XADrcP8P0tBtD0SE+6AUB4GhONukCvJCICtQDHAi1xoAMRMzMIDfxniMMOJ/UVbah7GNfcpDqzkR6Y6QsMi0jU/x7cFOKtRB1B0K7ZvYf8An0uskv/qtR5Xw/LdcuISXhSWUQaiXZL39YGx7eXARigfPuhx4GKPkfg4KCVcz9x1gGgXkzJTvbOsqvcqE+NcBwbLxT/pLzMk8Ej+JVlXyVfGq/Dd+gnTv4aN2BeQWpfXKbGmTt1vhRVC9KdCdVo+68DlSefmZDsIO/PCswUioX0lzYCov/Zke9Z/6eRSJgS7Uwj2bLcuaBC2gga5LzCwUh8ugIzFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPEdGp/S1s/Y2GUQm/Jcp9KQbeQXubQ715nsLNvVQyQ=;
 b=LslrkkUu2Muk/WEJsISXzlpnTsAzRePEiZU+bJoSQXvXBJhjt27yu/4bbbCPA4ci9m//TCDhke7HFjvtzh54dMa+EH37yVJjRlOrHEEv6iqcEebVXJ5JkBnXTC8O7Fe/oRkPb023glJU+rXy/KOttRbLHnmxbLPgzPQaDEK7qubuxH0xHl/Kz9Qc6KvHLsSyZEQRQ9krVw8rn9RcY5aEeabME2ao6iGuiMxJXm75B8MfhdKtBKdybjXLpWZfzVDlUyDHq9ZP8eaTH+wwwzWyhspbfUYN8IZx3KLaksFdH+hZf9KgSGbBYwMk7SkIXLEfurQ6VtB/a1vpHBlOABkoDw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 18:28:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 18:28:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 2/2] nvmet: add module description to stop warnings
Thread-Topic: [PATCH 2/2] nvmet: add module description to stop warnings
Thread-Index: AQHaSdBPxfEKcdMRjkWicnjrOEWVPLDff6EAgABk74A=
Date: Thu, 18 Jan 2024 18:28:13 +0000
Message-ID: <8fc2dcae-e443-4367-b425-b073a073af2c@nvidia.com>
References: <20240118053602.215765-1-kch@nvidia.com>
 <20240118053602.215765-2-kch@nvidia.com>
 <45f0e4a1-f7f7-4b85-8a18-3793dd779365@grimberg.me>
In-Reply-To: <45f0e4a1-f7f7-4b85-8a18-3793dd779365@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW3PR12MB4444:EE_
x-ms-office365-filtering-correlation-id: 0dba362f-8e1e-45da-cc48-08dc18533b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ow3UlMgb8Iq6eDk/u4lnYy05Ix+2Rg0vBgm0gwduaYRTuEx5eMrfNnKbu8mutLC+Ww9HQKdQdTJooO8nglnoY9yCp+gvQDHOThER77q6/y0IOji89zKVmJIyCl/GQiY2N5s6qa/i8dtcyjDd9a3gdV8sdsDHDUZlIt7UTRXNaAD+ZgszJsVEe5UCZLfnB6fuo9buyfTS3RvESxdbs3aUOAqwcX9ptbF8JA2xp7z7hUrJfs9W02vvXrOcxq1ziIUGWPHLOygMwhvoG187DGChpURbN9XZh/eNjc05HPlvdx7XFxPKtMPYFcp15hxyvdFNRRjzYXrOit4TA0oa8Iz12rU/N5ZR/dLKoC3akRXCIYCKmo/zX/K6jAMdZSWy4Ff5DKinOBkAJO6kDWZ2AcUOmrvDwMDdORwNmf9eL6qCzGoF6DUA1uH4m5qccabu/om6FNnCIp1gTQxbr1LUg5v/njXjmHga2SxuDdr5Wt3cTKch7exLWFeQVj1Z1UB8Si9N2lSH6JNJ/2iSxaigBqvR6LC1x585ZyDm5hU5ROdYT7eM/v6GpUOKWYS0iNaGZHdkiTbJpXQzquhaUNicGyiNmnn9uiFX7civhUprc+nM4Hcbs+RbyWGmSmDgmPa3g9jANH36iHVzgCqjtmjco+jxPl9jDr5mTT6Gr5jd0MnOzAjFM7eqd1g5lUN5d5KoMLWS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(558084003)(8936002)(5660300002)(8676002)(4326008)(36756003)(26005)(31686004)(66556008)(66476007)(91956017)(31696002)(66946007)(66446008)(76116006)(6506007)(71200400001)(6486002)(2906002)(64756008)(54906003)(478600001)(6916009)(316002)(86362001)(6512007)(38070700009)(107886003)(2616005)(41300700001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJrUTBSM2pMSXcvbUFYZXQ3TDc1ZlV5MUtOV3pVaS9jT1VoWWkvVWxsVWJK?=
 =?utf-8?B?a1hBck5OT1hrNE5PMnVuZ2dmanZhbE9YNjl6Wjc0NkROQWxIa3ZXSHNuK2Np?=
 =?utf-8?B?N2ppdXlYbWFmdUI4N25zWUE5eEpFekMyNjcwc3VUblpwZGwrQnRJRVM4S0kw?=
 =?utf-8?B?dnBjOHhuVTVUM041NnFlcE9RczRnbitIVGdiUmJxWVczUERYRUlSM3diM0p6?=
 =?utf-8?B?NUowYTkwV0x2cWVDSzBaMVN5WTlKOThxZGI1dlRBNUJWWHcyN3pjVnMrREVZ?=
 =?utf-8?B?MkpvWDlDN2c3SEdJT0UxT0xrOXpacUhwWDJXZ09EV0wzemZVN2Rub1UxZEwx?=
 =?utf-8?B?bDZHNTVCZW9IRzlKVHVYSzFQVG1oc25Kc29WUktTTXI5aXVycDBQWnQxeGgx?=
 =?utf-8?B?d1grZTRidjB4bWllTDc0RlZ1bjNjMmdqRjU5MUZQWlA1eHl4cDRFblY5Y050?=
 =?utf-8?B?VXZST09IOTNGRU1VcStSUFFEUkN5RGlZMVg1SzFKZGJYUURFajJBV29obUp0?=
 =?utf-8?B?emZhUXZXRFg3K05DY0JoazUrLzBTVHZ2RnBubnRtaEpxRWhyaFJNYitUaDJO?=
 =?utf-8?B?MkJ0bXZnVHo1QllxVUUzVnFZZjVQMDFoMHYrYVE5d2ZCTkVYTWZSbHJqUk9x?=
 =?utf-8?B?ektvTkd4Qk92T1ZuTE1PUTcrMXI2enBSUWgwcG84Z2p6QjNZMGxuaVI3Zk5O?=
 =?utf-8?B?eEJDblhaSTI0WmFkaVlsRXRtRXJHT1MyRllPbGJrZGxGOHo4WlYwZS8zeHhF?=
 =?utf-8?B?Y2E4SDVNWko3SmVyalpkcXMzRmFRNWFlUnkrQlZLQVZpVmpTMkNHNDN4Nmxx?=
 =?utf-8?B?enppWThwVzhVRWlHWnB5NFAzNnUyV1ZQL0VFZE1UYWJsS1FhbWZMYUsrSzJK?=
 =?utf-8?B?bVZ3YVFUeC91OVlUa21qRU1aWDR6WnJma3pidTJKK2VkZ2o1M2JSNHdiVXpO?=
 =?utf-8?B?NFpyYUZwLzZmV0U0ajVUMXhncFVNZkNnWFgyUlpYYndaNmpKcm1oVkZycXVn?=
 =?utf-8?B?aFpIN0NMcHdpZ01WT2dicndkMWhzb21sZk82TDlpdytpZnROa3BXRFJYdDlk?=
 =?utf-8?B?bHlyQ1M4SDZFUW82UFFtYURwNE9DZkhnU0hmWWI3cjZjN3lYT1NqOSs4MEVF?=
 =?utf-8?B?SlQ4a0pOYlBhVFBna1Y1bnBxbURQQ3QvTkQyQVlaYlFqSTQ5cmVIRG84NzBj?=
 =?utf-8?B?dHVuOHF5TTVGbUdZYVNCVnFWblRSemFJNnBpU1JLVi9YT29taE5wRXZJUFpa?=
 =?utf-8?B?RU9ZUS9tTW1nVkFoU0wrSFlXayszY2VKUWp6aHlRNTZaeDE2YzZaTTlDVm1I?=
 =?utf-8?B?UzV4ZmIzTWpjTkJYcGNhL2VIMGdDOGszZHBwMFR0aW5Sd202RmFuK3NaNjE0?=
 =?utf-8?B?ZGZvb2JPR0ROV2NBUWVnUDFlY2ovSVYyOUpva3ZiODA1UnVxRDJUdXFKWUt0?=
 =?utf-8?B?QXhHYyt2L05JcXJnM0U4Y2VzQm9UL1piYTlJUllBZmN4akNPUGwxL1M1RS9E?=
 =?utf-8?B?WDU3S3FpU0VHQkRHais0eGg2R3FtQkRBUVZXMDdZMFYrWDY0Z01SVjRUMFAz?=
 =?utf-8?B?RmRJb2lQRkNydFBzYXVJOGE3UTdPZXNlVDBuSGlDalVRQ29FM29zQ0duU2tW?=
 =?utf-8?B?VHdKbys5c2NmL1VLczZzZ0hEbzdKYnI2bzBVM1EyVW91RjFzNkpJSklLV0xL?=
 =?utf-8?B?TVpHUHZraHJWcWZsNjQvOU5nak5rUFJ5S3ViQzB3cy9wY2xBRDBPWVRJSWpw?=
 =?utf-8?B?Q0hmS2N6QlphOWdVUFFFR2hJSjV2UElaUnErTjJRMHhWVHI4ZTQvVnpQeHdu?=
 =?utf-8?B?MWhMWklwSDFLSGppTG52cVJydUcrYUFwSGdrdFplT3djVUkyM0hENGpxRmVR?=
 =?utf-8?B?WHVUWHc4aTcrd0pkcWE5VU93NzVlMThRMGdmNTIwQ0dGNHZ5RXlpUUI0Vkl6?=
 =?utf-8?B?RnRnZXZxYXUzSFRlSnRxUXNZQ0RhWndSQndmMjU2NCsxWThIMjV5M0NmWEo4?=
 =?utf-8?B?VUxsdUZWR1FWTWZKUVZnc3RXUkNsY0dXWGE2QVkxMlVLeUNvNEx6UURzTHRm?=
 =?utf-8?B?K3pVVDNZRXN1clRKSWxrRk1Kc2EvZGVLdlNjbEZha3hZajQxTXgvTUt6Z2po?=
 =?utf-8?Q?kVmQLoWsCoUeCFFX/bkAySiub?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD58A37E6DB8154BB8DF5F82945145AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dba362f-8e1e-45da-cc48-08dc18533b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 18:28:13.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ln6guEM7uyfpfDuk8inv9GA59Jq6Q4AC65EcmUKozr/4+DjCkqrc0RSImcFo3txrPjeoydWWYnX7gGPlXA8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_102823_184909_9DFE8C46 
X-CRM114-Status: UNSURE (   6.81  )
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

DQo+IE5WTWUgdGFyZ2V0IFRDUCB0cmFuc3BvcnQgdGFyZ2V0ID8NCj4NCj4+IMKgIE1PRFVMRV9M
SUNFTlNFKCJHUEwgdjIiKTsNCj4+IMKgIE1PRFVMRV9BTElBUygibnZtZXQtdHJhbnNwb3J0LTMi
KTsgLyogMyA9PSBOVk1GX1RSVFlQRV9UQ1AgKi8NCj4NCg0Kd2lsbCBzZW5kIG91dCBWMiB3aXRo
IHlvdXIgc3VnZ2VzdGlvbnMgLi4uDQoNCi1jaw0KDQoNCg==

