Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D95C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hI/cJeG5JKoME5Wdcs1wG9ia5HdzORxraKPQ1WNHwzA=; b=mpNsGL+fO8bJeC24TMVt9lr+o7
	c4tnG5xU8RkTrXZc15cg9TxL/Yd+d8ApBc0WPj8450VyI5raiiUObAUZq1sRjkXex3+HC2L73oubn
	RDxBo14kzwYNcfnPBM6aTMpWMWa+OBOraJeqR7FkQftWGu9FrpxE1Cd7pUjxcwZ9uPhwlCICiFUUT
	YMREv8ymocppbBpKCWPfWTIT7M01/di9wkflS1na4AO7NF1e/rHo3i6jRs6QwunqU2hU+P+oEiGF9
	PXU5VGbtKBoiVJSrIvXD5QTVfbNMLbz40kn+dfJkvxLZf8CF4+AD2g/Nbs+otR1kDTqDODLNhHDkm
	AC9IM7ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcqv-00EfU6-2N;
	Tue, 19 Dec 2023 16:21:53 +0000
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com ([2a01:111:f400:7e88::614] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcqt-00EfTS-0B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy2Z+d5j3x9qVrGPbvNphr9Xqge3tkOU246La91PMFYUq17nkQYemVRqBH6ohWTzaYiDKUKS+hgaIXzQHQtT4S8D1ppqiI9n3GOA9JqMfmil3dN5zJGMtsiwcwIZd3nQ6ADHDxmnP5guib20Vjx9YzkOAfeXAiyBiUIwlU+L7tCBLVlihbFDzaNTgUKSciL9z1NA2iGa8OLJuePKj84Kzj8F+kffQxQ9A7j2oUAo9IVMiE1kmZmmJy4AZRqOudX5guluMu1QewJbceL1nPv9TPuWKgEav0K4AZYdx68yOHAH6HoVXqe2kLjkCJxIAcxIqZzKGbtk6TOCbZRRavxkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI/cJeG5JKoME5Wdcs1wG9ia5HdzORxraKPQ1WNHwzA=;
 b=XRvi2mQYBnOg0zywfflt2uu9vweODEp5jyr65K3RruEjuHwkMGMCYxKai+Yk4pa/s/byU1PQ1S4G/jLyo9s0f+3/kOaN/+T4PQIJNpWSdjVRvGkGhAlNwlZgRi9dag6LBR/+1n+IUfs0c0o8PfpGrs3JBd9vcBk5ubc7gu2Z9aeTvIuNS14wUCsMoLfnk9TwxCSuQ+nWk+0WOv8MDWb9DSFCL2wZ7oG2Ki6IsrujQJf1StfuF5DNXTGGwoQy8urt0FzCnCXi5FduealuPO+6epyLFJ7EC7CnillKetE3bdYP/SETEfmI9wdkVIXtalSTtxgzVQHH1FgKWfOR+9Pd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI/cJeG5JKoME5Wdcs1wG9ia5HdzORxraKPQ1WNHwzA=;
 b=Qqry+icdGe3X1Sj3kh1T9ebjOgtWCfrK8HtVZ9ATiXKXME/RUe6jZBS3/20zHpvbkak7eJ18gKnVv13Ke9f6Exb2rLAcaV6Tf1N5Snm7AKIsvB8y04I24haEnM9cop0wn/5Z/FqqZFmjqJB/tDsRKgTJMm4rYNXVbSxtxOheBUdzWloUT3ogm/ZRzSz0qor6XEADJRNzlBozVlUTVpfGOj6SKfDXqzWoFLxBkZL417M7pJ74wUpeaG2lHyv3fFQO6b1R/Mvej7rcd+GEkGWgJUhQcUUiOGJaTnWqEr8tlO6REt7ObbE7lyemgwMh+gTLUtP97N7p8kcKlzwCJYQwKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 16:21:47 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:21:47 +0000
Message-ID: <97bf890e-d007-4316-b385-e7c8a405f64d@nvidia.com>
Date: Tue, 19 Dec 2023 18:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: enhance timeout kernel log
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 axboe@kernel.dk, chaitanyak@nvidia.com
References: <20231218224633.2963811-1-kbusch@meta.com>
 <20231219050108.GA31771@lst.de>
 <b0bb838e-761c-4857-9647-515f50d7ebf0@grimberg.me>
 <2863ba06-747c-401a-85db-2ecbdfc78e04@nvidia.com>
 <ZYHBjllwmdS8BIjA@kbusch-mbp>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZYHBjllwmdS8BIjA@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbcd08e-2ded-4743-d85c-08dc00ae98e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKeN8IpE4YJHG40h8Vw5tjm6yRsA+9WHaVC5oZasXRN+FaWl44SUwDs/z5MmZ0ExKxUPxljxg24pBR7OzJVks0fuK90kfptsfe6zt0N0fFkLjnLioCmWFwCpeRCm34jzPa3/50fyTcA+SmYMygfoo1r8n7Wve3h5LU3RFEAVGN3csEFvN57rea7pKCZCJekQoZjlG5T1NrWiDxfW6vKE2INmr3fDFPREnx+VFVaBq8m8DIF73qnqNj7WoJM+FJz1B5M7UUqRbylxFjxx/P5hJyHBCghzre5FSmIVdCxu8GPZyBFO5XWW7jtdGoecMPPAxoSuMoAqh0shSFnHHrgeAI2hULKde/Oe/2261/WudPvUaeWmeqjBjKsMSBHLUeLHM9wbTULGELteVeC1wEcvm9QAEYiXvckaFtjB0Jxfoy7THUbRAd/RZUoryXKsvD7GK40x1t5UXM0626nAQTmgf05gerJ/9/cxhARclxrBXikBAH8GAbGF+ny2cM0Znwl8vHaelVmr6su3/MNq4IJjcF6UQYdfEiC79taM0EJJM21RHIq8a6ONuD0L5P7sVu2h7kWVRj2verg7u5lTg0InUVfoIM8Vjj+57qdpn+/GFhQi2LY6odcndo6sQbioHFrI+BRZpHb81dUkKeB2+E2MdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(107886003)(2616005)(6512007)(53546011)(6666004)(6506007)(26005)(38100700002)(36756003)(86362001)(31696002)(8936002)(8676002)(4326008)(478600001)(41300700001)(5660300002)(2906002)(66556008)(6486002)(54906003)(66476007)(66946007)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lvVzhrSTVseGRzeGJrR0dJdkpsM0xDQjliMWxVTlFmRWNpd0VWOHl5Z2lI?=
 =?utf-8?B?R2tuQUVnbWFBSFRaMTl6UUNRRnllcmN0VDRhN3FqbXlPSzVTby8vZUpoeWFs?=
 =?utf-8?B?U0xvSWdPQWY3VTQ3U2N2aXRmajYybXNCVlVoay90bExQNEVLV05INzJsb1hl?=
 =?utf-8?B?bnAwNGoxdHJoWmZXRENSNnhUMUVLQW5mT0dIeEFleUJjdGg5UkUxYkYwVStn?=
 =?utf-8?B?bHVkbllCOHg0eklySXZlMGRaeXlTOXgyV3FURjZyWGJwT2JTMDNHM0NBQ3FG?=
 =?utf-8?B?SVAydXZ4T3BkTmVIK0R4L2Z3aFhFWWtaMmwvK1Rvd0wyWXV0UUJaeFppT3d2?=
 =?utf-8?B?U3RHbDQ2Qk9KaUhEYkpOV2l0Zk8vM2VaanEreG5jZEh4end5aHVRdTJUbWdE?=
 =?utf-8?B?cWwwa0RWNzdTVGllQmZPbk9MTHBmMU1YbnZQTmtkdkZJLzdYeWFTYldGVjlI?=
 =?utf-8?B?QkZCSk9aOWtKUGpkT3JoUWtJV21LODk4dThqREhjRXdpYjQrREpUSUJoVkhx?=
 =?utf-8?B?b0dQMGtCQkQ3SkROTU5wekNEOHBGbzhhTWw5WXl2RDlPRG9jZld2bVdqS1M5?=
 =?utf-8?B?ZEJUMGdVdjdQbjZpZHdheDJEQWp4cVhZRVlXblJFYjZlL3Bnbzg1aksrRERO?=
 =?utf-8?B?NzZnNUVIRjVucndQMDBsLytQeVozRUM2eERmcHBDeklUL0VrcGg1T2hxTXhv?=
 =?utf-8?B?MTdYemNoeUlwc00yYmUvZXM4MUUvc3VockhXZkpaemVTRzA3WldhL3hiMCsx?=
 =?utf-8?B?bjBPOThoVGtzWklRc3MxK2N0SElNc2JwN0FyZHlWSmg3MGpQckY3WHRPZmhE?=
 =?utf-8?B?anRBN3lCMWdGMlVVa0IyemUwUFVDRDN3UEtKak9qZ2dxNWVlRy9IWUdUdkFP?=
 =?utf-8?B?Sk5kdVIxUUxkMktpS0VNdWRBdjVDYVBoWHFMOFpLRWlaM2ZrQU1idmtKY0l3?=
 =?utf-8?B?bTF2QlEwa3ZEampBd3ZEMVZSNHFLWWpiRmhQeFhHR0pJMDZ4OFRkbWMwRE9V?=
 =?utf-8?B?c3Z3bDFUTHNmRXRkZmxQbmd2cEcydmFaZUtKS1NRVGNHZmJ3LzRZNWRvWStU?=
 =?utf-8?B?NnNFVzBjODE4TTVNWW1jc1BEcEk4WVpqblM0WCtYZkswdXY0aVI0MzByMDRo?=
 =?utf-8?B?YW05eEY0bTRMRXF4Zk9kNDVQSVBOWE5ZTVYvSzYwTi9yNFJnQ1BIOTBCYW15?=
 =?utf-8?B?Qy9xRVhVZXhIWG44cVhPdEFLOHd3c3FGaEpyOE80R0NJaFNycUZBR1JBVEtI?=
 =?utf-8?B?Nnh1Vkl4TzdLeUd2b1pIL08ramZsWEpHb3JQc01lcWRtcnVyWmxvZy83cHB5?=
 =?utf-8?B?QSt0WlA5QXJsQVNIbnM5R0lubG56d0xYUCtOL1pYbXdoRnUydVpORlBnSWo0?=
 =?utf-8?B?QUhoMkVPRXZRT2g4cy95dGdvc2NML0tyTE5uQndEQ053UUl3QzN1Z0ZmazlH?=
 =?utf-8?B?WW9pUWFZeVpIK2xqMXUwRnova29ma1pPQ1JOaW5SdHBFQjliRGc2VTZaTmE5?=
 =?utf-8?B?NzlCU3czT3pBODcwVVA2d1BFVzQwRzBtaWFxT3dIcGVQdFAvaWZQVHBNZ1Vs?=
 =?utf-8?B?aFlaZFhBUjZ6dFF3QTZORmxTc1lXdFpUVWhvL1QzR0QrWWd4OTZTM0pSOEFN?=
 =?utf-8?B?bHg4RTZpMXdJbHRXcy9jMkFsY3ViSEZPRUZoK1NSdVFkdndJR2N1bjAyRFk5?=
 =?utf-8?B?SE92bkp3ZnZXMVY1Y0hQaGlId1pvek9oNlRQYmFCVjdRQmZaVy9kRDVSRE1k?=
 =?utf-8?B?WHdTL2ErOGNWek5pNjRyRm9RRWR5K2s0TCsvR0Vkc3R3V3JKeUk4dDRyZFFV?=
 =?utf-8?B?R1BlUkdhQlhVZXVzNGlnTDhwcXJBK1pmUWhMMEtTOHAyM3ArZXY0cUNnUGUw?=
 =?utf-8?B?a29aNzZNV3AvekdvN0hBRlpJMTNDVHBwRGVXRmk2MysvQ3lxZFNjdEJDYVJT?=
 =?utf-8?B?R3lqdjhKbnhUYXp1VXJLQVpiNGJWZWt4NjVMQ0dNY2syZTY4WWV1OWIzMURO?=
 =?utf-8?B?QnVsYkxvZ0luM0FrSVBscWNNK3ZFSkF0RzVRYTZxQ040ekpaV0x1SXJDU3c4?=
 =?utf-8?B?b2xyNXhWRHNueUFvVllIQllwbnZ3NTV1bmNxQTNaYjBweTI5QXViY1hOWndq?=
 =?utf-8?Q?nQsyP+BagNb3vNU7Ar2JYaPuJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbcd08e-2ded-4743-d85c-08dc00ae98e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:21:47.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ6oFBCoYzkwv/w3sZPEwqKYqratxLWUvYWacmnjHPjaD9xguNodbEGdU1nfOmZCSw6v6Qc2DH2KBjdAg/EA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_082151_101304_2D1E4B92 
X-CRM114-Status: GOOD (  13.47  )
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



On 19/12/2023 18:15, Keith Busch wrote:
> On Tue, Dec 19, 2023 at 06:09:23PM +0200, Max Gurtovoy wrote:
>>
>>
>> On 19/12/2023 16:15, Sagi Grimberg wrote:
>>>
>>>>> -             "I/O %d QID %d timeout, completion polled\n",
>>>>> +             "I/O tag %d QID %d timeout, completion polled\n",
>>>>
>>>> Q: should we use the Linux term tag or the NVMe term command ID
>>>> (or command_id) ?  I don't really care, just thinking out loud.
>>>
>>> I was fine with neither tbh, but tag is better than command_id I
>>> think.
>>>
>>
>> In the current Keith code it is actually the tag.
>> If you would like to print the cid please use: nvme_cid(req).
>>
>> I guess the cid will be the useful value that we can compare to the
>> wireshark or the target prints.
> 
> Yes! This currently prints the "tag" from blk-mq. I can change it to
> print the encoded command_id in the SQE. Or both!

I tend to say command_id is more interesting. So better use the option 
of cid or both.

Can you please align all the timeout functions in different transports 
to print same value (tag or cid) ? each transport today prints different 
values. For example tcp prints cid and rdma prints tag :)


