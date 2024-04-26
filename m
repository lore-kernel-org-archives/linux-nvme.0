Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE7EC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=713rz+fahhJqnZiRL1KjepoOX1AHKROFwGBdBQtlDEw=; b=WIdPzgPgOws2usqyVK3X0ERxYz
	b2K/P+w8Pu4b0f2YqbrKbalqyPE/9VgJHna6rVdbDYKRST4mh8g6eVOZr1/DD5+YRgdW0LeoK8dEz
	IjVtGig/SgH0cHbLxzOFJn5C1VbEt0lxj03DhKuYJLq2wN+U6Ler00NwQnYbQb/Ya2MEeVIpXxylR
	OPFz80CKxQO/ZM0F5xH4OCpkswlSO740XmXlFsD27YJTFhLAk5ojnAg42r1xbCwe0zFjEJAyDQG6n
	Tek8zX8nqBeS8wMTJrEHtSgTIywh5p3nnYV2B/xXFvCivMzmrG7ubmFaIZFjoD0KjuXR3tlqosSSV
	7mqoFbMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0FuK-0000000BRz7-2CiX;
	Fri, 26 Apr 2024 07:22:08 +0000
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2405::600] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0FuH-0000000BRwj-16IP
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 07:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg/OE+Qc/uIBFMz+Jzqa+sGZEXy0AW19RkkBEEV+ooY7bat4M0hwTdW9N2mm0lh1TCRRaVjl7OVATqOYohfzXoPbWgcFFwCnlNPl4HnLkxrBCIVfGGstWJz3rfGkj8oF6ey2gFzvd0P9djA/uTaYNp0K5KrG1PRp378bIxllaP7JNZ/JPSv2H0xup6HI76DIaDAYRIt5dbRYzkZDcWr0mOeDpEmByZITSrUrgtQAhCUu1rdqOMa7+Bs2BWcLHcMNphc2xvhEkoiQyK8jhmkMapd+PFGjYyNqRCmOTBBzGReBzggUZ6X93mxmj8goD+RF3Ds41vxMz6cSRottgb5nhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=713rz+fahhJqnZiRL1KjepoOX1AHKROFwGBdBQtlDEw=;
 b=ZuSPHNOT93pJGasDVrdY9fLFkooaaoQSuosV8VWo9u5fnu4qG17pjFj1MfBUyT2VaC6fsG0ZLmG+zyScYRDyDWUuI55kX9qXPXTAflC0jSXKPTqH2eSjW7aWguwYTy2JsOPGOdKx1TWtj1A7ht7slbz2PwgjCBTyG7goKHywjC4NTuP+SWyxw9pO7uRFdhBcCKy0nWp4RKIkh3plh3+Qna9vfCjn0jeDlXVTT13T262Rhn1zlXSA30dOetSN0glzucpueJtP+50odJ0RPywEaY0AvIZCQd3fd9exlMAGfc1kBWEh8mLv4VO7M7asjdftPzddgZgiuyZE0TvjnCq5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=713rz+fahhJqnZiRL1KjepoOX1AHKROFwGBdBQtlDEw=;
 b=IXS6WDfPDwzIAHwSxNudDaUtdd0l3bYDDTV+nHbh/I4Jy0uHhdTM2JWvsPBn4E/7N+yHJsSmV+c2I4OPSuSiiUXojlWyguk6C5tMH6DgmLPbmLZcsw/SxUAkQFoHIU2YnUjUTT0nUFVjXAWs3tiG3DeV1Js2JhDyhUcLxOHB7y/XfjWrB1LP/Hv70avAcEF//J939TE92lTL5D93hzhtvmZv82pRTMCaplNDuc5tQuUKMGdL8mlotVVQCO3FpOopEW/bSAPbeqOPChkuqwzvGVDE6MZNFRIErfQLKKn90uJXG78mdFZQkLtY2jKPuT0ne0GerXnH8OsYV5QdarwMuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 07:21:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 07:21:50 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
