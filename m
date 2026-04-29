Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2F8FF8867
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=S+WHgCUWDiYIRgyFLIIClUWaFcYdcbT1aiY5n/rPTsg=; b=wLPDqDMawQ28vv
	7uOUjr8p6MrCaEbUBeAjZOn9fhm1PeHwqV/WUV+aTdNYzA3HFmM2rLS9uQsCMsp9sffo/bKsF6JDY
	rDoinxU/TF2hQpoWcCyWdvOh3pJFMA+1q3DBM0AyXckUPAhGqUwoWK7Fn/YsMWGo741nwUFambPYu
	PdX4vMh/J3RZ5Nl9kB0674Jf9h/lP1Vvs9zcJA6nyN4zrUtnU7lKuARVx2x3AedLaQZalfIy/KGJu
	Nd/mUI3vEEeJQBFnJwCKlZu8Eem7uHZ+AHVwfpe/HyfnTixmgDah52mPE4T7AVwVDoesP8BhnwgnK
	I7o9TQKD0zpl1W2540Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6FL-00000003nEe-2t5V;
	Wed, 29 Apr 2026 14:50:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6FH-00000003nE8-2y6t
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 14:50:38 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T92NTq720957
	for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 14:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=S+WHgCUWDiYIRgyF
	LIIClUWaFcYdcbT1aiY5n/rPTsg=; b=BwJJQd/v64O2mKWQ6+BjiDyUNTwLXRFG
	WEw/tUZ11NAWrrFkExqqm+daZ0UPfGZdSGHtA46eJcBlyv/sdB+7JGVQUX5zs0Wf
	8JDdOI6tVqFH+pLDXwr09EUqiockwWr97Hint/I+iNKnvprY5PQVuy/ELvu2VPgi
	6cWgiYEFrij03D3+onA8qKV3q/PHrAoz6/GLPXDViwK4C1zC/i7mHe95rc3cQ6Z/
	qMtEwbxddjG9sr4KJBkOPULanjYlf28oIqCTKjxWK+ToY7tmDB9WcDHbnzX1yn1q
	uxfrWM/ZaOobfWEGj3dhkXm/+MGS11z0t1xUIVQB8hE7gk7QiQ0S5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drp5t2vyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 14:50:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63TEkKsv000876
	for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 14:50:33 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4du8x8qa8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 14:50:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5DOeWI6UyvkErzNV0zQ/cNh9dH1o24bTuT7zxaawXvxc+dCuYBTh+MhWMneHGqhXEt74t95/4WgmiBYb21VD+05lrjElpBFnTHHhZw6eP/r44Q2Ytl72zs4UTy0e5tQ+l26g4YlkBpH+D8ES8PT/Dm0jsz2kam4ul+Gt8s+XlF9t1iJy7nKgGKbBlgHKay+x29sy9ccBI8ghnnRdsMCKThOxHIqgUu2v5dEhxa5SsQhcK1pOTtsfaSWSeZvnii7L1tNEBYQxek8rJfBUYL3kBvtwxsqrZJ/XOIXzqdL/3gMALdpqw5+BZzOQCVPXcT8QOTN62oO9AW8vCoE0tUHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+WHgCUWDiYIRgyFLIIClUWaFcYdcbT1aiY5n/rPTsg=;
 b=eEdP82wuHUKsal6GZ/gPVSTGIaQGM8cPknqhd5K9E+9nLggYgsZOt4lCLj0yoxhDmfbwm7MxmwzAEAlVPGYd4IBfa+X8lbvgxp2fwlwxKwYyBV6NLRgJf0u0om8+i4in4PttlBsQKvzKhLDg37ssN4f2smi7juLRahqoYaE0ZkooFp8CQwzA5LwBT4tMLRVJDEux2hK7kcSsSomyODLyquG0WkHKUBsihxZwNq/qQHzIOkxw61X4D+G/3XSYUg0ziJSKQsp5TK8me1cctDi2hJPuRRqtMlgctgIRSkslnd7II6XuuCyWzW95Bcbv+7hcCdYhnklpLOdUlfPQD3iNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+WHgCUWDiYIRgyFLIIClUWaFcYdcbT1aiY5n/rPTsg=;
 b=AfDqPDS8uss9RLJVvIB6VPQr5NQHhUO+tTVKREiZgZypUBlhnjmgpcwO2UCSEgeDYLhJM0PLbyZQwKHRPrcLUA6C/DI2eKEuSc5dm9lP2Z2Ko0UlbfTWVgZlL11DoDoXXGOjrg9Gka3nlo0tMuPzpfdnSGBrUqQE5Q7SRn60q0o=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 14:50:29 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 14:50:29 +0000
