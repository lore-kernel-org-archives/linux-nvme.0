Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9434ACA0EF8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kTVp3N3xLIBznLLZeCkxSdqrDTjaXp9dQc+ctSphnU4=; b=hn6450CwX4x65UGwxGIAkK+1zc
	FKLEEnnaOpVczIRIU/SpwNTgmWArp68F8ms85WPE6wLsQ1yAs39fxYBNTAPkUZMa0vKM0A8EaMIKP
	dUc6ATj2CeYtCbvCX8yTxR5v+AuM8WltIlohEfplDeAdqP+ILD+HQsjQmlDD2PsIZCh2teaWLFDtj
	vvDBFHBSSM3CngdbXiD96IGcubR4fH1G/EOKgRZM44n/P5vAVOh+s+HN38TXp7PHNgdpIi1Bt8ONx
	cV4LHKFFexc19vLiEHe8BqNiXSpTr7nOgjixNyj7qVMNZ45m8fPZtvzMAMOs8KRhDktA8HXEDhb2y
	CqV9PnOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5Xi-0000000H5g5-3BZM;
	Thu, 21 Aug 2025 13:41:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2yn-0000000Gg4x-1UEF
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 10:57:14 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LABNrI016318;
	Thu, 21 Aug 2025 10:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kTVp3N3xLIBznLLZeCkxSdqrDTjaXp9dQc+ctSphnU4=; b=
	ZR2VlxsPHc0D0ZvASe8QApEovAojdVSFICRplfluHrUMF5gc0XSXMpFSAzhyfUdg
	Usg0ZaXbWB5F8Tt5Nae1RN4sNVovojy6Hnqk0OvV3bpLU36KJ7aPY9YSitSpiP4I
	kEa9/xTomW+Z2HsEqYuMcG6JOCRflhsdWRRaBsOeQNo3KdZDKzEL6hdNUYQP7gVR
	MhSH1hAPC/XtzQVHsB8JxdTOmH+gy9LA3Hfm5h6ikYZzdUNaUF6VmsiCTG/vzS/H
	+PXFwFMITuMnhbWkhZTZg3Dpj8/xZ2aJaCLTvsXtIZoBbqLd6AvOu9VNPIHLENM/
	BMv306fqbWvko7+6vbeb6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr36vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:56:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAbtN1030250;
	Thu, 21 Aug 2025 10:56:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3v7mkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfpjZid3qU8nLylr9SXkKWz/K01XTjLrChWglpnHD/4MK1SJzz6XExmfG6WxmR8CjO09EzrAD1G+P7EHjrVaPI0yf4ULH39Vg0SNGfXH95OVGyKx3SzIIz3CJe+sAODJr0BQBhJUNUbJVH+J+BjTMvUiTuEjRUzfc9mFDoZb60UwZihgBzSseRL9exZ+kuVvW860PYgiccttu/4B3+8Uxc0EVKTJ8x7MmPm8xodjxX1EYTp+NIvC0mLUJmcZdXOpYkbKMVonKuYmH2vmKj33wwzWyc/PPwW4eMhX5a+srDyep0zZINzfu3QqCm38um/KhCWk2LdXjfnUMwskdiZpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTVp3N3xLIBznLLZeCkxSdqrDTjaXp9dQc+ctSphnU4=;
 b=mDgdiNvONxbLp+60JkK47EnjpoIysJfvDCgc7YiQMNYOQCuxqHnLLw8ztQq19idaN3gmFQL5Wfr9kHxFpwYkiF1Zu6AxFn87KiQFNCigkxHe+8shcDkZsRPtrti+QuhJnNHzBN2uLnm6pLGw8nx+/XYROvua3xk/Hx7uCM8p4xkOcxzbmNk13I4sHFCdnQPqiaSbsCaAs4ndBxLIjOBxVEirSMbBw+ZLa73fMZtHyGwRNTe18K/GcE7qGlR55mm5Erw1y4Qrg2UksyikSoinH7pfeIdnHlTMBYnpal8CKtCvyEWEqJMMUwB4C7tkIVRvzemyV24R1LfwNEcq4lhsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTVp3N3xLIBznLLZeCkxSdqrDTjaXp9dQc+ctSphnU4=;
 b=u/YFoAoLNnRoEAtrVy7cpam1TCVOsJ3d5Ox0p/zM9YEC41rRgLSFT9haNsE1A6Nc8H5oRWT1M5loJArLNTLqLMEmwhuaqTRrci9V5CJps6E24GtLQGUVFbCeR18JQ5EeuAhDpOfDtgmElNLt55YXWG3KRZGLLDqxEsNPO7wjEk0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB5662.namprd10.prod.outlook.com (2603:10b6:a03:3dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 10:56:13 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 10:56:13 +0000
Message-ID: <d7b24c65-8276-4e22-a9ac-0777bdd0113e@oracle.com>
Date: Thu, 21 Aug 2025 11:56:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, mcgrof@infradead.org
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: b6393e2f-2229-4f20-2407-08dde0a15822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDA1dkFVVzlmZEdJTnBXaHdldEhRR0owRFFiMlg2MzlNTmgxVnMvV1Y0TUMy?=
 =?utf-8?B?RmdVK1czRExCWk5PZjB4YklFdVNWWXFFM2EvdkNpc0dzTDh6U08yNjFWZmtN?=
 =?utf-8?B?WXhJeDhQRGRYdStSQ1B4WlozeDl1NTRTdHBISFhKSGpEdGE2VFh3RndlRmxC?=
 =?utf-8?B?ZFBnTUZIZVNDUTNHWHI2c1J2dUdBR1l5WFp4cVNXMzdrUm93dDhObXViWmZk?=
 =?utf-8?B?K0ZvUXJKeGRpaGpxN1c1WFRrTXlubFFQOHVtZGZkRDFMY0RHMDNTek53U3h0?=
 =?utf-8?B?M0FzNzZPY3lBc0JxbHNjZ2FTS2lNaUM3SjI5c0pVSHJKVWlDbklXMm8rZmh5?=
 =?utf-8?B?NDMrb2o2cXRLT0QzdEQrOVVVV0p5ZzkrejIxaUF5K2tlczZyM2JtMWR3OHJZ?=
 =?utf-8?B?cHByZFFZUURITW5wbFNoRTJJL09GY2NOQVJZNHU4TkpzWUVTN3JqQkRUOElP?=
 =?utf-8?B?M0pHY3l6R1FBQVl2NFVXc0VGRlIrNVgyZ29rODNveTJiUTRhalQzb2lTOEJn?=
 =?utf-8?B?RnJuRjR2azFZZnBaMUhZTy9tVDJmUHZkeGpZUjBxc3MrU0RwbkpsaUhmV3Vl?=
 =?utf-8?B?Kzh6WHZyQ3hKc0R4KzlMUGJaNTN2YWdNck9zR2doa3QxM09FNXE4SmNkOEx5?=
 =?utf-8?B?Mjh1Wm9WamhScHpQeVVtV0JGYWdvQW05dXEvVEtLN0xibFljVnc5ZzkydTdj?=
 =?utf-8?B?QVg5eTREZk9LdGc4Tm1PUzZORnFEUnJLOW5nci8rVndCU0pWakVEK0FkSUZX?=
 =?utf-8?B?a3dncnYrU0d4R0gxNks2UDZxMVU0TDhkb0ZmQXJpNXJoWGJpRlNpMURYZldz?=
 =?utf-8?B?MVJtRmQ2YmJHdUkrMkRJVmNXeUlwZmVXSklwaGVpVlB5TU0yTWtXRUZxaW9S?=
 =?utf-8?B?b0JOMXpWeXRPZG1NaW5sbUNqOGdrNEhCS01TbXhCbEpvV2I1UFRQUCtMakpq?=
 =?utf-8?B?VnEzVnNVQUdPMDZpN3ZUWTc2cGVobmJJWHpmTHVxWFlZQjZlK01tRlhoYm1K?=
 =?utf-8?B?UHYxNUNJMGo3aExwTDBoQnVhUDVFUzc2VUFXYy9HNHIwNG9FMDdUd2J4WW9m?=
 =?utf-8?B?eVpjd3V0ZWRuN1VlMjN5MVNEaXVOQ21zeEVrL2ZvUXZyNWozMnhMM3dXbmtr?=
 =?utf-8?B?TjlHb29LTHR2bTMxMW1LNzZiNExJUHgyVDZHaWlRUEZIaDZaa1QzeU9BNDB0?=
 =?utf-8?B?c2ViYUtrMEVuMUVqRmpOdUw4SDlndGFvQ3RDTzRTR29pR1FaNHJSNHlRcUMy?=
 =?utf-8?B?d0JUSU5GUk41ZW9mRklrQXNxZ2xyM3hDRW5Db2RxUlJnL1pNU0dkdTI2dEVS?=
 =?utf-8?B?TU9BOTVaVDZwRmZHcUROOEdpTFZNbGZkU2pmejRPNFFMV3J1ZkZjbGFNM1Yr?=
 =?utf-8?B?YU52S1lZYTdmM2lWNkJsNVUvS1RBL0Q2c21yaERoRTdUcG9mODJuUmorNUxh?=
 =?utf-8?B?L2dkV0R4WXZHa0FiWVRrYWtPR3U3dGRHREZDaEMreDN3bHovQy9YM3NrV1RK?=
 =?utf-8?B?OTJ0Um1RNW1sNWdlQ0RBSlZ1cGIzNHBrOTB0TkRKakpkdlBWK1A1MzBXeDV6?=
 =?utf-8?B?WjdhblFrR3JkZ2QxTU9NYkpCaWZmSzB4THZjdTB0YzFYUVpOK1ZGZmV3UXIz?=
 =?utf-8?B?MlZRdS9wSUhLVytrZCtjL3hIVXJ6bEJsTU9Oek1BV244ZHhXVHdTT2YyelRX?=
 =?utf-8?B?aFZLUHBtRSs3ZmRha3NkMGxLYUt2YU05SkFQeDU2eFkxTW9ZdGUvNkJFOG9W?=
 =?utf-8?B?U0xkTlE3MzN0b2hrZWRZN1llaWhaV3pvUnBLM0NsN01NS2hqNXRqMHNyWjEx?=
 =?utf-8?B?SnVwdXV3REZQeURvU24zaU05ZmswYndaemVNRVhYSWtIdXhVSmVtY1Q5bGxV?=
 =?utf-8?B?RTJlOEZ3TDM2MS8zR2xyOFhKK0VybzdMV3d1LzJLR1U5ZFlFNEtKRFBXd3Vl?=
 =?utf-8?Q?FObkR+3H0AE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZmdlpPZTE3cTJmbC9WUHVZUzJqZmU2eFdPWVpJNXVTOE1aenJieVMzbGlo?=
 =?utf-8?B?YmZNRlZQTW5NZWUyejE4eHN0ZEJ0dGpvVS9scVdXR1Z3VnFTYW11aTZQOUdU?=
 =?utf-8?B?ci9LZm5ZaHIwejQwazhWcVVtUHRtOGhwYlV0ditKc09UaHg3UnM3U3FSSXJn?=
 =?utf-8?B?UXBuMmVDemdLV2ZzWXlXVmhPVEJDcDdUQmM3ZTl6MkJGTE56ak9zZFlLNUww?=
 =?utf-8?B?Mnc0M0tJaU0xeGxUbFdBNWN5YnZNQnVPeHhPM3dRL05oaWtGMERiY1JLY0lk?=
 =?utf-8?B?QWx3SEo4akt0L1cxejNwK09PQnpnbGFOSHY4TklKaGtNODIrbTdjQWRNSlFC?=
 =?utf-8?B?ZXZ6U012YzFQZWk3SkpoY2s0dGVPUkVhMnA5ZCthc3phOWlBd2ZRL1JuaTdk?=
 =?utf-8?B?VHY1UkQ2bE1nVUxxenE2U0NmLzEvNTVGVnNSUDYrRmhiblFlMS9xYXdUOE5E?=
 =?utf-8?B?bGdYemtCbWx3VGo3ZFM5S0JSZnRvbjFUVlE0NWJkR2JrdWYwQjc1cGdjQ1pE?=
 =?utf-8?B?SzQ0WFByU2dTMmRyTCtjU0JoajNiaVlPWjM0cDVPU1BRcStFT21maHowSmpS?=
 =?utf-8?B?Q2FMeUo3NUw0VE9WMVZwUEFibWQva0MwOVJZS1M1WmFDdzROZEorNk95eGpI?=
 =?utf-8?B?ZElFUXJ1dG9WQ1FVb25Gc2hkY1pYM1IxR0RET1kyTURGcFdXQXhwYUVwUjJn?=
 =?utf-8?B?QWcyNmRRYkNxR2ZwakZ5UGV3ZVp2RWd5c0NVMDNaY0J0cEI5VStaM3M2TFJO?=
 =?utf-8?B?aXdiOHJPYzY1SzNnZ2hXU3REYVhDbSt2MXVBS2pWN0xDVnBpS0FrZVRhTzF6?=
 =?utf-8?B?ek42MW9pTjFIZ2EwVndEZ3RvMXJ5anpQbE5oL0hwS2ZEYkJkWDU3NWZwVXdx?=
 =?utf-8?B?NEZYTlhqdjJ2QVhNUXlLTUphVW0vRnlaSUlOWkQreDJvUWxudGMvWUd4cGd0?=
 =?utf-8?B?SGhNWC9ob2hmaUQ2eHlpcmMyVXdJbDdFZ3loOHRVY1R2WGdrMCtYOWZVNDhk?=
 =?utf-8?B?UDdKeGI0TnRBN0VuUW5NQ0RGY1VxaHBSNERLZ0V5Z09BRzIwVnBOaEZaaSt4?=
 =?utf-8?B?WWlvUitONDJkcFRBblptbDNQNG12OGRNTVU5UHNudyt0bXVKT3RNWVpRNUZj?=
 =?utf-8?B?WmJpaWZrYTVwbWJXZjRzQVM0b3AvWU9lZ2FQcTdVbHlhWXJ6Zm0vcm95TmMw?=
 =?utf-8?B?dnFyVEM2aVZuV0J6T1VYcHU2TWN5Sm5CdVNMN1piZVcxUzg4Q2ZhdkxhN2NW?=
 =?utf-8?B?ZThKMy91WFRrUk85Mkt5M0M2NU1NVzUrU3llZldrOW9mSkF5dklLNXc0cEVB?=
 =?utf-8?B?VnBlTkZrRnczelpXTm5IbTcrUE5PZ0t3RCtEdDZTdE50M0JWczFIQUR5ZmE1?=
 =?utf-8?B?QUtweGFodVc2Sk9Lbk04Mk85Q2Y4NHpac1lGVVcxcGt2WnZsZkFxL1c0d0s5?=
 =?utf-8?B?RFpucFZJZy9ja1M0cldHTHAzSllldDdzVlhMbnZQZmJGdCtoaEpYKytsdXlU?=
 =?utf-8?B?TENVWXpVMlpKdHgydnJFZEowTXhxR0lFdFQ4aTJsRk1MemtRRnFDMlJVZDBj?=
 =?utf-8?B?YzFNN1luV0xwODUrc2p3Wm5NZTU1amFXeVRWZWlUQWhZeUVrRW13T2hMQzRW?=
 =?utf-8?B?NS80MUlZdU5oNlMzNDczcmIxc3oycVA0UW83K0JYYSt2cExqNGxTZVpDN2RK?=
 =?utf-8?B?OFFuUnZYeEVyZUkxZFpyMmtzcytmTDYrQ05XVUZITDhtUmZWcTZ0MW1kSTY0?=
 =?utf-8?B?Ty9iQzRIYnFhcGdkTDFkOHZTaDhrV2tzQzhHMjVhSkEvTlFseDFZTmo5M3Fz?=
 =?utf-8?B?M2U1dTJEQ0RxamlWbGc2WC80TlBqU2hPdUhxby9BUGNFdW5mb0lZWjlIdnNJ?=
 =?utf-8?B?VDEvenloa3k0M3AwQzI2U3N6R3o5QlRPWVFsT2FEVWZSRnpiNkZRTEZ0aEJr?=
 =?utf-8?B?UnY1K3RJQVd2WlhoVTNHUjFhQjNJQnVKUGZHeklvSnBPRU53Rmw3Q1d0eXQx?=
 =?utf-8?B?QURsWTJTZDdKM0R5TEo1aktIbU9jVXNtek5LTDdLQzdIVnlPMksvcTR2VnZz?=
 =?utf-8?B?eDF6c1NWNEFhcmdwMjVPN3pyWnBKa05YQVkwaUdqOFdqTVBzYVVyMG8zeFNC?=
 =?utf-8?B?M1N6bjdFeW9pN0hZRm1TNHNoc2ttanJ1bFl6VWZWSDlaK0kra3pxWWNBODBK?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8V68QMiNNeRUWD50Nq+r3o2vv2TRPMuHEvbM0QXeEjK74jRt5IhkEe2rA+BFqZxSw8l5Lur4hGJJUtwAFZa5hV7rz44RKmrLQ8EsDBQR2hRldk2UYLt/x6sqBrPhxYw55kX/nn9d7nvrEt+dGGV2uK7W2j9tXO6VXcfeWqv6T0UAhsY9rgZ57b8NA65g7q+ArxIPfysUhFxJCYYKBLiNgR5pTHwQVX95WH3uDrXcMIyDJqKM5VdJ1VsJtiOg3fPv20HcRA+T3w9a/gRcKLNZBJnjVG3Db7nFGjsQIjzV4Dk/kdeN8H8F3QMuMDj/55NZx6rmrV6hS6bPuMaj26tkSAvLVZxF4vfHIauxZQjOXutse/YSkO/XQutpbHAmP5RHB5R7etDnV9mJgnEoLeT0jKJ4H4DNxGcEnrWF2K0FQxFrxxefg1Mb/1J9/ARci7G5GOLxqMDctmr7IX1SRIMmLYVQwYIypq3Bahrk54C7fngeC37AKdgBknOkhSe1PpMIehRMgNW8cQHEyye4KXMnH3hiHdepz1xfzJ8K02e2aLrRKZLrztEon4zBhdynfiEvpynEOQV13qVLG79B9n/aFpR2bEWh5/0rrfYazGOW6w8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6393e2f-2229-4f20-2407-08dde0a15822
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:56:13.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXi2VKGx6oMeuRCmJphbCaPcuYgsePfm+mjAxbuxyHj4sXwE3M5uO3Gx1Q3NcuqQBHJ5ydJAzpTnRIqwpDBuiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210086
X-Proofpoint-GUID: 6vNQLqTevDMB54qQOhIWpQDeHUF0HSCd
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a6fb50 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=FdF1hyGLymtzcZRsBjMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 6vNQLqTevDMB54qQOhIWpQDeHUF0HSCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX5LhNRfT8ICBE
 W2BdeoD+WGw9u8cfYjxZr3MExqJwVSHkLXT8drBzRGNpS5C9AXLYLvcDCgqml961fYqaMBq6sEs
 v+ed+FKmKHFGaH1uLEu+OsxyKW9dGfD/pP4bJxGWaD7CmCFl32SfBa5gUz3i2UAZFD52gzWUWxl
 HkgN8AqRgnwj/AdqXNdhQqgrSoizwvFVqfukNt9t/cdO4mOGtndu4t+apheUzZyt803oWvZU6TZ
 RvR1C6X5RRo5oSR66wLA3v7Yay6zS5ylZ9gmVe/KQZ6YyRjmQEO9Ma55guqOBsvxc144kta19xa
 bLF3gfsyZYUgwslTEAIBn3oxtKTK7f8V0o8zpRhyYb8un/Wc4HWYXgv2uI30+OIAtczLm1wj8e3
 IRfnNGYClVPnUxDHBEyhICfsyW3wqBN2FtzBDKHHb2r2RqxzShs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_035713_507183_C3EB93B5 
X-CRM114-Status: GOOD (  16.36  )
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

On 20/08/2025 22:51, Keith Busch wrote:
> On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
>> It would be preferred to stop honouring AWUPF altogether, but this may
>> needlessly disable atomic write support for many "good" devices which
>> only specify AWUPF. Currently all validation of controller-related
>> atomics limits is dropped.
> 
> These "good" devices that only report AWUPF, is there some set of
> characteristics that generally applies to all of them? I tried to list
> out conditions for when I think the value could be counted on here:
> 
>    https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> 
> I just don't know if you know of any devices where that criteria doesn't
> git. If not, maybe we can work with that without introducing more user
> knobs.

About the rules,

   1. CMIC == 0; and
   2. OACS.NMS == 0; and
   3.
     a. FNA.FNS == 1; or
     b. NN == 1

I have access to two controllers and they both set OACS.NMS and neither 
set FNA.FNS. I wonder how common these rules would pass to be useful. 
Then having 1x namespace is quite limiting also.

Thanks,
John

