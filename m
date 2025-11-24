Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB291CFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FV3IDdVqJ0SwcirUpY/q/9Az6xFauorcLCzvzCpT+s=; b=Jr46yI20PdOcv1OB68IUeGXue1
	7YVkyAekIBLDNaPNius/ZkN7+9Tq4OZdLhbSRMGe2P+Sj2POha5P6EV6zHEN/RWVmRI+9STjWlm4g
	XvSnX5INqlwuxfMxYLrQR9rKcGoW15fLEVhUNsfx9b5iBUS9P+dnzQ0HJtPtNhcX2THNP9tFlFD+G
	NejNf54UZTLhckUd0GCqsWgp417GVQk6B8iEgnK4aogyXboj/hSjMDdI4oxnRrTmPktdTalOWx3Em
	IJO1fWkquKYpbwt2ORBFSdRYa2yXj0JaN7JYdk7xOrP3d7GonoByKmN/28Oi6VLKzCSP+kA8PG+j9
	BSN1/9xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQKx-0000000BBIs-2Wqx;
	Mon, 24 Nov 2025 06:46:11 +0000
Received: from mail-westus2azon11012057.outbound.protection.outlook.com ([52.101.48.57] helo=MW6PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQKr-0000000BBIJ-1N4X
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s28+MpKt1eyAfgTRxbZAQS3WbVWGV6f5Z8A8hnwxLRbkuRtRfhY7QMKLTOVqPjxKa6fY8NtuOm/SOA/Woe6G+7jLjTHPUp39jE5nTQploBbYTkFuAi3OVsr1jsmcoz9t4cThxFXQOt1/EFZ645Qmgf7RIkqRMbd7JCdUG1jaGNpCkUuSMvgF8AvDxbmIZVSkJ2WzE8txYWtKjd4qAG0smD8dCpGVD3sQMXsE/Alug+BgSgfPmj2FJF+KsPuKZ78jJFUizAXHjzKxKitQLYS61rvyBQ20/DUbmBE1JBgancSXa2Awp+X20uuwZE88Qd6Z0sTm7bA7+z6iibwWkMyl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FV3IDdVqJ0SwcirUpY/q/9Az6xFauorcLCzvzCpT+s=;
 b=Sh716CnsKoa/jt/S20Ir24ytQQ2NJ8PXP8/6bvmX3J1Hdhmu0sxK2Je0dVPtk1WS7F7m3mGXvYZulRZ1EnimWYIAq+oYZ1ygnT9GHRsvZF0GF6Auo2UBE7j1fuiz/KAtxhahrTAQmL9Poh75EJgNHGqRX+jpIPSeHbG/kRP/vzHgLOTOkHHhBH2pTCKSdXvv7R2TbghE0LrgZJLyQJUri0dzjOGiyqJ6Wei9P1EM1wMl8ChffQvdZvdS9r5q4NPl1aOMa48ZZ/t0h/SlR6YlDbEGs8YyLChF36+QLhEjfJib+IyettxlNqkrpjxOrXplmv63g2oRpEieuQ+SZ3s4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FV3IDdVqJ0SwcirUpY/q/9Az6xFauorcLCzvzCpT+s=;
 b=svdn1x5cFnz4Zr+yXXJFZBxyb9KOoP8KCOC79bvaAwd9ZMIMtNA0zFsbu6ZPJNoea/8HqQrF7IPBZzlqqXy2sXYxluH0n94JXJU/sojcTv6Sp+n0zao6+bMZiNYMKzhPzujAxeWEHJ2YsG8uOZWuUVNyuwr6Qha4MeF8NTu7300O847dfCeQhBmOIXUZmcj5IjeLYdE0ga1jEXpQlkLWWy2ocfWedC30uDmDYFnUGHkhmOagaq3nghMYWINKOLv6vNGxpuYbYyDSbl7eP32eEZhqIbqNMLD3SQIHX05Bz6wRMUGEjmhFkXJ+qxDo0/7oFx0P/GFHhv44FO3uDTnhSQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Mon, 24 Nov
 2025 06:45:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 06:45:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH BUG FIX 2/2] nvme-multipath: clear BIO_QOS flags on
 requeue
Thread-Topic: [PATCH BUG FIX 2/2] nvme-multipath: clear BIO_QOS flags on
 requeue