Message-ID: <020fc39a-2832-4865-bc91-fbb3555a65f4@oracle.com>
Date: Wed, 29 Apr 2026 15:50:27 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: John Garry <john.g.garry@oracle.com>
Subject: [kasan bug] slab-use-after-free in nvmet_find_get_subsys
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH7PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaaff72-e961-4c10-22b0-08dea5fea7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YCm5WMVcLLsw2qXGATtktEhy4x3MmZMqGXHYlaLbhYhRRqdP5Y1sdkhZ+/DpUcNrXouN0v996R5Szr5ReOXRc0Gc03dwrK42TjmPLOG2M+FOT/sYpxMOdBSuSAqPjbT6L8zs4MHZMJmSxqldvWgGBWH7ALDaebRy/0YDHuayQ9m/QbXxYKGM1KY9Kp54vYxXTI481NcYqRig46Ed3Z/JtTXxJi1mXqNgy56j74WtyA0/fhFr9WqqQaM4he5JXMHm5mxW2u4D3ezLC4UStqiJQxRcLvxMUEZ5vm8YJ6vCYaS/VXIE5l9Vggme4zV9CYV4CLgA6z/z5IVwWjars1t+CnmzT81hNTKsOtWrswnhFX3XiZLpmZbiakakvUYngq0W1tlL25dRySRDhneE/x7VjC+tfyRirtnOEOqm9ltnRpbLf7ZgCVqFEA77srBo7WshTIXHmR+JfUGIhuH2GgM9oH7X2fdySI1rS1bJhmcu9Cw1Tmx7PsyTr1776MbjXMpG9mWZ59ZVp+B+/0lLWmQ5tHscAe+Sy758cXBP6+JzwArQj5dd80MtZFljSiHv9oGV4m8oi04FdIwnguT0BqzZBzRaj4bAB67NvOSDXjCxNovLsCPzUnshIeYW8mMlkO+PSEHF0s8wg7abcQ6AWjID0ZW+DZBk2YLyOu/ye2ywGMMduoQDW1X4GSmDqEgrHNUY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdsdGZvYk5qNWc2dEk5ZDR2cnU1VzM1RTRwT1d2NnQyWUljNWU4Uld5TVZB?=
 =?utf-8?B?cmg3QTJuNDdJR2dLMTBUd2RZMWZ6TjNScWlieDJvdVJnU0c4MVJQbDh3WjBO?=
 =?utf-8?B?aVUrcUlkTnFhazIza0t3bGFjRDhRaU16c3hrYStQeWpCdHl4K25VTnNsZVc4?=
 =?utf-8?B?YmVDOWw4SFI3bE13ZFZUbW14eVlEYVljL01ENkprQldjeHNUVGRPR0FicjdE?=
 =?utf-8?B?OE1KcGt6RVZFbXNnYkE4MEs0WVRyWG1zZjhCbHB4bFpnV1B2NDR6U05UN2d3?=
 =?utf-8?B?S2dwSGVDTmZoc0hkaDk5Vk9wczZNYkdiTUVkN0Y3Y2ZxZUtzSFRVVlZtK1Rv?=
 =?utf-8?B?M1RMSUM2Sm5yMmpTalJYRWR3NHRXQ2ExNlNDZ0xrK2N3dGpvbnZDLzJaelhT?=
 =?utf-8?B?RHJLY3Jid2lILzBFQW0xNTZlRDUxVmJkQ2U0cmNmRHRoL3psOVREZkVROVpC?=
 =?utf-8?B?TUkwVWpYdHNQTGszcXoxMnQ4TzNOa0ZmRU51NXFrc0pHd2xvVG4xVTRzVERY?=
 =?utf-8?B?RGx2SFl6SCthVG9YRURtbUY4aEFFUFNFZTNVN1JYcnNyR3AvWm0wZkhHVS9U?=
 =?utf-8?B?b0VtN2RTbTVEVE0vVlF0UkkrQ1JDMm9wM04yUlZYSm5seEFtU2VoOUFxMkVi?=
 =?utf-8?B?b1BnQzY5NXkzMGJzVUtIaGNpck5KeVB2QTVUVUVwSjJPQjl0aGxKTmd0RGRy?=
 =?utf-8?B?eDMyQ2FwcldoT1hodGkwK2lWUHFEZGpweWYyVXBGOElHTjQzSEhFY21jR01y?=
 =?utf-8?B?M3VzMFNjQ3NvNUJGN01OeDJwYW5DbkswWE5hSTVyUWZnQlNsZVBBQ0ZZNUp2?=
 =?utf-8?B?MXo2YnIrQlVYQzdtMHA0aThPTmVNWFVla3Bhdk9yZFNiK1o2NVA3QjNJRzQx?=
 =?utf-8?B?c0dLc3RGYnBCWnZ1REJDMTlVVTN1K3JuRUcxK0d2SGRZQURkZEZWWng4RndR?=
 =?utf-8?B?ZzFDakJRSFEyWC9yMGxpeEFVZTd1MWdybThyb3lrZHhWWjBYeTlETUNoc2Vj?=
 =?utf-8?B?RkRNb2JyTnMzZ04rSDB0SjNpM0dabXQ2S0haUldBRGNHMC9UR3VkMTNaR2Jj?=
 =?utf-8?B?Z0lCdjdsNENraEhQeXpIZVlhbThXOGdlbzd0MUdyeFFObkEvK1ViMlNBL3NZ?=
 =?utf-8?B?ZWFaV3lZc29DeDdBbXBSUEF1OG51M2FFSWkwT1NlQjlKYXNQeTU2T1ZNM2JT?=
 =?utf-8?B?cHp3Y1B5bXdibkN2dFdLT2w3WWczNCtST1hmNUtRQnVncit2MWwvWmZtcHRt?=
 =?utf-8?B?dXl3cHZGRkgxUWxlSWwyTEwwdi9kWUtvWkFjaktBTnlkUkVLTTUvNjFqZTAr?=
 =?utf-8?B?TzhxbllWTkdONndWMUE3YUlCdXV3MnVEY3l0NTcveVpvU3JaVTVheHU2MStY?=
 =?utf-8?B?Y0wwaG1pUU56bEpodlVweWJUTitPMTNFNUN2QU8zN2R5d041eEV4QkVTUHY3?=
 =?utf-8?B?NTFnT0p4NVBhSzlzMk9NYkMvMXBUL2V4NVhGWXpPc1Y1WnFpb2pvaEZUWVdM?=
 =?utf-8?B?bVZmTG81N2ZKM0JzRE92V292ZEkySm9MNGU1RkMvRUw0bC9lWCttYlpyS0F0?=
 =?utf-8?B?YzBMeDZCSW9SaFdzNjgySlBzNkYwODR0TFpaYW05eHRnTElRMjF1aHpwTWhr?=
 =?utf-8?B?V0p0ZmsraDlhSysySzJZNjBDbGErWHpKZGJCaG1ZL2pTZDlyUW53UmdyVkhQ?=
 =?utf-8?B?TU5ZTU40Y3BPdWdIVUkvTjFQUVU1QWdQdkhlRkp3TTN1KzlBcnAxczN2Mkg5?=
 =?utf-8?B?MFd1Mk82QWxCNDUvbngzaDdzcUpuZ3VwbFBRZnM4bHZJb0J5OTQycWpVQVFr?=
 =?utf-8?B?YkUrSWhnZGhTUnpjL0FIRFNPQXJpSDZOVWYrcFJxVFpjZU5GNU9UeTkzR1Ft?=
 =?utf-8?B?NjczT2YzeVY4eFB3L05hOHZpaFVuS2o0M0hMU05nb1JMU0d5UWZzKzVpZ3RI?=
 =?utf-8?B?SE5nMmc3SlBSZFNVSlVGV0lCbkllRFV0eXVvL1oxWVdLN3dpaTNURER1aExW?=
 =?utf-8?B?bjR4bjMvNlJ6azNEenVKelJIRGNiK29ud05QWHpScXl2RW1KZm9YL2F6T0s1?=
 =?utf-8?B?bnFlUUFDa3l5bjRCc0EvVm44cDBmNWhGbW51NmErbi9iUkhjSnlIVS9hTzlF?=
 =?utf-8?B?cXdINm43NCtZU0hXWUVuTTB4WHpMWTkzUFZNdVZRVDNQSlVHSS9USVpCQjZn?=
 =?utf-8?B?RUhpTVlMZXNCK24vRjlFdW1Ib0gzdjUvaFN3ai9FM3IzY0t1TU52a1Q4V2xG?=
 =?utf-8?B?ZXVsOC90Q2tad2J4Vi9pTkFidmU1ZzBHbnl3QmFsVGh6M1pUcWdvYWFRMVBj?=
 =?utf-8?B?emM5UXk4SjJCL256WUlsQUdqVWtteG1ZQWxadFluZXk5MFBCRnRkUT09?=
