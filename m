Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E3F41807
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsNgEL5fbtDw6jRMx09hI0sjWPH5Jnm2iY7dtGP+rAA=; b=Jh8gy/Z1c4IdCptrLEDm1WiReg
	SdDHHUAAYP1uY3eEswJxmumRf76SUlrafU8+d4+ubCKYJZ7IeCCHsiNqDuM4ptZEPl5tPbDiuXMkG
	aN0PkzNVomAZwuB9ajp/G11YDNbbAgnKZn76T+oz4nBx4VP2V9JRsZACSdiZbNXWaE44c56eTmvT2
	Jsy2SHkXeKY7hEpiI4OOPl9Yaas/f2UWqtkVvmREDpFN8/BW9GVa7Vsg51k/QbPS5cF6rdV4MErSg
	id+I4/bggZONlVSIjpmP61bxRYo2UYtc8MuDmtzlO2hlL0JZIGIZRWJSYosW03wIG2ki3EhZNqXsE
	4c8HWenA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzcaj-00000007c2C-1a19;
	Mon, 09 Mar 2026 15:32:21 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzcah-00000007c1G-14AV
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 15:32:20 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298uuJj1352423
	for <linux-nvme@lists.infradead.org>; Mon, 9 Mar 2026 15:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gsNgEL5fbtDw6jRMx09hI0sjWPH5Jnm2iY7dtGP+rAA=; b=
	YUbAEdIqSQjV7D2oU0laXikyhwh3gV+s6itMPFsY/c9wnHVyU3GPtastVwwHEbHK
	yaZy26y8YJxM/9mY9mt0zaybRRTdcSqEzdnU/wsVPc3AaJPupy32bcQtRLrasr3Q
	gXHULMmx3I9H07U5QCiK6OC5tRN7REINHlsyMFEm4lZp21gxN7HNwAThXQ/cvncO
	trZQD+RTxJG5QAuCizuFa4Mc7tLnAnRJr5kGo9UMCdlljp3dMZRoqihn0x8iQ6L6
	V23g/WPR6i6lD6E4aVibhjWpMMD9FRJGmP8ywobRXNbYFRh/fmYkAzJeQFDqcK9n
	nI4ym/hdLVFStt7b3Ve5sQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csks2h5sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2026 15:32:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629F2iMK039594
	for <linux-nvme@lists.infradead.org>; Mon, 9 Mar 2026 15:32:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf8vmx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2026 15:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRCbKIkbzGxLZFTZwAfLdWdp5IpXHeIlSsoGmYSQhDkLbdXJLbQ3muGRlcOic4MP5yJgt5XdRYX59QwR3DYVwjqVJTXKxxeYyaGWx+SvAsxLwqSLJhu0/VDJYvOyatqTBBXdlkHi1mvpm1wj7UY8wzO+cBoCKRDfwGcmX7lTpXLWjSyvCcGY6FkJnezIKUwIpdmQebK+8x7AHzlp9BEmXAJxJPcJKfI5rvvOigGfvm+HPBroiQDqIopyDuBbjwJkkDLe8x45pajvfJiC8JYk41ODrI9eOkb0YriSxDGv4pwgoOZq/z8+Rvhpi2zGhdo/lboCd8KJbp24omRigbZ8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsNgEL5fbtDw6jRMx09hI0sjWPH5Jnm2iY7dtGP+rAA=;
 b=SphNQusceNXfZ4IdGC2tVFPAk5/xlwDMRcPfLOP87dYmg1q01xCL8/UD6RN8sOHI5Yr7z/5gmBhpvktwsMxtJvzzEPvJjmgkDWQyM7lcD2VyXxfHI6heS956dDcHWrd9DfClp5MAOe/kyhMSIG3ronuDMpPBKw0XfNxIqnIg7s7Pzzj2DudyUd33w7DQzh36LwAzIThcjg48ws2yIoH5SlyRNnT1eas9NkBE3dOiEG0CuAlZTlRgWdGfIm2tyWCAmOc880yH+QzKFCfP/F/vd92chti1eWyJ3hkFZNz6b42k6wErm4kIF5HulBCBSH3lEXtQYIZyp4BtRvzEw2EyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsNgEL5fbtDw6jRMx09hI0sjWPH5Jnm2iY7dtGP+rAA=;
 b=FJpafNifIRIqOwfIPFEpxoodUWO2ZKK9VGJLf8nokin8imXOnzI3f6DRFeg+8dkrHcygti3c23vu1fNPuaU26u6tbSDISKfoJhFlooKEtdo+pENPW9TzL72wYVoV43Zg6D0xx0/tz+vhcnbrjPwfm6N8bqEHMkIXMCrs9sAQgSs=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 15:32:13 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 15:32:13 +0000
