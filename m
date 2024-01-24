Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48830C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cTAyHx2RAjuKnHP1zkSDtZaahDWDY3P6E7XmnrRWkE=; b=gjaisSYTi00qAGZ5bRyB5HU2T8
	1EfhAj8ct2cnPfPhyIXH8FvNFj8ukRzn2rQ2lLXDfNS//ebJim8Mx/bg/MWdIN9UFqCBDwBTUQjhz
	yoezVUwAhZWLrWIrwWNxAicHRmCkOtPqxpFt8l+pd75tSqJhJOWsKiGukoRKEb2MmHcdKyd24qOY+
	Tpy9Hs0cpavTVgeJRm4Upgb4/Vo06JOVUWdQx5CqRHjTjg38Fxp0WANk3ZosmTSf/e1pamp846kWt
	cbbAKAkzByWT71drvSPx6UKdtqL0mrSIUWoHayVbbwjT/MScPnTGFstNjoeRm9xeMmSHzEklCa+gk
	nGMYKdwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSglp-004Nut-0C;
	Wed, 24 Jan 2024 17:10:37 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSglm-004Nsm-1T
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 17:10:36 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OH2irS013004;
	Wed, 24 Jan 2024 17:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1cTAyHx2RAjuKnHP1zkSDtZaahDWDY3P6E7XmnrRWkE=;
 b=CbxvK1xQvTTFbOlIve0xLvTmQEZpULXbCeuItcvNJs9/0HU9lsshDu9qv1cX/3/5jdwv
 z+zQF+tAP9jHQIcHVfa6lUHo1vV6RWjOViN0Xp4k/h6XemLT7QrFTbzN3sH2429xluXY
 E1bTS6J3dELO9c0Fr6SkzkAfVe9OPlZJ34+xU03TNTcAEFJUQXlkICf3gMYqbUMW07C6
 VI+x3WIBDshTxX4xpe5ry96NuRPxOjSJipu7bi3k8o8qftK8qtsVff4ekV9xjvXZBRej
 qYEvzErFGcn+lTW6IM3aCu82IDeFm2gkEJaQNvprjmNIk0i0TvhpfNCIzVL1vRtKUL0i mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy3xbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 17:10:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OFul6b003979;
	Wed, 24 Jan 2024 17:10:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32t1xvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 17:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjk0gVqhgteMHKe4NtWbM48PJmJue3IiseTFLPCkRlqVsJqada2NnGHnV3GWUnQ9rAVxuqemwa2bcweTvx5A1GfltswlhpcuhUhFe4q6Z+6VGWIWVgc7fy4F1jQrNsxmXifmMXilS2sXPcfyLHK5e+UzFOTz6PMXkmmiwxCUXbgQeSlBuZtTTtXmqFzV7vCPNBScyzrKj4S9pF/Y9a6m4cnhtKZstpiIKc7Gu8rsQ7Y5QYHSCFXTOzUzZb15JmN6yv2AuqBEMW8KahC8MhqwIUvcrBwgDd4vCnGLPjxIOnu8P/zTQx2z2Xz3b+N5ASU+n9cfRDyKQy8mU+Ngh3PKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cTAyHx2RAjuKnHP1zkSDtZaahDWDY3P6E7XmnrRWkE=;
 b=X1Z/OlrHqeAVXpgLFlioPlxKfLrjEN9+HTOlqE+jGGxuh4saPO49pBxoRtPBYqe+UM9g1xEWgUZBPIm2twwziKCe6JKUfmOAzPqFWhlMI3mCvwhaJL7eghnldpNy1uaq/cYePJ5Q4kF+bEUEnlXA9dATVdhL0y7UiC8zFDtXnKA9QtLc+Epfqv/NE+5i5nDc1mj0G0lnL+QTUGI4KbLpsobblIJLdOHXJccGmxvcm3cuuS0zMfjbMXpiVLF+w+P/SbsvX+BJyLdZnC/6/U/MhWFsCnKlJlussmYi/AGMnMZdqyzz/UuMaK3n4LL7lEZv0HNY3o/vhhxB+jBWOnYKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cTAyHx2RAjuKnHP1zkSDtZaahDWDY3P6E7XmnrRWkE=;
 b=CrsYIKPFUm5//GHXe/ySZjYBUKcxLPb1qJxXskMLrwEi7jYDCoaJfXRgtapnODEn6rFp6irwRpiJ3mdYBmkhfrZg+OJfJmsMiLA1FbIFXYinqqVUqNeBF5crfmb+YnchmQFfa+L79XlGPNKeA4lXhEb0t96n0523sxFweCqnmes=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:10:21 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c%2]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 17:10:21 +0000