X-Exchange-RoutingPolicyChecked: C3aduphiS+1lLhwcD9BXrevfcnbT8IOlM7cxKn2bn7i3CfwinsiswBnAKBuuH6T8D3i/6QubrCqjSR48XnQy0emF3LRy7lsoeslla3WCbjkBStEz+aOkn8+3sx/jiiIo8zgIgjHtrVfogWshxpSiikgtnTvV47QAX7ZXqdt3FYM9z7f7lY2RniFTLbxawZCc0nRWgtr82lgPr4pEViIXe23J9KhvgzwQQDhZCT9PC4COtqjpLdDsDZeQs7XgQ7q4+quFbIk12HGpd10vM3ty7RAELPavtHpL/+zvWncR3AYthCFkls/OYBnjp/Zl2H7DoHuCZ77H1+mW66lpoNc8Cw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GjYQCBlgKIaY/4vC7pbHNNE1atUdQvp1v50Rzi2nfOeaqkmsAEONblS3tQI0LyhrnpjmxSS4E4RoBEIEm4XsJ2zNJbB067N0zHrmFyHIu1cHIRa3WhHGTn3Il3FlNLB4KQiZ0T3RYaSIKpHsJJdqlE6LGb9KlKJHOfw86/NhLtb2bOIfsHV1CD2RW8LJU/Iyhx50A8GZp2LUVQWeDozbgD4eP1X1A52isxRoixq5qoFrv3nVOVZejLdjvH/0vJVgIoA2CkRHnEVZTWR+t7Tm9qREJSsGfbPU+GhRPL97vMVMApsSp78X3QFewhj/EeOR3UJ5CscjdH8qBhj/aPq7fME6DtapEWFy/k23/NAMM2td5lB9a/LH9YDS4RFKplR0J2oRLgawS1riJ46z4Ag2qOL5x0zEZtoZ+9HWPyXLvmM373qWk+fbJOzRWgzRkno2h9slURT33yLnrlV4HVjnTaKoIHDSdBSr6dH2xVpdDc/WmfX8P/qFdNM6ofpsy8JJWmKWke4F9lnRQinrYnAkirqhlf7zYBHV4YqnYZjw16o9bckdIMGW7tWAjAssRU/nnXPI9Ek0oo/r2EkLC0hvRPZAiPKhXdOkkxGxz9on3wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaaff72-e961-4c10-22b0-08dea5fea7fb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:50:29.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+7gDu5xjgDnCy6aAPcPi3MDcrJJJ9T4Dhdz3LFNgel7syLNGbklBGC+KdOIxyaTrqNtTuiEeMwjI/XqGnLtdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=912
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604290150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1MCBTYWx0ZWRfXwslWrncyT6Ov
 CiD1qMbUvl33SbyF2Pjc3yRxOiQHg/fTqy1sFUkyeFT076QZLaGYx95+9j04yTrLZ1kQ5Odpade
 5xq6IklgrhNCOm31Ghh4/fEP4RzkOEBZ6le/C9f73j5kzM52hbdGdXOomoeE/VEf2qTzxivD6kp
 LzXUIS6mtCSTYH953ktgBUAYTyEsdErEAPPpM0qd3onarDCARll34Cs3ZG17J300u4IDlWjdKGm
 f5CH7ZFRxGvl4qkh8u9fdYFOMwRUZ6xFu7fUJ/wKRPIeIdGmXTAFrtStIxqnaWSJmR3kC707Wy0
 zN4uqGNbXB/+f6+785BZ3PCRl1Jh70VH/+Er9u1OD8lhEP/Lg8V+eox4Ou7J21NEkxcMRQotj4o
 pzF+XMrgFAHYHsoymx20Wg/LHmLzsZKA1ANJdoNoDXp9FtKbYwoBCu0oK7hYsRoxov4YZErKDU+
 /ScgDnO5/ajO13TyW08Nuq3L4uCfoeVLo+nBd3eM=
