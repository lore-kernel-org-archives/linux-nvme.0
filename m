Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102DDC6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OglgKlQPvokWxtGr8P0TlaIO1c8oqm7+/RFO3OYSeUo=; b=Vk5czyit+W2ukF6uXnpTizLPk/
	C1bhZ48RYq1Z6C2xizi9gCjnJYaCOc/+eGFKqoYIbhzYpdSxRoh4wmvG9+lu1ExX8dHDGizLbPhza
	/RDXOCsG8BVoCnv1RMzL5vA1Ij2961IYAxDJVcxz/gi+bHDkfpKt/dZ38twV34Hy8wyTiWvzd84Wh
	nOMhh4PYFk3adcih9yEiwuWuCmRC1yTx4l2tG3i73peX/oFHZ+n005e5l5Nfgg9ShpamoU38G+FT1
	vOx2zIf5MJhecO5DFbwdIwfW71xMFMpzXokRFAKgQw0SuQsa0/4LXUydg9cSnZgMqkCf8cJC4u3uU
	X80TZriw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phG6a-00Foho-0k;
	Tue, 28 Mar 2023 20:39:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phG6X-00Fogz-0P
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 20:39:43 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SKTpkI020420;
	Tue, 28 Mar 2023 20:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OglgKlQPvokWxtGr8P0TlaIO1c8oqm7+/RFO3OYSeUo=;
 b=rEM2811CBDp+ww+xeU6ltc5cMeBdWmSFx57rtY84XsemPdMoJuUdj8ITGWsdIz7Sdk6C
 uC+8CtaOCWTQhO0jKLuYfAVgztA6ywBUn6Y3pii/Lr2JvAkAiQFEaqan4O5yJ1o4i2R3
 +DxzS0cV/8uQ6ojBH3h518HwiuwldyzZXIpJ7lAcbcWHafW51mN0776HdTrJrQwf8AQh
 QJdtwfjnmzDENL2HJJy1YDvuP+/xNTXlMc7uDeAVBH1wL3+6YOrGbc1D4Wo3pkxzj4i2
 BN4JmHXJ6YHbWs92jqgW/LbYXZSbCXjVQiOWrvJg5qScV7TRptlxj21Sgk1Avwb/iFTX Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm7aw00p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 20:39:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SJO71G010194;
	Tue, 28 Mar 2023 20:39:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqddeyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 20:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0MbaWYxswGlvS8T9HjlzE1tVxoQ685BwqP6bPAe4rTy24vmnRoOU95XwwfL4P9oueElmae7MufqTEwIb+kywkVB5Xgyy6+ME0/g11LLGR2cGZVxwaCPNvXLDsNIIAYVa1Gn1vEbhgr4oKudxWF5bnXxsP2RQlRHPfkuubrkrI1p9G8hyQn0Aq4NPBV8Q1tP4IIz7UoSkTdEIs5OO1cszYy/5I5lZDnIeuAywWa+z5Gxtwzcl1weU6VL4X4wbcuPB2uabb5ynxxMooclsltACWyxbGXXVVC036Z3rxlURl8C4quIdlILK+g3CILebvsVHy+dhWGrrBGkyxQWL0Q0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OglgKlQPvokWxtGr8P0TlaIO1c8oqm7+/RFO3OYSeUo=;
 b=FECMurEg4n0+mBOKcGLeQw1v/XBBpLknKHv+2UxSkp85n+6l5a/ERgjsdtPKOz9rtebFoDS0otSarRMahlDZh5wHn2CkYCv4aCn3xk0Gq4Y3AsOW+RzfHhbgYUALpU7iu4QcRtxSNRYBTYAFiyoRXY6TlOFoW0VOJQxw1t2xKWIgicE1Pc3x5hjH/NOkiqzf2JjqkcFE5lUn0Oke2zhtfatjrY+3CPSOnVDDLIOaz7z8u7Wz5boaB/XEBqw+o+QSA5BRsA6bey6iBoleR3ZoKAFwkl3LbrGcJHcL7zPRAASnZZTdSSTNe03OKHXtTkBIbP2OW4TYlmBvuvoygsKNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OglgKlQPvokWxtGr8P0TlaIO1c8oqm7+/RFO3OYSeUo=;
 b=Ks3REq9r11+SASF9TWXT/knwTS845e4U9//+9DdF6QGrAIAa8e1o3uvPP0eZiruTpjEJu9RES9EKem+J40kGNrnk0YrTcFvWBQp4SVAten5depCUYaHxrnxa/5R5Abic4BioL2OracpYp0/C84qjlFeRjhvL+1B2jy3F2n3MhJk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 20:39:18 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 20:39:18 +0000
