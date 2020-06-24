Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3590CC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DDF20656
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXhxdKrr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RRllu3ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DDF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ojIF3d9zkerKmnihscsfD/KhZh1pps+ULXwcB3O1rys=; b=dXhxdKrrXLxMwxmdeUcWTnl81
	BCwjpWaKE8+hPht9eNbPmHAcNnUGq/vn8T50q1BNixy7KuMk1Idxj7K5zSBxEfFJSBYGZyRgMtF6B
	xQagWsY0NYJUlytf7dQMJcH0e8Om5XnTRY6JBoGXO4oGWb450121XFtxD21a7e0stYHmELxRJ1+kT
	yq6z5Q5yTHSRYWuFTOQW+2EWlLo1XP3/+ZQ7/II3o124pCEJsLq1fmbU3ArE97NOAlcZCJTFHcieY
	RfNaB3I49TgUrwAGtl8qx4UscFAlBKOfsa75GJAGhnWZ6U28A9j/7tbA+kq2BM5a0TrC3fkRGwfxJ
	efFWr6YlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo76V-0000Of-V5; Wed, 24 Jun 2020 15:14:24 +0000
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo76O-0000JO-FP
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 15:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtNaWcWxqCHZAneyQ2moHDgSTqS5GoZ0hSKpJoIusd/EHtTP7nBn/5YfeaKkasQLLrCBT9mzvcQ9AiLhiTsrtUwgdxCfuqbHNSOIU3IVsUZ0zxFqRRpKQDDLFUkYpz5OmJkGavo7VqcOOmKJEZBF+rr+jcZBpDRlEHUVcO5gbEx1YcGoTxeJVRQVaWPecSVYg+0QKTs2nh6miwHYyiTKi0Xk3I/+7ZS8NQH1vjZI6uZbiDpKdN23Bohh/3Zbmebc05EQ1dEtNxBSIePNhMnHRzNUAnilFFT9X94pEd6CQ7Pbc9sUqw9wx13PGxGVKGRJbHlX4T1VV6YwOqkfuzJnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz61XRVnHYVBLmPE3dZHtzM6knHU8MpNI/p8+MWLRrk=;
 b=U+us8Ac11+CewpNqsfpxnhzw/1Jrk4EWm7H/vUt12KMn94JOcJfOP5bRdde6+kXH3rEEKQPmEIVvlIGE+1kb4n++1noVy3f3ee33IauPV0eprokYolpx9Nq14IeQeh6reNvZGvHTVZXGDJUKBk6C1Mk3he4z7NZl/+0boCDbPQthffZUv2OQcoT3SJ3mtmrM1Uvuj5G4X1TTgl9D7RhbbRkpTkRxUtELv7XAeWm1NzrH2+BJQjzuTMR5wVj9vVhzwRX9b5QAwLTdzY4yEsY3radB4eg8TlEKTacsPIATWxQjaWvTTjqU2m5OM/fvwhksQZEFIrJkf5tf+ym+GkXGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz61XRVnHYVBLmPE3dZHtzM6knHU8MpNI/p8+MWLRrk=;
 b=RRllu3eplwkKxNlbrNPK2kiDyWHynuj3PAJ4Ud4z61+bK6JJ18l3N8B+PABqJ53sLLeEPT4apszZ7U7eIDjrtEwxiE7ii52oGC+Yw/OXITHaRaCRzKqP8MxabWSIt+WhYBxqAgp+Pvw563Whk5O3Jbx9Liw6He/xoYCOxUbTxXo=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4916.eurprd05.prod.outlook.com (2603:10a6:208:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 15:14:12 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 15:14:12 +0000
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
To: Jason Gunthorpe <jgg@mellanox.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
 <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
 <ec6b1a89-0cc0-1378-6d29-29b9d255c7f5@mellanox.com>
 <20200624083743.GA23529@lst.de>
 <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
 <20200624142255.GR2874652@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bb7c9c1a-e439-7298-2cb3-f91838b201f3@mellanox.com>
Date: Wed, 24 Jun 2020 18:14:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624142255.GR2874652@mellanox.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0090.eurprd07.prod.outlook.com
 (2603:10a6:207:6::24) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM3PR07CA0090.eurprd07.prod.outlook.com (2603:10a6:207:6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.12 via Frontend Transport; Wed, 24 Jun 2020 15:14:11 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7b8b496-07a2-4b4f-21c4-08d81851406d
X-MS-TrafficTypeDiagnostic: AM0PR05MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4916F1D1BD7106394AA8F9B5B6950@AM0PR05MB4916.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCLM+S9/bPMzTnxPgt3rOm8Py7sAspOSkTNsBPm+RCzGuEnBHtwS4h1Pj1xng4YSzOMkhNaxsuelfqSUF7Ewxr72wf42AZUEZzOM2TMgM9n803xrSYY5Mf3GMkyVSFcKJyBYJ/n7sHeyiBB6POia874oOGaHVKGQ7a8ItpDmzne2W7RuYE6+QROzWF12hA1rirwlWKJZxU9606bUudSAvzdulQHW0/7TmfJqcTZBrbTo3x6H1U7PcH9VjDKeA8yER4gPCNF/VJYk+UtCo1TrHD+6BXHZTsvMbmXZnG3+FcP5DIcmakMB0StTgiLi1Rt5sXzHVL15f0WF7dwqXTT2NR3I1W9bWBJLJz+RJFbDDWdrZJgdt0xD74ns+UDJTbVu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(36756003)(66556008)(66476007)(4326008)(53546011)(66946007)(6486002)(54906003)(5660300002)(6862004)(26005)(16576012)(31696002)(316002)(31686004)(107886003)(37006003)(16526019)(6636002)(186003)(86362001)(478600001)(83380400001)(8936002)(2906002)(2616005)(956004)(6666004)(8676002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: esgBsMXyQHesqExQtWMOG3rKFLZpH9qiDHoIh8lt9XkwgMFnBNNWSoCmeEg/bgZ465dEWC0OAvVvavT7oYcbURgGSKqtHGtoy3hTcia9iDx5aBEvyc1KN4HCf6TislZzO1H9J9MBLhNjXprsf/ZPpIwGJvj+P/PNk/68JmlibTPiq7IsM6w4PK9UoY59/OBlBLFLCJoGvLEXjmRRRft2TFyh59Qc4/8J7InMoHc1qz78si0ALyte8tIOxrJGFz2goIpL5ls/GnDmD8PdhD1R54t77ZuW7EAInJaBtvSaAwwUSZBMLcwQuJwf+Utz2jMb8wYy3vTBZeLDGe5gw062NWv1xIQCwo/VTSm55gj1XJTdeLbXxasxaNVrbRHPJHgWCFL2bBqd66umvoj4jrq+xYiRDZ0T/jpRDtIavBp1EsUdcc/+m7ZxoW636T3S42NbnU2iAnRxzoiNv8Dw/Ji0OGT473B3E6tzFo4mQAQC9Cid/Gu0cV3XgED3ITG2TSLQ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b8b496-07a2-4b4f-21c4-08d81851406d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 15:14:12.7255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJLGPFD8CY2vwym5lIof0EaSGcpdbUrA/pADgHelObmCQJvNch+CiSZSWswQsIOglKz9IYZ5HEmP1kuv9+SLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4916
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
Cc: yaminf@mellanox.com, Sagi Grimberg <sagi@grimberg.me>, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 kbusch@kernel.org, ogerlitz@mellanox.com, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/24/2020 5:22 PM, Jason Gunthorpe wrote:
> On Wed, Jun 24, 2020 at 11:44:06AM +0300, Max Gurtovoy wrote:
>> On 6/24/2020 11:37 AM, Christoph Hellwig wrote:
>>> On Wed, Jun 24, 2020 at 11:34:22AM +0300, Max Gurtovoy wrote:
>>>> On 6/23/2020 8:34 PM, Sagi Grimberg wrote:
>>>>>>> The completion vector index that is given during CQ creation can't
>>>>>>> exceed the number of support vectors by the underlying RDMA device. This
>>>>>>> violation currently can accure, for example, in case one will try to
>>>>>>> connect with N regular read/write queues and M poll queues and the sum
>>>>>>> of N + M > num_supported_vectors. This will lead to failure in establish
>>>>>>> a connection to remote target. Instead, in that case, share a completion
>>>>>>> vector between queues.
>>>>>> That sounds like a RC patch? Where is the fixes line? Why is it in
>>>>>> this series?
>>>>> Agree, this should be sent as a separate patch.
>>>> The reason I sent it in 1 series is to avoid conflicts. Since all the
>>>> patches can go to nvme-5.8, I tried to make life easier.
>>>>
>>>> We can do it separately of course.
>>>>
>>>> Christoph,
>>>>
>>>> would you like to merge patches 1+2 from this series or should I send them
>>>> again as well ?
>>> I don't think 1+2 are 5.8 material, so please just resend 3 standalone
>>> for now, and then resend 1+2 once I've merged it and rebased nvme-5.9
>>> on top of nvme-5.8.
>> Ok. Actually 1+2 were aimed to be merged to 5.8 but created a conflict
>> between Jason's and Jens's trees.
>>
>> If we go this way it means we can't push new features to RDMA and use it in
>> NVMf in the same cycle.
>>
>> Jason,
>>
>> can we push iSER CQ sharing to kernel-5.8 ?
> I don't think so..
>
> Where are these patches anyhow? I don't see any iser stuff in rdma
> patchworks?

These patches were developed by Yamin and reviewed by me internally 
after the merge window of 5.8.

>
> If you need a branch for something you should plan it out now.. I can
> help organize the branch process for you, but you have to plan it
> out :)

I don't think it's necessary for now.

I'll just send iSER patches for review and you can fetch them to 
for-next (5.9 merge window).


>
> Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
