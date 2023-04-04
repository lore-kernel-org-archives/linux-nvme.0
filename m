Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ADFC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Apr 2023 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucbQC3uGGCnYjtuQ8fXoUCJ3ybLch/takUYlve7oNlM=; b=BoXRTGbgfDBPUnGfJuSNXHjjj5
	95VuNiJ0/fnMx/UHjhsJOfQNT8L5Oe7D5/DmFvLN+w7+bPO7ZblBhnIqpm8UEc82kkHx26wVXVyru
	xj84GJ+jfczJpqXzeRTFQNTnUamT1ybJBskru2zSLns1Of8qn5zHKc0KVvHn2ZLITfFiZihlo8Z6/
	nIHAVc355kgxzaFq46WakSfd4oxHESs0SFfwqKqhUvzOyN8Zci5MJSQGeVF3KRrtXZ9SP3YHsnTRt
	jRvp1MoloSuzk9aLNO2PSwEiGlje1Sge10qUO9AH1bzU6+san2mhq2sK1dA3ZPCW5d9HazPQL4yKx
	tAgvi6fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjjP1-002BGb-0y;
	Tue, 04 Apr 2023 16:20:59 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjjOy-002BFW-1F
	for linux-nvme@lists.infradead.org;
	Tue, 04 Apr 2023 16:20:57 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DuLEd029039;
	Tue, 4 Apr 2023 16:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ucbQC3uGGCnYjtuQ8fXoUCJ3ybLch/takUYlve7oNlM=;
 b=RN1vGE8h7qiUVoJW2Ir4/z2bkjTioa2Lm18nkFUOjnnCqZ1F1EUKYl81bajZITJpAXAE
 Z9oUVjlqELaNvhN14rfGfwQ3fO1nhhidzR+ddKPLYgGEOpDAuYRSVCoRK63Guei2lxBN
 0JqETUR4RIjCbkk7Nutgeo4f63PMUOhIMgQwrdFUWOYveA75mRcFVcP1vMWv8mZtQDpk
 /v9wnnJT+cf/7QKdW2NdTLpjWhwe74mZ3b/N5uv7CesRSjDgQZ3+DUa+DXt5g+ZbPg9D
 9R7huH3N8fCxB9R3oNkn8IqN43RSAWBTQYympPuSlPv2X6U2mhfeAPbMdvEWDZBM88oC yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5ue911-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Apr 2023 16:20:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334FSqti037722;
	Tue, 4 Apr 2023 16:20:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjscc93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Apr 2023 16:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/qQzKsdKqZumy8h55h0CwxViyVJuxbuxEA6xFa4+RfZpQU6Rp9gPhMGVDZ6t3NRbbU1bq03mkK1k0UEWIw4sj851fck807XlEAZGdIUTl3AzO2+52X5VR9L3NauMsA7qCKwVS5ACGlAgXBs3I/R7cV9eYNHKppeRKaB+ZjkDLPNFeVRY4oe/4JmbYdqC/o4JsG1WvgS2CIPxxTWHB+vLrxKZ8fcNXu83Dq+2rEST3ps6SF/6qGxD5ie2l9QKGXLefRtBPk45P3T9mavb3KwUQMAhVwBRHWcsm84RENmkyM4vP9pGE+GMsKmBCB+9fxN6tz90SHpqzk/j97lHjN0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucbQC3uGGCnYjtuQ8fXoUCJ3ybLch/takUYlve7oNlM=;
 b=VUyQw1uhtDQhdha/3DzyhGD5dDqksDjCOyCq/L7ZLXKwbZ8h1SWrifYBsGsd5LC5iD21jDQ9x1eSxnQWF1pn4AWya1v8T7cotHCFKB+t2qrvsOFsAVPkLTfmkbniyeTioN0QitfzYep73OC4BrQzfwz/1+EbZ9VAgbitU6m6e4Neoh3aIp11pXpzDl0fLQsosKwqYH1KakxFutenRjG2JBPb2EcEq9Fj6kEO1zoNawPVoFGhUwML5PFnzaWeeTn78rCN06X1cm3pHsnU6qYP4lcYpgKEjWCPFcCZEXT0Ypv3MdQkk/QIfFjREerkhmr8zDX5Yj/bvDdUfvB5eqnsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucbQC3uGGCnYjtuQ8fXoUCJ3ybLch/takUYlve7oNlM=;
 b=oqgIU9E/tONGhgXCDQe5wf81f8lXZkKIcDqgUqSc+6E/+hLli3mgZcrXWf4gVkOFRkaiR9AKRAHaBKzj3RU4CSc3EXF1lem6IuaJ4T3AHeFFxw/nspCedeJTMFTSq7duizd55PyE1xhNl61dmT0A/fLP28sK1K4g0dcYU0XN/EY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:20:44 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:20:44 +0000
