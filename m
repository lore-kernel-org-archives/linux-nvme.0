Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C24E69185
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2Ug4/jkZ8XzlTZ3AQEqwNUwh2pEB4QjRMU3f9fjfRU=; b=If5l485wj78qIave9IPsl6O3r1
	sHrVJ2sFO52i+nCXTHEl4ITgGQdAdzOKv9wgFZOA8VR/gi0FglNGoxWBEKRv/L01qwP6DkajYx7jK
	bYELDFKTPTW3WbNcg8Sxx7os2xD0/IWGWBdm3W4NrbL0LuGwT9Lp8VpYMNM234ur7Ybnw0k859J3l
	c6hCfglF+24NdJlYNZcGhuyBJlk3htn7PDJdjmINWvLZR7jZS5Dgl8BvJnmTIZ6iMW+tv+IsEU5vD
	sZNbV4TVpW18WxWZIIPvFRBHwvFlTLGayZiNKs2418Gs7/V4QuE8teffsku2lej3T8xYAOhkaxRnd
	ZGCpJUIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXIq-00000002wzz-1ZWu;
	Fri, 22 Nov 2024 17:18:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXIn-00000002wzV-2i71
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 17:18:42 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBbLR016291;
	Fri, 22 Nov 2024 17:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=E2Ug4/jkZ8XzlTZ3AQEqwNUwh2pEB4QjRMU3f9fjfRU=; b=
	eorKQfzooGrV6neta+3cJkT3qITsw//QlXBDWq/0Kbo0JkIFRR1D5bBrDMVu1aK9
	1Moq7Qs2eVLy93+lETPRWJATE8KT1AvwWoN4Zo4VTgMPnwEuZ2RiU0h0FKFHbopf
	B3VxbU3zeR3zk/pSVkR7IhuECpuV3TyRAd7IQFSEQJMvBo5wME4FpNXwx1Ihg010
	VNWwxW39SUuszvu9cV9aqOUzx3+fgBrxXybbbgFgcGVm7oCqMLdXUUlbxLgx8kzi
	JW6+HC58yY/dmRzxIYIzvR6IdH7bpJRzRYr20toO/EOArPo7oik7/lXyKIhEnZ+7
	XEFhoKunBc7XVRcRd7457Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaacns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:18:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGa0pD036388;
	Fri, 22 Nov 2024 17:18:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudjbe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcW9EuWokjL/yJV4b8Bo6IDJhe9tLmKuFuRvO3lOj9k05vZNhwR6z3is0osxPA1qKLyLOU5kiJqt42FL2wgfUtuVp2kOi95Ex65vYE2IavmTxJrr9YEBv97WPNIraCJkzHw5hIFypeLiWfI/nfuBt/Xf/GWS4RjK8SF6XugzobHu1yhQLryUZNSMfpbPxyXSKtVxJ7gxUtQhSPa4YrKckLcFmZEdntAxKRysiTs5IuQK9iVHs4TUf8jiWT7QOpMVdNe+V9UTCQncP0wbjIFQG7BMDDL/xxHbtPNgecaVocHqrxxnspnmLXQbMhXRZenCjrUdP7FZAAJgbbhGkhS+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Ug4/jkZ8XzlTZ3AQEqwNUwh2pEB4QjRMU3f9fjfRU=;
 b=h4qHkJqNoGQtwmKf8C7a0McVnXT6NTqVXYTmuVnbYSUAV1yPbj9cXeJk2pu0ax82Oo3bObWnyuvjnPpUysO74U9Ix19dVL+isIhu6KRa1os0aHyk+HqTC1ay25Hujo2azoz0Ynt3DmlNcUquByA0KlBfFP9Nze+apXvXU7j3gxkl/6s/5jAf0pTSixgqHMmHSEUM1XwgTkG+CCoxwSIOP1SZUSj+EewADrS9Sh+YxMuATL1CeDKCMVf+MQqAVPPdU0ajznbWHBB28vSI6rwOF2rWiDIcs4BSZG2lsLWeeJ7cslGNH2LC2oS/GnoXRbH5eLVecbxoq0pkRfimHs9gIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ug4/jkZ8XzlTZ3AQEqwNUwh2pEB4QjRMU3f9fjfRU=;
 b=MlhiRfkn71jmxEypQhttWzTANjd7ieLRtVlds+JahfY8AQ+GXCTj1Z+1/iQZMbkfShv9ba5jnsnhR9llwaG4lvQgjzCRIsw77U+02BtLPHLke6Z/NIrMihCzJvnWUHRgV/TGUVPkjkCVLtZ4O7N4ViN2mUzCh33uNpbqMYinWmY=