Message-ID: <ab4941b7-a722-4495-8bf9-bd1e602a802e@oracle.com>
Date: Mon, 9 Mar 2026 15:32:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
To: linux-nvme@lists.infradead.org
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
 <aar6j8S1O-mjqqxN@kbusch-mbp>
 <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::18) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: dad59490-5d63-4378-98e9-08de7df1095c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: oSpRkeeI4fW6A4hoXsxpZjtIWzmZ72cK4k7ITnHiZdkNikHay2hd5r0VMbZKOOwFfGMvm9ZxDtt9M4haxHsXSXnGVbU0wmafxAlvW4tqHUzp30QK2zVDXsf0v/WlbKT7vavetspCQmSgd8df/8MY12Gb315hgBWQmPF9/GFt13kZdc+vbSQJlYNyBeBn0sCQFsTXhxEm25iAdjU9a7UNmsJIZ/kXuKln/WYRdrQZ6EvmV9KLtOvMF8zsbHtYsC0OWFxBxiHJpTMDY3oljl2mpSAjHXGPokcfPUjeeM/HUY4VbdYFHTPEH2FwwmUPmt5RmRk/RYsHzGzeIvU7gUVnSWkGfLQbQxF25qA191rtbgeQPhme5qOcFn2r2dgua2cR6lRaNcB/xRyHrzHlnAuUfVaT42o3uMftqe4qPAGsk8GCjLJGVZ0FguxjGe9/RVIBj+ZHnWceN98HNeQ+DiIbU8lBk7qvrkG31SBb2hoITA7gN4qnC3NJfwePT7N10hTZuh3TlZW8KFXlrnGHkg21eT13dz+6IzIrGH8GtO5TS+du7NBZLOJf00uJUj1Y2k8Qn8AIqwXGMhi4RwIYb1OVh6cOiSLQGW8Rr1mPigf77sQPsviFKHLt7aSmWx9sZC/ndLDJ2BV/7O2EUmIDAocoL08kohW4UiuMKbmA9kp92UrfgMvN9dQdTcoHDC/QhsThFXGvTZiadrPhE85qAZOWpfZMPJOvjsJA7771TDEdSg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU0zK0NpR0tkNHlFbWdmR2swdy95Q2JRNm9lcDg4Q0NsVGVuMGcrR2FxZmJ1?=
 =?utf-8?B?SStzSmZEU0gvcC90OG9IWjRtbHMxajBRWGhaTmNlYldGeXUvdnUzK2FXVHJ4?=
 =?utf-8?B?R1E5ZFVKdGpXRnBTS3NYZjJ1Nkh6MFpiUEdLVFdiWDZSSlJ5aWRMa05VeWF2?=
 =?utf-8?B?Q3doYkxHM1NvOGkyQUFrQU5LVUJWZEpjR2J1Ym5CZmR5OFJYQXdER1pzRVdw?=
 =?utf-8?B?eGNkUlhkQVZIVmlndnUxSzFvbUJLZ1BVenBmclBjL2xjdWxRMXRreDBZVTVm?=
 =?utf-8?B?NjQvb0hOZnpWVWQrbEo1N2NGK0RFeGlIM0FpSE1BYzZ5WEpZdzRIOE9aV1ZB?=
 =?utf-8?B?THpyL2lOSDBsR0dPNkFyeW5nVGd2bXk0eThmSUE5bUIwRTlZY3NpS0dXcVc1?=
 =?utf-8?B?ZkMvNEloQ2RiVkZwM1hhRGc4ejVJTGxRTCt0K0tyeWRCNnRMVHYwQ0NPeGIx?=
 =?utf-8?B?b0NFWWoxRU1Qa0FQVWNJV1dmZlRxUzVBbWlOSzN3dTkxaVhING1xOWYwY1lC?=
 =?utf-8?B?UjdHQkw1Wjdid3RSM1pqaUtEblVrZjgyMUt6alpTZEVTQjIwSDJoVVN2VWwy?=
 =?utf-8?B?SHg3YjBQTVQvQ2s2akFWSXRHT1k3RGZJZEpCRG5VQ1A3SEdTbTh4d1VEcVFs?=
 =?utf-8?B?cG80QUtyOUQzUWZtNnZEaGcwYjNkcEQ1WnpPbmY2TXBpS2RSSE4wSFVmdFov?=
 =?utf-8?B?ZHpHUUR3czRsNmhBTXRlVkFLRlkxaG1kbnNPVXFFRUFvZDBlWmZDWGRsRUhV?=
 =?utf-8?B?TGRhenV2M0szSmxrQmQrdWRKK05QcjNMd3VubkxTeE14alA0ckZGMWhTMjhz?=
 =?utf-8?B?OUJ6a3FTVzJ5dFltV210Tks0RTdQYVdVUFo2R1dNQXlvYzR5M2k0NkxJUklx?=
 =?utf-8?B?eEZJb1ZEdjRBdExzVWxVKzg5ZEpuL3d4QVZHY1cvdXhuVUNlNUl5Z3B3ajZm?=
 =?utf-8?B?c2V6MmxJREFaOVBUWmtodS82MmIxK24vQ09JZnYyeDhxNUVKSWRmUDcydHd0?=
 =?utf-8?B?NC90b25XNUR1Z053TFdmL1pURDZYZW9meVA1c0FoRGR4ZG03NmN2Skd6ZTRS?=
 =?utf-8?B?Y1QvRTByQzVYTzIwZzNyNGdKUFl1VGU3WFNBUDZUNHMwQTZDeTR3RkltODJi?=
 =?utf-8?B?cEhoS0J6eHZxZTNpUjNad3NSZWprZmtRMjRhYmFPT0svOE9qRExRUmFoa0hz?=
 =?utf-8?B?azNrVFd1T0E3eXJBTy9lU1g0c1R5OVo3bGw1ZmdtV1pCZUdOSExkZlVXYkpy?=
 =?utf-8?B?c0pxZ1lESkxLTXBGMjZuV09OcFVqdDRINWRjWDlsMG83ajQzeWtzcG5aaVNW?=
 =?utf-8?B?NHhzNlZDWVI5czFlbU14T0ZudFVaYTI4bDd3eTJGdllFY1R0TE95ZFhENkRi?=
 =?utf-8?B?M0NZZG9WTm1yd2xhcmt6OTQ2M3Q0bmNuVnhUeXJvc1BBUWZsVi9RWGRFMnNF?=
 =?utf-8?B?QU1XZ216WTgxOFBrcStsMlR5N3JSZk8wK1ZzaWc3THBFKzVWaWlMUExlSkRE?=
 =?utf-8?B?alpISTBBUmNqbmg4NS9pVDFLNW1PemgwRFhjTEdXY1BHWDZYb3JsS1JxMGVS?=
 =?utf-8?B?T0NOUWRHM2s2eFdMS2kwV2QxQTBrTlRveWR0WHVRb0pSVkd3eEhnZTAycnFX?=
 =?utf-8?B?NzZWanZQTHV5TE96eWJzbHdIYmpVVzdxMVFHd2VWYUM2L1ZJOFdWTng5N1M1?=
 =?utf-8?B?N2I0M0xNaG9LUFJJRWNzRGxYZE4zQkl0QzdocVYzNTFyZ3U0MUJjbDJ1UnlE?=
 =?utf-8?B?MlQzeEc0RFVmV1VJUko3d09hYjNPZlplWjJGaUZaSTJhRTVoUVpteUV1WGtm?=
 =?utf-8?B?QkI3QU1LL2t4MlNkaDZMMDlUNXc0dUsvaE05UDZmSGZrSVpJNlFvTnd1Rmhm?=
 =?utf-8?B?c0haaWpmb2NnZ1RqU3A2bWVyWEI3NnNURncrSVVNN0ZJN2tMMEllME9aMEIy?=
 =?utf-8?B?QW5PdFNWaVByWTNOdE1CV0FRaUI0aXlFNWJ5VEwzNzZqcmRuQnlpVTg5a3dv?=
 =?utf-8?B?a054ajBIRnpGdk5PaVczY3gvTTBaSHFUa1JlYmZOTUN6ZUhta3dVbXd1d242?=
 =?utf-8?B?a2t5c1IwWjY1dXE2VTdGUUNGWm1oVzdlV0JVV1VKNkRRNWxYWUNFL2tqUzFP?=
 =?utf-8?B?VHdjL0Zxa1ZNRHdDOC8zRDY0NHpLQ0xBU3hEZmVTOXBZOHVQRmorS0ljVGJW?=
 =?utf-8?B?RXZzRThiOXRoZzV2UnNaR3oxMjNtVlI4dVoySEYzOC9mTGo0MytmbDhicTRX?=
 =?utf-8?B?MlhDcWEzdHA3dE00ekFWMUtEM1A3TzNvUWVmOGFMc0ovQXVPdDRPWVB1V2Iw?=
 =?utf-8?B?d1ZKZ1Z3V3U1eHNHNXNGUXVlQzVRcHdxRU5ySnZKZ216dVA3a2toZz09?=
