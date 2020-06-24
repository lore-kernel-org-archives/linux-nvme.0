Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB1820768
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BecpFCa/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WDV5dks8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hCunEhE0mKRdyrYOc05o2NvUUKRLyQipvcKIJBAWb3k=; b=BecpFCa/04ChucDpq0D58vukA
	hCcGA/7L5fg1ngn1Sw+pG6FqiJgq/7/C8qyu9Gjngm+CfrCay0EIAdVomC80EZRuJaoLBM1Rel7aI
	KgXP5eh2BNaHL/ds9wT4cmHJNFEOPehidAcytDgNyt7mikT6S69pvXo+4yDf6ex5n2YTdLqdgfD8L
	M5VJf6SedktZGGU6TS6KV5I+7podCl8xa62G0tw5DTHoZ3H54T/4+6yCvJBt0nCekZsGu/svwKnqH
	7AvRay9IflxQC4Vi+q03vmN5zarr+b9XwtD3Mud0wXsqj1ZfroD5xulBYYKE46rkombZ2P07YGrWG
	Ha3mgbJuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joBTW-0001vW-Vg; Wed, 24 Jun 2020 19:54:27 +0000
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joBTU-0001tr-Jf
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 19:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTOcFSn21TEJfOarisEKKdg9fOxbfeVRJxVGLCw03IVDGcW8KDSlDXu+HEVqOjTIAOKbeny9KEkzo+yOxFCWkJKVUWk0ZG70H/ZAaxxbEgff3BbtEbrGIVMHvhZwsUGHxOWCaD9zaF5hBXuXjN69mx/1Tvt1rY1fswzfZE2C34CtzKjzoKzCIH3kUBA98F55+olNGVBn1K8Z/xK0b4/ynbe3xrrpXTkzOp6oF4uUBFOou7A/UlVMzGcjVneHZcvtvcQOFk/4rU+KtWdWL623MyD3N2m/SzC1APl8rjGdp6H6mcnau0QmT3ePMCIb8i4QcAjc+2B9B5seoholWGs3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0goPdH34rqkWbLMLKEl4EtokNvoC1qB1F6dknVtp3Y=;
 b=b88CJ9XFcOpPNt305jwB5tJcZ7At4tZpovclcsWL7YsCue1ZtiKnmx0MnMokOEpOrUo9doIJ2KtPgd4W9nskaPzmXgz5yacmokLIxd2QyDHjwKI9/hbGvD/JbHfyJz08uRWQsQmafIcz7B8bA/Vib9VuZf2TJU0TCFqW0nEqqOCeO6c/jrVxPLnPFVj+1VEFV3njDOAnHUT9v6G7ZmVPZKMRLRGXSj9opWISProus4HLk3MoIXzbrH5c9SKq+cLNIABxAxSUP4WmpxuwCZtqDEQpN0R9YRBDIrBBiFfJ8RbZYb/Two++IGNhuDwoEn/3m0HR3CcuDUZP5q1F7leGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0goPdH34rqkWbLMLKEl4EtokNvoC1qB1F6dknVtp3Y=;
 b=WDV5dks8Okjh7EcoAN2ONKeBJ+ck4wtHjXbgBiiBWiqOQsYjaNjuVQRzeZlP9RR9UVPcFVOxDUeh7nlGqv9DBo9BuGkBxl780vsmgW/Re7H/OwBqmGwho7KF3C+z1T7a1LAqzlfkbsuwhUhYiuMGCQ8DC9nrFOlgyDgE9PNrhx0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM7PR05MB7092.eurprd05.prod.outlook.com (2603:10a6:20b:1ac::19)
 by AM6PR0502MB4070.eurprd05.prod.outlook.com (2603:10a6:209:18::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 19:54:19 +0000
Received: from AM7PR05MB7092.eurprd05.prod.outlook.com
 ([fe80::b928:e157:6570:d25b]) by AM7PR05MB7092.eurprd05.prod.outlook.com
 ([fe80::b928:e157:6570:d25b%4]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 19:54:19 +0000
Subject: Re: NVMe over Fabrics transport requirements support
To: Sagi Grimberg <sagi@grimberg.me>, Alex Talker <alextalker@yandex.ru>,
 linux-nvme@lists.infradead.org
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
 <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
From: Boris Pismenny <borisp@mellanox.com>
Message-ID: <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
Date: Wed, 24 Jun 2020 22:53:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:207:2::31) To AM7PR05MB7092.eurprd05.prod.outlook.com
 (2603:10a6:20b:1ac::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.11] (213.57.108.142) by
 AM3PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:207:2::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 19:54:19 +0000
X-Originating-IP: [213.57.108.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd5a7db9-3a74-464f-ebda-08d818786247
X-MS-TrafficTypeDiagnostic: AM6PR0502MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0502MB4070445F7C2676CF09FE18CBB0950@AM6PR0502MB4070.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFxNDJ1iGPwGDfTSq45AFGmkYSXTCGIiSnO1taz8gYPU4EaElQ+IgTOwK4PONkGC8d+2vaQs6ZAjDWhg4dEQruGMElzA2P41IWbg4ptH/e0yYMLPG/FVE4HRBNMZMa41BZgqf7Bza2mebSv1NQdN7ygN702KRgMiSlvEU/Pk0AtrmozycWD4LUJ7Hcs09K8qf5yN80m/CSXT6ijag2by2gvBGERcrtDfZwoxJ/7T/3GR4kcz7eggUPBWNGeDay0IpaQMTx/eg7Xy/zT4GHU6G6L3D0zjf+jk1NFY1DGGGx7zPTdDdnscFtnjmeKsA/cLj7mxtm9bloKflRKrC58nnFTJGmdKL/sXSqHwDKMWMVuZy+BwamTxzoeThdlVmv8i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR05MB7092.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(316002)(186003)(2906002)(478600001)(31686004)(8936002)(8676002)(6666004)(36756003)(2616005)(956004)(66946007)(66556008)(66476007)(110136005)(16576012)(16526019)(26005)(31696002)(6486002)(4326008)(53546011)(5660300002)(86362001)(107886003)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P1g2u/TlBUM4AjkHn+ctv98LGqC6QxHwF6vPuk8IJL3EaW30r1syNGRhCMlqCHGOQ4QY4KtHp4Yk8XEbqN0+nZevUE5cQgwWjcjF/L6W2DdggLOrOuqbZb9IEkz3OQKkYlQWNEzEnu3M4fuuD+pDEaW7G/yoW8mlFID+dep1LI3drYddj4Xq1S6ZAI204d1Niiq2y5+WCrzlcTZY9Z1AFaEp2E2yk397V2Zdz1jy4uR7CfKFsi5KptC9OK4XrKMr+jhQX+QbAGzqf6wyA6KwIeBpTcU0WmxKkMtpc4OA4zgPLvknjxrVqNbXJhIPx6ZohebDMxVtCMHG+l/LlLarBcgUYM7+8fPfJdZS0xO32xsxbeYnXR0NOq5euAdj0MdPDiCZNvsSYozERQZfJEavw134nvG30iVtA7gd+t/sEcARnmCMBYjidDKICRxGi6IPI26G5jH7idR1bQ04jDUB+junEhhCjxxuaNTo0eHEXNOGwjtB4rrEhKNBYJwVdcQz
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5a7db9-3a74-464f-ebda-08d818786247
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 19:54:19.8501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuDE4pZ5gU8gRetd358YmKiA54ZV9cVyqyxRIJpr4UuMvhP7dRFHlVriWZPPUILMdNF08LdfAZRnCRLCFldh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4070
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 24/06/2020 22:25, Sagi Grimberg wrote:
> Hey Alex,
>
>> Is it true that setting any value in addr_treq attribute of port in via 
>> configfs
>>
>> only affects displaying TREQ on discovery page and doesn't anyhow inflicts
>>
>> "whether connections shall be made over a fabric secure channel"?
>>
>>
>> I can't find much about whether RDMA(RoCE in particular) is secure
>>
>> but for TCP TLS is must-do these days I think.
>>
>>
>> Is this functionality planned to be implemented in near future?
> There were some discussions around adding this. Currently there is
> some infrastructure work that we need to do first to have a kernel
> consumer utilize ktls (mostly revolves around the fact that both
> ktls and nvme-tcp are socket consumers and implement sk upcalls).
>
> I'm CC'ing Boris and Or who were very much involved with the
> ktls implementation in Linux, they can maybe provide some more
> input.

I have some early-stage patches the enable NVMe-TLS on the host's
receive side and on the target's transmit side. It requires
some TLS infra work, but the real problem is the userspaece side,
as the TLS handshake cannot be in the kernel. Consequently,
nvme-tcp must be modified to use sockets provided by userspace,
and I suspect that this may be controversial. At the moment,
I'm busy with other things, but I expect to post an RFC after
I finish with my current project.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
