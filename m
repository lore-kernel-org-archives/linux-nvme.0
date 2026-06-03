Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E879ECD6E64
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dk0NBWLfrf5IcJ/+wNZhAdITI16n7MQEHmxSBAAwNCU=; b=bQ+hLEn27W2LQkDpumj4PV4N7M
	q72a8v8M8P5z+UXEdZuiNHfpCszvK4Wjp8X7jrT9osHm3LtTs57zyr3E+uVQmLRLQb5ZjMD+4FJJv
	bo+S9J0ITZtlAIEttPraV+W4d8D+D/lPeE9zJtf5wAVsvEvYbwVPKTnfsKwfGdCiW1UUvOJ7G4KyL
	ziAVg9HwtwsCUnZkvCOYvnA9kTvxpoNRrBKhOZqRZaqgN2nKxGfeU/MC+3Ju6HMoQeJVDY+3ndWb0
	pF+V9fdWXAZ499fHlmr7KaM1iETTAtxI7sSGJEbenin2WdA8XSmnRdrfZyYtAV4hdafBLasqvif3w
	IyQZlZQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUiWj-0000000Em2Q-3EwR;
	Wed, 03 Jun 2026 10:08:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUiWi-0000000Em24-1gQ3
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Jun 2026 10:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dk0NBWLfrf5IcJ/+wNZhAdITI16n7MQEHmxSBAAwNCU=; b=OmSemYWwwA5p8K20IySqG23le1
	CAarXRw0dcCmHZ7IDGx0bMHknBb5XYBeOhTieX5risORtg37WyfDdy6rxtdBvZXpAwmBw4jxD7pSp
	hsZc1rqceH83pxUL+Eh2+dJeVGNC6t1g8AAq7GmEpqdB4+mxtNsOt/Uy9B/oZ8GfE0L6knYffgr9U
	P53Uwubkn/xTLaT4xvx25y0GfOiIThccQW/Zw6VsNFSUAbdeSLv9E5Q3AlXg63uusRX4FO+Pdo1CJ
	NQ5k3gFTw7IghaQ6wN6AMN+BhBlwqvlSMzNlgJsxv3j/ZB64my04XYEewjPixupGNik9542YMLvxv
	du2YqvlA==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUiWe-0000000BnhX-0HgM
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 10:08:43 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6532vxuG1671922;
	Wed, 3 Jun 2026 10:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dk0NBWLfrf5IcJ/+wNZhAdITI16n7MQEHmxSBAAwNCU=; b=
	b2tuXutn/7skx/z6E13e37VH28HWfZvfxdbqr5iGlN5hfGifRhJTNysvldZWTLhz
	IMlFIPBL8Hm535xFmtwF3lFYxdd/VYXOq1yPX0nzpvjFX3fNp3+ND3KuCBNvk8nO
	xZyGFA6XRUo9XoLdmmJBjsJKJf3+ePoKsQcbUxEyTf3qsyWxXwKKCCZEb918KGv0
	3aXz1bRH5zbbdlI9rzd91XFlj8Tq31Uu8mkm/cOOd5a3a034+8/iTgWsMamWle5+
	ukNc1O/iDHvBa2Ic+CG+EoJ9S4joChwCN5FbCjHu+9mNDvtI01zBn3wmvhcieIHB
	XMx4Gsp+nIvro7lcN43w7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efqxddyve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jun 2026 10:08:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 653A0MJh001675;
	Wed, 3 Jun 2026 10:08:19 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ehu8kpwry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jun 2026 10:08:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh0ERSAyv5J3DA7s00w2aDIj3ESo2G1fFplCujcSrX+fvcT4j1I8iNE0HzShEyAoeCrtiCNvkU2QRdEZryYvGujUDDGpMBfMwIyJgySOBGYTWrvTStL3lY2sqYuAoYCBSwKDiuQURcHQd50yLqXCmrlS2ufol5yqsUFLpqv+eTHpX0E8jt678ZluJYDRRkCTIi1KTW1dxSXoaEQQ/HYrtyKGoOc7I+A81oWmLYyjQEDJBDLAls35Bv6SYqBqGYr6+VH74dBC/Ol5QjNRF9BOe/T42I2AAnDX5COxI2FWpktTSfmrYa8v7Sd/eFpdmqQ73PXt0IOyloHgkUjs2eIB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk0NBWLfrf5IcJ/+wNZhAdITI16n7MQEHmxSBAAwNCU=;
 b=hcEnBSpeScrCFBm+DJpHdtDqoBzy8A7GT7VAt3WXySYKW55954Dd3WfTVAw6ZQMGeTSI5pc4nMD+2gVY3hYMpwF/08vXfIzO0T3jE4cJn4PKE/zgVLalk07rMz89vNNDW6sFYhk5iXlY4/eocMf6O7aABYwWpSL7mvn+CFA41q1NniH6b8jOlU0FC+xunlTbt0aYDOES6nDiUvmZcJwBwO3ArJgAH9zGtgbTZAF5v/b6BkgjodjJLx/D0TPLPIaTp/NJNk0R0jumSIFv64qSGUn0KdQzSOnwvq6ioWDmDWKtV8up2bZe4gkDcUSPNEzyga3ByJZ7ap0mB8rEiXTLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk0NBWLfrf5IcJ/+wNZhAdITI16n7MQEHmxSBAAwNCU=;
 b=cQmeOIAIsad6oT4F5PIoRdcEKaVy8tJkMTqW3mfqdKzdXOMeiFovyQuP0Mi0DVwFhfnWRm06OZGrBwG1FHnfaqMjrTsv2i4yjbi5LSFC/BIGLPc9afCxx9rKKnWQ1OoHYbE0WkR88qdxjiTIkkwmrvlIJTlLNgzfJeQK/S3uFU0=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:08:15 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:08:15 +0000
