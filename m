Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2215DC87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+7lZoz8Q/MYu55XFm+7lXKVgt4v9Mptm+ngNUOI88g=; b=j4GqGunXR8TAPiwOK6dzPqCply
	QhduRYZ8Cj8CjE2DCSzbawMIEyJgaYWui/OisVNsQeWdpvK4QcS5dBxeB6v4Eg8QgCrVBNrtyJCRJ
	/RKA/jCuWr7aJFhMDlHg2RqEKa1FQVDpijKLHkcTwdTwzkYrxOJ3BMJaXs71q0zJWeqwmRE2XDbG3
	tHkWMm6ZEzyRQFFHpG715pjEa1OXbHiaDKCx4rudKEGqv3mlq8yMuSgePH+c3RCmrEseprnMoH4Vo
	vr5+EdHAxf2cytPGHXmP3m7rEB0thIhuWoElPAwzshAYT8r39cOrg4IZEOJmNYOiitIMMtAqnJBsf
	lnWM2Rpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugli5-0000000Gx92-327U;
	Tue, 29 Jul 2025 14:53:45 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugli1-0000000Gx8b-3jYj
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 14:53:44 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDu6u4013598;
	Tue, 29 Jul 2025 14:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E+7lZoz8Q/MYu55XFm+7lXKVgt4v9Mptm+ngNUOI88g=; b=
	jN9VdPypxIcqg6mgGvAp+5IewDFCh0N7c/uFUZdZg0u6isG+8n6UMQhzfeKv3+Eb
	TWpsG+ck/JBkUuqOuZJJfk16U+GIqyD3am5KsUbLSgm5B2VIOGBeW2RNKPc1GMWH
	Qt4WNLOOBzED5cxa3QYhj4OSU++9aQTnzonZR0tfQVZQMFf4YO7YniD2uf663EYO
	XMsMlaryrrN9ODZ9TiPKGR2LOcBU3gtykq7EOgp2mtd3RqrARFnhpn81KXb90bgc
	i0kYchxgslJGUI6gEwPAlFCDyGADl2K0JgHd4kCJWLJtSk/f51eKgjKUVx8YJrDy
	ZE8q2r2F9eMSmvb83ucEuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wqr5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 14:53:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDXvmA034426;
	Tue, 29 Jul 2025 14:53:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfa8fb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 14:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+FkrDyRiTqv2r41tkU/NrRtlUcBwsFB1wwgITEmUJPwFmyMexurHc6Bq1+5ryi19bj76/AbnVo8obriDx4yI5uWc8DS9UxjeC+8BFkg+fxmycnnzO1t+Rx0Rr4EGZ5KdUn4aRkWMmGpG0dYnO7nc66xzGmMoJAv2O4xa+l3SBgW3NSgHj9hyFmpa0QrM/ZzmWkFMHN5mG5mgYTHf+WBoVyZ88HNkrLsbmGlbHSYr3iZVrtVlrML3YjPWcPDYJldkqGD9XHRnaYpjuA1TVgQuqRBVwoPUHpXLXfj/nsv1LzrQd/5lB3GUMtzoF/ehiv+s6Pqn0LLv7qFlaBdd3trIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+7lZoz8Q/MYu55XFm+7lXKVgt4v9Mptm+ngNUOI88g=;
 b=i20+1oOI7HgTaOJlNOsi1eiFAiyBcjMikRhQRgomPgNaFshpZpD5W9II0+mQTjIGQtSUndv3J/ovzlwpg1x/5OgWllXig4wACLgyqc44/zqJIYQDIZVVvoewPslJP2DU2F1qLn2/Bxydo+bulvOKXD1qCvgnnKBELcDLdQ3BUgG+YVOQVaFhdALhJPVo41S/exMaoVoEl1cVCmltuVDv7bMSW+tKKes3wD325nz4+NrXfuS9/IWJgqvcR1Bc9sQy/cT4wSkNgM/dUlH9m70/mFXqPEZENVWbzxlhPMKUW2v2lqDuk8u5dv4ihDs1bxtc8Ifl9EXh2uxAjQp1/PYJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+7lZoz8Q/MYu55XFm+7lXKVgt4v9Mptm+ngNUOI88g=;
 b=h4/LhMBYg2aw1Y/WyD6JG9vM33N1ZfsvOY9NjMrz8myaxRFEeMmtusIyVSAHvZq3+hwFIklRfo9JcW3P3OhToSww83028pPPaQmQIWBEe7eN1/ZHQDp+7zsAhjg0lNU1xegiZDZriHr1kD8Ss2Hf+ztQJ7op7ootYwhCb1gqqqE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5794.namprd10.prod.outlook.com (2603:10b6:510:f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 14:53:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 14:53:11 +0000
Message-ID: <ad394458-29ac-4302-8028-2276519a4122@oracle.com>
Date: Tue, 29 Jul 2025 09:53:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] nvme multipath eBPF path selector
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20250729070653.125258-1-hare@kernel.org>
 <20250729075401.GA23933@lst.de>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20250729075401.GA23933@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: dd61d147-504e-4bbb-ca37-08ddceafa344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlN2VkRZN1J6UTJpV3pnQndySFlvQmtoNEpaR05RR1hGWUhiYUlWOHhMRitw?=
 =?utf-8?B?em41dmlYRkZuTUNibFRhRXJ1TGx0WWJZT3BwRkRDVUhmOUxkamZlWkdZdVpt?=
 =?utf-8?B?SFZYVDdLL3BtNWtqOU4xRVJtazNyRm1qNGxlTmxkSlJOTkRMamkyRUxvbWY4?=
 =?utf-8?B?c1NRZjFUUmhHeUhTNy9kclQ0YUUvb3c1V0F4QUpaam1OZENvalEyeDlpRzNY?=
 =?utf-8?B?L1lGVWV2YzhCaE1Nd29qZHhIbzRaMGRyVHhBTnpqSkcyMG1Ddmpjd21HTDJM?=
 =?utf-8?B?YTZhY01nTUVZRWV3QnRJMUw5YkZjdURPUHhzVUNOVmxpUDVIcDhqanZkN1dF?=
 =?utf-8?B?ZUJGR0VldWR3c2JsVWlMcTZubUJvdFJYSVVyTDZWYmR3d20vSVByd1FvenBx?=
 =?utf-8?B?REpnVWNXdnlXaG9Bekd1cVJud01pYStVZWJnejRXVERydkg5K3Q0TU9WWUFO?=
 =?utf-8?B?S09mOFlTUi9YQzBpZkhTU0w0VjdXLzlaY2NNSmQ0eTNKaHVVQnU5U2FYa2RH?=
 =?utf-8?B?dzg0b0pYL3R1bzNwaUI0dVlORVphNUtFUUk5TnlzOWdNbzduK2FLZXU0L09K?=
 =?utf-8?B?dGdyQTJwclp3UUJCdDU0RzdhR3RxOU1tZ1BIZTFvOTNWRjJ3eW1nZUdjQk5y?=
 =?utf-8?B?QStOeGVUZ1BsWGlUVU9qbDA5YW16M3JFVG5PcWw1MXVwRkkrUmcrcmNXZGNW?=
 =?utf-8?B?ZXhmWnVoUWNhM3ZOM2Urd1NVKy9hdCtjbEpOTTR4a21BL01IaTZ2ZlhscERC?=
 =?utf-8?B?SCtUVEdLVmNCREU2OUlYRXlPSWxZRjFpUW1pK1h1dXBIMkwvL0VUeFhFMWVu?=
 =?utf-8?B?ZlpiKzBKWlNrWTlkUHhadXFYcGNEQjRVaFlvbS92Qk0vK3ZVM25Xc3Q1eDJu?=
 =?utf-8?B?OExKdElDbVdkWjhhUnRwMXB3UFl3UmtJbmpjSVdSc3JRTkxYL1hmY2ovNFoz?=
 =?utf-8?B?c2NvU2FyVjNEbXNXWE9BL3psVDJwaWhBTTMveUlSWWdVSkJseDRyRzF0TDVZ?=
 =?utf-8?B?Z2ViLzN1ZzZLNU1WbzdkMk9lcE9pNm5DUGxNZWs4cFkxTEVSL3Q3OWFLWCtP?=
 =?utf-8?B?ZVl0S0xOVzdnQXBuNnIrbEVabTdtM0VNbFRsUE9iK3k1TjFsVXJKQ215dDZL?=
 =?utf-8?B?VWk1RGd5bUVLNUdhV0dEM0VGUE9sTGNqQW0yNTNOMlk1aURwaTAvNWhkNHhB?=
 =?utf-8?B?VG5XVFFsYUpndXBtanQ1d0RBZGVOeWd1VlRoZnhDZmlCelFVclFKMGcwcHNF?=
 =?utf-8?B?NnlJOHgzRlZqb3BscTVIaEhJc0xJSGpFSGdKSzNGM1F4TEFmcWVLb2E3cktn?=
 =?utf-8?B?WlpjSVpZSlBrUUtiMG9ISjFvVWVqWThxSG9lZEIrSUYzMlFoVmpuYjdIZmZF?=
 =?utf-8?B?dWpRbUszVG1TdldNNS95MCtFM1ZpUEplWEJvVXFGamZiZDZsbnl0QU1ZQzAy?=
 =?utf-8?B?N2hvdG1FYnpHNkFmLzlFWW1Qb3hRQ2pKQ3JIN0ovUy8wc2ZMTnFuN282dndn?=
 =?utf-8?B?QnlEdWpKTEVmSG1FUjVDZy9talFKemkxaGVqa0k3cFNJWWdWdGMyS1ZFV0xq?=
 =?utf-8?B?dm9vWHZNckd3QjFtR0xYOExtelJGTDhEaHBUaTVPS1RTcDRvNnNZajBvYXpE?=
 =?utf-8?B?dXNIZW9KbkhmcHdRaEFUcXZ5ZnZJYlBPOGZrdkR2WUlsR1dhNVlYVHFqMVRE?=
 =?utf-8?B?VlorVmdHL3hqYUhmeWNWWHEzblJnOVFaZVNNZGdZQWRWcEcvRWlwM2dTN0hQ?=
 =?utf-8?B?TTIyTkVnUE8wYVNMeko0NWR4b1p0RFF1OGExTlhST2F3bEdDc1M4eGd1Vk83?=
 =?utf-8?B?dnFhSjl6Q1hIaXpVdjlVOXl5czlBM09kQ3JxYzlYdTRzRFo1Q3JWYk1VaTRp?=
 =?utf-8?B?allWZjl4NklKOWZTbUo5Z3QwcFlPcFMrVnVtNTJiZ09RbkhPL2djUkg2Uk5Q?=
 =?utf-8?Q?YbOvrk1ykg0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NkZkw1R2g1VExJcXk2Yit6SDdjTzVualR4TWFiRDQ0amxpNG5RcVZOM3Zi?=
 =?utf-8?B?Q2FNMHZHaFV5UXNFMTBpQmhUcytVb3l3cS85M3dGaUJaa1pBdXFpTEx5eW9T?=
 =?utf-8?B?OTJ4eWtEZjUxRStIbE1saHFmQkhxUllPNG10dW5QL3BzVk1vZHh2a2pEWVBV?=
 =?utf-8?B?V2lRN0NPU3JpQnhuNkdXRlVlTkIzbHFpMWMzeE9xbUxGK0tiMDYyVWViYjhn?=
 =?utf-8?B?ejBOZzc3d0phZEg0VUJEajVFQi92Z3gwc0Z4TGxDaW9ncDhzZ29YcXJIVEgx?=
 =?utf-8?B?Zm5MOGlBb2hRWlFiM2VJdE9KR1oxOCtFUUdyK3A2dGhZTXdBeGJ0NUQyZXJw?=
 =?utf-8?B?ZXpqNFVvVDFCczJkRkEzY1ZiV2VjUjM3Sm1kOXdxb2xON0NQNXl2UXZNcUNU?=
 =?utf-8?B?YU02SzZ6eUU4NERnL0NyTWErcXcxVEE1OGpoUG9xRmxxLzhQbktMeDY0ZkRY?=
 =?utf-8?B?L2ZKUGFsVUZMK0E2NlpZWG1Ya0JZNEdUeW9BWEk0NmlFelJOSG5Kc3NSYWxy?=
 =?utf-8?B?YnFDZEVaQ0ZFMnIzcCs3UmsvOW43aHR3bVMzWG9leTMyVm0wVlBFQzIySnYv?=
 =?utf-8?B?eFN0R0dTVjc4YkhvbitmdkxFQVh6V3hXVlpqSGRrM0JXb0ZWMU5Wdi81Rk0z?=
 =?utf-8?B?QTgxSStWVmFkcUU4VWZ3RlArWVl6bWU1RUFHVEdWNUU3ckppeHlkaHNEWnJC?=
 =?utf-8?B?RWUzbVdmamlYNEF3cFhQbUcveFV2NC8vOS9rdk9QU01xdmlvTkdsT1NQa0Vl?=
 =?utf-8?B?NVVSQXFxNGxsMEFoeU9hUHVEaDJwdmYyUjVKUS82TDBjQ0p0TGtxQWRqbGlq?=
 =?utf-8?B?NDhxYlJpN1FHMW1lblA3T204cGhTUmhqNEVGNnRaYzFWUXF4czdpaVBBc0V4?=
 =?utf-8?B?ZGpiUEFLWmpFbkVyb3U4Q09RTy9OUkZNTFhVZGFzVW0weTl6akRUckpwaDVj?=
 =?utf-8?B?MXFZcXRFTUpKSWVkUHVMTjExSDFvWlRZWFFyNC9tTU1tWDd2UThUeldSNEFO?=
 =?utf-8?B?VU5pN2ZvZGhFZFBZSWJXWU8vM2trbTJnb3l6MklQa1BnZlNOSDNHdmRkblZt?=
 =?utf-8?B?Z0NaMU0wVHMzWUxxaHBzeWUvV0ExYXM1VkJvY1lOTlN2NWtsQ0xQOHRyVWMx?=
 =?utf-8?B?TDMzZUh4ZkN0TGJkakYydDZRZjZXTk4rTlhuRlpkQ3pZODJuTXdkUlJOZFBJ?=
 =?utf-8?B?bll2bGNrWmVYU1E3OXhydERNS1ZVMlB3Rk1TbXR0SmxKZUNJUVBUZ2RnVmEy?=
 =?utf-8?B?L1Y3USttYVdtQ1BIQ3kxZHhWMlZyZDh2VVAwcmxwTEdTS2ZGTXJGNWNFTXRO?=
 =?utf-8?B?SU5tMGhkVDdXdWlVT3BCcWdmM1k5WlFwZ1l0d1pjQWJvUGowb04zZVRYSVdj?=
 =?utf-8?B?L2s0VWxZa2MySUh3TEtPeFg3dVZoa3VVUmF0czZTdG5VNWtRM0Zic0orUGZ5?=
 =?utf-8?B?TlRPaXJBZ2dQdzJvUUwrK2V5MStpS2pSdmV5Yk9YYVl0UHhpN2lCRW5wYUEx?=
 =?utf-8?B?Nk9zQk1qODczTklWelVvWm1JeitvTmRKUDI0L2g0OVZTQ3NpZUtqakt4NjRt?=
 =?utf-8?B?R3F5Wm9EYUlvK09FK3QrZGUvWS9BOHNoa1pvU2NiSWdlOWNBTW9HU21LR0Q2?=
 =?utf-8?B?NEdlaHVpUlR4OGhGcVA2OHJnQ0ZQdHY5ZXdQeHkwTHRwR2lDWElsUHBSa2JZ?=
 =?utf-8?B?UlhSZkZDakdoZlIwcXp0YXJLTWlTZ05WeDFOdkFocnhtZCs0aXZoWEYySmU2?=
 =?utf-8?B?aU9aL1VHZVdBc2N0ME5TVGxLRWlTOWJ1MnpiTm9nMEhGaU9RQngyaS9VSis0?=
 =?utf-8?B?VWdHSVdab25nUXFnRzlOZWdQeUIvb0dLVW9LLzJFRXp6YzFlbS9xQWlPVHlX?=
 =?utf-8?B?clZ4SStwQ216MEpSNm44YS9lMVFMZUo3bExVWEJFVHdseS9yV1FhOFU1OTZW?=
 =?utf-8?B?U1NncDBmajRQUG0xSXc5Vmc0SUc1dGUxeW1ac3JuQndFYkxYeTRxMk9mcEJp?=
 =?utf-8?B?MW00OG5kbzlXYXAwUk1pT3p4Vnp3amJvRUFOd1pMRjFyeXNJOU5LZTFUN2x6?=
 =?utf-8?B?VkNpOCtsWW00OWtIeEdUMklCb0gwZVlzTXQyeDkzNU8zY2ZXalVva0dnY1ls?=
 =?utf-8?B?bDRhZ2t0cEFPeDgxR25mczIxTkFQV3FuYXdvRHB5UGJYeVRrTzZWR09zSkpI?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bPwkL/pF3FgVsT3y7ERl/1oJL+ui5yQYqUducEL9UWuQ9NCgPNv5dzL36QDX+Lbxm8QvUemAKk6G7Sql716Uxus3fp/mNCsvfGSZgPQB6ZFk6i6UvInCl4donKtVFzIq/NstiT2UppA1s1BvJbsQ2EpkAkvKbc8gqIE4lgrQjOrPz2wPqpLsaUfvCtCN/DEYjkuelgXyz256HROM1zQ7tiaV7Ny7tv7bCFxHutBYOCgkZVMGdV9OmOADccs8ypORbdLVEaFrZY9DZ/vGfoRisqbF8Rg6MaWIrx1m2lqxYVdnkEdl8Wv1bOg1v6GZ20Rd5wYNziNnQxw+v3a7dUFCCEKBvAXEXaz4IaJsdqY+KuhgRsrKZs+Fc0jPTh5dIYZXHuvKAuu1nlOQbprSXw5Lsc2I4OSI2OMzCMW/eh9kTXIrzoFW7wtzTNh8jPo0NsAIjtPIk09N0t32X49ToFj0vdOBfAOFKTIhspsC78dHAedYopX2c8xxKmtL/8RpH3B+l3V9oI5R935GuQLaB5Hiua5i66lOsEs3wS3NCdfn/zD206sMrrJOB5RxFCnaceRK8/Y5zkt5Dzd3LO5ZEG5LtNKRI33E9cTRVZnw52nbZE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd61d147-504e-4bbb-ca37-08ddceafa344
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:53:11.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcEXD5MUUdPAg/0GM5fkh/xSfZSq8DwbSqZzoN/yPDKThWBMvTYHy2QYhmxjEIHz8fpI/tff/yeLEKQs6OvR0UIPQhZ/4taFcB3s04txrY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290114
X-Proofpoint-ORIG-GUID: GfmwqZGrLdJVkjVbcdmVImwSNYnbFpuD
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=6888e066 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hNOTfydlAAAA:8 a=VwQbUJbxAAAA:8
 a=PFm1BbBY-z-V_Ks0SX0A:9 a=QEXdDO2ut3YA:10 a=fZunMKNLB757I4m4HZ3M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNCBTYWx0ZWRfXyuJmb9F7LEX/
 Wd4mMf++mp/Y9smv03bRWeUgHTuzS0pemsu/QAyNyZd7w1nZ7DEfQXGaeA4ijF8i5o1q1L7o0CL
 KGJMJHqrh5YI5jfE3iOf81Rvq7veywYHOGg1PdqfKoQwaq68B2OfMDoygBHeWmzz38pmsU6tfbS
 m2GR+GObPWzg2bXzkF93ido6iaIIsxgA+P0Ny/Vc9fIcL7Vnvc5FIAkf3sBV+r8EnKY+NGGnvgh
 QzsSfuC5UTRsQq4uAIzo1CBsld0nZcNkkJvJMaUVeQDu0aYMtDeDJGdgagAihF5Ittg67J4ND/q
 +XAMXUWA6BVVd7+p2/qY4yum2dymm+jMe2CZZmnYC11xkzRGwF5ufWl88a5SrWUh+LMuNwDkqIV
 lApIHhyIVWeAWHeDVCo9Wx9pcq8MbstsIIhNP8Fo4HgSqZm3WGMQyUxpWbm7qatPRhTLmh3h
X-Proofpoint-GUID: GfmwqZGrLdJVkjVbcdmVImwSNYnbFpuD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_075342_346195_BA8E26AA 
X-CRM114-Status: GOOD (  16.12  )
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

On 7/29/25 2:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 29, 2025 at 09:06:47AM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Hi all,
>>
>> there are discussion on having to deploy more complex I/O scheduling
>> algorithms for NVMe,
> 
> Are "we"?  Where?

I think that's me. I was originally looking into eBPF path selectors
for ADNN:

https://www.snia.org/educational-library/adaptive-distributed-nvme-namespaces-2020

I was bugging Hannes about what happened to the spec. The idea was
just that if the spec is dead, then something like eBPF path selectors
could be an option.

I'm not currently looking at it, because I got busy with other
work. But, maybe the ceph people would want it for their nvme frontend
like in the video. For the ceph iscsi project, I had looked at SCSI
referrals, and it didn't fit (I can't remember the details), and ADNN
looked promising.


> 
>> but then there's the question whether we really
>> want to carry these in the kernel.
> 
> If it makes sense, "we" do, yes.
> 
> "We" don't want to export random crap for sure.
> 
> 