Message-ID: <c1aa9b1b-5a10-8dcb-9a9a-fce1ff8a5097@oracle.com>
Date: Tue, 4 Apr 2023 09:20:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
 <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
 <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
 <935faecc-e000-3d7a-71ed-7517b1f4c299@oracle.com>
 <588e5542-9076-d1fe-c1cf-ba60ef3dd1d5@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <588e5542-9076-d1fe-c1cf-ba60ef3dd1d5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:806:120::28) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe7d7ea-7bef-4b3f-3156-08db35288a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	irmXWmGcGcgSL9TqBIH7GOV6D/hIOlQgR9+LNyl49ZGEL30FfoZeIBAReGM0MKNMtqMH1JBNx/iY7QvCOdYgAb20v5glqBf9lCfHprKMnCKseXnGdtuvZOvsJWT66vc6LfARUovXrUEq8NCXv5DopWHvrMNMpQF3uW7mZnGTWFbNKDtQ+PoUMKg1gmWswZxQLWbDU88NuqVBC/KUsbLyLbvE6JcGYYRErJpbDfHU/BV0303ZzW24xqz9pvJKg1NoyjUWt6WlpInTP5e5omqi1lcbFX373VhehMXSqhTH+Ko3nlShFBKs4ha7uzyCJUY5vinPRusymQHcDBECcuoQpVTy4tVqlwYo2/9MSVlZDkQaOifGA3/b9xzA/imE43O7H7U40NcbT1JllSNwlCLbDi3IIL7Vyvs1DOwt2hJs0X+uJfYodcQIth0T0I97zRD84Yo3dW28D8DK6LdZoFKmRg7+1oa2Kxj5EReAk6EZXJLDJ+IjDqMgVlfsogxGoJ1ywkig/QIyiuvvou8nUcZEQmPzk8vOSFJ+81PrISDdu+UEasK/UGS/GsQGi6IwYUkS5QEt6T5UE6tFLXuzl+jGpJdQTZ+FYn+uRKQuj5AZnLDS1y3mQPQ8MaY8VSgp/I9N
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(2616005)(6486002)(53546011)(186003)(83380400001)(26005)(6506007)(9686003)(6666004)(6512007)(4326008)(8676002)(41300700001)(66946007)(66556008)(478600001)(66476007)(5660300002)(38100700002)(4744005)(316002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?SkxDb0VzVk9oYVMyR2ZGclNFWFpDK0U2MXI4eVpDYTAzQURkbExhVjVzNFM3?=
 =?utf-8?B?TldKWmJ6eHd2YXl6Tm9pQmE1bFU0ZDlBZU1pZEV3M3I3dGp1ZVhtUHRETnVj?=
 =?utf-8?B?OVVWK3BSMnZVT29zN2MrTFVWTUNmdWJyTkVyMW1IYi8welRMT2NIUTNnVi92?=
 =?utf-8?B?aWNKY2wvL3dkRkxvVDNaUXA2UVFqYllGTWVDa2loVHBTcm1jelIyUSt2em1I?=
 =?utf-8?B?OGVWcGtIT2J3cHNzOGJvaVdRRDRyUlI0eVhKRVVjTk9wZHRSWG41OXRSMk4r?=
 =?utf-8?B?a0hoa1RMZHhjUU1oNUllVlplbUw5aFpON2kzd1RmMlhhSWluVzV2U0VuVEg0?=
 =?utf-8?B?Q25vZURWUTBEUTRMM1hiU0JPbGx1WlMxREhGVk9jNEVEQVlxaTl2dytVd3lJ?=
 =?utf-8?B?N1lhMUpXcEl3MTdrYUd0UVk1SlR6WEs0aW9ROUQ0U09WcmsrOUdwTmpHci9w?=
 =?utf-8?B?c2xuZ1h4UUl2RitNK1paOTNQdmdzN1lRWkFIOTk4dks3UzdPQjVGM25TRnVV?=
 =?utf-8?B?aDFLSFJERGY0SnQ0aVByUFZmUSt2djFOSHd2WGtta0RDOXJ4Y2tmQVJTM3FH?=
 =?utf-8?B?Unprai9MWVk4U3JZVURRdTh2TVhaNFZMUFR0alh2UGd5a3ZhaXkyU3VFd09L?=
 =?utf-8?B?eUNWOWFBdTNFNkgvTVpqZlJja1Rab2xqYmlkMkZ6VDNmay92bmRBM3hFNnFm?=
 =?utf-8?B?dy9xODduTW9ZRmIwczdhTE1zZUFRdUowV2dSMzVrVGdMVm5rc2pwVWl1R0pY?=
 =?utf-8?B?YlRmcERiMmMvTjlmREsrUjZGcDhyTWxWTjNkSUlqRnZNdFNZakFIM2pWM0RF?=
 =?utf-8?B?MmM3ZGoxU3ZsaVZhaGp2ZHBjN2RqclpIU2xVSmNSOXAvUGxHSVBiRVNVdm92?=
 =?utf-8?B?c1Y5eUNsODR5VS82aTFNODdqUEhWd3lINWt1OWU2WC9sbGk3aXM0Y0VwRHBD?=
 =?utf-8?B?UWs5NkppZ2VJWEdMK2R6cjgwZmRVdnJXbWRFYlRxZFN3QUwvK3JPMGc5YkNy?=
 =?utf-8?B?eU1CSGkydlhMMVVaMmxlWnZQRGpEQkFEckcvSDhWY3pyOGs5NGpqa25Fbmlw?=
 =?utf-8?B?QlhOQ3EvK3F3UEpiRkVQUkpwY1B5ekcxZjJWWEtDakI2TkU0MkIvcXpPeHVx?=
 =?utf-8?B?RHpRWUtIeDFHNW5FL3ZCeCt2ZWlla3ZpYmVOcmhRUUEvRzJhSEx0dkF0Z1Vs?=
 =?utf-8?B?Nk90REFTVG1qN2FtVksyTG9kUS85a0dSREFCN29UM2Q3d2tSVk03TGwwYjNl?=
 =?utf-8?B?VmF1amswMzVkRnRHUWxDblltZXRxZnkxUjJORHErY3Z3eUJ3U3hxTjhRUktn?=
 =?utf-8?B?aWo1T0lvd2JSeEs0MGMvQzUxcnhTWmV3cmI3ekdQT3RUZmtMeWZxOGgwTlRT?=
 =?utf-8?B?R293eUpkWlJ4REVzcXF0aGE4MW04L25wd0VrR1lNQTVkdTJPYXlWNmlPdzJs?=
 =?utf-8?B?aFBsaDVjVHIwR2FJbGlEemlERU5EaDV5NVJtdUlvUXJlV1pFbTE4VGdtYnVW?=
 =?utf-8?B?VTVFVWUybUNLR2ovU1R0V1ZET0dPTTFpSXlXaUlTQWZCM3ltMlcwZFVEY2py?=
 =?utf-8?B?VmVtd2tpdWtobnpGWkIvY0dwUDk4clJkcVNTTys4WjdDR2JTUDZZWUR3YTFQ?=
 =?utf-8?B?OXI3TXRKdU1laFVUcEF5Zm8yeDg5TzVQS2R0MDRzeEVqZWRZM1dIc3pORFpz?=
 =?utf-8?B?dFU0LzJsc0xUWmprYWhnMXFxQ2pPTE5uS29aYzBaRHhFNjUvb2ZkV1FYQ0Ez?=
 =?utf-8?B?QmlWSjgwU3dMSCs0N0p2M1VGeXRVVnpxaVUvUzUxY1NwbUM0WGRxcW1zRmJx?=
 =?utf-8?B?TXVnSlJaV1VZRi9pV05IOEVyd1NpeUZKckM0R3hHSkNRZHcvOFg4ZmZWd1V1?=
 =?utf-8?B?QjM5WXdhTTZmVmtCQjNjNTdYdnd5RVpJWExnMnlwMU8vcW5HUmJuUlJEZXNW?=
 =?utf-8?B?Nlpxb1lDa0Q1eVdyaHlWRGd0blFBUnNyTUVLNDJ3UVlOVXoxS3hNWG44aXdU?=
 =?utf-8?B?NnZyNjE0VDhSak1ER29tVzNlV3BmWWd1ZUpGSU8xR3VZbkR0NHpKWmdYU2J0?=
 =?utf-8?B?S2dLR2pOeDVCNmtKYzdxdmtBMDFwQTZLeGlOK3Y0cnZqQzd0LzRVT1B1eFBp?=
 =?utf-8?Q?o6cPBiwGqK3YjRkOKJII02tA1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	uxmeHhLOF96dPSOq6DdE+8BtpADrKPOyn2pPnpaGXPdiIjuhDvUFjw06D3SWgA6LjZ+xAOe9RdXM9MGQmiigFEgDN5TDfGZr3GfFkmftLSOFGvpJ1k2NHBE4j8+oTjgaetWuzD7iiYK47B/QkjK18A4FhAKLiBJk7VkKbV5gf6ZqKNvDuKi5pwMAZdbIiWuSNig2nc7NGyh8U4qxqccawaYnFzfQXo/jKpq5jJXB3ANntFbty6q6aA0eZBPadIAiz98JfaUxTFCZ6WQXyYn2Raf+sVEEVQwug3lA9R3IxQqQ9KwFGxVB1zzlSc5FbICNnJJiYh0j/VEjWeIqgWfhz8+/RIZVQCJR9A/WUFxYbJYNpvJSgvyEaOxbO20rf3XvwZQ9dJtU43xwvf63YeDmzpULTfbVtMylxRsIzEr0Nxo5DKeArIhEk9i9lpHH1FhBAGGvSVzAcyhInrbNE/ilRtqaGG75JuTTpI3J83E0KBoklDU/CTkkfN2gbNSZCxegOGglmnAIlYLlpQfV3mqYugadEdxzUPJA7HDdfVfspvZbNHtwiU2qXTMxJva7v1jw8hMzfMvFYnKW6jzPlPtur6tVnVvDNjPQYMrbmX/ZfVMqAU7HZKb53FAidDMX5jPKdfgRvn65RdHBlntb+kDx/tXUBUAC3xfXFLyBmXxaTE4UNl1Vwgo//v/wp7hc7JhvEwt8enSCBMjeiUBJzptzUUbgSfaoVQhqBZqcZf/WLsTEp6/3/4xy7m/o0EHRSwcasRJZHyb2Ue9jZu5EwRmZ59VNFAgBOG3qJFlQ8qAOKjdkO9dvjJUOHZDPN5ICJnVZPBZCWdYJMKa63xhctbpF/RRbB9J3W/O6Sre49W9J6/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe7d7ea-7bef-4b3f-3156-08db35288a38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:20:43.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARTGkX32lhwVTngeKKzeBoBbDBr9vMHC7YVyJLAqeVVDgVdxLJ/trBxVFpOUUwJR75XE+rnKlKkWzDy/JsrDeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040151
X-Proofpoint-ORIG-GUID: 6BFP644-tzPBCtk7jh3qi-nPhpUCnW-V
X-Proofpoint-GUID: 6BFP644-tzPBCtk7jh3qi-nPhpUCnW-V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230404_092056_454221_C61EDBB7 
X-CRM114-Status: GOOD (  13.33  )
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


On 4/3/23 4:29 PM, Sagi Grimberg wrote:
>
>>>>>> +    if (!nr->ctrl->error_logging)
>>>>>> +        req->rq_flags |= RQF_QUIET;
>>>>>> +
>>>>>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>>>>
>>>>> Question, if we already introduce granularity to this setting, why
>>>>> not per-ns? why only per controller? I'd think it makes more
>>>>> sense to do this per ns. Will also remove access to ctrl in the hot
>>>>> path...
>>>>
>>>>
>>>> Meaning we should have both:
>>>>
>>>> /sys/class/nvme/nvme0/passthrough_logging
>>>>
>>>> /sys/class/nvme/nvme0/nvme0n1/passthrough_logging
>>>
>>> No, just the namespace logging, why would we need the
>>> controller as well?
>>
>> For Admin Commands?
>
> Yea.... you have those...

For namespace errors (read, write, etc), passthrough initiated or not, 
shouldn't they always be logged?


Alan



