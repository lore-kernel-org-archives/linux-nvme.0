Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBBBC27C52
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qC1KwiI78NPWQAV59nIjkK4VOOum8bJAstfcqpaNPAk=; b=jwV1E77SyyMaxvrB+fSWNfxgOS
	oJMXd2pMxwICFl/TnUHdYnD/lmdsMLfJ243U0ULRbtu9ONeGlJXOLGLucVpepS39GuRkQssXGoflg
	Sf3sHLxlJlIOvaoTkcS6wCJ7y3hJaK+B+5vuvxRJ9+58vKzTcAvn4PbxCwA0bqnhhDEo6WVP6ydpP
	3bnxEJFENeBeYjhEnqW36bEylh7UB0UddynL8/aPNgzQMwrBcPWs5+VmFm+PgS91ysNWUAcET3AvL
	nfUKDtPCeGYd4lFDIUCWIcGH7HWrY1td2E6xu8GmtthcC2qfAOpy4YOB5sk8M4BugpeGCIgLa31NR
	bqobUyzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6mN-00000008YBY-1nGB;
	Thu, 06 Jun 2024 06:39:19 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6mJ-00000008YAK-09ZW
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 06:39:16 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455J0eFU015603;
	Thu, 6 Jun 2024 06:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=qC1KwiI78NPWQAV59nIjkK4VOOum8bJAstfcqpaNPAk=;
 b=Zg3zQwIICjv2QP02fOcXP+SwJaoJxjA6U7Io4py5eNxvvMcy7alMUDqLoIWV55/5t9Dx
 iXq+TYD/iXcACsgUfhxxneOe3LC2poQaPp+Job1EltR8/6ncT97WX4WmMOoPzE5SOYzJ
 qNr39Xpb/4IsNlHK7hkblV7B2Ia8mILYudskIBYTMToz0sGCOZXTDdZp2g1cpHKAVy/2
 n8jdn92LwZYApCTsWGPdZptx/6Ytf3gStA9R1F3p68PROKGw8sITQo8EuFsNUX76QE65
 ixslhEhO188j2pNX5OLiQ4rM6UdWu31LOUQDf68B4JBN3MDh9RJDczapxf+bSEJyr9cr hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsyau5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 06:38:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4564xt9I016562;
	Thu, 6 Jun 2024 06:38:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrscms0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 06:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpm6GOSqVZmwF6AijRP1WELmHNGR9syPIJNhiXTHzZ9sKzi7+YxvpAnzuywRfAlzdKYb3rGU0dUEdd8h3Uonns6xNljtQ6FoCrR5ADX57gZDNeVVMvEek/F7DshQXOYf9yEGBKZ945IEqLvuVKJfc99EKwhSk2cbduANvP2Fn8ze+PtzkjzXGOghqTcAvWVNsDAnmv3DWfKyds5NOvryAIUjQXtynztKrunGVgUj84e8dbKpDvv5Tjf+I6AJZXuvzcT5kwM56ehB//iDL4cwuyWfZuPLPkSN7j6RCZ1AASRHNGcDsgTdAaRQ1FDzNUru8jx02PhvcOJJhEG/YMAaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC1KwiI78NPWQAV59nIjkK4VOOum8bJAstfcqpaNPAk=;
 b=juJQW53pOQST1rDszzokqS66/2UxvSWV+eT0DxElO+6ldMbUb/A465g0MU/OJw0V6dZsruWAPZCY6v0KMxseFu2JS4Sm0sSxSmDHLJ5W5y5IRRtTV8Ulyvd70E5kHpGAkaDPPGdxR5jMj85V8K84/IGsgbIKQ0V91SHQGnqFwpecIg5Y/hFydKuJ39jXTClLED8iVBHSJDsmFqio/2gtTYvj+/imeX5an/UDIPyE3SbdONs4+GY6WHa80iunFkqolMgN1Q8wDuya9xK1w7x378YqWpBiPxpltjvBNallXbQcSupvLldIzxXM3GnM8Ovu4JRyFi90laVGDj04j8PF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC1KwiI78NPWQAV59nIjkK4VOOum8bJAstfcqpaNPAk=;
 b=gVLgBoFFFP26jW6G8/F09+FvckOxIQSC5YdYwgIokoPEdjhDBQ/rzvFhL8w5RbhECnNzPSVDe5GpT4l7zpF1Eb07WI1Gd5mCPjBOas/KAgE0MXCh7rh+3REk8kpqgC8gkVgN+QYW9S1okyHbLAxxUrKMDq2/ssteh1qkVcjuJx0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 06:38:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.032; Thu, 6 Jun 2024
 06:38:48 +0000