X-Proofpoint-ORIG-GUID: b5w4BTfD51jQo0JOmE7SLNg1xhH9vdN1
X-Proofpoint-GUID: b5w4BTfD51jQo0JOmE7SLNg1xhH9vdN1
X-Authority-Analysis: v=2.4 cv=E7v9Y6dl c=1 sm=1 tr=0 ts=69f21aba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=lmFHfrsnN4P09Dn4xhMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12310
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_075035_757845_D4EC99D9 
X-CRM114-Status: UNSURE (   7.86  )
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

JFYI, while hacking away at the rework of 
https://lore.kernel.org/linux-nvme/328010ad-0d56-4f5e-a37a-e25914da08b5@flourine.local/T/#m926929b41d49f6d851c3cbb680f24115174bf737, 
I noticed this kasan bug report:

[ 2440.008916] block nvme2n1: no usable path - requeuing I/O
[ 2444.991612] block nvme2n1: no available path - failing I/O
[ 2445.036229] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2445.037497] nvme nvme2: creating 12 I/O queues.
[ 2445.040938] 
==================================================================
[ 2445.041235] BUG: KASAN: slab-use-after-free in
nvmet_find_get_subsys+0x541/0x5b0 [nvmet]
[ 2445.041556] Read of size 8 at addr ffff888102ece520 by task
kworker/u49:5/7677

