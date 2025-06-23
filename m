Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19088C7EE31
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8ZorgwZEr9ltFSf4Y66QEr/PSwiHco0Ml38zYhuvpI=; b=pqWeixo4DZom9RdZxiQnsUpQnn
	f1+GpPKBUAX+j3A9vD97tLAi+UTgl424+/qx4Vw0+e34fT+qHXlKi3B1wtsKOPqxI3GslIrye1jN/
	nsIe4zvnc0JBXVangnk4txN5pY6dnmEySbIXLn9ew1aBQ1d1hfboYZGt0c0WEiZWhpG8zgX2BKh/e
	xrx6JE8ujS/lH1ufDbtbPpTdl7gRh+NzWmkZoNodmR+6HoHAFuijBc5fFOc+tMpdwB82FbwCfB7CR
	evycdp8rllLVHJZUhhCC/8uairRryiLYk6YC1Mxx0c4iE3F6TN5eAsan6udLic6xR1hnwNdK3jD1y
	axGQuxLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uToxP-0000000421B-0iXM;
	Mon, 23 Jun 2025 21:44:03 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTkuu-00000003YQQ-2AS6
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 17:25:14 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGXxSr001658;
	Mon, 23 Jun 2025 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z8ZorgwZEr9ltFSf4Y66QEr/PSwiHco0Ml38zYhuvpI=; b=
	iOlPZLblwsDmN+H4ncO8fJXqkq48KNNsmj+fPvr6uLa/PEvFNbBIOZDsmqoYwTfa
	cV9NVaChXX7PbGRgETb3biLgRsGEj7OfVj8ETbX4gg099q0N63JnbZaM8Q1qq95/
	Y2aULLdDHdFG0svxIlUpZsb+YIfCZLb6YzblLjYiZp7LCs7Wn2TFHTMS2PlmQDg+
	jW4BcFrangc+cHH5ZFzBwdzkCs3PZlkqpJeVXNNGIGO25zIOdIcgN3+tFD34UYtm
	LtVmoR9S5Lx6PhaA+NPXsRdw6UHAuxFDSNAJQoOx2axVp/ZmpkNYEsN1y/hzCCBy
	oR5n9zd5msweQHvlssNESQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uu8jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 17:24:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGeoqD030685;
	Mon, 23 Jun 2025 17:24:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012039.outbound.protection.outlook.com [40.93.200.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpp4ek4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 17:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeN7vDDvY3MqjLu0rm7fh90t3e040ctsxwD1vUFWcGO84l6kWSj/LXegFdc6HXl23K1YnQp0iGP07N8g+DUep22287eBMYwHCJ5WH4ICa+95W/vvKcBNIKdG1JYfCYcIhqZGUTE42eX2+vFG8ioe4R7fbLd1VmlBBvZfSgKJpWjPFD1S5Bh2FgGt7hb+pnC5gBDlOOo/VGhEFy3Dbf1CwqqOZHppx5dnw8ORP4RjO2CCg93+b1QPiuHcJvK6x+dKch05fMSMN1mWunXyYy0wBeYNJjkzuUdHV7yXSHvxySMBKcpJZzDNFRTHsAcAaWwrC2Cxf3uXFel+zrZeYHJyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8ZorgwZEr9ltFSf4Y66QEr/PSwiHco0Ml38zYhuvpI=;
 b=EwAbEmDwtHpWn5Rh2sd421lIEyKA9A9m4DfDFbpQun+A7/0s4YE35W4F41Ma2Fw52w7JFOn07On1v7US7c95a8IK5ZkbqAvDQxACehSgM2ZNQtUu2ejKSibdw1XXYPc/2KiYByGtBdCOBKXHDoyzaxLJqSKUpQVdGsy6zKP9uXTkcjJ3CtM04fIXhqmhCCDI2c+ycEeO78BG6C6CXYa49eBDgb66iPDOK+/hmPr69C97ZcaX5SPDsgRtpE9KJsf1mcxMKq2WD2u/PveTVRIWK5CvXo+lkjg9NuIq0Ne9KjF3yAs7cwg/mWpz6lmm/iEYoGz2v/S2tNO8VVDIBxL5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8ZorgwZEr9ltFSf4Y66QEr/PSwiHco0Ml38zYhuvpI=;
 b=B1lxisdrMKVlOKRnHneJc/o7HjT6w8Fe6meNP6DQnUfpSP2e/d2a2DsSp/iStK6fC+O1RXcPtrLjPIjStnAh43FxC1GLb9kiXoaLjsUGEdZyXxbJULfyA075smd9BM757A/WqISPYqky59YZm3lr7SEDQ63lWbhlRaIpGnkYfyk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 17:24:55 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 17:24:55 +0000
Message-ID: <1802de7c-1f2b-4c84-9f99-a38625c3715f@oracle.com>
Date: Mon, 23 Jun 2025 10:24:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
 <20250616053627.GF1148@lst.de>
 <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
 <20250618053213.GA28614@lst.de>
 <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com>
 <20250618171750.GA29321@lst.de>
 <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com>
 <20250623133309.GA27241@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250623133309.GA27241@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:256::17) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 851b962e-5301-41ff-a641-08ddb27ade9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2h2d00wa3dsd1FRbEZUNzY1K29pTHc4bjl6SFdlSkZlSjBzd0QxMnZ3ZVYx?=
 =?utf-8?B?NHRYclNhaUlFeFVyb1ZYbHlBWnNRMkR1aVE0dE9HY3crV0dpK1NKY3BkZXlk?=
 =?utf-8?B?MFdFN0NDOHB0amVJQW9UZTUybGNxem0zME9Tc3FKL0xNSWZ4ZWFrVllpSzRU?=
 =?utf-8?B?SmZUbHpPTDlCYnpQVEJhS2tXRnJpYm1YVDVoWGFOei8yVEtndkdTRXd2ZFBT?=
 =?utf-8?B?TEZUZC8wR1ZWNHBXeGo5NzZoSDhqKzBVMm05SHcxVUhKOTFGYVZsQWpiaXlX?=
 =?utf-8?B?SkpGaUNoQlQ2WU1NT3VjbERXSHc4K0Q4SmgzQW5udjk0N3FlQU1ZVkNjb1Qz?=
 =?utf-8?B?U3pPWlcxS1I4akhFbDFza2xOaVZvT1NCbUI0UVVRc3ovK2FnT3pEMGVwWEdt?=
 =?utf-8?B?WWtqV08wd3JuSmhlTFBYam9yTlYydUtWeFovSHBJVEhOQ2Z3YTNUQjcyaERW?=
 =?utf-8?B?bG9JQ0pFaTE5N1V0bEt1YldjTVhBTWpJZk93SzRWRTI3Y3JKUVVwcVh5M3lM?=
 =?utf-8?B?WFpRc0hJeGR3YkYxOHBVUzVBTitneG0ySE9BaWRNamhsanNpT3kwUkRHdmpO?=
 =?utf-8?B?WHNoSzhMTXoraituZjZHMnFGYS9ueW94N0VNVG1JN3o0ZEtLRmNaNEdyYW1P?=
 =?utf-8?B?ZG9ONDY5Ym44dlBJcHdDZFdKQVAyb1ZySi9yeDFpbjMzbjIvY3ArK08xMi9y?=
 =?utf-8?B?eFJJUkJybVRyOXVjSUZkSUYxdkVTSGZUZlR3bE40UWkzU1Zkay8wWFJlM0hO?=
 =?utf-8?B?WkNLU0plbE1CUzJPbjdMZmVMM3IxSXQ0STNETE1WMmlHam84aThsUEFXOXZF?=
 =?utf-8?B?QjVtTFhRSmpsMmVkU0hIcTBHM1pBd0ptMXlhUlhxWXZlM1NyWHh4Q2hQdk5w?=
 =?utf-8?B?VHRqTGE5YjNOMzRqbWFzOExwMU9rWE9meHB6aWZQMDgyYlhkZnVGUkxmcUV2?=
 =?utf-8?B?bnc4Z243ZStydVR2VzVHNS81RVdzQlcvUXRqcG1BZXNhaTZaMFN6a0FEQnlk?=
 =?utf-8?B?ZTFtaTRwS0N6S1VsbzZaSUxTMUVqQ056VDh1SzVDZGM3UEFidy92Y2krZm9a?=
 =?utf-8?B?L3JLTCtlbHRKQStNb21xSEtJZ0VDZDh1UEtHcitnQWFvTGtrRUNqUTZPMmZS?=
 =?utf-8?B?MUdPZUFncXQ1TDJCQ09zWVljMXU4SDJObEg3QmFNVTJvZ0h3d3ZWS0ZjTFJR?=
 =?utf-8?B?cFhIWE85OTYyY2VXd0lDV0Q2RDF4ZzFmWUs4Z1AwZUZNUDBQR0NXSkVQZ0Q3?=
 =?utf-8?B?VHBnbHgzYmZMZEpEaXd2R3pUWWhuM09sVnREUkU3U2k3NnVPdjhRN1VOUlhP?=
 =?utf-8?B?dlJHQUtxb0NKNktXUEUvSUZmakttenJOc2I5SzNxNldZNjhObE0rc1ZQczdN?=
 =?utf-8?B?K2hLMnVzRDNwNzJkVmhQQUNWM1N5dDJDLzNiTXd3M3I1YmtxMnd0OHNCejAw?=
 =?utf-8?B?OTdSRWJNTHpOSmszUXZibit6VmYzUDJwYjltSXJaRXlWb0MzbFYxeWcvOGVT?=
 =?utf-8?B?Qm5neEtOMTd2YlV1ZWQ3QUpoMXdnTHlMSDVGZXZjcklUTlp5RHBXZldSaExQ?=
 =?utf-8?B?cVZwdjRkd1ozOEdkZ2w0cUhDeHd2ZThNa0N0OE44Q2dzV2JPMHVvN3luU2V5?=
 =?utf-8?B?WldGMzhlVE1oc2JSRnpXMmMyV2xlOEg1VHN0OXl5b0ZWeThxdHdBNDc2MHlT?=
 =?utf-8?B?bmZyWEZUU2hOQkg0NEg5MlcveEl5VDVFVU10Z3MrWGNyRDFUay95emptSU9E?=
 =?utf-8?B?enF2VGJUSi9sZlVQSFNQL20xRUowUkkrMzdrZzdRYXlGdmY3YzRPcUJOTm8v?=
 =?utf-8?B?NHJWMXZvS1dvUGJKRVdweTZ2R3V6djFISDgybTlxdHRFMVRzek4rYmQ1OFR5?=
 =?utf-8?B?cVFiUE1WUVFlS0NVVjlpcEVjYzJxZWUzaENGMlBBallZMXBrNXJoc2ZuRENs?=
 =?utf-8?Q?g6QAN3tJMiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDd5dGJWNWkwUTNaalVBb2pPazZCdGlnOW95NWF0QXg4aE1qcEtJR0s3YkVl?=
 =?utf-8?B?MFZjaWRZb0c2aDhJWFB0R0VsaUpTY0RTUDBhemdXYU5xNGhKakZtTFBKeDI3?=
 =?utf-8?B?Wlh0R1UzdU15OWFycE1wUlJzM2VIb203SVg3NmpSb0k2c0xPcUJaRndVc1Q2?=
 =?utf-8?B?ZFJIbjk5MDZaMFNZQi9zYnRaSHdyNlZUbGdHdmd4VHpMVVdxV1NMODFmaFBS?=
 =?utf-8?B?ODZ5MlhsN0dDUi90VnlQK1dRbHA5VHpLRzY3N2diZG5zUTlkYzNob2JWZEV2?=
 =?utf-8?B?WHhmckhXRWtELy85a0FOdTFtbnpIMGFUeXlWRkl4a0RGdXJ2T0szckV3RXg0?=
 =?utf-8?B?QWExcTVCSUZ2UHJUZFpFNS9DcW1CU3M2NW5xb3JJOE5CYXR5ZFg5NUR6dEQ4?=
 =?utf-8?B?WkNVUE9vZTV3SFoxTmp0T0x2WURsbXpQU1pIbDFJN3FWVlB1NVo3akp0dTl1?=
 =?utf-8?B?Uzk5Mnh4eVdmd0wvWWZNQ1ByUS9nWWFuMXZnbE1JTjFaeDF4WWRKTlpPYnc2?=
 =?utf-8?B?S2U4aHVCczVOZ2RrV1p5WXlMRStBUFRwR1FKSkZvYmJTK0c1a0tXcjE3Umk5?=
 =?utf-8?B?Q3NQR0E4YWhYcHcyK1FlTlU1Qk5uaVAwSndVKzJOWElVbk5rUk9uL2R1WHk4?=
 =?utf-8?B?QWc1Sm4yLzlZWG1GTStNSGZkbEhxOEZ4Y3BxZndOMkN0T1ljTmFmdXRSVUQw?=
 =?utf-8?B?UGtpZjE3WHdudXJDTXV4OGtjUE9mdFYzczFsd3BZOThGTDA1Qml3V2tGTEpX?=
 =?utf-8?B?WXNzNHgyMW9DMDFYRTZabGhESGgycXJhTnVibGxtNklKcnhKSzVIUkhBdklk?=
 =?utf-8?B?UUdFMDFGYlNxV0hCQktKeDFOOFh0ZnNBSCszenJEQ2tpRUNHdGtRR0JzNDg2?=
 =?utf-8?B?NzZ6ZUF1T3BxSlR3SjJQSVI1bzVhS2N5QVRidUJJSHgxbXJ3blFSQlFoL2JL?=
 =?utf-8?B?ZEpVL1BhUHhDTEl5WFBTYmp6VEpzVnQyY3N4aDVQQy9mckF0N0xoR0FsSmhi?=
 =?utf-8?B?RXdaRjE1MzhISzVDTHo3bDdTS0xCNlZjSmhCWVF4QWIxak1lK0Vkci81Tnhn?=
 =?utf-8?B?aEREaEo2dnhqU1ZjNkFmcUJJa2pwVCtuVkNWNWNIY1lQMFcxSEFLRWhsM0pr?=
 =?utf-8?B?WWdrTHd5OXMvUHRQcXhQVWVlQ0NyNmxyUzV5UndrOVVVT093NGJoN2c0ZGFy?=
 =?utf-8?B?KzZWS21tYWJpSTNLdEYxYlpUdFF6aUtpQ1o5bU93akdMcTlpWFlocWdvOW9P?=
 =?utf-8?B?OFpHbUw2aFM1ZlhhUVZaZGY1OW5xZ3ZPWkJrTXVEc3ZCMnIrdkZvL0xPKzZy?=
 =?utf-8?B?VXVzakYxc214TkZyQmorZE81aEZ2anZQWDdqSFQrQ21mLzVaYWNBQ3AzV0E4?=
 =?utf-8?B?ZXZESm96RkMwbVNkcEh2WWVmVm1iZWhtTE5NN3JWU1VSU0tNZHMwdTU2aHBm?=
 =?utf-8?B?YklHNlp5SGJzL0YybWZka1JBTlJGMHhhcUhDNVI3UldLVmhRTUhGREFodExl?=
 =?utf-8?B?aVl2ZVNiVkpUQm44MEYxSUUwM2djRE9LVGRJTmlSbHRCSW03NTB5V2lQaDFP?=
 =?utf-8?B?aGtWRGxDTnQrZzdMZjJnYWpMMlhnQXo3Z0NJZGpKMEZCTEdYWkFRU3Y5V3Zj?=
 =?utf-8?B?d1NqYndNRHp4bHdvSzVvQXNuRFZzV2ZzUEZHNUx1b1RiaGNvYUN5T0Rjb05S?=
 =?utf-8?B?L0JCQjYxR0lFTzJ1bk5ocHRvSXBnSmZZL0NhQ2ljOG5iWnNlN0JvKzZwbGFI?=
 =?utf-8?B?ZEljZmVIOVFOSlVmbk5MbDFTZHVMMXpJOUdLSVJDME5JVldzanp3bE5wL2l0?=
 =?utf-8?B?eDB4NlZIN2hsM1pkelI1alVSZ0ZIVVl4eERaMU5BeTY1TWtvek02L2dscGdx?=
 =?utf-8?B?TWZQOW5hUGl0U2ZscDVkc2ZGdTZxMFd4YjJ4U01aSkJ0RExQZDVaMjg2SDQ2?=
 =?utf-8?B?OTd4Ujhwdlg0ZVpzYVN3a2lmOU55eEFOc3lCNzlTRHhxVzF1N3BFYkloK3Y5?=
 =?utf-8?B?M0NpbmtselBQU0dpZjJDSms4dFd1NUd6OXkxa1cybkJLVUx0UVNRRTNqZFcr?=
 =?utf-8?B?WlNWMmQxMmxtKzFMcjF0ai9MZjJMdjFHN21nZWxkMk83NlFHcVdsZFlEUHB0?=
 =?utf-8?B?MlN0OElKV2VTMHZSVFpad092THQ2WGZaZlJyMHZtTWw3ZVFDKzBHdjZVbUd6?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V5cy8ARjPKuwPM8l8H6NffGcHKgFhYpfCEeYu+S+MkMdXWwrp67WjXuMMt8eAo9A4l3mGWvKZ8UF3Dh2ssEMkcImA6HF4NAuQz+OhTCM+q42aU1Y5ET3aT9G7eHV893o1/UQeo+U+NmvAZvuD+mIROZBtpXiXiGX+EbB0UrXEhlefU3dLFiSJE9ewWW8e7qaYsXvNzrWv3WwES6JqBsAOZP6m/2pBs8b7WvhHrNinvRgjJw37sQSEh3dP+iKNrGGCLj4dDAi0jTJweCEqMhlTDTZ2cQnPE3BK3Mtw83WciFCHAyOuPvdmOuUbe3z8xvc7d074PQqY3BnXLJG4MRIV3DPwg8wLJ1PwgBfgL5iYjwr2FDs8qNv2PmWdTBKbcyUyZTP6G3dWKMRPlv06Uu6VRZMwEdFfeO4VW7z864x25VOllOqKM4H9keDQsZc9ncUGE5uLKmLgI1mQYValMuPOZRfU4yNOWb514wJ5ncQc5bE0afp5TgDDZNJmwRQ8pNP2tHKtTpImayvOrnlAPkFuA6G1EBkjfSPsTaWl/zfKQslmWbS0ipdSkVLuQLOJr1HXeH4FYXAhXvq3A+E+HlSVoQ6HE0qwC5dBGt6A3ItQbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b962e-5301-41ff-a641-08ddb27ade9e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:24:54.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlBJD2f7bxcfibS/iIRUS4gKRNpjnimVp042bJCwVbWHaPP6xY80L+QBavlr9Xwi9oogGH/lqIA8Z3NrPjfQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230107
