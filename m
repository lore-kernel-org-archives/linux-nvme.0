Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA52AD1950F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dx3xV0xhRCBD2chMiGFKMtjo4B5k8cp+IUY26RW8ooQ=; b=hF7B3JQ9QncHfSLDT/FWuSqRfi
	GKTgScaK24eI5CK5KDRcSSBRRG1T/EjJh47Xjc7BYA6uvbOi7Tbe6p/8fBrciJC59hXJ8LhXbcTYK
	/4KqrIchXTs20iSeg8M4/15wULmQsqySsc+KxxtvzwhNKzWgOeshPc0F1xkiBTUfcnP64c/G8YwqB
	hiLSqamfV0TI2j8c/ywPBYnusgBn0uBoEK6O9qZpoz3h9fQ2YoGrHafW2SbhJpXGc46gQ7mVfCSAX
	6LlvgQnWwpf6jvFuckSJXMLPhVglkVTlVl9qiIhE5kc/XwnOkr8i0LjhWLXVS/ZDLgJEwOv27DZ1Z
	XVtnafWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkRET-0000000D4Lc-0Lxv;
	Mon, 26 Jan 2026 18:22:37 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkREQ-0000000D4Kx-16dR
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 18:22:35 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QH6aJo750426;
	Mon, 26 Jan 2026 18:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dx3xV0xhRCBD2chMiGFKMtjo4B5k8cp+IUY26RW8ooQ=; b=
	mPry7XZTAOaLyC6QszTtEuQZooAKwlNrnmyZK6p6L9QOUl4GTjYsRcGIbITYMYkJ
	un0Lqt8JJVzp83gbdJ/FagAR2C1Q37tR+v6wwAUqKp+BdKpv0FHhpSOO1JivGudn
	yQW5PaywYKAPImff/9WqRVuKJVDBzFVfIto4jQ4rMStRX2K5KVvq20M97i8Aw70g
	0EZ6u4koq/+25UwCpY9EppUmlpcKD1/F8VjtR8O/1lck3x071Aspx0JGwy18EaUD
	cR9wMHS5HtcPfo8yrtvh1QOV3qqqhOwrd9U2tVm3hBr5YVMGOcSS5STyL9PRyxnt
	69bfpAb1RRQe7GMCW2MonQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2tk11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 18:22:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QHI5Sx036072;
	Mon, 26 Jan 2026 18:22:19 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhmjb68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 18:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsBUtYb8MJBC4lfTxJ2BGOFrV/smjd7eMLOIS/gA1uOaWy0tfjUOSZ96Th2jlcRe6YP12UzsKcWmt+w39GmR69pjTf3StyGSYLq+feJvvbNqZmcn85KEu7gjN0IoHKMEW4LHIvODb+TjgtBGp3jOIz/FGoJakDgey7DyOHRKoOUTPls7RnWuBbYzxiWgi1XwDI1zHjEen5eGs5658TkspeMPKlrpEPqzOBkSwiNi83zOeVMriToT+Mg9l9Pz8c95Gwnwf+smQxk+unblGjuDvqfXCeQYtCK5kNqdE669OcvjOB7tnJWZo6imjnctoxVcb6hXay7ioXhFFBiMTi9UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx3xV0xhRCBD2chMiGFKMtjo4B5k8cp+IUY26RW8ooQ=;
 b=YqBBA/Hhv/I4JsP1vR6bqouqzVdh2T44NAsvwGlMM0wLfiaPhGJDBUqKet/ajoJ9pMe1f10GWKrz2GvXxJiR9aksZ8L1vvluzjknQl93SoN2K0tHNrgekLBelIJeHVfV5GbUFIi606KZzAlwBya7sUzm/aG13gQnCgIIHOniQQubf347yfpcOqcACV+BhY/Q3VynR0clWh3PHJ0cabYtKUNu/tTA+capFoXUD3MYnA6g3qGcdyYAIPnzoUCTKd0lSuJR+jH74WE6YfAYPGDGGfsJP6dYX4zb4aHllFMNoB9rouNbrvXIjQLpo/lSyOrkfCb/Eh/q+mwZK+9yWHg23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx3xV0xhRCBD2chMiGFKMtjo4B5k8cp+IUY26RW8ooQ=;
 b=PU8ZJe2/OfxPlmiP2C4PnPU7qEI2x3FIYveZOjSLbTV17P64qXsy7mEaPSZT+v0WrwDZP9a3hOr6Q6jjJSbobCpwaA0pIiSWWgqwEjyehSSncg8AMb/fy4t1q62Oodbs0CY2zIA4drFlMScjPr2pdIgVbwAxyQjR1duAzEia4bk=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA4PR10MB8731.namprd10.prod.outlook.com
 (2603:10b6:208:56f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 18:22:08 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 18:22:16 +0000
Message-ID: <9f1997b7-e4bb-42f3-a0f2-d48a8c4dac9b@oracle.com>
Date: Mon, 26 Jan 2026 18:22:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: use NS head lock to serialize access to NS list
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org
References: <20260126164552.3379194-1-john.g.garry@oracle.com>
 <aXefchA1e5ShuVnz@kbusch-mbp>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aXefchA1e5ShuVnz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0656.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA4PR10MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 28cd4b43-55b1-4427-8e8f-08de5d07d57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1FLM1B6UGh4NmR3TFgyNFNlbGlYUHQ1YzBDdFpyK2NWb1I3RE5RdDhwZjRP?=
 =?utf-8?B?T2ZRdHVUV0czSWdObEFKcHR1ZU9HK3dFL0N2c3djTk9GVWpkU1k1a1hnOURq?=
 =?utf-8?B?azNJSVJVZVhwNlpQcUNTclFNZjE4K0VnSEJaaU1XWXdxZXlzM0VWN051bGFV?=
 =?utf-8?B?WGNSMUJTZU1sOFo3cGJFRTMzOHRTdFU0Lzh4L0Jpa2I0aGIvSHdlU20xWGdK?=
 =?utf-8?B?R3UwbjRsYmFZNnlRazdONzlQeEdaY0REVnRMU2s5OXZBNVRFa1NwWDZJR08v?=
 =?utf-8?B?MkJyeElKL0xGb3RlSmdQamNDanNWQit4YjNSYnVmYjhsM1ltWTR2c3RsUnpI?=
 =?utf-8?B?MVJ0cEhGdkdCa0hGbDFjbHR6dmgvNXQ4QlF1SXpmMHVteEpuMm9qWmEvdTV0?=
 =?utf-8?B?TlF5eXZlaFVYN3VSWkhweWhwQTg4YmJQYVNPcGk2OHNMUHlVSTJJRmQyaG5Y?=
 =?utf-8?B?dWhhSVBjUk9CQ3dNbkR4SUlKZHBIQmw0S1lBNHo2SzJUSlMzcm1nR2pkMko5?=
 =?utf-8?B?QjhHVkkxSWN5UUx1RENjNmhzY25Od2tsNzBxUXJhN0hyT096UDZ1Mm5VT2Va?=
 =?utf-8?B?MjJiVFpUWVh2cElwZ2RBZEpVYTMvWWYrMG5ZbTNPdW1rTkVJcE1NaW1Oa1ZB?=
 =?utf-8?B?TWlHUTlTWHBuMUd3SWl1dTdmOXpKUXlUcnN6STc0WFlLTW9ieW0vaFRmU0dQ?=
 =?utf-8?B?aG1jTUxBVHY0QUZPYmtyZEh5dXdwWkg1ZEp0dmJjZnRTaEJpUjMvRitNUXJT?=
 =?utf-8?B?ZFRjdnhKbkJwL1VZK1lpbzNZMjhXZUF5U01OZkx2REZxRE8wRmhsNTNmZk1L?=
 =?utf-8?B?ejBqeU9YbU11RUtxVlJMR0puNWpuZ0NMWUJ6SkRDbmpEckd2ZFlUeit2RkZx?=
 =?utf-8?B?QTh2TUlISVcvVm5QOFhpOExQRXNsRS9RRExCUEtCb0NtMUFKRmt5cUpldG10?=
 =?utf-8?B?S3hOSU9CZE1kR0hPZmtkVm1nOS9Ua2VPMngvNWRSTEVJY0ZIeEZ2UXBmdjNZ?=
 =?utf-8?B?cDUzeHFIaXdjYk1RT2ZFc1dvcXFIWVV5Ni81WVJtMytIRC9vWGtFbklXTHFV?=
 =?utf-8?B?aGNHaEVOM1pGbm1NTG41LytQTXhoUWU1STd6TzUwSjAwcFdrc08rRFhhL1A1?=
 =?utf-8?B?SUdBNWdhYWgyZDhQemhTMmM1Z0RybW1FZnVkSzFDekpZTG1NR29TbkkwV3N2?=
 =?utf-8?B?c29VRWJRL1VKZmtqK0NDOEpSNzZjZWJvUExGbHdsZjZydjFudE9pSllIRE14?=
 =?utf-8?B?c0tlV01HajdlenFBUGNubmdWWENiVEFCWS9kYkNmNjY5QTNwMzlIMTF5aGJL?=
 =?utf-8?B?Vm5yckwySTgva1RPV1ArQVFYUnhpWWZ3T2NOUnlOWk9wSlMranJ2cUtjVTN6?=
 =?utf-8?B?LzhmQ0VzaTdORlFiUk96MGJla0hNcS82RWYyNmEwOFY1bU1KMFdQbzQwN0dZ?=
 =?utf-8?B?MGYyNnJnSUlwbVI3b0NoajZocDVnZWVWdFhaZnJ6S1Q3Q3lTY3YrVHRhbnlo?=
 =?utf-8?B?SStwbzJNOWVhN2FjM1BEczVLZmJqejV6Qm5YMmtpUnZyQ1oxOGYrc0ozcDVE?=
 =?utf-8?B?N0dNb2N2ZUdWNzlZaGU5aHdpUlp3UXFZZmZWV0dLWjF6c2ljNkZUbUlqUFgv?=
 =?utf-8?B?cjU1OSt0L0pWV1JSeGV3YnZlK293R3B2WjhNSnJOYWYvYVg2L0Z1Q2g5MUdZ?=
 =?utf-8?B?WUNKazAzbDRML3RyWERhVWo3MUp5bWl3NjBFMEMxZC9rYndrVndhT3U5YlNH?=
 =?utf-8?B?dzMvZ3VqK0tTbGQ1WGFZaFlGN3FRYzl0U3NWY0M2TnMvMlNJeXozQkRINEkv?=
 =?utf-8?B?eC9NcDV0MUp0ZzU4S2wvVFBKUTQrMk9zKzkybHl5dzF0NGRMY1FGa2kydWRu?=
 =?utf-8?B?YUUzRzEyM0lqNW1xY2lXSlJGZWNMUTZRdGRPYXlFUXFWekVoY1FZRy9wamlx?=
 =?utf-8?B?RzFEOHMxS09RdFBzbERoOG1RZmxTd1ZCRDFUdVJweEdPNG9WaGVWbEplbWg1?=
 =?utf-8?B?eUhTbWFlOHVpR2gwd3VrSU90VFJFSm5aRjV3RGNBVHhQMGJnaHd5QkkrMFVC?=
 =?utf-8?B?YlZWMXdDL2twRFZJM3Z0dUF2VXlYcktXcExtK2t6cE42UlVSWjZaTFBYVG9I?=
 =?utf-8?Q?zMYk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3N3aHBhTGcycDRRdk5OU1JtQVFSWnVvd0FmT25DcDRyQ2ZBb25idHlwQ3l1?=
 =?utf-8?B?VjJtdXNLbUE1SFhod3pUK3pUMDc5NWZUWmFOK1lLd3o3TUFMUUNtY0xjamda?=
 =?utf-8?B?Z2VmOVR4eWQwRlhpc1FtblRsT2RZKzhHVlQ1Y0RXdjNkVXplRnRVK2hKLzNk?=
 =?utf-8?B?aGVlbHJiNmRXc0FNT1hDUjlUc1RzOUlIMWpxR3hRSldXQXhBZnM0NVVUbitq?=
 =?utf-8?B?VG9lY1Q3VmZhdDRQMGpzY2w3S1pZTFMyLyt3VDJMNFVSRE9wVEswa0NHR2p2?=
 =?utf-8?B?RHoxQ2tsTGFnZmFLbTdBQXdGbzRPN1NHeEZ6YVdRY1V3ZHFMZ0laTW0xZCtW?=
 =?utf-8?B?Y2dscnhNQWU0Y2Z1R09TQ1lJeE1OakxnbEs5ZGJ3NmRhTEd4UlBxNTgzR3pS?=
 =?utf-8?B?YmVycTVsSEhxZGcwdmRjVFFoZW9QYnFqRno2NGhrQWF5cktGL2N6bW50K3RP?=
 =?utf-8?B?RXNwWGJ4QW5VTVNaeEQ5ZUp6UXhGcDVnQmZrRUtHSWFWeEF6MUd1QlRJdENO?=
 =?utf-8?B?SmVrY1VsQzBBWW90bFZGczlZemQybmFabjg3MnkzaTVTNEY2ZDNOazZOVGE3?=
 =?utf-8?B?ZndUK0E4K3VzazRnaVhLb1RuRG9wVDMxaEpXYm1XT2Y4d0R1WDZZbDlscFF1?=
 =?utf-8?B?Z0VOUGNobkhqM0tEY0xzNS9WN1JWWDljYTZGamY0MCthbWRNVWRUZTcyWTJT?=
 =?utf-8?B?cHNjRTBaV1BaL3pJSjNwaU1qQ0hyNjNEeWhZYlhHSmg3VnN0OEo3ZGRpRy9B?=
 =?utf-8?B?L2tUNXcwQzhIT21BQU5taks3ZEJUQkRjRWlmM3pIZ00xQ09uTk4zOHFjUUFT?=
 =?utf-8?B?bWZaZGl2Ris3TjB5WVRJM3RtUjZkWkc1ZnNZOTJHQmNrZEx5ZkpyNGRhQzc0?=
 =?utf-8?B?S2RPbzUyY1I5U1JZOTZhcklDY0I5RGdKNXpZdXJEdkxaZnNyTFlmSUNNcTF5?=
 =?utf-8?B?RTFsUmF6MXBlUW1QUEw2Vzc0R2IySHNxM09keCtveG5vNlM5WVpmby9BcUR5?=
 =?utf-8?B?OGlPdHpZRUlsS2ovcGI2alpNUVZmT1FpeEgwYUJveVhkZVFSOC90ZUExUG5N?=
 =?utf-8?B?RWdNa3RwK1RaYUlWZStkNHFEdmJCZ0lLYnhxK3ZpL1F0eDVJZGlob3BtdWpO?=
 =?utf-8?B?bjNoTGY4MHoyUFZnK1A4VzVzbDkydDVxUGpBQjY4YUlCaEFvelNPbGNLNXdG?=
 =?utf-8?B?clprcFA4V3ZZUmJVTEl6QWFFRnUvRXc2YXl4QTR0MGVNRFZLeW9ib0kxR0hu?=
 =?utf-8?B?MXhHSzcxakJCRkRtVUlGL1loRk1JdVRkY0Z3WFlhdm8xbUw0clZPcWIrU1Jx?=
 =?utf-8?B?clJIMDRUT1VOOGUzRDdYSEkvSUZEZjFPUno1dHNLSXdSZmd3N0dtU3ZzZE1F?=
 =?utf-8?B?MXJRdDEvaktpNlA5SUZqc09iV0tMRi9jK01meDlxMkpYQTYxdzc4d08wcG9P?=
 =?utf-8?B?dG42d3d2d1Y4bXZyYVRXVHRMeC9UMVNEUE5VYXE1dExzVnlSaGl3d1BlZFFB?=
 =?utf-8?B?MDQvNHJQSWtwdFZ5UVNKMy9yam1qb0FXOGk5czZPamJqa3NFYnNpclNwVmk2?=
 =?utf-8?B?aVQ1VHVSZmpnelVTRU5mNFdkV2ZZaURHaThZNHpCSm9UY3l3M2F0aHQ0VWhu?=
 =?utf-8?B?R1hNNVZuY25KQVpsT1Z5MnptWXM3VE44bmp2azBaVHRSOEZTVyt5UGJNMXN4?=
 =?utf-8?B?a3FOemI4R3B0ZUExcW5aa1JyM0JwbHNyOXg3cjdLdFA5VkZObVZCQ2QrTHdQ?=
 =?utf-8?B?YWdDMDVwZHhWVmd4YmxWSllIV0VpNGI2UVNIS3Nqak1QVEFDdm54ZmlQNjRF?=
 =?utf-8?B?WjUvd3lIZXk3UW5ieHJPWHlVZUFxSXNQSkJUWjBTaXJKRGM0dWZUOWNsYlY3?=
 =?utf-8?B?Z09KTlZQQW4yRHVZblcyRWxYOStOMnJzUSs5eFB0U2NTYVE5TU5lVWw1OUtN?=
 =?utf-8?B?bkVDblZRbjBjdnlkV2diUy91OUowNHJYSmR3ZDMyN0dvQ2NMbDliN1BPVFBr?=
 =?utf-8?B?Q25mczl1bFR0RDR2bktrb3pVTlgzczBjVVE2b3RvZnprNG5NQzRzYlR3NXhh?=
 =?utf-8?B?RXFFcUo1T25jWmZ5bFdzUzFmeW1XSWg5Tnp0QUhzcXdxRlZHRXNqejdJVjFT?=
 =?utf-8?B?cDlpVnlHaDB4MnJHLy85KzJzalI4cmowRDgyck9lYmJES0I1NTV3NlkvWHcy?=
 =?utf-8?B?SVVTQkhWSGo1Nk5acUVQNVNndXpFQ1pPL3l2d3FpRy82OFc4aUR5eHJ6dzhv?=
 =?utf-8?B?MEEvdThCOWlMWFI5VmtMeVJKbGRPNlpiVDQ0aFAyaEVmTnMzSFJaa3Vla3Bx?=
 =?utf-8?B?dFFxRjZHMjdWVlZnOE82RFNpc2lwNlo3MWl3UU9CQlphRFNLRkJ4V0xwcnJY?=
 =?utf-8?Q?wlTQkmwSv/7+dtTU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rAuBgGYY0/PoKl9z1u9DyKxrcyul2siQBro+6CLG0AlUjf0jYs8tPqx/mVWYp3mdhCML3UGPkcHaoCufJ672byEj7mrDeFPohcrWQ94OdkrfcKdbffG97bVxJPaZyJyZNrYE9FuFUaGAhLG4IF+2DiBkmewt8F2PuQZ0RpRv+qtST2L3gvEVCGTuPW41cMIi8lV7uuQeMaYfGlul/DnUwfrZCuhJqgyXtPQ/3WO9XUEfJi9n2hqAe6+Nqir1EIzGa3k2owt+K5P+o9WhfIDmeFcww50UAKg6fMYanNxavhP3QZ49D54ErSe1WrqsNHz49jfQ3iyTrShP501fHwDgmC4KpBvcmpO2QzeD7Df4BeKxulYOpwoolSK3jpJPL2tAxxlIQZa58n0JY/o6FTAHRq5OzYVj/mRQ8RxhQ0S7y6kB9F4dBmKtmoj3Kn9p7wDviHmKdbbDTRD4aBo9fcxQkz5UE4XV/sCBsJ8EfGRlELaQ9GlMJ7j9X2s6c+m7ieZG8EZZCTagR+XIBETqtTot5ZSi2/HLO9H9Vv7/Hi4Wuh/WaF7m6pXB1yZAHEMi2hkCtU47Y+ghUHOskUR6PK4bSPA1/rZ5DPV+AxWEhpUzA4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cd4b43-55b1-4427-8e8f-08de5d07d57e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:22:16.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZQ0OXPKnKZshdOLpxvmWZlYj8oNx/UtL0TLmQNPaov3GeF/ud4v5ABVQH/dWFQq0M9pxG+W3pwW1qlnKFckxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260156
X-Proofpoint-ORIG-GUID: 7EjUlMOVQqN3n8vHec0Y5QpB5-lPjeiN
X-Proofpoint-GUID: 7EjUlMOVQqN3n8vHec0Y5QpB5-lPjeiN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE1NyBTYWx0ZWRfX+pIRAd0o7gOW
 XMXNQgxGqm3VjaKTIKoGG6yeRQl/By0EeH8gv5jlgG0DRa5wng7povSnkU6IzLunUmyaYG3VPPp
 Q6Tn26+GV63Snp57744tg1ueNg6R1Ntt7sw9AdU4ykvYEy56rUQy5y//mkleKr+bTvV5BKAAEpb
 v4mxIDJEn2xSwkjHedpkIf+nEfMR0ysD5wTWmBVr06hULjyjm/pNO968RkZm/TF2OHov0ff+Ylu
 rMCcztwyUahVT9mAJZdXvRwsVKynp2uLAvJGftAsfMEd4miKRXDZ2Lee8/tsjtQSt+IEfs/0OgS
 GmadTAL51vd8E5Be2V7lCzElwLhXg5zK73BxWWNBH+GpEj4116lJUonMYDM4bB84J9sPPmz2ngS
 +b65PzSTw7eVzNBDeNjE+gIVjrRzdNt/EDRoCUaFppBMsocMJ9UH7Gfb4LzbB/j41FoYU1OZkjY
 FISRfm2o1we6VUCzc28GNlerDUeni4N3HVeTFxns=
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=6977b0dc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=O6WeB3KjzENcgDkRtc8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:12104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_102234_449000_B8AFE203 
X-CRM114-Status: GOOD (  12.44  )
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

On 26/01/2026 17:08, Keith Busch wrote:
> On Mon, Jan 26, 2026 at 04:45:52PM +0000, John Garry wrote:
>> @@ -702,12 +702,12 @@ static void nvme_remove_head_work(struct work_struct *work)
>>   			struct nvme_ns_head, remove_work);
>>   	bool remove = false;
>>   
>> -	mutex_lock(&head->subsys->lock);
>> +	mutex_lock(&head->lock);
>>   	if (list_empty(&head->list)) {
>>   		list_del_init(&head->entry);
> 
> The head->entry is linked into the subsystem's "nsheads" list, so at
> least access to that still needs to happen under the subsys->lock.
> 

Ah, yes, I overlooked that.

> The other lock changes constrained to the head->list usage look fine.

ok, thanks

