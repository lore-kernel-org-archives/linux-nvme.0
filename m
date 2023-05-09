Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F756C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkINz4zy6+vFUHOa9f1/v0bV63tSGTQW74FKSIiEusk=; b=rnTpork8mFfdqR0aEjZGNQKJQD
	TW6a8STwtTd0GgCKqOYKtsQ5YbuIHzoX05ri5VR8+K0rkeiyO98Vp3+C8zqOvGjwDZvkyHetvG85/
	C4/ZaTw7OgrZ6wMWT63PbUCmtG44FWR/S4G9S06jhZHMQJo3llG10ED337Op+qb5iNo2OHU+XEXlA
	IRz6geH8Ry5BxDVu4YzLqivu4TI02z2kxbrCtM33fglinIPShk47XYYaIvvE4BXYfzV3Z97+SZuxW
	f5T5uN3eH1YMGFldXhnC5Tet/Uo9ZjENlvwYLG7RgNLiH1m0Iy6vLHMVSbIGuzkm8HBSt4QtRf5se
	GSzG/wGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWhj-004VHg-0v;
	Tue, 09 May 2023 23:25:11 +0000
Received: from mail-mw2nam12on20616.outbound.protection.outlook.com ([2a01:111:f400:fe5a::616] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWhg-004VGs-1c
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE/09iaC//TByniqcsRlrAWXRUR6dxfUtwHj9rU5aRQnTunKcfYPJtPGK+O/CNOmTo2ohMHGsq1YpwTKEJp5LGKocOCSzzdCNA/txL33QHkLlTXj07DnwVzjgRwHmmKK20PUYcxfbay0CrI9cwCTe7QOr9Nvx3iUcWCLdkKdQGATLZySAM+kxQD6AasTv6y+kHhtIzsw90LmPfrUPyI3hlSOgp32QTqeRWRSHA29Kb2Hqfpzfwyrl5uO9el4w+J6vTy9+XHzQCIIW4s0qc956OQnv3p00fYl9F8wJ0BrEjTnejxai5wEjU/7X9kIouNGaz9XFCU6zhL1zJTCqD02kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkINz4zy6+vFUHOa9f1/v0bV63tSGTQW74FKSIiEusk=;
 b=lPBuLgEZg51X2rlPyP2YufKKdmfFPogkHx4egyRaud/sBIfqsQjRxmaTWDSf/swdmaFvf4p3+vPGv4kMlYa+tU/2MKalxWgjUr0j5BvikU4aU4NBPyWhSS9r4nifHGwgFvAKtv/XMWQk83TjrZrDhaps13wVpzEYbtTR3Olx8eDkKb3QUUmm4c9iqDcViYnHrsNcIzCqLzAtu1Mx1cBV9ZawPzEnt8wG+Zm/L1NTKQFb+7WdiKcYDkSlrBSC+u8zKsO4mGv6WNoOaeYC1W2M7Q0iH7Oe8sVzrVhnXwJPTdO+XxqpFFAQ7rfiTU9kas68QsFU20BeMWIz2/wRwiuU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkINz4zy6+vFUHOa9f1/v0bV63tSGTQW74FKSIiEusk=;
 b=Bvc/v5HdTTT2Ago2BKvlakhVrclSwluNohK95uUBSh4jgL09MP8RPD9hNTN5B2T5utvvqb6sAN/YVsR60Zoau6b7y59qaVFBR5p4pUnW310vFkIYl9VUh/l9cs1MkIFvu22+RsBUKGZ5E+CjqExy7g+IiGNKSDaczVPIOcBUn9YF9pE5sjDIgc1GVH03na47LyL1f0Ujk5WNYdWrrMHBUg0YVmt7wH10crQm8P40TVLefs3Xpv2+PdnhpVV87tKYWKzdCbU5sm5ABVqkQocQzi/RUmdeIV7giqH2nexxTn6zmmgPGRb+2XdwIGzV1iP9JTFodd3vpjA4q4gQdqStsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:25:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 23:25:05 +0000
Message-ID: <046765f0-01a9-eca7-7f36-a0b62c7beb93@nvidia.com>
Date: Wed, 10 May 2023 02:24:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
 <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 43eeb000-2362-459b-3405-08db50e49edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	OraKSKGdkexgp6p+20tyi5/kIxvGPaZVvcZGFtukqCiLxI/9M+PIGe650VAcLY0uECUWB0n0gO8Boa0xXM7jdvgqGShA4sDHm/CDYEC2nEl8Msj1AOoZ2Lt/Kw7p1OAgpR0A8Ffh1Vjf8gHGlkbUYkS0DTZyfzBlnqM5lF3KMG+MitSUylpGA2wLZZsRV9lpyEQ+4X8T5ugVSyBkTAaJbVjkzKBWQ/UP7WiQVd8kXlTup4Q+G8rcIqQSfyBkgbvx9ds7nRY21ELDLUkWZm4YMHDRcXVphjoFgERc3LfQ0oNb30H9qChMId/JTMwYocQhq3je8ixAyvVKUtkZgy84C7fARqqnbgtx31GRjUGJL71dy8vB6sb1Rpk+JBqa4DUF1CdpgKzP/LuHVx+sy/Wjozixghr+yGPR6w7UdEFonRpzXWDdXPkLgf/lNcXrYtiAAeijcP5nW+l6nCDQ6D5/gB8dC2Hq1x/gqZFO6Qz9XycVWLiaC3zhGDnPeqd8mAmh5RfDa8oJv1ktdqdGt9tZRVl66JGo8zwLZojbLHU0YFFg6KtxtMEXkk06nOX5Be5Epl43NRG8+eSC9LEYxA/A2ZHelJ3mX7y2k7esrdFyRmP2QPwXzpvJPGy6eOEM3uS31UU//CJE7I4d+7pFgegqkA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(31686004)(6666004)(478600001)(66556008)(4326008)(6486002)(110136005)(66946007)(66476007)(54906003)(316002)(86362001)(36756003)(31696002)(83380400001)(26005)(53546011)(6512007)(6506007)(2616005)(8676002)(8936002)(41300700001)(2906002)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Q2dUVHNYcWV0TDF4UjJIbWd1Si9hdTZPSG1OZDlKZjBsek9OZUpzY1MyWjVS?=
 =?utf-8?B?UGRBUzI4SzlBenlaTzRndmowOWVwV2wrYVlOa2tPZHJZaHI1eWpvb0hvb3By?=
 =?utf-8?B?alNlMFhvWW9qcWNObU0vMHlhR1R3bFVOTkR5MjBmTENEc3VhNUZSTXdENGVz?=
 =?utf-8?B?c2lJMmhuQzZSbFhWRjNCTGFoMTZYaUtBNlFpY01YdG5GOFBUdjY4R2Q5Ykd0?=
 =?utf-8?B?RTBWbXIzeWticHlUOWtYdzFXejRHK3JNNnZVbGJBNmZpaW9EcjY5aUgyVExJ?=
 =?utf-8?B?T2xvMEVia0Fha1lDNXBDZHFENGwzdm01dTEyTkJIWFZtTTc4MTh6TXRyWnVI?=
 =?utf-8?B?MEZpa3Nodi9VcmtjNWx4QlpJUUtqeVR6U2swRUIwWm1Eeko0Y0QyWTM1TXdI?=
 =?utf-8?B?K2hZMjhrcC9uVUZ1UW0xTFRVZlduNmVSeWZFeGhMZ1lxdlZSek5MUzN0Zmtq?=
 =?utf-8?B?SmY2YmpZTVlacGg5Si90UzJlL0F1aGtQdUNuK0EyOUFZUjNmQ2hTYWp1ZktY?=
 =?utf-8?B?V0d1S3pqa2lMT1lqc2FHeG53UmcyNzdWTDlXbjNLS0VDWFJtNEVvS3NFRy83?=
 =?utf-8?B?d3lHQ1hMaDNkdGdYZjRRYThaYUhRRFBlYXhTbXNzREhjOGJwYnYzalBDbkVx?=
 =?utf-8?B?UE12T2ducE05M1lycGoxNG04Q0pnek1obkpBdURZdmJLbXdDTVBhcHhzUTZt?=
 =?utf-8?B?RUE4d2V1VHJHQUZCSnkvRnl4U3ZsL2NrU3AzSmJleThBTjJpQ3pMYzh4YW96?=
 =?utf-8?B?L3N1UDhVZTRRUkJxN3BPcWNtbjhwNlh2WHF3M01jcjZtcitWbEUvdTlBdUlH?=
 =?utf-8?B?UUhYV0d5dzYyaGRvWlgwNXZoaTJaM3R4L1VpTXVlbERuN0RNYzc4eGxoSHVX?=
 =?utf-8?B?ZDVZa29YUEtYZ1huWDZ1bW1OWmhrbmkvWFJFVm5XSGxKNVJFTE5VRklLc0xE?=
 =?utf-8?B?OXVYTDcrczR4SVBlOVRjakh6eENDbUhMS0FpeGkxZmtxcVlVRy9XZlZSMU9E?=
 =?utf-8?B?aW05RWIybjcvU3ZKMUpBTjZWLzY2RW5WTW9DaVRBNlNUbytBQVk4aTJ4Wkgy?=
 =?utf-8?B?RWFTV0k4bktoNjMxcFljQXZNaUszcUJaT2pUZDJCc3l3a1F5STU5dWtkcHZN?=
 =?utf-8?B?ejhKanhBNitqU1hwMzQvTnM4bmJxN244SmhBczRjMkQ0TlBEZFBnTDJ1bGFS?=
 =?utf-8?B?Uy9ia2I0RFBGOFlFalIraWRPV054cmVENW03MjNwTmJ1Y1pic3M0UklURkxq?=
 =?utf-8?B?c1dqSERwVzZ1UElmaEI3Ui9DTkJtcTRia3crVHIxWUdlNDl0Rk1oeXZjU3pu?=
 =?utf-8?B?NGJWZXhiU2xqODJRSmdnazV5SndMbEJoMGxOYlQzT2VCSWZGQnhhbmdxZ1gz?=
 =?utf-8?B?Rmd4RjZaNTJYYWhhS3hkUWZwZit5YUF3Q0pGNVQxZ3JmS0RGaVNwUTExbUV3?=
 =?utf-8?B?bjhWREhXeHZuVDlMcnVENjgrRlViTk96UWp4Q2hocHh0eW9iN1lzN0JCN2lC?=
 =?utf-8?B?KzQrWFVhY29YeG4rY0lSNldsOFVxVldKS21UejFVNHBiakptNXRMQlZyb1dx?=
 =?utf-8?B?OC81RXRlTU5mMGR5bjlzaHRTaGc5R0krY0VGVkY1c0FmZVBEbkt6WStrSFMx?=
 =?utf-8?B?YlNFMHR2VlRUVkxBNHBGYit4UURRUnhPQkl1OFBFaTdzaGZIZzUydndzSlRl?=
 =?utf-8?B?bDVPYWlrQUQ4bncxdHloajlNMkNGN21ZM0ZIVC9OSmNPZGtlYjVLR2dmRjdG?=
 =?utf-8?B?dThtQjQ4Z2ZaM1Vvc1hZeFhKTXh1REd2SWM4VnM1bmk0QVhWRnVhbExCaEpY?=
 =?utf-8?B?Sk5USWUzbFZJVlpNWEpObTBaWlJoampTSGxUZjBHcG56Z0g2N0M2UGYvUk1S?=
 =?utf-8?B?a2pKMzJoOTYvWUpNb01RVVp1MmlwYjh1SVlWOHduU1dBSlk4a0RkcHF4MlU0?=
 =?utf-8?B?VCtPcWFOWTZyOGpPaWplT3hmVzhKdU03TmpEWWtXckJxRVJtNUd0UUwvOEFX?=
 =?utf-8?B?N0ZNaFJYZGR0a2xQR0hzNExWdEkvdWtYRm95Q0JmSFlmWjdYb1BVYWs0d1lx?=
 =?utf-8?B?WGNVY3FQaXNleEpVczZmZDB3NXJIZkNZWU5uN0VLZzZaeWtpYkFsaTBxczlo?=
 =?utf-8?B?bnhhcE1HeXhldENyak4wUjNUYk1tZFVBNGhobjZMdDBNRXk0UFhua250dFI4?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eeb000-2362-459b-3405-08db50e49edd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:25:05.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhSkE2sdGFjDfGqTvsfKnqsuXx18PtyQ6oHkj5zKyVjcfe+K9f/Hz3nC5XehNCcXufj3j59Bx8W9WNzccdPFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_162508_545839_A004A480 
X-CRM114-Status: GOOD (  13.70  )
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



On 10/05/2023 2:13, Bart Van Assche wrote:
> On 5/9/23 15:55, Max Gurtovoy wrote:
>> Can we fix the lockdep not to get confused
> 
> Lockdep uses static keys by default. Associating a single static key 
> with multiple synchronization object instances can cause false 
> positives. This is why I introduced support for dynamic keys in lockdep 
> about four years ago. I don't think that it is possible to make dynamic 
> keys the default without changing all synchronization primitives.
> 
>> or ignore it if its not a real issue ?
> 
> Most lockdep reports indicate a real problem so every lockdep report 
> should be reviewed. Having to review false positive complaints every 
> time blocktests is run is tedious. I think it is much better to suppress 
> false positive complaints (in a safe way) rather than asking everyone 
> who runs blktests to review all false positive lockdep complaints every 
> time blktests is run.

Yes, I understand the importance of that for sure.
But the concept of "dirtying" the base code only for the sake of the 
above reason sounds like a bad practice in general.

Maybe for that we can have some mechanism of side patches that one apply 
before running the blktests ?
This will leave the base code clean but will need to maintain these 
patches to be applied cleanly on the base code.
But I guess we can have some automation for that..

> 
> Bart.