X-Proofpoint-GUID: IsykPDICOu4CwSS3B_E23trB-UKq9UGO
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=68598dea cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=asU8mKIqoIByY_6IgAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IsykPDICOu4CwSS3B_E23trB-UKq9UGO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwNyBTYWx0ZWRfXycZfkrWIChfG OVk+77HxIim5Pk+FJUkSTWCPk95vcI/Mr8X+k/+8bxfNROpMWK9YMP2lb+eITMbumai84ZFjmxd PldLoZKbh1gbnvVTtEuQlgXuQUxOqE7bMtImII1EClgKG4+WSpoZLQl74veb69VU3EJtX2B3fW/
 uYndNQCi01L+qmq8n5OVjHyjOv//N8akt2249o9j/AYXAjZBruhVzEJ8tKXUJwSxlc7XLOViU2s F+kYjoRySu3hnMOqvAeFjDge7nEe71hSjdc18K4+86HZFN61f3tlqsNcYzv59QAoKlcWY+uhZct CSCxIP6If141O2c1HfQ5Cwl2dJu5/91ETqWKRDXjsvtrB2un7Bq3PhaPcTQ9F0Y+em5GzklC+qi
 SzmqljaJc13zYbsDHn0U4P/7oO2klQK7cUv/qfS2DMGEEl6cO3/B+VUwoahssJcOLoGGeNAR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_102512_571916_7D2B303D 