Thread-Index: AQHcXK4ZbI66GpY0AEeLtCxjsbBP1rUBXQAAgAAFngA=
Date: Mon, 24 Nov 2025 06:45:58 +0000
Message-ID: <a3159403-7344-4627-a413-f289a313c12a@nvidia.com>
References: <20251123191858.69957-1-ckulkarnilinux@gmail.com>
 <20251123191858.69957-3-ckulkarnilinux@gmail.com>
 <20251124062552.GC16614@lst.de>
In-Reply-To: <20251124062552.GC16614@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7146:EE_
x-ms-office365-filtering-correlation-id: 9809587c-d2c8-4740-d3f7-08de2b252027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?akdCb1NnQ1BaeXNNU2tkQk13RUR2MkZ6ODA5UHFsYWxIK2JUY2VUM0xRREpY?=
 =?utf-8?B?NjRjZXZTSktqZFA3MjR1dWpYMU9mMkw4d3BaQnp0WUVsS2FsNkhWOUlINksw?=
 =?utf-8?B?bVZ3NjIxUFlxZGNyQVZSNHQzZnVsVGY2L1cwSGJ5UVkyYmVUVytobCtPTTFW?=
 =?utf-8?B?dG9BcTNzLy9yQ1YzaVUzeVY4RHBhL3N4Z0F2UVZSNVF0eEtPY3pQV1N1Y0hE?=
 =?utf-8?B?ekpTajRNQVpEVVRFRmRKUXQ3a2pIeVVyNEtZRjlwM1BUcHFNZmVhYjQ0cS9s?=
 =?utf-8?B?dUl1Wjh0WE0yODQvNTNqbG9JRTQyMFZNZjRmVjZWYU4zT3ZWWG5GdFhMRzlw?=
 =?utf-8?B?bnBMMU5JMUFra2FiZVFRdGhVTXVUSUs4bGFFbEMrWmdiWDdETHFvWnZTK1lG?=
 =?utf-8?B?L3dsYkRRZ0prSG1uQmJNaGRFZThNZUlFekdvOXd3S2xJSS9IS3RYTzRhaVlH?=
 =?utf-8?B?MlBQdTVsSWRHNjRYK0E2STR1bU5kNFViejdpWU5RbkFDY2IvdGwvY01tb3dq?=
 =?utf-8?B?amRtMlJRUk1qSUlnaUNnZHJrYlJRZ2dlN0FOY2tLWGdtK0hhRlZ5MGVodDl0?=
 =?utf-8?B?aU81SEdsR1E3TnVTRHcxYTAyN3lMZWZBUThBSUhyMm9ub3dyblA1djNYSFJx?=
 =?utf-8?B?MDU1TW4zK1hyNlJnaDUvbzNsUTZFY2FWQ0R0Y3JvSFZiQmk2TDBPVnBUTW9t?=
 =?utf-8?B?QnBPcGhNU1pqTGFsTXJJeUlWblhLZVhxcnZxYTRIYzZYMkVvQzRpNjczRGlI?=
 =?utf-8?B?RVN3ajl3VXJDUStlK29YbnBhNC9mVEVlL0dzd3lDTmh4Q3FHa1A4ZFQ2RUNP?=
 =?utf-8?B?cExXMGFvWXBPMnR5ayt4eDBvZ00rMVhRcVJuTm1CZmJwSko1RENUMnFTM2Fk?=
 =?utf-8?B?RDRNb3BldUl5cnJWMDJzeW5Ia2RmTzNYUk5RQUpoRlpGSUxJbzZwS2ZuZFhH?=
 =?utf-8?B?NzNuZnlIU0U5eHQwdHlVeHFOWGdqYjNISVZ2TldhMFNwWkFPOVlDNm1MU1k2?=
 =?utf-8?B?YTJSeFRyUGhXbTBJZXhGZ2VrSlhtNWxQOTYwODJwMGRWOTIvRnZ1bFlDajgy?=
 =?utf-8?B?NnZzZEJYSVgraGVoL3JGM2RUOENPZE1VdVJoMExiZURja0p0dHBEM3pENkp3?=
 =?utf-8?B?bXZjRUFTMExiMFNNbFYxSFROT081dW1vOWorOExmRzlERklZNVVwMGFHNnRr?=
 =?utf-8?B?U2FFbFhIckpwQ2dWMnpLeWtyK1FJQkUyOHJVMUx3blZOVXlDKzRRdXhqOWFk?=
 =?utf-8?B?YzVKSVNhYXZPQTBSR2RqTERIdFVpL1l6ZWZPdlRaZUlrSktTcnZzVXpOMkVx?=
 =?utf-8?B?OW4vd3RvVkUwaW9EMWwwV0QwY3N3eitjOUFDanRWdVY3OUlYV05vSFYvN0NV?=
 =?utf-8?B?dmhlengvYUV1ODdMa0E5YkI1S09taUg0K2lHZFB3QmtHWTZWNTN0Vkx0QTgx?=
 =?utf-8?B?YjdPM2ZKdGd4eE9TZitlcnBSdlMyaWFwU3JhRzA0T28zLzJLbHFqQXhMbzk4?=
 =?utf-8?B?aE4xZEZhdnJYb3hNd0RSRU1ESEo0dlNnY1c1TnpBbVJZeE5IK1BxSnIrWmN4?=
 =?utf-8?B?cnRWZXp0Q0F2VGpiaUF0Yy9wNjNYdVZ4NWh4allqbVoyOWhpanNCYmFVa3Bz?=
 =?utf-8?B?eStZRDBRWVFYeS84bjJ6RlJKVFA0aVpuUzM2RFlXU2JiMlBjMTN6TTRoZnhB?=
 =?utf-8?B?cjRRTVA2K1dQWUFrb2xGblVBczE4R3gvalFYTWpRMS9mbmN0d3Ywd1ZjSzBn?=
 =?utf-8?B?RWpYQ1FyOE1nODJ4TUloSXNzY1hLZi9taHBiSmZ6bjMxM2xvVWVRQ1lFQjdl?=
 =?utf-8?B?KzFMWVBMSW5JMm44WlNKV1c5cll6SVVJVExCQWJwREgvd0JOZmdac08yb2dI?=
 =?utf-8?B?QjdhR20rTzVqSlAyNzAwclUvV0VrbnFvUUVlVGs0K1RZUElraDFSZDd1R0lr?=
 =?utf-8?B?aTRIMjdUVXExRWpTR3lnSDEvMWNHUzJGTnJGZ3hCNXc3K1NhcjRYQ2Ivc0lk?=
 =?utf-8?B?SEJOeHFmc3ZPYU96cjluS1hNL00yQUxDT3dmNVZUemRzRE9pWkY1dmRvZFFG?=
 =?utf-8?Q?dAIrB/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFlVUVORE5oaEZ2WGRJQUdyejUyYUNUTjdnZnRCM1hIY1pqekZ6OXk5UzJa?=
 =?utf-8?B?c1M5Mm9obDFkdUxINW01VCtXUkRVVFN2RUJjdENSZnMxYVlsY0hTWTRhZjNQ?=
 =?utf-8?B?OGdkd09WY24zenRTK0hjbHhvZmJ1MUMyTmxJOGxXVzZBd3ZyMUduM0ZrSlow?=
 =?utf-8?B?MTUyVmdiNmRDQTlKVXZuTERuYXN4cGpTVkJPVVpYbFlOaEROdGZuZzVhQ2N6?=
 =?utf-8?B?Rjd6QzRMeDlCT01Xd0RrajNsZ0FmU3RDRWs0bVcydy9LQTZNNTRYL3lyN1VE?=
 =?utf-8?B?Z3RNbUJXbnZCa0l1dDdBdzZTbEJQeGdycUdSRVFXcmswcktVQklNVTcyU1lr?=
 =?utf-8?B?TzJaNGsyd2JXNlRSK214OHNsY2ZvUGhVaWZ1a0svWDZ1SWhmKzBwSXFPY2ZU?=
 =?utf-8?B?aktFQU0xYmI2VG1oanRLbjJxV3YyaExqYUttbmVIbk5kczAzeFdxa01oUmEv?=
 =?utf-8?B?K1VkY09ueFYwYXR4YktvbnhwL0QxV3B6RG1UbjVJYVo0aDdhNDl3S1piRHpo?=
 =?utf-8?B?Vm94a0cyandMaFhyVWJhNlhqdHlZazYyYUtKdi9hYnNjTzdGbHNPQWpPSXRN?=
 =?utf-8?B?K2tkOXgrTGdZSzlsbHNCUC90aUlGRDlkQ3QyYjVMWklCZzJkakNmak5hRkFj?=
 =?utf-8?B?elFmNGpiS3BlM3hkVE9Fb1gyR1p5WmpHMkVCMUNKQ2tkbEFjQUV6RGRGQUFn?=
 =?utf-8?B?QU1RY2hqekEvdFI5UTd6Q0NUOThvVHVheC96eXV3VXhwWWxHb2Fpc0pzUHFy?=
 =?utf-8?B?RzltdjlET1FHdmZVZ2s0T3VpRENqcGQrQnpuQjd6VUJ1N0gxcHNhUHNCdU1y?=
 =?utf-8?B?VTljQng4L0RsMUhCM1FCdnpZVk0yNllVT09lUEZSOGVBSFpldDlFZUVSQlZH?=
 =?utf-8?B?eW5PQW9RM1Jpc2MzcmlJak9vTG50WmdsTG00YitPU3V1cjR2elpNS0s3NjRD?=
 =?utf-8?B?eG44K2IyTWZRay9IQ0xOemtmZE5DcFVkTXdzNFBnWE9UQkdUcVRDZFRTaHdi?=
 =?utf-8?B?aFNDb2twUmlDTTJSM2JaUUJNOVU0N0lSd3hPeTZacmpsdU0wZExpV1dTVldh?=
 =?utf-8?B?TzM4aWdCTzU4RkpKZUQ1YUlGWDJMbldPNjRPMFN3MWtZcUM2cDl5TmwxNXk1?=
 =?utf-8?B?eEJwa0pvaXl3YUFQSDRveFJhOG15NkpjczVXNlV3WGkvS1lLT1BGUzg2Q2gr?=
 =?utf-8?B?OFNmd1M3YVh4MDBZclpGcXhjUk90b0VsUWJCa3ZpM2loRTBnd1YwVklnV2dG?=
 =?utf-8?B?VDV5TUtyaldJeEp0SnNzR0tLWDBVbW0ySzI2SU1oWmR2SWh2M1lYQTBxSzdy?=
 =?utf-8?B?M002ajNzRWNCQmxDa2E5NmVVNDF5OUVRYVNSOVNFbFdub1UrV3FBYWdvVHdn?=
 =?utf-8?B?YmlDd3lRc2Q5ZWdYbVc3akc1bTRMc0FzY0M5N1M3VGxDZStlcTF0WFR1NnIx?=
 =?utf-8?B?VmgrK0lKOVVHeG1wbldBblE3ckhjRlJUbDQwbDBrWlRBWkRPRGdKMlE4YlA1?=
 =?utf-8?B?N2liNFVvV0Vrd2dhWnBxRGJPUDNxQ2tZbW42d3VoSlgydXFDL3ZFV2tDVTM5?=
 =?utf-8?B?MzF3L3B3WHN3ZXZ1ZjNRalltWGlCbXhMeEdvUXNTdjg1UWRTeE9YQ3NTNEpN?=
 =?utf-8?B?TnZQOHVLTXhZWnpPOXNaSHY1VlRSbUJaZHNQNFhONEp2N1J5UXh4VTNpRlhE?=
 =?utf-8?B?S1JuVjFMaHFHWmkwNis2QlAxMXNrWEx1b1ppNnVpUWZpNEZxc3owOVdWcFB2?=
 =?utf-8?B?cWlzWTBXc1B0OGF4SkJ2V0Q4WjhZbm81TzBIWnZkclg2MFlxNFRpQ3luUnVJ?=
 =?utf-8?B?NkVLeWRlVG5JcUxKVmtIdXJ1M3JGcVlXSUxvOGZPbk4yQUVCblp2aFNnaXU2?=
 =?utf-8?B?QnZhalRiUFJlc3pEaWRPVmwvMDd3NXZNell2RzNucDVrdmZPVzMvVVNwWUhC?=
 =?utf-8?B?RzZkR25haDNhdEVnYUlCNkoxblB3NjFSZ1dibUNaaW1XYWl0MmQ3Mm1BdGpZ?=
 =?utf-8?B?TTh1dFdpb0RJNHBiOU81QytxbXMrdU84S0ZUVVQ1bmtqUUlERU13NUVlV2xS?=
 =?utf-8?B?Z3pQNXp6Y0ljWXNHbWt2R2t0T0ppRFI1OHNoK2hJRitDUVpxZXdMdXlKTFp1?=
 =?utf-8?B?d1BvYkNQYjZEWUtNam9IRnZsdHNVQ2ZsWWZXQm9RaTBiN054eExPLzZmdXdN?=
 =?utf-8?Q?sobYIRS9sf8AMPSTGGlvPYSkkEoEvJybdmkRezhJLF4f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AF14AD3CCABD946960DD03852DA0B44@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9809587c-d2c8-4740-d3f7-08de2b252027
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 06:45:58.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avv9Ko97wvDhrXvjrLIdFGJe2/DfaQL7sndyltPkGWY0d8YbRTuJ6xX68KgD0PgD2Ha01aMmpt98f9+yF+grOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_224605_551955_5AE2481D 
X-CRM114-Status: GOOD (  17.63  )
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

