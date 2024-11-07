Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18589D35E5D
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N5rzewcNd+Xw/E+v24M/voGqOjCVfFK1Nm+cMKSveys=; b=lLoOjvvax0ZJ3VW+Ayn3IG7pke
	JtlhyCdPWs9fUYfSvKIqE6SH6MGT0lPk6pryjmFUSrvMyb5ik73wrkMLO9z4/PWPYKwyQ5zb3+xVD
	Ixc4XmvseJiyu7CosXPD2NY8yKDv/3dCPWdf83wt4ac8n6mLvzIcHLmIRBmygVr+I7mMma6opVs7x
	/krCYCfdXnSIQVgP94kAIlq5oXe4hUIaEAUF3xlAkArn249mTVsqiQ9ZUIGAcSFW7n/JzwKogBl+b
	zglQfI4scUlaOsFcQ7DivXrnlgDY0MpV3Nc46zyKSnbsQBu2llkurlmD3jPIEbSTYzSU9C67kQbmg
	ZWgLlJVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8zbn-00000006RNJ-0FYd;
	Thu, 07 Nov 2024 10:19:23 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8zVC-00000006QKi-1VAm
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 10:12:37 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A74r5Er030901
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 05:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=N5rzewcNd+Xw/E+v24M/voG
	qOjCVfFK1Nm+cMKSveys=; b=vBLFtkx/sCbLLr1+gUkh0Bh6XiWofYLIctGQ/2q
	57ay8a6P1piV3XzNP7+rN2sjzCOQ9TenOXcNmF5TymySBkESrudfTSPh1iPdvwUM
	qvzmEwfVo9zdH8weqJwaB0szbZa39MkJQxjd3TnDkRE3RR4gHdtw9/+2iEt/oCgp
	9JiVAT4WPrs1Urbulf90Ib8kbSDjLdZGkkv6PFUXD+dMMEXt4DdOMm/gj4Q40lVm
	4qfb8/m2YPyKkXTZRoD0XShw04PTo+VZhVFz3SZobLlmyqDmlSr7c4bJAQHqDuCy
	Tiz3XQMQnTjxnjk+vHG4ULdzTplicF/u44dktaR+OY7h4Dw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 42rpwqha5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 05:12:31 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A78m1ju023056
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 05:12:30 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 42rt53h7mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 05:12:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8xm01vnH72gG7Qb8CDA5enHFdeiLO11MmvrIx1F71B4sZTIuUm4s6BN4oMaLYM/gVw0I0OYZ3aPRFji4a+8SAVp7vjUwlLbPvdCiclOV5Q4sAl//J+4GROSW+52foiULJbXcKG6GTuJWKm2PsfWc6HXfd3Kv5Iz7ZrLPrtQ2b/yztxf1tbvP8PcTsGtpYqHtgC7hCyGhznugMn4Av8FO4ch9gxFM2rHWosEW/Qz+hRKGNm73AibsazExZoMHJAMEfh2yUn87ZgcW4UuFfsXILkIdzArccq9nx5yaHbAaBo6HJmunvqEhxq4kJjgawq12J/STDCCixIP6vP1rb5uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5rzewcNd+Xw/E+v24M/voGqOjCVfFK1Nm+cMKSveys=;
 b=I0c6g+zp43G4El/ytsZIeGtOJmjog53ACWsuD+8dYQUt50jmjI+AMTdjezE++psUJeRh4KvdhGmlKSJoGtiwSEEXP0XY3Kds3RhXcPSDul/ZwS7Z4vvU+h4Zzzu7fjYW+FIS5g8N7HB52FwYWOqfI5YKhOblHc5FbS1krP2fAazjBxwE1NBlN7xv5qMzQTgyc4umatjzbDI4dG6tIWkkUvmMx2Ev3rHcrIlMJR//SfuezJ+CvjKXBox6S+0xzSZfJGqbd6IqI9yf2lKgeIFMxJ1BEC314Alf6l64Fg9yifM2UDfmIQ0PctdXsFsUt7wGS2waVUzERFeVYKUZRnC41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SJ0PR19MB5612.namprd19.prod.outlook.com (2603:10b6:a03:42c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 10:12:26 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:12:26 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>,
        "Cohen, Yonatan"
	<Yonatan.Cohen@Dell.com>
Subject: nvme-tcp failed to send request -32, kernel  ver
 4.18.0-553.16.1.el8_10.x86_64