X-CRM114-Status: GOOD (  20.22  )
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


On 6/23/25 6:33 AM, Christoph Hellwig wrote:
> On Wed, Jun 18, 2025 at 11:30:20AM -0700, alan.adamson@oracle.com wrote:
>>> Can you double check this really is your CTLR2?  At least for me
>>> the async probing reorders nvme devices quite a lot with qemu.
>>>
>> CTRL 0 (nvme0) - AWUN=31 AWUPF=15       nvme1n2
>> CTRL 1 (nvme1) - AWUN=31 AWUPF=31       nvme1n1
>> CTRL 2 (nvme2) - AWUN=15 AWUPF=7         nvme1n3
>> CTRL 3 (nvme3) - AWUN=15 AWUPF=15
> Do you mean AWUN or AWUPF?  Because AWUN is totally irrelevant and
> not even parsed by Linux.

The above configuration is the HW/QEMU configuration. Both AWUN and 
AWUPF are setup.

>
>> I rebooted and it probed differently.  Now CTRL2 is nvme1n3.  We know
>> CTRL2 is the same as nvme1n3 because awun and awupf from nvme id-ctrl
>> matches the qemu config (atomic.awun=15,atomic.awupf=7) for CTRL2 (nvme2).
>>
>> # nvme id-ctrl /dev/nvme1n3 | grep awun
>> awun      : 15
>> # nvme id-ctrl /dev/nvme1n3 | grep awupf
>> awupf     : 7
>> # cat /sys/block/nvme1n3/queue/atomic_write_max_bytes
>> 8192
> The code in nvme_configure_atomic_write calculates the values pretty
> much directly from (N)AWUPF, so I don't see how it would get things
> wrong.  Can you run your patched qemu setup with this debug printk
> patch?
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3da5ac71a9b0..245397b217f4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2033,6 +2033,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
>   		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
>   		if (id->nabspf)
>   			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +		dev_info(ns->ctrl->device, "NAWUPF: %u, atomic_bs: %u\n",
> +			le16_to_cpu(id->nabspf), atomic_bs);
>   	} else {
>   		/*
>   		 * Use the controller wide atomic write unit.  This sucks
> @@ -2042,6 +2044,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
>   		 * values for different controllers in the subsystem.
>   		 */
>   		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
> +		dev_info(ns->ctrl->device, "AWUPF: %u, atomic_bs: %u\n",
> +			ns->ctrl->subsys->awupf, atomic_bs);
>   	}
>   
>   	lim->atomic_write_hw_max = atomic_bs;