Message-ID: <cb5e9d41-c625-43b0-aeda-591b4f7edfaf@oracle.com>
Date: Thu, 6 Jun 2024 07:38:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] fs: Initial atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com, willy@infradead.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20240602140912.970947-1-john.g.garry@oracle.com>
 <20240602140912.970947-3-john.g.garry@oracle.com>
 <20240605083015.GA20984@lst.de>
 <fbb835ff-f1ae-4b59-8cb3-22a11449d781@oracle.com>
 <20240606054143.GB9123@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240606054143.GB9123@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0322.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: cae0fdfe-0c12-492b-2b5e-08dc85f35215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXR0UDRlUGNSMFhNakVUdFAwYjJoZXFQN1BIV1c1TWYvZ0pKSkV5Z1dJR3hH?=
 =?utf-8?B?VTNxQTZab0s0ODFaT29GdjRvalp6U00welQvekhuZjQvSHFMeGVIMXBiWFdp?=
 =?utf-8?B?dU5OMlRQM05DSDQ0Nmg3cUgzeXBwQVJWQW1jYlBUamNJREpDcnJTQ3FqVVhq?=
 =?utf-8?B?Q2hKM3dxM0NkOHpFeGdEMnlaa2Q5MW43c29oOWN6OXdlT1J3WXBBeGpIalNF?=
 =?utf-8?B?RVFuaFFrWEdNN1Z4VzNmeHJITUlOVWpqM1BSVmlDL3FyL0ZWSVZNUXVLbzZ5?=
 =?utf-8?B?YlhTWUxoNWQ3a0FNa0tKQ1FpTGlmb2J3TTdvVDBEWTk2NGZBU3hZME9XeUh4?=
 =?utf-8?B?VWUvem93Z1Myb1ZIZVhIQk8rTzRvY3NMSDQ4NDdySXhpMHhsUUNhUE9mMzVp?=
 =?utf-8?B?M2pWT08xSkt4MHRETnFYSGc5SkdCVkVFcjYvWmRCT1BSWUNDemRPUkd0Sjc5?=
 =?utf-8?B?aS9IMm9nRlZwcFdueU5xRUNCUzJGNXJjSmZSS09PQ2lBQ2FheU9uQ3QvY0VV?=
 =?utf-8?B?Rnc1UlhDdzVKbjlOOGp6UEpXTnhkSit6VThMREYyRld1a0h4cHhPR3IxMUFZ?=
 =?utf-8?B?VUtNZ0JEWUtkVzZ5aVlPZmJDUjVvWnlCb0E1cnF4anJwYitOcnE1NUkwRmFu?=
 =?utf-8?B?RmVGbC8vZHFOVlhheDNuQTYrWnB5QTdyZnlPYXVMYjliall6YmhiWUN5SHNi?=
 =?utf-8?B?RldnTHhIdnBJWGRRak5Tc1o0RDZlVEhyK1JpLzZXU1hFTUx6YmxsNzI1YUg4?=
 =?utf-8?B?a0xIWUF2RnhUK0FMY2U1S0NyWjRmQTAwMS9vVUFNUlh3NlJoQjJGNEwxQVFY?=
 =?utf-8?B?OThBTlh1bk4xckpTV3JxTFBBdDYxeEgvQmRkbVo3ZXFESHIwWGdjdUJMczNZ?=
 =?utf-8?B?V2Jhanl0UGRpbFd6MDEyUStZUFlUUHM2cEtLajNHMGljenpJQW9Ua3VKZ0Z2?=
 =?utf-8?B?VHd5endObEhOU2JUdngxM2h0enRXOVA3a09WdnJ6WU9xQ3lrZVhlaS8wd2Rt?=
 =?utf-8?B?NGNzeGFua3dpUC9rcWU4eW9BaVBaRi9EUVpDU0VWaFJLd0xVQ2RLUXdmV0w2?=
 =?utf-8?B?L1pDV2pZYmlnZkMycGFjZit1NGU2TXRtZXFUaVFyR0hLeWxYNkJHZ0pzRThr?=
 =?utf-8?B?SWF3eU9DeEJqZGljTFpmSzdqMDV3anNRS0JsK1RhVC9Udk9rSmlJZXhtZTlY?=
 =?utf-8?B?Yks1UVhpY21ZelpIR2UzVk5KYVZpL1diS0ZUc3g1S2ExVmlmdlQycGgxajZW?=
 =?utf-8?B?ZnFnU3JhREdaaFZoczBpQm1LdkFydXFrSTlLNlpvcTN4eEFsbEZqQkh4QTNJ?=
 =?utf-8?B?T0JYdXQ3cHVJZFJEczBvaFUwTlFXMWdXMUhQK3VXb1VuOG5kcHI2OVVPYWho?=
 =?utf-8?B?TmxuOThFc2FWN1NOTzkzOWlZT3dJeVFmSHp0d0NyUEp3dW1wS01ZNkoySFNi?=
 =?utf-8?B?aCs1dGcwZFV3NGQ0WnZUbnJLR2lTaXhsRGZFNG4xMzRIbFR6Rll3eHJmcXk3?=
 =?utf-8?B?NCtRaERtaENmOWd6U3FzY2RrSXVhK08vZFdMY2NHS2lZVWx0ZWtyQVVyM0pk?=
 =?utf-8?B?R0xZMHlKTkhhYzRCQmpockkrUXgrQVVyOVZTVlIyZng3cmkySWY3KzdVSzY1?=
 =?utf-8?B?eVRqeldVOWxSMmt2YjZSR0xLR2REUTBabG1HM1R6a0VuckRNTGtpNTFrK3pj?=
 =?utf-8?B?NFpBYkwzajhKVTNFYnZtQ0ZQQ0ZJQ2RiMVdqYXlDY1hUUG44ME9sajRXcmNo?=
 =?utf-8?Q?VPuTAD/CJkvueQTmF1yfTFBZq9IkcVUwPy+/Ywx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZadGRLVGJ2Q3ZYanUySmVLWUFPSTNKblNjMUZ0RDhEY2FveXJLYlhoZWFn?=
 =?utf-8?B?MWthSUR2eTFhUGNDRkFCbEE5MjczU1psdkFCbGNkNHkySU5IZWszbldINjJr?=
 =?utf-8?B?cmsvcHR3RjhOYVZRUHVOWXNrTXZMUzRnRzhvQ3FWWmt2NWpuQjZwN1FQYUZy?=
 =?utf-8?B?Q1BGU3BoZ2ZwaU43OHZUMVJXRk5FQmhNVHZDYk5YOTNBenc4SWtSeGNJMlZ4?=
 =?utf-8?B?TkZBZnhwUTY1Wlo4di9zWW4zbWgwZFkzejZ2MWRwNmIxdHlCS1hZRVQ4ZjBF?=
 =?utf-8?B?MlJKL1l3V1NlQy9hWnFFaVc3bGtzNUVvSVBzN1Q2R2ZNU1BxV2p5cm40OXVF?=
 =?utf-8?B?UjZrczNEdzRXamJMSy8xdUFZYmRUdHF1Zzd0aHBZZmZaa1p5MjFMODdEY2dK?=
 =?utf-8?B?SFNmbGdhd1h2SmpVSFVVTW9KRG5GN2MxZnJXd015Y2tGcEhRaDBDenNoTGcr?=
 =?utf-8?B?dTQvMCt2dExmMFhqeHZZRmlZQWkyQXhZekI0alZ6UFUyVjgvR2ZNYzIvNVd1?=
 =?utf-8?B?QzJ0VGVGOUEwMlBwK2h6SXYvUzZmWkg2NGN6bmZoYVUwclUyN0F1N3hPRjdq?=
 =?utf-8?B?cEVIcnQ1QTBJN3JnM0FnaktlUGVwVjJ2bUQ4MDZKZWprVncvTjVLRmdXaVRr?=
 =?utf-8?B?N2tuT0pvQSswYjlNTHFnMWtEK1RwRFd4R0g5VUtZSzl5SVpSTHJSbTVPUE9t?=
 =?utf-8?B?Qk9NdlFVWWxMRUE2b0RVZCtBYVVaMkkyMVpEcDRXWmlsU2p4dzd1bW54VVFm?=
 =?utf-8?B?c1VyNVZYTlZIdGJJa3FoS2ZoaUo0cGFIblU3TXFpcTE5alMzQ05HRkJnLzBJ?=
 =?utf-8?B?dzZSVW5ld0R0aTZOUGU1d2VHcHdsWUxweElrY3ZVVkxuNW93SkdxR0h2THIy?=
 =?utf-8?B?clRsRDR1cVRaTmQvMUFvQ1JiNGRMQUowWXFtSU1LQWQ1VU0vaVgxaTlWQSs4?=
 =?utf-8?B?dHo0ZStFeE1LRCtIU3FMYnNwOS92cU95RzBDbjZpNXN3N05XSVh2YnRJdFNE?=
 =?utf-8?B?RTBQY1UrNElSVVBaMU1UdlB0R3kwUmVVZzRIN1hIaGZpS3hTMFU3M09VZXRK?=
 =?utf-8?B?UFFzK0pBUmFJeFZ0bmtTYnV6UzNjS1RwREh4ZjZpbi9JYjR4LzZMakF5dE8w?=
 =?utf-8?B?NnRjNUx1NCtqT2tpTWpWbzBwM0dOUUpKcXZkb0REUktweWJiWDNVN3F0ZEZU?=
 =?utf-8?B?STlJckF5Vi9ZL3VqTzBOVmY1V3F1bFEzbHF3L2JsZ0ZYcUsvUFNwTzBhS2hi?=
 =?utf-8?B?dVYxSFQxU2RrTnZ6bER2U1RQYndVL3EzQjJzNytXcVI3ZmxzNEhJcG1PeUw5?=
 =?utf-8?B?dWF5Y1FyQ3cwTys3aUdadGR5ZFBPSkpVajRYZ25zZ2Q3SW9COVhvVjVqb3pF?=
 =?utf-8?B?eXZnSUZPYWhUMU41eTB3b0RuS01hM3NJclFhcG80SkFRelBqclNocXBYaU9E?=
 =?utf-8?B?dHBlbHgzRG5Kb0hOdVZLTFJlSFVOWWRCVlhzaEJNVjZpa0h3SktqdDlZOVFZ?=
 =?utf-8?B?Znc1WG1EdTd5Vk4zamRKYWJGT3RodjdKVGkrWXdRRTM0ZU9KUzVOMVZWTTBh?=
 =?utf-8?B?ekZOQWdxTkNIK0gxbVdWNzVkYUNkNVdTSVRKbTJOaklnazVUTEpEUUdLOElH?=
 =?utf-8?B?K3dxOGc2VU9Zc3ErV1o5cFpDdEV1S2RORTBiZ013eC9qMjNNVm91S1ZFbXgw?=
 =?utf-8?B?OCs5OHYrNXZWaDBVb1V4bjVXbHMvQnNmTEtGQlBxSi9ybFA5RGNVUE9RbjBW?=
 =?utf-8?B?UzBYc3lZTXpCVmRQV2JobUxBL0pkRVdlVGpIbFVrYmgrTWZ1MFJ2M1A0UVo0?=
 =?utf-8?B?aXNYTWZzQmczb01CUUtzd1JUbmdjMTNJUlhOb2o3V05yUXFMcTZaUjNzaUI3?=
 =?utf-8?B?V3h5a0pRTUNRTFNUN25qaUlsR29vZHhSREZPc2VLV3ZQUmZ5NDlaVnBNK1F2?=
 =?utf-8?B?UmxZdHNZK3BtM0dhck5ZblhsR1MzQnVuMzRCbXJweldpczdoaDA4Z1cvVnJp?=
 =?utf-8?B?L3V4dDFoSkdxTmt0U0JPK01WSFp4dzJTbHBrd0Via2I2NEdxTWhPWnFuV3Bo?=
 =?utf-8?B?RzVvZ3B6Zmc3Mk4wLzVuK2F6Rnp4VUNyTDhOQ25CYzBGQWd2MHRkTGQwUDhC?=
 =?utf-8?Q?mBEmI8IYmDYd1LCjWVIA0rEnr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZwScU5lMIx256z9qO+6dqFLUOkXaiayZj9OqWVuHCOe9RjYxtPNfEePgPcA/6JvwkivBLyGJ0VJv4XKd7T89TGLdOAFKwE7Ucot81VQQfCIhJ6/Z4XqbyCbbluvzUk6EMRP1yw8wFms0lyflfKnlK7gv/R30mA88K+TLlGM1qcdRZi2jQOSXr895J/kKHS4XMNQm77G3h6emayi+SwCzLyJFqpS7RWnbJRlmQbhvVS9IE64ENTXU1RaxA/a/q2O5mCT92Cnc1QFf5F4tBmRjtWf+8vvgvq/lj2BAQRfsGiknYhydqBekwLoJ1UchvnXxZgATfTBBuydnKrovyrfKcQug6y+i/VR5xb+dbQyoPrLklcfgZc//6V7upCxX633rqumxumehUT3PDitTkSpwJVKq2sRcTFj6W2H6Py3A3qoIc4TnLjXn4DYOPVsN+MMQNUmQ4CJrPbcZfmiJTZLIrgTNJ9rj6yglKjXlyLeLy1wfKS1MU0ov3uKvhOahPDgQCMatTFKWdn7vZ6LojFN5YUrYyRVkZEeGBupPDZXGUacK5QWD08VpWJwnT+QNIqlk5p73OB15PSSau+lX8QRTzLHbRLYyFT59AjJxaD/A4ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae0fdfe-0c12-492b-2b5e-08dc85f35215
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:38:48.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxtzvARi2C+zlDxM9o1G5ZEuPnAIBMkN95+FAPLV7+eNuGHbG0EI73UGQDipi96guBizvbhiS93DRNMA99Ubtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060047
X-Proofpoint-GUID: dZL0k7ZFCHyGIxS9xF19gB6wpNL1GB_A
X-Proofpoint-ORIG-GUID: dZL0k7ZFCHyGIxS9xF19gB6wpNL1GB_A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_233915_093872_6945D441 
X-CRM114-Status: GOOD (  25.10  )
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

