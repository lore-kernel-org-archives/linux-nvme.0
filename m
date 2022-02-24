Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0FBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtKRQNKjE0Mee1gaaFw5T4EKaX0sV7hYfqJAFU7GECA=; b=0y6Hqd55CUb5II0fn1VBIJyeCQ
	5TgFUn+PIlKmL64B7HMzYrH2x4H4V5vID+6hp5AHganmqj1nWgkDtd1BDaG1808nVqnrleM/7yUsW
	dfJQAokWaYZ+cshJ9IEiwYw3aZr2l9hdg1XeMlfV86SQ9QKwn2VFTC9Rv2sGyoPxuMwwR5daxMGCQ
	OtTar5Wj0bvdcZDJdJfZvlIyOvFh9bNweB4f+lkd+7gA1c1IhosMF6ANvvDDrYxVK3JyXYl5LCPDa
	w8ABo+1WDT5+nXWuyh9wafIgUrBxRuJLgzYa9gnLTAL+hVH8qX6FA7UD84Uru8AIBd40I+E+hoASX
	GVVxk4TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNN0n-002bPT-HE; Thu, 24 Feb 2022 22:55:01 +0000
Received: from mail-mw2nam08on20609.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::609]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNN0k-002bOk-SI
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 22:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko00vC0+AJTt7IzTLarllho92DG8BRfgd9D+vsFj8/azbB1ATWy0K1CSzVIUNh56U2DLTi788Iov3Qg2MPcdn4NHcucn3YF2cm7d6nd9JrMc5eKdf9dFdvlt7SHHyyVpd8HScm5JaVrPcfyazC/llJB3JuiSUlZLmGjtD4FjyPf0MNEu9Qzh7ClNLCHXbFSwKnRzY9MDq3pzRJOc/HDTdMJ/LdRE/aUYRy+0d1WUQ2C2MnP1FkbOGGVWXLhvppE756R8cdKWYARgFVyElAtZh5JtnO0cAMzPSnO/dj+ARNqiJ6oSGHYJjdmhmEEgHqlaESHiukL/b5XdYvFqLxMbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtKRQNKjE0Mee1gaaFw5T4EKaX0sV7hYfqJAFU7GECA=;
 b=ZUiHoqAnTxk4cBiDDHSVxl4nqKII8GW2R3kjqJ2hg9itDW2jRgnWS+m6u8bHbUx+q64VIDZCRQa7dplE1cXWNiypt0nvJ7A9CGLGOF8S1INhzdP7Rj+At6Zn5QjafQap2FerKA0GKVCIAocmKxaCj5NlA+nAQtzzf9Zi5vbG98EPESjLq8xTrwexisZBSOUkhYwD7nyYEnKX0NtUIG1DcyI9eV+z0ULqfdz4EIbVN4hgNIA/zKTAUHXb9RtS6cyqxiu0EpaSG951IgVTGITNLJBlM2E4dZFxA7ZUnLpRjPvNcWoGWa42E6cv/DiAbIewT6h0DSJEApMsXjgyXAso/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtKRQNKjE0Mee1gaaFw5T4EKaX0sV7hYfqJAFU7GECA=;
 b=NCNRJ2m2RT5YQGj3lxtNI/VSF87h8wPlXDlKE1NVvf0N48h9SOzJqnvVTRQwr5WSSMfncyyWj9/IPeM9erPYIOrLGgWu9ujTKzryw0I4D0U8Rx2t5prnM1P4xJKQBYvgu1u8RstHoCXJAzIA8S5FvgzhgS3iHBjwOC7hbDhN3t1C5C7Byrw5JV6ZU0T5regZCjhN+DI4DgXRoptrAnEzQbYDxousS8WYKcOr45ScAd5mfRrAIF2z02Oguw3NjlLELx0BRP6jwJNWOGWv4+URxa/R4MhxuR6S1ktcazmvQcycFwdGWc3fa7QIWchP3TpgKngJg5IQPIh/MD+qXe0eRA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 22:54:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 22:54:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index: AQHYKbU5emTG9og65keigbS9X9lVIayjT6eA
