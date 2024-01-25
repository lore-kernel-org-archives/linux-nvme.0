Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5C2C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xulAv13bnACtHLQsH2KJ0QCmV23uloLLLRJPwMe2hTo=; b=ZcUZteUnGunKU6NNv9uXghaJK9
	1KPtGQu2iSU3Xd0tsI8RDwZAaYpl15ZCczP4Ex/Kyy4KLH6H7pOK6rT7g9AQ3u+du5KB3o9xNLyDW
	DW7mR4rIMu5jjJNVXt+bjztPMCvx3uZXey4ae4xK/sSB4nrFfI2PhlOc0WchUz2sALrbeCqO6ajBH
	fCdmIJxQ3gzugGNhuny0EHkRNJmW6Mp3fCVIsAZJWDIRIwP78C7f2+sorGIOT/B0BzQZTVMOz/mrZ
	i+1KeCxg2sHhrtHIWe+MbxBXPOLMwi7Y/T2gMn4Ng4Blo0ANwqGP/cbH84PLmzchW+UsiELDfRK/T
	H+al1wLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT24o-00000000hcr-1IhR;
	Thu, 25 Jan 2024 15:55:38 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT24l-00000000hc2-0Yjg
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 15:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBjqZBZxruQEHIQSVxRoBkzGQW+CsQHqWgmi18M5cmZ5jUFS2A7GpzIV17BaSeJkJ90STulI3P5dUp456uaENl3bb6iMFYN7TPb9qy2KD4hBbhX+hNw+rXrS9TnqE7jzai3cGGyZg/8gWV+CdvL/gXxyOPh+uRIVb6X5gTODxvq1MYSufOzCTcq/Zw2CnRRPY1aS1iKAfGwHOWN+kHfTtM1lTzCpGaPYpxReXtQzfCHbKxz4geMaYMnhF9lZatXeQD7nA/MDGCvmaqbPKdjnzWKUE5XV2BCSrQ6gIeTABYFCbqhmkkopFnF19ERwd8ooup5Kk8ebUkt0B6mRnYx6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xulAv13bnACtHLQsH2KJ0QCmV23uloLLLRJPwMe2hTo=;
 b=N5QlXB/+XY1teE0zS6iFp1lkiP3iSjGB4bIm1JXTqPLePd4c6+IuguJnOMmsnvMEOZkT6hwq7D4K7EENpcThO4GI4EEj+iL00omKfN6sAkoaBF4BrzMtYNXvKkrYPUJIWZ9/Hmud7ztWl20graQ0E19MOPcdv1Z5JCRtyiloIvGiy5PnkFSALTFyGKlN9UcBWVU9MVhTDXr5XiauMQN5mKdIWXDRdGjlnGdpHC2sfxa8Le5AAYdDmQjFhanK5rK94jbKGKLDE3P8FdgH4FFWq5Ndd01TuG2lKRazIABQgOwPNx7girLkb7xoBec9L74elhQdE2tkw3faCHMOA4DeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xulAv13bnACtHLQsH2KJ0QCmV23uloLLLRJPwMe2hTo=;
 b=Low+g9ri/phYgDydL+27vl9Kq8ikQ7PKOBSzbfMoyV+rXac32YnD4CSvV3PgPIu/iOe8z82/Jn2xcpkw9wigbvfsHjJjoU9I76zRVB3wNEPhKIjvYnBBmz5TK0QrvDinOuvbUC7fHRcAOM/wn6Uzivrr1fRTztr9UucXgK3RBD6Prmmc4DOAqtCeyV3vidEW5Dvna1f3UlOfnHEzn7cmWu1eAOImfcAHb+9Z31j1VKhUwLnBuJJwprt7rr4P+O30PgVlh9FPri8KoatvfwX+vywvRg9NW15F/4R4P7j5fliew+Y19gnQBrSSXzuRxTg7sNV03mTRcCnH9JB8A2A2VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 15:55:27 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 15:55:27 +0000