Pj4gRml4IHRoaXMgYnkgY2xlYXJpbmcgYm90aCBCSU9fUU9TX1RIUk9UVExFRCBhbmQgQklPX1FP
U19NRVJHRUQgZmxhZ3MNCj4+IHdoZW4gYmlvcyBhcmUgcmVkaXJlY3RlZCB0byB0aGUgbXVsdGlw
YXRoIGhlYWQgaW4gbnZtZV9mYWlsb3Zlcl9yZXEoKS4NCj4+IFRoaXMgaXMgY29uc2lzdGVudCB3
aXRoIHRoZSBleGlzdGluZyBjb2RlIHRoYXQgY2xlYXJzIFJFUV9QT0xMRUQgYW5kDQo+PiBSRVFf
Tk9XQUlUIGZsYWdzIHdoZW4gdGhlIGJpbyBjaGFuZ2VzIHF1ZXVlcy4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNrdWxrYXJuaWxpbnV4QGdtYWlsLmNvbT4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDEwICsrKysrKysrKysN
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0
aXBhdGguYw0KPj4gaW5kZXggM2RhOTgwZGM2MGQ5Li4yNTM1ZGJhOGNlMWUgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYw0KPj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvbXVsdGlwYXRoLmMNCj4+IEBAIC0xNjgsNiArMTY4LDE2IEBAIHZvaWQgbnZtZV9mYWls
b3Zlcl9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCj4+ICAgCQkgKiB0aGUgZmxhZyB0byBhdm9p
ZCBzcHVyaW91cyBFQUdBSU4gSS9PIGZhaWx1cmVzLg0KPj4gICAJCSAqLw0KPj4gICAJCWJpby0+
Ymlfb3BmICY9IH5SRVFfTk9XQUlUOw0KPj4gKwkJLyoNCj4+ICsJCSAqIEJJT19RT1NfVEhST1RU
TEVEIGFuZCBCSU9fUU9TX01FUkdFRCB3ZXJlIHNldCB3aGVuIHRoZSBiaW8NCj4+ICsJCSAqIHdl
bnQgdGhyb3VnaCB0aGUgcGF0aCdzIHJlcXVlc3QgcXVldWUgcnFfcW9zIGluZnJhc3RydWN0dXJl
Lg0KPj4gKwkJICogVGhlIGJpbyBpcyBub3cgYmVpbmcgcmVkaXJlY3RlZCB0byB0aGUgbXVsdGlw
YXRoIGhlYWQncw0KPj4gKwkJICogcXVldWUgd2hpY2ggbWF5IG5vdCBoYXZlIHJxX3FvcyBlbmFi
bGVkLCBzbyB0aGVzZSBmbGFncyBhcmUNCj4+ICsJCSAqIG5vIGxvbmdlciB2YWxpZCBhbmQgbXVz
dCBiZSBjbGVhcmVkIHRvIHByZXZlbnQNCj4+ICsJCSAqIHJxX3Fvc19kb25lX2JpbygpIGZyb20g
ZGVyZWZlcmVuY2luZyBhIE5VTEwgcS0+cnFfcW9zLg0KPj4gKwkJICovDQo+PiArCQliaW9fY2xl
YXJfZmxhZyhiaW8sIEJJT19RT1NfVEhST1RUTEVEKTsNCj4+ICsJCWJpb19jbGVhcl9mbGFnKGJp
bywgQklPX1FPU19NRVJHRUQpOw0KPiBUaGlzIHJlYWxseSBzaG91bGQgZ28gaW50byBibGtfc3Rl
YWxfYmlvcyBpbnN0ZWFkLiAgQXMgc2hvdWxkIGJlIHRoZQ0KPiBleGlzdGluZyBub3dhaXQvcG9s
bGVkIGZpeHVwcy4uDQo+DQo+DQpldmVuIGJldHRlciwgc2hvdWxkIEkgc2VuZCBhIHByZXAgcGF0
Y2ggdG8gbW92ZSBleGlzdGluZyBub3dhaXQvcG9sbGVkDQphbmQgc2Vjb25kIHBhdGNoIGZvciBR
T1MgVEhST1RUTEVEIGFuZCBNRVJHRUQgdGhhdCBmaXhlcyB0aGUgYnVnID8NCg0Kb3IganVzdCBz
aW5nbGUgcGF0Y2ggaXMgZmluZSA/DQoNCi1jaw0KDQoNCg==