Date: Thu, 24 Feb 2022 22:54:54 +0000
Message-ID: <5ba88aff-f417-9880-7d88-76d68091d8c0@nvidia.com>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de>
In-Reply-To: <20220224192845.1097602-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de621a77-47dc-4a86-91bc-08d9f7e8ac14
x-ms-traffictypediagnostic: DM6PR12MB3147:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3147C4D81264E8CEAB0F7656A33D9@DM6PR12MB3147.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4P0iJbakG+XbwSfQ6UULG4sSDC0RNVoHaL8WDSaQSyN157IinHNX30/pZi1VX4fBr7eaHK6WzkE1RzAKUUplxSI/BgIwst6mmvvOGCt1TF8pbcBNTd2RGQvEcJPjKTHgPUarnf/vHa5vi3Z7mdiq97XvEk4BcFso1IEur/gaejjLYoTXNr8BcGcMo6hsxhOwQ8ZJLEYunoXZbPVtWlwUYQ4+j7zMtdIMPTI7VZyMWwiwLzQidGctDqc+2VUKKqPxk0CZ+S7QHvaDHsa+Gmy+DQMXfHfLjqop5wyW7HrvzNMVMwf/ChZ4kYlUi1HisxyY8OZF6jSC41grzYWq5ewMwwoY2FIaIJ4niI8+3XsnTHhuk8kHk9v4w1vgURCoEf/e/vGcwOvTowaH2t3D0OKnTo6vjPtpW26EbRhJI5vJSZA85cs78B38eS0iieVaWig0r1cXGHxtYV2G+3/AjGO7IDbMszWOWXaF03cTkKTOrZATcf8frcdaofyygDL/38rFTS4AR+amWcKEaap76WyKTBpHHXT1oXyVHIKopGmKb/sNT5FWvPCm1CPm3BDmlKYqzmTpKv/um0Qrq0euFr8LJt48pUjkDnrJ6QR02e7iTbbuKqV9fmLF74htFRTltQIddv13Q6JB+EH+aQ8sGA8QRMmMoW6itJRNwGbfk3iC+7FNSz7Qqo3icuR85bpbTplOU/ucHHcaR78J4GVxpDu/1tGSOuw4lU4Evg1rGIoQYvzs9oQ6dps+GlJ9lzZdhkKiz5OfmVf4jz3llPdCSOTrbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(2616005)(36756003)(6486002)(6512007)(83380400001)(186003)(2906002)(71200400001)(53546011)(8936002)(5660300002)(86362001)(31696002)(6916009)(316002)(558084003)(54906003)(38070700005)(66946007)(66446008)(91956017)(76116006)(4326008)(64756008)(66476007)(66556008)(31686004)(8676002)(38100700002)(6506007)(122000001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlVtaW1yOTVXZVNpemFIeXZpeXRwNUdoTEkrak5WYXU1dHZ0S1dZUjZyNG5s?=
 =?utf-8?B?S01jeEJHNjJzRDQvOC93K3ordDlobFgrR1YwZllpbWQwZUJKU2p1T2dubTZN?=
 =?utf-8?B?d2xnVWFDbDI2LzFVZXF2dDl1UWJXSDJMSjFEMEo1TzZ3QytiUXJTOHc4K3ZU?=
 =?utf-8?B?ejB3TWRqYmxLZkNiV2ZOSzFNNjRhc1hncjFWdERuWU9zK1U0eWU4Z0d2RTBB?=
 =?utf-8?B?Y2hzVVZRL2dhdGhTeDVFclVzdTdQb2xIVVJvc2xBckswK3NEMUh4VklLMVZO?=
 =?utf-8?B?MDl2UW1YbXpFYjJiSFFsUFRUK0hZTzF6NHh6eS91bW9zcHo5MTJMWW11K29E?=
 =?utf-8?B?RHMwV1RQOGdQNmNhK0FDSkpNL2x3TTRLT01JWW44NmMzRkhsUU1weGVOQm0z?=
 =?utf-8?B?NFZVYmNnS2FxUXNNWmVHL2pvcmNVbExCb0NTaWEyWEEwa08yWlR4THBUMHNI?=
 =?utf-8?B?ME9DVFBxQ2hQY3gzaysvbzUxa1JkVnI2Z3N3dU1TR2lFYk1jZE8vNkRCUEJu?=
 =?utf-8?B?WWsyWi9LTlRIejVLQ0VzMU9uOW0yS2NDZXR3c0tiNlpnQjVXTU9CSlkyUnNp?=
 =?utf-8?B?aE5DWEJ0NjdycEN3aFlUN0lGSVJManFsbmhpODRQZlVtYWtoTDZTTUxDNVdW?=
 =?utf-8?B?ZC9rM0t2MEtLZEdLMUJ6TTV2YnRySm55ek9iSGNmcFVKWEhjWXlLMDdlUTZP?=
 =?utf-8?B?cGVqSzRad016WHdIejZVMDA0UGtMQUVWV3UvMlN2QjkvRjZXdXd1Sll1NjVM?=
 =?utf-8?B?VGpQSlprenVxOHloS3NRT0xmR2R5eDh4VGlFVUUva0FtY3VONjV4ZXJmOGNR?=
 =?utf-8?B?cE1vMTRGVjdsZ2x6T1J1S3VtcHF0bE9lMWdpMTh2QUtJUHhNUEJVTEJrQW05?=
 =?utf-8?B?RGRGbm55S0pGUythYzhCZ2pybi9XQzRPMzNPTEVoenFHZkE1c0xLZHNlV1Aw?=
 =?utf-8?B?SnBVNHdVRWpmMU12blpRTUZiUXFEOEd5RXJHaDI1aEM4bUdYWW1yVUpHVTI0?=
 =?utf-8?B?ejRidE5neng5NHpUYVdUckkvVFhFbEtIYmc2OUZBUHJzNTBXMXVYTG91YTZt?=
 =?utf-8?B?VDhyMFU0V2ZWZjNGMDkrTUowMWFScXRwNC9KZDBoQ0lnc1IzU0JIUlA0V3U2?=
 =?utf-8?B?ZmtLRFB1ajB4OWtsV3cwK1UwNXVhN01jcUZBSWRTcURoRllQTURPeTVrdHFa?=
 =?utf-8?B?VllBeUxUUGc3R2lDUi9ISmhHV3Jib1lzd0d1eUxSLzdMM3MyVmFIWWFCQlRU?=
 =?utf-8?B?dVp1ajkyYTVWVjR3WkRMRzJvVWlraDVIalZtT3BWQTAwRmMzNkZDSlhaTVZT?=
 =?utf-8?B?UUtGMWxEQi9YaFVYbmRPUHhRS095TndMemtZUG4zMHJCMkpDd1dmZnJ5TFkr?=
 =?utf-8?B?Mm9ndEdWWmpnU2o2VjlvMHpUUTJHMmV1V09MY1pGMWZZaVQ2Y1JMMkUvNGVN?=
 =?utf-8?B?aWJDcG5mNFhUN1lTbktWckp3SE10aDltdmVncEg2d3MyeThGNis0OTlTbzdX?=
 =?utf-8?B?UER1NEZibGR5RFRsL0NoN2JJdGxWekw4b04xTUs2eEw4TG81dWIvZ0wxeUJy?=
 =?utf-8?B?ZzYybko0K25Qa2Y5bmtkME9CYVQ2Qmw0L2NVeGZtZUdSbnBrTjdEVWxsUjdt?=
 =?utf-8?B?eGVZTXhJNFh3UE0wL3hNL0xiSGl4WVVxMTI5Z29oVzFhbXhhUkIvbGlBSTgw?=
 =?utf-8?B?ZGNyT0piRzZMRVJPeGg4U05ZS0FsQ2R6VlMyb3pvaFdCKzhsNmpsSzRYbjVl?=
 =?utf-8?B?bWZnVmFhOVdCZmhRMUowY2xuSjNLZG4vY0FGczUzc0RkcGtQK0ZFU3VWQkJB?=
 =?utf-8?B?Z3R2d1ArZG4xaktUWjNRR0Naa3NvVGZmRGI2TllIWGFhSXM2UFhtVHZoRlFv?=
 =?utf-8?B?REEwMzRUSTBCYU1YWnl0ZlpiYjJ4bTBsVERUSk11QkVqZTd3djdrc0IybS9m?=
 =?utf-8?B?d1R4aDN5Z1ZyenRqTXNKTGV4ZFlSUGI0ZWR0T21hQkdwTU1JdGY1cjljQW9o?=
 =?utf-8?B?ajB4bkRpQjB0aDYwWXdQMkdsNkd2ekRDM3k0VFh2UTg3N2RPRjBlR0JLS1Zm?=
 =?utf-8?B?aEtIbVN6TVc0Q3d6OW5wMi84YVVRZEpHME45eGQvM2EvcGV6Q1Z4VmpIWXY0?=
 =?utf-8?B?aFZFckZtSVFxbGVRTDYzYzlqZUE1NFVCMjZka3V3N0ZxeXdRdDhLTnNIL2Y3?=
 =?utf-8?B?cnhNL2NuSW4zQys3UXR3Y3JwNjJGbDNubS8zM2Q3N1pzbzJTbTRGY01hS0FM?=
 =?utf-8?B?SWVLd1hGY05SVWNiUlI1ZE9lelRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAECFEA51094CB488C2A7E8907972D86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de621a77-47dc-4a86-91bc-08d9f7e8ac14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 22:54:54.0200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEulfVJcCLwCUYG7nga7wnKDUSFVyZ5uvEoU2qaRhdqDwU6n3QWPgUIVhCU/1h07lXfsEN6aIE4+BHMv/ZEZbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_145458_942937_A38DB21F 
X-CRM114-Status: GOOD (  11.85  )
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

T24gMi8yNC8yMiAxMToyOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGNoZWNr
IHRvIHZlcmlmeSB0aGF0IHRoZSB1bmlxdWUgaWRlbnRpZmllcnMgYXJlIHVuaXF1ZSBnbG9iYWxs
eQ0KPiBpbiBhZGRpdGlvbiB0byB0aGUgZXhpc3RpbmcgY2hlY2sgdGhhdCB2ZXJpZmllcyB0aGF0
IHRoZXkgYXJlIHVuaXF1ZQ0KPiBpbnNpZGUgYSBzaW5nbGUgc3Vic3lzdGVtLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KDQoNCg0K