Received: from IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 22 Nov
 2024 17:18:14 +0000
Received: from IA0PR10MB7577.namprd10.prod.outlook.com
 ([fe80::7923:a24d:8b74:87f8]) by IA0PR10MB7577.namprd10.prod.outlook.com
 ([fe80::7923:a24d:8b74:87f8%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:18:14 +0000
Message-ID: <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
Date: Fri, 22 Nov 2024 17:18:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Nicky Veitch <nicky.veitch@oracle.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
Content-Language: en-US
From: Paul Webb <paul.x.webb@oracle.com>
In-Reply-To: <20241122121304.GA25877@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::16) To IA0PR10MB7577.namprd10.prod.outlook.com
 (2603:10b6:208:483::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7577:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: e05ef364-efdc-48f2-e9be-08dd0b19a5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5ndXA2am1DVkxrMVMyb1pNaCswTXJ3eFNsRHN5N25vOWhES2Noa0pzMytS?=
 =?utf-8?B?cVJtKzNISjhYVFBVTUtaWVFZUHFZK0dHSU5HN1phNFZQRXFjVUNESkRUa1Zt?=
 =?utf-8?B?cUhXamx0azA2aU1zN2xZSWQxR1BlSW5HU1JVSjNtTlVxeXc3WnJQc2VYamVF?=
 =?utf-8?B?Y0dYcklYc1RiY2JSSGVrVW44azBvRTZ4UVI5VVVpNXh6ZlRUbDJJSTBTSTdn?=
 =?utf-8?B?V0txMFlpd0tpdUUwcEtBWEMvUmpSbWgxSGVHMmdtVHB3NXpJS0dTZjNsMlhs?=
 =?utf-8?B?YnBUb3RTQklDNmVjdk1tRnhpM2VHWjNsZ1k4TnhST21KdEUyT0wwcUVlSVR0?=
 =?utf-8?B?R2hpWU4ycnZlOVAwdmlUUkxSZithb3BweFM1dWdtUDhEQk93dkp1Yk4vM0hX?=
 =?utf-8?B?WSs1bGxta1NmTHhkaVErSXNNZERFMXdzQjcrcWhHazFjMGJxYm1MR0xaZ3pW?=
 =?utf-8?B?QWI1U0hhUlBlVlBZaDVQaUtDbjE1VXNDaXhwQWp2TkIyTS85Zi9HNUtPb2Qx?=
 =?utf-8?B?U2VNbndnOVluK2pUU21VM0ZSL2hIWTlscXdGRU8xc3RCaVJpaWpGVnFnWUNU?=
 =?utf-8?B?Q2srdm5XWmV2eUtKeWI3NGpuT2I5Q0N3RENmSGJaaDltekNvVmhZWWo0S1RD?=
 =?utf-8?B?ZW5DWjNlTTl1VG03Y1Y0TmhtNTE0NXI5ekcxMUZsaVlyY2lSR0ZNMkpRVjNz?=
 =?utf-8?B?Q1l4cDNkeGlTS2hSRmorQmE5aTBaV213MG96QW5WcVZWU3AxekE5bUdrekg0?=
 =?utf-8?B?Zm9DT0dkaTYrV2p3eklLdHVzWDQ5K0RjSkgzM1dBNDI5eHBPa01OYzNlVGdW?=
 =?utf-8?B?NWw1SlZQRld2VkRtbGU5SU92MVRPMW0zeHNncXdhc0xSOUxib1V3dCs3c0Fp?=
 =?utf-8?B?Z0psZlM1cXByS0ppUGxaMjNkajdoRDhCVWxRdnZzNjdMTWtUdWxlcTZCMzQ3?=
 =?utf-8?B?SW1zT1hpUU1JT3dIMDc1MWNpSHF6R2tab2xTK2tXbzNvYnFKbWdXK1hRU3BH?=
 =?utf-8?B?TGxjOVRkVHkySVlYRWhCYzJLOHZFaklQK3EzWjlJK2hnU1dGN2M3ZGJ1N0xl?=
 =?utf-8?B?NCtXU09JZEtMR3ordnRnZitnaStRWDJJUGRXSm9aT1lOQTY5bkhQL1NCNUYv?=
 =?utf-8?B?WGhId2hYMHlRelhBZUN4bEFmQ1NXTzBNMnJDYzRudHJ5cmNJNVBXVXkwUmk4?=
 =?utf-8?B?UmZJS2JEMDZTSHFKdTErbVdjM2kxSVBWU0RNNVNuUHUyL1BWblRMS0FYM2l6?=
 =?utf-8?B?Q1phNG4rRy81U2FPRXdmL3ZCQmpDL01McCs3ZjBmdE5JQlNZcVR2NWQwTEpB?=
 =?utf-8?B?MnlPYTNKNzBsOFFLRU5hbWs1QXdaVFdiL3ZJNUtCM2gyNm9Yczdsd1FhUjZv?=
 =?utf-8?B?ZmJWb0NhL2pxeG1JQVJyMnVSVVF5allycXRRRUx6UFRRcWhpaHdkVzFSMStp?=
 =?utf-8?B?TkZOMERQTi8rd1NoWWJaa3V1c2lMcmZidlM5a0xIYm1jdGVvRXZ3eDRyWUpp?=
 =?utf-8?B?TCtzMlYzTFpBR2dZWEVpSC9xdEdOS2hraERRTzBwanFwVG16aTRkaitPZ2Vo?=
 =?utf-8?B?bnVUQkhmWGJzUGNydnc1Tkd5S0xFWWcyWDlLK2tLbkE2aHNvV2hoUEFjUEtV?=
 =?utf-8?B?cTlqc0x3dVRCakNnVEdoS1BlWkk4NFhhY09WSUpnTEQwc2VkSFdMNnNDdHQx?=
 =?utf-8?B?dENmd096WmZzV2NlOEVXQ0ZhMnhaQWxEeWJJeEZ4Y1RreVBOQzZNalpqcGVE?=
 =?utf-8?Q?gtLeZ0mfNo3gA2SwJbRDuvYLaG8bE5Tgar3JREU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7577.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBVOVAyN0VQK3c1WEoyeW5hdlA3dGlJRUJ3bitoak16RS9oLzNxQzJ5dkIy?=
 =?utf-8?B?eHJDY1NpVkhmdHBmbHZGS0dLbkdEQ1JPWDJ1Z3h0MEJ3OFZZWnRSWWNlelMy?=
 =?utf-8?B?ZkpVVDVRRC9MT2hmUjVPUDJtY2JQcHR4U3pNeGpzZU9KdTd3V2VKRjBtbGY5?=
 =?utf-8?B?RGpKWExGZ2hVY3dod0E3dk9WTzNKUmlCZzY2dlBJaENpaHl4ZjRZV3lsc3NH?=
 =?utf-8?B?T0t4dnlEY01tcTlxSkVKWERVUWhXUWUvQjNGMThkT1RUSXJXWGtWR0RZb1BE?=
 =?utf-8?B?SEJONVE2djA2a3FHdkFDak9JaEtEZjF6M1JkWXBMU1NSK2F2OUNnSVhvWG9L?=
 =?utf-8?B?cmluQWJPbUE4RDZiR0JGWkpZRTlrU1EybkVQeEVKWm8yR2dXZGFDR05iT1RU?=
 =?utf-8?B?TXU4d29vaHRjUWpXWUluUlhrUVRKOHRDNzEwZncxYm42TkdsVUV2SmtXSk5N?=
 =?utf-8?B?L2kybGpUcDEwL3Bkd01JZVp0c1J6WFpQamdQOWY5OEUrRTZvWHU5bFVsY1ZN?=
 =?utf-8?B?ZWIybHJDbDM0bDNYdW16TFpMMnhxNDZXQTlLWlZWZVZEVGp1a1JiZHAxNW5D?=
 =?utf-8?B?anI3b1FlY0xJd3E4MC9OSlQxbTA2Qkpzb0FxQUo4WGJYWXdLRlNDbEZXWUY1?=
 =?utf-8?B?U1JJUVVzY3lEekh2TDQ2akw3TzNKTVZzcXVLZkVEYm15ZGtIL1hndWFJdkd3?=
 =?utf-8?B?eitFcnU0NXhqL0xxL0IxNlNSaEdTM1VxZXY4K0Q0dUg4RG50ZVpHZDhPU2FJ?=
 =?utf-8?B?a2x4REJuRkYvcVVSM3pwYlJaYUpjbStjc0EzVUd3V3dTVjZBOVdLTXd1cTVT?=
 =?utf-8?B?YUZRcUp4MGRZc1dRVFNaLzZhQmR6R3RML0t0OHhtTFRGRWpBbWdyTjIzZ085?=
 =?utf-8?B?cVdGYUR2WjBnbzhlYUJ6SmI2UUxKOVMrbWdoYXplOFBIdGlDRTVmZm1WdVZB?=
 =?utf-8?B?MmRGUnBNUGpDNWdaRHpYcnN6alozYlhQZzZNMjNQdVk5cHUrVk1DSUNkcFRY?=
 =?utf-8?B?V2JSSytjbEVCY3dSa29sdFpaRkoxaitRMEU2R0dyendIT1JvOGEraEg4bUtM?=
 =?utf-8?B?b0MvQ3FaMVFCd0UvNjNYYzJSUTdwRzNsa2lMNEJCK2VqR3ZnZGRNY29qc2lC?=
 =?utf-8?B?MDRhS1Q5SEJNMnNoUm9MV0RsTFJTNTNlTk1TWTFJb3FDU09sbDJaUDh2cFRa?=
 =?utf-8?B?aER2VFBIdTJBb293RWNYTmJoL3ZlTVo4a2h2NXdlMEtGWUV5MUltMlFCSE5x?=
 =?utf-8?B?LzVhQ29RTWNlMUU0SE1EeVR3NGY2SXNtNmZkNlB2eUdHbXVTY0I4MHRFQUV3?=
 =?utf-8?B?aGlRcXNmYi9KNmtNT3BLV1Q5Z2RscGtHdkl1SElLOTJOS3R5N3djc21Uc1lX?=
 =?utf-8?B?cFM5V1c3Q2VGSDdDc1BjVTV6RjdmeFBQK1NBZjNFOWJTSUUwT0JKVk5NMWVa?=
 =?utf-8?B?MG9DakVFVHd2eXFPNDdjYmRWdVptekZmU3FCeGVaRTlTRmcyQ1BGQXlkcFNV?=
 =?utf-8?B?eHN5N3hhM0FYV0p2alJUUlkrRmZTNDBWNHN4TmJtOUJHWWxqYzZ1d3BwMExx?=
 =?utf-8?B?YTZTM3ZyeS90cm5EUDhhOFBCUzFJSW1ZNkg4dWZTQXNBN1NvTGVITlVTQm5R?=
 =?utf-8?B?NWVtYlozcEF3LzlEZ3lhdkZuNkNPMTFENWk1dWI5KzVUcjVBMlpoUkpFRGVr?=
 =?utf-8?B?M0pEV1hDYXJDNlJMMlpYbzVmaGlaTWdZR2dSRVVHeUdCaTZOeGg5SlNIRXhT?=
 =?utf-8?B?N1RIVEpUOE1jUFFwWk42RnQyUFFNZG5GcWhGc2NDY1E4VlYwdlJmeTg1OStB?=
 =?utf-8?B?WEZVVE1YMzV1clYxbmh2bStVdmttZEFVQ05GVkFiWE1wR0s0Mnd5K0RxVTVa?=
 =?utf-8?B?cVlTblBVNkM4NXplaEZIajM0SEJUMGJhQmFJRCtJRmF1TzlLZjlrc2xpeVZu?=
 =?utf-8?B?eTMvdTdqeDFLSXRGc2ZzaERlZEczd2t4OG1mR3FNRTJqWlYyL01JT3JqZUVo?=
 =?utf-8?B?UU1SWWw0emFQK2k5VkQ0a3ZpTG1JNzJxaHUwMlhpOUpqeE9Ea0daY1V4MTZR?=
 =?utf-8?B?TUdyaElGS1NEa3dOUGlTcUU1NjNBRjJYZjVzZXl3VFM4WlZUZFpXWFJLNldV?=
 =?utf-8?Q?6OjncVn2TrRrljrI3HFeHiKjM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cFrE2co2hvJbfbh/RkCDiq4evHmHRHqtm/h8jYuiMop/zKSy8XzlDuG89uv9nA+aAIwDgBfvn2ipHugMV5KeNZB1FtCglO6CDtJx+GpwTY5jXS9Tq0qsA3MGU6A9YYzubNHZQMKZsPKlJ3QxzpJHtCQ2LhrNRib4JUy6nMdmPq1ifCihGp7p7lV7tepQYAPGgFxWtR56tOhFbs61QCkDDQcbHWRcivZoDvhVKDnjljWJB4g69WMapvmTM6gtlIoVHD65J/KwJ4omOSNIXbeSPqiUT0pkn+aDK5WRmNpkXn3l1gdER+um7tUeBR/vtX8GGGPh0iJ0DXtp/ip6AtDY2n/FSMTV0Mz/k3wqzWCRBsE/bDp6+tfwfTxSqDx2mrQ6fNFb92qMqJ+gnso1vEFBWroX7qiD0P/RVO6GaX4F+ARm4B7gUrgrX/FYro+0dhCX5zynN/00FSoZH3gnZN9XS4RGkFvEwvnvAO+lyaF8UnH3mwx7LUUPRgfRNUgEJGB9KdEg5/ShkJz+y2YXJ6k+JGfqWMUXqp9ZD7jLdYDJyELTWP0INQDtQ90Cx1V38Xr49lOpASNA+DnbisFfqD9+q6WsT4fide8pH8W3leoADZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05ef364-efdc-48f2-e9be-08dd0b19a5ca
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7577.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:18:14.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE+ZiZWYZQg1VPrGHL3exzYi1xvELkuGllsnGB2GA5fm4iORJwFlv6jEydoskbrTFGQYS8816jcAd7osHQ0L6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220145
X-Proofpoint-ORIG-GUID: b4R_4gUfOjNdyEOidJMc8lotwz8Il50x
X-Proofpoint-GUID: b4R_4gUfOjNdyEOidJMc8lotwz8Il50x
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_091841_692198_BC7A4D14 
X-CRM114-Status: GOOD (  21.66  )
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


On 22/11/2024 12:13, Christoph Hellwig wrote:
> On Thu, Nov 21, 2024 at 09:07:32PM +0000, Paul Webb wrote:
>> Christoph:
>> To check for weird lazy init code using write zeroes
>>
>> Values in the 5.15 kernel baseline prior to the commit:
>> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
>> 0
>> 0
>> 0
>> 0
>>
>> Values in the 6.11 kernel that contains the commit:
>> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
>> 2199023255040
>> 2199023255040
>> 2199023255040
>> 2199023255040
> Thanks!  So 6.11 actually enables write zeroes for your controller.
>
>> Another interesting datapoint is that while performing some runs I am
>> seeing the following output on the console in the 6.11/6.12 kernels that
>> contain the commit:
>>
>> [  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> .. which it doesn't handle well.
>
>> [  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> .. and interesting this is for a Deallocate, which should only happen
> with the quirk for certain Intel controllers from the very first days of
> nvme.
>
> What controller do you have?  Can you post the output of lspci and
> "nvme list"?

Hi Christoph,

The nvme related output from lspci is as follows:
$ lspci | grep -i nvme
19:00.0 Non-Volatile memory controller: Intel Corporation NVMe 
Datacenter SSD [3DNAND, Beta Rock Controller]
20:00.0 Non-Volatile memory controller: Intel Corporation NVMe 
Datacenter SSD [3DNAND, Beta Rock Controller]
94:00.0 Non-Volatile memory controller: Intel Corporation NVMe 
Datacenter SSD [3DNAND, Beta Rock Controller]
9b:00.0 Non-Volatile memory controller: Intel Corporation NVMe 
Datacenter SSD [3DNAND, Beta Rock Controller]


$ sudo nvme list
Node                  Generic               SN 
Model                                    Namespace 
Usage                      Format           FW Rev
--------------------- --------------------- -------------------- 
---------------------------------------- ---------- 
-------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            PHLN942100EQ6P4CGN 
7361456_ICRPC2DD2ORA6.4T                 0x1          6.40  TB / 6.40  
TB    512   B +  0 B   VDV1RL06
/dev/nvme1n1          /dev/ng1n1            PHLN942100PE6P4CGN 
7361456_ICRPC2DD2ORA6.4T                 0x1          6.40  TB / 6.40  
TB    512   B +  0 B   VDV1RL06
/dev/nvme2n1          /dev/ng2n1            PHLN9415002B6P4CGN 
7361456_ICRPC2DD2ORA6.4T                 0x1          6.40  TB / 6.40  
TB    512   B +  0 B   VDV1RL06
/dev/nvme3n1          /dev/ng3n1            PHLN942100DQ6P4CGN 
7361456_ICRPC2DD2ORA6.4T                 0x1          6.40  TB / 6.40  
TB    512   B +  0 B   VDV1RL06


