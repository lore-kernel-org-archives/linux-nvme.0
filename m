Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596C7C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5IXCvHEqiRmaUTAEROF3ZRv49uVHZ9d2nstlwsTDv3g=; b=O7YvyNhRPk9zzKEJJYC7EGVg1M
	toJ3COGnCxcQXtLkU/rqSsndJqvt4BJ6V58v1WL+z5yb+IwVqr5I8lTo7pDx2YaGP8TWhPt9EikPy
	dxelrk/ep0/m70eOGZHnkaRyUDL7epCJI2bt0RuPndbYQkJUU4QWLxGoCbXyO0wZmiDtlqBsUNMTA
	fe0NpB2pEWVNsW2tRcmDrYs05qYNInZ6RS1Tt3yF+ZHuMX337LhWyf5rG5vOecivrEt9xExqzZOQq
	qjGLdrZs2yfOAMBpqDog0Oj0ryVSmXkUodtB8UJdMH0sDEFuDfmKxPge2Pew4TMu7sTeAIhFaqceI
	9hjlDawQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUsg-00COPC-1w;
	Fri, 12 May 2023 15:40:30 +0000
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com ([2a01:111:f400:7e8a::622] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUsd-00COOa-1b
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaLNF0RvRM9ATsv0phcqUSf7lhSnIWTNocl6H8dBdmGLCwvFMPnrwgTDe9kPscRyq1bHXW7+MK0bnl6vpULUItvzqfa58JUm9pFtmayIadbio5ARAI47A5zg9qO8xf3tw08aJZv498ofNFiQaiMEVmjewVDeSLjbq+IEvXOvTscL06bm/b0K0MVFpl6LMo3oPG5CeVKrGnPJ0rxf14ChfS7sGJVI0dsjXbor3cuXHB9h3Q5hSwSLKUMaEq1wDvv9VQyDIX3eegvp8/Hwteyo/MbmMJ5aIGC4DGF6PnJ6fXqConwq/qvfbrCJagyP9YB45X9tI/Vxw4fO/SGugFjFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IXCvHEqiRmaUTAEROF3ZRv49uVHZ9d2nstlwsTDv3g=;
 b=DJkt+q0pT1mH7XIJKCIoe0wJDMbOk2l/PDVlaeFklWuw74gOR5z4o7HCuO0kFvcYhsHw4rE3zuAoPx+DQixZjxI7fDN61ojxwmLWzz1SwnMCki3B8O13zNg7RfnHMCKg2XX2fgexZAW1Xcwtla2J5cH/+hsrwK3P9gbu/OrEa/Dz6rjWFG/KXHzPpPYlxyE5Iw1KNreB4V3gtDiqdwJ0xRRx4bXBf0Fm/OaEgR/nIr92Alc1kLV/u4o2qnzeexr38g/jPxvPJfBCl55m4HCU23p92GXXI4lWiLvyUeYqPg2Skz7gn3I22DnxeMaUUSoP+O6nlzvB5BAaOQSQhedUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IXCvHEqiRmaUTAEROF3ZRv49uVHZ9d2nstlwsTDv3g=;
 b=qw47uM6mEU7u+ZZSYw2nKNicSlc2B/NT8LLwohPT/6U1f9ng0Pkxiiml2OQtzZDtJDCnc+rLo2E3oJ2AoY2ORj6cZE6x0rfQ9xXU7h09ZEiK3udcEckJBHM6c9gpznRyh0ajOokyPIampS8vXLcN3lQscNM2C+PtgzL1YBBMXTOD9nyQ4Pn8reg6/ynch3H0prRrNe9r5Dil/o5LOPzYUAknKqTzRs44F/DxWkMZ7bysmfkdhjFAybFUkSqhDJJB0/TJq/XErtpuMdY2BAyMI6M15v+ndqUEM1wjA+/qJ6xoCi3mypumKsorDa1WBzb/+oqeGo6eQw6BlRMwBEF77Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 15:40:23 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:40:22 +0000
Message-ID: <beef281e-06e9-3dec-63fb-54f188ee483b@nvidia.com>
Date: Fri, 12 May 2023 18:40:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/3] nvme-fabrics: prevent overriding of existing host
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de, axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com,
 israelr@nvidia.com
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
 <20230511165441.30005-4-mgurtovoy@nvidia.com> <20230512145652.GC5051@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230512145652.GC5051@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: a25f21a9-5925-4f2c-e79f-08db52ff32a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	+MwzXS+1TIL41kMzf4TljCCBiZaNvU6rwy+RoDLbsIQfmXJOYC7GMoFRf/3Cmf2IV4uQsRp7Nrac8bZAG7rmeFLd9TlYqyUXs5xnzgp7WnqwKSFj/cbnH5+W6+leO2gRm8qot6St0tLZTwXE6n/YttfnbVysfL+HlMvFKCGy0f56C/CVHq1vmgELX2VuLoYzL1/m/2Qt/JBcZUTWs0V/OdK0xbqmYt5HxrWYPGGJexik66pru0XrQag6bJFkGtbNBSaKfYYmZNk5fXlV7fqaV0KccxehMv3Ci6v04/VCoJZUE1hDsLFLNUHXxa/t8KwYZGI4ZPXzNdJUBszfcZIxKH5Nt9Sh/Ly52roWt6WiQOf81FefTxtIT3awisat8mp8LTNvhlk9/Tba2lllXP6vqyleaFYKbcSzTv40qUjwKNpvD2LVgRKSuBO7zlBEfoxhTp45pVFDofXOAnqFyjDxZPjKZodSK7emIHeqrkfOZsX9d7ODtCAyhQ1HgGzUsx+676xub/Blm3OZkQsCixeizlGAp8nRC3I0bhr0u1D/xg16pkqcp+xa2zbLaoxyoHNwBkBP0vNyw/25ZxrhRvjpmIjRhNDNL9V2FrKpp7gPyFoo5jdKX1n6abzSKBOKvLZavORfFGGEf96f66WqHWyOkQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(86362001)(36756003)(31696002)(316002)(66556008)(66946007)(66476007)(6916009)(4326008)(6486002)(478600001)(6666004)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38100700002)(6512007)(2616005)(107886003)(26005)(6506007)(53546011)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?M1U3YWlmdDlIMjRra2V3UE9ZcmhYOVZyRHFHc1QvSnc4d00wUkszWnovVnNT?=
 =?utf-8?B?dTB5aWRoTUUrUWdnK1Fod3owRVVsWlROejVOZEJpUUhiVVRqSW9vYVF1ZlFx?=
 =?utf-8?B?b3JzdVJaV01PUmwwdU5aV2JndTNVcFcrWEZLaUEzeVdNUU5OODBoWnZ1YVht?=
 =?utf-8?B?YWZNcWxBTlVrdWliZ2I3aDdwNVJ6Q3hHMGxpcEpVdi9RdjVQaWp0WTI4UzZ5?=
 =?utf-8?B?N1NPZExNM1RmZ3JodEJRTHZVZFYrakpVOEpEZ0g2ZjZsQXF1OTVnaGhZMWJy?=
 =?utf-8?B?aU5NaG9SenJJWnViQ2t0TXplSWlaejg0VDMwVTJxeXdNQ3ZHdndsdk5SM0h4?=
 =?utf-8?B?TEZxU0QvS3BxTk40R3RLaWh4RVMrRDJqUjdVUEhkbXdxdk15RTVheERGcTRp?=
 =?utf-8?B?VFFTS2VydlA1Zzl4dEVqdmNwaG5Xc05QZmFZNzQ1L01qRmQwZG5mcXAxRm1l?=
 =?utf-8?B?dWZwTlY4NStVdjNUWGJ2Z0Z1V0ZRalk5azJXM1cxQkRUMzRjZzI1Rm1mdXY1?=
 =?utf-8?B?M2RLZTJVSmFQQ1J3VUxWUERFb1o5V3dqRmRzY1pxK2JCbkFkT2JzcW1QUzc5?=
 =?utf-8?B?VmpRZTgrTzhZVWJEeWozNnhwK1g0WVJDVm1ZN0V5UjNZeC9wMkNmWEIxb1hy?=
 =?utf-8?B?MzVUSGM5WDBxeXU4Z0RwOW5rVkZHTUZLZUhNeFZ5eWhUbXZyaXIwZG83WHlB?=
 =?utf-8?B?ZWZ0UVJkbFQ2eVIwSk5YTElQZ3kwUEFkSEdyZUhwNHk1OE82ZTRLVDNTeUIx?=
 =?utf-8?B?b1lSRHBSM2p0QTJNVDk1dGJjRWU5akExSkIvbDdKTkNtM2lhQm0vQlBQT21K?=
 =?utf-8?B?bGFOK3pxbVhueEdYazFJM0xmRW9Dc2NuOWlRY3lRQTBQcEV3OXVSWDk2VVlZ?=
 =?utf-8?B?LzhLeU52SnhGckQ0QzQ3TDhvTTFJU01qbUVGSlVnOEdEcWtscDJsRkRGdzJ5?=
 =?utf-8?B?ZnIrYmdpVWk1bGFTUFJkb3Z1WlpFeDU0UWV2a2lQeUE0K3pWL2J5WVNWTzA0?=
 =?utf-8?B?YnpjTXRhVUVZUng0cEE3V2p2MHovTW85VVZuVThSbnQzOHFjWlhoU0tWblM0?=
 =?utf-8?B?b3BQQ2RYaVpodUNqVDJNU1YzNllJMDZ0MExORENtWjZFbWtrUFJRcG5KY3pw?=
 =?utf-8?B?R0FmcCsxOXB3OXN4VHdFS0dqWVRKK2xYYWxWdE04ci93S3E1SHFnRDdTTW5F?=
 =?utf-8?B?WEEwSmczZVRPWmlXUElURDd0RmJSSklicVBTQWJOTS8vUEQ2cGptVXBVWjNr?=
 =?utf-8?B?ODRNVVJKTTArZk91K0Myck55Ujc3VmhLKysxclJqZ3oxVFVZaHovSVNpVUxE?=
 =?utf-8?B?SHVzTXpYS1d4VnJuOUVaWk05a2xWUStWd0tEWWlqZTQrVjNaOUpIUFVmeUor?=
 =?utf-8?B?RFd2WUJXTmoxSTVUcm5yN09zemRKVUtDa0hkZVZVUnlCQm5GVmk4aTl4ZlFY?=
 =?utf-8?B?QjNtSmRHdXdLNy9CUFdqRENPRUJvWFNhNVpyVVJnU1kyTnVUMm9NamprekQ0?=
 =?utf-8?B?QTlOVUR5YmJoZ1phbUh4TUlGWVlUYlZXVGg2L0F6ZXpwUlJsbENkS3M3Z3dV?=
 =?utf-8?B?MFlaak5YRGFENDdybmVrQUE2YW5yalNKTTlLSy9FSktjL3lkN3czWjdOZ29M?=
 =?utf-8?B?NmpySzZkcXNqQWFXZFRFRWprR3VvQ2h0WENKd1p5bTNjTzZZaUgvMTA2NUpZ?=
 =?utf-8?B?cVlFcnZ2TUtNQzI3YTkxTUFSUGo0S0Y0Mlh5V2VzQ3V2RzhFWWVPK1BYRlFj?=
 =?utf-8?B?RTBlNTB6VnlrUm13WnZEYUpRbE9xTDZjYko5Yk9qbmYxZnFxZkdJNHZZYldB?=
 =?utf-8?B?dWFYSG9GZ2dPSkhCOGlpTi9aZ05STWRoMkJLMVY4TXZJODE3UGtIY3RzaktP?=
 =?utf-8?B?NDcwTzl1QnZkYWw1d2J6RzFid0toNnE2V1VxbVJraGlzMktCQjFGRERuTDJY?=
 =?utf-8?B?Y1NGeFNjdEtTVG8wOXlRUnA0dFR0eG1TSmhwVVVoOEhJZjNncWJNVldiOE9N?=
 =?utf-8?B?SGNhZzB2Wld2RUNNcDd6cXZaVUpGYkZ2cCs2VDI5WTFxTFVxMlFOd0pqT3ho?=
 =?utf-8?B?RzNXR2ZyUlJDNGw1SnVwbjZtYWJqa1FrcXZvRHNOWFNTUFRqbGpWTm5MZ0x2?=
 =?utf-8?Q?azHg2/znUv2g1xQwgcrwUm4xj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25f21a9-5925-4f2c-e79f-08db52ff32a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:40:22.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vutnbhdp6DHnBv5kTUQcM1QE9cNBBpVqXMn27IyGll3dy/r6koLgsfaQ6vvKfPiUDK+iAIOhs+yBeSXbbQlRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084027_560884_9F8B8490 
