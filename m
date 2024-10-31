Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668FDE68946
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 02:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JA9o5BQ8quvOVFEOy1BF8aQgJjRvmy8MPU3cs/fmcD0=; b=NEX5aLzWI8MQjYXRdenD21wRUs
	jVNnhdtodE17yTqmuPKbpy3P02eIowH0n/cAKtrAqrrg6pl8+ionSrQsuTu3WW+aLJBnghG1gd/2m
	TGR1dnrUMZ5vst1sUF1PfJ2foqdFEjRT6pgbRLjZ5iY/X1Tt7/X+PwF9clV3s98mDzBap78fdhwPx
	ZhHVxx3h3pjqWQLIyl0/Vlq1j7WBuZXZnIxQZ5oRme3bkEnowYQoq78Y43Zn0igCkXmusNnEUw4m/
	6Ji1bEtDYbOrtfKag1dc2Lu5i8z8vazPEEhUsWY8XOpRqoMN0sYLVrZ3KTmrRghYhPPysGgd9HPr4
	L+nudbwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6LBX-00000002NYY-1tSv;
	Thu, 31 Oct 2024 02:45:19 +0000
Received: from mail-co1nam11on2062c.outbound.protection.outlook.com ([2a01:111:f403:2416::62c] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6LBU-00000002NXW-0JPT
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 02:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxP3+tRpD2h9MKMLFum0/XL2KpcuK6fnEQJZbxFCIk4Z+H9fmUaST+pHyy4otGXr0rHRyjAuRsqGl3DIAsaDUonSKvuhOxbDWb4hCTpo4I4cgd+JbbM0O+qU3QID42m01Vg0wKswAlL0H+7GY9XNg9tNvHate49XMUSgZHZuWJMht69yUEe3ZBSCkY2NqK7ULgZgjM+hwQjIq+GKvylrFP4ZThDbtIFPrq2r4Nq2OTLMA65O4rncuqFyvoRjdzJ4jd0wrIkb+bh7kAFCAXm3y48b5/ZBNPyMh2g9Wi7hVJVvRkqWluuaSbMFgGNvmkhLnc93CUm0OA1b3kQhwbIeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA9o5BQ8quvOVFEOy1BF8aQgJjRvmy8MPU3cs/fmcD0=;
 b=lPRU/2lOaaRTUQS9aRbbdiEjxglXX1intiCYsQNyPZNvU/TA/HtxB6w5407wrvOVeAirOUD4kTfIZalGL45CePFsW/69brIvAJur+LylmVwLlnRuuFkFHe32TlqV2NEUQCU8wTWjWgq3wxKSjVKAGBSnXLntwXTEdCpY1BvszAAYBOkVc6jrARHs13Q2UmTcLUkD/A1Fhx0E6WwAkXMnOjs2mSKf47l35YpEJLxCmb4gbSw7BBVRzh6yCw2FkbM+qwU2ZMhIFBVwBb7hR8HtFlYy5saUj2mzqdECNy3jyH6EHV1ssN5Xs/BNhjv0K7yLlbHqrKSAhpT8Ss6wncyzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA9o5BQ8quvOVFEOy1BF8aQgJjRvmy8MPU3cs/fmcD0=;
 b=e5uRBgQaoWZJi1xFv1qh74Ow0TobG3XZaiJfz/EHSg/HxPtBDn8BkPZNct9zOSPKl+IxAjXeIq2CIiGhc7/yew+ucvcwAyqQrfrn3VvvOVt33cqxs7rF0bArIKQjVyj/cvCoXLJWPm9swf4ovO0Vq7tQPZ/vQh9a4JRnIjulrW2U//WeoenwqXl7GkvnzPir7qKZyjybaEk5a/VNIdJV4VjMG/U99Ce4C2re03xVpRkjQkBdbxcWXX/yCTT5FOT9ylnDrlIAQLB1okEmXX0jl6o6NaZP6LZkH/BESRkOdIglciv+i5lNlB6YtswIJtZiTQ+oY/x2vDvH//0AmljIgw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 02:45:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 02:45:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgIAAYlyAgABQ5gCAAFAFAIAAekmAgAB74YCAAAw4sw==
Date: Thu, 31 Oct 2024 02:45:09 +0000
Message-ID: <8A92B3EF-64FF-4ED0-BF4E-5BB6680B8FA8@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
 <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
 <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
 <ff0840eb-5b41-48df-9887-3539275761a1@linux.alibaba.com>
In-Reply-To: <ff0840eb-5b41-48df-9887-3539275761a1@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4165:EE_
x-ms-office365-filtering-correlation-id: 0f9d2dd0-11a2-4444-4899-08dcf95608e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDVSWE1lbG5rano3ZWdDYzhoRzNkdGtZMm5McnNSeVQ3RHorMmVVUlVjTFA3?=
 =?utf-8?B?MzZiRWduOTBwNEVaKzBwdmZCMzRycGhGNzdzV0VrM1hFNVZJa1JXOGF0K1FP?=
 =?utf-8?B?OWZEcHR3aXBmMjdWYkxpRkg5YllYc3Z0MmljdDA5M2dsei84OVlJTmsrdTBN?=
 =?utf-8?B?K2t0WDBDOVFwV0pJTXB2US8zV3FoeEI1S2xucktkM1hIZDlhZjZHZWNQTFZF?=
 =?utf-8?B?eFg4enRHNmJob05xQU1aRmNrUzM4RVZCTDJmZnh2a3Vhem42RHA2R2I1ZlMx?=
 =?utf-8?B?WEZPdnJKb3dISEF0bW5UYlNRN0JraHI4NVYvZ290OCtKU3ZLOGRlWVRzdU9w?=
 =?utf-8?B?Qk93eVFlcndlVG5XZjlRVWx6TDdQVEdjWWM4ZHh2clBPci9abzF5c2ZkUmUx?=
 =?utf-8?B?N2ZybDdyVlBaS3IxZDZiekJ1cnRieW1UaVZrcVFmY2wwaEwyZmU0TjdQYnY1?=
 =?utf-8?B?WS9WeUkzbmxBWHZSdllsRzBpZVJtV0V1dVhnZHBXQW9wOENZV3hWUnFFOEI5?=
 =?utf-8?B?TDZHN3h0aXJYOEU1OE5wNE96NDN5MXJMZTJ3V2wxU3lmZ2M3Qnoxb0krOG1q?=
 =?utf-8?B?bUkrL2V0SERZMFFmSHl1TWRWZWczK3BKRDJwVDUwcFl6UjJ3NmwranRxR0U4?=
 =?utf-8?B?aXJHQ0owNmJRTkIzOHQwaHRQajcxbWFXM1h3UFdxRVpGMDIvcjdBcTVnOFBJ?=
 =?utf-8?B?aGZ4WUNLcUIvR0QwbUt0UjJZTjhCTnhacEVtTS9Td3UyYnVscVk5NHlpYXV1?=
 =?utf-8?B?QlA3MzU1WUdJZXBRVVVjd3VlMjhCWXRCVW9xSEdFUkhjUFU0dEJySEt3bUYy?=
 =?utf-8?B?cGNmS3ZMeXo2MlpyZjBnMUxJMjUzQ0FMWHl2b0l3dC9jejdMUFVyT0lOandY?=
 =?utf-8?B?dE1MRXVOVTg0SDg0QWlZSXd3b080TjIvZmtqUjVTbHErTXVRS1pFWHpKNy9Q?=
 =?utf-8?B?Z0l2eGxFeHZhL3dzYlFMZ01lVGUzeVlmNzNQRVdBTDFhem1oSXNKS0ZYWHBp?=
 =?utf-8?B?cmFsbUljL1R1bXhzNHduR1JZVGZkWDBKUUwwTExrdVZQcmlTamxmN1ZNSXRh?=
 =?utf-8?B?SVR3ZEJPcDRzc3BTM3MzOENJU1gzRWl0SUtSTEN1WlZ0MFhoc3hGYk91MWNH?=
 =?utf-8?B?Q25nUE1ZUlJCN090YkZ2Nk5wK014d2Q4djg3WDFpVWZMTVl1U0RoSDQrdmhI?=
 =?utf-8?B?UWthbzVmblA5VFZseDZUZVhiUDlkdXNHMUd3UHZCc0ZOZEd4VWptbkVQTklu?=
 =?utf-8?B?eXdCR0xGNDFpWCtaSzloaTRkUE04WmRKWEVHUFJMbWd4ZkthUEo5UERNUm5R?=
 =?utf-8?B?aWMxS2pmQkovVlFhUFZLUDhkMlN2K2RybVlaNkd2bGhxaUJpRlkveHdBSmZQ?=
 =?utf-8?B?cFBOMWR1cE9peWlLVGNUV1ZId2pNZExLd0lQbFdkbklBam11UkNTNk5VOUFn?=
 =?utf-8?B?c0lSN25HdkZiN1BMcXo3cXFWMmw2YXJJalhGdG42NTcyc3ZHRXppa2QwZEQx?=
 =?utf-8?B?MEdlM2xsSXJIUmdMZDllNnhUNmM2dGZwOWM1MjNBZzR0VVM3TjVvODhDaG9o?=
 =?utf-8?B?cmxBaC9wUVRmSjNROEwvS25TNE51OTcvUmRSOUVHWFlGaE10SzA0MXM5SFdS?=
 =?utf-8?B?NVZ6NGhJRzZqVmRIYXBuMXZqclc4b2hYRmYyWWt3TDVJNFFFRGJja2laM0x4?=
 =?utf-8?B?dFBlQkpRTXZVTEtydFE1dkFpbzdMQWNVM2xHZDdtQm84bUhrUGZJVzhRQnZB?=
 =?utf-8?B?WGRqV29oVGtBLy9pMU5nZWZmV1RNNENMNDhCTnBMTzBxd1hqTUwram5TTVpO?=
 =?utf-8?Q?HtCuuUZgw32XejXMy669lAqdNOBUfmyf9AWgc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG5UZ1B4NVFVNTc0YVpwa1J5SXdXZHY5R04xeS9HVjRzU0kxb0c4M283bCtD?=
 =?utf-8?B?dnQ1cTU3VFAzNkRYd1ZjbXZDOThnby93N1BFN2xmck9CV1NYa0lwTnF6ejZr?=
 =?utf-8?B?Si9jM0VPdTZZTFI1VWl6b0F3ZTNGTXpZTmJUeGlZaE9jRjNoeHhRWDVOOVFZ?=
 =?utf-8?B?eG9Ici8yWjM5YjR2ZDBqclVHOExTSUt4d1ByRkl6TlJ1clQvQzRwQXdjRHlu?=
 =?utf-8?B?TmdNWVRnbkJIaElvVXhlMGxsZnhRVktFRkFDWGYwK3pWSmpTUlpHc2VFL044?=
 =?utf-8?B?aFp6RzA3NlRsWng1M2ZGYnhYbVRrQklUem02KytTbEtIcVNLeTV4RUVCZExh?=
 =?utf-8?B?ZnR6Z0hQZVdvdVExUSt3Z0VwMFJ5ZGJwVG1qS0Fjc2RIRVJJV2hUM01zSHZV?=
 =?utf-8?B?cFNYcjhOeDJGdlNMVDZ2QStYUFNFZ2tNNndRTFB6L083ZEhYaXMvK3JIYmNp?=
 =?utf-8?B?ckE5SjJUUVBuUnlGMjdrU2gxVFMrTjM4UGVCajdFMldKeHl5M3YzUHI4WWx0?=
 =?utf-8?B?T2VDWVZNYk5SelFqUDc4WW1Eem5oMFJUTGUyaGVyVFVvOExjemNpTGdTL1Mv?=
 =?utf-8?B?QTV3TUxQblR3YjRMWDRpaWU1RVRFcFRlSDNhVmEva0RXbFZ1L1ZTTVdacEY5?=
 =?utf-8?B?OVdzWFdqb3BYcHdDYTFYbWhMbFRKa1BHdjFmZGl5bFFYWHE1ZWlha2NmWHRx?=
 =?utf-8?B?RFRCTkhxYW1hN1lGemw3TUE4ZWl0T1NGMGxjWHNSOFpZSnVVZUF6bFNNL3BP?=
 =?utf-8?B?RTJibUFSSjBTM1c5Q0VEekQ1RHpEdFRVeTlqL2hic0pmVkZ6aVhzbno1MlZy?=
 =?utf-8?B?MHVUeWxyUWhreWt3SVBBc2FxK1R3Y2hxYmJpL3RpUk5rTWJSQW5SV0VGVnIv?=
 =?utf-8?B?a2VybWlvWmI3ZnFtSklhL2NsQVRzNDdWdDR6RVJMMnYrb0VBZW9NYzNkeHdk?=
 =?utf-8?B?MUFnVUVlUTlaZHRkektYcnpIVmlYeHRIekY5enJabm1iaGJQSUFDbXVheGo5?=
 =?utf-8?B?T0dNWW5SOExDQS96bHpwUm1DY0RpMlNQcDFPRjJKeXJFeDlGYTJFbE9jMGIx?=
 =?utf-8?B?SysvRTU2UlQxRmV3L3h4dENvUFZpSGdpLytTTEtUSE1QTVdpVUw0aW51WU12?=
 =?utf-8?B?ckJ5a3Y5TFBNY2RKaFJQTGtTWHY5eWNRclNYSENZTlY5VHF5d3JnbzB4RTAx?=
 =?utf-8?B?UU5GQ0RmUGgzZDRYZ05udGZCcTBKQnBmYmFTUlFYSWtuSU9ySUEzb21KMnlj?=
 =?utf-8?B?bU0reDlJcFB0Q3B6OTVpOVgvdU9nZ3dsMlIrTzU1WlVjbUZDdUNyQnFQTDZx?=
 =?utf-8?B?S05zSnpOcHlaVHFkam83UG9GWDRKSWtsb3F4aFJUdDhNRkNmSFQyWThrazVD?=
 =?utf-8?B?L21tRWxiVTBkMUFTL0RiRFpBcmlxZDZiTTFuTHJNSG9MRHRwN2dVZjJraTlI?=
 =?utf-8?B?RjR3TU1MZCtGemJRUjlvTTl6QlFGeUZGWGhuZ1VUV1BwaDB5TnN0Wm45Rk41?=
 =?utf-8?B?akhJRUxvWkNrTktReEFtL1F4V2l4Wkx1UkVDWHFuRHJIaXJ5UTllUTlQQzRz?=
 =?utf-8?B?c3RsQjlPYyt5bE9ZTFVKSmhYQzk0OU5abHl2b3FBL2JKTW5EUWRPMXMwOVJU?=
 =?utf-8?B?SFppTE92SUhJS0dSV0h0MmRyZFd3WGw0c0w2Yy9JK1RWUVNna1UxQTUxRmtl?=
 =?utf-8?B?cU5YbEJpbldUTjE2MitrdFV3bXdSNXNOOFNHamhMSkVxaGo0bU9KSm5zREM1?=
 =?utf-8?B?cHR5TXZ0Q1ByaG9ldWxjOFllRTh0SFczdXhpY3ZFT2pCSjd6cHlRdmdqMGlp?=
 =?utf-8?B?eDB5ZFU5RW8rVys5S1FCR0NWcGh1cGdpRXVIVW54V1FoQW05UlRqWEJuN2Rz?=
 =?utf-8?B?ZjIwV1BNa1Z6akVIQk9uK1hQMXdoenQ1NFpSK0lCNGlKd3RnelBURlFyU2pt?=
 =?utf-8?B?VDdKc0tLM3JhT0ZvQ3JZNExPUVU5NWVGY2p0ZG92dGg2R0wwSTFiSUVORW14?=
 =?utf-8?B?QmlWYXBRellNNHcvUjdaNUcvRDdYNWs3VDJLVGcvcktiUTI3UUtBK2NybEdv?=
 =?utf-8?B?L1dQMER6VHlJTnBTSzZXSlBoWkJrRWVUNjU3L3QwMWVFelRHWGpnaTFiUHM4?=
 =?utf-8?B?Y2h2ZGQ3S1A0SVk2MXhkdVdXaGQ0NFZCM0JiWVd5SnIrVjBwTnNCai9nVE14?=
 =?utf-8?Q?UJwtsRDX9yObU3cP1qx61wbx/xTL3VOAigzUUzSSTqd8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9d2dd0-11a2-4444-4899-08dcf95608e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 02:45:09.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io+zAZPYtmgJLodsMZxStjgSA1AY9VxMLTfh6aXJEa/6dxGPKXgpgTX3NVSq8V/m6KPwZ2mfx+qAVL/vQ60NEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_194516_177858_DCA6EE5E 
X-CRM114-Status: GOOD (  16.64  )
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

DQo+IE9uIE9jdCAzMCwgMjAyNCwgYXQgNzowMeKAr1BNLCBHdWl4aW4gTGl1IDxrYW5pZUBsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IOWcqCAyMDI0LzEwLzMxIDAyOjM4
LCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4+IE9uIDEwLzMwLzI0IDA0OjIwLCBHdWl4
aW4gTGl1IHdyb3RlOg0KPj4+IFNvcnJ5IGZvciB0aGUgdW5jbGVhciBleHBsYW5hdGlvbi4NCj4+
PiANCj4+PiBUaGUgdHJhbnNwb3J0IGlzIHRjcCBhbmQgdGhlIGJhY2tlbmQgaXMgYmxvY2suDQo+
Pj4gDQo+Pj4gVGhpcyBpcyBqdXN0IGEgc29sdXRpb24gbGV2ZWwgdGhpbmcsIGluIHNvbWUgY29t
cGxpY2F0ZWQgc2NlbmFyaW9zLCB3ZQ0KPj4+IGRlcGxveSBtdWx0aXBsZQ0KPj4+IA0KPj4+IG1p
c3Npb25zIG9uIG9uZSBtYWNoaW5lKGh5YnJpZCBkZXBsb3ltZW50KSwgc3VjaCBhczoNCj4+PiAN
Cj4+PiAxLiBEb2NrZXJzIGZvciBmdW5jdGlvbiBjb21wdXRhdGlvbi4NCj4+PiANCj4+PiAyLiBS
ZWFsLXRpbWUgdGFza3MuDQo+Pj4gDQo+Pj4gMy4gTW9uaXRvcmluZywgYW5kIGhhbmRsaW5nIGV2
ZW50cyBhbmQgbWFuYWdlbWV0cy4NCj4+PiANCj4+PiA0LiBBbmQgYWxzbyBudm1lIHRhcmdldCBz
ZXJ2ZXIuDQo+Pj4gDQo+Pj4gQWxsIG9mIHRoZW0gYXJlIHJldHJpY3QgdG8gdGhlaXIgb3duIGNw
dSBjb3JlcyB0byBwcmV2ZW50IG11dHVhbA0KPj4+IGluZmx1ZW5jZS4NCj4+PiANCj4+PiBUaGVy
ZSBpcyBubyBwcm9ibGVtIGlmIG52bWV0X3dxIHJ1bm5pbmcgb24gYWxsIGNwdXMgb2YgY291cnNl
LCBidXQgZm9yDQo+Pj4gc3RyaWN0IGlzb2xhdGlvbiwNCj4+PiANCj4+PiB3ZSBuZWVkIHRvIGRv
IHRoaXMgcmV0cmljdGlvbi4NCj4+PiANCj4+PiBJIGRvbnQga25vdyBpZiBJJ3ZlIGdpdmVuIGVu
b3VnaCBkZXRhaWwuDQo+Pj4gDQo+Pj4gQmVzdCBSZWdhcmRzLA0KPj4+IA0KPj4+IEd1aXhpbiBM
aXUNCj4+IGNhbiB5b3UgcGxlYXNlIHNlbmQgYSBwYXRjaCB3aXRoIGRldGFpbGVkIHVzZWNhc2Ug
Pw0KPj4gDQo+PiBBbHNvLCBpdCB3aWxsIGJlIG5pY2UgKG5vdCBhIGJsb2NrZXIgdG8gbWVyZ2Ug
dGhpcyBwYXRjaCkgaWYgeW91IGNhbg0KPj4gcHJvdmlkZQ0KPj4gc3RlcHMgc2ltaWxhciB0byBs
aXN0ZWQgYWJvdmUgc28gd2UgY2FuIGdldCB0aGlzIHNjZW5hcmlvIHRlc3RlZCwgZXZlbg0KPj4g
YmV0dGVyDQo+PiBpZiB5b3UgY2FuIHN1Ym1pdCBhIGJsb2NrIHRlc3QsIGJ1dCBpZiBub3QgSSds
bCBzZW5kIG9uZSBvbmNlIEkgZ2V0IHN0ZXBzLg0KPj4gDQo+PiAtY2sNCj4gDQo+IEkgd2lsbCBz
ZW5kIHRoZSB2MiB3aXRoIG91ciB1c2VjYXNlIHRvIGV4cGFpbiB3aHkgd2Ugc2hvdWxkIHJlc3Ry
aWN0IHRoZSBjcHVtYXNrLA0KPiANCj4gSSdtIGNvbmNlcm5lZCB3aGV0aGVyIGJsa3Rlc3RzIGNh
biBoYW5kbGUgc3VjaCBjb21wbGV4IHRlc3RzLCBhcyBpdCByZWxpZXMgb24gZGVwbG95aW5nDQo+
IA0KPiBtYW55IERvY2tlciBjb250YWluZXJzIGFuZCBzZXJ2aWNlcy4gU2hvdWxkIGl0IG9ubHkg
dGVzdCB0aGUgY2FzZSBvZiBzZXR0aW5nIHRoZSBjcHVtYXNrDQo+IA0KPiB3aXRoIGZpbz8NCj4g
DQo+IEJlc3QgUmVnYXJkcywNCj4gDQo+IEd1aXhpbiBMaXUNCj4gDQoNCkZvciBub3cganVzdCBj
cHVtYXNrIGFuZCBmaW8gaXMgc3VmZmljaWVudCBzbyB0aGF0IHdoZW4gd2UgdXBzdHJlYW0gdGhp
cyBwYXRjaCB3ZSBoYXZlIHNvbWUgc29ydCBvZiB0ZXN0aW5nIGRvbmUgdmlhIHN5c2ZzLiANCg0K
DQotY2sNCg0KDQo=

