Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FDDC71157
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SGl5eZhBuoDoXE7syQkd0PpW2K7EVk6LZ8hRy3EEzn4=; b=gcY2yd7HnZw0t4/ZXX0KVapmgy
	iFsQmVw2Ezx039j2nvUAO8MPcfOy/1CqsUhIR+sY1tmtCrNu5HsJYknWPs30gfW1wBr/Qc7shVKN2
	w12PfO9+/Lsj9Afn7aw5if5cmWLhKCb1BDIDelEeQP1GzXMnN7ZAORZN+QeOurSvYA3yfbNY72LlJ
	DU3GFvNpoXZbJeBKyspQesisNw8wr/2KTwoVFvON7LrIsNpn6WhmEPWK7dMs1OqsA0UlA6vIV9YjZ
	VCaucjCz+oARJBcyNsGt56Wt9lRn9zt2qRabj+m+EDtafzT1joy6i6XTARIKfGYXXS+I5FzHOmpdt
	xnRq3IpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRyE7-0000000BBq0-4AYu;
	Wed, 18 Jun 2025 19:13:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRxYW-0000000B4lB-49qa
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 18:30:42 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHgNjQ022316;
	Wed, 18 Jun 2025 18:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SGl5eZhBuoDoXE7syQkd0PpW2K7EVk6LZ8hRy3EEzn4=; b=
	cA7oq6Zmn6XB7EBRPljyo6w/vUEJx//Zjv+BoWNjxNYB0abXaJgAJHlqlX+4uybK
	49dsvOPXhIXBIFJzUdLAMUKq44U0JrPn6nyQmhdPghHrYzDVLQceYTDpOgCvete0
	3b6aUueGA2a+9wsg35JldhJxGj9rgi6vfD5DEWnZ0A7+cpwKW1HiP9HxlnQKSAy8
	cXqIDqSUSueYMEL+fXqcS1y3iTbBO70+dXh4HU2R0ZrAcUBU8HvBgOtE4e70yXDC
	T7RyQLpmm6EDBEjCfT0hLGmOQBxx4y1LPqh2d9PwkTzsjkfnujjy5MHHJkZRtUeG
	aC3NQf6Lc2yORWL2jCt3OA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914erebw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 18:30:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IIMYsC035096;
	Wed, 18 Jun 2025 18:30:25 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yharudw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 18:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMlTTo1pDYI57WNf3eGrh5n1POz2wBb/ZheVOq7gCkTqa0aJ+WM6yJJ3cdEJzyT/VRDLEyZ/fUC3B5k2fggm+uS2dMAZrPigGekIucqWraQjGbAT8QTxUyWBc2KKnvbNOee/SUuPT7OonerGVij6krp+Iou/vRWYwd1VDsaASwQK2Nl5vgjKK+2w3h0VY/3YcpSnW+Ac9fCnvbCrf/wt7CDvzqsShXTFlJHwTyyXrC7tZBi5zW3WhGIPNN1ykIzdW9nkYSZqI1ms37cGpLZNyMDLm/qfiMdT2g7+iBdTvtg34jcQ0gdnPYGWiTRkj6+W1hRastyKp/D3eNEKww7i5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGl5eZhBuoDoXE7syQkd0PpW2K7EVk6LZ8hRy3EEzn4=;
 b=jgnw+VoPX29pgzRZb8c5q1d7XCqpePeba1Xfyg0zHd38Z50L4AP/KjLsUZGIuoqsKRAsqY/G1UFeKUvo6aE800HDC2pOqP5i9WdM8yPz79i4PfsanZXsBvTPrF6Z7gNUGbpboQ9pHYSI1n/0WtFe+bJ30xwe6y0LH1P8F5tKzisbv59DU04cF3UTj9ZfYObGJ+sMOOaQGuI9JBpWqBse82obSy0N2Qd060AgS31UjrWCmEloQDLK/Nt9RBL/ZPX1YZ2hNC29bz19HmFwuWO67BkRZIJI3zvLCwu5Lats5pkBR7wmjRsKI1/9XUl63ZdCyDlNqRcFnROwU1Bl0Vmvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGl5eZhBuoDoXE7syQkd0PpW2K7EVk6LZ8hRy3EEzn4=;
 b=WZjsk+WeC49HvzgaBYHEsqi0hzTSuOfcRQLYtcDiSWQJnV02ixtMLQ85GnxfGVXwRY3LXwqY/1mz0k4HtUGA4hbyeCCs90uS77gYLSLgzrCy440s/hjmh/D2gjCJk5ASsfpR8p2W4u/SaWDTDfVXoyoT9Zcmw65bQAnNNhEVIZI=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH3PPF654CF2C22.namprd10.prod.outlook.com (2603:10b6:518:1::7a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 18:30:22 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:30:22 +0000
Message-ID: <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com>
Date: Wed, 18 Jun 2025 11:30:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>
References: <20250611055432.2401372-1-hch@lst.de>
 <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
 <20250616053627.GF1148@lst.de>
 <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
 <20250618053213.GA28614@lst.de>
 <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com>
 <20250618171750.GA29321@lst.de>
Content-Language: en-US
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>
From: alan.adamson@oracle.com
In-Reply-To: <20250618171750.GA29321@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH3PPF654CF2C22:EE_
X-MS-Office365-Filtering-Correlation-Id: c1063859-8725-473d-3e20-08ddae962f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1pIN2tQT0VJOFVEQkk5VDhhYUNsTHpwcVF1UTY2SHlQYVBuYnBZVy9CWkFC?=
 =?utf-8?B?RmpLb3VXRW9pRFlreGxZU3NyamtHTVRLT1E5MktDbWd1N2VPZWlyMzJSN0Zz?=
 =?utf-8?B?RXVTdXNPeENiS21wWjl1dmFMMXpPRFZKdkcwYXlxNnIwYWYyZW12clhsbjJo?=
 =?utf-8?B?S1FqNTdzWkNXOXFZVGh5TzhwMVllbXd6UklkMEdzYStFZ08wT2ZQWDNORHA4?=
 =?utf-8?B?Z1VlTjFldll2WnF5bGVabStXVnYvOXJBNWJBV3VkZS9hL3lrTmdnSkErZ0sx?=
 =?utf-8?B?cW9JUUJhQTFXem1UWkIxc3k0SDl5K01hMmdoajY1YnI2TTFpZGR2NkhxODAv?=
 =?utf-8?B?YUd1S0xOeXlkd3BOajk3Z0hIMStjZytGVkpDQzJYYXRBcm91SVd4bkwvaGxZ?=
 =?utf-8?B?T2IyT0drS3lENjU1RVcwZ1RqelNMeXZxZ0NtdE1rT201T0JEZzliMTQ4aDVI?=
 =?utf-8?B?Rk9QT1JKYjMva2M0K2RjUklMU2ppTEM0VTZYa3lKdVZCdTFkc1o1SDIvZHBE?=
 =?utf-8?B?OHFIL1FVZVBKRGMrYzZ5Wlh6RStXSU1CTHp4d0V2MndSYUszaHgxR1BOQzNH?=
 =?utf-8?B?ZEpjTXBhZ29WMmh0WXYzcitQclRtQTJFRktqQmdlYXI1dDBIOHo3WGNHaXEz?=
 =?utf-8?B?VkRGbmxuUGEzRHc0UUJGQVB5cFpwcXh1cXJYbmxFY0QxZ0dvTVBRZTBsTDYw?=
 =?utf-8?B?OVorWHRqU3NtZlpXN0xPWUo3Q2ZraGJ1NWp5V0ZkREErUVJuRWFDRndkRWd3?=
 =?utf-8?B?ZnVLSFpUUVo4Nk1PQ05iZmFDUk1zSml5eTdrRVdCOExVeXR4MXp3eTVvUHl2?=
 =?utf-8?B?L2JlWmlJYUorQ0ZXM1hnSmJDYTFOWE5lQzBCUkR3RTFNcVNwZm5CZStiN3VN?=
 =?utf-8?B?QnBrL0xONDBYUmhyVVBZTlNvQk9qVkk5Z0k4L01pQ0VCVFQ3cXZRM045cEli?=
 =?utf-8?B?Q3RpbSs4eDAxSytWNzV5Wmdpa2xGSEo4dnVtTGYvUnNHYWhJOHBTQWQ1cWxT?=
 =?utf-8?B?bkdjUitLRVlkRXNhM3owUzNoMHBXS2lYMW9lYitHbEpyL3R1NDFLVm4xZm9s?=
 =?utf-8?B?b1I2MEZ2dnFMR1R5YXltSkpTaVhsQ2c0YlJvNXhnMWh2MlNwNk9FeFd6RGxr?=
 =?utf-8?B?cDBtN2NGbk0vcDFKMWNta2oxbmh6ait6ZXJJQTAyRmZhSkRkbjFLYUkrNHFT?=
 =?utf-8?B?RysxWS9GeXFmWklEVCtSK1gzUCtscVo4bzhGNUFmZjVLTVZEdlZrTHBOT2Ns?=
 =?utf-8?B?K1QyKzEwZ1cvOXQyTGdSYzlmS25MT0Z6L1BxQTZscGUrZmduTDdZTGRnMEo4?=
 =?utf-8?B?eTFUbDFhSlNHZFU3ZHBXd08vVkhEc0JiN3FOMFo3K3ZVTlRiWWU5enU4WGZX?=
 =?utf-8?B?MWI0T0JnQ1p6QjVsVkJtRC9XWnl6NkZ6bTRCRkZpREhpTThPMnJyRU56VEdW?=
 =?utf-8?B?Y0dOaTE4Tll6QnlLV3QrWDJvRGF2dXphMDRRRHgweHJjMEYvWXJQeVhnT0dq?=
 =?utf-8?B?bDJ1Qi9pVjYvRmlxTmtOdGttQWx6VEgyb1duWGNhQ2NjdXgzM1p1QWRRMmVU?=
 =?utf-8?B?NHY5RkpPM3hUWTVQRE9JSjZCMmdoSmEzWnRsME9OZVoxdmgyWjRPeVZLckRh?=
 =?utf-8?B?TzFRR3NqQStRZDM0VGswYmtVTEp5a21XaktwRFcxU2NGMjAwdVNLM3Rja3hz?=
 =?utf-8?B?VWVjQ1VZb2VxeFQwY29OQUorb0RRSEljeUlmZm5MSE51VjJSc205dXk1RmQy?=
 =?utf-8?B?d2hYdm9iTDZmTkZmcEEySXBmYTYraFdBdERUQ0xyckNEeDFBaUFVM1BLTG1C?=
 =?utf-8?B?cHROSVQrWEdIdUFwbVN0aXZ3WHJCc21CNXNMSFBEeHNZZmt1TFpUNCtycjVP?=
 =?utf-8?B?YnRLYjU5SFN2T3FOVVZLSDBzZUl6Zkd1VXZlZGduZGxkSFRDZVlFajVHTXdz?=
 =?utf-8?Q?YVIIgByvCCg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjQzSmZLU1c1dmVIalpycXduTU0wWTNmQm42SGx1NjljMGtPKzJ0SFZzZDFF?=
 =?utf-8?B?UHd0dzRrRGEwMlQvUUtyNzVvU1ZkRGVMV2JTVXpFcmVwMml5czJZVkJ1Sjgz?=
 =?utf-8?B?R21iRXlhenN5WlQ5cHZiZ3Axa2h0ZUxtdzBFWjV2YXVOV0p6Qk5XUVg1VTU3?=
 =?utf-8?B?MEhoZEIwaGxHMk96NnJXa3IwWXNRY3Jodm42ekZTNVlJc3ZUL3ovSHRONjBS?=
 =?utf-8?B?Z0hKdXhNSlYwbjl5ODNoNmpBQ3EzS3dwQ2J0dFQ3SlNLNlZ3MERhU0o3OVBJ?=
 =?utf-8?B?elBrZDBMOWdvcUNqVnFROFdPQnNMVEtZYmw0VUhzdGsyNlpJRlB6R0Yvb001?=
 =?utf-8?B?SHhWa3p0dEdRbGNNSkgvSnJlUXVaajhJRTZIWEpVcHlZblVFRk9DcTBNNmph?=
 =?utf-8?B?UnNtNHF4SGw4aVdiWUEza0x3d1ZiK2ltZDlxalcxd0JxS3o5ekl6SDV3MzRJ?=
 =?utf-8?B?aG1vaWZCTXkwcUpZYlRrVkNKdis4aGpQVmhRR08wWG9VOTN0YjJ6VmdITnEv?=
 =?utf-8?B?a2pqSG1DeXFFR0VqdERaaGNtUC9zUEpKSDJrTDVtUnhJaFhlUk4ySDhrNk0x?=
 =?utf-8?B?eW9wdFUvamVYek4xZlZvQzUzTnpHcTA2OUt3YmNDUFg2Y1pabEYzNXgvQnFP?=
 =?utf-8?B?dzR0NTUxZWNxRXN4c01Gcy9LdEFmVWNYcnVSNXErV1U5NTFMY3pkeE4zSm9v?=
 =?utf-8?B?WDBWT3phUzE2ZkVvRDJyUy96Y0VoQVR3WVdCSnVuOWcxMjdtRFpiVkdkdEt5?=
 =?utf-8?B?VHIrWVdFM3QrWWtDRGNxcFdRdExEcjlZQ2dIcTZlTzE1S2swK0h3WkVKMXh2?=
 =?utf-8?B?NWxTQ0VBNmpPNnJJOVp4NWtRbE9XOWJlNWFPa0FZdjlvZ29jSUV1UkVCVEJm?=
 =?utf-8?B?aDRiVlU1OVNuK0tXKzl6c2dpQVZoNi9GODIyM3dNMmI3SlVZeGRlRzJsNmg2?=
 =?utf-8?B?S09SUlM3cXBtK09WanBiSW9Td2hHdlJsQWMzTEc4WWlYR0dKWHRZWkVmM1Vo?=
 =?utf-8?B?bDEyKzAxN2dtYXIrMnFPd0F0YUs5QlpTbkRWZjRhNG9TVHQ0TWh5MExjVUVC?=
 =?utf-8?B?YzdXTG94YmNzSVFSZURCZ3hxb1d5Yjk4MXluZ3R6SGdKMTVwbWppeE5iRW5l?=
 =?utf-8?B?NFJlaHVNZlY0SDRBVnlBWW9leXpIYXlZbTZXNy9UQUtqeGc4ZXBTajg5bzh2?=
 =?utf-8?B?ODJQeTlxQjBtS0hsd0ZHaFRyL0FLT0ZCM1hrbUZjYXJ5RjRkcVl5Vm1LMkZx?=
 =?utf-8?B?S1JxcEU2Q21NcFpHWWpIMUZ0LzNkQmUvZFhQVWpueEtrTG1FMmpsYXQ2OEtW?=
 =?utf-8?B?QnNpaVZVaXkydGFMVllrQ09OdmFjTGx2UjRSSzlVNGpSMmlaVUg4VXlDbEE3?=
 =?utf-8?B?UXh0Nzg5bEZPcEdaSlMxYmptd1RXRmpHWUdiU255V0tBOWk0WTVDbFdlVmNO?=
 =?utf-8?B?RXJSRWk5b1ZieVJ5aEJBVHZlY05ibzgyUzJSRXFNS21yMVpKZFBpOXVEbXIr?=
 =?utf-8?B?OE8vUVdhVjRsME5WL1V6UTlkS1hlbGNQNUZNWXd3ZlRPWG56VmxZWmFZNFov?=
 =?utf-8?B?WnR4ZEdPUnVhLzFZN1VzUmFSRmtxREpkcmpURHBFdGRuL0JIZSs0YVRoV0ZK?=
 =?utf-8?B?V0JXODd5ZUxvNWhCQmZYSk84SGJ3VXRjUmxla2tOdEUrcEdTclJTckpiZ0Q1?=
 =?utf-8?B?MEVvdlkwaG9PYUFTZEFWQUZHcnp4RjVSOXUwL0ZHTWNvc0wwODA2Zm44dkdu?=
 =?utf-8?B?RC9jVWZZU1NsTDlZeGZ2ZVY2SlhZRHMxbW5obUQxK2poZHpNWjIvVkVobUtz?=
 =?utf-8?B?aXkwTDJRL1ZaZHEyYThEQVVuSWxTRkpmRkFQcVRrU0Z1L2tVWFZ5WEJaRFQ3?=
 =?utf-8?B?NW1uUkNQdVM1MXcrcGR6emFUQTZ2cktaaHNEUGJNYTZMS0VaWmUvL1hPMzRn?=
 =?utf-8?B?cDJiVDd3Z2M4QlhyYWxSTmVqMVVmTkhxeUFqZENkRm5PZ0d2N2wyMkJwb0M2?=
 =?utf-8?B?UmY3SXdpLzIzcUlIbDZXZDBTb3Q4ek5GYlQvOXZTQ1FvT24zZ3FGbndqRkw2?=
 =?utf-8?B?MU5hMVZNcFpZQi96SnpXMGw0N09ZbitETVQwNnhkdVRRMC9DWjByK0dBR3pD?=
 =?utf-8?B?cTl2TlJWNzZCbXRwWTZGN0lUZzFJRHpoZ1RVYU1RU1MyU1B5YXNZczZVdGw0?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oNsZNxyMnvmubxbAFPYSLGq2t3D8oCm0JhpUJRW/x3c+Y61BGaQXFwqqTggUsDkZvud8vT3/wsn/dotl4JwkyR52sSwkEFVRU5kyO7VOHUCkK4YYbe9X4gnquO7hWi8axnqN17WAAO3S9u0VGstffWFEH/q08wnRJVWl2uyVLgCnTwj3fp6DEOHGjEL+aAb+t/RVsFoJ+4P2zadO23p9KdiDSI+YQhanMj+bEUvuCC/IG3HaUNmyuX3MRI1Nm+m+HDUTn7Xy1eMSFVnowE/3HoE+7j692Hyl63wytG+OGDRL7HAMtHPAIVQnXgdYEBnBsSm1iDgup5AcWxS4Wf3YmJqsm6Eq7KxFzDA5rwGMsQO9xIddqLU2D8s/JacubaWjBvxf+Kg1AncxVVU9ddGVuIXHA8yYH4xfSSilyHGYtXGWCOOxTLz9NBdh1E1q4DWDr2s98dUvR7NzO2FJmo5jlGuTFTPKEiUuuYhrbVt/9AnwPq/2lXPAEqFv9t+V/coEVApA0RkP1XPvJlupVb7KxYY7y7tEQdtcxF+1pPYGkEXFyUN4zHfrnQuIZYQtk0WzwloErqsG24Qt9+FTKyqQIrdKYp95q4ThhoXpmQ7pLMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1063859-8725-473d-3e20-08ddae962f3d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:30:21.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzNc19RCwcLWYoZe04RdwzY/hTF4dWxvgf63+jdYldl/1AHFC09YpdnY4wFBgui2EA7hp2njYkinI6ypotgTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF654CF2C22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1NiBTYWx0ZWRfXyQCLH9qwQhV3 vFRUnT8Mav7tWORRLjiDbuC1ShhvAoORa80rHeePeUlepwbJHFebMNVZ3+gU/+MgqIJFRyl5i8E vkXEC1DFln4redmNWTiLEw9+0R8iUfd3J5zgL5p2OV5PyhBxZgkuznaLqKrJiUTdk9ZT5oft9hF
 i+o9V/yGy1cdxKNLeQ6koMe/4ROWMvP4UP4khWToqGd9xhprLcfJO/8BlXg/SHWdlbzth27fPfS gKqJiEKVgxJ/5fTb84EnfQbq/oTNapERjq6DQKuJ/LZnsIeF3VgZnL+EN20zy3sY+lEbI3/45/l pDtqeBYSFggZtzJl7N8ZKJTXMRePRxMN6qiLRqKQJDorvkC45SnkllcNS4Cl38ZevciSb4gQnLe
 /1CHKZQgQq1oZFPM7UOjKho2xcj/dv8EdK0+X9NkuUJ85zua0RheQq/Hemo8fQNb+LxXXTrM
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=685305c2 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=RU18Lo6s6beJIr9vMDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3kh1MDAR5qepdictM0xByWztJ68i3gEs
X-Proofpoint-ORIG-GUID: 3kh1MDAR5qepdictM0xByWztJ68i3gEs
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_113041_161199_C691E1A8 
X-CRM114-Status: GOOD (  14.45  )
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


On 6/18/25 10:17 AM, Christoph Hellwig wrote:
> On Wed, Jun 18, 2025 at 09:07:42AM -0700, alan.adamson@oracle.com wrote:
>>>> AWUPF of 7 isn't consistent with an atomic_write_max_bytes of 8192.
>>> It is consistent with an (N)AWUPF=15, and it is namespace number 3.  Are
>>> you testing controller 3 above or is the namespace shared between
>>> controller 0 and controller 3?
>> CTRL 2 (nvme0n3) has AWUPF=7 which means it supports a max atomic write
>> size of 4096b, but /sys/block/nvme0n3/queue/atomic_write_max_bytes is
>> 8192b.
> Can you double check this really is your CTLR2?  At least for me
> the async probing reorders nvme devices quite a lot with qemu.
>
CTRL 0 (nvme0) - AWUN=31 AWUPF=15       nvme1n2
CTRL 1 (nvme1) - AWUN=31 AWUPF=31       nvme1n1
CTRL 2 (nvme2) - AWUN=15 AWUPF=7         nvme1n3
CTRL 3 (nvme3) - AWUN=15 AWUPF=15
     NS - NAWUN=31 NAWUPF=15     nvme1n5
     NS - NAWUN=127 NAWUPF=63    nvme1n4


I rebooted and it probed differently.  Now CTRL2 is nvme1n3.  We know 
CTRL2 is the same as nvme1n3 because awun and awupf from nvme id-ctrl 
matches the qemu config (atomic.awun=15,atomic.awupf=7) for CTRL2 (nvme2).

# nvme id-ctrl /dev/nvme1n3 | grep awun
awun      : 15
# nvme id-ctrl /dev/nvme1n3 | grep awupf
awupf     : 7
# cat /sys/block/nvme1n3/queue/atomic_write_max_bytes
8192