X-CRM114-Status: GOOD (  10.61  )
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



On 12/05/2023 17:56, Christoph Hellwig wrote:
>> +
>>   	list_for_each_entry(host, &nvmf_hosts, list) {
>> +		if (!strcmp(host->nqn, hostnqn)) {
>> +			if (uuid_equal(&host->id, id)) {
>> +				// same hostnqn and hostid
>> +				return host;
>> +			} else {
>> +				pr_err("found same hostnqn %s but different hostid %pUb\n",
>> +				       hostnqn, id);
>> +				return ERR_PTR(-EINVAL);
>> +			}
>> +		} else if (uuid_equal(&host->id, id)) {
>> +			// same hostid but different hostnqn
>> +			pr_err("found same hostid %pUb but different hostnqn %s\n",
>> +			        id, hostnqn);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>>   	}
> 
> Please avoid the c++ style comments.  But If the code was structured
> a little different, they might not even be beeded, i.e.
> 
> 		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
> 		bool same_hostid = uuid_equal(&host->id, id);
> 
> 		if (same_hostnqn && same_hostid)
> 			return host;
> 
> 		if (same_hostnqn) {
> 			pr_err("found same hostnqn %s but different hostid %pUb\n",
> 			       hostnqn, id);
> 			return ERR_PTR(-EINVAL);
> 		}
> 		if (same_hostid) {
> 			pr_err("found same hostid %pUb but different hostnqn %s\n",
> 		        	id, hostnqn);
> 			return ERR_PTR(-EINVAL);
> 		}

Sure, good idea.
I'll address it in v3.

