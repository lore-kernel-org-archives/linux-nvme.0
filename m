Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BDC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsGxzkvV7FYJv2DDPmZrrINGdWCsqEufzvavukt50C4=; b=T9awOFMElKvSpV7agSNC4EBPtR
	eJ3cW56KXxptp8QhK3UfE43arxEYb7jo/81/ESrxjubA1YpdGdnu9AzQU4aLkvVY6WSajMfw9tWgy
	VPvvs8ct9C2vDR9k9UpkITzKRcUfFwKLEvB/uf8yxz51Hb51CXAAVop5b5+1BIIVCSAAAazTcRDZS
	7uwTrdW0wo5+sLJ69VLMXFVSZ3L6P9YsEWbpufVGU5yi9o+R+eVuVzcO2enhgzWC/ai7pzURtbh41
	ZOaSlQX2aH5tZD8iFnQQtXuNNmqfhpSzAOntAYdGyMYtiF/06rdA+C6TIC8vEMkeuONipODQ936kN
	7Iske+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phv4a-004RwN-2c;
	Thu, 30 Mar 2023 16:24:24 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phv4X-004RvB-2O
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 16:24:23 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEEM2K030159;
	Thu, 30 Mar 2023 16:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qsGxzkvV7FYJv2DDPmZrrINGdWCsqEufzvavukt50C4=;
 b=XNazsavvwi5SFBUlKywwWHYHxctwXJacSI4m8dVgShtzJYkOWh6cPqjbVt7xCTA+IV8S
 AQgoqpXnbzYh70jvlQe3FzALlmZDNU2tuXXTvhk3fHSSLhSptHgMj/q5f3epKS1BtatR
 1+WwWsi1OFYs97hrQ947Zoud+Oen3quskvk4FYJfOuABGiC3S43/TU/etXNTxRjxLsm0
 mxoAZj6BdDuM9Dy/B9rTrzQqWK9/GFCQMzBw2wljHxmIDdcvkXzUMjCztJMCqujSw97R
 rQ0153jXqv6BZ/PReeGy/89t44axacEVSOAvRs1fIk6C/ssMcAV7+vWj8GNtWJhFhn1F Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq56u5rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Mar 2023 16:24:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UGFuJ3035043;
	Thu, 30 Mar 2023 16:24:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd9nemu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Mar 2023 16:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnm9FfVsMZgl68NSnWPqLNNcCdYndBzZC2NwKZbxavF+w1/n+sXUWeB51G6ZIdVfXOFFXcJZ4cWFadLKzTYHGGwwfIZNmpSnl1pGO0lv0c6ZKPxLGWmGzUJZmxcXrSlpf5g3pwFrKYU70PYYqShgCd0t7sYLMfi8Tfmxs2S47v85BrDlbEsN633tqBxy45CQzDap7bLevSBu6e+qJDqrfn4J1A1Yp+YtACnXV69q+DqaV5lXcs969z+syXxyMlv408RKokNx92ul/LU8jYA6XbKd71GadtKB9p9mgzUXJ+9Z2zXUxm14QxYuSjpK/KQ13An7+HqwqU09w/wNT9rGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsGxzkvV7FYJv2DDPmZrrINGdWCsqEufzvavukt50C4=;
 b=Nd9JlHBQcBzHcAbptAxySguLVmUbS7z/TT6JuIGUr8lnPkAN3nQX8YZj2rFLz6izgvEV/bF9A1Ogq7fFNL8RI9c4x3vZVo4qJslK/LMpmdBgCcOYU5vj74G0J7fZ513tv5WaR5vMUVk/Z4cyl1G3pCH3kk9uM7Or4ri2wmKCFcLY3Ko4hsSfsWu3nywss5mjD9yd0O2vhC7lqU1UP6Y/Up5CsmExzHzUnJeLj1RedJOADCP15WI63ZjGPlrs8S4lLF4RJFhCesJ2OujaCtSibvZyMG9oiYau3gimJIiuIoArWb43UAOc8AiKO2eAMonVdDui/IsOiF4l96b1zOBXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsGxzkvV7FYJv2DDPmZrrINGdWCsqEufzvavukt50C4=;
 b=iljaGrJ4xufNnruryeAUshnPofN9IL30Y3Hoa6jaqX40oBD9roeOkVmjDUADJUoPmivPznTWAcXY747QbR6vi54xEec75taWqDqoZXDgj2gvugbOcDCd6/uMLOXc8ZvFH5vmrbWAljB4a6MKWb3qab7utGmBRLSPA13a+PmRQWY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 16:24:13 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 16:24:13 +0000