Message-ID: <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
Date: Wed, 3 Jun 2026 11:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify
 Namespace
From: John Garry <john.g.garry@oracle.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@arkamax.eu>,
        Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
        Weidong Zhu <weizhu@fiu.edu>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: d4aa26dc-fec7-4ef5-8e11-08dec158070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: CJ1c+1ddfJRoAk97G5PWfJ0z5S4SbVJMl0GcGyCeAnovXiWenXWPSgDPWk5T7Ga6KjdsybmQRCyZ89EQTHjHLuX0KEoiubXyP7I71H7Umx43kFg1JkI+p0i06K04Kh+OxfRFp/J1NjlU/ajSNewmNTTN2L/vhLyuR57ZhDnBlm6gscPthB+BGgnuKu+js7zhDgks4mGZ950gUvyRpA7S9WMR1S4bwwvrE7bzo1TM/RVHVA5E9XmM4SBSSBecljAUr77kIXRkSAuhiryx7g4JsZCNyvBlXJ00hG8vAhYABhjHhcBQVtz/28mHhvFIgmaOZDTSIbrlcUAHoCos297xWkVHx4B5NCApyVttUSknue01DD8ef8rujb0O/N5Hesg9jiVXRhXT04nhiDLXr7p0H65PYpomMp+TtJPT6yR0LbPIRu7i51SH4xkxttP+rDO+buW3uqui5/qZ5q5L4lj3rfssF9yhxpnih+0t9+yU/0jkyWdQfOf38DZiahO73aok+tKgQaa6G+zDA349/IyfTUc+cIIoYQibptwiupEQEqwW8xYtfiKnwKH1FGfQgU4bycGZkW4M7DsxLyA/a94wquLba086t4laB46i0dbveH5YGsGT9BPgyve37EWgJkGZdEQ1wwTcuNUpsx0G9Kc/Bbyy1m66bEMy0KA0Gkzzluapb6eSVXTqeBSF87dI96YR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JFT0d1Q2JBN2ExZGFZMjJZMW0yYVJ5MEUwbndtUUVxdkt4Q2tVMFhmTkpm?=
 =?utf-8?B?MFlHMFhlaEdPQWdzMjAyUnBnTW1ETGdwUGYwcDBUd0pSbStRd00zM0t0THJw?=
 =?utf-8?B?THdSSUdpVDljOWlJNjhQZ1pUV0tOdmtPU09qNHlmaHltdzdaU202d1pUOXZJ?=
 =?utf-8?B?akV6elZjMzM5Rm1Lam1jc1VLOW5XVVdpRnNYNXpMUXg2a2Yram5EeHRLYW11?=
 =?utf-8?B?NkdpOVFoc0tqYXFZbjNIMmp4bm1TRUNQOEFSQ3BZVlhlR3M5M3BSMk80a0lH?=
 =?utf-8?B?eUpHbG5GMlVlM3BuWmhSSHlWdXNkMEJpU3RPbUhqRUkyOTJEOStoVGMrNDNS?=
 =?utf-8?B?NVZ2Y2pGcTJyd2xxbzdveDk4Zit5NEJJbTVCczltSDYvL2RteElOdGFzTVZL?=
 =?utf-8?B?RlVJUXd5SkFvSFJIMHppZmlCM2RIcS9iQ3dVQ2toQVBlVEwwWHJOOVliV3FH?=
 =?utf-8?B?SSt1NXRBc2tHdE4wbWVWaFJaeHphUTNVenZGRkcreFlzNHdDWnVQaGZGQ3gx?=
 =?utf-8?B?cmMzdEszZEk4M1VuWlI5djV2YjQyaGoweCtOaGg4ZVMvZjFxY2tnMGh2WHdS?=
 =?utf-8?B?RDBuaXp4VThuYXlVK1VIM09TcVZIdG9lbDdQR0R2SDJOT2pVeXk3QjRiUk1K?=
 =?utf-8?B?TENXY0ZCRXBmTnZxbDdQN3N5SVRwK0Q4MGx0aSs0R1FEN2U1eFl4dzNpQTN6?=
 =?utf-8?B?THNPYm1rZDB0NTFlR2VJd1BrZ3VBa3lXVFZ6bFBZbnRneWJHUTZZOHhpaklK?=
 =?utf-8?B?YTVuelo3My9JckRSeWkxTG93MWNFNjVtaHZqc2tXQXl4UVRRd3QrdG5HVzRO?=
 =?utf-8?B?SmlaR3RxMlBhZXUwWC9IMFA4STZqRHcwUWhsSlVKeXFyc0RQME1nYmNidzc0?=
 =?utf-8?B?YUo4cEM4eTNCWnkveHE0YnI3N25FblhsZXlNdkpyRVBaQ2xSSmpjWUtocDl5?=
 =?utf-8?B?V0RldTlaRTJ6TTZTbmFrb2ZKTTN2ZjhzZkZONlRzajBNV1NaeXkzMnliQk8v?=
 =?utf-8?B?MzM2SUt4ZWRqYWtLTjBLZWk5VDdENmhic0hLMEk3R05IWEI4eHd0empac0NF?=
 =?utf-8?B?UW1KZ0JLamhkOVJ1YUl4VXdtQS9weHRtV3MxZU5QdElGOE51NTNadFZldGhJ?=
 =?utf-8?B?Y0FScTNrU3dOWjNhYk95RjFwOHZQV3RUQmY3STIzemJ0eGd3dVVFaTZkK1FP?=
 =?utf-8?B?KzRRMit2V0twOWV0OWw1K2k1TWNyZFBITjN4ejM0Mm53eFNGV3R4ZUFUcHRJ?=
 =?utf-8?B?Nk84TUlFY1VtVy9CcndUN3BYSXNiM1dmRXdIOUF4ZUFqSm0rdWJON1I1dVdS?=
 =?utf-8?B?R0x2bjd0NWYxYnNYdno3RzZOcG4wNUx6RHFtM2NzSW9SY09iTVdXT3lYY0NQ?=
 =?utf-8?B?cGdLemc3RkxXY1ZxZnFKSTNBU1BWTlBNYXI4dHFjQjFpYzM4cFhFZ2Z5YWJT?=
 =?utf-8?B?cVF0Vk1RNGcxa1VKLzlkS1FqbnRacnRNcFp2c0l5ZmVuM1BNTzR2c25LSTEx?=
 =?utf-8?B?eDBwRlhvYnIvQmdLbnQxdDd5MkZYRkFDWDJLOHpqUm04K0hWa2xmMHFBVWFF?=
 =?utf-8?B?dFZqem8zRE9paDBZemU1bmYrQklmNk96M05WbUdzNHNMZlJPU1RMeGIwbnkw?=
 =?utf-8?B?bkh3SWRTUTA4U2M1VnM4WjB1QS9lNW9tRXZOL2RJeGlVcHI1cjNDVysrV0Nx?=
 =?utf-8?B?MmcvRk9BbjVTM1N6c1dPMFVqbXNURlhTYm8vTlFhelJmQlpzWTJZMUN6QVp6?=
 =?utf-8?B?dk8rUUkyL1dVdWlqN1Qxb0dlbXhBYk9ka2FaRjA2ZmlsUXpCdFM2Q1doNlRi?=
 =?utf-8?B?dE1lQm9qeUJmclcyTXQ4SUxtN0M2VmdkY3NuNHdyMlhEMm9lTVdDYnVLRkxp?=
 =?utf-8?B?a3RHSDVsb3JJOTUxS0oyK1Q3MjVSK0FwWXl3Y1k5c2w5N1N5TVVQRmFtQVVk?=
 =?utf-8?B?ak9qcFlWckV3UEUySUxNU2F5NE9rTnpDVjZ3RGcyWEFaN296ZEg4c3hiNGdu?=
 =?utf-8?B?Y3pzZjRpVXRvQy9LVmx0cFBpRVhYVVJBZHU3U00ySWI3bmRRZ3Z6L2I5OU1N?=
 =?utf-8?B?V3kxTlAxbnUrODNGQUVjY2FXNGpHTFAwUUJEdnJBVVBldzFGVzEzSmtwVytV?=
 =?utf-8?B?bDMybjlPeEtudm9WOHRBMm04NlRZbTQ4YUJqQ0ZncmFlVzQ3bVJXWlBxTEpQ?=
 =?utf-8?B?Wk9pVzNmR3BQVS9JUS9tY2V4dUpFNHhVUFJBT1RSLzFRQ0hHMTdNVmQvRmlt?=
 =?utf-8?B?VU5Uelhoay9lZWIvcGJxa25iOUcxU2dCeFRrdng4dWhjOVk4TFFFeTJRek5w?=
 =?utf-8?B?aWtKYmF6QUdORFUwMGYyeCt2RURMNEJRdWdzQS9wRWFhdVgxQzRWdz09?=