X-Exchange-RoutingPolicyChecked: hDVAq2Pvx7S2S/MDUjFyu4+SUyp1AxAxkiU6DXv1LzFIJMvxsEL6JA4yoDU2oS1n79G7GNQuKLmPpRW1BOnzIStVudeh439Dk17AB6qCUKS5rx6Jinm9jy3xYw2yR5URxsJj4TPRDImNn0FdbTiDy9b7qoLHdxM8U/Iaj27JSUFzJusZSwMcjXz0A2w452xhaO5n/zljM9hVdAo+xjzeMTVC7uzSEApKMV+KUKK96+PBLoRQ9YEHdYiNl1JMb6Y531hOh3FEAA+lqzWI/+fIxBO5ZObrVTWG7qPXr0hH6LttqdyWpKFLi6E9v1By4lsfdxjSkFiZzYCldAlPUu5I7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DTDCId/D2QxH/CAtVMj9mviQPyRA/bzW8bI0NFCWA6q57SDlATwy/6vy7x2QJvsFBzTB/gu8Jg/Qj3/MSXq56SfWDkePf3AbSy3xnB7wDBEErGl4ZipZXZZttF2S255CEelaxlY5/WEXi7tj4rIy2OmPJFyMAKCHOp0Y8sVkdG+pu9MLmjNxi9yqCF91yk1BGcijjhWCoUqt8meAMjh5XqT0hvIjz2mCsjGE56ugSVXMlsEsOtTAFpp/73QhbhYGJqtR4Dm2NPxqxhqgpmHeJ44UmaZb2UflbcijfR/phnvECSzUFAnYxhoFYkwXJxWlC1JJcaCctao636ZMkIzEKq0eo4/3ut6D3m5cXr3HMv+XyJgnliq+SgeJi8pnWhQ2q9DK0dstL0S3K0d8RzxzBR6I/w2luyilO09DkNoTL32cZDLNESEzeXu+WGyn1ogzquq0iDj2trP+bZGTJP1a8XpIrVYwc2/mlAJ6YgVcDahAVgq34q2WF4XUB364K/KnBMf5A8OaIx8UqsvubWUYRG2WLiBdXbfQtYmGQnztg3TC6e+p+Qe/zrPAIp02yJ+IbSWHkAao9GmTvySSMPJRhQIIqX+xz3OGl8J6fChGb6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad59490-5d63-4378-98e9-08de7df1095c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:32:13.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOSj6GA0rfagTEsSH33WtsVPVv5Z6o1W776YuVj1Onz+JN7ve22GQEUQDpG7yrrrHaQInCDeq/O0qmTr/wV88A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090140
X-Proofpoint-ORIG-GUID: A_vpxSIAumnMG6USQ5u2CqeAh6CgG3qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0MCBTYWx0ZWRfX+idFvv/fnguj
 GSaKz+jhSjJGSTm7MKqsBQqllIDmYyL3+uhoFF5PB1B+ZnQISxEYtYs6FJ5pPqXGm0hvd2R9XgU
 9QAXHg/UPkhongIF9Qct9xXUnIFzr9lnEQQ5NXk0WhkRekftF4eEUruCbWVwHGaSoRFO91Q2Y1H
 Nu8Rq47ccaagAYxbG9YEDQ+b5Z4QZtejwxAkVDJY4/kwJvMKik5miC4P9WRwMuXWslD0/FO5YX+
 VfaFuFTPzOFcDEszWoy5f/u0M5UK7yIS0Db9R+cWBsRiW0Et3A1UertDOtD32xHQxNmv18aexU4
 EJjj/oxCMxwsn1DuvMNXKAsrNMVJsloEfCyiDFfPvFKvpLBIFAguXTb2OILDeKtgem7aC7dUuhF
 yubGiE5J/QJAT3AEtADgQiKzr0HteUegU+zDU0AXbA4QA0Kz9haSZm3G316qiZQVwVccQxcch17
 i/M64MjSyg63Q/VlrdA==
