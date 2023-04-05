Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D48C7618D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZbRxI9+L3YmH2bpVyopU1oWQzrOFJwmmIVnikNSwsLM=; b=HeqaI5gQQ1n/DkFhIk7OW+89O0
	8YZNHTRtwQd5bjoIOFfE4tNbHjAfSOl0yDzdhcM75hk73X0MY1ny0/W0DUQRkAR7zdfMXfv2+LBNI
	FAd5BFM2OQ7hz0BglxiHXOxLS3aRqX+d3wEKkKmsvVBMCaAbuYRXcLR9k3pDwx9m2dCxrjlrY83ec
	5mpx0fWI9qIufImdkWWahEvRaI3YCIKcBGJJ6T4f2o1a80wZC4xQ9dUwSGaJYk+ovklfYoCyiJxHu
	i2yLxHJa2j/hvDt+oPQbYqgSoKmBMGDhtLEGxSw76PGtjcprZyZTYBjd6bkHOWq/Q+DUbEW/PxM6O
	DjQru/UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBj6-005rSU-1Q;
	Wed, 05 Apr 2023 22:35:36 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBj2-005rS4-2q
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 22:35:34 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335J3T52010777;
	Wed, 5 Apr 2023 22:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZbRxI9+L3YmH2bpVyopU1oWQzrOFJwmmIVnikNSwsLM=;
 b=BuD6FuVFW0DumhLxz7oD7Xob7xBhtxLnTVOb9Ql1yvmPzInlsE0KP0N02p5cfO1RDVPw
 FCRXZolVR3iYrh9KA1X7Ev25OQnUMJX7UnBcMufqtaaU4AKfJ1+NM+38qOlM6RBk9x8a
 cQ5/oeNky4pQZ0pzUT6usmA+VjRJH8Y0pTuTL05epa5W8H0vCWE5ceetCAGAtGRmA3/p
 anBlK+OwCvih6JsyFZBMT48TltxFZBdgSHLgn1tt+sdjHbIPM0t1Jmo/3ORpP+FURS0D
 0w1kowqjvUbyZkEycsg8BvTcEI4tOxMySfiRRSUwPW+Kcyq1i9WmFK+J1inSBtXUmmHH PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5uhp5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Apr 2023 22:35:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 335LXaOr017420;
	Wed, 5 Apr 2023 22:35:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp9a36k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Apr 2023 22:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIKKOE+VOdK97BL2rnNT0Vwx7qakUmy3+74D+ymL+fMOFD1sv0gdESWqmKUUwuO5UcwZXS7AHewBfnk5zcI/AvLUL+0bd8QvWN2PkVqTrTh3nPodZEQeGEhZoqdzUQcAC7tCl//iNL6HOFz4crWUOt0BNx0I41ZDMi5I3qgP+a9xSdgrHWSaD9lM/ust30SmUfVaapampDGH2/kBLgQvJUQ20HIpnnXOjOKIkIsdXhaBhnktZY8Z0xfoj0fM0SqIHmekPjbvNtPyRdshV+h9mgNb0Qw0rEysu2N4BdvaHQRoDodw/RxrDiXGBdYb7IwBKwrb/hUSehZ91rbeP730Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbRxI9+L3YmH2bpVyopU1oWQzrOFJwmmIVnikNSwsLM=;
 b=Q3i7ZG8wntUX2XGQ55Gw0mBKJ7HFb3gKhyn/tPM+IyWgmBIyeGsTB3+tNPhYFFXy59/2+9I9z6iJbb4cBnNrYUcGdBSfgOnnRr5vMHB7SGdqINGyzDCUWzaIhx3TJTNtmvqtc/wpRa2VYpos0dAARhytHzvj7/vYIZPywh0YMk4BjVgEkDAYiwH7M/JGchm2c6fjbEe/zmBrxuRrxFbmuXppxpIw9J+1qGGXBQbOgX56+O2LLh13qCIBaFk7VGb2ZAfEIhCZY3a7lDiYeJb+qlqB3tXSve5qHqd1WlP/154rEAxPRSj++Hu6ytHj6kbHFrjdtBgnoCenq8ftZ2jsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbRxI9+L3YmH2bpVyopU1oWQzrOFJwmmIVnikNSwsLM=;
 b=JR1scUTB/TKJ0QWM15ED0MIK9PP2f46kDHlyMIGDvWg3uKCmlplmII69nv8z8fZXvWSrctATe46oy8v5F2Gb3Gn6QROBbdqjf045XeqeGWtjo2jjiolA2pLezta/3dk2xw67Q1rJZwcCPOvNTTfVO1EKIAm2RPI4wCMeo23WzGA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB5877.namprd10.prod.outlook.com (2603:10b6:510:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 22:35:23 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 22:35:23 +0000
Message-ID: <3c11b233-82cc-0ab3-c099-1d6f43e4e1d5@oracle.com>
Date: Wed, 5 Apr 2023 15:35:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <CGME20230403083443eucas1p225993f889610c6c070dcb24e232aa526@eucas1p2.samsung.com>
 <20230403082613.owr5wshccoy2uw4z@blixen>
From: alan.adamson@oracle.com
In-Reply-To: <20230403082613.owr5wshccoy2uw4z@blixen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:5:74::38) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b2dda7-31c7-4d28-5b9c-08db36260b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	aO+XiO7Rg5Elo0ZJVG2jE3IDA865iauUO2e3ZGyW7/UjxQKOUplD1QjmPy1+NVC8Za/0GfdAnjnFL3dzhzGCyTyo75BTkaMx1srqpp3R9x2NFLMTF2Xq0DzlYoMjsKZaMWaVVIvrt9Ijku2GpDKnx78mxISmi07QchIta6hdhHKjUa4mxp6F42i9oja/97rlgk91MST00oIj9D1vaI0699vhkhe0zdeYhwbjUzFnq1yNrkgWDmIKjJB306/eFQVp6iX+vRge9tfHOfJkwkCsYJNTgzM0z7OHmJ5O+riPZcsyptoK8VlWgh3MXdy9AZLcmK9fhFv6EQt0FGIIiIa+TtTCbJw1Dalcb47/PrPNRKt1p7wod26t1QEZOnZCOhSvN97LNCWzAhrhtnOio02BNgQIELDaJ2qt30TB9KaftLw94XQcbgo3HPkweWDyLdiTbQcwLtlqy9KdV2I6+USgKaWQvXl5TygjATzcAVOax1yWn/a9rQJ6tBSPPW8zW5MHOW2fNs5hkJC7iqxitVM1ZLhQp43J8jQf4oCnNDcmEmSi8lmFn6M4ZEoPIU9lhYHFA5l92HgZeUWM+sssGt9S0fJ2XyLfUuozT/Eur0kjg2wYPy6abxZYeZ+wiJAAthUI
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(478600001)(66476007)(6916009)(66946007)(66556008)(4326008)(41300700001)(8936002)(4744005)(316002)(5660300002)(38100700002)(6512007)(83380400001)(53546011)(9686003)(2616005)(186003)(6506007)(6486002)(26005)(8676002)(6666004)(86362001)(31696002)(2906002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?MkdGbis2SllyYzZjM2wrM3FqQlZTS25aSUJWWHJqR3N4SDNLU1dHcWJ0QW1l?=
 =?utf-8?B?YmFHQlRYVkNBYTRJdUtlQWNJQkVxT1IycW1JNSttM2ZOajZEMzg1Tzd3K09H?=
 =?utf-8?B?N2psOHhNU1JFVjFOM2pNdUV5RjFQRTkwWFJrQ0ZKYzFMdHMyYnVwRnVjSVBM?=
 =?utf-8?B?eGZDMUtqU2h3OUhYK1VyWEhRWjh6RTlZTXNlUTNnL1V4dy95RDJDUFNXUncv?=
 =?utf-8?B?b3pvS21oRDBJVHNkTFlueVptcUlGVjcwbHdtdmE4S0FUTmp0R1FGWTVONGlR?=
 =?utf-8?B?U1hOR05IbkpxQ0l0OXM5OWhLMlJpL292RVVNUDE2ZGF6S0gwcklTR1Jrbmxu?=
 =?utf-8?B?YXlYNCtjZFByanpXNGVwVUFPc2tEeGVZU2cxbTR3R0RkSEI1WkdMNGRIMmxU?=
 =?utf-8?B?bXcycG9mOFptMlJkTDFQSWhMUnA4aWxsOEZRcG9wK09sNnZrSHhBS0ZackFy?=
 =?utf-8?B?aFYzUENvZjFJRG1aSnFDNUhRTXNIVTBlUTBhNzg3cUs2Qy93cjVWRGZhOW9y?=
 =?utf-8?B?RzhEZFdmbHRURldHb3k3ZjlXUm94bys0Qjh4TUdRODEyWStBanpPendBaTRH?=
 =?utf-8?B?aDdDWEhLbjNGbVZRa3Nnc2VaYW9GL0NPRXlRdnppTDFZT0srazdwL2xIU3Ex?=
 =?utf-8?B?Zm5YQnNMUkRMKzkzWDB6cVFrZ09sVkpCT2VlcTZkdEtudlRBaWIyWmlOQkkv?=
 =?utf-8?B?V2hOUk53ZE1heEIwd0xSSGFlNUV0NHRLa0JJQVVwSXBpWk0vdTVOUGJLclRR?=
 =?utf-8?B?dU9VVFhTdHNuZkMvdHZURXoyVUt2cDVHZWRNQThvVmhRaVlEUHZlTlliL1FI?=
 =?utf-8?B?OFNBbmZiU0NIczZQVmJseWV5bW54T1BHb1FXdDEwRVg5akRzRi8rdnlYNEhn?=
 =?utf-8?B?Vm9oNWFIdlVjbldrRVdBd3hUVjJXTzdTUlVjTWNqWEE1YmVXd24xbmM1U3Fz?=
 =?utf-8?B?K0drNTk1TjBpb0hwZDN6d3d1R29QRGhxN2FwdE1HZTZxYUFKSkJ0QjA2Qkxr?=
 =?utf-8?B?QUxqbzNkKzFvZFZ1dmVSM3prb0YzVGhGczFtNGxMK0U3UWhpeWdqZlhrL3Ez?=
 =?utf-8?B?SDRsRW52WTBuYXM4T3BSaWcrWisvUjJRWFBDOUl0dUNvZjUwVzBQMDB2Qml6?=
 =?utf-8?B?V2liWWdsWlhWdWZRZnVtZUkwa1Nvazc3NldaWGdMY1VQQmU3ZFlqYXdsVFBk?=
 =?utf-8?B?aVJtQzYwL1RiblVuY2NXbDhGdDRhcndwK05HOTVIcGUxakZ6aURlUVhITTVO?=
 =?utf-8?B?V2VZMDJueVpIQWhwT05vSnlWcnRzQXU0bmdWVXEwSDhCMFZsaTRKNzUzR21D?=
 =?utf-8?B?U0NSNDN1VUpJN2llWG1qTk1iVVc3ZUcxTFhON0tZdnNnTlZLZllzb21SOWR6?=
 =?utf-8?B?Q2ZHclZsVjBDSk1JMUpUdlBRa2Vwc2VwVEtFam8xZjArL0I0MHg2aFFtY3Ft?=
 =?utf-8?B?TzFGTVRrUkd1QVZuVUZiVzRwMU9UZko3Yk02WmpOZkhLOTJoTlgxSWdlY05P?=
 =?utf-8?B?YTkxNlJXdVNsU1lqNnB1YW81YWdPNGx6NUNKcHR2V0NlR1ZnZnMrWVV6SmFn?=
 =?utf-8?B?QmJ0Z2ZQMURuZ1ZIaUpTYUt4cHRxNVRiZll3NTZzQzFVY3F2ODNqd2U4L29P?=
 =?utf-8?B?LzNsZklTL3dQWWxVVGpEWFdjV29IdEVEV25jZVMxMVZDSDI0SlliUTNjcTZU?=
 =?utf-8?B?M3o5Q2pyUkJraHN6WThycGhLNGYwM0c4Znh4d0RNaU1mUU5VK09OU083NjVW?=
 =?utf-8?B?Y0dXSTFhWW1aV2NJUkJwdFlpa0Y4bTdYT3AyLzBXczlKNExvK0ZibTdZY0I4?=
 =?utf-8?B?MnBZUWJhVDBzbWhCQm0zQ3A2NjF0T1YrQW5yUnM0N0VEcmY1T0cvdzgzQXMz?=
 =?utf-8?B?VG5PeVUrRG1mVXY0RUZ3WWZUcjU4cElySVQ5dWpLWC9WbjNGVnpnUXNpLzJR?=
 =?utf-8?B?WVdZaWZQQVhyRVd5VGt4YVNlUjU1dTA2Y1B4SUtWVVhzMVZwanI2NGRnenlL?=
 =?utf-8?B?RE5KdHZOVnk4VW9Qem1rS2g4RER1UG0wcG00K0ppdWE4VDUzSVA0c2NUY20r?=
 =?utf-8?B?T2VNQ01KdzRwRXFOSXRaSHpPWWFuZENqSllnbnhQTi9FNjRYTFI5dGsxend2?=
 =?utf-8?Q?XoZsOh202tDmDlxMYiGYxWZJF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	zxGDNoSKd2A3LOMVNjcjINiDUFiUNlA2R4ygEMZVcI07wP4nR+xr8Pux5tDUvmKIGVl70MY7yyyRK+6+NEYf73ozd2vJmHRfn4RC/OY5Euy3ywH2FDUcLAZ7VVPFcrvnlJycUqs+CQKsxjDTd/Hx9m1cBq+lMts1FQh8EAKRwRreCTnnOUVanbFZ4dYTgPg9S3Un8YYfU3W33C6ucp+pcjs52anwmtB9GKffBRWenPsaX+o0pRBg3HoGmoPBOF6i/ZGXwIHcZYRUUbWSuMW1FkTBGO1FJb5P+9iUa4G/9cPoYioHp4ILqqY6P6LN3k58/lQn/+1PpL6XCaJ6lMCdlX1CWiRB3DTMQfI5o5ZyfENbD/LEjjyGPapgyLNzBZP4qoe7pZMUMm8VSn2xaShLj2SEhsCYzdQTTDQ9bgTS1+pFwXGInySIo7FtyyyigfRv0iSHuuzYcbXiCe+KItxFzb3/3G/whIK77cQCxMhDgVkvPwaKg/qWUdQgVk+ez0i8DVcZiWk54NynsDAjo0VVcaJ3ZvzH8YJd9LLCW/xgiGJcG/n8cKZBQL3t4SbzE5BFq91SXfvU+e7TYivwaYF+IswnlqlJpkmPLi44RH2byKY/5CptUaaX3PmbbyjtLUgkwzguFserjfBHTdoSalItLh2dSrldsi8/aGzxlhJLKKF9bkq1j8Z/AvqptLA8VlizHFBGQgpOaTdhZnmw4CvgBz91WFT2L72JGMoN0l5ojH5m7DDuxVpuq5vC8RbkNVljaD6WuPuTFLGFzk3iXEsn3x152t7r1oduWecSyWtPcwy/9EbQAdRgtVeFpULbOzwYA6nQ4zana9CF9w0rW4bEh6q/17ZD6w1Tf//A5//Pg583ls3n4f9e+oCC8s0HD8fp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b2dda7-31c7-4d28-5b9c-08db36260b46
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 22:35:23.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ5bz8oihVNOpp6cBHSEwA9SN/Os5wIopIgmZ3xAcjmcPFzvoaKuNXUA+roc5vDMd9WJmBir3/SnUDA2J7m5hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050202
X-Proofpoint-ORIG-GUID: U-C_ZkGVApvBac8yeGg7Rsd--0j8Gs4V
X-Proofpoint-GUID: U-C_ZkGVApvBac8yeGg7Rsd--0j8Gs4V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_153533_793620_6BB37A03 
X-CRM114-Status: GOOD (  15.84  )
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


On 4/3/23 1:26 AM, Pankaj Raghav wrote:
> On Fri, Mar 31, 2023 at 03:18:23PM -0700, Alan Adamson wrote:
>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
>> logging for user passthrough commands.  This commit adds the ability to opt-in
>> to passthrough error logging.
>>
>> To enable passthrough error logging:
>>          echo 1 > /sys/class/nvme/nvme0/passthrough_logging
> passthrough_logging is a bit misleading as it doesn't indicate it is
> going to log only passthrough errors. `passthrough_error_logging` is a bit
> verbose but it is more apt for what this sysfs entry is doing. Maybe
> an abbreviation for passthrough_error_logging?

Since we are looking at only opting in to passthrough admin commands, 
how about we call it:

/sys/class/nvme/nvme0/pt_admin_error_logging


Alan



>> To disable passthrough error logging:
>>          echo 0 > /sys/class/nvme/nvme0/passthrough_logging
>>
>> By default, passthrough error logging will remain disabled.
>>