X-Exchange-RoutingPolicyChecked: opUc+SkqdSSF+2qrkUtXkhtvTSfA9y3noL2CsKx5r7KbkCW45iJqpFBDFS/CyCOVPs1vbTVegob7URiPq5PitBjfUyfLMezMYDlZ2/uSAo58/LKvZpwePOL4XZB5D5ngVPgwp7G3JAIcWCM2JF7L5fYoDZ04fiDU7Tlz5niYn+fVd9yohmIY5PQdLcGpDEXTayUvMDKbtRWZbzxndL9WCg1Rv6LIamuOlOW5nL9R+9OnyW1MkofqNCbMPA57vCe2/EmsPNaO1eBUXIwWZBRt+sfJk7DKAyArCfV5Wx0wh/zSBO8Q04FqEzBboU/0pe0HdbiWCWqsFLInglBBuwT2kA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UyUJ63SOID9Eruajdj11PXF7qVMFqCZ9vOLGiBt54EVst0rBJgWcjSIMDJbAAsXhA6PJ9kdO3voLdzD0FCElBS1FgXAcjrfhcnD48VxU5ddI+HBJsnlTFclBBlf2VJAZuQlorJ1IGR03rL2kMpC9I9vjSK55iA++Ap6VxC78sC1t0glpKVWuPfYnCLP3xNJnCx903LqePwkbcbIJ6r/T+ANBNW9pDzquKYJHtqueBUPU3abJ8Ijqp1YD+L0pQV39bEMmn2ugGXgEUjoZGCmlPndjhZAjBn+p8+Udp47D26p5WVp3X9bgXpaR6mIOHdjbJnm551epzOYG9t3V1UpQHeZLmoYiinxYEVDVENCiXJ+WJa3gK8m7bjRmRlBz1cqogPJtI9vzgCpvyvaB7v1ngU3mh/xZsk7yy4K1491q2A/ajLW1E5d3jImVqSwc49auJDEXn+qat63FYEXaVT+5F0fvb6Gm6vKGozrp+IaWDeyXDPR4cpzhU8Cul45rvjO0ILJtGeLqmnSay8wymTVNO/wt6/Z+mvmX2+cnDnd3MK/hLPlcjw8xaJAUrOtIch2rOZYzFzIiCeuSAJ5W9EXzxSZ8KpsDUadrB1ULu6SfBJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4aa26dc-fec7-4ef5-8e11-08dec158070b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:08:15.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Kt5BU2cNCZAB0s3KytaoX4SalM+zcBE/+Qlg8tmr8mda0WBawPeRvOU1BxH8n5YU7jWCmupierLIgHF+3mB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606030096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NiBTYWx0ZWRfX1OWGjfxiXEbH
 L+1u3oReBoSVqdxII+8w7QfG8zWu9/Q3vJVoiVEcimILpjEQd0Szs/IMtRUcKSrcB1xubnUSXBy
 7Y6y0Gqh/jHfXTIR5DbOb5ut2fRGpg5SnEG37frVR+PBKljqcUbqSRPldY4FVGDs/7gjYwF8lTx
 3X1+2dCL+kOBNf76vRiOmLjXlF5KbSJ8Pw/YkyvgqWLIUnG+9pL5hmk+QbkYVaM1dLOtGt8ZojQ
 LOPp22yE3V/b6ERYm3ROwMnJ3U9UqSoEnQKOGJ+QrddUMsuCT/fe6KRaWWi7nNtPBpU2QJNSNbq
 EFEaneE7rfaNuTnqQY+hAkA1YVf31nnm73uKRX3Wmg2yDvLp0D4QfFBJGTWGbBg+4AbtnubjObJ
 5n/wzfWE+1QRnqkF0kMgz47XWwDMluc4CvvXNM7fHKlL1ZTOKyzx4xCc5z5WcyQe4btMicDVprv
 EKngElDqJcu/p8liVowtwe6AElM54mbamytAoO18=