On 06/06/2024 06:41, Christoph Hellwig wrote:
> On Wed, Jun 05, 2024 at 11:48:12AM +0100, John Garry wrote:
>> I have no strong attachment to that name (atomic).
>>
>> For both SCSI and NVMe, it's an "atomic" feature and I was basing the
>> naming on that.
>>
>> We could have RWF_NOTEARS or RWF_UNTEARABLE_WRITE or RWF_UNTEARABLE or
>> RWF_UNTORN or similar. Any preference?
> 
> No particular preference between any of the option including atomic.
> Just mumbling out aloud my thoughts :)

Regardless of the userspace API, I think that the block layer 
terminology should match that of the underlying HW technology - so I 
would plan to keep "atomic" in the block layer, including request_queue 
sysfs limits.

If we used RWF_UNTORN, at some level the "atomic" and "untorn" 
terminology would need to interface with one another. If it's going to 
be insane to have RWF_UNTORN from userspace being translated into 
REQ_ATOMIC, then I could keep RWF_ATOMIC.

Someone please decide ....

> 
>> For io_uring/rw.c, we have io_write() -> io_rw_init_file(..., WRITE), and
>> then later we set IOCB_WRITE, so would be neat to use there. But then
>> do_iter_readv_writev() does not set IOCB_WRITE - I can't imagine that
>> setting IOCB_WRITE would do any harm there. I see a similar change in
>> https://lore.kernel.org/linux-fsdevel/167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk/
>>
>> AFAICS, setting IOCB_WRITE is quite inconsistent. From browsing through
>> fsdevel on lore, there was some history in trying to use IOCB_WRITE always
>> instead of iov_iter direction. Any idea what happened to that?
>>
>> I'm just getting the feeling that setting IOCB_WRITE in
>> kiocb_set_rw_flags() is a small part - and maybe counter productive - of a
>> larger job of fixing IOCB_WRITE usage.
> 
> Someone (IIRC Dave H.) want to move it into the iov_iter a while ago.
> I think that is a bad idea - the iov_iter is a data container except
> for the shoehorned in read/write information doesn't describe the
> operation at all.  So using the flag in the iocb seems like the better
> architecture.  But I can understand that you might want to stay out
> of all of this, so let's not touch IOCB_WRITE here.
> 

ok

