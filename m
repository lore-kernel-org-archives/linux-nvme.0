Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626B3C46CD2
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bolvKPuehPcCccKGj0bpm3dJtcWGjkiIfSVmo0bIH6w=; b=Y/uej6hx6jBavt1l1qi24Vivqh
	eJiV2a4BWQV2XpC9XZI3/gJan6ZOKXz5egl2/8vUjutboKFxJmB1CNWJ8obNyekb1/NHesSoSC7V4
	vJsUIgbjTAanbRToZsW4ax6XYTuthsDc6BzrG/vdR1Xw8+w3wnYDblV2D6ve/eqW26cuJrwPjkFVU
	8PVgV1OPdiK4ldjTs2z87cKCZtEI7RWL/GoEGCAP1x/T6A2vjHN6K8wEQlSk7xL/n9sy4m1sdhpb2
	mZSH4Lx9IunJu7n5Uf32eVlYCIstx7Oh+00ckTqhDtHqoJW3kDw/MX6QT6mdcOWDETES7dXYobBd7
	V6+ilXiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSnz4-005k9U-2h;
	Thu, 25 Jan 2024 00:52:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSnz1-005k7a-1U
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 00:52:45 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLcKNc012570;
	Thu, 25 Jan 2024 00:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bolvKPuehPcCccKGj0bpm3dJtcWGjkiIfSVmo0bIH6w=;
 b=cgrNnoqNp7P+VHLo+DW6h9AuwP5d+nlKXP+J+nUK+qKxh10IIe6JTKwFmgcTGiTiFvIL
 YzBhREoSwV5yy4h6i4XBtYpJkVcDllG1SpiR0l3pozjjBJuR6sGmnLHjizWNWNg3lvbu
 yNAgSBEePcekNUhNxU+sAOXu1v0XkuZ3npNgbCfslUn/KVmfN4vLTpkMcpMa4kD6eak6
 2GgM6CV4S1C0YOpcI06QinBglaZ/WStk3GYCJgh54sJEo17VMI0VyrD0ZRYqC+QxsekV
 VGB/Vd0NNQ8+JHiP8SpDGQE97bHeHx/XReje5Czx63WPGrnSbEnzpg/zJKKPTve3uWpQ Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79np0cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 00:52:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40ONS9OR025990;
	Thu, 25 Jan 2024 00:52:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3182cvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 00:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw5MabRg9yQuUmzDHCkXaKX+3roomkbyDlyi6PgNLopjTYmJgOVq94qEzIp8TCsqzIGBvYnfaU6Qsla58drvZV1C6vYncMoYNaiKpWhtoZDI6C5/oOKBERGT9cTOAv+a58rf2otSPChz/gXftGbe/9Z4R5IHOI5/YNm8B4T+lDNO/pTIaN3BNxz0xGE4uWoFPODiU7jgG4UIL/FS12Z1+54T3E/5VJfLlLe/y/TRmwGlqdi/MWpLo3fz6itNtzUYPvsE3d+1JDG6hOqNe46oxBYmEMOvXzQajc7pVdsEQxEN4a/8PnYG9n90im73zSVsr+Mgf77O0kNooAsTQsi1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bolvKPuehPcCccKGj0bpm3dJtcWGjkiIfSVmo0bIH6w=;
 b=ZQQwc5dYLBAtHZ1FLAorhwgrOxexZsXqDCEVeIF/J3+8DqEHusQ/2w+o6oWK2QoGhLLHH9/cNvwGJcim2PtjGRWum20Gv30n+wITRPHD1wKTJcd1F9PsJGSPzwjm0hnYFbpKyYMMXAsprXtg3OptvF9sKJVBYAw75PkHrIr9BEW+4EaU/lRmC3lLA8v1RNeUN1g4yTs5RRkN2TaB9NWovA5wK+5bo8t+IyGq2A/ygpnD3mupHoy7britL2r5EJsGdwLaiNGFSGIztyBSBtJfNOoJycTJDyX4oZx26jKrfVi5cenPQl2T/WvmRfh1UB6BNTMjAyJ6lK9HR2P51A5N0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bolvKPuehPcCccKGj0bpm3dJtcWGjkiIfSVmo0bIH6w=;
 b=yL/5VEGby9MNKHbD3/yqo+o218vXdq0+Z9D9Z//UAJO7eo1kQNlgIPAO+Xzw/h1p6qxrSddI7TlaJJYz63X9dV4RGvmSnoZtWzwSndfTPp9xXV1qU27mqat/ymZIGmXnQv9vWkqm3OA82Zg5/BOj3da2t6jBxTZHGMMV72VF7wQ=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Thu, 25 Jan
 2024 00:52:33 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 00:52:33 +0000
