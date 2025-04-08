Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA55C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7D/Tynu3xKuKojWkxdsV25gvW8BakIfLb7JXZzbsXY=; b=ZK4u1GygHG7uelMvLBKDs/FwC5
	E/LAFhtCXgdtmbPtahLw7Iw8HoleF4zbiZATqab8YerXIaNdkoL9aP5zOybfHMu1I0gqjNdJXUC/7
	I9GJFtffl/s70mAxW+L4QGZZGkU0SFEunOfry/ZWDcZZLxvv5UMJKXXB928eif3ZMAmNk9gaqxRBe
	BGl81l4ofVkmoqjCCFm/apTD+eMO5rhmiyakJO8owT9gPF7KyKscsCDBDJdDpH7oxfbKq8zZRltzM
	MbxF/bkczcy3SuRaUi7IGRN7C9Xsg7frYzsFShclBoPrK0scbErzp4cDdGAMXNshrmfipVQh6uZa0
	3ZGax6xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GQv-00000005RG0-3FJT;
	Tue, 08 Apr 2025 21:24:37 +0000
Received: from mail-bn8nam11on20617.outbound.protection.outlook.com ([2a01:111:f403:2414::617] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GQt-00000005RF2-1MU5
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 21:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRDV3xoy7C0d2nFYSnZcgUubltPeQlDVJ7x6nD3Acz5abV/ro7KxAA8B+gQDdEh8nteXhnmXID+flcxgDn8K9HtEsfgGKug92jyUBIE7niVi0oMXCLyMQVnS27L2UmXSlp6g/yd8ysqK/7Vy6dhTDmUlcpyMKB3io/Jeneup8/fRZ2GXPk3wZHHyZdL8BgLp5gsGt9blJS4XPP1vKMTykKmOjo0xdkImLop993hN7MLHUhQE6iVmqHpLywAhNAcGjZFbvGBDPBtriKPvt57ci+QPmeybFea/jg2VZx1pfhi5AL5f1R/A2r+8IpfsVbfvFidg+kup+y8yMsRzmLLSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7D/Tynu3xKuKojWkxdsV25gvW8BakIfLb7JXZzbsXY=;
 b=EdX43ibDoCNQ89rZID3CHZ8LWy/DIE9Wh/nBYCtHViW/dE6o4erojQMsfL4eq7mdJewXl2JTcNK8edat5mfo5pSYs8dqXJZFme2Q/In5AIHae5L9JxhgFVhXXOwiIXRvM2SwnZsPYdn/fTHSaTIVnARsxs2w7QXxhZvBzXhBvAnd0p7RmLr6M8gLYXHWcmh+2IrK3npSN1GIAW59kqeL17tp8cA0+mChfZPw1X+JBMC9zfc3qr2Qjj6LgB+yU/vOJIJ9mnbe7vmoEMlen0uNEjudXj/Hy9xdUhTpxf/Bm72mNnGbnIpOlE+R+x4i9p5biy6QovjYjQaDbtZvtaOLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7D/Tynu3xKuKojWkxdsV25gvW8BakIfLb7JXZzbsXY=;
 b=B72k5XY0Y/VlkOz0MUbMwbtwO+LGk2yTMsvIWGmBLTh4ZDCldLPcqBD+gBF/XhLhFTALGfFyBHHkm6p6C/uk+6KnP5AV+FDkc+iYyu8cWfBaBhqX737Ueb7fGG3Db5Ia+jGthRZ4m6GoG39hWWzgE+wXNGXWg3DwYkoPPGXnkLF8a74TS3GyC8RljH6OJYWJ535IBMYAcgkSjjj562xsmS9UiMCueQ5iIkzh1RzfThLZp4/+eY+pFnch0v08l5qd5ZCcnESUPDHeCU+9qx7uHSTxce639TFX2jED3/A+Jq7GsFJpQWVQ3NmiT5VpwV+YuUxJMgXHzLRoIwTBR91Gkg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 21:24:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 21:24:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
	"~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>
Subject: Re: [PATCH v2] nvmet: replace strncpy with strscpy
Thread-Topic: [PATCH v2] nvmet: replace strncpy with strscpy
Thread-Index: AQHbpO+VvY/pCtsbukSjh3+lHCfT+rOaT1sA
Date: Tue, 8 Apr 2025 21:24:30 +0000
Message-ID: <5ee4b3ef-c3cb-43f8-846e-195597f32637@nvidia.com>
References: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
In-Reply-To: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7494:EE_
x-ms-office365-filtering-correlation-id: ab93c00c-dac3-4d4b-5867-08dd76e3c00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NGZjVXJUWURFV3dmMXgyamI0NHFQQzUzOUlIV0NHa0hkUExqSkc2YzNIaUtw?=
 =?utf-8?B?cFZtK3lkS1JOWlRXNFNid0JzZTVKaEorQXhxcHdEaEFHbHVkU1M4emVEUkMx?=
 =?utf-8?B?ckg4dzI1S0R1WWhIS3JkQWhWZFRKVStxTXhVRkVBT0QxN2Z0VS8vZkdDS0N6?=
 =?utf-8?B?R2VtMlRTZVBBNU5vdlpYajhlM1o1cXF1SFl4ZDRNVWJtZXY4MUx1dFJ1NXY2?=
 =?utf-8?B?UkhvMUFwZk9ERkNkaDhMV1ZMdWMrVGRvVk5odmtTVnpJR2JQMkRwWE82SHRX?=
 =?utf-8?B?b3FiTk9pcGJUU09ieTdvc3JYK25CRmFzZncvZStFSmp5NXByNVFEc3pPVWhk?=
 =?utf-8?B?UEJaRVpNcE5PQ1hzTmRMK1ZhcENKSWhDT216a2c4M1ZHRmRPUzVtUGlPRXNL?=
 =?utf-8?B?NGlSUkgrVG5VVkpZeHF3ZUVsMWtRZ1BPclowcmpJempiRGU1bmgwT0ppY1Jh?=
 =?utf-8?B?a3JINjJRbldYQnFKL2ZFM216KzJVVGRiMnMyUFhQbXJZNnlrVTFiSVo3Vlpn?=
 =?utf-8?B?Umh6WktVYnFoOC82dlpOeDJCSDJGM2Y1Z29iSGRsdWR5d1JpOU5LZ2tLTjh2?=
 =?utf-8?B?SUV0YlJHQVhNQXBVUkdhY3JVRk5UNFJxNW9wOTF2MHB3bVB6TnphRXpmb2Fa?=
 =?utf-8?B?dlZ5cE5EeEYzK3V1OXRMNWovMWlDMnU4NDZWWTdidzdxTUQzdWhHa0pSbmU2?=
 =?utf-8?B?SjJBRmlNR29MK1VFWnhQM0xOdlhuWnVjVHh3dmxucG1KS1ZSaVJiL3hESkZh?=
 =?utf-8?B?ZmxYQ3F3MHZQSmtnRXU1bTMwOUtZMmlKL2JROW9JbVFCNEwwSGFEZjBEL0RY?=
 =?utf-8?B?YjlNM1JaaERzK1lLenRtcUxJdVgxbm5iK2dqNGJVYmlxakp3cW5xUVhSei8z?=
 =?utf-8?B?d1ZhOCtSZEdPTUNSK3IzRG9QMnU2bHNPVFJ4c0NOeitjQyt4MVlZZEw4T1h6?=
 =?utf-8?B?ZjJpS1VIcTVkdVQ3NE5NQzNIanZMT1hQSHpLa0xpZXFnS3BIZy96YWNLcXdY?=
 =?utf-8?B?K3JqNi9nbVd6WHdYVnFzODBlTE1qL2ljZGc2d0pxdlJCeFlONUJLSlcvaEtw?=
 =?utf-8?B?UFg4akhocXVkaVowd1RNWW94cUREQ1NkbHhrSXBXeXpyTzBId2dEbUw4Y3Uw?=
 =?utf-8?B?bTBEMkpjWDRVWWNyVkhFMUYzamh1SkxsNzFEa1RYTFgrTGx2T0l0UHpydm1E?=
 =?utf-8?B?ZHBOdTRVcU81cThDY2R5U2w3WjFHYzltYW9zRVB3M2UrWk1rM0xmS3pGaCtR?=
 =?utf-8?B?ZVd1OVRHRFRBNkRMYXREaXFpRTdMdFBiSCtFSjJTN1JtQmEyRlZjTEpUVkNJ?=
 =?utf-8?B?ME1sWEluSFlHaFZ3VElxQXdwWDNoVS9UbXBzSW02RHhta2Q1ZG1sd2pVSWZ3?=
 =?utf-8?B?NjJLVUJZc2txeDV5MHlPUjNyeGQvMnJZd0RFZXRFZytock8ydDhrRXRmNUZw?=
 =?utf-8?B?elowZzUwUmFFUXIrSHdPaFZsOWc3a1J2OVpBU29tV3ErUWV0eXN6Yy91b3l5?=
 =?utf-8?B?WEpPTGxvc200YTRKRGtpSytoZVhQRUtJanJ6MTJhNnl5azJ3cklGSzNkNGEv?=
 =?utf-8?B?WEM2OGxkNVFjTGdRWUZqN3hGYVM2aXFIYm9IZjlpWUl5dzBlcWcyb2cyNEZZ?=
 =?utf-8?B?TlQ5ZmszSllHTmJ6QVZLcW4xUSsvbFYvSDVEVlNzR08vaUNweEZhNkhsZ2Rh?=
 =?utf-8?B?SjBGUkR1VFhKQWdud2U0S2RwelVRWFlwUmp4b1NES2dUcExzRDJNSnl0SGlO?=
 =?utf-8?B?cjJQR2dsRFRJL055YVFKeDhuWElrTWZ6QnJjT3ZMOVhQNHFTWjhqb2w1SUZo?=
 =?utf-8?B?VUVqejlvUmZsTzUrQzhPcS9tM2FyRW9wNDUxU1NzUjR5eWc1RW5ISmdLVkVx?=
 =?utf-8?B?UkRyWWhKTWlzS3dBTUJ5MlBXSm5ZNU45cHEwc2Zzcm5icWIwdk1rZ0ZxKzZi?=
 =?utf-8?B?ZVBZOEp4MzZhSnVlNDJDK08zZk9uRXZGQ0pMQnA4aXZlYmY0cWZQYTVzU1lF?=
 =?utf-8?B?Q2hnV0cyQitnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTVZNy9qOEJ6bjZQRFJJQ0VUQnlqcklITGZPK2MxWmV1QzJ3YWc5RFM4Ujl1?=
 =?utf-8?B?S1hXRGtKbXRuVEsrKzNnMGF0djMzQVFqNk1qZjNuVWRMMXdGSHlMaWRpTWNO?=
 =?utf-8?B?d2pNeWNLYWUrRWt4RFE3b0ZBWXFWUXZNTGJpbW42QTZqQ2N1U2RmdkN1ck9s?=
 =?utf-8?B?ZDRjWjNPWFJkb0hYSHJRZldveFFqcm1KdU8yRGswOFVYejB4OXM4d205d2k5?=
 =?utf-8?B?QUJNSitFZ2lsNlRHbkdXNmtzd05xSGVHNlc1VGZlZ2VqL0VsNXp0aEN6ak9G?=
 =?utf-8?B?TEVOaDgvMUd0d1ZUU1dDOUVlMThORm1Wb0FtZGR1eXMxMllzRVo0YW1Qdjlu?=
 =?utf-8?B?akxKVXZ1QWRNRkpwRnhDVmU2QVlCdzdOVG1xVCtMZzY3eCt0VTg1VGNpZHFx?=
 =?utf-8?B?cnBVcmQ2SE1oTzFnNlpIYkdMRGU0ZWxIL2tkN1R4YjNxTmJuQzY5eGVrM0dY?=
 =?utf-8?B?alVHbEt5bnFibHJDTGk5SjdheEZDRzhMU01KTHNKbVBJOTBHbVZNenlwRGN1?=
 =?utf-8?B?L0NCQm5tUVlMaktYVGpiK3J1anBSRXBuaEdObUtSTndTU0dBVEVRcXBDTm16?=
 =?utf-8?B?aGk0ckhEaDFVMDRnTEg1WmhzelVjMklCWjRnRUU4VjJ4UE9zdHlGOFc2Y2da?=
 =?utf-8?B?c0VXaDZxVUhLby9KbS9kdm8xSnB2aytkbHZlVi93cElZTW5RNXdXZlZXUFho?=
 =?utf-8?B?akJ2djk2ckF6bXY1cTNoSUErRi8yemQvL1BqVHpRTnVXZEdWTSs3SXZSN1l0?=
 =?utf-8?B?cmRZZWFIbWxmYmZ4WlhjWi9xVERxNU50Um5LQjhLVHM5SjdtWDc2dVpWc1g5?=
 =?utf-8?B?b1pQOUR2RWFvazdRb0xrZi96M1BRUVNvR1VnWUlUc08wVDM0czV3cGFqbnpS?=
 =?utf-8?B?NHk0SzNXV09tZldqSkd1M3RoRWI0MXlHNG5FbGxNckI2TzNJMkJFYkRLa3lV?=
 =?utf-8?B?bUVDcjF0YVNPVUNvZWZVZHFSWGZObTVWcms0WXJLOW4yNzRma3NLV2hCaTd1?=
 =?utf-8?B?VFFwR2hCRTVmU3ZqNmRNRzE4TE11Wkp6TkpPZEFnRVVsMjZkL1M5N3BOZUR3?=
 =?utf-8?B?TWhQcmZKMUdLSXJjOWFubW9zUkNyaC81ZzRQUWRhbXgzZ2FPU1BlSDRqRGla?=
 =?utf-8?B?MnJuZ3ZCOUFzd3BWUVpEdWdtWGFTYzRSemM1aWU5RzFIdDh2cUI1QnU0NSt5?=
 =?utf-8?B?OElXQ043cUpXaDZOK0loT3VBRjYvUFREQUNvZzFweGU4WEhub0RoOTRUY2Vt?=
 =?utf-8?B?KzR3RE9Qc1gvV1ZsQ0tSZk9WY0hvajJHSWs4RHlLTWVDV3JsdGVpVlZWZEJO?=
 =?utf-8?B?OWdOZEx4VEFxaTNTeFBmQm9JSzBoN3p0NVBobEg3dGx5MEpUQ2NsNlQ1N3lz?=
 =?utf-8?B?RHNOeWZEdkVvbFpWbjZHQWJMMTdiTTZzaFI5bElTRWRCZ3Z5ZE1FRTlVWVhh?=
 =?utf-8?B?YWFkRmdmY1dZOFJPNFlqb2FqOW50cjh4LzdtcGhaQVRJZTlIL0plOUN2WmRv?=
 =?utf-8?B?dlYvajNjM1RvcFdzVTQ4SjMzbHBpLzJiWDRBNDV1OEJQS2dRTExOVDc5bTVq?=
 =?utf-8?B?YzVrL0dUeS9ZbkxiNnRRdVRIM1lQNWVvZ0RRVmU0OW9ONUhZSllDK082RWY4?=
 =?utf-8?B?TmZoYmZuOGdsL2VzN3ZiMzQxVHQ2MVNUWXVCb2t5ak0xU3l6akxrc1E5MlFP?=
 =?utf-8?B?TVZLeC9NcWUvZWxFUkdPOHVUbVlSWlZSYWpRcWRNNEZYck1wcnNyOUk4TmhC?=
 =?utf-8?B?aXk2amtWMUFjN0o4OW5zRmVLSkVpNG5jRjlwZFJvb09TRlVBdmZLKzBqdmlF?=
 =?utf-8?B?RWpwZVBscWFkYWhUcklOWEhmK0Q0d3J5Y0JlU0diTGF6TTQvWjl2bncrSitH?=
 =?utf-8?B?MlU2VzZabmVEZmlSMjZrVm16b2hOa3FTc21OUjMxMFhqZ1FXU2lacGVEQnox?=
 =?utf-8?B?WDdXaWprRjlqSzY0S3UrRFMrcTBMU3BLVHpuNmpRSGlnQkRNaHM5U0tRcVE1?=
 =?utf-8?B?NVZtRnhpTnFMek4wOE13NE9EdmpBY0xteUtzVjJkZEFpZmpyNnpRR0FxOHU1?=
 =?utf-8?B?b0NqbVh2QXp3dnJTTjZjcmlIWldjZForVFQzbFBLZTY0MlpHdWJWS2wvbmdH?=
 =?utf-8?B?TzdzZmVXNkpCUFkrdkt1TXNWNUIrU25LS2w2b2NIbVdhMjgvOHJpaWJDRnFR?=
 =?utf-8?Q?vdmiLkPV7Iwx4dYuUx80Q0xz+NOmfx0UnpnD1uCc3wnT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <390029C62B957449A21897B7BAA1B6CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab93c00c-dac3-4d4b-5867-08dd76e3c00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 21:24:30.7508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMxUJbyReIQ7ykeisBPpLWJl/4QXX0Pgm4VDnlfIPoQl0QZ+GJBaiiLAE5DQYWIe/g938zxi9cnFBxgDEt3TMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_142435_382038_11FA0083 
X-CRM114-Status: GOOD (  10.89  )
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

T24gNC8zLzI1IDE2OjIzLCBNYXJjZWxvIE1vcmVpcmEgd3JvdGU6DQo+IFRoZSBzdHJuY3B5KCkg
ZnVuY3Rpb24gaXMgZGVwcmVjYXRlZCBmb3IgTlVMLXRlcm1pbmF0ZWQgc3RyaW5ncyBhcyBleHBs
YWluZWQgaW4NCj4gdGhlICJzdHJuY3B5KCkgb24gTlVMLXRlcm1pbmF0ZWQgc3RyaW5ncyIgc2Vj
dGlvbiBvZg0KPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvZGVwcmVjYXRlZC5yc3QuIFRoZSBrZXkg
aXNzdWVzIGFyZToNCj4gLSBzdHJuY3B5KCkgZmFpbHMgdG8gZ3VhcmFudGVlIE5VTEwtdGVybWlu
YXRpb24gd2hlbiBzb3VyY2UgPiBkZXN0aW5hdGlvbi4NCj4gLSBJdCB1bm5lY2Vzc2FyaWx5IHpl
cm8tcGFkcyBzaG9ydCBzdHJpbmdzLCBjYXVzaW5nIHBlcmZvcm1hbmNlIG92ZXJoZWFkLg0KPg0K
PiBzdHJzY3B5KCkgaXMgdGhlIHByb3BlciByZXBsYWNlbWVudCBiZWNhdXNlOg0KPiAtIEd1YXJh
bnRlZXMgTlVMTC10ZXJtaW5hdGlvbi4NCj4gLSBBdm9pZHMgcmVkdW5kYW50IHplcm8tcGFkZGlu
Zy4NCj4gLSBBbGlnbnMgd2l0aCBjdXJyZW50IGtlcm5lbCBzdHJpbmctY29weWluZyBiZXN0IHBy
YWN0aWNlLg0KPg0KPiBtZW1jcHkoKSB3YXMgcmVqZWN0ZWQgYmVjYXVzZToNCj4gLSBOUU4gYnVm
ZmVycyAoc3Vic3lzbnFuL2hvc3RucW4pIGFyZSB0cmVhdGVkIGFzIE5VTEwtdGVybWluYXRlZCBz
dHJpbmdzOg0KPiAgICAtIHN0cmNtcCgpIHVzYWdlIGluIG52bWV0X2hvc3RfYWxsb3dlZCgpIChk
aXNjb3ZlcnkuYykNCj4gICAgLSBzdHJzY3B5KCkgdG8gY29weSBzdWJzeXNucW4gaW4gbnZtZXRf
ZXhlY3V0ZV9kaXNjX2lkZW50aWZ5KCkNCj4NCj4gc2VxX2J1ZiB3YXNuJ3QgdXNlZCBiZWNhdXNl
Og0KPiAtIFRoaXMgaXMgYSBzaW1wbGUgZml4ZWQtc2l6ZSBidWZmZXIgY29weS4NCj4gLSBObyBu
ZWVkIGZvciBwcm9ncmVzc2l2ZSBzdHJpbmcgY29uc3RydWN0aW9uIGZlYXR1cmVzLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXJjZWxvIE1vcmVpcmE8bWFyY2Vsb21vcmVpcmExOTA1QGdtYWlsLmNv
bT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

