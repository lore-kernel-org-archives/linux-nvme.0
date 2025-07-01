Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB6C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnUi0ihqPcxB3Bi/+qCxRtBxYe/TkF1/nZFYVcQe73A=; b=k/UnqYnFQG2QLls48RgLJdN8eW
	0vKimen3xft/yYJT5lcdbHOCUizzsw0j/W6Kz7dh2FEyBy8K3Hl3y5X/0YAHR3ST6AS8/+fWZvdcu
	7weQz5ngC/jKd2vmj4K6vuxZHxCO/BW8R19paheefFxFMObUn2NmLFmbNunMviNOwcEHGw+XRfmrf
	YGBEvtkITjdg0go5xIHW7vMfSL2ww6qvOllYxbhe1D+SUVcwyDL4G8/vWZL3eSYDtmMgshto6hqb3
	JrFnmynJBD9qTbjyyWyxwUjG6Tcmt0P3s8QqiMjuMQgy8TI4qomCgasQFyBPuIb9xi2AWXVUOmSrx
	UC+A74VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWfzG-00000006Mfb-3WdL;
	Tue, 01 Jul 2025 18:45:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWdH5-00000005wia-3mBt
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 15:52:01 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9RIL024738;
	Tue, 1 Jul 2025 15:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mnUi0ihqPcxB3Bi/+qCxRtBxYe/TkF1/nZFYVcQe73A=; b=
	BOn11kmv/iBQcYUEpFs+FE5kzVg5vQ/jTfPrIixnxERXIWnvbQrmS1xR8nq4QZ7M
	2hYnx+tbVKr/wj3z/pQzsUWwMg3ek2wKPVbOPAhRz4U/kMKWWJPn2CTu1a30/wJ5
	Bk3dDmb41/39mxzCWV+PRI1R5s98tln+aANSUmWnGymz4UK6KKQ6aTImOURHdbzD
	0cstgU45C7tw2sO8e5zK2iaorbm7Uk6m9fDUMf52bbceBOh0Fo/CDotJdXQE0nDM
	kH1LT+m5WAdDpOn6Xu1gtH3F9RmN25n/34CS3CgovIVObP7jjyF5WYWe3Sb7y+Uh
	eR6eUvfWkqAE0W8wW+fxiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704d4d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 15:51:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561F0UdC019238;
	Tue, 1 Jul 2025 15:51:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1eqkft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 15:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVbTL+Usab4CzZg+nvHZbbHyo8PzALmISyuQ9r+X9TH3efOxEV0U+XbTb0BVi4qlEM5EnwjU8FdpuaQXzeuKaNSlQPdIsH2tuTCx+LOnyPPB+M+tc6zwBQDJm7Fpep+hQTVVOrL9eQHjP+I6O0t0Eb9GZR2/t+3GdaVRkRlCediQbKa8kB4jgmE5sNd2TuQlvDQUf+Kq+tWQLa1qErl3w4sHfcf4pIcI2aDzOwwN0Y8qDPRIGZUAej/UcBHCms1gGG9t0LvA6iVkjzeMQRN17m/eHMJhH3Z1upwQvTOM8ouQNyyb/C0GN7nULRxZWcb5/tm4SzVpFlXPCFw5lsC77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnUi0ihqPcxB3Bi/+qCxRtBxYe/TkF1/nZFYVcQe73A=;
 b=hUUWzIW695BUAL9aczOis6bwj66xg/sqinvDQR/XZdvz5ZloiSsffaNVWOZivgvt2DUc6npM3vvFdTG3Isb2oZH50TXxsihY+g/3pzkh3W/eyWPS+4f5r45l1HaeOOccaEgpkoxHN7OsaI54PtCxB9X2H/5ZuYjZeLHjZZ1TpvrHfAfuDHc7/elQmUcL2ihkbYf1ZjXMJgJP143nYIsprjz/RTqJqaTRugf+Vi5ACTeUZ4vDNFQG7cEc8dVNUqnprXzlTJOVM1sRcR32NPQPRSeDuhkVn2qVaTEFNyfvv8V54e3xGb44gEZN4AdUZgYgC7p+xnO34wXuEAeQ57atgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnUi0ihqPcxB3Bi/+qCxRtBxYe/TkF1/nZFYVcQe73A=;
 b=eLcmN+kc4afRXBaUwrW77+n08dh660/Q35LRjs/SVQKWbYJiW4kMJ3Ja+urjsPywLfV8tLESsd3p+vnJM5abXPrbg3gPrwGcWUBaZ/Rm/gmDKCwUWtXqLKS5qNwnRPsx1ZcsVrhO3GcALyXZAS1HIvOai/1ZnlhpLssQbBANfMM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ5PPF4561E4FCB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 15:51:45 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.025; Tue, 1 Jul 2025
 15:51:45 +0000
