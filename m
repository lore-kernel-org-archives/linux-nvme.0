Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA3C44512
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:From:References:Cc:To:Subject:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2CA+gpEHZdSApZTwZo0UJa1c0rJ5o9ZrH4bg86P/HY=; b=3z9MjxL8QqMBWlFVYghtyNAlrC
	a1ra1w0bMaNTKGgxCiKuDl1t0Dyzl+RfA2pCCliisHlOSsCqaC7m5eimtizCR2U6qGQRTOhW4P1az
	1+vhCfXWFjT/kI3+mdAwsfG5+ybK46ObZ1CPth1IKyz4Ahv4pyIWkN+kdduFsC55aabs1S9lWH0aj
	Wzh4o9LH8UCwxab+Fmte3+tFdHAEWaKiJj3CK5Su/zqgXLStohv1cPqshimpI8cyPjdKXp+CAYjf9
	9NPAtGJ0OPvVtSTK7FwIpQmiW+KcRQiUKVVyUOOWQ4gpoP+Wb+oY8IMNzhXnktTsbmMvP0EQUJYhX
	pMyH2UBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkP32-00000000B0E-3CBs;
	Thu, 16 Jul 2026 16:34:56 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkP2z-00000000AzX-2hgr
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 16:34:55 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GFLl08843269;
	Thu, 16 Jul 2026 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W2CA+gpEHZdSApZTwZo0UJa1c0rJ5o9ZrH4bg86P/HY=; b=
	XzJc5J7yLecG0DZduFeTV9R/DfVIm/Fc1JBYYPejhIhEPjBjgXtiyu7c5od8388M
	fISMbAxrV85dUTpG6b8iFBwBAITWnCZmImu568TbQch+RnGo0INY7yBZ8qkSRllz
	IUPIHNfl2dWl7zIDP977E8qsy0KxFcFO6zMVQ5JyNK63/HlA2lliY4OETyhKRWk3
	gDQoh1mWwkwcoXwqdhGF05pmAKCOWXkE1O0slh2oeWEPruwtPW+bIK6OaM5lVTP/
	QK8GHIE7NZ60E/Zw6cn5AbydovJnicVjNQt0MqBF+v4LPahxAp0mR1Uck7Iujcjq
	GrYVn7SlwZSSxIlwRbC0NQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep39196-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 16:34:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66GGYa0C021589;
	Thu, 16 Jul 2026 16:34:39 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fdmhc7p29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 16:34:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb4+7WBmgp5ERQGDNCYW7qdrFYZ/lqa9wfwlMRaIMozDY+ogY86IjEe9QHBBG+FJ4Hjnz3OxrKzeKORVYY8WD3B/UteZrO5LYEev+++wP1xInRpn5nIBH1VxPqedWh5fcBcUvjiPgRf5JMsOQj7aEuR5PnBcF7ZTpJksWHRQOQ6dmiCq0q1cgp4QtKakH8gi1DgSG9OM+hT+e2x8TCzhdr9473jiRgHZG1718PnFhmmZ4IuHHsAzfjr6zPVBV3dxYhzNNyDqezW2+NpBHD4ptURCx6tYzJYTVoNSRlGIAwXrR5XShQVb8JOWIplm1YUqaILPinwwJwA51PRZDcAe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl0wXm3ddhgLP8yL2eFQxJ//4Q9+Mny+Wq9PwhSvi7M=;
 b=ZszuwkOAdzi1Efv1XfrBHggCC/fTILuxyYPaNPTlOQW12iocrNeEnvBs/Rc6Hny6o2CXj17O1xP0GrtiW/Z0gou+LcZOXq2NckjmQvzkJNArUFO+q/Yx2KqPC1pYLfjISU2Xp7HvKbfUGqq2ZzKOz8UJNrn0AGoLlLCDurZUh8L/Ra3ZRF9nXbJ1yuqAnC2JoxjesUp69WsDZG3Yum3UVP4nqMdSy/9t4hFNYN2NGdgoPRWwOWnjWn0qCSv7cdBgQNsDy/S0LqbOcxEXKF9bwXC6pTNVAO+I56yWspOkLdg8XIAkia5ABTtx7iUoBZPwWDG0O8a8sSIKrAGEeu/mWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl0wXm3ddhgLP8yL2eFQxJ//4Q9+Mny+Wq9PwhSvi7M=;
 b=osSHVBir1Uq/59kjfzVPU0PUyFe0mLYLFTDDM65BcSCI1TVBWjQMiRw9MlOVDHOtxtWezGUhSi1KtkgujBy1J3d4is78FIsUFxf5CnpJS3bOMwuTcb8O5wPwjOS7iWYPacERaMXknkw/OHrtt/VxQiwS+2tWoaSBQSetu+T0Y7U=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DSWPR10MB997911.namprd10.prod.outlook.com (2603:10b6:8:3b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 16:33:55 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 16:33:55 +0000
Message-ID: <d00a2702-4713-4f29-a7ee-7eff52aa5c23@oracle.com>
Date: Thu, 16 Jul 2026 17:33:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: fix cdev lifetime
To: Nilay Shroff <nilay@linux.ibm.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
 <20260713104238.3034640-3-john.g.garry@oracle.com>
 <01c56065-b785-4cc6-87b7-47a0078ebc67@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <01c56065-b785-4cc6-87b7-47a0078ebc67@linux.ibm.com>
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DSWPR10MB997911:EE_
X-MS-Office365-Filtering-Correlation-Id: b13ae2af-0816-4576-0c55-08dee358072c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|5023799004|4143699003|10067099003|56012099006|4133799003;
X-Microsoft-Antispam-Message-Info: rIk9nG+mRWzMdAvL5DjCYJJgl8UBSOmylrbO2f9d4nGjtiqZGE7IX9M130nzjAPMRPe7fkb+PsuyDfXYI7q5xZA7KHIniMxp9+vZCsHdR7YZ9r+MIKqFybrvrShBi7clh0mJchxXL9uusgwHxGxM6faDyC1urQkHaNFl6ZPIb7r8+QloIhfNb6BM1PA1WPwmp7bG0TtY0HA+9n+JV713Nr88JU5A2OPE1AvlCd3ZKDeHODPwhitDEuto4goVd+eW/Rz6U51rQqAnV0C1WxHNTw4B9Fa5cYBIZ5HTjIRx1tDX+cfSmtR5ZksnVKuPrI0iWxCO1fw8BFA4PrGvIgyQDXkRE2mNLk7i2G2o9K7syiM16sBura2SgRAQlklkhYhmzFPVavsva0QyqUlnD7uH/btr+rW3S+CRt4YkMhCcSuVUa/Ci1QISdH9pMQAJwHFK4AqTWsKUMTj8Aq16v8ZKMmSdBZ1K+NBllGVcLpSUa57d4kb+y3+qHVYGDha77CJkG+Nf7uTo69NcKa2UxSPgGwfyoGTyCqEaN0Z/1B6l6pOGu57A9AXnyMPglIL/gDmXUe+nlBMEi4fSFshSzJjkjHS1piPm0PUnxJxzPKlUFhLhjiGEY1lb6sxqaHuQVCkE3duEV9EGmSjp/XWAWIZuKs6s1GBt/bUgMdO10Y6QHj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(4143699003)(10067099003)(56012099006)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdwbDEyTi9JSzAvbnhoYkZlTzl4MW5xT1k1dlpqdWdpa01Lb1dmd2NLamhj?=
 =?utf-8?B?TEJMMkFobjVURWI4d2hpZGNuMHJ6ZkpnSi9ueEVFcHM3OVA4ZmhvNDcvWjhS?=
 =?utf-8?B?MGhlN3oxcHlHOEJUMVgyamxGMEMvM0h4blV5aUYvTTBPTndodzg2NUFSektN?=
 =?utf-8?B?bzIwcUw5cDBFbFVNTHdvMHY1UUJuTlA5UlBBeXByZ1poR0JMNmVSYy9hVHl0?=
 =?utf-8?B?aDJlREluZWpvZEJwc0paNTRvYmIvSnhzYnpRampaeVpFQ3B5eEJrejRVMFpU?=
 =?utf-8?B?VWNGTmV3U3BwREtxbFdDamYvQ3lzMm5TSTdiUDBSSUhnd0FlaTQ2d2laQi8z?=
 =?utf-8?B?Qk5MNHdiTkNTaVVWY3AvSHMweDY3aTRCcDFtK0FuNkx5MkdTbjVMQ3VGTVdK?=
 =?utf-8?B?b2ZuWmR3QytZOHJJV0JGN0xGZXRzN0NCbTVGd0JabTR3Y1NvODBWYWVZU0t1?=
 =?utf-8?B?V1oxVmRRbUQrKzlkd2dVckt1Mi92eXJ4ZDdTa0xiY2tKWERJUlYrNWFzTEI1?=
 =?utf-8?B?MTU4UUpISUtlajY4a0FMUHJxbDhNS3psMzdxbzA0ZGZxYVA1OVpZaU4rL3RY?=
 =?utf-8?B?RFFuTVVEYlB1bmdDYnNZL1l1QXF3ZUxOWUFTc01EZnRmUlQreDFNWG9HQ0JD?=
 =?utf-8?B?bXo1MExVNXZaODMwMklYaFp6S09jQXlpR1lGemx6NzBOSXBNVFN1WDRsNFJ0?=
 =?utf-8?B?WGdSU0hTcjRicEJwajcrb0JNcGxsd1BKNGErNi9zWVJTbnkxRmthaGpXMzBl?=
 =?utf-8?B?OU1NN2t6dkZNai9nVWxUMHFEZzYvZmZJTzZGUXdtOFowWG9wUmM4NUkyTWFU?=
 =?utf-8?B?VXF3Vm5wSjdvemVhSnplZU1PWHNISnlDaWJBMUJyMXRQZTJYMEk0K3JZZGx3?=
 =?utf-8?B?SXVtRkNkc2NyRmsxZjZOOWJoaWhXaUw1RG9uT1JoRmNMWEpXcHpQaU0vbWt6?=
 =?utf-8?B?aFFxZWtJVUhxZGN4V2grRDhPNTREM2xIZzBjTzFJZ0FFY1NBck9WUlJrVnpi?=
 =?utf-8?B?UEZKN2JtemJsMWlyNVF0VWR2aXRJOEhiOU5WUWlDcFVZQnFidDlZVTRPR0tE?=
 =?utf-8?B?d052Um8vN2dRbWYwLzV0RjZSUVdYWUNIT2xYakhSMGJLbCtFQnlpR0FPak03?=
 =?utf-8?B?UElZRyt3eHcxdXg4VmQ1UjgxSUpTSW16a2REMGFCMWZJa3BGaFdlaks4SnVF?=
 =?utf-8?B?anpzNWRrczV1RCtGZ202WnR3dVdIQUsyMlBPRVhiSGk0dm8reW8xNk1jYXBa?=
 =?utf-8?B?eDZRczRsWk51VDY4NGJ2aW0wSUtwZXRUbm9FODhXbGgwRUFiTmtKaDFXUklm?=
 =?utf-8?B?WW1mazBUZ2htQkhZWG1FckNUWVVhMytlMXZxWlBqSWdQSC9qWHNOYWErT3Yz?=
 =?utf-8?B?Vlh2T3JzcWdMYWd3WUpEcitmVFp5azZsNlZlaExmMlFBK2V3bWNLRk5QTlow?=
 =?utf-8?B?L1VuVThINjE5R0h2Uk1uRGlGam43c1ArMXoxQnRYQS9WMVZjdU5JTFJ0WVlv?=
 =?utf-8?B?by9qNU5vYTFRSUlYRnlsR2hDYXkybHlHeWJFcGREV0VKQ3ZJUnNNWVFVOEtx?=
 =?utf-8?B?bnJTZE9Ob2RlQTBBNHQrMWh4elRxYUZKazVKOXgvTnQ5STkvdis1M2ZlekdQ?=
 =?utf-8?B?bE5UekkwUGtGb1lrU1FIaXZkWHFOaW5xVVNnb29GOHRPNUlzK0RQZ09rNUR5?=
 =?utf-8?B?U2lHWFRNMEV6QTlMbDVjZXRnL3VoZDBJTmF3TGF6TU9sc1NKWjJoSjZMT3lp?=
 =?utf-8?B?N0RTOHRPeElWYjBmaFMvV3d5YVBoUm9yTkRTUGY2NzRxNmJPTU43bXpyZlVO?=
 =?utf-8?B?TW9ER2tkSmk2NGFmUkt5WUYwK0E0d0dkdlkzWEJ1bnp1ZUE5bGs2RU93UTYz?=
 =?utf-8?B?QzJPbDZyVVZ5WVU3b0h5WUhuWXFXbVdHdGFpSU9VSUV1SlNPMHdwZytHaVIr?=
 =?utf-8?B?NXdCd3NXd25lb3dKVVZCczFXU2RSdjEzNUpva3VJSTk4eG9Wcm4rZFgxZENP?=
 =?utf-8?B?TlhtbXVXaHcwamVRcHZvWDBQQXczSmlBMHM2SEtQM2ZOamM0Qnd1WklWWFR2?=
 =?utf-8?B?K2ZIUUs0bi9rYm1vaVRlaFVDelF1eE1vWTJjNGJtRnBTdk9TaVd3KzFXS0xG?=
 =?utf-8?B?T3dwSWFVdzhNMDVpcFhvdFFxMDFic3pUdk9LSTlBaTM0Qkhrdmt0RU5Sb1p4?=
 =?utf-8?B?a0Q4bldkTmc1OGJIbThvT1d3N3JRRzgreXdNOC91WFluZXNTa1c2dURJc0Rz?=
 =?utf-8?B?YmNYRkdVelVMTHNpbEMrWmZmOUxvdU15bXdGeU52aHorTlpQSjJSOWJFUHhC?=
 =?utf-8?B?R1RDYTBLNFV2VEQ3eWlwN1lxZ292NTk3OFM5YmgrRDdPZDdnNStDYlJaZFB1?=
 =?utf-8?Q?oF6WHjB7HU5snqiE=3D?=
X-Exchange-RoutingPolicyChecked: XBT0ZDIDyv5y3LzxttzowH50ilWLHJtbWatSDVdI3mDrM0WlUhor7oXQiR5IY4fwcMBViEDXiFafoFoa2ww4xFNIOgx7YI4kXFn9vXmMKTL2XsnkwGfIQuaap612QcXDfvKexrDBpet+yVNsPOL8c6JZYdxVJkCgA/qUKy27X3Dv6WvRQqyFPUCxnMG4cWEgjZA9SObrW6c0/0PceAH4a2IBYMZRUhEMu7CkAp5M5WMkEYiPpQlCwJj+jmwVmhLYtc1kruXUwUJHPW0/urok+yhSnoBUjWM5ebqWQ5N4+SNyVEoAqSHFqbEScpnb1LQBiJYrvpsdFT1f9HwTb3enxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PWzdizFQrN9QG8eog9S9QZFINelu/4cIRVPJ5yqxTT6l/wzvum3hoZeEWPTyk8jtkyKJai5580zBPrelsjR2gCQAVjCfa1bjFaSZAP47bJdo7l8B8re52idxlm+jeX2u7J0qg/9aJyZ2x7CpzYIk7J/+Py1d7wbYPkMH+HwzNFP1gkGgHroBt1NrwJhVlKzkWZcOZ5o4KqxNbaepiEpyrW80SxVftj+2CxmumBhjNT9Y4CHKUBRY8TWMGytShH3n+pBxwX8F3lRFnD9xS+cAdDr357kbPSI6eplIkkicxq22B3pXQ2nue+sE1Yr/irWJ6gBIgw0yUhixjv74ysk9JemOYHcMCOs18gGdW7YvDXSsUraJDogthiKPYRse86v9rVdQwStkj8OMbJ200zNRb6A9j1RTjQ0v8ysSmsznzo+wuD/P8Pa61N8Rxpg5IjGwU5LZxfbLFc2NaNoK2tkD1Jj/dR3HK4sjlJZrG8x9Zl1fAJ8DAkAEwTOHtKP+64ZEdAMY2okfej8taRNX/9u5dV2hnIYpJmk9y94ogY17JBvfhzTZhN1oTx79x3RVbbRBRAegyBmEPe76r6XZO1VYy5C0f2edNjLI1XvGJhEIjDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13ae2af-0816-4576-0c55-08dee358072c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 16:33:55.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yY4VyPfLE3JrTM19gtqKk14NRP8iR4U99Lm9DtYSMfSiKpXTz3Wqdh6zYkoTOhfKqn9K9+K+ugZ8RI4F8ZJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=660 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607160170
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: irQ9RejD4wOY5OokD5HU1ifeO6iGUN2E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2OSBTYWx0ZWRfXwHWS4cBZi0/X
 D5Duwj4F/NwKcPKoCgS/YSrsMKSIv/LinZcca8znoXb5jdq1cOduA/pL/NBcfOdfqz5zUsYahY9
 f6iq16FiPcb0VqGzZ6H6YVdAu7tpipHFtxpLesTBJJRNZv9UqiIi
X-Proofpoint-ORIG-GUID: irQ9RejD4wOY5OokD5HU1ifeO6iGUN2E
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a590820 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=RpNjiQI2AAAA:8
 a=VnNF1IyMAAAA:8 a=LlYQg72hSJEtsmc9uGIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2OSBTYWx0ZWRfX0TnX8aOkxnPc
 7aipddwng6rzOzoN+fkKwdX5zxUnU2mp02XGkThWJJx3+IusYIRoFGh7u/T6/1GEYV9lmKlDDgW
 b4feOaxSZUciUpxXwK/UE9Cu99w67aPtgZPay/k8CcHCw8KlTy95jSRG6OByktLkrnjpX0cKqO4
 ObxMhOBgVZB/dIUfSeEz7/idJVfTxQgCY9LELptrVpdL22qfKB0tNvqMYfmfr3d8kT9vvg59/l/
 k/IBLfNaO940CcPBS8+eE9hRW1dQ+VOPsd2L2QxxDDVFem8qknw4JOJA8RPdAkmQTyP2KQ0mR9b
 c1hXHTQKjhxk61lBTcMD5JKRjfRe60FpJP6BVjFq8TwRybi8+zilxNIQS3Syazk9+AA20U79ts/
 2mG6PcGzfLmiOAiJxGkcCVBaAHGP4oyIP9LwEFxIkmEOD47bh2l5D5Iv48/UHir3j97I1LykAlq
 9UDYb1PvK/UZGAfrnukxLFv7qYkOLVLt7eS94Izk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_093453_800464_5A0871E5 
X-CRM114-Status: GOOD (  16.85  )
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

On 16/07/2026 16:03, Nilay Shroff wrote:
> On 7/13/26 4:=E2=80=8A12 PM, John Garry wrote: > Fix the lifetime for the=
 cdev by making
> adding the cdev add take a > reference to the NS head and drop that refer=
ence in
> the > nvme_ns_head.=E2=80=8Acdev_device release function. > > The same pr=
oblem
>=20
>=20
> On 7/13/26 4:12 PM, John Garry wrote:
>> Fix the lifetime for the cdev by making adding the cdev add take a
>> reference to the NS head and drop that reference in the
>> nvme_ns_head.cdev_device release function.
>>=20
>> The same problem exists for the NS cdev lifetime, so resolve that issue
>> through a similar method by taking a reference to the NS for the lifetime
>> of the cdev. Note that nvme_ns_chr_open() -> nvme_ns_open() also takes a
>> reference to the NS. Now that should not be needed, but that code is
>> common to bdev ioctl, so keep as is.
>=20
> The bdev ioctl uses nvme_ns_open() and nvme_ns_release(). So, IMO, you ma=
y also
> remove nvme_ns_chr_open() and nvme_ns_chr_release() methods.

nvme_ns_chr_open() and nvme_ns_chr_release() call nvme_ns_open() and=20
nvme_ns_relase(), respectively, and they do more than get and put a ref=20
to the NS - specifically they also check that they are not called for=20
multipath mode (as the NS bdev/cdev should be hidden) and take/put a=20
reference to the controller ops module. Why are those addition actions=20
not required for the cdev? Or should it be done when we add/del the cdev=20
(like in this patch)?

>=20
> Otherwise this looks good.
>=20
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
>=20

thanks