Message-ID: <a895a713-2412-e198-23cb-a5d3f90ce81c@oracle.com>
Date: Tue, 28 Mar 2023 13:39:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v2 3/3] nvme: ignore starting sector while error logging for
 passthrough requests
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-4-alan.adamson@oracle.com>
 <20230328005529.GA21497@lst.de>
 <30e218de-a6ed-6f5e-500b-212f918a6cba@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <30e218de-a6ed-6f5e-500b-212f918a6cba@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 17764aa0-96c0-4036-984a-08db2fcc808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	O9pn5nbwePuxs3pOBZ84qkLWe4XOJdpzyTvFEUiYvzMAFNXcF2TvqNogsZ5i1t1Q6+XL8F28HaBwAJdLELSjAWbvDJQUetAaoFrA6qrQdTdscl5um75JUAgRsCaDq/OzCGxD9+ImA/zkLcKirLuPmysYOJDUE5HRikDzr844xS5cCGZRSQ9rvEQJlKpP9MRhsRzJmIvhTSsUzdbeqqRmVpZSALtQcis8n9Xt3cHgE1dx4ozjtEf551QwmJaAD1mlOtWF+xWkHe2gwkbEodE/GLTBgEkG4C5VwP2kXIYFQiT5RP5YYNPcypgLyn+eaVeET+3zzJbUu7U/whQiLsjOAfg03fgtXKh0WQyzbngBUWXT8g0SQ4MKeQ+IZDHOTWM31eXFGc9GYWm6CsPkM7JdYTSUY8inR24vsKcI5w4W9y8/R4YOrXNjFDsnW7visezyQ/KanU9ZuzTTnKy0cvUxis6y6oHgdShC3R+6uwHZcjNeVndoLw84fT0LS3zj0Ocm3chOrE5ZMxQhO3BF7oT0bxSgRPvIZppaDlhtPmU+Sj1h3U3xUHQ12ZXf0kWqCpGnfTNKY9c4EJ3vCHxWGuHndwmYcDa64UJfSu4pN2wCSOfA4zoI1Zhb1D4kBZJnWj/s
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(110136005)(478600001)(316002)(86362001)(5660300002)(31696002)(8936002)(36756003)(2906002)(38100700002)(8676002)(66556008)(66946007)(66476007)(4744005)(41300700001)(4326008)(31686004)(2616005)(186003)(9686003)(6512007)(83380400001)(26005)(6506007)(53546011)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cUo2S3N1cVVxUjJyVTZiV2h4bzZPN25RcmdEeVFQVWlGbHRNWXNDWmNNY0VE?=
 =?utf-8?B?aThnSGl5MXNiUUdua3VvL3RvUGxyNWkxNjNzc2lvU1NXL2lpZWM5WTNBQW9X?=
 =?utf-8?B?SVd1MU1kNWpvNSsrUml4UEY4ZnVEZ2R4YlJoVStGK0ZxV3QrOGtCVGlXalFr?=
 =?utf-8?B?eWNsWnlQeElSZm9ON2NMVjk0K2tFRzc4S1pJQXY2UEdDZUwzbE5BRWNHU01w?=
 =?utf-8?B?K2VWd2Rick9hT0NlbTY0U290RWZrRm1JZjlwZHRLazRSNXl2QzJUQjhMWUdY?=
 =?utf-8?B?Ky9LNFFZWW9ORnI2N2FEcm81K0V3aDViRnhrSWZyVlVlNUU4TkNmbDd3akp6?=
 =?utf-8?B?REV4ZzZ3cWRsQWgrNVpycmVNeS9aakZEUldxY1p1ZG90ejFtbFNQMjNaSk1F?=
 =?utf-8?B?b09SNU1TT05HQkFZdlYwOGdDZXBLeEZRa1JXKzNtUEZBRDR2NDRXU2prdHBa?=
 =?utf-8?B?WlVvZ2UvMkQ1dysrbDZUMm1jN1J5bzJFR0lKMG5DZGVFcEg0SG5qZ091VVNI?=
 =?utf-8?B?aHY4ejVaUmczakNUM2VCVVRKV3B1Q3VSQjk1UG1ndkhUNkpTQ2l2MjVZdThv?=
 =?utf-8?B?UkJKQnBUSERFMDd6WHJJcWVqZ0lNVWRROWdibndJWm1EcmhUa0lsM3l5UUU0?=
 =?utf-8?B?YWxidG90NkJkR1pZMHNKS2RqR1hTckxkaGdJREM4OXFueGFvOTNzVDFqR1BZ?=
 =?utf-8?B?Z1RiMDh4aUNFL0pDdzMrbFNXZ0RlVDZRUDJReGZIU2NWMGVLZlB1NVBBTVlC?=
 =?utf-8?B?YUM1Zzc2cHF5VSsveHA1N09oZXJTK0hhalppN3VCcHNROC9DeUVIU1luOEk1?=
 =?utf-8?B?QnZGdjhSYTQ3MVNLdFJ4cTRzV1RTZ1ZBdTlPY1hQdDQrSWxSQUQxU2dOeHRh?=
 =?utf-8?B?WC85ek5LNUpWR3ptbXMzMUd2OW8yVTdwSy8wSmh6Y2Q2SmVsMytsU3hnaG1B?=
 =?utf-8?B?d1hkZ25Hc0U1UHlXeTVyeHpnSTR0ODlLZkJqRm9vaFRkTk5ablhHcjlCZUxX?=
 =?utf-8?B?KzVacGNMYmtiMnlLd1JhRUtoYzMySE5ZQkh3SitnZ0dwdlBsRXVZdXFNeW1F?=
 =?utf-8?B?ODlpWnRib1V6MHNIMWVsazhXWUFPNFpaNXRsanJIWkF1aXhONmd5cWFyT2FM?=
 =?utf-8?B?L3RodWM2R1crZjZyY0ZvSm9haEhOcE9pQ2kzbldOOTREOFhyQndoZ1pmcHVY?=
 =?utf-8?B?eWpveEsxZGY0NEdtRWxvdkh2dmxwNnhhUG82Ty90NkFqWVYvelBibWF1YU9H?=
 =?utf-8?B?Z2hoSlZnQ0QrNFpHOXdxTGl5WUpnRHVGNjR6MjV3eHh4WkxVNHlxSnJRd1p1?=
 =?utf-8?B?N0tGSlBaeWh3ZXdxVTBYT1hxb01RRi9BZGVxOVRZV3gycUMxUURHR3lxSGZH?=
 =?utf-8?B?Z2p2SE8rYXJBdGdHc21BQkZoVkt2ZkRLdExpM2kweGRJNU1qQWNoMWxEYkcv?=
 =?utf-8?B?QXdpRGtORm00eHhmckF5aWk2QzFGdUt3NVVuektUVWRjUHY4a2VVMDBRTzI2?=
 =?utf-8?B?MjNsRStrN0NwZ1k1emFiUzg3MlpkNnh0UWoyVEQ5TzExVVVlTDBkVWRsWTBX?=
 =?utf-8?B?Z0trdVVzTVRRZXNsZWkwRjlvRkQxVFh3NU1JT0p6bGFndGdtOERxVHFncE9C?=
 =?utf-8?B?ZnE2eVphV1ZNOVNrWVNsa3lpNW5aSjl0ZlpwYkRwQW1nU1dHOVM0ZDh6Si9S?=
 =?utf-8?B?SU5LRUhGeTNUZHVqNWtUWE0vRXVoWUZhdjcxOVV3Y0dBZEl0OVVtaDVhUHJR?=
 =?utf-8?B?cW82aERIQ0hRNks4cXRPQVFqS3JUNkNaNnM4dHlJaWZRenAybk54Um85Z3Rz?=
 =?utf-8?B?THl1WGREVldkZVlBTDJmOTcwUzlmcHpMeGRSL1dHdmEyNUJVMkJ6SmhVaS9a?=
 =?utf-8?B?WmNTbldSb3hPb3cySTNxd1lsMVVMUmt0OTc3RHNaNkVndHlLUzk1blhDRTBD?=
 =?utf-8?B?THp2VmpkR3Vtc0Z1WTJaNzJtZFFFSTZSZUxPZWFiaXpzVGNyNlgzbmFaN0RV?=
 =?utf-8?B?bXNCN0kwWnFrQ3c5cHBHcFMwWFg5Snl0TDcxVTB0ZWdST0JMbzVoeDkzc0o0?=
 =?utf-8?B?Znc4R2ZGZk5BL2F1dDczUS9Ra2dWVUFMVmVOdnNiVkJkVHd6OGN6clo4RGl4?=
 =?utf-8?Q?zGcUXtueLzNiZ8BkV9rZd1gML?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	u8CGuDicNgSWHUew7/scqGsNNypVE3Rl/G4QbbhwtkChPyLzdJxgxDos32LAHf5gJSN5cHGfMRRrf+TyZUxsuP8WhbP2vfd7fehhsWW7Q9Y4d42Ri2b2G1HFWXdEX6zUg6o9d+jCcpwp+zQu8ldfzxzlUBIxflorEiuDu0WkDllYUZl7JiUKHoMzfsJiBI3kNZNy/epl0SfrgNTyBrXOchcDEqd9YTWm71+0HOKile1IbG15hiC66siTKDfBRQpmZrYkCrHsPHDKail6bD8EzVaiYUnccYMUcb4lO5btigeL+nwbPdfb/HnwBfBUdJfg/OSLbfFVFekV2CybL24a9TCTUlXNtYn99XacvsZXMUYxzzJiCG0zbYq2prD1rYooqSpVV+Hm+5hwqVnB83vQjLo8DTN3WD0taTBcX/7j/iQrBNqXNlTdqZkTikNAgzhvTtMEimSpklpSjdgzxVT7lccWY+lI23zlSlLpbWEMerFAsTCDUHjm9w4QrCsZyUsmsSKAapzin4fSmsZsOBQkPWwB8zfJJQod5dF5a0WWSAowOijDwqV4PfbTFqYfQk735LNDbK3s31NtrveYZ1qcdsEgFZWTW0CAsF+KvIEvAmxgRGC/OjxhKc5s8ea6/0xZrT5iKW34YYbH2JGswVhUCoKPhVe+CBktxNuMt0uKywZ/JHxN92XaRct04TtGiss/puV3Hd4pH0rsmoOQqugmw+aKhw8Uv+i5w1++upsSCaUcDqE3+Cl3ZteloMGZul86ltcuKc7ID/NyQ/3FtyzbBmpOS3mx/k+4q5ZdpSuoEP6lbSMecDzVl+hCWE2amuGMdEfh54zvLjuKyQjtYzB+D4Fun2JbdQ5Cf/LcSkDHiAB/zI6wIZsLXI1z16cI/zDa
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17764aa0-96c0-4036-984a-08db2fcc808e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:39:18.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JXkKVM+Tir7omcfSghHYUaISjHB4kd2PZbGk5zAq6mnEX0FZy+LeW98OskdXfnw7LKYcKsFQO07aBlwq3Rscw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280159
X-Proofpoint-GUID: AgPWha20YchowBqiFdfIVzkZLexa0wPe
X-Proofpoint-ORIG-GUID: AgPWha20YchowBqiFdfIVzkZLexa0wPe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_133941_648731_A5459AD9 
X-CRM114-Status: GOOD (  14.56  )
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


On 3/28/23 1:56 AM, Sagi Grimberg wrote:
>
>> Yikes, no.  Anything that needs to poke into details of passthrough
>> commands is fundamentally wrong.  Maybe we need a separate log
>> message for passthrough that is just based on the cdw values instead
>> of trying to decode it.
>
> Agree


We can do something like this:

nvme0: Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR : 
cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0

nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR : cdw10=0x0 
cdw11=0x1 cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0


Alan