Message-ID: <dcef0a27-c502-47ff-b42e-d15399a81ee0@oracle.com>
Date: Tue, 1 Jul 2025 08:51:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix endianness of command word prints in
 nvme_log_err_passthru()
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20250630162153.4040149-1-john.g.garry@oracle.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250630162153.4040149-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SJ5PPF4561E4FCB:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1ded10-c395-4461-f051-08ddb8b72e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2tBa3V5YktkTnZmSXhRNTdqaWdBd0xkcnd0aG9NNHNzZzgvaVF6Rm9hVjJR?=
 =?utf-8?B?MVNLSjdPYUxmTFZtWEFNdWRwSUtYNzVzZ0llTCsySGF2b25hRG9jRTd0czdE?=
 =?utf-8?B?aGxEdjVTdS9vV3FTUnFncGU4VlVGa0FlMkFQNjdQWDh5cjZvWlNqOUVkam1H?=
 =?utf-8?B?akxqMThibnZJWU84Q2QzcmpZSlYxeXBtWTdwRlRDMy9YS2I5eStSNGIzb2ZY?=
 =?utf-8?B?ODlKUUtveDNHdFAvdnh2YXBKc1JkVjFxdzBvdTJUMU1CTnpOczhOUnZOUHFt?=
 =?utf-8?B?Vk0vdE1Oejg2REJacUNRUWw3OTVxVngvcW1PUUlTNU5vN214c1JIUkVXZzYv?=
 =?utf-8?B?UFJscVh0Y09vSHF0OThhOTVoWG1sbXJQQVlQL0tic1hHOVJMb0x5SUdvTi9y?=
 =?utf-8?B?Vk9vVHhnYWVHWGM2SEc5R0FIRDlzeXZwQVVTaUFoRmVxcnkxWWxVSjR1Zldj?=
 =?utf-8?B?TXFHTlcycWdSenZET0hrTjVoRmN1aTAydDZRekdJVVN2c0tESm83NklLbmRp?=
 =?utf-8?B?OHk0T090RnpRZThvNFRCNXJzdUZpM3gxU2xHWVZEaWRIbDlKaDlXQThHbWlp?=
 =?utf-8?B?MHdZSks4eEJ1NkZ4QXR6VE9YVzlSRHp5MDNTV2ZHK0ovVnVJV2lEQ0pWQjBX?=
 =?utf-8?B?ZTVnckhwazZMSU0xRS9NSGhUUWIvTDRoWklTaEFCTUxmeTFlY3U3ZTlieEtS?=
 =?utf-8?B?WnJhYzBER0haRTk5RjJIM0ltajh6VmhHNEpVMy9LWUNkZ3lnM1NPeGhBRDRl?=
 =?utf-8?B?MjlRVmxDZENNeERrTVpycXVEZEV6Qk1Hc3oyVGVwclZXSW8vNmwrQzJuSFdx?=
 =?utf-8?B?cmtjWXIzdkJoVG9BeXZzUXhBUjhxdW1TVVlhbHRhaExES20vYTRBNlh4ZnFy?=
 =?utf-8?B?ZWFrMk5Sa2xaWHhqT2FUN0s4ZGtjTVdEdmJoN2owcEZBMTNKcmMwR2FpODRs?=
 =?utf-8?B?bHI2a2gwa3k1UzlrNjJJUFZvTnZpOG1SMHBQSFNONXJUMjVDQU9YbkNja0lu?=
 =?utf-8?B?bHNKdkFycmtCN0g2dVk0dGxnQ3NpL0ozOUM0S0hmSHRjcE5pZk9COHUrTWIr?=
 =?utf-8?B?cHZtTE9mN3dTTWJoQ25TMnVwT3lXaUV2RGhJSTBYaWMyRldyVnBLR3o0cklq?=
 =?utf-8?B?L1RhQUZ5bGlNZFRlbTltZ0lQSlRhaEUyb3pHNzE3SU9xNTVIZW8zcUp4NERw?=
 =?utf-8?B?Z0ZZdENUL0cvTzRlMGZiUjRGNDREWnJ5WDhzRlhXZ20zd3J1cTYwYnl0Q1I1?=
 =?utf-8?B?akJKMjZRT3k0NUxTUTJRb3d4RVh3NlVkdlAxVW96VVJjQ1B5cFNEOTdCR0dL?=
 =?utf-8?B?MVNKanRXRmpHeVRzcWkvMS9pS2w1c2xaQVN5V2FWM1FBVHk5NkRmbVp0UWNO?=
 =?utf-8?B?dmpJdDljd2VTTDZ4dEFaM0Ztanh2MUlXVUhzRzhpWXJUcGdKZENlU3hDMDgz?=
 =?utf-8?B?MVYyZDIyeXRtVmhpSGhXQy9sc0pLMCswY3lPNFNZbWFsWm5wNWpLQVFWazJR?=
 =?utf-8?B?Q1hvMTk1Q3dHdXpmUE9sdGdDN0pCNDlOazF5YlpqVnRGM1dsMWhrdHNBQlJx?=
 =?utf-8?B?T1RIeitJTDdpRG8xSE90Mmd3M0ZsajZGQzhKTjdMVDEvei9hdUNPOU1RNldI?=
 =?utf-8?B?RnB0bURVejhHbHZsbkw2MnZ3SkRjcUlXNnJ3eVIxbk9Ga1A4NzJEYjh4WWlB?=
 =?utf-8?B?cmtRbHcrSWUydW5TT2VzWmtUMVppa2JvaWpmcm04eERSZnI4LzNGbldYWHhz?=
 =?utf-8?B?TkRVWnFTSUxQek5EVnF6MzJSQzF1MEN0eDRsaDgzcExPbXZJakJaWlZvYUxk?=
 =?utf-8?B?R1VXRTB6U2tabHFrc1RZWHlzSnFFdmpPMkZ2b1VuTHlMR05vT0M5TDdLM3Yz?=
 =?utf-8?B?MStpcXBUclVaaFhwOWtjeVY0VHNuS0NVU3BPRGRVSmlBYkxraHRIY1M4eTln?=
 =?utf-8?Q?FOtaw79q/q4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNWZ3NNTDNyaDNsS0phTklaWmNyeWp5dXdkZzNsWDQycnY1MkllZUczUmJa?=
 =?utf-8?B?UndUR3hFNEgrS2p0UllPNnNmOEttdTRoN01Rd3ZydWNyT3FPNjgvUlloM2NB?=
 =?utf-8?B?eGVpdWM3ejZpOXdRUEFVRWdHQTA1YVkybHNuTlIzZTM4UmhNVmc3WGwrTVhX?=
 =?utf-8?B?QlMwcWpFMHhvN0p4c3VBT2dDSGM2YXRJaFhNNCsxVEdXZTk4ZDNPQjBMdTRS?=
 =?utf-8?B?QWdOWjkwWHNRenZyazBMTXA3WXR4Z0pWVmtnbUJpRG9ybXFoaFk2Y2dCS0hD?=
 =?utf-8?B?MEttelJjeEIwR0Vwb29kMmpIVnVRVFI1Y01JMlk5UkRtRU44Sm44QncvbW5l?=
 =?utf-8?B?YlZSTWJWbWhFeHh6ell5VTR0NWZjWmEyakZ2bXRsNURDSW9lMXBiSXVaWXZZ?=
 =?utf-8?B?U0lwWjJvbUdqNnl3eDN6bGJ4UDFWdFk0elpOWitmM2xRaXI3Q2REWkN0U25T?=
 =?utf-8?B?MFVPd21TcEFsV2NpS0FlNmVZaTNQNzNPek5GUVAzcEJOMmJsbmN3ZWdoRHdN?=
 =?utf-8?B?SGUzbTZEcis4bk1CZDNmWkpoc2hjYU4yWnQ1WEtOK3RyT1FOQzZFRUdCYkFT?=
 =?utf-8?B?NVhaN0x0QkFnTElvWWJpYzMxOTZHWHFBS29LL0Uzc3Q3dnh5aW84T3pmVHFM?=
 =?utf-8?B?L1FVM3gxZzByUzdrdGtEaVppWk0va3VyTHJ1VzUveDZBZ2ljZHJkTVVKVlZa?=
 =?utf-8?B?VGc4SkRKTzY5MlpnbldkN2l6cTNsdzBtNWYxSlhsQ3o4WTdKc01UWFJySlF0?=
 =?utf-8?B?OEl3bHphRTVvUDJqT255b1NnMFVFVUF5L2lka3VRL0xLRXcveWsxZHhqellV?=
 =?utf-8?B?UFFpdDdIYXdxUlZrR1Z3bjUxSFlvWFRJb3o3ZG1HY3R6L21hRkkxU2VTdzQ1?=
 =?utf-8?B?NXZOSnZrSlJHUlVtTW9hSFRTQzk2T1pJY2p0b0FZREdmbGxWaGxnYUIrWHd5?=
 =?utf-8?B?Y0lmckZTb0RsOVlZS09mYkFYM0Y1SzRxYTNST3pKaUxaZGtOZGplaFViRmY5?=
 =?utf-8?B?NUNtVVlFcmdnM2dGTjhncE9nUUFDT2ZQejJHMkN2QnlJTFBLYjJvTG9EVmRW?=
 =?utf-8?B?RUdwV3hXdXNCVU04dGMvVFgwRkdwVk5zZnpjM2NxV3gvMG1oazZWNnh5VmM5?=
 =?utf-8?B?dUpNK2o4bDJ5NkFzUFlEaUFRdmNYSTlITlArb2NMZ3BVYW9qVjVqRFRydGFK?=
 =?utf-8?B?elJtaEZXcys4cDQzcnlkRE9iMUhHc2Rndm1HYXJickNUa0oxSTZINUdURXJr?=
 =?utf-8?B?RVdOcjVJcVNUWlg2dldNeG91M1duU0R1NVY3SjV0RnpSSGNNVkFqVDc1d2Zp?=
 =?utf-8?B?UVpQK21QWWM5dzJhNnlUVklOR1N4UElrOTFXd1B6UWFOeThwbnk3eG5QbFBn?=
 =?utf-8?B?Snd6VHc5UXlWMEQ4c1ROakgzT1FabGNKaEFrNkdjclBUQ09KTkZycHg5Mjda?=
 =?utf-8?B?NjUrNzhnNHA5RkQxY2ppNTFQdjJ5WTg4cnRzVFBFcG1CRUllYnl5VFJCbnh4?=
 =?utf-8?B?akdPWUoxek9VMFRPSTVpNEZjME54RVVJNkFmZXZFbTBKNVhTQmFwWHMxV1hX?=
 =?utf-8?B?cUZsc1ZiVGoyeWFmdXF2bTRaWXdiNGV6UlVhWSt0WXVhblhlNytVYjBQSVlo?=
 =?utf-8?B?UExPM0ljU0prd3p1N3Y1VGpFV1pURTA4Skh0c3E2UnovUHkzV2RJYUZJVG5V?=
 =?utf-8?B?a2MrMjhHekljZHBZdUdlQ2ZIcE5ZUkFHRDhyWmpwSFYwUWgyb1F3SXM1dmlH?=
 =?utf-8?B?RFZ1MHJiYmhXQ1orTWRmU0JRTSs2alNSdDB2U3FGY25iejVHc3M2VG9TV3lT?=
 =?utf-8?B?aGVOZjVWUVpIRTNRZTRQam8xeFIramh1TlVnc0Y4SmVmT3pwTG1VRng0cHdO?=
 =?utf-8?B?SVJJNklETlB5NjNEcmZlb2RpTmpsb045bGJQd1MwQWMrZUI3YmRzejFhOW9R?=
 =?utf-8?B?S1ExYjVTbU05VEoySUJsOUVqNHUrbVZ0OWNWRVBGZ0FmNDJLdzVVQXNYdFpo?=
 =?utf-8?B?UnRucDcrTTNMRm9rNG5sTXdzZjkrQmFwQzh5MkUwZWxmUERMMnlRKzhHdWdC?=
 =?utf-8?B?WXJQWk50eFZETGpmbnYyTGU2ZklndG1MbE14empXd2lhZXhZeGZwYzBKb3dm?=
 =?utf-8?B?U0YwNUh0UUZ3N2pJa0xpRVdtRVpIYlI2K0hLaGhVMVFGK0J6bHlEdVpBditG?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EECH+nl9gdIgq0UiRIgyeEBCTpCXE7uDA+XFgBW9DynbyNy0/kaQtQ2EDmcgQM8EoDQXIxs3/xQK9u1XvZ8UaR6DR11OvX7e18YbEYACjJIrxA/PsgV8WhlJLFh0PtlJI5bg5LTmwPMVmIkvqFfPRxEv9TWsToG3n2kNnTZDjoJ7qivtQ/Gnl440i0eWSS1EhnD3SqwT9xwTzk4IU+ROKVMXRHG4HKtJkjtE+BevJ7vDFCPjVeasoa8Tz5KAZDDfmF7Ho7YSfxiT7mNVPkMsj8XFlmx/JWwkfuy/h51BBNNIVJjtXssEQdbk+N57wipy6P+3zodRsYia9VVk2SsH9D3Z4WI84641KRi5jX7kiRdrRVT22l3KGN7n2AjkNu+Kq7wb3fgohwICUqyGcVa1vfSvxmlCQkEab9AdiQ2X+cVS/8UXBME7UiQ5TMqvt06L7tDr6z7t1pJrsEEmS3L6kNxzobm5hw2TvwEiQaQiVrR0UlkdGTGOP0eUPT0rSLgitk/3mOU33TJg1H3exhMH55OuECfqIUN4f+BVRrC+7Q9zGKe4pSJhxaDYuNfp5E1Wz87hA/5QabKjwpaNBpVYKtBiui0azVf3vTOJcQhu3HE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1ded10-c395-4461-f051-08ddb8b72e83
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:51:45.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgbrzCfIdTlzS4ul/xRl9t1S55MTugiZ491WwLGPvDvRnzS4H1c+PUm/1lBOUl3wmF4e4k8cPT/iug0eMVanIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4561E4FCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwNyBTYWx0ZWRfX6e2nXMdda4PD zZmk0cMU9P+uvfQcOXmGJHggzwND43PKuI//Rjh+BnzCUsh2lZ1lo0yfiNmIK6uUuu/wEqfZREW IN6DuMU2GvLB5Razz03W753xG4+PmO1hGDgAUKV/nkTfK2ImK6LesDhsnnoCmZorbJpYfxudQF8
 oMqAOYOfYhq9ak4xTWetH7LRJXfFNDdP4Ez9fSoRtsxENKFO4A98sQqBW1bM3FM5//V1MoGSv/5 GCjXk3/x9qbD94IIZL40FDyXlzbFpEDUh637Yp26QZ/1RheDgp/0CI5TY2mSY8WmSK9T8CxoQKg mDWi0d7Lny7i8z25GRUrMQae/3DO+KoG7/ZBQbG8ngogrFwzOdEQYq594OqqYBXXHBdtpvRmDh7
 Ottkuhjlf9k12Uahr+1mkbOEXq1lHfUDQEeDeCbOErsKwo/v8Yvnidt1Llvo45jNMjIHVyPJ
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68640416 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D-_FskwTaoP2A4LDqN0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: ND1aifJn3U-Oy4HjO8-CgliM0KVV9xVQ
X-Proofpoint-ORIG-GUID: ND1aifJn3U-Oy4HjO8-CgliM0KVV9xVQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_085159_958463_4D14FF4E 
X-CRM114-Status: GOOD (  13.26  )
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