Message-ID: <8792f6fd-acba-dc8b-4c72-0e641b7caa62@oracle.com>
Date: Thu, 30 Mar 2023 09:24:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-3-alan.adamson@oracle.com>
 <20230328005735.GC21497@lst.de>
 <89ee30c7-7c7d-b0c6-3234-07e698d211ed@oracle.com>
 <27a9d788-869c-93fc-9a24-48c163621098@grimberg.me>
 <6c9fe658-42f0-a006-b8fa-1a8d87d681a2@oracle.com>
 <efc01aad-737b-b50c-b4f6-fb928fbecbab@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <efc01aad-737b-b50c-b4f6-fb928fbecbab@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:806:121::12) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: ab03ba65-263a-4482-87d4-08db313b3308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	lVFp1zZjLQ4NzyOoEKED7xBytRI++hstLcdPaVtJ0kVcjBho46qIKvkEuCUH8wlg9j3qBX5WG7wUIwSChAc9zRsumLoB6m9TMR0T4G6N4vsFusqu4htjn9FqsHDJ+BgiQbIZV1dv5v1QnJasSHQSb6pjegs7H2oPeWNiXcvaK1Ioq4kKNFyj3ew26PFgclPea97FBXsrzzA/jOnFbrzzR0hTp3I8meDERM/Iuug//pwZSdr+X5ROctkLNlGScvRIoCWez+hxcP0ll4GIfBHRA8k9KJENP/a7xUZXapH0oJsuyrPGVucH4mYc9k3gpzVmGsrCqzICUAGHMUkowQggD2Y1kjD7hrHlV8Jbbh8p8K/zKCZ9oX5qiWGq02oh+M3Tux18iwjfwod7lqqweS450nPmskxNOQ14R0iCZCR9UcWO/265P4OBkgWYpvu6SvSLKVEO7kqf94kDD3B34JlbtSgJTRY9uG9JTKbib2GF3PKC3Zn7A9hkFk5slobR05QzEgdJZDDUT04wLvzHrlMx8ZZvpMkkqce7Zy9Akx5Ubf3dTeMhpuB4kxAiSaV3NFHvp2t3WIRrnLvSYdR0fnsrjIpTwalBRNSzq8MtTK5vW3rsFMEJOMaImTbB75Ln5G6n
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(6512007)(316002)(6506007)(9686003)(26005)(6486002)(110136005)(6666004)(4326008)(186003)(53546011)(8676002)(66476007)(66946007)(66556008)(31686004)(478600001)(41300700001)(4744005)(5660300002)(36756003)(38100700002)(2906002)(2616005)(31696002)(86362001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?R0J0b05VRW1MWUQrM1BKZWhmR1JzS0txNTFNaHJLa2xaQjZ1NG5OL0lJYXFk?=
 =?utf-8?B?T204QVZsWnBqTG5BSlV2czZzWWx1WFYzUnR2aUhPNVBIT3NPRHhRL3daNzBt?=
 =?utf-8?B?bFZRekpxc3JHc01Rd3NjcW4yRFdaVkd6VDlzQy9pUERJYjNrT0h3d3h5VVhU?=
 =?utf-8?B?UlVYSFlhNWtRd2dZajh2SzJ4YVV3OGU1M0NOa1lZUFA5M1JKWWFWYUd5em1X?=
 =?utf-8?B?T29VVXhvSXVmdlFvZU40aHFuRUxWYWtzRWU4Qklsa1JXank1UUYyeSt6d0hF?=
 =?utf-8?B?Y3lpZkFXRlQxNllBVlZvSDhHUEZhZHE3akJ2d0RLZ2NZdlUzcWd5TGZOSlNZ?=
 =?utf-8?B?WFNDZ3RLMGhQazFiSS9QbC93dTU1MXR2RG1zS3E4Z1RPM2xxN0VsYlVVeGFS?=
 =?utf-8?B?OXJPRjV0WmlSaVQzclJxNjRXMVNZVHVuWS9UTlZXdDQ1c2FySldaVkZqNlB3?=
 =?utf-8?B?RmgrQ1hSbDhRbkNJNGk0VWh0Q21GSHgwYlM3Rlo4b0RmNnJwYW5ZWDJZRWZw?=
 =?utf-8?B?ZkZSdGpDTzZXcHNWWGZiaWVDWEx2QkRvZkUybVExdldXOGE0K3BtT2hkNEVO?=
 =?utf-8?B?clA3VUFTNUY5Y1E5UjgzQzlsTUV5TjZGelVsM05mZDlsSUZnSFloTXo1SElS?=
 =?utf-8?B?aGxpTzhlUWZ2ZjhrRHZzTTlsQ3Rjci81clgyMElpV0JQWUlFeW1Oc2pJbWQr?=
 =?utf-8?B?SFV6TTFxTTlndVN5a1lxZzFUL3FTY2IySW9SVWJGZ2NrOWJtbEpFK1d5Yk1o?=
 =?utf-8?B?QlBTWnBKbW1Wd0tYTThydkZiSnlRTzdCS3BJYnI3NUFiY3RxNEFSV1N2bVBD?=
 =?utf-8?B?dVhGZGpKSnhsOFA5REVnOVhQTGFEYTZaUWovODZWQ0U2U2x4S2FyckwzZk1w?=
 =?utf-8?B?VWwrdDVBeFU2TUNFNnFKQ3BKR2ltejVrNmluVnlFLzV3VThoMmh6NW40UnMv?=
 =?utf-8?B?S3FXbkZqcWhTbTV5c0M3TkdiRWtaSXl5eUg2cmRFOWh1S0hwZnJUSS8rbnVZ?=
 =?utf-8?B?S2txUENVWVNDTDgvS2dMd3J0TXF3ajBadW5vTWQyU05pdVAzUWFvODNjdHFF?=
 =?utf-8?B?U1dWL3N6NkJ1OW9lNEJoV2hZcnRsWVB3VWRWeWlOTkhDUnora1NvcnNqZUN3?=
 =?utf-8?B?Vm0yNy9yOERvQUtSazV5SEtmaG5ucnlQN2RZWFl4ZEJYdkluM2xNL0RBcWpE?=
 =?utf-8?B?RXZzaFQ1a01xL0lyWk05NFpFdlJBL2xNUUNHVFV0NW56UmJGTVR0NVF4K2JF?=
 =?utf-8?B?ZjV0TVJWWE53Snlad1ZpY1Vsb210UlRyc2x5NVd1QWwvSWR3NWJLeEs2WSta?=
 =?utf-8?B?NFVJNjlhWGJpUmM4b0cvTG1obVdaVG8wRVE2NkRrUVFWM1FTbDg4T0NYdzk3?=
 =?utf-8?B?SEtEN0dMWlhGUEc1R3F4QW1SUldDU3hYL1pBeXBwdkF2WWRybzBJcjFocGV6?=
 =?utf-8?B?YnRYWG5HZ2w2Y3VSVHpmRU1mOXo4SDl2UzdmcU5BSlJHSFVteFI3UHJxRnpH?=
 =?utf-8?B?Tm8xYlIrVkZLRFlNdlBPdWFHeGNYM1JiZHlwSFV3cW1vd0Jkc3M1WDU5YWFJ?=
 =?utf-8?B?R3YxY3p4R2VKU1p5Yy9NTXI4UkpSVldzSkNQdXlWRDBTdU1Hd1pTcjZmellQ?=
 =?utf-8?B?QU5JRG9lRmtOVTZyclJxdEpURWhXVTZFMVN0Si9SMXNzYnB0dk83V3pEWnFP?=
 =?utf-8?B?bEtvOVFzZTN2M0dlZExLVkcvZ1BKYVF3dkRTR3kxdDJiVkloT0Y4ODVhd08y?=
 =?utf-8?B?Ung4L2Q4R1NtRWZyRWpOQzFKaEkwU1MvQ0V5cExqTVBBWEw0em0yd0xsU29P?=
 =?utf-8?B?SmpDb2oxdXlKLzErWWtKZ0NNaC9OZWlFeDRaMTFadXFjZWdMZEo2RXF0YUVV?=
 =?utf-8?B?ZUMxWWtCckh0UXZjK1JwaytyazFHSnZsWTJJSGpGVjAzZHdxcUpFZzE0Z082?=
 =?utf-8?B?NnYvVXBRajhyZTFvWStVUFUza2crRC9PNkloVUNZZGVJSHZhazN3WnoxOVE5?=
 =?utf-8?B?cVE2cVJyRDRkRXRYRndDUmdHdm9WcFpNcVM0R1hVUkFCZ3lLMDVPTFdRODgv?=
 =?utf-8?B?UUc1OUY3cjBENlJvWTZLaEpLQVFaSi9XVDJkMUdoSHlYVW1jRTlVRUpoVmsr?=
 =?utf-8?Q?rz7tay2Y/l6J0FyrPnAFOd5/x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	7QPnRsW8mBqOUprv+rSEK83ytJEZ++VG3V90UnZssRXPmVs63J6soYwB5wc0oEszjYz3PWHtf4A/hOgTGwMTMAk2kr8NNulsxl5h4xnkJbPVntfLryOu/ClCdskDiO0Zy3rKjEy7e0rKVIZNb0nUKLANlQz0cXQYwLONM2NpHiVuF8MbLyO1f8wncwRF/+lWVTv9MpenpH8Azlx2nIivnzuiLN2lXxi+ptqxpbfEVzMrD4XZ91Yaapj+9dBWFAeEqj9P8/9t40RCdTUshQnPdIlo1S2GjM0MjhleZ9EOx5IIBWyTikq86hu09qkpLVUk7F0StCNEGeFu1GRfhbArr8pIZQQ3P0Sp659nYkVdf5BZ9UioARb4kPGuBGM+/7zKdKX4gBsEB7PQ0d9h2R5S2Jm93371Sk1UHfQnQBYlHJdtSTNuYIUiiPXwEQ1yBrFKjLMv7njT3w5/zU2nZyN/AqpaSCjCD1EBMwGr/TIXwVM/YlIKO3tszKxFlXx8c1s4VdUiUkOiuSsg6KS0bpXiNWE1kJDh9U8VNWfNNpqGSu4A48OCmhzgkkt8vnFMUZ+MVWjTa/eCGD0psxrd1/sjXS93VX7A90KXPpIxc72GmZA2/ngi/uDiHJ02H3O8nG1xGDxHoljI9KwmOyOuYeZdCQUqD/f7Uuyx++ePt9w02PlIierrzHg3a1nSuywpAZN1vYA+XaWhJCwvg52qG5RvrpbOdoD/FelV94Gf6U39QRiS9dvaSgyfh4hm2iOTzd1tmmqpj/9nJ7bEQrsv6c5GCeDDoiKuoscqBhCAypWGdshSx3d5ALeCUCEn2sN9XQ4v44eQiMETATLnRC2bL29cfb+mISbB3n+/3/HxgYpg126l6SrwYvs18TrUqZPUzpQB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab03ba65-263a-4482-87d4-08db313b3308
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:24:13.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D8sUipQZ3zQLcWBBg8IywZS6gAAeLvOwNeQJRGcCxwow3aBePRnb5fecoB4IEMO4KBq9bkzZbaYRD8Flc+Uyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=892 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300129
X-Proofpoint-GUID: hUbSAR8RoyPH23manMs3zlnalPPCmh2M
X-Proofpoint-ORIG-GUID: hUbSAR8RoyPH23manMs3zlnalPPCmh2M
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_092422_203046_B65751A5 
X-CRM114-Status: GOOD (  16.09  )
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


On 3/30/23 6:38 AM, Sagi Grimberg wrote:
>>> Is this something that we need per ctrl? My assumption is that
>>> if someone wants this, one would enable it for all controllers.
>>> Maybe this should be a modparam instead?
>>
>> Maybe both?  Have the ability to set the system-wide default value 
>> via modparam and sysfs to change it per ctrl?
>
> Definitely not both. If per controller setting is needed then lets do
> that, and if not, lets do a global modparam.

I think the use-case for it would be:

- debugging a problematic controller.  So you would only need logging 
enabled for a short time while  debugging that controller.

- Some application  that is sending passthrough commands to a specific 
controller.

Its probably best to enable it per controller.

Alan


