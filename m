Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B02DC7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zrU+pMMNWcTlPhRlfTcEKd8zSR46qfuoh9k7W6C+w4=; b=g820LRTQWcqAgbpSjPKosevBMd
	lhrOZdvbfQNJmv+c+49UxOF9d9/rLYNxaO/6vZLBD8qsj+AqctbepsDa2u5yd/zrgaKMQyvM5QF3k
	2i5E7vrmwmFZWsgAkssTE2saL9cZY6c3sHTiREXIyrdsxoU5e1PKN8ZPFouNxSXFoCgrs5auG336E
	Y6jYav9yv8rWwGOJdrwApGGW8FiNUjwx+mE8BsGeu6jcZiowYbEig8ZElWtxLGPweBAGxyVj0LZRl
	2Cdv01D6k2NtKzVwNdq63D+BPLH6hMorY2Ih9zmLU/CfKZ76NxZEfJ8y6n86OTCqVEbstul1NL8su
	K6A8Oa2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwqr-00GWtB-0Z;
	Mon, 24 Apr 2023 14:07:33 +0000
Received: from mail-mw2nam04on20603.outbound.protection.outlook.com ([2a01:111:f400:7e8c::603] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwqo-00GWqH-1M
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 14:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erFriDMUkKgSmsDV2xZeSB+GEGWHhvPtxKoVzu2F/vP4ObMgTYM5IPr/zwHpeko37Z0y69wBM2GfFLtOI40bbHv9X2HOVZjZ3+5JpdLIBBTYJZX3wNbv5h/s/q5hUulQ/srrl8OORkBOnuwchmU14+6XBDODme8Wgb0jnZn/f36z/OAR+w2z0Gl4+HKufHAIlmOujnjAH6Hz2+q9auIumINmJbXuVzjJSGK0RgvGzIqXFkIp4+NsmkX492RVFmT2CWKYTcobpBNAIu+VqglIATfXaAwuDaLPsnVej3UZ928+gcIm4x+N4frTuqlGWJt11A2d6oLRBHcWken1W5P11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zrU+pMMNWcTlPhRlfTcEKd8zSR46qfuoh9k7W6C+w4=;
 b=NONA0G7+qU7pp7gmlFHTw8cg3KJnMM9h/ir1h9iWXrPkv/zEwj4ebVcQDjoPZ2EtSN4l6F3yqf0K276RlF+nxZPI09b7qy1M3GDcjIB9a4Z9qPkW96bJgVeYdxTxVB4UuhqQxDJyiTgIDd/RREj6RfNnB8xZJwc2rYaag5GR3BxUEdAZVw/rwN1s1RVBSWbwmf94VgXQQlsEDdpsASehqvmfr+e0D6F+GFlcwvtiuB74TPo2J7HgrsgPuMuTCMBGKDqxU94BynYtFvj2QaBUXTLkDCZUFgaS8CQ5L2Rgop+0qghG/7V8aNYAg69hPFdyGiVnf5DGWCZIf1qGpJntHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zrU+pMMNWcTlPhRlfTcEKd8zSR46qfuoh9k7W6C+w4=;
 b=ZZPSKfF9Q5RPN2VKz/eq0HXg676nwcGhOjFdxw3V58F4DeYuyw1K0o6bthUbzkuAI7cOcRu8+/WghfIusXjB6FPlw6lJkGOE9azXgSeMguat3MqpEd2ZY5+6XYtbRzplkAmyPxBOvdYXoLj9to3/9Ykaw0noepPIzg4MYjsz0JGhAK20Ukr1uMRmbI7QiUnPlaXWjL5yu9FLNcgyAJwgIm01b1kmlDQ1p8+hSZYKalhmwHzlQIek55Z8bg963qzVoMgC8k4c8JzNul4keiWA0Hg21ZnsHHcF+LsEhsN/RNfVGiwjLYHI9yLfr9+SkvzKDZNgcLlN5+uLPOZMSDgEuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 14:07:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 14:07:22 +0000
Message-ID: <e4cbb808-5e08-4523-8a6b-929fd31aeac7@nvidia.com>
Date: Mon, 24 Apr 2023 17:07:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
 <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
 <980a8241-407f-a3eb-a1b9-d5eb1ae0ecf5@kernel.dk>
 <97b1df55-33c7-d31c-d99a-6c6f5fe4f361@nvidia.com>
 <4eb35ad9-7422-fd9d-36ea-3f1ef895917e@kernel.dk>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <4eb35ad9-7422-fd9d-36ea-3f1ef895917e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ec4bc5-58c1-4606-fad5-08db44cd391f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	9PqZJDnfM47scPkOmMcjxR/Mi4VThWG8o1bX8SvLUMceDuX/Im0aKQIvQPk68XL5hVnnJihBf5pEAzpHYuTKxpWzxmpKNbxLsEuB9bYRApSKGI2yygrl5NO3efSyAvYwsxAAxrFsetelRAGK/WBCL5hOyHdgRo8PSWZXoXg7Suul2VW3bNGVaJke96Rjl9hN5eXZ78T/6dSRwcITrCHFG50MloO5JBuHy86a8yZ/XcKAJWrkeihx/zNSvQEiEGIRDJ6H+0/M+iSb6mKKqhOsbVL4CrwSRKfLtFRkOqCKZ+Dy08IKvpcW7EdxFVea2kfUe5DazgTed37pcohJxN/qL6C8pjjSNq0gTPZySVuDgbDyyd8OGMWf0ODj8qmyEz8l7AP8/qd1pwPD4bhe3H7FFC9l9bgnXk5vLnYelsOjCOLNQKKuYbSLImez6o+Bw5dD1oXWrgTof4GAFr0oM2B1yhP0gSheTEfu8EUSzYbOxyI0W/V3MoKx8RO3Vtv2VAlGd+VIiWSp4fNyQ/WMuK7N/qF3QhMYnqi4i9e2fI0IaaERSEgTEASgtyy8BelaveSUXF2+gbz9OZsxRRRiSIVhqoQx3axfWrPtBJp6W3f0/8Z9pwEaSACkTGdlpGiEkKx7IGZJCavLQGfml2iQ/XQYO50wGQ1kJYVAailm1H71IdqIGc9F6D7RWYo4GfA8urIV
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(107886003)(6512007)(6506007)(53546011)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(316002)(36756003)(110136005)(41300700001)(478600001)(6486002)(6666004)(5660300002)(38100700002)(31686004)(86362001)(2906002)(4744005)(2616005)(31696002)(186003)(83380400001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?eGpYZjdvMERLTndxa0NyV2d0Y0RLRTdMYWFUd2xQdjVSaW1wL0ZxMzNFRkh5?=
 =?utf-8?B?ckVKWTVoRisvOFFhT1dqcTg1ZzhHWkhFYnFRckhrUFdONHE5VFl1c2VSSHp1?=
 =?utf-8?B?Y211RmoxUWdMaE96a25HMVBpaldtSHNiNkhLSGZUektJSnlSK2JveFlHbm9P?=
 =?utf-8?B?dUN1VmNFbXBwNTFObW1RTkowd25tdnVDSDNqSSt0T1lnZVBpeUd5MjBjU1F1?=
 =?utf-8?B?dk1FYU0yUDVHL3VoRExNRWh6OVZkbTJRSUpqVW9NY0I2TXZYOGdvRFBuYzZq?=
 =?utf-8?B?aE9HV3ZLMzM0eUJXNEtQSUYxc1Q5RUZUc2JtL25OcTJPUDFGRm5xaDdNTDlk?=
 =?utf-8?B?VzRVcWVya3p5ZDJ0M0x3M2NaVWFwVzMzM25jSmkyNlVrWmZDdW5PK0pCdTQx?=
 =?utf-8?B?OFVENUlHUzBhQXdaSURNS0tOem5MYjIvN0gzZjNMQTh4dlhJbXU0anJnZXNl?=
 =?utf-8?B?YUNFVDl1SzdYeDBKMXY4WTMwQUY5bHZicndncTBwY29PM2VpdHErelN0TGpQ?=
 =?utf-8?B?Ynp1eStPOXJqbjdDU3dhNUsyVFQxTEljSGpHcWlaUXFIVHhsL0ZaNTZVeVdx?=
 =?utf-8?B?bjQ4Q3NMWDVvaFh0M1MwcjdmV1lwT2kwdnVKN2hRcXFwZDdpczRFTnA5VWJr?=
 =?utf-8?B?TU1XNjRoNCtuWkVtZVU1eWNBbGZwamM4YjArOVNWODFqaUUzNGZZUnB2YzJz?=
 =?utf-8?B?bjBNdC9MekRmQlF1aE9vVTdmaTdEYlRFMUhyUDVCVTFMa2VVUWhJL2hIS2pL?=
 =?utf-8?B?UzVRS0N1MDZOWE52ME5nUGFMM3ZqdU5CYnZ2anZsUGNXUkVOVzRLK2dNNy9W?=
 =?utf-8?B?M25nKzNSYklWb2NUaTJtRlpacW9LeE14ejljem5xZDVkY2NMVFJwZ0pDVXhQ?=
 =?utf-8?B?Rk1lSWJxcmFtbHBOQUZ2WDFlOGN6Y3FZa1I0Yy9XajZ0SzZvaXJtYnY1RnFK?=
 =?utf-8?B?aDArQjNPcUhNOHlxdm1naFNsY1N1RUFORXh3M0JwaXE5ZTVsbC9za3lNWEw0?=
 =?utf-8?B?L2ZsT3FpbTc3eEZVMkdHdC9TUzlVbk9JZjlGZTVtWjZsZEJnbDNMb3V5UTFL?=
 =?utf-8?B?b1NvMXpPYW1FbVZJaEE3S0hpV0lxYkxkbm1nUWVZRlRlVlZ1OWMyYUovazlR?=
 =?utf-8?B?QUZ4aGF4QWlqN2o0TkxsN3ExZFlaWjVBeG1lU3dtQ1B1cFFvSHNSUjh0eHls?=
 =?utf-8?B?UzYzSHpNZUJDeHdwWnA4dlY4MC9HcjNoYnlod0psaFVDRHRreCt5RzQ2SHJy?=
 =?utf-8?B?Vnc1NTBtRWt4VXNtTzN4UlJldGVzTGhTQ0hOS3R6WVNnQXRyRVcrbU5meUxh?=
 =?utf-8?B?d2pQZFcvOE50dElZSGhSakZrSjVRdCsyVXJVZmsrWnVmOFdWMGlSTjc2SzNF?=
 =?utf-8?B?RHgxTXdjYlRmNlBycmFOL1A3TWZBeVBESHBRYWw1b0ZkcFBQcXZxWHVrSDU1?=
 =?utf-8?B?bjR2YXI4N0JNZEsyeXNIV0lpcWduY1JmYVJheCtkWFZRWjVMU3Rqc0RNcWFO?=
 =?utf-8?B?ZW5HQUxiU1YybGxqbnZSMytyRVlqYXhJQ0hRc09KcCs5YktCc1JBWWhBdnVa?=
 =?utf-8?B?UUpzTTlyYmwyT3RHWUxjMzJmVlV1dEpib1FnYTBBeS9jUDFPcm1ZWlNIOGJ3?=
 =?utf-8?B?OGYzQnBVeGNrakxhZTd0a2F6SzNYUzlDRTJxa1RSM3A3NFRqb2Y1Q2ZpcFVE?=
 =?utf-8?B?VmtkVnhWbUV0a015TFdRaDBmOTJWM2tvbnlwNXJ1T1c0MDVFUE4yRW5rMHNH?=
 =?utf-8?B?VjRGc25xSS91RWgvemVtVXBuNUJKWjk2c1I5Ulh6SHpZeWFlTDZ2amxLd01T?=
 =?utf-8?B?RmhGNmpMUlZnKzFMSnB2VGp2VDN4R0F5bUJITS9jTUFOYzQyY3pQZEdHaEtC?=
 =?utf-8?B?T0hleWthV0FWQU45dWRTRG5LN1RiN2dMRmt1aDVhWlFpOTRVMGRzTHFLNWRl?=
 =?utf-8?B?clFpZCtqSmpuZlpxWG11UjdhSi92VzQwL1ZXZG5qMUt2cG81LzcwdTIyM1NI?=
 =?utf-8?B?Rkw3YXhtcWZwMEZwdEJRbU13V0pCT0grR2xrZHVGS01pRVRyZFM4UjB0ZWI1?=
 =?utf-8?B?RWJlNTduRGplWXNCZWRhLy9Rcm55K2hRME1DL00xTDJHeW1lN3BuM1Z0c3px?=
 =?utf-8?B?eGJKdkJDdFRPN01acElyT25VWHg3VVBuaHRpWjdzMFU5VzNPV04xNlh2amo1?=
 =?utf-8?B?RjVKYXVSVDRlWTF4aUlJeXFwSFZGOE5aVDQrRjVCNTFUMlMyRFFqWC80Nnhp?=
 =?utf-8?B?U0J3ZEJvbGY0SHRsNU44WEhGaTV3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ec4bc5-58c1-4606-fad5-08db44cd391f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 14:07:22.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5gx41JlXxrGz82+IuLBnddKiYFLZemElKc23ANpQgdNrpW4M3VuG7Rv+qZAg+u9v/RafB36o5v2v0VXb1n7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_070730_502635_50249ED1 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
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



On 24/04/2023 17:04, Jens Axboe wrote:
> On 4/24/23 8:01?AM, Max Gurtovoy wrote:
>> If the only comments I get is for copyright then we're good I guess ?
> 
> Didn't closely review it, but conceptually I agree with the change.
> Declutters core.c and usually there's little need to touch the sysfs
> bits.
> 

Ok. Let me send it again with fixing the copyright and removing the RFC 
and the concept agreed.