X-Authority-Analysis: v=2.4 cv=S4vUAYsP c=1 sm=1 tr=0 ts=69aee802 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bkgejhSUenPj25aotEcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A_vpxSIAumnMG6USQ5u2CqeAh6CgG3qy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_083219_525015_44D3BC17 
X-CRM114-Status: GOOD (  17.71  )
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

On 08/03/2026 18:55, Nilay Shroff wrote:
>> Last thought, as you are probably aware, John Garry is proposing to
>> lift the nvme multipath into a generic library, which suggests many of
>> these events would also need to be generic. Should some of these, like
>> error and retry counts, be appended to the generic disk stats instead?
> 

Thanks for the mention

> Yes I am aware about libmultipath work.
> I agree that retry and error counters might conceptually fit into
> generic disk statistics. However the intent of these diagnostic counters
> is to capture all relevant events, including passthrough commands.
> 
> Passthrough requests are typically not accounted for in generic disk
> statistics, which makes that interface unsuitable for these counters.
> Additionally some counters are reported at the controller level, and
> controllers do not have an associated gendisk or block device.
> 
> For these reasons exporting them through the dedicated sysfs interfaces
> appears to be the most appropriate approach.

 From the current list of proposed counters, my thoughts per counter are 
WRT SCSI:
"nvme: export command retry count"
The ACRE which this is based on is not relevant (to SCSI), and I would 
be reluctant to add such a counter for scsi_devices

"nvme: export multipath failover "
I think that this could be added for scsi_mpath_device class

"nvme: export command error counters "
Similar as "nvme: export command retry count"

"nvme: export I/O requeue count when no path is available "
I think that this could be added for scsi_mpath_device class

"nvme: export I/O failure"
Not really relevant to SCSI, or more relevant to SCSI low-level drivers 
(which I would not want to expose as an ABI for SCSI multipath)

"nvme: export controller reset event count "
Same as "nvme: export I/O failure"

"nvme: export controller reconnect "
Again, same as "nvme: export I/O failure"

BTW, I think that the counters should be atomic - otherwise we are not 
getting accurate results. And, as is mentioned, none seem to be in the 
fastpath (so I don't know why not have them as atomic).

Finally, some of these counters seem to me to be more suitable for a 
debugfs (and not sysfs).

Cheers!