[ 2445.041976] CPU: 5 UID: 0 PID: 7677 Comm: kworker/u49:5 Not tainted
7.0.0-rc3-00140-ge72100575e13 #50 PREEMPT(full)
[ 2445.041979] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 2445.041981] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
[ 2445.041990] Call Trace:
[ 2445.041998]  <TASK>
[ 2445.042000]  dump_stack_lvl+0x91/0xf0
[ 2445.042035]  print_report+0xd1/0x660
[ 2445.042060]  ? __virt_addr_valid+0x23a/0x440
[ 2445.042077]  ? kasan_complete_mode_report_info+0x6a/0x210
[ 2445.042081]  kasan_report+0xf3/0x130
[ 2445.042083]  ? nvmet_find_get_subsys+0x541/0x5b0 [nvmet]
[ 2445.042095]  ? nvmet_find_get_subsys+0x541/0x5b0 [nvmet]
[ 2445.042106]  __asan_report_load8_noabort+0x14/0x30
[ 2445.042108]  nvmet_find_get_subsys+0x541/0x5b0 [nvmet]
[ 2445.042120]  ? __pfx_nvmet_find_get_subsys+0x10/0x10 [nvmet]
[ 2445.042131]  ? __pfx_sg_copy_buffer+0x10/0x10
[ 2445.042151]  nvmet_ctrl_find_get+0xb0/0x510 [nvmet]
[ 2445.042162]  ? kasan_save_track+0x14/0x40
[ 2445.042164]  ? collect_procs_ksm+0x3a1/0x4d0
[ 2445.042167]  ? __pfx_nvmet_ctrl_find_get+0x10/0x10 [nvmet]
[ 2445.042178]  ? sg_pcopy_to_buffer+0xf/0x30
[ 2445.042181]  nvmet_execute_io_connect+0x238/0x510 [nvmet]
[ 2445.042193]  nvme_loop_execute_work+0x38/0x50 [nvme_loop]
[ 2445.042195]  process_one_work+0x84b/0x1a20
[ 2445.042207]  ? __pfx_process_one_work+0x10/0x10
[ 2445.042209]  ? do_raw_spin_lock+0x136/0x290
[ 2445.042220]  ? assign_work+0x170/0x390
[ 2445.042223]  worker_thread+0x6f0/0x11f0
[ 2445.042226]  ? _raw_spin_unlock_irqrestore+0x51/0x80
[ 2445.042234]  ? trace_hardirqs_on+0x24/0x190
[ 2445.042249]  ? __pfx_worker_thread+0x10/0x10
[ 2445.042270]  kthread+0x391/0x4c0
[ 2445.042275]  ? calculate_sigpending+0x84/0xb0
[ 2445.042282]  ? __pfx_kthread+0x10/0x10
[ 2445.042285]  ret_from_fork+0x79f/0xa50
[ 2445.042302]  ? __pfx_ret_from_fork+0x10/0x10
[ 2445.042304]  ? __switch_to+0x381/0xe50
[ 2445.042312]  ? __pfx_kthread+0x10/0x10
[ 2445.042314]  ret_from_fork_asm+0x1a/0x30
[ 2445.042325]  </TASK>

