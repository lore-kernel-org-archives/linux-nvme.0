Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02357C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:31:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F7161107
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5F7161107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LoACOU7IU4YUKeMK5VOVmGxC0srZWtHnca82A+N2cMA=; b=aT5PD2wfOpWyg2
	h6yhstqS9BiiLgXNgaDHh1q6XPumPqxjrfcpb6m8pU5rDBHn2y83a9rKlN8EdGOkTajVNR5Z2ody7
	U60bqyKpIQdyZaMUhEgKMitNeRyvwvIuiYnD2p8tLoMd79eP11zubhKM2LEJcmz4AmPWrLq9ts5SC
	ZhivMGY8NiXsZaPdZqpYg4aKRXMWGs0oSkbxiGPe2MtbyWYa13Y02cBzeRHtSQTGgthfbi/0rDlDU
	+fqW6DbxiSCECAk75fm+3PeXFmbMeqndsT8Zh0qgcWTAV1XKk2qxlu3Pa3LcwJV+T/VVaX71CcGVa
	dFVi5KrfbCEIYBXPSk0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2LS-008dJH-Ms; Wed, 22 Sep 2021 13:31:30 +0000
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com
 ([40.107.223.40] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2LQ-008dIy-1L
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejqd65e4u1o9+IFKQygb5HR1BrU8mUWXnpuwJuOjpieAjo5xG7fizJgcEbf6sy3/eZ7YXAKappfETeqGvfSlPCpzesGEDMe7pOr02PCOrVXbiUtZeLHP1Q8/52DCVvcAFBUmvLX92PPRteTmPyswchCXC2cIMVDt4rXYHYhuwbCI3TdX8oXhfkFdis1/+4RJtNWKd4WVclaXbao6ZvUlA/UZOqOrSljj0znoeUBAFd+d7kioWAuEVLf/J/c8c4H7a6Ek1jOQQjsUhuD21YlU/SNbmbM6A17HDYI51aI1RKvH3J+6NYiBRTcJWwlA3jEp3zRgKRf+LDnCJAeli26vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FYrrpbUUMYWndCeka+dNq+2WMcPOBuyrjWv21XF9GZk=;
 b=NFk8WDKNLCHDTNFRJtqNCPzbdwHZhVtbvRCLJy7Zwx+8XDcO7SlmfYLq8plyatbBk0lQ7/wW7WtZ9CkbW+k3KFAO18Dc9AajVHF8CFfSn4058Mh21fsyB+MGC4NqCk+lJLeSAK2PuMi86qAsJdKObUFmYcv5NYMU7XB1Z7eZMAvkDc5pax2DfFxxITteLrWth5rZP93fF2a+gtVatLb/0L/Oad0jL8e0X4p7fDJ829TVzuaf7CQyyoyiSlnjakLDZcpFuqG1Js5NnlOOBaXzjp34ugiULFm+jjyKuVLGZikqsPxdK44V3UdqqpcNzylTqLT+rCucxxAhG92/L9BGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYrrpbUUMYWndCeka+dNq+2WMcPOBuyrjWv21XF9GZk=;
 b=t5X10MMLA42EwRX7mUaIOuUYyVIDCjgjNpZN40BbbPCYvtXZypYFBX3GvB1jMvkZtifezJMKWST9S9nG9B/smRRbzqBIlcNuoIP2iIojnI0LAcgyPkVc73zhVRRQaNMupgoft9Rixc8/43SWPkbt061o1fJzEhdJhK1ut5xRgbCTb6VMfQEE/Qw/MJUwunlSiDyHD1IkKgvkXhvoGCT24u7UL0VMbO13Bs5myC9oA2v6oB6FPCWfeUdiwSyRsflvQ3TbRZLFgo7+wP1cbT9uffGE7g8hytzTckT4U4TEF3wHu8Vu04Ug1nM5F9aMTjKsGXbHWf3oWAkO3bkRjXpqrQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:31:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 13:31:20 +0000
Date: Wed, 22 Sep 2021 10:31:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 chaitanyak@nvidia.com, israelr@nvidia.com, mruijter@primelogic.nl,
 oren@nvidia.com, nitzanc@nvidia.com
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Message-ID: <20210922133119.GQ327412@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
 <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
 <20210922121014.GF327412@nvidia.com>
 <902a6d63-fbf1-532f-c3f9-b74942b00ff0@nvidia.com>
Content-Disposition: inline
In-Reply-To: <902a6d63-fbf1-532f-c3f9-b74942b00ff0@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:208:2be::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 13:31:20 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT2LH-003xqV-76; Wed, 22 Sep 2021 10:31:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e5edbb-a3df-40ba-1a22-08d97dcd4346
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555669BBFC5A598A2AC1FF5FC2A29@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLI+nPd/AzR2Np8nWxTp1Qp1qpGcvsst4f30h5IrzdAdWQIwyPsfcfQdFSS2GbHEoJ09nOJBuJljY7odCPehP6K6ZeX+DanUifq2FfcHLNEsMtULbsFTbi6MuFDkB2jctTeU11eR6si8/fBdCAqwi8JLF1eTeaWVEyOkr5Vc/GFtva8u7wawQ+FiXltWXMoHT7X5lSehUf/ncVvXbcz24SpZ1aDao5AUkD8pZar/BxtF+W23YZwo5BxTqqLfTvotv6v3zW/yx2DgdHISeecM0bTJ61DTJ1rTucdJo4BPVLD+KpHDlFLxW7nVmeNqXCOhyccAAVI7yJtfypCYab6mw/Hs+2oM6qqhNeMTtJaYbwnFE47qXP/Ek4Y2cYbogyZy+jrKW+mK5hZy4AkiKOjRch7cofp00qesfHONVuOGkSYRTqpEVx9IPDpiGW56a7dXHCHyzTb+qC2GlywKpGehKUR+0x0kjyHM0c6jK9oxnc8Ly8kE08xGMj4b517zxoQn8/2TCVlzfvBWwgrDNMpgJe17AwqLFsa8+8177d2keqf6Mb6yAExwMrRyQ1BNMX3vpMgbZesO6xibrhF6JSZ/u2ndE0I+Egqw8mRucQfFsEEtqL9SizbLQ77eZ8ZN0yjZn/WKFqA7RAnoM00MuCLqVtIHyz/S/GZSeZkHJuvayAgYZI9JPXh9dzPE2eWiwobQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(2906002)(33656002)(426003)(9786002)(9746002)(1076003)(26005)(186003)(38100700002)(86362001)(508600001)(66946007)(6862004)(316002)(66476007)(66556008)(37006003)(54906003)(8676002)(83380400001)(8936002)(36756003)(107886003)(53546011)(6636002)(4326008)(5660300002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xednNH78novqYGPKrpCguGZOlL4GfjszV2I+6+rK1nxxuN+ty2UM+RTVJ3q9?=
 =?us-ascii?Q?lEnTi+OWe/zJjCmTHKsgU/9bhtpLsLOLbVIHuAYSwrxgWce3wFbgSrqFCsew?=
 =?us-ascii?Q?4e4f6gvp3UwpQwNZH21D/QHsNjr/v2Ytnrps8V1ujlRoPB7RCh+vfW3gQELK?=
 =?us-ascii?Q?ViPVQECEGVvwS3hJ/5fid5xDKtVdACy3+plGww1uRqRGnnuphoLf3gTCXZVJ?=
 =?us-ascii?Q?3Vs+QKu1hiFmI386Rj/QZDqrbRtnoOtphaNFOuTBySn89MAhDkdRGrHTHhsC?=
 =?us-ascii?Q?aG+Q2k1ajhxJLAZ60k1emg8v7I25KNaNdSNpoeaMXrBak2Lobje1Kvve+yUa?=
 =?us-ascii?Q?2B6gPDdRr9JgTcbHjSH96HLdvD4kO7vmQu+BsrD7VH3ahFhj7pQecSNlklRV?=
 =?us-ascii?Q?GBw1+T5jvfzOBONoQZpbPJYKgrRk7Se+Jd6NNZi/GFya6PdxmWQifzgQ0XVM?=
 =?us-ascii?Q?FBZLbf9Pgn7YgA6xGuAKLsuGLggh34J99kUqzlkwVLWs3x5gcf8Fy8Zrnh0R?=
 =?us-ascii?Q?hkl5D1WUPxZg8QZfE1O+hD39ZvCylDpSubvlD979bJ3gRlOY41mMCkAbhR6+?=
 =?us-ascii?Q?181Xegh6tUFx7lHnN4NSWIsCqlsdSpQxLfGvFDWp2M0MKZs7EiJvjxchypBv?=
 =?us-ascii?Q?mVUYWrGR1U/5xjmQ033mPZ+fPbCmLsqxPeQXuqUuJIEEB7EeyqUrCpq+Nf4b?=
 =?us-ascii?Q?RDder1tgvcQsTFGnCFJd6viyzJc3luSAapASwrO8SEYFPACg1mp12f9agUr+?=
 =?us-ascii?Q?vmcl94/HJl4ULBpC59RFyJyy1S1t+fv1GW2ZmPr+SmIrQKjSs0iq7rYGAECE?=
 =?us-ascii?Q?80GtlmTp1n+eLS6vtMMbtqLbygYe9XvV/evTxFJiKwTZMMgatpIxuZD4iMY3?=
 =?us-ascii?Q?DVpI8yZJ3Q5HkgRmiWjQmd+JIlcm5i3LxD8/eIceBspMOFwZ/dw62fTZeULj?=
 =?us-ascii?Q?oFate0SGkO9d3c+1N7MazSUmUO0P8Lp3+dFGRm81e5O+Kynd6x9qyx/1w/Eq?=
 =?us-ascii?Q?o8+HJE61V0bWkHnA/A5emLE1LNAgR1DikE/pBMcPwNriJ4tLRssAWo0xNJKB?=
 =?us-ascii?Q?DSWEcvyvDVrI6jUdtu368xZ201zW0szOfpfbEQFEOv7OaRfpvr3BcxLiEY8S?=
 =?us-ascii?Q?azcZI9O6Sw4hR/6D/tjuZhZvFoqqG3/SKH+igaieEKUUcY6qqdEi7uED4HKq?=
 =?us-ascii?Q?ZNrSwVgCD2XDd7o7l7Xx2tq8mnxllPzTZU0Dp1fp/Tta+nSv0pp4eLOkqvkn?=
 =?us-ascii?Q?7amc76jjeRHSIwB5ymWuidLo0wRP3RiUHFMBuLmR4ciIo5J2489YWLjVRj8K?=
 =?us-ascii?Q?aAP5MDVb8dHXKZ/T4pxQr5vq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e5edbb-a3df-40ba-1a22-08d97dcd4346
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 13:31:20.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuFlbmWn4zcRkATTryj0sz619gekj8yH1qlNcPkibzEanXGrGELUBTJjJcMvQrDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063128_125713_DB9036DB 
X-CRM114-Status: GOOD (  30.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 22, 2021 at 03:57:17PM +0300, Max Gurtovoy wrote:
> 
> On 9/22/2021 3:10 PM, Jason Gunthorpe wrote:
> > On Wed, Sep 22, 2021 at 12:18:15PM +0300, Sagi Grimberg wrote:
> > 
> > > Can't you do this in rdmw_rw? all of the users of it will need the
> > > exact same value right?
> > No, it depends on what ops the user is going to use.
> > > > is it necessary for this submission or can we live with 128 depth for
> > > > now ? with and without new ib_ API the queue depth will be in these
> > > > sizes.
> > > I am not sure I see the entire complexity. Even if this calc is not
> > > accurate, you are already proposing to hard-code it to 128, so you
> > > can do this to account for the boundaries there.
> > As I understood it the 128 is to match what the initiator hardcodes
> > its limit to - both sides have the same basic problem with allocating
> > the RDMA QP, they just had different hard coded limits. Due to this we
> > know that 128 is OK for all RDMA HW as the initiator has proven it
> > already.
> 
> Not exactly. The initiator 128 is the default value if not set differently
> in the connect command.
> 
> Probably this value can be bigger in initiator since it doesn't perform RDMA
> operation but only sends descriptors to the target.

Well, that means the initiator side needs fixing too. I see this:

			if (token < NVMF_MIN_QUEUE_SIZE ||
			    token > NVMF_MAX_QUEUE_SIZE)
                            ERR
			opts->queue_size = token;

Which is probably still too big for what some HW can do.

Both host and target need to bring in an upper limit of queue_size
from the RDMA layer. A ULP should not pass in a value to
ib_qp_init_attr::max_send_wr that will cause QP creation to fail if
the queue_size is programmable.

Currently there is no way to to get the device limit for QPs using
IB_QP_CREATE_INTEGRITY_EN. We know at least that 128 works on all RDMA
devices.

In any case I still view it as two tasks, fix the various interop
problems by adjusting the current hardwired limits to something that
works on all RDMA HW and computing the actual HW limit, adjusted by
RW, etc.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
