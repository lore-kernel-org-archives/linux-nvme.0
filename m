Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E1CC02194
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2025 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0G9dDStVZhX1Z4X2KoBuJE/A0PXaBmUcOCwNE1rTd4=; b=no0aPyDHTFRw4ABxgKJ0bypCyT
	u9bc+RggCW1NewTsBC7PvmRJ9/yUn9yJ8Mq5jX2xyum3rco5hq113YB4osZN9NMxOBKA/Vr6Ijp1f
	IFQDtrhLkTvWo8AJJcFqdv2kCXXdhNOfgfwmo2X1B1fc7vbA+Wyd389cvkIV6MhY1RGEQQKcnzMRy
	Om79mJybHtnnyuMxB0SvuN+r5zpfZEkWctn4MVKftOXZ/g2k5AYaV/F7GlozAxrakach0K4YMatkE
	b4SdfoeufgOtV3Gki0/TH8bks7a+wSfMz6+2LlL3Kuoixc3Y8GSDFlTh9BPyNKxhEhvJuO+T7zPNB
	O4EpwzHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg5BR-00000006uxO-1LAh;
	Thu, 06 Feb 2025 16:56:57 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg5BO-00000006uwn-189v
	for linux-nvme@lists.infradead.org;
	Thu, 06 Feb 2025 16:56:56 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516CxLQP021987;
	Thu, 6 Feb 2025 11:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=k
	0G9dDStVZhX1Z4X2KoBuJE/A0PXaBmUcOCwNE1rTd4=; b=e+GaI2t/FRzNYC0mU
	BH8jishDQD6MbnofEncNbh2eWvhGTIJq5veuFM9QdXE81u6h4IUmi1L8VgbuPKb/
	H0uKskE+FUkM44MhrGRrsbvAYO5UthneyLQC1hWGSsudpLDTQOn4Tt8zg3MwpcSy
	yP9BhgLdPqJJ6yi7WPCl7MHJjKuyKVrD1vcvxG0SSwyMhjuDmKiLXYVTQDCZlWlh
	OX88nuMEyWhBsWXGG7mk/iouqISMqAacBrq219mQnbUpyInkMTBXLzWvXxiZBE5A
	3HK8ePgTkuCSZ1yCAMvhghR52q3G4wfbJaEceDXxFQECqw7/us0HGrnz0ELc/p94
	BN1/g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 44hgb1x8y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 11:56:46 -0500 (EST)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516GO2FP030009;
	Thu, 6 Feb 2025 11:56:45 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 44n0jqgddb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 11:56:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2oSku0PgFQAj0TWwXGc/sgnn7FzH42M/UMXdA2lzzzuzYlv0bPJw/SZjD8+lG3vfHqs1lt8czdAtA0VzJt5Pwd/1iN3NgCTwY67KtR8k2sjBFq33PLEiqH05eJnB+ZrHHwYhOZ/rURs30I455vaF1Nxf7iGDsxFohCEphmIJHRYDTDPhR6HWjSVUrysf3CQbL3sZt5QQWcui+4odlLn+ujK5MS152L+IIpCPvR9uyYusuRYQ2m3niJPsG/qsNI2M5C8EPCm4x+dIKkBbWLDBAkxQWLsnEyvTvj0/JhB+ehIVpH+8/cl2HmHewAiWkrtaM7Gp1pA0jZ2X6AH4SfkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0G9dDStVZhX1Z4X2KoBuJE/A0PXaBmUcOCwNE1rTd4=;
 b=H2TbKiffTrCEmpf43twU3u9lC4YMcmGsWFD51aupPfHZkb1Pjvum1fQtY9VO2SnW+a3fhkFZlQ5hJEkc4ZGTfh/gOcWH3hhV2rhkt5+eC9gxfR53TKRmEOe5gCBNeMyDOw2G6aSM8q0Qw3UNKx2kCAqY3Jq76KUMRGhh4qL7CE+AxkekriT/C4Li8z/0k2RyGex0e3fxJhcaMDfQQHIHL3j1KX3GX3sdKICXLACjk9IgxsUW447xe+ZguvxGNJAT29PrG0COzkLtHiuMmFwPtXf/0BJSvAhUw0eDtzq7Ea8LAg++3ildYZfcrpT5b3UNk9GPWXUZQ41p4PmsxNkPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SA1PR19MB4893.namprd19.prod.outlook.com (2603:10b6:806:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 16:56:41 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82%3]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 16:56:41 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: John Meneghini <jmeneghi@redhat.com>, Jiewei Ke <kejiewei.cn@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Daniel
 Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: RE: [nvme_tcp] possible data corruption when host detected path error
 and resubmit IOs on another path
