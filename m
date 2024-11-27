Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7296ED609AC
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WfFmsmqYBs16lDBI4c9parRe5UDItWx4RcJPH8QDF6A=; b=akOqVPsC+U7bqaMhSfl1tuHCtj
	w/JlXY1g0NvcRo1Y84bzJj8dtPtCXhRBA6sa4Mt4s3Ole2cGQ3VX8qaRHdhNoV7+Qc4OuM8NzLm3r
	kHnvB3poqam0lJG9TRcJmhaz9FDaQGdCjVHcvATwxQgiY4C/k755rbizrqSAGw4ej7dPw8HZIuFI3
	33NEDxzuSL3jZjT+sSBMUkFZJMhg0IQ9mTwrgZUiLOTNrfQTfnIwoApiPZVm4MB2w1wpvlEYAakQv
	senwM25G5s+z+FH6blj+vUVrFdJxxATvz+3Lj68gHM6AugfyRZrv4B5n7bA+fEt6z+gY2I9C0XgAg
	V/b1O+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGCoH-0000000CUAA-2Z7j;
	Wed, 27 Nov 2024 07:50:05 +0000
Received: from mail-mw2nam10on20609.outbound.protection.outlook.com ([2a01:111:f403:2412::609] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGCoF-0000000CU9U-2dyS
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 07:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9T50k8YYYjK2YcMtVbCmWv4xdFRAa1wkymwW8zlBDpQh38UinLbJL4b0IaeeBzZlLD5bmk59PnoMHwvIWAA54YCWC4JegcItICw22DbXdL+AMwEQ6BpuVhDM0rygjgMoHS/EkModtwEWnps7XrGC1PncEcLSALoc8DZV5mV88NDKchKhcXuto2D54UtICa2bBokoy4IEwQlVyttGDx/HFfE+lYuP5H+FOJpgd4h+OI0Gy8+3sJy8R7YK9LT7sc3wBJL5hW5szWQDWeOKKzf3ZG7L8wPY7I/VozNbGuiBemkkfeCKw5AI6T5fme+Obz0IsN9EpgFmldEzfEaDM7VjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfFmsmqYBs16lDBI4c9parRe5UDItWx4RcJPH8QDF6A=;
 b=YH9+xJPJJZzHHPuSXuyY9xB65qofNCcYu1JQv3JQvo+DBD3LdnkGOxM0FnnXOtURBSY8qnczkOX+0xQw4J6SZwToTiXlX95Gj1Tu989WBs1z/JLliVdS8Zmobh9ce5L7L7W6xmEjDybKtxkiRZtFwedzsbEc3LEZMide97J49oI2Cm/rTqszZCISttFLQktuFXDzciu002iZFvu8+StxyLM/Hs83/4wtFlSGNECyt7MCppwHptEeSAVo4oVgwTKlzDYLXtAS5b/z06/XLCvMUnDbmYSCNgnD+c5jS+ww6tr3vCw18m8+krUx7gExSjUSBYRDYpT/0dIKaKXKBsTZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfFmsmqYBs16lDBI4c9parRe5UDItWx4RcJPH8QDF6A=;
 b=XA2DzyVYcNIoSvslGEGbpOOa16WsWBJxP5p0GGR9iS8e6ltQ/tnDFcoQGb1mwaQpb8s+5o4KD6Nia963Wy1fK9I0rzi7r/hDiQyZk6JTHNDvK7tPH8RUj/hS8YtEoR/+xJjaEFCMF6DZF59/U2ah//Q2z1lfF6QOPoQWfAqV2Qac6U/hrYDkID1LglU9jEr/1KvjHJNmsp9mtVilF0tEVeyfv4JJfJzxwLcv4FMJ93e8Jmt2fWoGeohtASuDKIP53M1subD6Cg9zvLRpYPKNSwB+x7mTz14KEunuWaU6cytsDSk7ELIV7JROJFks4BsdpMm/a+k7lgQ3c6DANCgBzw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 07:49:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 07:49:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bryan Gurney <bgurney@redhat.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] nvme/039: check for logical block size of
 test device
Thread-Topic: [PATCH blktests v2] nvme/039: check for logical block size of
 test device
Thread-Index: AQHbP3HV2MctQUbDzku8U6o2gsmw4rLKwwUA
Date: Wed, 27 Nov 2024 07:49:58 +0000
Message-ID: <002e624b-ced9-4251-922c-e41bf5966d90@nvidia.com>
References: <20241125193933.22017-1-bgurney@redhat.com>
In-Reply-To: <20241125193933.22017-1-bgurney@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8768:EE_
x-ms-office365-filtering-correlation-id: 982e634e-783e-4ec7-f0af-08dd0eb817a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDRkSjhYSTBySStFZHB4QnhsaUZSQW05aVBYTEl4emlveDhqdHJxRHNSekk4?=
 =?utf-8?B?NHc2d1lNNE1XRWJpbURVZ20vT0ZaZmUvcUxwcVVubTc2YnVJME81cUhZK216?=
 =?utf-8?B?TjlEWjFJOEpGL1cxMis0R2FDQmdpNWF4SDJ5KzBGUm5JWDFMZHE5ejRZZld0?=
 =?utf-8?B?Mmt1czBRTjhxVFBncndkalpmV2RGc3V0bUhvL3lERzlCVDNEaUlSNkphR0NK?=
 =?utf-8?B?OHIwVWpJNUVPbytIMFZaVGVuWWg2elg5K3NwVHVxeThkZlYzaHVmeEMvckJW?=
 =?utf-8?B?S1FZbmhGMklKUUowQnZ3TUVxdzFxRWRtb0IrSVAzbUNjaUVPSzFLNU1odTZW?=
 =?utf-8?B?QjE5MUpuVS83Z1BMWWRMMmpodk9lNzE3QXlYOHRnRzliWEdZZGVjNUJrZjRr?=
 =?utf-8?B?dVNOUExKT2dqVEEvZGdTeEdsRVhSbVBJR2V0dm04VitOME5MS2R4Q25PNnAy?=
 =?utf-8?B?bHFHTHErYXFWQnZ0ZGpDUnhNLzd0N2Ftc1Ayb2VJNzFMaXRxYkdYQzFYbFJK?=
 =?utf-8?B?MGYzcDE1emlUTURQa3A1QjlkcERZc2REYjBQeE5qRG0xbGNDRnBkNnNFcFFI?=
 =?utf-8?B?Ukk0RkpQZ3pyNW9zcjErZnBvTlhMNi81eTJnUkVNSjZUNFdUK0owRm43MVVQ?=
 =?utf-8?B?YjJXS05wOElBOW5xY1ZadUVBMWcwWmxXZUNuWGNvWmtxanpOaStPMTBmemx0?=
 =?utf-8?B?VXJndWFXNUVnOHlWRHhYUDFhR0xob1NzcGR2Y2JSQUJNbnI3MnlPY09MVUlx?=
 =?utf-8?B?cThjTGRVMWtFdUo0TjIzaTBPNWJ6QWtBbXVpTjRRRXZ3Z2k4bUl0TTR1SG4x?=
 =?utf-8?B?L09WUnROUmhIcjFDOGgwRmlSWlZKZFlMZnc0cnlTVHo0T0lmMTlHK2x4VHlq?=
 =?utf-8?B?Mkd5NXVyZWt4NVlJQ212YVBuaEFYOVF5OHVuTmtjWDVtRHZTZmNKS0VWUzNy?=
 =?utf-8?B?MnU2dUo2bDFUVmN5RUlHNk8raHRHUG9DWkM0aGFxOVpjVGdiNkIzZXBwcFVi?=
 =?utf-8?B?YUVqOFNDWTlvQmV5Z1BuSnBGN3B1NXFlWXlLbldZUENYUjNIaFMrcEgzc1Nk?=
 =?utf-8?B?UEN5WUxLallaakRwRGJJOFJwd2NMZ3VpV0RzZllVVmJSQlJHM0taKy9EQ214?=
 =?utf-8?B?Ni9MUUVXaHBPQytESnRqc21CbnJOYmdlTXdIc2RETCtqN09obHRudnFldUU4?=
 =?utf-8?B?R083SnRmZXoyRUxsTmlSRTBneWxmd0hBSzVhUTBKNkVLc2NnK0Q3WEE3eVJk?=
 =?utf-8?B?Qktnc21oekVKNEROZk82YzJBUVBUYWwzY2lXTGY3SFNiWVFZVEJmTkRiRjJS?=
 =?utf-8?B?Vlp5T3h0SmRkOER1eE1NWWpRSnJidnVZSjEvbmxrZDRQNWwyaElaMkpueXdB?=
 =?utf-8?B?UUZvZzZpTEhZVHRvUFdHWk02K0dRZXlDdlRnMmVmOXdrN1JoVFJUalROOXZU?=
 =?utf-8?B?TnpjZHZ4WTB1bGpiY01LRG5JUE9uL2UxMUFyMEJSMG1nRG1TVzljQ25YMWp0?=
 =?utf-8?B?eUY1V0szZ05tU2cycXhTUVVJUHRmTHM2UGlpd1VFY1RUWEdvbVNJZTlUYmNG?=
 =?utf-8?B?TXBsekN4U1FWckZDVjN4dGMwMjEzTmdkeHVrODRJOTRwSmd1N2FoNXFtajhV?=
 =?utf-8?B?bzJrS2Y3TFcxeTVJaXhoSHJJRk1QcWFzM0lWdWdobVJldVdWbmIwMG5GRmh3?=
 =?utf-8?B?SjZYK2xwS2owRDJkS2pjR1QxTnFtZHd1T25rOEpKU1BIQnNCMFQ5Zng2NElw?=
 =?utf-8?B?VEZLbVFuMlVKV2dJNG93MnVWMWdKV0VvYkFrcjJWTC9DN0cwV0VnNjhJTTVu?=
 =?utf-8?B?QzZQL05Vd1BHODVIbFBMbnh0TVV1NDIvQmpyVkt1NVNsNVpIUDNVQlp1L0FO?=
 =?utf-8?B?blNCL0Q0ZWp6QXVQbG03Z09GSTNsNlg5VXo0MWNxeC9yV0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXhwUmVFY3ZsSGptV2tvVC8yV2lxKzNmejV4aWVpVFhtWHNqTVQ3ckdnZVBn?=
 =?utf-8?B?S3QrSzlrRmU2bXlrRXhlaWEwOHVpSVVBSW9PVEl0Uk1WbFUyeVh0eEUzdFZH?=
 =?utf-8?B?ZVY2K0E4MUFUMm83ZWRDTDNndGM5VWFjOC9PNDFuRUZJWk9SbVhENVBPTmxL?=
 =?utf-8?B?NXpSdzhKZjNzSG5oMEtZSE5UaXQ1dmcwRlJHQXJTYTlZY05USmhaeU9MMUdM?=
 =?utf-8?B?cmYvUUgreXRMYmlnZnNvb2k0RS9tcDdGRU9hWWljMFlXUEJJbVVROTBDbHVn?=
 =?utf-8?B?TUJkRDlUSHlWRjNOWDhPc3BVR1NhWmZ4WXlGZCtZYmRrWmRWMnlPbEk1bDV3?=
 =?utf-8?B?NUpzYU8vdm92cFFabjVvSlhkSHVLZE1oc1VHVUJPMjA0aUdOQVBROWlIQnBu?=
 =?utf-8?B?YVBDemVKd2YwaHdLckdONHgxZ1NyWkpnMkNUNWhYOUJVNUcvNFdVV1hjTk1n?=
 =?utf-8?B?bXZ2T0FTMUR6VnduYUF4dFlDUm9JbW5VTXFRM2RSWFUvUm9xcGxUREhKZzhP?=
 =?utf-8?B?MXc1cWhoNlIvd2ZJdm9vM3dEQjFGVHl1UWZ0RXl1Y2pGUUhDSmgzUG12N3Nt?=
 =?utf-8?B?N1RkZHJ4NmxVbFZEZm1iUTdTbEVMYUhpRlRBUHA1eXFvNHp6WEJCZ0krVzZl?=
 =?utf-8?B?dXBFQUVaUDJ6YTJMaFpQQjYrYXNyK1YzZWpLeDJJTkp6Vjh5VXhGQnY4ZHRa?=
 =?utf-8?B?WGc3cGFJMi91Nm9RUzcwWU9TM2d4UlZ6WFVhWEk5bjY4Q1Y2WTlKVWhzRzJv?=
 =?utf-8?B?WW5oZCtwdkZWcElPVEFkcnowZGdHVXh3cGo5MzFyNldWNHdEQ2xFNDlGMHJU?=
 =?utf-8?B?Zko3YzFiNE45Zm9wcjNSYnhZSmhCcXdUcWl3YVdRaENVL0s2aDRDcGI3ei9z?=
 =?utf-8?B?ZVFCS2JOeVhraFlTTmZBKzAzTmQ3UlBpN05Uc08zZDhVN2s4cWhOeHNGbHJG?=
 =?utf-8?B?RGMzWkRKTmsyRUdlc0J2SllXclRONkpVYTNFcStPOGhJbmNUbEN1VlVZcVo0?=
 =?utf-8?B?VjkycHYxRzYxTmtjeTRXblkwMkpwaVFnVjRBMjZMUVVoL0UxVk9RbmNFQXJk?=
 =?utf-8?B?Nm9uZzd0ZjZ1bDBmQ3BRV0VMdUh4cWUrRGFNUVp0MmMyTjBicEpwYmxSUGNj?=
 =?utf-8?B?WWp4RGMxU25lSHh6SmtzTDJnQngxbFcxdkMwam1UdWVlcTZoUHo5eHZObHdz?=
 =?utf-8?B?VGc3bzFlMHBhUjM4TDZMQS9NRThGMVNReFU3UnQvL2hTbUU5OVNXcWZaUEk4?=
 =?utf-8?B?cjhiaG5qd2VsNlpFQUxEd1RYd0hkQUxSM0JGbkV2aS9wQktDSlZHSW4rbUZn?=
 =?utf-8?B?ZEJYMHlJUmxKaFNTOStDT2RuQ0p0T3U1THBhcVBQbFphTXZXTnk0azc1Y3Jt?=
 =?utf-8?B?TmpVdGkxdlRFRjJUY2JvTW1JRHFCL0R2SUpkZVd4YTZGOEoyUU9BcDg4SDNn?=
 =?utf-8?B?ZjVkRkVsU3c5c1pjaUdKazVqaVZNWVQ4d0ZPaUM5bXVXUERXU1V6YkRwVUhL?=
 =?utf-8?B?L1FNS2d1UmJZSjhpNmNKVUNEZkZhWjA3dXd4MlhOTmlNbUQwbzRCOS9rQlY5?=
 =?utf-8?B?NHZ6c1ZWVHBHcWVodXNVeHk5UkdEREpsK2IvNjZHRnB2NDB6RzA0QlhXdWs4?=
 =?utf-8?B?cUFTQURpbHJuY3JISjdhb0htUFVNSk5kT2MweXM5Vm5Veno2VkFHNGsrOVlJ?=
 =?utf-8?B?ZG84UkJ6V1Rsc2h6WHQrTS9lbzBBZ2RQb1FNeHdWN0tLKzRCaFZFZVJtZ3kw?=
 =?utf-8?B?T0EwRldEMS80bGZ2bHJkWjJFSWlEUlFlZXB6dWxPWU9GLy92bEI2U04wS0Ro?=
 =?utf-8?B?a2c2eUZ5U29RZGMrQkZnOU4xSEpZMmFtbHJBQWpEdVVVR3JsVTk3TFBBYXRQ?=
 =?utf-8?B?NVhwVHdZMG1lRG4zbTQ0SjkwN1kxT0tIRncxZTFnZGl0dmh0SG1PSFBLMFVa?=
 =?utf-8?B?ZDNXOVBKeG1xcDNxTkZpSjR4aHYrMllSd1kvQkNGbjNLRiswZnV0WmI2OERH?=
 =?utf-8?B?elFjc3VUd1g0eDVEL3VuYkZvdFlJOGNjazhkQTRWTGsxVUQyNFpRdXhIdW9o?=
 =?utf-8?B?U3ltRmx4eHA0TEtKcVhkRXJUWHBhUU51N3Z6YTNoSTRnM0pobTA2UjFxb3Ra?=
 =?utf-8?B?TXFmSk5ZK0hySThRV0NOVXIzVndBdkQwR3M3SlYxbERzNG9oMEtoUU9EQisv?=
 =?utf-8?Q?mnelLUg3tbk30E4dHGA19zWCbXfcW3wfyU8BueHfszrR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B225DAC1FB26249AEBAEEC077A26EAE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982e634e-783e-4ec7-f0af-08dd0eb817a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 07:49:58.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VyOj+zKTE6JzAKG4LnAlIFVZkpNQdrBQn5Uk2XHE4fJQEdxwm+Tq6nswRzJstvZ4NW05pOis1i5uUXnAEPMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_235003_672341_DD6B9AA2 
X-CRM114-Status: GOOD (  11.10  )
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

T24gMTEvMjUvMjQgMTE6MzksIEJyeWFuIEd1cm5leSB3cm90ZToNCj4gVGhpcyB0ZXN0IGhhcyBo
YXJkLWNvZGVkIDUxMiBieXRlIHZhbHVlcyBmb3IgdGhlIGRkIGNvbW1hbmRzLCB3aGljaA0KPiB3
aWxsIGZhaWwgb24gNDA5Ni1ieXRlIGJsb2NrIGRldmljZXMuICBDcmVhdGUgYW4gTEJfU1ogZ2xv
YmFsDQo+IHZhcmlhYmxlIHRoYXQgaXMgcG9wdWxhdGVkIHdpdGggdGhlIHJlc3VsdCBvZiB0aGUg
Y29tbWFuZA0KPiAiYmxvY2tkZXYgLS1nZXRzcyA8ZGV2PiIsIGFuZCB1c2UgdGhhdCByZXN1bHQg
Zm9yIHRoZSBibG9jayBzaXplDQo+IG9mIHRoZSB3cml0ZSBjb21tYW5kcy4NCj4NCj4gQWxzbyB1
c2UgdGhpcyB2YXJpYWJsZSBmb3IgdGhlICItLWRhdGEtbGVuIiBjb21tYW5kIG9mIHRoZSAibnZt
ZQ0KPiBhZG1pbi1wYXNzdGhydSIgYW5kICJudm1lIGlvLXBhc3N0aHJ1IiB0ZXN0cy4gIChPbiBh
IHRlc3Qgd2l0aCBhDQo+IDQwOTYtYnl0ZSBuYW1lc3BhY2UsIGxlYXZpbmcgdGhlc2Ugd2l0aCB0
aGUgaGFyZGNvZGVkIHZhbHVlcyBzdGlsbA0KPiBwYXNzZWQsIGJ1dCB1cGRhdGUgdGhlbSBmb3Ig
dGhlIHNha2Ugb2YgY29uc2lzdGVuY3kuKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBCcnlhbiBHdXJu
ZXk8Ymd1cm5leUByZWRoYXQuY29tPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