Thread-Topic: nvme-tcp failed to send request -32, kernel  ver
 4.18.0-553.16.1.el8_10.x86_64
Thread-Index: Adsw/XII6VVVVp/7RBuSOYTRGxDGXg==
Date: Thu, 7 Nov 2024 10:12:25 +0000
Message-ID: <CO1PR19MB488513E6255DD934359170DCEE5C2@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=a2a65265-4b0e-4c0d-89e7-581874eb58f3;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-11-07T10:12:01Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SJ0PR19MB5612:EE_
x-ms-office365-filtering-correlation-id: 9f3e28a9-adbd-475d-d949-08dcff14adc7
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjN3SzR5eGlVYkJHbTRISTVnNDR5T0RNR2ZYSmwxYjA5VTNOd0YzZ0hRTDg0?=
 =?utf-8?B?UHJNaHpUZWxyZ2gxWUV4ZEVGUkdoemgzamk5Y3VjMUlPd0ZNNFVZQ1k3aG0w?=
 =?utf-8?B?RFBlOEZtVEdBM3p5NzdheTF0bnpnSXhMZFRESG4rd0FyVmRUUVZPdzRiWkkz?=
 =?utf-8?B?MmdoN3NTTVd3VEdJTDd2ZkNHMmZTZnIrZ1diTlloNWpLS2JEVlFrZW9sWkxR?=
 =?utf-8?B?SUJ1dGQ1Y3psV0JCOUJiVXVQK3FYM1V4N3dnUi9oZ2lyUlBWaElRT1grejh5?=
 =?utf-8?B?b2pVSEVQN1VCODlMSjdHcVl4RmhUTGVnUkFOeE00ZS9UdDdHQXoyQlQ2dEk3?=
 =?utf-8?B?Nmh4dS9lbE1Hcm1sNEc3RFI3U3N5bDRpQnl6SitYN2pic2dkVk04MVBjazUx?=
 =?utf-8?B?V1pCVHNHL0cxSjQzTEpSdjZVaHd3dVMyNGlYODk1STZwSmNqNFA3a0VrSmkv?=
 =?utf-8?B?R0ZwYjBPU2ZmamM0K1JZQ2grYXpoYlJnQmZlMUxsUDhLdkplUXFRdjQ5OGxp?=
 =?utf-8?B?NEFmREREOGlDdnNoYVZZVFlPMXppNGgyQUtDQTFJMVYyYkRlMDZ5TVc0bTdy?=
 =?utf-8?B?S1ZqRUNzekdiOTgwWlpJcWZNNWFIUmxkeEU3VlRycnZRUWc2TWZnK0YveU5W?=
 =?utf-8?B?b3FOWC9WVER2SEw2YXJHeHhITG96enZHUnBjZnBXdVFTNExRM0UvNEtlUE1Z?=
 =?utf-8?B?WHRYbzdsbm9WdUtKVVlQcTQ4Rk1pT3JKbUdlWnkvRm9ldURNRnNEeXhUVXRE?=
 =?utf-8?B?dXpwT0J1TFNGWTErRThHNDF4QzRqV1FTWERtemtFY3RqRHJISERJWW8zMm9j?=
 =?utf-8?B?SC9CSkFrVEFaNTZSam1sSXhaMUp3MTRLSHd4S2VSb2xRcjUrb0x2dFhZQ20z?=
 =?utf-8?B?S0ZMQWVQVVRSSW5nUHZEWk1rN0hpaWE3eWRMb2xUd2xzdkYrZERLdWxOQ1hR?=
 =?utf-8?B?RkRaRUdrUWRZWU90alNoNEREeVlqanFWcm9CTUpGQzBXcVNkQlhvNzUreVZH?=
 =?utf-8?B?VmQ5cGs2cUphbExVMkpxT1FLM2tQMUFGbjlKb3NlV0h5YjcrNCtlekJsd2lB?=
 =?utf-8?B?R2Rqem5OVjRhTXVXSWNQRGZobjIxbW43Vk1NWDJlNUdIWGEzZkJZSDVDN1Fr?=
 =?utf-8?B?ZWUyNTYyT0RuMzdoWHQvekczVkxsSnVsRnBHam9ic05uekFpL1JUU2tjcjRW?=
 =?utf-8?B?cWhMeXhsRVViQkxWY2VlbDNFUkwxWTBodGJTbE1mZ1VPMHpuWEJRb3dWK204?=
 =?utf-8?B?T1BzaHc2amRPSTlwRWJCSHd5YTlEOHVWY2FPdFZZd3NBL3gzdkU4eFdzT3V6?=
 =?utf-8?B?dWF6S3gySnNOZ3BCWXkyVVlXOWpxV2NkMFFyQ2QxaEE1b0k4bzltYnFxVmw1?=
 =?utf-8?B?cGV5ZW5KQUUrMFd5blpjcmViekg3dzlqUFZIY2R3QWd2bjl3akczRlgrdVMw?=
 =?utf-8?B?SDMzZW9kN29kMlU3azZTTElkdDN0OWp4RkRHNWlRR1pSUHFDVU1XVGRUMGlq?=
 =?utf-8?B?b3RLMUxSaUxEMWVyTWZ6eTJTeWhmeFNWRTJBQnpFUm9BNUpSSmc2OGUzSXE2?=
 =?utf-8?B?VVd0enVUUVFBZUhSMHh1T0ltNU40ZkFYaG9NVnAxY0hkakFiQ3hhRVNKalVK?=
 =?utf-8?B?M3M4N3h5RUtiVXAvM2d5UFlubldDZ2k3Q25HVWZGcVlUbVVlTndKNXArai9T?=
 =?utf-8?B?RjZmUkI4QklIN29mU1V0RFJubG0zTVEwMjBrVkJrMysxMVJmdjRrK0EyWmF1?=
 =?utf-8?B?NkUvYk9xSTQ5NytiOGdpL3lOdC9vZFNzeEIvSHQ0b0JRMmV0NkxJUFpVL1FX?=
 =?utf-8?Q?Pr8PxqnXr9m8HRYXk0A/YXMOC5GRh4mWbKahI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0kzY2VvaGVWdHhpazNlY3VpUjZsZ3VLSFFPZnBSdVh0YkpBSTVkOVh5d1F1?=
 =?utf-8?B?Y3FFZHdxSlRieFJUM25FL1RoYWhMME5tbVN3NmFqWE1KNHBZM1BYbUMvYXhV?=
 =?utf-8?B?ZDlaWHVGQXFMMUN1UXhyaU9aSUVYMTkySDdiR0xHZnM2MWJYSjZXUnFGQUlv?=
 =?utf-8?B?eEcwdFU5b2p2VWJQN1lNTldndk03YjlJYk1OVHdqTUpHN2d2bGhOelRwTlgz?=
 =?utf-8?B?MHYrNTBFN2Noam56N05vdlNnUXIvNEg3VWxQelN4WjJYanJWc0hNQlNaMGxB?=
 =?utf-8?B?aVN5UmlDZWppWnBwWDk3RDMvMEVOVjVsYjBvMjdwTHdHL2dDbFNiK1Z4cDFp?=
 =?utf-8?B?bU9uQ2p1anpRU3lCTWtTRVRPcWRrZ3F0VzRHN1pmNXR3Z1N1b1NOU1U2bXBT?=
 =?utf-8?B?TXdBL3FxdTJNak9iY3o1d2dJSWhHS2t1UmJ4S3FqUUk0VVFYRE9vOStQZE1v?=
 =?utf-8?B?ZEdyNHBKTDZpN21iVTY0VEpYQ3ZlZUcyaE56UU5NZi9yb3lMWWpmK3NWUERC?=
 =?utf-8?B?RjBCelBFSjVyNzBQMGk4Ynpsa1lWWXNHVlJvZ05nZHR1SXo3UVFzcE83N2Ft?=
 =?utf-8?B?bkFyY0Y0VGpDZmw5RWg3RWNTQ0NVZWttL3l2T091YURqd203ay9lZ005V1pF?=
 =?utf-8?B?OWFWZ24vdGt6NEpwZ1d2MzdDQ3YxVk1WQi8zYnBQalBCZGNFR2FwL2MxQlI3?=
 =?utf-8?B?VzczOGVHRG1xWGlGUjNSOWRlZy9KWXpWeTlvVnlVTlpRbE9qamN2R2dyaC9Z?=
 =?utf-8?B?bUhBNmpaWVQrYmtXRkZZTitSYXZteWdySkJ6TWdqdDRZeGhGRk0rQmJkRm5j?=
 =?utf-8?B?MzF0Y1VYTmVrM25jdndueVA1czhEVmtsQVJuak8rYlc4ck5EOEtTMElnUTF1?=
 =?utf-8?B?SGpORW82VTdPY29hVVlNYmliT00vU3ordk1vWFpxb0o1VXcvc0tvTndSY0lT?=
 =?utf-8?B?cTE4WURsendqeUNmakNqeS9VTTdnczBkNUMzQVB3M1FvbzlVa1dGRFdQK01k?=
 =?utf-8?B?RWI1OFRzZXFucGIvcTBmMG1IbjJuVUwxeE5YVFBJVW1CckRjNTU5QjR4MXNO?=
 =?utf-8?B?N2RENlM2UmhKUUsvbDFGQ2JVN3ZhQTUrV2VwQkwvdVBXd2w1VFdVampiNlJ1?=
 =?utf-8?B?b2FIVThSakY0TkJPNlhlcDBhS002UlAwaE1ZcUpOK3A4QTZpU3hmdjh1TVlC?=
 =?utf-8?B?Mjg1OG5pRWczK2hGUHN3MU1MQk1IbzNNakg0QmQ2bkNIWlNRMGEzaXRMRFAy?=
 =?utf-8?B?VytWTWozYTFoVyt3NVFWdlJjZmc3SjFCSk1UcFcvVGRNR1NHVmtZYk5EMDkv?=
 =?utf-8?B?TmxGWW13NURRVWRydWp3NEQ4TlAwRG41ZmhIOG5JRlJuV2dwQXFpS0J3VE16?=
 =?utf-8?B?a3ZGcCtKRmdBODJYeGlVMm9oV2tmZ2xhbUtVYnBLWERocExNbEkwRWFGMzVX?=
 =?utf-8?B?b0pSbldXR2czZzZHTjJuNEdrK0tsaEpxUXVpTHpKMi93MWR4ME9WTXRVK2pG?=
 =?utf-8?B?OWdzQmlhY1luZWZSZ1IzSUVmZ2pGbzMvcHFtc1BtdnpOTW5BSGx4bVNnNTZK?=
 =?utf-8?B?ODNHbitoSXR6VE1JeWUxSGNzcjZaclgveUw0L0MvRWhUWGpPdmZNd1JpYTlU?=
 =?utf-8?B?bmdONHZ4eTlJU0xEWkpRYXNHcFJOd041N2ZwQmhRam4vcmtpNTNDbnM5L2wr?=
 =?utf-8?B?Vml0ck9Id3EyV3paMFQ5cGkxemVBdC8xWmJNTWxPSFdjUzNuNE1DS21aaXZ6?=
 =?utf-8?B?S2M0RCt4TGJDNUpXUWhpbkx6TTVzWWhhZVJ4bGlEcHJhcFhDZlRCUWJJWVV4?=
 =?utf-8?B?QXRrMWM1ZllsM0p1b2VkZ0lSM21Va3pMQnh0ZVk1QW1ySnpzN2F5ZmVsaEth?=
 =?utf-8?B?WXg4ZkRmUFJybEl6RzY3Sk0zbHBIbTMwNjJYTXNJOG1wVlNNSllzUW4yNHJZ?=
 =?utf-8?B?UU5vY2hkQjd4TmFmejdmT0dJOGpZKzRVN1dhc28vRlR5ai81YUxDdlJBeXVJ?=
 =?utf-8?B?RW1GdEYxZjI5eUNWMExjbkVPN0I2Qkx5TGRCOHlwaDlNYWdObDJlUDJWYytl?=
 =?utf-8?B?czZnc2FGVHJFS0NLZ0d3aFByeTZ5Rklrc3Y3UjNFZVg1bHJLRkdmeWJ4QmRS?=
 =?utf-8?Q?as2dXwlIXXkJNLe06caGByWwF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3e28a9-adbd-475d-d949-08dcff14adc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 10:12:25.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHnbJU1bnZwi+esLoHz8stCsTBxEbMVVjRqCKV1No58bh1FNUxso6hCGKxuml42cHczR0cS3XI8mq94R90Kmmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_01,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=966 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070078