Thread-Topic: [nvme_tcp] possible data corruption when host detected path
 error and resubmit IOs on another path
Thread-Index: AQHbWyyDWqIS1B3hZkCQyHzi1+nTjbM6rbaAgAAK2QA=
Date: Thu, 6 Feb 2025 16:56:41 +0000
Message-ID: <CO1PR19MB4885DD288E25D2F763B24095EEF62@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com>
 <3184caaa-7254-494a-948e-4a3aefd05f4f@redhat.com>
In-Reply-To: <3184caaa-7254-494a-948e-4a3aefd05f4f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=726e4721-9a83-4385-aca6-cc8cd6cce0b0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2025-02-06T16:56:25Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SA1PR19MB4893:EE_
x-ms-office365-filtering-correlation-id: e7502039-83c2-4b92-0057-08dd46cf3af2
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEpNd2s2WU9RZFRiSS8vc2NHUjEvSC9HUDRoZUZrNnh0bExmWXA4dTIzdXJE?=
 =?utf-8?B?K01IeG9KanBTMGs5SlZKVmxZTWVqVUU4OTVtN2xnSGpBUFExZXFEZ0dSZ1BC?=
 =?utf-8?B?Ym1EcFZkbmo1TmFLazJuNEg2WU45bUVsaEYwdzgrOENlRndxUk04WE9XZ2xU?=
 =?utf-8?B?L21OelBEazBWN0VKL2NUZDVadWpiRWw4MUNSUXlNbTNzQ0NaNTd0aGVPdUM2?=
 =?utf-8?B?TzR6c2IxclFMYTZ5UVJHTHZoTTg0WlR4RE5rZTllVFJBVmFWdVJna1ZYS2Nt?=
 =?utf-8?B?aU1jQ241ek5FL1FLbW1ZemJsYk14dzdteWdqY0RSNGFScDRqU2xEOXp5QmNG?=
 =?utf-8?B?anJPdFdtRUlVSGNmdGN0cW8xbU0wVTlWSFNTT21MazZBcUpCZVRxZktDNkxX?=
 =?utf-8?B?aG4zQmtVNm1LU3BMZDBkL1dUbW1YY3M5WVV0L1NURjlvamZEWktHeTRUS2hs?=
 =?utf-8?B?K2ZXY3NpdUYvZlV5dkpEVjE2dERGMzZETjZjWHBPWDIzczFndmc1MnJ3QjVJ?=
 =?utf-8?B?dm5kV0J0VlpncE8rWGx6RXhsc0xkdUo2ZDlMV1FZU09RbnJLeXYxOG9Cek5L?=
 =?utf-8?B?VzhQR1JVVTZORDdxUnBmNVpNdkxNem8rMDd1ZVRJNDMycS83QTZTcldyM1BS?=
 =?utf-8?B?ZzdlcWZ4cGVRZExabit5a0xRTVEwV3ptNFpRWTZPZnhYa1ZKZG1qRzhyb1hK?=
 =?utf-8?B?d2Q5TGVRbHhjcGdrd09GTTcxZUhYNWRkeUJtQ3dhdHUvd2FEYjdKeW5rSlp2?=
 =?utf-8?B?ZUZQQTVIRmFQUjlNSlk0TEVCSDljTlpxQW4veDgrbVZiYmxMRzEyajdBeDFk?=
 =?utf-8?B?RU55d3Y1L3luWGg4YU5GQUVvRGtZYllFRFh5U244czE4UWI1eTExRm1wUmVV?=
 =?utf-8?B?OS9LN3NMZ0FpY0VtdXpXbktGYnN3dVZuV3Q3TmdDa0xaNktVSmtOVDFyNlNt?=
 =?utf-8?B?ZDBDaG1WcU5ZOWZwTlpFYUtmb2ZQSVJWN3pIQlpQdS82OENNTzJxTldxc09Z?=
 =?utf-8?B?b0lpMEhrSkVNWnpJMCt2bTRpSDJGZ3ZNZXY2YjdzZWNydlpvVjZvb3NlWXUr?=
 =?utf-8?B?Z2hiNmJOZWhwME5DbWlLMzF4UFBTam82dk5ib1hjM2lUYVdvZDRwcjU4L1hL?=
 =?utf-8?B?UU9QcUtaejAwRk9SN3ZqN1pMd0R1WHB2djlySHJQMk9WTWlLcWxLR0IwU2RZ?=
 =?utf-8?B?TmRHdThRTTVlM3NnZk85THRqMCtCNG1rRUhXR29WVGRNSjBOU0hyWFVoRTFQ?=
 =?utf-8?B?cklFTHVzV1dvbjBiajZoSVdPeFB3VytkOFhLVEFySHhEVktVYkZTM0VrbDdw?=
 =?utf-8?B?YnIydFpVZkdvWkt3NFF5TEhONXRCUHVUWWVZNkIyU21rcTZ2ajBQaVY2YnNn?=
 =?utf-8?B?MG1kK3VkMUZjcjZaNWVEeFZITGkzSFZIWVRpR1pDVXVWQWdON1hXcjMxMFd2?=
 =?utf-8?B?WUpOTXE3Tjg3N2lkcVgrVDlLNnNGUVNDdlhjOElPV243STlFVU5kNjdTVGIy?=
 =?utf-8?B?azN2QUx6QWY1cHExNnMrOFViSWlMWkxONzhlbUVnYVdZN3Y1OWpPR2xHaTBy?=
 =?utf-8?B?QVFRc0F6ZzNobjN4TTBLWWpzaUtUbTJBZGNWNVBFRFhqZ2dPYXV5b2NWczh3?=
 =?utf-8?B?cjN6SFg0N01HcFZUWHNWWGF4bGJiekJibkVvaWF3RXVTcVBxMHVRbFo3TUg3?=
 =?utf-8?B?VE02WFIzMGZrYXFsM21KeWx3STJsa0hqVDBWWlVkYUZVcXdRM05LN0pVQzI5?=
 =?utf-8?B?bFBvS25ZOGtLSHBGeUZyb0hhbUE3ZzkwZ1JLUmRDN015bldZSEpHYTF3Ulky?=
 =?utf-8?B?MGdPUlJTWDJvMnBhbVJOYUVTanRkaURlVlVya0pUK0xUZmRZSTQ0OHNQWXhX?=
 =?utf-8?B?T0hkTDlDQzVpOVhoN01XcjFnZHZnLzB2alZnUXBjK2FIRjF0TWNpYW9uejIy?=
 =?utf-8?Q?zTDaLpw4Pw4jb0KWTlFQyNAsZe9kM7AR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmNpemlwbldINlZ3U2xjQ2wrZ0dIRTc3di9aK01mMmEreEZZNUEzZndnMjVn?=
 =?utf-8?B?emdjWmpBTUJaQ1Fyb1FPVUVQeERrSjBaVnhzdFhjZlh3SUdHNkxGak1RQ0dS?=
 =?utf-8?B?alBwczJxelhUNUcxeWdlY3lERmw3aFptWTlmUXJOOEVxdmIzMEFVSlNQS244?=
 =?utf-8?B?dlFjbE45UWF6M0RQK2lwTXcyTE1OcnhoSXJoZWduenlQYWg2dlR1c3VaL1d0?=
 =?utf-8?B?bDZucDhJYWJtRWpMWUl0ZmRVWlRKeDloR0prWkZxbksrVHZPK0pwLytVSHM1?=
 =?utf-8?B?a08yeG9HWEFwQnUxNkFncy90TWZJMGFJVC8wU2dadXJNTWU5Q3VXZEJSTmJJ?=
 =?utf-8?B?UUxRYkFzdndLQVdZbEZHQktFRzlFYkxZVHpGdGZpMGJVZks0akdIUXdpR3oy?=
 =?utf-8?B?T1IwaEZBL0F6SERiQmM0VU9vU0E3SEtpK1lnTjczQ2RVMXdKNWxtaGR2QWUr?=
 =?utf-8?B?S1gvZDVtUGExU0MyUnZXenVra0JhN0xlWTJMdnZxNFEzMFI1SVhEUmtNVFdY?=
 =?utf-8?B?Y1JHaHJrVCtEWjVyWHFONis3UE1wSU5VaE5IbWc5R1lMbHF2ckd6ZmRCWU1F?=
 =?utf-8?B?bGlxbzRtQmw1Q1NjeDV0UVdiM2lKUEtSeEI4YkJpbXYrREQyS3gyMkhOTmJi?=
 =?utf-8?B?Q3RLb0lvYzVLdmYydDBLL05sM0pKMkdrSmhKb0tHUUVZZHlKZU5YeUJldWIz?=
 =?utf-8?B?NndPVG9nMjhOdkllZWlPRVNTV3dtRE9QNEdUcUJOSmdpWi9DbFowc0c3QUFH?=
 =?utf-8?B?SG5MTGNianBibmJwK05zV0hkdXVHbXJpdzZOWnJLbjI5NGsxbTBEa1Z1U0FR?=
 =?utf-8?B?WVRrTkZ6ZWdybCtzRUJoTGczcTJVa1RSa1E5Ni9pWlk1VFc5eDJ4SzNoVnNh?=
 =?utf-8?B?TmZHOXYxZW1TWUJLNkJQTzdHaXAxSTl0ZzZnYzI2S2VHd3Y5SFRrV1JEc2RZ?=
 =?utf-8?B?S3cyUVNtaHArVVFNSVJhRjd2eUVQbTU5VTZmZ29kdHQyRVdWOENwbkZmM0Zx?=
 =?utf-8?B?QlgrK0h5cDhXc2l3T1dGVXVyWnhacFRMOHRVOXhSOWpMYmVEQW80TEdIZDJr?=
 =?utf-8?B?OThSaURvQXFnTEcyNzBxR3lJT2pVeTF6V2xQMzIyWE56UnhvamsrZW9MNEFG?=
 =?utf-8?B?V1RQQ2JjT1EvN1hJTTl6RmEvRUYrekJVcUkyUEhweE1HQ2tnRHZTUEM3K1dO?=
 =?utf-8?B?c3ZDU1JET3NHN3J5d25FaTFNckxZbjhlMVExYnBTcGhnWENJWEs4R2Mrczhs?=
 =?utf-8?B?UGRBOTVTT2pxaFQvOVE3V2RlT0tvN0h0MFdzRGtRMnQzL3pyRTYrRENZOG04?=
 =?utf-8?B?WHRMTmhUVWRXTU40TXpuSTZkWmFSQnZ4VkRjazlMalYxRU9qUERqS3ZEdHYv?=
 =?utf-8?B?QnpJSVlrdWtWejIvMXpEMmREdlErMjdLY1kycUx3Vm0vNEMzR1pOQmFOUmt4?=
 =?utf-8?B?NktubjFKRXFWZTJGdFczQVhVekRGd3FWQ2hJSTBpdG8xTTNCWURsZzJ6amJq?=
 =?utf-8?B?TTZQUUdyeVdGdk44eitkdUxLZ3hraFdxNHVPVkpvaTQvMVJkRjB1eWt3VzRr?=
 =?utf-8?B?UXBEcWFwOStnc0VqTFBkZE92bjBXczBDTFpud2V1MWI4MCtoMkNtOXBaSUlG?=
 =?utf-8?B?U3JHV2tyaE1OTmlIY1I0U3dFKzRmaVZoOHZXN3JLQ2x1L1FhL2hwU3NUTEFx?=
 =?utf-8?B?ZlQvZGVuSnp5UytHWS8yVkljd0oyUi9uZldEVlFvQ1U1Vkw4azh6TzdSbzF0?=
 =?utf-8?B?QzdDanZDcCtLR1pmSFZGd2VBMkNyRWM4N2FySVkzYUFqcy9jRVlqSFpucTZh?=
 =?utf-8?B?OVBCMnIyenNkQ0s1T3FpRXRJSWZBZ1JMM2tSeVVodEtlWDlHVTI1TjZ0a0l4?=
 =?utf-8?B?d0xieHYrdE1ST1lzWHNVdVhnMXVYWDRpRzlYbExXZ1VMbE1NSEJhUzR4aERt?=
 =?utf-8?B?OTUzUStVc2NqVlV5b3ZIa1FDcmFBZm85VDJ4eW5vU1k3SDhDMGc0T29FQTd2?=
 =?utf-8?B?U1ArM3Vtc0Q3TFhNTHcxOTI5S0YxMkpEQTRxM1JXTWVWNzE5c0VnMkdGK095?=
 =?utf-8?B?NEdlRlVTSGxRbGRoYS93NjFlKzBSbUZHMTRWbnFUY2pvaUtBVmtoZWNGY0Z1?=
 =?utf-8?Q?Op7PKqrCjgzFXuYx6McPs4S6X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7502039-83c2-4b92-0057-08dd46cf3af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 16:56:41.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtIfu78jLbyjtLNRf/mvUQ28673/pqu5OOSnLQLe8O/5Dfcda0EB4QlNgKWvShh5dJAzcseCY4MYeIYlbBbNZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060137