[ 2445.052641] Allocated by task 8141:
[ 2445.052887]  kasan_save_stack+0x39/0x70
[ 2445.052895]  kasan_save_track+0x14/0x40
[ 2445.052898]  kasan_save_alloc_info+0x37/0x60
[ 2445.052900]  __kasan_kmalloc+0xc3/0xd0
[ 2445.052902]  __kmalloc_cache_noprof+0x25c/0x700
[ 2445.052922]  nvmet_ports_make+0x163/0xc80 [nvmet]
[ 2445.052939]  configfs_mkdir+0x484/0xe60
[ 2445.052950]  vfs_mkdir+0x2a0/0x6e0
[ 2445.052958]  filename_mkdirat+0x413/0x560
[ 2445.052963]  __x64_sys_mkdir+0x6c/0xa0
[ 2445.052965]  x64_sys_call+0x955/0x26e0
[ 2445.052968]  do_syscall_64+0xe2/0x1520
[ 2445.052974]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 2445.053218] Freed by task 8375:
[ 2445.053458]  kasan_save_stack+0x39/0x70
[ 2445.053461]  kasan_save_track+0x14/0x40
[ 2445.053463]  kasan_save_free_info+0x3b/0x60
[ 2445.053465]  __kasan_slab_free+0x6f/0xa0
[ 2445.053468]  kfree+0x1fb/0x5e0
[ 2445.053470]  nvmet_port_release+0x151/0x1b0 [nvmet]
[ 2445.053482]  config_item_cleanup+0x12a/0x200
[ 2445.053491]  config_item_put+0x5a/0x80
[ 2445.053493]  configfs_rmdir+0x797/0xfd0
[ 2445.053496]  vfs_rmdir+0x2ac/0x840
[ 2445.053498]  filename_rmdir+0x391/0x5a0
[ 2445.053500]  __x64_sys_rmdir+0x47/0x70
[ 2445.053504]  x64_sys_call+0x1fff/0x26e0
[ 2445.053506]  do_syscall_64+0xe2/0x1520
[ 2445.053508]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 2445.053738] The buggy address belongs to the object at ffff888102ece000
                 which belongs to the cache kmalloc-rnd-11-2k of size 2048
[ 2445.054206] The buggy address is located 1312 bytes inside of
                 freed 2048-byte region [ffff888102ece000, ffff888102ece800)

[ 2445.054901] The buggy address belongs to the physical page:
[ 2445.055125] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff888102ecd000 pfn:0x102ec8
[ 2445.055131] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[ 2445.055133] flags:
0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[ 2445.055143] page_type: f5(slab)
[ 2445.055146] raw: 0017ffffc0000240 ffff888100058640 ffff888100057648
ffffea00040bb810
[ 2445.055148] raw: ffff888102ecd000 0000000800080007 00000000f5000000
0000000000000000
[ 2445.055150] head: 0017ffffc0000240 ffff888100058640
ffff888100057648 ffffea00040bb810
[ 2445.055152] head: ffff888102ecd000 0000000800080007
00000000f5000000 0000000000000000
[ 2445.055154] head: 0017ffffc0000003 ffffea00040bb201
00000000ffffffff 00000000ffffffff
[ 2445.055156] head: ffffffffffffffff 0000000000000000
00000000ffffffff 0000000000000008
[ 2445.055157] page dumped because: kasan: bad access detected

[ 2445.055371] Memory state around the buggy address:
[ 2445.055597]  ffff888102ece400: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 2445.055824]  ffff888102ece480: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 2445.056049] >ffff888102ece500: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 2445.056271]                                ^
[ 2445.056504]  ffff888102ece580: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 2445.056736]  ffff888102ece600: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 2445.056967] 
==================================================================
[ 2445.057266] Disabling lock debugging due to kernel taint
[ 2445.057282] nvmet: connect request for invalid subsystem
blktests-subsystem-1!
[ 2445.057361] nvme nvme2: Connect Invalid Data Parameter, subsysnqn
"blktests-subsystem-1"

The kernel baseline is 8658b6054439 nvme-auth: Include SC_C in RVAL 
controller hash

I do not have a reproducer. I will analyze when I get a chance.

John