Message-ID: <12d06642-562c-43d5-983f-b8ff164b8fd1@oracle.com>
Date: Wed, 24 Jan 2024 16:52:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b78790-e24f-4aee-7485-08dc1d3fea81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4OdjCNlFjuCDJPTilMNLi0sLPThOwaZKUkJdCOpzNNfNJztKeJNSIpKsCzZQv8h2zg+Tmd3L6JIYQjHO9POtLShIwBfaYWZGeSPndk08akpgOibwYd1S52joYbe2P/N7UIAwwvh8Zf76RPc5r0SF2i5v/3IIiKyWovVrgvW03ZW4Ou1jpEreoH0EvbXBOsgV17utEaDgcZcQ81wSwuPjdDJ/Rh1d0hxSorK4adbd8LUrIBpYB94O8/ixqEYe8xyaCy7c0McpVQppv6QTIFKmqYU8nesBM/UCvtfeBtqYCZbOoPrGjSinxKLrdgeou2w+1MBkLBy5Xloe9DO06F+VD48uTmeUOPS9DFYldQBLyclApkzWcsXQ968PhZNcHhVZEJRfOLMBOxAiJHmP85cx0FwYWrUR2CLtzTIc5B9wp7gNeqZDSGMKnFBahVzudiAWbgXBwDPIf9XfHlecoDdwB+nZPsBrpMcL5tZABnjjeWm9/wNGCbSnwyZMVdO4c9+5XGKcZ82wngC1doBkox6vzi/N57WmyjS7K5NWIQHSVnRWWJhOheF2dvfdGNeKq9dAi403m5nJT/mF6Pkslu/IqH4i+9UqRaAjEgLSuZiTN6AoXM7db65hkaEppZU5syY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66476007)(66946007)(8936002)(8676002)(86362001)(54906003)(31686004)(66556008)(5660300002)(2906002)(6486002)(41300700001)(4326008)(36756003)(110136005)(6506007)(316002)(38100700002)(31696002)(83380400001)(26005)(2616005)(6512007)(9686003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW40VmJCWlllcGFralZFQkx0K1N5VEZscXJWT0tnakplcXlnM3NWZVpGMEJD?=
 =?utf-8?B?TWVXNHhZclR5T3Y5NkRWMzlPWnFKeDVmVzE0bnByUGw3RlNsWDVoUjVyRTZT?=
 =?utf-8?B?dmduVnF3c3VLYlRPeDdqRWd1WjNJT2IvRHNMT2hVMUJxSmllaXduWVFEZWFq?=
 =?utf-8?B?a044MUVDWWozelFqcDJoWTFqTU5Ha1NQQXNJT3kyVWVvWGNhWWkxK1NtcFI5?=
 =?utf-8?B?U25wQjJpSmRSNzk0RVdmQlpldXdQWXg4aWhDSDdFY1c1NmhVaXNjY0xJN21R?=
 =?utf-8?B?aE02Vm5NUldLb1BhNGRramdNSnVmMm5Fc2lOY0dDUklsNHpLM2JiRHJJY3V1?=
 =?utf-8?B?R1IzWDVXMVE4L3NSbnExaDBZTjVoQmFnWnRROW1pTGxxbmZtZEUxbmh6M0Jx?=
 =?utf-8?B?bFhyKzB5NGZhcVFReFBFQ21UQ0hZLzk4ZndnRkRPb3FFZEVWbGJvaDNLYmh4?=
 =?utf-8?B?NTY2MzVweTUyRUNnVXdueXliY01Ud0VVU1QzbXh3Z3JYWFpWZm8zQ1hHVE5v?=
 =?utf-8?B?ZEp5SXNNYU5qblltRmErUGF5MTRERTBCRnBCWVAyUDhVRko3bC82QnRYcVZZ?=
 =?utf-8?B?dzIvRmhQakpwelNhYjdhdUQ1VXpXclREeFNvWXhQaDBWRzBuWGd1UzdvS3lo?=
 =?utf-8?B?MkRqckNoSjk0U2ZkaWR3dllLUU9tUlFhSTh4K0NYU1lvR2FwZlRJT3hFTzRY?=
 =?utf-8?B?RUxKSk9DTGhLYVFTblluY0JPeXpIcGhlcUxGd2J1alB0Zy9LTTVIblhDR0Z3?=
 =?utf-8?B?bFB0R2FubS9xVXhGU040czhTVUxtMDlUSitOcXRGUVI5dEpyNUxlTGVzWjZh?=
 =?utf-8?B?Y0kvWG9vcjczaU5raWlxN2hRVzM5NmlQRUhwSGVYVFAwSis5VCtXTlRkemlk?=
 =?utf-8?B?R0VlWFlEdDdTemd4VnQ0ZGUzTDVIbDdnS0pQZ1NGeGwwNGxHZmdoRFpwd1kr?=
 =?utf-8?B?UVJhU2dNR0pXVm5XM3B1VnBLT2NFOUV1U1M1UGxRK3EzcmZBSDhlbVorZEQ5?=
 =?utf-8?B?VHpwM2dXWkdBZ1JTZTFOUWFYNE1sRHNMMml0cGE1VmxUbWZqMzM1K0dFV1Fs?=
 =?utf-8?B?T1R0VzhRMGZFejM3d01aQ0JFUldRb1hoc011WXJTNWFQQjdtMzRGZGRkVERD?=
 =?utf-8?B?Zytkem9UYzA5VXFSalZiTnU3MXY4VG12VE84eVF5a3ZqZjdlYVhrNk80dDBr?=
 =?utf-8?B?Q25YSHFMUkRkdDdJMlZIUk10biszanVYa3BvclFMQlFFU3hnc1VqSWhzYTBw?=
 =?utf-8?B?aEErVjQrazExeDlycy9aNnRxS08wT2pQTDZjOEt3WS9HdXdvcERxZkpyQm1Q?=
 =?utf-8?B?MW5YSGxkZWE0MDVXdElrMkpoOUhwSHVBbXF3RWRzN0xXYVBvNUIzdzc2cG5w?=
 =?utf-8?B?QzJVY0ZvQzlsdFI2MEdLNCtIUVRDRXo1V0tqbW9aMGIweXVnWEhxbWNXNjZN?=
 =?utf-8?B?ay9SdmQxWkZyK3V6ZkNIZUI5b3ZUZVgyamY2ZGRoQlpwc3pvU3NxSTEvTmJa?=
 =?utf-8?B?MytnVnhqZDZ1RFBoQ0ZvTUVHWm1WcWt2SU5GZWdvOWoyN05SWDF0c1pHY1ht?=
 =?utf-8?B?VWNhbWprbGhvUDFqSEx6bGp1MEV0NkU5dzM4dWhFZUFtcW1rRFdzd3ExcEQy?=
 =?utf-8?B?Y0Y5amE5a2YvVHByQko4QjBoaDFlUFBoTzR0S3JxcXhmVko3TmR4ek5DOThS?=
 =?utf-8?B?ci8yQzFnTitoQkpTSE90ZitlRWxPa0thb0RYeVZnMTJpMVlYTW5YbFd6SGdu?=
 =?utf-8?B?SHVTZnNhUjl6RWY4VG1Xd09xRVJvRDNwZlJQWVZVMG9FK2VXRW00QnBnM3gx?=
 =?utf-8?B?S2hwN1NtYkVZT2lEbEJRZnRYSXZBcmJ1T21TREN0SWtlb1lDdVdOYWJ1ZkFU?=
 =?utf-8?B?S21NWFFZMUxQNkFLK2F6b0xXMkdMdlhUZEtqWFdtRjZwWmhNZWxidlc1bWJQ?=
 =?utf-8?B?alpWc1BBYlVaS2hUdFNjZ2x4aVIwdVkwTFFHZ2NZTjNtNGRTaFExM0lJQ0FH?=
 =?utf-8?B?TkNackQ1QmtBSzBqVC9xZGZGT1J5Q2g2N0dKaEdLN1FMa04rOU8vd0J5UnlL?=
 =?utf-8?B?QWFPbm9DYnM3b0pzMmNrZlFreE1qT2J6UDUxbzByQ2xWb0t4Mk80YTgxLytV?=
 =?utf-8?B?QjhNOVFyUm4xc2d6Uk9vcVY4T1NMblYxMmRMSlBXcFJqR1J0VmdSZGdGYkhq?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5xOaO9eNyCGOU3c+AU6zl6NSXXoY5wm55owPolwz7YAOw13XzP7+d6oDLomkWRZ8gP3dR6zC/VNNU6E5MMNdL4nmu/WqdCDF27J9QA4RlCpoFa5lzAZIKV3G7w1hJZUbI/cpZXXURq6cCWXaQNYoUiRriqQfleR0mO5HX7xMUU4jH2PeepsPhj6VP6TjaEcHaf0DQm4m3N01scyfLphlsCU1bXLAVyOcyIZ4nDkxcuinCAb1Z2pY6C/okRJKAB46rX3VglveINcsdJEDgbMfdF6WWH4i4PU+gzLnTVgjaMm0/iOpeuHB9V69njBxbC+m2JADWD4AJ8y26T5LNrSXs6YZ2YJrHXymeuEnM7dQB8GNmez7nRjekwkuTYJ0TFmDsm/VKxVCbwvICBznxvzqmUqzP6ldP7/5dSRk1syQY0FrqT0WjXqNpHR4DqOa6MK8L35Gahm63ET92c1W2RFxcWiqGivN9PF+VGLwjsAdiwCfV/L6B0Ve31qqNehFDI4lxq9Dx6EtB/yOk0AxM3Po6CR9w1fMYQkBh6Qu2m7zxgpJ5M9/LXmsjA4yvdLk6ok8bhrBjWiT6eXz9tRgE/5k8xYewvsrw9X/g6B1iQg+7I0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b78790-e24f-4aee-7485-08dc1d3fea81
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 00:52:33.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WDjcZObpPK71w2abLOxayZITtjjsseM0xjMeGbZksgPjxiqPoRDBBlzq5yrpMJV8BoT97HzATDLByALNllZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250004
X-Proofpoint-GUID: Z13O2k6Mnxu9J4qyxnuqHb-v3pCBuzfP
X-Proofpoint-ORIG-GUID: Z13O2k6Mnxu9J4qyxnuqHb-v3pCBuzfP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_165243_676700_67838D96 
X-CRM114-Status: GOOD (  20.87  )
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


>> sorry I didn't understand your question clearly ...
>>
>> In the original implementation we get two different struct device 
>> objects
>> for following commands in sysfs, that sets struct device:logging_enabled
>> flag,
>> which is also used to determine the logging in nvme_init_request() :-
>>
>> echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
>> echo 1 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
>>
>> nvme_init_ctrl() already sets dev_set_drvdata(ctrl->device, ctrl). In 
>> this
>> proposal above change in nvme_alloc_ns() sets the
>> dev_set_drvdata(disk_to_dev(ns->disk), ns).
>>
>> This allows us to get the ctrl or ns object associated with the struct
>> device
>> we get in the sysfs, then based on the device class we update
>> logging_enabled
>> flags for either ctrl or ns respectively. In nvme_init_request() I use
>> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.
>
> I was asking why should we have a show/store that operate on both ns and
> ctrl?
>
> Why not have a show/store in nvme_dev_attrs and a separate one in
> nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
> the ns attrs can access the ns in a normal way like the rest? Or am
> I missing something?

If we create separate show/stores for the ctrl (nvme_dev_attrs) and ns 
(nvme_ns_attrs), using the exiting macro: DEVICE_ATTR(), the attribute 
name (passthru_err_log_enabled) can not be used for both nvme_dev_attrs 
and nvme_ns_attrs.

/sys/class/nvme/nvme0/adm_passthru_err_log_enabled

/sys/class/nvme/nvme0/nvme0n1/io_passthru_err_log_enabled


If I setup the attributes like:

static struct device_attribute dev_attr_adm_passthru_err_log_enabled = \
         __ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
         nvme_adm_passthru_err_log_enabled_show, 
nvme_adm_passthru_err_log_enabled_store);

static struct device_attribute dev_attr_io_passthru_err_log_enabled = \
         __ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
         nvme_io_passthru_err_log_enabled_show, 
nvme_io_passthru_err_log_enabled_store);


Then both attributes can be the same.

/sys/class/nvme/nvme0/passthru_err_log_enabled

/sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled

What do we prefer?

Alan