X-Proofpoint-GUID: 0JEfRaWqAEKj1iAwH4CZ23jn7gNJU0cB
X-Proofpoint-ORIG-GUID: 0JEfRaWqAEKj1iAwH4CZ23jn7gNJU0cB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_085654_444093_F7081ADF 
X-CRM114-Status: GOOD (  16.93  )
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

SGVsbG8sDQoNCldlIGFsc28gY29uc2lkZXIgYWRkaW5nIENRVCBzdXBwb3J0IHRvIG91ciBOVk1l
LVRDUCB0YXJnZXQgc29sdXRpb24gdG8gZGVhbCB3aXRoIHRoZSBiZWxvdyBwb3RlbnRpYWwgZGF0
YSBjb3JydXB0aW9uLg0KSSBjYW4gc2F5IHRoYXQgaXRzIE5PVCBvbmx5IGEgdGhlb3JldGljYWwg
aXNzdWUsIHdlIHdlcmUgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBkYXRhIGNvcnJ1cHRpb24uDQoN
CisxIGZvciBKaWV3ZWkncyBxdWVzdGlvbiAtLT4gIkFyZSB0aGVyZSBhbnkgcGxhbnMgdG8gYWRk
IENRVCBzdXBwb3J0IHRvIHRoZSBOVk1lIGhvc3QgZHJpdmVyPyINCg0KVGhhbmtzLA0KQW1pdCBF
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaW51eC1udm1lIDxsaW51eC1u
dm1lLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4gT24gQmVoYWxmIE9mIEpvaG4gTWVuZWdo
aW5pDQpTZW50OiBUaHVyc2RheSwgNiBGZWJydWFyeSAyMDI1IDE4OjEzDQpUbzogSmlld2VpIEtl
IDxrZWppZXdlaS5jbkBnbWFpbC5jb20+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcN
CkNjOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+OyBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+OyBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4NClN1YmplY3Q6IFJlOiBbbnZtZV90Y3BdIHBvc3NpYmxlIGRh
dGEgY29ycnVwdGlvbiB3aGVuIGhvc3QgZGV0ZWN0ZWQgcGF0aCBlcnJvciBhbmQgcmVzdWJtaXQg
SU9zIG9uIGFub3RoZXIgcGF0aA0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCkhpIEppZXdlaS4N
Cg0KVGhlcmUgaGF2ZSBiZWVuIGlzc3VlcyByZXBvcnRlZCBvbiB0aGlzIGxpc3RbMV0gd2VyZSBz
b21lIE5WTWUvVENQIGF0dGFjaGVkIHN0b3JhZ2UgYXJyYXlzIGFyZSBleHBlcmllbmNpbmcgZGF0
YSBjb3JydXB0aW9uIGR1cmluZyBlcnJvciBpbnNlcnRpb24gdGVzdGluZy4gVGhlc2UgZGF0YSBj
b3JydXB0aW9uIGlzc3VlcyBoYXZlIGJlZW4gYXR0cmlidXRlZCB0byBnaG9zdCB3cml0ZXMgaW4g
dGhlIHN0b3JhZ2UgYXJyYXkgZm9sbG93aW5nIGNvbW1hbmRzIHJlcGxheWVkIG9uIHRoZSBob3N0
IGR1cmluZyBLZWVwIEFsaXZlIFRpbWVvdXQgdGVzdGluZy4gVFA0MTI5IHdhcyBkZXZlbG9wZWQg
dG8gYWRkcmVzcyB0aG9zZSBpc3N1ZXMgYnkgaW50cm9kdWNpbmcgYSBDb21tYW5kIFF1aWVzY2Vu
Y2UgVGltZSAoQ1FUKSB0aW1lciB0byB0aGUgcHJvdG9jb2wuIFRQNDEyOSBpcyBub3cgYSBwYXJ0
IG9mIHRoZSBOVk1lIDIuMSBzcGVjaWZpY2F0aW9uLg0KDQpNeSBxdWVzdGlvbiBpczogZGlkIHlv
dSBmaW5kIHRoaXMgcHJvYmxlbSB0aHJvdWdoIHNvbWUga2luZCBvZiB0ZXN0aW5nIG9yIGlzIHRo
aXMgc29tZXRoaW5nIHlvdSd2ZSBzZWVuIGR1cmluZyBjb2RlIGluc3BlY3Rpb24/ICBBcmUgeW91
IHJlcG9ydGluZyB0aGlzIGJlY2F1c2UgeW91J3ZlIGV4cGVyaWVuY2VkIGRhdGEgY29ycnVwdGlv
biB3aXRoIHlvdXIgTlZNZS9UQ1AgY29udHJvbGxlcj8NCg0KSWYgeW91IGhhdmUgYSB0ZXN0IG9m
IHNvbWUga2luZCB0aGF0IGFsbG93cyBhbiBlYXN5IHJlcHJvZHVjdGlvbiBvZiB0aGlzIHByb2Js
ZW0gaXQgd291bGQgYmUgaGVscGZ1bC4NCg0KL0pvaG4NCg0KWzFdIGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzFjZWE3YTc1LTgz
OTctMTI2Yy04YTJlLThlMDg5NDgyMzdiMUBncmltYmVyZy5tZS9fXzshIUxwS0kha01zdEF5ZERo
OVZhMnk3cW1OYUZ6TVBrNWhnREZmaW91b3VmeUZxRnZBamJ1aFRXcFVGUWs4R1ZwMlF2V3NzYk5v
ZUVqaDhXLURVbXNkRmIkIFtsb3JlWy5da2VybmVsWy5db3JnXQ0KDQpPbiAxMi8zMC8yNCA5OjMy
IFBNLCBKaWV3ZWkgS2Ugd3JvdGU6DQo+IEhpIGV4cGVydHMsDQo+IA0KPiBXaGVuIHRoZSBOVk1l
IGhvc3QgZHJpdmVyIGRldGVjdHMgYSBjb21tYW5kIHRpbWVvdXQgKGVpdGhlciBhZG1pbiBvciAN
Cj4gSS9PIGNvbW1hbmQpLCBpdCB0cmlnZ2VycyBlcnJvciByZWNvdmVyeSBhbmQgYXR0ZW1wdHMg
dG8gcmVzdWJtaXQgdGhlIA0KPiBJL09zIG9uIGFub3RoZXIgcGF0aCwgcHJvdmlkZWQgdGhhdCBu
YXRpdmUgbXVsdGlwYXRoIGlzIGVuYWJsZWQuDQo+IA0KPiBUYWtpbmcgdGhlIG52bWVfdGNwIGRy
aXZlciBhcyBhbiBleGFtcGxlLCB0aGUgbnZtZV90Y3BfdGltZW91dCANCj4gZnVuY3Rpb24gaXMg
Y2FsbGVkIHdoZW4gYW55IGNvbW1hbmQgdGltZXMgb3V0Og0KPiANCj4gbnZtZV90Y3BfdGltZW91
dA0KPiAgICAtPiBudm1lX3RjcF9lcnJvcl9yZWNvdmVyeQ0KPiAgICAgIC0+IG52bWVfdGNwX2Vy
cm9yX3JlY292ZXJ5X3dvcmsNCj4gICAgICAgIC0+IG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVl
cw0KPiAgICAgICAgICAtPiBudm1lX2NhbmNlbF90YWdzZXQNCj4gDQo+IG52bWVfY2FuY2VsX3Rh
Z3NldCBjb21wbGV0ZXMgdGhlIGluZmxpZ2h0IHJlcXVlc3RzIG9uIHRoZSBmYWlsZWQgcGF0aCAN
Cj4gYW5kIHRoZW4gY2FsbHMgbnZtZV9mYWlsb3Zlcl9yZXEgdG8gcmVzdWJtaXQgdGhlbSBvbiBh
IGRpZmZlcmVudCBwYXRoLiANCj4gVGhlcmUgaXMgbm8gd2FpdCB0aW1lIGJlZm9yZSB0aGUgSS9P
IGlzIHJlc3VibWl0dGVkLiBUaGlzIG1lYW5zIHRoYXQgDQo+IHRoZSBjb250cm9sbGVyIG9uIHRo
ZSBvbGQgcGF0aCBtYXkgbm90IGhhdmUgZnVsbHkgY2xlYW5lZCB1cCB0aGUgDQo+IHBlbmRpbmcg
cmVxdWVzdHMsIHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gZGF0YSBjb3JydXB0aW9uIG9uIHRoZSBO
Vk1lIG5hbWVzcGFjZS4NCj4gDQo+IEZvciBleGFtcGxlLCBjb25zaWRlciB0aGUgZm9sbG93aW5n
IHNjZW5hcmlvOg0KPiANCj4gMS4gVGhlIGhvc3Qgc2VuZHMgSU8xIHRvIHBhdGgxLCBidXQgdGhl
biBlbmNvdW50ZXJzIGEgdGltZW91dCBmb3IgDQo+IGVpdGhlciBJTzEgb3IgYSBwcmV2aW91cyBJ
L08gcmVxdWVzdCAoZS5nLiwga2VlcC1hbGl2ZSBvciBJL08gDQo+IHRpbWVvdXQpLiBUaGlzIHRy
aWdnZXJzIGVycm9yIHJlY292ZXJ5LCBhbmQgSU8xIGlzIHJldHJpZWQgb24gcGF0aDIsIHdoaWNo
IHN1Y2NlZWRzLg0KPiANCj4gMi4gQWZ0ZXIgdGhhdCwgdGhlIGhvc3Qgc2VuZHMgSU8yIHdpdGgg
dGhlIHNhbWUgTEJBIHRvIHBhdGgyLCB3aGljaCANCj4gYWxzbyBzdWNjZWVkcy4NCj4gDQo+IDMu
IE1lYW53aGlsZSwgSU8xIG9uIHBhdGgxIGhhcyBub3QgYmVlbiBhYm9ydGVkIGFuZCBjb250aW51
ZXMgdG8gZXhlY3V0ZS4NCj4gDQo+IFVsdGltYXRlbHksIElPMiBnZXRzIG92ZXJ3cml0dGVuIGJ5
IHRoZSByZXNpZHVhbCBJTzEsIGxlYWRpbmcgdG8gDQo+IHBvdGVudGlhbCBkYXRhIGNvcnJ1cHRp
b24uDQo+IA0KPiBUaGlzIGlzc3VlIGNhbiBlYXNpbHkgYmUgcmVwcm9kdWNlZCBpbiBvdXIgZGlz
dHJpYnV0ZWQgc3RvcmFnZSBzeXN0ZW0uDQo+IA0KPiBJIG5vdGljZWQgdGhhdCB0aGUgTlZNZSBC
YXNlIFNwZWNpZmljYXRpb24gMi4xLCBzZWN0aW9uICI5LjYgDQo+IENvbW11bmljYXRpb24gTG9z
cyBIYW5kbGluZywiIHByb3ZpZGVzIGEgZ29vZCBkZXNjcmlwdGlvbiBvZiB0aGlzIA0KPiBzY2Vu
YXJpby4gSXQgaW50cm9kdWNlcyB0aGUgY29uY2VwdCBvZiBDb21tYW5kIFF1aWVzY2UgVGltZSAo
Q1FUKSwgDQo+IHdoaWNoIGFsbG93cyBmb3IgYSBjbGVhbnVwIHBlcmlvZCBmb3Igb3V0c3RhbmRp
bmcgY29tbWFuZHMgb24gdGhlIA0KPiBjb250cm9sbGVyLiBJbXBsZW1lbnRpbmcgQ1FUIGNvdWxk
IHBvdGVudGlhbGx5IHJlc29sdmUgdGhpcyBpc3N1ZS4NCj4gDQo+IEFyZSB0aGVyZSBhbnkgcGxh
bnMgdG8gYWRkIENRVCBzdXBwb3J0IHRvIHRoZSBOVk1lIGhvc3QgZHJpdmVyPyBJbiB0aGUgDQo+
IGFic2VuY2Ugb2YgdGhpcyBmZWF0dXJlLCBpcyB0aGVyZSBhbnkgcmVjb21tZW5kZWQgd29ya2Fy
b3VuZCBmb3IgdGhpcyBpc3N1ZT8NCj4gRm9yIGluc3RhbmNlLCBjb3VsZCB1c2luZyBEZXZpY2Ug
TWFwcGVyIGJlIGEgdmlhYmxlIHN1YnN0aXR1dGU/DQo+IA0KPiBUaGFuayB5b3UsDQo+IEppZXdl
aQ0KPiANCg0KDQo=