X-Proofpoint-GUID: 8sDA1AjiG2k0nfi9L6im11gXvqJRKEmW
X-Proofpoint-ORIG-GUID: 8sDA1AjiG2k0nfi9L6im11gXvqJRKEmW
X-Authority-Analysis: v=2.4 cv=Po+jqQM3 c=1 sm=1 tr=0 ts=6a1ffd13 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=NOcJJj70ay1y3R7sccAA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_110840_459760_A4C10DB2 
X-CRM114-Status: GOOD (  12.43  )
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

On 02/06/2026 17:18, John Garry wrote:
> 
>> I say we can ignore the sparse warning, or we
>> can rewrite this to avoid the check_shl_overflow entirely.
> 

FWIW, adding a separate function keeps sparse happy for me:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea837b94d3e5..3ec98038668e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2364,6 +2364,11 @@ static int nvme_query_fdp_info(struct nvme_ns 
*ns, struct nvme_ns_info *info)
  	return ret;
  }

+static bool nvme_valid_ds(u64 nsze, signed int shift, u64 *capacity)
+{
+	return check_shl_overflow(nsze, shift, capacity);
+}
+
  static int nvme_update_ns_info_block(struct nvme_ns *ns,
  		struct nvme_ns_info *info)
  {
@@ -2407,10 +2412,8 @@ static int nvme_update_ns_info_block(struct 
nvme_ns *ns,
  			goto out;
  	}

-	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
-	    check_shl_overflow(le64_to_cpu(id->nsze),
-			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
-			       &capacity)) {
+	if (nvme_valid_ds(le64_to_cpu(id->nsze),
+		id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
  		dev_warn_once(ns->ctrl->device,
  			"invalid LBA data size %u, skipping namespace\n",
  			id->lbaf[lbaf].ds);