Date: Fri, 26 Apr 2024 10:21:46 +0300
Message-ID: <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 252317d2-8551-4039-eba9-08dc65c18a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rRqk6H/ivR1RaRjBzOB4qViIP2rkdP4TJfTK6vYmKFrC7ACfEb7PAOvbF26f?=
 =?us-ascii?Q?K0c2z9wUtB5Y5BLxht8Qz9benaMPa8jDX2Oj4dw5l+UCD0d1mGfqzN8ySJ+E?=
 =?us-ascii?Q?KppztFHQlKL89oyWPHQw7R8+zq/mJgLHIeM6B2ByY/LqWJpqPIoGqU5C5Kwf?=
 =?us-ascii?Q?iccNB2QBYTPgUAMz/aMzfOjPI7LBmvxUE0nL50TdnG1bofyc4OdCqSGHZkPk?=
 =?us-ascii?Q?5Yl/BdNZg8Y8h6ABndLIrH3l0Pq6L/I9kXpS8FiSBvACOVp9hx++Y/Bn3tJF?=
 =?us-ascii?Q?CQRYZ4UlAC+/TY1ygiZrnl4yJ3gWFJAbbLauaMVDOsOwNXJ+0yDn61uSqrfH?=
 =?us-ascii?Q?lguEW9Z+HLmDlLskiXAX30aIufrSWeGMLqG5AGWYzyCLqrT9iQ8cCEKmZTve?=
 =?us-ascii?Q?r3lMTKH1a1SbtfhUXHJ/Z1mFpHiScSyYy8FYgYBXnIp9tRuKFQWNgXaaqOqV?=
 =?us-ascii?Q?OIBdbNe7GUa1uz06QkKCHkpFVwRD7PfixfC8y+NAl/x69xCTmXpbrhZplC1O?=
 =?us-ascii?Q?ryk8Gh+BhvdE5MhKcTzV5h49B5HFX/X1TSorsjl/RM/UymnY2dBnj3ak4e8J?=
 =?us-ascii?Q?/W+cdd/SUOz7TpQLTMbAA1h+Zb2gmN7wK29FZ7iKxZkMIeGRSQFFwNXKEX0n?=
 =?us-ascii?Q?EvioBbHuASPi/Z6w+/KVPYiwiR0GlMHfwLl9BgW1xt815szvnxxHBHPX5O51?=
 =?us-ascii?Q?WIt6moZFv/ZMul2WVlA733a47gy73jnfIxP8dDQ38BAHvK3cS1Uc/SodipMy?=
 =?us-ascii?Q?vlKMsnf7q/+ETlWXD64GhS7IXZS4CBCLuRjmhec44OVPgtCpUFgki/wjpeiM?=
 =?us-ascii?Q?cYXMs4VGD1sHsSCqA66ifAIqPCrrG2Qd7uProTf/c9EsxnuX/zKHiXBD14YP?=
 =?us-ascii?Q?j/IjTL9Q74N0lWKUTcaQawTNyo3/3Lss8ME68wAW/v40j1KaLpvSeRhQ3igR?=
 =?us-ascii?Q?z8w9yejpODL3Mt4PFyy5TmYyGTh9nIKZzqWJHPPhWN9RD9lbnvR3Eolai1vZ?=
 =?us-ascii?Q?EP4pCYPEPyrnr+RT6Nxe9r+kiszZ1h0cITKDdkBul3EAP4W8ryyJi03hqUo1?=
 =?us-ascii?Q?F3E4nr/pJvrJNazKMQarn7BWUpKnHwknx+ra8gTiMbup2v8dHDRtfczndNdh?=
 =?us-ascii?Q?n473JKc9ErS9NEurdR9w6+mJ0USXmEC1FksNXcbIktpUFLYm73WAmTIgWBR4?=
 =?us-ascii?Q?h5378abwKx9+efAZvt2N8CMysCY6Yz7tHD8/27IW8I/0BcO5RrW8ybJbeZca?=
 =?us-ascii?Q?VHiX5N7AvPLVfhWoSqjrcQPp54mrDqy8PHczXTN11A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kw6QfefDOyDAnbAbMoqEZG7h3zfF5zp1z17t0ImgQoDA9JKLw/RHN0BAaGQr?=
 =?us-ascii?Q?LPLRVMLoZRocinqH+9nzAgeWght6yqfhjRFp7hA30Df3DpsPaZIx3qxvW4x9?=
 =?us-ascii?Q?9yEicxhWUgO+Er7pdh2c3pfbet94pTSTGe1TjJ88tW1eZo5gwXgBkY9uKnaz?=
 =?us-ascii?Q?JcGP++qtL9lKLUf2cmrU1E6ekhSyGz6yOyGk/kzkWFBZV2SYrrSMGseW5EEi?=
 =?us-ascii?Q?eDd4BBDlT2Gb0FAwTQVOlXIS8PJ0tM3steFxupZw9J8CQEAf3u4FzrXpbWIG?=
 =?us-ascii?Q?cn3tiS6qpEVn/qfi5wnYnWh3SUeeS4eFkjmULTFSbbTzdEwXKQB9u81YgDNi?=
 =?us-ascii?Q?3f2RBM664dcbMS6q4vjyPhqC7/OyRUzm2a0E07vEkS0Zmp1j66OZY7hxF+t4?=
 =?us-ascii?Q?ESIPWiPEy/RvDsPmJpJ5/yIxsoS2oOQ9V9vC9lZ9Bol/02lvUnXgGW87IJ4M?=
 =?us-ascii?Q?pnmeg7aNqjjNgjJv/0fAxYbLtHoT8TH+g7lR84HT+Y5H0IR3eS2WyQkQGxmq?=
 =?us-ascii?Q?hRKX2bvIsC36v9yANoqSLBiHWHHLUvdV8IdlK/7fWkltNQCPKEa1M15qdVFi?=
 =?us-ascii?Q?WW2YrXoySV7gxNHMkXhHIPqbeRZGGbQiO2a2ffsaQO13vsyeQdwGHx2+3Nyk?=
 =?us-ascii?Q?h0k7QmfCWfQPa07UNjnIVw4dvjW6qY8G4hN/hOBOZwKQuunPfjgN8P//fOWJ?=
 =?us-ascii?Q?q7t/o9I8RbaLRrziZc8ro8qguZmAi5R1pqxF0wF8vQzJUA30YMiZBZayD5yP?=
 =?us-ascii?Q?axBPreco0TXq6dK+bKI09cFkVFwzKBKKGOG2uU5LqwJpI7d3weieHGfIwFsM?=
 =?us-ascii?Q?ib8Ae4Bexz2ExJx1+poSOp33Z4HxgvfmI6bm5JJoJh029yLhvRZ+Ig9NrdkC?=
 =?us-ascii?Q?5pG3PzEduFNfqhOK6fkEGRF/axubCRhLDlWWpUIrB1Qrp/S2pdN0pph9zApW?=
 =?us-ascii?Q?M6jo4SIo2HlSvLakcgis/eEgtHPH4EZzS80P/HdRxsmS5vCltAmMpU9JZN8K?=
 =?us-ascii?Q?9CffZ3e0bPc7vPUpDfVdnRRNuhKzasP4LtG4TFGjoZHjDcG1yzrIxIdQ/h9i?=
 =?us-ascii?Q?UQ6U15QS0PoXULG43U2AuJsPI4oliPj/yMz6H6xcDa0boKxjpUYyI55Oey86?=
 =?us-ascii?Q?LaOl6Wwql/Ms+rNnN7kGZ0wlHIU8zdxTZoI0sfeCNe4hhpu5vhkjkJoDr1Xp?=
 =?us-ascii?Q?EsN1va3nJtzK+f7Mo/q5pFTjU6ARGE93al2SBBOOY830VagfVz/LOLJ4U5Fg?=
 =?us-ascii?Q?m5CrBoXKtQq38EZoStY5Ww5BSFlpKlW7giJHw2U/sdnSVnqHJqH5bSc2Ts20?=
 =?us-ascii?Q?JGQ62QL9qv2R4YQG/PqxMFVYMb+5DC9++keHxXGb+lP4ajSB6+h39OKIANsA?=
 =?us-ascii?Q?i+GHUR2opKzgf9NWLZtl0xuMnB4zKmyL/rTMrwXSDMqDaLXO41hCKJ02ywv8?=
 =?us-ascii?Q?d84wNu8YGAPflXbkpXHijBTl8LotHSQYMR6U++P2Oj25y41cyPGR8jlH2Le+?=
 =?us-ascii?Q?z/+G4RU7fAwO7m8Tun5+1i7avqLA2SyvTFUkRepaaWBCnZgzao9UHKMhJEFL?=
 =?us-ascii?Q?zdU037aepaMylZlyajNTaAB/l6PTwsYqJvHdrFXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252317d2-8551-4039-eba9-08dc65c18a77
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:21:50.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECFlax1f/Ut4jxNuoGMqRk9SMc5CtwLJYKxVcvLefYAOgiVHNr6tixaqEQidL72ESY8P3ZklH9qONmINrEgeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_002205_331304_9F3AC9CF 
X-CRM114-Status: UNSURE (   8.10  )
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

Hi Sagi,

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     config->io_cpu = sk->sk_incoming_cpu;
>> +     ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
>
> Still don't understand why you need the io_cpu config if you are passing
> the sk to the driver...

With our HW we cannot move the offload queues to a different CPU without
destroying and recreating the offload resources on the new CPU.

Since the connection is created from a different CPU then the io queue
thread, we cannot predict which CPU we should create our offload context
on.

Ideally, io_cpu should be set to nvme_queue->io_cpu or it should be removed
and the socket should be offloaded from the io thread. What do you
prefer?

Thanks