X-Proofpoint-GUID: lJvAwYru6huiQ0B24ChunOHysxIEeOMm
X-Proofpoint-ORIG-GUID: lJvAwYru6huiQ0B24ChunOHysxIEeOMm
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=925 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_021235_606902_C8F19FC1 
X-CRM114-Status: GOOD (  10.41  )
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

SGVsbG8sDQoNCldlIGFyZSBoaXR0aW5nIHJlY2VudGx5IG52bWUtdGNwIGZhaWx1cmVzIHdpdGgg
a2VybmVsIHZlciA0LjE4LjAtNTUzLjE2LjEuZWw4XzEwLng4Nl82NC4NClRoZSBmYWlsdXJlIGlz
Og0KMjAyNC0xMC0yMVQxNTo0NDozOC4zMzk0NTArMDA6MDAgbmMxMDk1MjAxIGtlcm5lbDogWzMy
MjE2Ljg3Mzg4N10gbnZtZSBudm1lMTogZmFpbGVkIHRvIHNlbmQgcmVxdWVzdCAtMzINCg0KRnJv
bSB0aGUgYmVsb3cgc25pcCwgeW91IGNhbiBzZWUgdGhhdCBhZnRlciBhIHRpbWVvdXQgcmVxdWVz
dCwgY3RybCAobnZtZTEpIGlzIHRyeWluZyB0byByZWNvbm5lY3QuDQpBZnRlciBzb21lIHRpbWUs
IDgwIEkvTyBxdWV1ZXMgaGF2ZSBiZWVuIGNyZWF0ZWQgYW5kIG1hcHBlZC4gDQpGcm9tIHRoYXQg
cG9pbnQgd2Ugc3RhcnQgc2VlaW5nIOKAmGZhaWxlZCB0byBzZW5kIHJlcXVlc3QgLTMy4oCZIGVy
cm9ycyAoZXJybm8gRVBJUEUpLCB3aGljaCBtYXliZSBtYWtlcyBzZW5zZSBzaW5jZSB0aGUgY3Ry
bCB3YXMgbm90IHN1Y2Nlc3NmdWxseSByZWNvbm5lY3RlZCAoeWV0KS4NCkhvd2V2ZXIsIGV2ZW4g
YWZ0ZXIgbnZtZTEgY3RybCB3YXMg4oCYc3VjY2Vzc2Z1bGx5IHJlY29ubmVjdGVk4oCZLCBzZW5k
IHJlcXVlc3RzIGZhaWx1cmVzIGFyZSBzdGlsbCBzZWVuOg0KMjAyNC0xMC0yM1QxOTo0NTo1OS45
NjI4MTgrMDM6MDAgbmM1MjIyMTcxIGtlcm5lbDogWzM3NzY4LjE2NzkxMV0gbnZtZSBudm1lMTog
U3VjY2Vzc2Z1bGx5IHJlY29ubmVjdGVkICgyMTggYXR0ZW1wdCkNCjIwMjQtMTAtMjNUMTk6NDY6
MDUuMDE4ODI5KzAzOjAwIG5jNTIyMjE3MSBrZXJuZWw6IFszNzc3My4yMjMwNzZdIG52bWUgbnZt
ZTE6IGZhaWxlZCB0byBzZW5kIHJlcXVlc3QgLTMyDQoNCk9uIHRoZSB0YXJnZXQgc2lkZSwgdGhl
cmUgaXMgbm8gaW5kaWNhdGlvbiBmb3IgYW55IGNvbm5lY3Rpdml0eSBpc3N1ZSBvciBmYWlsdXJl
Lg0KDQpMb2cgc25pcDoNCjIwMjQtMTAtMjNUMTk6NDU6MzguMjAyODc0KzAzOjAwIG5jNTIyMjE3
MSBrZXJuZWw6IFszNzc0Ni40MTAyNDVdIG52bWUgbnZtZTE6IFJlY29ubmVjdGluZyBpbiAxMCBz
ZWNvbmRzLi4uDQoyMDI0LTEwLTIzVDE5OjQ1OjQ4LjQ0OTgyNiswMzowMCBuYzUyMjIxNzEga2Vy
bmVsOiBbMzc3NTYuNjU1ODQyXSBudm1lIG52bWUxOiBjcmVhdGluZyA4MCBJL08gcXVldWVzLg0K
MjAyNC0xMC0yM1QxOTo0NTo1NS40OTE4MjUrMDM6MDAgbmM1MjIyMTcxIGtlcm5lbDogWzM3NzYz
LjY5NzI0M10gbnZtZSBudm1lMTogbWFwcGVkIDgwLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1
ZXMuDQoyMDI0LTEwLTIzVDE5OjQ1OjU5Ljk1NTgyMiswMzowMCBuYzUyMjIxNzEga2VybmVsOiBb
Mzc3NjguMTYwNzA1XSBudm1lIG52bWUxOiBmYWlsZWQgdG8gc2VuZCByZXF1ZXN0IC0zMg0KMjAy
NC0xMC0yM1QxOTo0NTo1OS45NTU4NTUrMDM6MDAgbmM1MjIyMTcxIGtlcm5lbDogWzM3NzY4LjE2
MTM5Nl0gbnZtZSBudm1lMTogRmFpbGVkIHRvIGNvbmZpZ3VyZSBBRU4gKGNmZyA5MDApDQoyMDI0
LTEwLTIzVDE5OjQ1OjU5Ljk1Njc0MyswMzowMCBuYzUyMjIxNzEga2VybmVsOiBbMzc3NjguMTYx
NTI1XSBudm1lIG52bWUxOiBmYWlsZWQgdG8gc2VuZCByZXF1ZXN0IC0zMg0KMjAyNC0xMC0yM1Qx
OTo0NTo1OS45NTY3NTMrMDM6MDAgbmM1MjIyMTcxIGtlcm5lbDogWzM3NzY4LjE2MTgyNV0gbnZt
ZSBudm1lMTogZmFpbGVkIHRvIHNlbmQgcmVxdWVzdCAtMzINCjIwMjQtMTAtMjNUMTk6NDU6NTku
OTU2NzUzKzAzOjAwIG5jNTIyMjE3MSBrZXJuZWw6IFszNzc2OC4xNjIxNDBdIG52bWUgbnZtZTE6
IGZhaWxlZCB0byBzZW5kIHJlcXVlc3QgLTMyDQoyMDI0LTEwLTIzVDE5OjQ1OjU5Ljk1NzczNSsw
MzowMCBuYzUyMjIxNzEga2VybmVsOiBbMzc3NjguMTYyNDExXSBudm1lIG52bWUxOiBJZGVudGlm
eSBOUyBMaXN0IGZhaWxlZCAoc3RhdHVzPTB4MzcwKQ0KMjAyNC0xMC0yM1QxOTo0NTo1OS45NTc3
NDErMDM6MDAgbmM1MjIyMTcxIGtlcm5lbDogWzM3NzY4LjE2MjQ2M10gbnZtZSBudm1lMTogZmFp
bGVkIHRvIHNlbmQgcmVxdWVzdCAtMzINCjIwMjQtMTAtMjNUMTk6NDU6NTkuOTYyODE4KzAzOjAw
IG5jNTIyMjE3MSBrZXJuZWw6IFszNzc2OC4xNjc5MTFdIG52bWUgbnZtZTE6IFN1Y2Nlc3NmdWxs
eSByZWNvbm5lY3RlZCAoMjE4IGF0dGVtcHQpDQoyMDI0LTEwLTIzVDE5OjQ2OjA1LjAxODgyOSsw
MzowMCBuYzUyMjIxNzEga2VybmVsOiBbMzc3NzMuMjIzMDc2XSBudm1lIG52bWUxOiBmYWlsZWQg
dG8gc2VuZCByZXF1ZXN0IC0zMg0KMjAyNC0xMC0yM1QxOTo0NjowNS4wMTg4NjArMDM6MDAgbmM1
MjIyMTcxIGtlcm5lbDogWzM3NzczLjIyMzQxMV0gbnZtZSBudm1lMTogZmFpbGVkIG52bWVfa2Vl
cF9hbGl2ZV9lbmRfaW8gZXJyb3I9NA0KMjAyNC0xMC0yM1QyMDo1NjozNS4wMjk4MTgrMDM6MDAg
bmM1MjIyMTcxIGtlcm5lbDogWzQyMDAyLjg2Mjk1N10gbnZtZSBudm1lMDogZmFpbGVkIHRvIHNl
bmQgcmVxdWVzdCAtMzINCjIwMjQtMTAtMjNUMjA6NTY6MzUuMDUyODA2KzAzOjAwIG5jNTIyMjE3
MSBrZXJuZWw6IFs0MjAwMi44ODYwNzZdIG52bWUgbnZtZTE6IGZhaWxlZCB0byBzZW5kIHJlcXVl
c3QgLTMyDQoNCkhhdmUgeW91IHNlZW4gdGhpcyBiZWhhdmlvciBpbiB0aGUgcGFzdD8gQW55IGlk
ZWEgd2h5IGl0IGhhcHBlbnM/DQoNClRoYW5rcw0KQW1pdCBFDQoNCg0KDQo=