Message-ID: <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com>
Date: Thu, 25 Jan 2024 17:55:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
 <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
 <20240124094832.GA31289@lst.de>
 <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
 <20240125144130.GA18804@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240125144130.GA18804@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 1226cc0e-50b1-42a2-ebc7-08dc1dbe0cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+agquA/2mtUUjGYsEvOrtOnB+1e1o5k4ofRLCXCgO0WjlCYcGJT0D5XYYnh41CJsL4+pqaOvzN0HZwfWTQp8icjHC+avc0StcalqEIlG8J+ny+hCKB0c49s/H0oN0flnvEHkQYRzcP3+T0AUC6Nm5K3EtdPbbGcO5T7EYCXmeI/nKJ9fy7WnooGLA9Eh9FCD+2hlhr1TeZqXmHJx4afqhV2igQXRMhqiAN9PogMLE9unG2s57mmiUP+XCGGJ+rjxooERP7gnDZ3MZkdL1ug7lFbQFilSLm6dwYw0INIKTrLyDR7DeOsUM3+ZgOkX7GQ8Gpxqy8mfdhvCGBqM/lv+WkO/pg7IM8HoumGfCTNMuXXAMF3UbmD9u282f0tPy6+j7ksgPEQ1COuR+RGVPCmv2MPn16cSuRRp1QMh0i15Yb744LCE3DlZgNDlbi3KNygWiAS1GBCe3/SN87A+cCaFy5xtc2fm/M62Vftk4l2BmnJcnBXm1NdSLz4JkqL3yR9RJxbUemdtFUHzLxyYnBy86lOqbU9AaVpF2ujdv3EMa0k3ZT9BPd3iS23yfJefiDnds/nn3XBeZWGndwoMY+z6m6Gbj5KtL1r3PpVhZGcwRDP0L+Bz2dCaqP0Ik0/qgDTPyxJ1RHI0foHCEfIsCe95A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(6506007)(53546011)(38100700002)(6666004)(36756003)(107886003)(2616005)(6512007)(31686004)(2906002)(478600001)(86362001)(31696002)(41300700001)(4744005)(6486002)(5660300002)(66556008)(66946007)(66476007)(316002)(6916009)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxmMjVNMW0wbmJxTE5GbVhUbklWb2ltd3ErQnlqODBveWlQRGFuWGtBMTBG?=
 =?utf-8?B?WlArYzFsdHZUMTE0NnVWNDVsY20walp5bWYrV0tMRnpUaFBnZHpnMnFJZ0Fk?=
 =?utf-8?B?ZXd3ajNYWUl5NzdtakVvUDI4SWF6VExvSUkvZ3h6eHV6RFUxcFBGNC9hS0FK?=
 =?utf-8?B?NUFiOEV2RCs3SEZiVXBZZk9XZFdVUTVjREloakVIL25lbC9CaUZ4SCtib0tl?=
 =?utf-8?B?QVRQZWpmcGZ6Q0puS3RpMlNvWml5Ri9qRU5FbzEvM01Lb3c1L0x0cjdsOUdQ?=
 =?utf-8?B?dFZFNTM2czNZVDRvRllrQ3NOUEVNOWM3cThoUEFwUUpxOUdoOHdyMkhVUVhC?=
 =?utf-8?B?aHNidUZzeW5uWmFVaVVSRXVjT0UwVFlrZUJ6dGE1SkdXbVpPVVVrZlBmQll2?=
 =?utf-8?B?azJlV2FTcmJpZFJqbnp2dDBaUlZEYnFaVE5hYS95NU9iaW1iOXRZam9PZ3lR?=
 =?utf-8?B?VG9Wa0Q3UHJxU0pSQ0RNeXdMcGJQd0VoYlYxSGxHdmZVQWRjeng1d3VkLzVl?=
 =?utf-8?B?dWtadkVaK3JpZGJkbVBDK0tNTExwcGZZYW14VkZlNkx0MlZsQU1oeERRL3dU?=
 =?utf-8?B?b1BhMDU3aVRJeTU2aFNQMHUrQXVsbU01dW5EMGVJNXVTQ0NjVUdXcys0cG5j?=
 =?utf-8?B?dWNiZkdSbVhoUUVFSWdGa0k3ZXUyazRHTy9jL0ZHeW9uN2JGaXlOZ0h3MnBy?=
 =?utf-8?B?WnliK1NGZXUrek9JOS9IL2ZnNG8rQXd2bW1EYzRDMW5hL0hRYmUwZ05tUmNC?=
 =?utf-8?B?NGNVUE5RSUtySVJPb3Zob3kzQk9TZGcwWVdyYnR0YW94cUNmaU1CVjFFaHMr?=
 =?utf-8?B?STdWZnIxcXlHQlFiNERkcFlNZ3M3UHNLcW5ETDR3YWZsT3VnNVYyK1dyUTBh?=
 =?utf-8?B?dXc4eUFtdVc3T0Vjei8yd1A0c285NER3alh3b0duYU1pd3JlTnAvRXVMaXp2?=
 =?utf-8?B?dmhhRUFxQWh6MmdNWW5VbmhuZm1IbDRkU2hHR3R4NjVwb0xZUGc2bEdqWjNm?=
 =?utf-8?B?TDdTNFNkTGJWR004aVNUNWtJekZJN2c5a1U1TlIzWGFQS2ZQZUlaQTRiR0Ju?=
 =?utf-8?B?VU5rTVBLejZjd3NNMXJNVVJKbHpjb0FkdzNndXdaSVJhVS92UmY0amtMNUg5?=
 =?utf-8?B?OVZRQ1lmN1ZVZTQzWm9zc0tCSUJGTUJmNytYR1BKS3FsbzNDWVdydDhEbHFQ?=
 =?utf-8?B?TU5JSUp2SGF5UG9mcXBqY2VCSVJiYktwNXhNK3B0bnI5YjNSc05wQzI1U2ZX?=
 =?utf-8?B?eUd0SC9RdE1mK3E0NmNnNkFOWW9EMTJIZ0ttZWlqdFIxeUNtZ3g5VzlLMHhy?=
 =?utf-8?B?d0hGWTYvWXJ0d0lWK3JaL0xYZG1ERFZyTFFxTmgvc2JhUG1RaGJOd0lTTW9M?=
 =?utf-8?B?ZnpKdnh3S0tsbWJncSt4UGZTVWduVDNtcFF4bmpDbk84NVFhTWVNdVNSVEZ1?=
 =?utf-8?B?ZlUrTHNQRW1GLzkxSUJNQnlkaGFXNnMybzFQL2xJYkFuaWZpM1Q1K0lSUm8y?=
 =?utf-8?B?REVxZEZmM2xpYU5URGFlTGpiTTdtc3Zja3pZbXJQZUNyOW5OOG4wbm9FWS9D?=
 =?utf-8?B?SUwyQkxLMTNuaFQxUDlmYUJjdFB6SzJ3ZlpvNm90M0dNQ3hnRERRV0tPQ250?=
 =?utf-8?B?MTg5SlRncnUrSUJNUzc0OWdhVWlJL29uZFE3OHI0QmZ5WXBLRCtwTjUzWVBO?=
 =?utf-8?B?UXFTL3IwOVBETm45M3VBYmhBYXEvQkFWUW9Xd1YwTDhjelNlaktrTVZBaGFr?=
 =?utf-8?B?dE9QWkpDeC9lVUFRZ0dRaGRMUVB0NDJRMlc1RWErZUh1bDl0WTBnQ2lnQVpT?=
 =?utf-8?B?R2RGTC9abkF2cVBEYW1lRTNBSDlyRk1aSmVhd1FzMnozaEcyNXUwS3dtSlNR?=
 =?utf-8?B?REZvUVoxSi8ybnRvc0R5OXBoOXVZT09ZR3kwOUJ1WW9HbWU1RUZQb0FBZHUx?=
 =?utf-8?B?VlpnMTRXUzFtOTFEU3Zrbjh4YXhlMTBNUmRBTjdIOWNCTVl6U3JkWElqYXN3?=
 =?utf-8?B?QjZLL3E3bnlzanB5WUdXbmlkODJsTEszTmZhclNXZHdKb05samNlQ1NrWStu?=
 =?utf-8?B?MHBIcnZ0QllTNzUxVStyVDIxYUdVNWNOMGh6eTh3MkE0N3pQbXQvWVR1d05a?=
 =?utf-8?Q?xjnIrzkDaCPMMCusQEG6WStv3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1226cc0e-50b1-42a2-ebc7-08dc1dbe0cb6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:55:27.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWkrKD2vKdGoI78FWkW2k0nsWweeotGe5nxI+nBHGSQHzCBqZXrRCd7Z+sI9gxOKW7q48YBV1PNWwtuTZjWiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_075535_239436_F3AC21AC 
X-CRM114-Status: GOOD (  11.64  )
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



On 25/01/2024 16:41, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 12:23:33PM +0200, Max Gurtovoy wrote:
>> Even in this case of re-creation we must sync the namespace identification.
> 
> But a format is not a re-creation.
> 

we currently don't support format in fabrics so maybe I didn't use the 
correct word during my answer.

because of the dynamic nature of controllers and namespaces we have the 
identify ctrl/ns commands in the specification and we need to use them.
Re-queue requests to a non identified namespace is bad behavior. It 
might be even a spec violation (I need to dig into the spec for it 
probably and try to find some description on that scenario).