On 6/30/25 9:21 AM, John Garry wrote:
> The command word members of struct nvme_common_command are __le32 type,
> so use helper le32_to_cpu() to read them properly.
>
> Fixes: 9f079dda1433 ("nvme: allow passthru cmd error logging")
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>



> ---
> build tested only
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7493e5aa984c..551595c18791 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -381,12 +381,12 @@ static void nvme_log_err_passthru(struct request *req)
>   		nr->status & NVME_SC_MASK,	/* Status Code */
>   		nr->status & NVME_STATUS_MORE ? "MORE " : "",
>   		nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
> -		nr->cmd->common.cdw10,
> -		nr->cmd->common.cdw11,
> -		nr->cmd->common.cdw12,
> -		nr->cmd->common.cdw13,
> -		nr->cmd->common.cdw14,
> -		nr->cmd->common.cdw15);
> +		le32_to_cpu(nr->cmd->common.cdw10),
> +		le32_to_cpu(nr->cmd->common.cdw11),
> +		le32_to_cpu(nr->cmd->common.cdw12),
> +		le32_to_cpu(nr->cmd->common.cdw13),
> +		le32_to_cpu(nr->cmd->common.cdw14),
> +		le32_to_cpu(nr->cmd->common.cdw15));
>   }
>   
>   enum nvme_disposition {

