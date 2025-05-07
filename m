Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BF6C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 18:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qMvbXpwtxc5dUGvg0cs30ALI/TazoaIlBwhOHoHvYJM=; b=4eNZ3FnPtlgkqBEqNTroDBuWbA
	aV7Xe3IRbxUCzdOUJBiPm11eHreR7TjwZuia8RZmutP9Z91zHomGCV9jfVSoaVvyE9K87Vk1sbKUl
	hv81whByBYlOchkbgwtSGsPUivE6JVvAQz6JxDHCYszjR8kbeEJu1rqBtvvqsbyMNnb+RyPQviw+y
	uV4HCuqdqDOFt98+WQRWY8X7APXIuwxkOc9QAOiaLTCNsITo1e672XdNFQhqr8IXW+GXeDZzb9pYb
	KDdAhyIFs7i1bySh4EihJp6+QjW84iaJyNWynISPR8LklaDaWs4nGs9YvGGsJlcFlLI3hpDQU6hZQ
	2PbJKqVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCjD4-0000000GRFR-0Ae9;
	Wed, 07 May 2025 18:09:34 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCjCj-0000000GREh-373O
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 18:09:15 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547I6kj8002371;
	Wed, 7 May 2025 18:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qMvbXpwtxc5dUGvg0cs30ALI/TazoaIlBwhOHoHvYJM=; b=
	BfAlJ3shADp/tvVZOoC6XguzXoQ+vJt3BNsOI3AIuYiz0wfOWutN+RPIeqTU1oRC
	3JDZ9txFEGCThssOlLyf4CI3hhyZcu0ibYDC5CMLb9wnq/5pTRiDfn3kWyrMCXPc
	HDZQ1krALRY3FCg3HbRH5+s/b6irJyUQgA3lcoZWWNumVfui+J7JF3BLyR1Gstkn
	/xvUApbHWElI4LRcW3OuQJtvKhvus5GTbnpZF7NX+mj05cCIf+qvVfpjIf6CLGVd
	cFAQVLP2QaebAhjHA/T5jPbPEubPhJMrQmwz87fNhAt08wishM/RbuMcI1Bh/CvQ
	wHCXFW7MXzL4qPSHOjPCwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcgp8071-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 18:09:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547HAKWh035553;
	Wed, 7 May 2025 18:08:59 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kh0579-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 18:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7BbMcrw8lAhxPgkCxf7dNrOzl0AxCbhHaEtC7L3O8zVAzsph/FOS57eDpvUq1pmuDBuFdme8+bAmj8KfhNvkdIg5XQSw1dqWNw2xjoMSoUBYOnmf4FRs3lrmtZihwII8QAEmDzE01PeoFJh6bzZBUnLA8m7fCczhalBTpRqmPE/g8j0REDXCaLFLpj/6z3G3AQwusyVbMheguS6g2T2J6ZjEHfgifRdyHrrKZFUaUuMdSo/kaCsWfc4kwPw9OHSJl5TFq00imO7bOtDbc276caIqxIwvrfVZE6QWdKE87Wku/3nqXRVPFdoPn64nsOxPVfOanzvwNSqYs5lbfiGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMvbXpwtxc5dUGvg0cs30ALI/TazoaIlBwhOHoHvYJM=;
 b=oJkJk4fJ5Fmabj4yxa3CHymlS4nChKqhyDILiBrGVR65B9mi4vm4ZtoSEADWowBpZjQs48Xa/+yjFOa7/avg9qQxOadwSN5/ToKVMdRBmpCAzulclSQROUU/G6DBXNCTffZdMl8lJK1WLAgiVrcH11C7YaaDG4U7paUfJFo+rQjiHAoVB7Ub4HshLbRkw/fTN9T7f4Aod9l1BsD7MrCympEIBCvrKpsndye7LsVp+KJqw6lLVB4jqf/DL1MAx1QSroKxrbHdBNyGbEqk6KR9e8T6bZu67NdtGa6fgqIymZv+TLKCATvyAkpBEC3MOBwmndN//YgJOWJmgcsWD3rasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMvbXpwtxc5dUGvg0cs30ALI/TazoaIlBwhOHoHvYJM=;
 b=Jv0NUNdpZJwJFwldwq0KTboTWhEbnwA5+PPRyr/h4yYwCWQk394wrNx0N6bk3GfUCU3xjRWhCZkC/cpaG0Hstbb/FBuX5+Xke0HF7o4xh9BM1j9c9l0Ca1fquwl45DWayIdYyy7/bBuNHjvYHdqyb/ZCkEflZk/4mBTz8WsvKv4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8092.namprd10.prod.outlook.com (2603:10b6:208:50d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 18:08:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 18:08:53 +0000
Message-ID: <561cc62a-a6de-4a8c-b277-0d236526d80f@oracle.com>
Date: Wed, 7 May 2025 14:08:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, kernel-tls-handshake@lists.linux.dev
References: <20250507094049.26181-1-hare@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250507094049.26181-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:610:4e::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0d3d06-54ba-41d1-d39e-08dd8d9239d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdiTE5iS0ZrRnhNUFVZRU9Nb29XMEZTbFVDTCtaOG8rcmE2dzhEL0F6NHFl?=
 =?utf-8?B?R2FkUzRqNmwrWEROV2V4czI5aFlaVjRvSzNKcW1Ja2pKMlgraVJQMHlsRENm?=
 =?utf-8?B?Um95YzZNZ1QvL1RuU1hKVHFGUWdEWHJBOTlIMS9tejN1MnkyWkxQeUlBNWdu?=
 =?utf-8?B?Z0J5TmRQYzBONE9CMjZVU2FqaS9rVDJpcHZ0YTVTSXFERkdpSTE2TTVhaDE2?=
 =?utf-8?B?Yk9vZ1dsenlRbXp4Mm9aUjRDLzJpMXc5bUl2VWxUMXloNlkwZTJRaFVJWHpR?=
 =?utf-8?B?dU9wTG1BU0djb2YzNzdQdUgzdDFqNWZ4ak95NmtzU0h1RXg2UGlQOTA0QWpB?=
 =?utf-8?B?UC82UFV1QkhMSWlyVmsvQXVHVHVrK2NTeE9oenZsaWkyVDlOYThRVHBLZ1U4?=
 =?utf-8?B?OHh5dk5FNXNzVkJPMXo1M0psNVBrVXhraFZFaFR3bzkrbnhmYitaN3VSd3cy?=
 =?utf-8?B?Qjc2T2VoUWcxWk5CMUFJSkJ3dTRqdkhZcEt0aGtrQWFadElWN0QzeXZIOVZo?=
 =?utf-8?B?TUFDQ3N3citsVVNGZU1ocXhFUGlMRUxOWmdjSUdEN293b3FFNDNEWmU2ckw4?=
 =?utf-8?B?eU1IMlplYW03OTBISk14a1FKNEVkSmRQbWN0cTFoTnFZTjBzc3kzaytINFlH?=
 =?utf-8?B?RFE3Zm51QWlISlA0TWJNdzdJS05RK3lHOCtad1d0SHhhS25QaEVqNkErMEpZ?=
 =?utf-8?B?UzRQZ21aOXhZcjFyQWEvbXNBcTdpanMrakg1WFYwaDcydDN3SU95K0NWWXkr?=
 =?utf-8?B?dDZSVGY0M0JoTThlb05EaE9UZHlLRlZvd0haRGNjMHpsVDBBUHNudjArRFVB?=
 =?utf-8?B?dnI1Nlh3czJjKzI4MEtTUGF1OGtVQ0t6YXRzZmxCanRSOUdGU0FTamIrWjZw?=
 =?utf-8?B?VTNQK0VGVGMwQURTa1M5QWNnclpWYU1Ba04ycWcvdlM3MnMrMkF3eFFaOXVJ?=
 =?utf-8?B?QTVDWEtxZFlPWm9kQWRLVDhmdHZ5dS9KWVZWTjI4RmhQbGEvMVN0ajlKaG1M?=
 =?utf-8?B?d2tpRU9pOUswMFpZZldwZkFIUGlFTExJdGtCUlRwVERIV1BWNEd3enhuY3ZH?=
 =?utf-8?B?a0V4dVZ4dzNQZ0hHOU5zWmlnZ1M2WGRsdnJGbXFLMVQrMldMQlpKa29mT1hj?=
 =?utf-8?B?dFhCa1VvS1VNN2tnZjdaT0hIbE40SmZPNVMyTm5JOGYrT1BWWVFjU3N3Mmo5?=
 =?utf-8?B?NTdqd0dlU0d2ZkVHaERlTEU1R1RqcHcxMmo1V0xQM2RVRTV0V3pPVVFzQmVq?=
 =?utf-8?B?UGtwSlQ4QlQvSzZNaDBnV0FKTGtWL0FoSklYbXM1WnFsU2Zva0RVaXZjTHJU?=
 =?utf-8?B?SXV2UTBNMVJ6YjlsZzl0bHVmRUtEcFdzOGJoeDAyYW5ZL1BFcnllMy9OUm1y?=
 =?utf-8?B?ekpudEI5bXBCd0FJbCtpblhKczE4cVVMQ1VGR1U2WnlYQ3lQMEpuUHh4K0t5?=
 =?utf-8?B?L0o3TlFsdVdCUVZHbjAyU3RwWkhPeU5ZVFg0eFJYVnVlSkczTEI4S0pFOTBL?=
 =?utf-8?B?UDZIVHh4UXA3c2xiMjREcUZ2aEMwbnQ4WXh2YkFtdnpUclFMMTF5TDBVTGNE?=
 =?utf-8?B?V3lQTDNEaDV2cVdlZEVyTE9McFVZVS9CMDVIQ3k2SE5qeEFZZktvVEVodHh3?=
 =?utf-8?B?cWZ4YU5IaVRVVTIzZmZBcnVMOGJ3Q0laK2lucGV6eXc4UWZKL01OMFk4OTZF?=
 =?utf-8?B?RTlaNWgxZUVUVHQ3Z0ZTTkp5Q3gxZUJtU0Q1eTZoZ0lpWUxORkYyeGcydDlm?=
 =?utf-8?B?bEJGWm5qVGpwN2VLYXhyamQvNzBXQm1OQnhOU1lsMm1hYmFzV0FRWjdsNldW?=
 =?utf-8?B?OUVMRkRxNlhnT0lIUUt2dGNSdnNBTnhWRjlPZFZmMTQwK0xVZHlOK2NaV0tO?=
 =?utf-8?B?bWFrVjgvOStUSFBqVWd2R3MyU0xvUmpsNWwvRGQ3b2dvcms4MzFJQU5xa3Fs?=
 =?utf-8?Q?7LmpIykC7ko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRTY1RhVGRqQnI4ZEVKTHI5TFo1U1VGbXpndnErRHJoMEgvZ2o1S1ZHYVg2?=
 =?utf-8?B?S3B3eUdWYVBhZSs4MnZWeEJsVERFWVo4R2J0TCsvazVQU1V3S2NrWEN2TmpV?=
 =?utf-8?B?WGFPOTBhZ1NnZUVZVVNGSnRvb2piMUtBSTNHcWpib2VkSFgwTHRGazcyai9w?=
 =?utf-8?B?eGl5dVpUSVAzbzFNU1dUVHZKWG9RbGZhWG5IY2U2U3A2ZTQvelU1c0c5Wlls?=
 =?utf-8?B?SXB0QzllSkw2S20yOS9zRnllNlZIRmxxbjdNSEFVUVBqN0Y2RUpCRXdyTTlE?=
 =?utf-8?B?bitCZHNTOEwrK29tV2JUdVlQNXpkN3BrYmFEMUFVai9LR2c5OW5qK0VrTHhz?=
 =?utf-8?B?TVBlZkxpZnRCdm9ZU21lamZBcEpWbytwY2FOOTZBVXJmQVBvS28rZGxmbnVB?=
 =?utf-8?B?eXVpV0toek5QY3JaVW9yeUd4OHFiVGxwbEQzMmsyL1dxNTRLelBGRzJ3eWFw?=
 =?utf-8?B?Vlp1b1ZKcFNxS1h3eUpCYVo4d0pjZXNGUXdBVGwycFZqVFhvcUF0MFh2eUhm?=
 =?utf-8?B?clJHbCtlY29NSlRxdTFGTndUMjVXb25aZzNsRUkzdUdZRkJHd2xuOEtubDdw?=
 =?utf-8?B?YUpUVFRrNGo5V1RXT0NnR05IcS9SNi9zblVvVTRrWSsxVGlYQkRKbFBXMUYw?=
 =?utf-8?B?L21HT3kzK1dwWkZCRkR2VFdrQnFiamhrcG1ZOE14N001UXBiaU82Y2JzMHdO?=
 =?utf-8?B?ejllYzJobk5GQ3FWdDhqU2FVVFgrQ0pkZkdkbWRQTXl0ZTc2b1VyRXBOWFlt?=
 =?utf-8?B?dWVqUkptWVRhamI5aGd2QlRnNE5VakNReHI3a3ZjTDNGNlFJOFR5NHR5U3or?=
 =?utf-8?B?bDZ5aFVnWStHcDU4UkdacS9ScC9qd2xwekVrQ1daMzRlbVl4NlNmVXJFcjFq?=
 =?utf-8?B?Y0VURzRnT1ZuODlPRTFOZlAxQldXcUpvSy95b3JBM0RZbUlDdHRIL3p0eXU2?=
 =?utf-8?B?N09Tb2tHTFNvczcrdkFpVW96V1p2M0dYclAxV3RVMk01K3ZuU1RxMkVQejNi?=
 =?utf-8?B?ZktmVkZSVnhld1QyOEEwSS9kZGlHOFBTNE4vWGg3aXh5LzJFTTljUzNSR3hZ?=
 =?utf-8?B?OTV2RE9rM3hhcENtMTZBZk5LT1Yvb1lheFpjdC9ieGRQVDFnUWEwRERvUXBN?=
 =?utf-8?B?NHBkZXNobnlRRUhEc1RFYlpoS1BBMlJYU0NiTGw0L09zMWFzMitIaExwai9B?=
 =?utf-8?B?WmRVbW54dXFvZW1lVHdpeW1EemE1bk94Q1ZtZW0rNXY3SzR2VGdYUGNIV2dV?=
 =?utf-8?B?VnFrWStJT2ZSSjFEcXRaMVBDQ1pwdnBneWFnSTByeFZ2cy9qU2ZMdUJGY0d1?=
 =?utf-8?B?dXczdHJIZGNraHNSWVFWMFJlZmJCV0kvYzF5bnV1dXVrcFJrTzQ5ako4b2hZ?=
 =?utf-8?B?dUJoTkxEUHptSkV0VTZzd3NyTDhsS2JrcFUyeHlRa3llajNnSkxzRlIxOXNu?=
 =?utf-8?B?RlBIUnZtcnN2U0VYQTlJeXlJbkhIbTdUNHFkb21DdGNVMnArWnZGeXY1UVJ0?=
 =?utf-8?B?QVhJL0RXUXlBcnNsQy95NlhxSTZvWEh1TURNcVl6TTRMY3ZMMFg4bGMxNzM2?=
 =?utf-8?B?VzVqdEhmdXFhSGlHai9zUDI3cFBlZ1cxMnFBaDVPMzVzUG83bFFJc3U5K3ZW?=
 =?utf-8?B?aklBenArODVlTG4zbU4zeGI4VkV5dmZBaHUxT1AxZVpNZlhQNGJTdVhaN2JF?=
 =?utf-8?B?WStkSnpMdU1zS0wrU2k5a09PUk9zOTIxcHZicUdMQktxaVlYcTlEemQyTHFk?=
 =?utf-8?B?TXc2cTJCWm1QcHpMNEZWNDVNM3Y1WExBR240RjcwT0NQQThIczJIWDgyV1hU?=
 =?utf-8?B?RXQxYXlZbVpSTEJHTS9sa3VLd0lWUEhxR0l2ekpnUGJuRUlJUzE5dC9WU3ZN?=
 =?utf-8?B?ZU9lR04vdkhBK25lcWEvbmxJS3NvajF4ZHRBNVgvQUVYQ2paR1I2Q1JzVjdQ?=
 =?utf-8?B?VHhqZXI5U01reWRiWGZ4d3ZnYjNaNEp1VWVEa1BpdHlEU1RoV1pMck9iVkRt?=
 =?utf-8?B?c2RTWGkyV05EYmc3ay8zams5K3RHUlYvN3Q0MzFsOHV5V0VwZHFsTFh2cjM5?=
 =?utf-8?B?TFc3N0ZQcXhtTUhCUG5EaWFQSVNQUWJwUmQ2TE83b1IxMk1nVmJoZXkwZXVz?=
 =?utf-8?B?SWlST0IvK2VyK2x2MnZlak0wYVJmU1Y5ZWN0K09OUnNRc1R0b2FweWdBOEFw?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W/OIbj1apvBnTTBNDq5FTK2dAwIQY3ucQxhlU22Q12pYXmK4hYY3svxul7e8Eifqrfzhd2OZdPQ4by2JBGOWaQ+jqHI7szQSuOCfmZ4qdAG3WZXylg3c7Pb+naDQ7DCRhnkZHhVozD2tFJgN47VLp77/EfVsm3ciYONHzoFNRV3xxNAVx06Gk2Qtm0EMf+37qzcH7LN+f/P9xbB+vlVrVwZCZOrKBuKnEj0GAMx36ajM0fwG5uk0wvZtddinm7xJarmJl1p3xhfcy2GQ4739rsFDQ6gZAH1sfZtRjoqb+LCyoarKI721lC2W8CnJ7AftEVRqX7HxGtGLZR/5pjY+Ek7gpLXZR94dzrH8OWHazjRPy/qvFe8uMZhobeJRgfINbdaaEpDKwF8PmK964gQgJgf6EAyRxanSOWJE6nkZNlWfFyAAOYFmJzBZSQafI2Iy9boZMf1r2IWPkjn0Xd7x97d0TOjTQBG7ZOQqKU6cX31/79rar2neU63qVqJyUc+X8Iu8t0sq6hgUWPmF44DHMr6p4n10O9wZmrW6my9XLlO+f1N18UdKL6hpqLEC1XWP/ircKHzjxh26PZS9bdSKfzSXnaddfnKUiW8XDP4D9/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0d3d06-54ba-41d1-d39e-08dd8d9239d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:08:53.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGuy+FPtZ0KLFwtQr1ju82bOST7d4JSrRjjb7HTdyBB1eUA1NzE4/tSWyAfal/71dOs6LVNc3992RqPQcyquZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070159
X-Proofpoint-ORIG-GUID: motj_XJbrOH3CfmaG8GdHTL2-hs_dXkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1OSBTYWx0ZWRfXzparhvVKjKwR GKnxT3xa6XGAlumjfVjHEkaDfnVOUWNWF+rGoV5MiKOsoVK2W63GndT0cW2HtOjHCpYvRwxVSVP a5HmfZtrUFh5zcFYE9mO3ohTTWvlOt45bSuVPeCsoKcGHIjHHN36rkWJAvlPFNIDH4AAz8duvs4
 R8juujX0yZftwOyLuIhabIbnW/EPdeTj79qLqp9zFjWCTSnITbISOP5uFFX8rUZwmLjP1pe05Ux nr376PF95IfJR2AZegeVT5pCw4c2Sp+nJYQhDHKui6c//z8McwNH8gZp+xomD7KxDxZO5/twPp6 EAnMtMlQw3XULuMr1PDwU58MP4cTMi3A+y9rWM4S7jMnac3QwB6xePQeIgeFEId2Nc3tO0rzGmI
 piOtPMUTPdaaXZAiVDIQRAgQMxEJMfwhpezsmnNG36KN+UgwQld8ZebtAAoA2Eu5A8stU/CT
X-Authority-Analysis: v=2.4 cv=D5ZHKuRj c=1 sm=1 tr=0 ts=681ba1bd b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=GtKKwlXGpVk4V20fJV4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: motj_XJbrOH3CfmaG8GdHTL2-hs_dXkf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_110913_787494_E9140B2B 
X-CRM114-Status: GOOD (  17.72  )
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

On 5/7/25 5:40 AM, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
> the serial number of the keyring to use.

This needs to go through netdev@vger.kernel.org.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  include/uapi/linux/handshake.h | 1 +
>  net/handshake/tlshd.c          | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 3d7ea58778c9..662e7de46c54 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -45,6 +45,7 @@ enum {
>  	HANDSHAKE_A_ACCEPT_PEER_IDENTITY,
>  	HANDSHAKE_A_ACCEPT_CERTIFICATE,
>  	HANDSHAKE_A_ACCEPT_PEERNAME,
> +	HANDSHAKE_A_ACCEPT_KEYRING,
>  
>  	__HANDSHAKE_A_ACCEPT_MAX,
>  	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index d6f52839827e..081093dfd553 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -230,6 +230,12 @@ static int tls_handshake_accept(struct handshake_req *req,
>  		if (ret < 0)
>  			goto out_cancel;
>  	}
> +	if (treq->th_keyring) {
> +		ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEYRING,
> +				  treq->th_keyring);
> +		if (ret < 0)
> +			goto out_cancel;
> +	}
>  
>  	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_AUTH_MODE,
>  			  treq->th_auth_mode);


-- 
Chuck Lever