Here you go:

CTRL 0 (nvme0) - AWUN=31 AWUPF=15       nvme0n1
CTRL 1 (nvme1) - AWUN=31 AWUPF=31       nvme0n3
CTRL 2 (nvme2) - AWUN=15 AWUPF=7        nvme0n2
CTRL 3 (nvme3) - AWUN=15 AWUPF=15
     NS - NAWUN=31 NAWUPF=15                 nvme0n4
     NS - NAWUN=127 NAWUPF=63               nvme0n5


[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ctrl /dev/nvme0n2 | grep awupf
awupf     : 7
[root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ctrl /dev/nvme0n3 | grep awupf
awupf     : 31
[root@localhost ~]# cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n4 | grep nawupf
nawupf  : 15
[root@localhost ~]# cat /sys/block/nvme0n4/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n5 | grep nawupf
nawupf  : 63
[root@localhost ~]# cat /sys/block/nvme0n5/queue/atomic_write_max_bytes
32768
[root@localhost ~]#

[root@localhost ~]# dmesg | grep nvme | grep atomic_bs
[    2.831882] nvme nvme0: AWUPF: 15, atomic_bs: 8192
[    2.840480] nvme nvme2: AWUPF: 15, atomic_bs: 8192
[    2.842418] nvme nvme1: AWUPF: 15, atomic_bs: 8192
[    2.861119] nvme nvme3: NAWUPF: 0, atomic_bs: 8192
[    2.862427] nvme nvme3: NAWUPF: 0, atomic_bs: 32768
[root@localhost ~]#