Message-ID: <98337a29-2f51-413f-b886-f3ed0933f2d1@oracle.com>
Date: Wed, 24 Jan 2024 09:10:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
 <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
 <5a9a9473-7a32-4808-8053-3668ca3cb49e@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <5a9a9473-7a32-4808-8053-3668ca3cb49e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0491.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::10) To CO6PR10MB5537.namprd10.prod.outlook.com
 (2603:10b6:303:134::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5537:EE_|BLAPR10MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fbe3e6-0cd0-4c28-b5fc-08dc1cff590a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sHLVwQixxrCrG4RIAyGL8vdvW7h6x1JHZUsF/S3RLgRar/ShIj6WcgmLWruLEyzPn+XOgZQJUQS7Pa9jEiV8Yd5z8b9fNJSUGN62N5LPxN+pDsWPw0GDoGkBuAe7aLrw9VCclnCRHIVqf5EKi2VnLNqY+7WbYz1ePK09a+4FARX14b66yMeon+CPn17eDLFoenuBRR90u/jECGDelWXA1lPtNkyd38Gamxo/PLDV/rasvKe3jZP3QNp26A+tqu15rSQ1NO8BcLfm8sibiuSD3E/f8aXPIBCEd/mUA30Az06+WAKzh/Y48NUpnrisiGYupgJGk74pxJDmJ7aHO3jh9xGVNHJ33HWefB8Xz/YU1qan2WoH39VJQm1k6LmBsZfSwfaHM/6Ilj5ocYcjpzwQLmbc4OMl8Yhy1wy7Bbp3aQ18EDVU49ImdOKyYGKKDULLvsKBgzuZx9fijkoewQdNvstq1ods3vkb4d96aX8CqN/FxZKQ1MK/JImpsSgv6csFCk7xEFCx8I2F19AlP85mtNeSfxl6Rh07oCFVmEXerhlW+PoljPyYG2xzDc9N9GCrq+aj6XWwwB3d9uHrPUCziFEsXLy4n1Pbjlpgov3RcAEQoWv39IOiVrmkieyl4UG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(66476007)(6506007)(6916009)(316002)(54906003)(6666004)(36756003)(53546011)(6512007)(86362001)(26005)(9686003)(2616005)(478600001)(6486002)(41300700001)(38100700002)(31696002)(83380400001)(4326008)(31686004)(2906002)(5660300002)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpqdDE0ZGRTczU3SlhMcmtNMm5VODJDQ1FHdHB4RmRvcnkwZ2J4WWxYTVJn?=
 =?utf-8?B?NFNUNURuUGIwQXd6cTB5b0hhaDlDVmtacjFTcWhmdTNLUnYrVDVWcHpvR05S?=
 =?utf-8?B?UDYyUDZIMGlxZzZsYjg3UmRNQzhjTFVBTXRUV3lnNVZzWTlzUEZwcG9Da3RT?=
 =?utf-8?B?QWFHUHIxOHZLOUdBa3ZuSGorb2pWSVhZZHNlWWkrOHJBTWFvdjJWQUM4dlUw?=
 =?utf-8?B?UXlXWDd5K3BkMkJYckM4MmRkZkgvUmRrMXN0d08reGlRRlB3N1dmOGJyVFNL?=
 =?utf-8?B?RlZmM1R3QThMNkVLdkJESVJ4bkFOWnkwV0pHMnA4MkJMQlZlLzJkT2g4ZERw?=
 =?utf-8?B?cUtCRDVWQlRXUUFNOENUdjlLNEhidDFhWkVBdGliY0JxWDE1ZUtFei9kcDA2?=
 =?utf-8?B?ZWc2VURZak9tVXpNeDI2dk5DYVBvTzE1a2VRR1pTUnd0YUFTU0YzdGQrWTZI?=
 =?utf-8?B?Nm5SNnNqTkxFckF3UTlYTk1PVHU5SGpTV0ZqdVRIa0ZoeXBiMUUvYUI3Rmtj?=
 =?utf-8?B?TVA4aDgrYVY5aWdoMTZab2pjR2Q1MTE1T2RoYzFtTGdWUFdjUVY3QTlMU202?=
 =?utf-8?B?WE5oWXlDQW8vcEx1c0l5OThkWEpjQWo1dlZaWlRPclJsZWdlMC94a1Z1L2hj?=
 =?utf-8?B?UVJNT3NMd2JtT3ZmK3lHUWRWVzM5VHk2UjFKVVVWWlJQV2gzNUpHL3dmNDEw?=
 =?utf-8?B?R1B5OE1uLytyWkkxRE16RjJQSHhDWjdPMTk1R3JWQ1RJcnFTeU1iREhSVzJH?=
 =?utf-8?B?dWxucTZvM2xlUTBJc0JBdVJ6L3BpV1U2ZjEvWWRNenZiOEZkZnVwV0dzYkNF?=
 =?utf-8?B?WWpIdUZTdWZBSU5DR01CZjNEQlJQQk1mWnRZT1FGRm1jU1NoTWdVMlZCaTFB?=
 =?utf-8?B?NVJ3Q29KelZhdGNlNUxWcm1JbTZPQUkxcE8vUkJoNElnRnJmc1pmZldvSHM5?=
 =?utf-8?B?YWlXcWJ1TzB0YXp5azNwamVIVXBybnp2T3MwOHFGakgvbThJOEdMeDBJQ3Jz?=
 =?utf-8?B?cUoybVZHTWw4S1A1TWpPcXc5RUlRV2VGc2wwT0NxN1JuaVJabjU4RXNobC9M?=
 =?utf-8?B?QzdQVlJrTGVJU2tJUlhkcnU5WE5yWVhnSXpROGtRays2aHd0M3E2ZFZyR3lr?=
 =?utf-8?B?RS9mT0hTOEVjZEM3M1FZZzBuY210ZUJGK2VFTFBmejdrMjQwMWU1NHhIcXhy?=
 =?utf-8?B?QitzckJPTFZjUzZZWnF1dmVhU0IrZ0RlL3BNZGFRazQ1NTNiNjhpVXFoV1Ez?=
 =?utf-8?B?RGxoRWpZSUxaM1VNQTZuell3VU5IZ0NsYlB3UWwxQWdEQzMwTHJXOHhBeGFs?=
 =?utf-8?B?eEVwYUdFelBNbkNZM2FINS9QQnFDQXM3S2RhbHVjRE1IdzFzazduVlFQV1ZQ?=
 =?utf-8?B?d0Z2bjhsVEliREVsdUM5aTFwRGF0RW1hL29wcHRXMWJEMHpyQTgxL2dVcnpl?=
 =?utf-8?B?UUxHUzNSaWFmYVdRcTVRT1NibTlYVVk2N0hVOXRtYjdRdEVUbmhUV2JIZ3Uv?=
 =?utf-8?B?ejNGdzg3SkNUVE5DcEFDUXVRejNQTUViSzUyQkl4aGYwVGFnbHF5RnV5NUdq?=
 =?utf-8?B?NDlZN09jTDFQdnYvMXZjZDJWSTF1Q0xqRi9jSXUyc25QRDlRZVRna3B2NVMw?=
 =?utf-8?B?aU41dEVlcU1WVkJ5ZytVTUlKN3BjRlZIT2l6ZEM0MTFXWk9oS3k2U2IzR2ZM?=
 =?utf-8?B?VHlZNGdESUZlazdkSUM5SURPc2JpaHZlZjBlaUFJZVROZWU0RkV6dGVaZjJt?=
 =?utf-8?B?UmkxR3VpeXhKN3VCeTRiSU54MUJIc3FSZCtCRkNPSzk5bUNyYVEreGFlUUI5?=
 =?utf-8?B?Y01NemJSU2JoSk9xYktCL3RXbkk3MU1qc0lZcE04QmlOUExoajJjc2wxUDdL?=
 =?utf-8?B?RHAvWWJIRGtrSUdvejh5RENKaXZtcEZ0QkdMc2RTRWhRaEpoaEpPaWhWQzdv?=
 =?utf-8?B?dWUvM21ESXNTSmoyandVNGZyWjcxU2lRZm9tckFQODZvemwwT1lyV25jOTlz?=
 =?utf-8?B?N0ZLV240RVFuSEE0WTczQ0hEK2kzSzZ4dDE3STJvSC93alUvZGx2OCtFZ1lq?=
 =?utf-8?B?Nm9MazFSNVRZQzBwSjJxN214VEJ4c09FRERVNk1YSDBKcXpZUDRnbUNrRWtY?=
 =?utf-8?B?eTB4VUVBK3BHZUNPcEVEaWJJeG85Ry9pYzZ0WnNEQXR5NFpEUythNUVsYTVq?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cDzTLoI9F1X1GKw79LGj+hYEfXwm52H/JD5qOyvhpDAE9jxHH73etwdXGci6gfAXqCHwZjRhwNu0wkgHtbtKhkkU/ERMonKZ1YfioJ4BzdIgFqpDgDWmritFhns7t73GaJYs2XxfoVqDv4NBt4iQokzdy01IOVxIU7N9j2NsC+TrltbjQ8FS3PMAcPSx02zQcobxpOgSYU9s9TGVz89LxLz3abvyGTH9AxCuB8G2vOFyvAp4lSHoUO6bUt7eosw7eK5CugjyL3N1coQA2DyxdxV1S7kc4Zwp6WJh6gdi/gQp4XH7McAKo1DLryhsouBeZ4yYjCHqbN22AzjPQiO7wN981/9xDWo2ASFf76Pf3x/PVLd9l9j/hbu9cTR2dAJxV8KVswFxmzGdxI18BBSqNctAb24ivaHZ26WK/bfSZ9eyjdAs5FmUdoFFJMZG/0dCFbhN3YjaaqFf6OE2rvjcCkzNLa7sGpexv0ktTFO/0t4JCy2eFsgkEBP5Arja8S/2Ho9dHUc4NbY66IDPvDTQ/Y5EOhVImSuL3BhuVpAVPA/Hs7X6ot6KOqupNjnlDy/59p2p+NeU/Hl2QqRiOjjlLUVhOwX/tgvZ2O4lbb5vdKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fbe3e6-0cd0-4c28-b5fc-08dc1cff590a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:10:21.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/bucdC2hnrqdtGa4YZhjePE0xvGggi2oqjzn5+lz+9aB1QSQ6MmH6+h84J0tpq52F1DEQQKs41Mvk0LnhZiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240125
X-Proofpoint-ORIG-GUID: IdJfKCutUauKMzz30_mzz2waNOGZE_q0
X-Proofpoint-GUID: IdJfKCutUauKMzz30_mzz2waNOGZE_q0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_091034_620082_2C49221A 
X-CRM114-Status: GOOD (  23.25  )
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


On 1/23/24 7:41 PM, Chaitanya Kulkarni wrote:
> Alan,
>
> On 1/23/24 09:11, alan.adamson@oracle.com wrote:
>>>> This allows us to get the ctrl or ns object associated with the struct
>>>> device
>>>> we get in the sysfs, then based on the device class we update
>>>> logging_enabled
>>>> flags for either ctrl or ns respectively. In nvme_init_request() I use
>>>> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.
>>> I was asking why should we have a show/store that operate on both ns and
>>> ctrl?
>>>
>>> Why not have a show/store in nvme_dev_attrs and a separate one in
>>> nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
>>> the ns attrs can access the ns in a normal way like the rest? Or am
>>> I missing something?
>> I did have a version that used nvme_ns_id_attrs but didn't think it
>> was an appropriate place for it.  I can go back to that.
>>
>> Alan
>>
> can you please remove the struct device:logging_enabled and use Sagi's
> suggestion and post a new version ?
>
> There is a also comment from Christoph to use is_visible method instead
> of dynamically adding and removing groups, can you also add that to next
> version ? unless that cannot be done for some reason ...

Yes, I'll post a new version. I don't think the is_visible method is 
necessary since we will not need to create a new group, just use the 
existing groups (nvme_ns_id and nvme_dev).


Alan


