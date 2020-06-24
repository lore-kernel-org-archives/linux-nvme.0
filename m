Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758B3C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B4D2080C
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyCBhYyQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DRFBtF+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B4D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eCEk8HcgQ7bexxuYzdrsljxj4q1w9eMST73oMTgbNhI=; b=MyCBhYyQvGEJjQzwDnFiKEbbT
	vSfizC8C6nlrdwXoFTnui73/fP/46eaKbfJtM/o3Ux7awW4WUvT0/5RqUuzHaja1+K3MohEoCX+8J
	Ale3kIy40zXTruDg+7RdqLRvBTEKW54S0Cr9yP5u6kT84TLHAaIVilvwfUkvhxaLBjESdOZ9qmpQd
	6YVaMdvYHqXmtyPJUY7h+un4Q7ZQBZjP29Kr5uSiCUbhqqwVNaBnA7CsqAAC4i3q4V5zvwman6YvA
	t3g+PbVtspRvhE8Rjvh36SXVnLPc1IKyIwg9LHCX6wHcO1IpnjI6Jh3A2mFRWA7N4lkYQtb69GGPU
	MsgBcLjIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joBt1-0003kN-2E; Wed, 24 Jun 2020 20:20:47 +0000
Received: from mail-eopbgr130053.outbound.protection.outlook.com
 ([40.107.13.53] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joBsy-0003jL-Jp
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 20:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcKrcqejyjb9i3bAZmGuRU3GG2Jyu+rIXXKtoQLBXMCIC8sySkeH/sQVIkWAEBpvlabqqgJ794vm6VIL6nXTJBF90Wm1s/yNiiOkbASoxkCzsKZ19XMBduyPa/PV7J64o8qJxzlLfSXkHc1X63fXgqyxAGwaEH55GEM7lDB2mrOxXpf2L/+uLEAgpuo8JtFYtiWjj2AJOVTxZg8Pka1NLZFPZTFw1F4famPaO/iNHshJQvhdlmg9f4P57RpFSik6Ysm0oVhAGI6n0+dP5LEpBQXuAO+Jx4AX3GhWfhgZr2PUPrwUoOCGfSPXQNzPc3rFpmCB0E/ClOqTUP8hJVOHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df3O6lW3O6KYnAZ3tE/RxVj417JNbqrtt2Kq1Lg11pA=;
 b=ajv8iepw6j+Cf/mTviIHFrePRiBIh+eDSYbCyhdgxmwfjE2ja4IPMLd95pGdO/qSj2VONXDNc10gi9dZwxghDfS/IlNMHiZ4KiuHRcxZBo9axcN+1cy07Iqa5pCFi3/ZR4pWrciZghN38lfgrcgwg03UjW2ZyOwL3fVQPPR/jn3HgwBDhRsXZp0Zc0c47rhunh8KQp4mT+lumTncTHfMy7jg3AbtdWgw3SEMqpivXXmoGxbBVCXEtDrMUuepkPdihhnM+8s6OvqzhOo8E1IzMzcbAppJRgdROlOgsoa4qPEtTx9RiZuk5AkpF5wr32iYA/+UcwkjcEO9M1L2BEl4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df3O6lW3O6KYnAZ3tE/RxVj417JNbqrtt2Kq1Lg11pA=;
 b=DRFBtF+w/Y05Q/trFhfESbhYFP1R5+h7wqGnJ5rMZgSNhxz9Oo25Z2fX23R48x0rQaw3wHqPf635gZbfwK9Dx04ujH1WbClSYAHk+BW8XjpTvOQSIryroQtaopRugwMRi4YI1mYicpkxiawGRyHe1NCjPNhTeyberYB0MQgkFTY=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM7PR05MB7092.eurprd05.prod.outlook.com (2603:10a6:20b:1ac::19)
 by AM6PR05MB6486.eurprd05.prod.outlook.com (2603:10a6:20b:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 20:20:42 +0000
Received: from AM7PR05MB7092.eurprd05.prod.outlook.com
 ([fe80::b928:e157:6570:d25b]) by AM7PR05MB7092.eurprd05.prod.outlook.com
 ([fe80::b928:e157:6570:d25b%4]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 20:20:42 +0000
Subject: Re: NVMe over Fabrics transport requirements support
To: Sagi Grimberg <sagi@grimberg.me>, Alex Talker <alextalker@yandex.ru>,
 linux-nvme@lists.infradead.org
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
 <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
 <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
 <75010fdd-36dd-2ac0-a658-4fc7070744f1@grimberg.me>
From: Boris Pismenny <borisp@mellanox.com>
Message-ID: <3a774d39-f786-bdad-0dbc-1dd0e6a56a15@mellanox.com>
Date: Wed, 24 Jun 2020 23:20:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <75010fdd-36dd-2ac0-a658-4fc7070744f1@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0048.eurprd05.prod.outlook.com
 (2603:10a6:200:68::16) To AM7PR05MB7092.eurprd05.prod.outlook.com
 (2603:10a6:20b:1ac::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.11] (213.57.108.142) by
 AM4PR0501CA0048.eurprd05.prod.outlook.com (2603:10a6:200:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Wed, 24 Jun 2020 20:20:41 +0000
X-Originating-IP: [213.57.108.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f7cfec0-f808-4bc1-6766-08d8187c1183
X-MS-TrafficTypeDiagnostic: AM6PR05MB6486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB648608CB66C00B8CE31491CFB0950@AM6PR05MB6486.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57OnTAX6urrNEz2z31BK3IuBet+sGMnU6Cj6ielRDnlXJDK1u90Yv495Wj8L7MWH6vVLt1mkjTWbwD0sREqd+P+ifZpm9lzsAIujeygz4JKo6lHO5MlEIBjboZdPYhmhx3tTYFHM2q1Rp29CcDWvB8J9nekvKQNptPQ3bisJE77gBni2HdUhiLiab/sweNvuoQbCDiATBT8wE483MUpX9FrlonThZYzhezEk23oedZ+4RrGjnfgBb2eQZCvX2Hhq1XGXyaEPNU3EKUZz/7e/UBarGlz7EK3d+fHus8+koGtG6MhkWCzvVpA2fyhev0MFknTH/a/jmOReeRQk5V4SHJYnmsF3yE+p/2z5PnpAM0ZdUZ2AjKfRUxSzbrweOptZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR05MB7092.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(16526019)(186003)(83380400001)(5660300002)(36756003)(52116002)(26005)(53546011)(478600001)(2906002)(16576012)(110136005)(8676002)(2616005)(316002)(66946007)(66476007)(31696002)(107886003)(4326008)(86362001)(6666004)(31686004)(6486002)(956004)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PrzSlDl/8qfrU4sjf9nb6CbjI64wI4NSMpXovueQG37/wURkqTaj9o4etcvz6UoD5DBGO1qo4UVlgHx0mPiyep9s0EjEDDElxymHTyBLOrJC/KO2O25xYLdbGUyeYX9caZWEL9iMgPSqa4ddnCrbJBSubyOQEF3T+LxIytM60+mWHRCGBc2oMWpPLf7MzSgavS+NAF1Bwd5YWiTSBGem4rpBICMb2PbiAITtnipSUnwU9Y+8JCUdQlj6a8Ps1198xf3iDxB6QMg1BauiMzHjVjM4Ekr1rYU4FS3c/lQHafe/cKQfX8pE5YvVSi8SumcUlht3rVfGVnpRfZGXM6jUIYvgr5GCTQJ4X0firoNridhF6jHQZ6+PqjhQaSMxUwIv/GjMJUAhJ369LnKpT4/dHfM5ZCoKykqI1HMDAmpmh2pcD4OsbJbYAGrsYiVJU2pSHrwEJw4Jac31stJCijYFRQLvEptmRuavqEkm4O+jFDyNAAdkSu/50M23Jbf850dS
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7cfec0-f808-4bc1-6766-08d8187c1183
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 20:20:42.3772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b78sP7RO6iyN+cZgdXxW6SRPyozN1QWeEWbqkEHtX8jGHxY17qdKXGmTsv7Xp7T7h4BySUVyZZzvG39mQMc88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6486
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

On 24/06/2020 23:06, Sagi Grimberg wrote:
>>> Hey Alex,
>>>
>>>> Is it true that setting any value in addr_treq attribute of port in via
>>>> configfs
>>>>
>>>> only affects displaying TREQ on discovery page and doesn't anyhow inflicts
>>>>
>>>> "whether connections shall be made over a fabric secure channel"?
>>>>
>>>>
>>>> I can't find much about whether RDMA(RoCE in particular) is secure
>>>>
>>>> but for TCP TLS is must-do these days I think.
>>>>
>>>>
>>>> Is this functionality planned to be implemented in near future?
>>> There were some discussions around adding this. Currently there is
>>> some infrastructure work that we need to do first to have a kernel
>>> consumer utilize ktls (mostly revolves around the fact that both
>>> ktls and nvme-tcp are socket consumers and implement sk upcalls).
>>>
>>> I'm CC'ing Boris and Or who were very much involved with the
>>> ktls implementation in Linux, they can maybe provide some more
>>> input.
>> I have some early-stage patches the enable NVMe-TLS on the host's
>> receive side and on the target's transmit side. It requires
>> some TLS infra work, but the real problem is the userspaece side,
>> as the TLS handshake cannot be in the kernel. Consequently,
>> nvme-tcp must be modified to use sockets provided by userspace,
>> and I suspect that this may be controversial.
> Yes... That part is going to be annoying as hell. It's unnatural
> no matter how we tackle it...

Annoying, but I doubt that it is worth adding the TLS handshake to the kernel to overcome it.

>
> Please do note that there is ongoing update technical proposal on the
> NVMe TWG to update the spec to match TLS v1.3 (not sure if you are a
> member or not).

Yes, I've seen some draft for this, although I'm not a member.
TLS1.3 is supported by KTLS in the same way as TLS1.2, e.g. the
handshake must go through a userspace application, and the data-path
is in the kernel.

>> At the moment,
>> I'm busy with other things, but I expect to post an RFC after
>> I finish with my current project.
> Great! Looking forward to seeing some patches for it!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
