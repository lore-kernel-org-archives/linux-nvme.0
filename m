Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA0FC001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnFkGMg8sqMtyaIp0YtzsYfNLef7b9C0chZTYX4gsI0=; b=iyncyKo+zdybv1INeqspV4o7SM
	PjF7dmtgYn5glTsz34Y2KmonLe05umk1nzZLci6q0JNMzg5gt/JDVQpVcM94IlFE7+MhgoyWFmZjX
	lExxvKust/sbd4tHzanDwt3+2nsJJLZyZzYpClXw0xJhI3591kFhkUvojs67W5bC7FhIEj3o5LnmV
	vEbMY0q9KHJq+DU/HciISVluxgDEIMHVk84aJj+JRn/S64qMgFSBT1obbmBz5i+hsToz2/HJ0PVAy
	uHuvH9qppBZNx61P3N/rMUGeqjz4GUmz48MrplKlO22prfq2t275JTQ6wlTmP+rQ9KyKGB3BoyjhS
	eINA39bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVaBh-00HWzu-1F;
	Mon, 14 Aug 2023 16:13:01 +0000
Received: from mail-dm3nam02on20610.outbound.protection.outlook.com ([2a01:111:f400:7e83::610] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVaBf-00HWyx-1D
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 16:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnkaPdcDHCY+VvV+je7VNC2QtZ9t2VJfFWYVqW8pEYWeSsTTDp9lALYZn9cvHBcqkoIIGNBdX5KPzrv6paV6NgEhpDFzfxmZDTmnHsvf7VXF7fG/NV+tsHpkD4ANgUkYjMHr11If6wn3nVT1bRAYKd4c98EBFHcOwdrlMYj25WAD+n6pAeuhY7FCzKwrw+5X2vOa5cPuCUrBR20/n/U6bKc1Is6XaruifX/jrsYP7iYPBVk6iABGU3YVqyjrGFtlCcDcFlX8BlTMfahgM3hsm17a3XI36wrDejXE6wAaYqJMc2BlnDdP5+mahlAhyTaRko4uRxxBCZJqugojWKBgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnFkGMg8sqMtyaIp0YtzsYfNLef7b9C0chZTYX4gsI0=;
 b=LZl3W4A9+zmOqBmEBpQhYMRZo64d3gSXCFleiwttWGdT+OGCoBRIcUNtasIi+2Zk8acBjCjv++YI4FEENqs9Rxyi2S7lichk8pwRSpSm879RVBOIKMmD1FAXgMOhPyQHChWTjLxynuEXFQLCgFzMZNv6D+2EzeZ5A6/BlDc9tk3MttbikDKmngs2jj6mp6NgCqWQnXhwOzWilK2EfYimTJPoIDeZUNFRbrNzKq+ye4u0bkzhx+9mYoehjLgC+J7JUEPVVIfW/XNnR9d3Sc/LrJNklKqKKgFk0rs08ozRRHwkiyumYOYqRYXNeQLQvk2CO+iRh3eS7zEGZjuJT0hg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnFkGMg8sqMtyaIp0YtzsYfNLef7b9C0chZTYX4gsI0=;
 b=UkiSvXzkKVghH8h4QHVc+9xE2h2Bvfy+JPsFPtlULwNgTqDQ+xsXEUzw9E/KgpKE3rp6EBXnlzI1qB7ssy2nPmdq+QXTe4G4iPVy4O4uB0yUTugjOrTCNivi9KTU6lUNdQotcuomL5eLh4Qkizwun97Vl/jhx9+XEWOtG+X0uOpOu6/DGhGB6L82kc8tzmopswRK1Up3vugvV7Gl8OC0YuFwPKJG/mvvR70vSslkS9hrf5ihT/twzxIwlgoACe0ZmhjYdE6xC9XZKwyOf6JN3tI9GvqA7AtS6zUEl3XtW2U0FyrqqA91DD7aD7jmYdQw9XiVaNiipT1yw11gu6/cmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 16:12:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:12:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
In-Reply-To: <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-9-aaptel@nvidia.com>
 <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
Date: Mon, 14 Aug 2023 19:12:47 +0300
Message-ID: <2535y5hwqkg.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 678eded8-7f75-496b-d14a-08db9ce14ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVhKwn1Vjga0RXWqIgAZfExIfXZ7nI5cbKYWj2eKHd+ZtpPEVW1uPS9R6fsd61ryCvoDenqn5Gr/Il3fuHCVyO9i+Sm+vbr11ay/xepkckLROxktUAbqojTB8HSMIgAxnoxSXvr7vtQuhp7FEE6k+m9p+wBo8Tx0rUOtb0a5B0JsNWja3y5EbZYaOz69ZK+3f4yseYoRpZDJQOk64318Z0+J6ksV2IpLQKFxC9Kx2fBxLdCr3cru07GSvH1rocPyRo67YXf969NSFfC7o+I9y/1g340qJ2sYgBCdz1/hZzlBrUwshf8uNkm0cJBgdmPCObJrdt1bq9pM8iRYtubeyIDvfoi/CZGnCf9W9FF5JFqZaCNUA5QrISXhkWmvrf/8MUuKcoCwl5fAoI0i5nZsO0pYjz6nAh7m8p15lU2czEVpZHk+uDxETCIHofkWH89iSdxFfJq4AjXMItDNHrHk+tahwnmrZp0fDK18slxPdxU1SKFG4uEXnD4vSEPEPHYzxq8OaDui83x9ARvM6bQivZLZypu2rwMHK0m0E92bCA9t879s6Jj9sxcfGqg7til/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(1800799006)(186006)(451199021)(6666004)(6506007)(6486002)(6512007)(53546011)(478600001)(2616005)(107886003)(83380400001)(26005)(2906002)(7416002)(41300700001)(66556008)(316002)(66946007)(66476007)(5660300002)(8676002)(8936002)(4326008)(38100700002)(36756003)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FB0WEZZ36lZchrx8Viia8jt8Zdsdjj7bWdx1xbI2aiGo5hGAHt1DJwDbz3J?=
 =?us-ascii?Q?xav+iTt0WUvNb5X4oDWGm/fBoa3b93lzBuIUEhXLVjaq6B9vFlbLpwIfNX3U?=
 =?us-ascii?Q?bVpPY+svXOJqu85lG9WqiHhmTaHR+w9T+tVp6w0xMHQ/MDTuzUdZisOEIMYf?=
 =?us-ascii?Q?N8wAfnUAaARGXgq1gYZzL22gWLykm5j5jOjw/OtzdlHjTp4ybXm8xR4uOP5j?=
 =?us-ascii?Q?zmnltfrQheVXctEPlWHvhhehmc/xBBKs31kAZBsbd47fxoo/It4GvfmPlFOj?=
 =?us-ascii?Q?bcK4A39k8yt9gLGOhtNJVRzKFwPTs/+qn7jX09fX7D4D5ur3MqJJo4pPAVKD?=
 =?us-ascii?Q?yFlNbMJHPC3qCdNJ1eBtSuMSITHoQirGuiezA/upBqeXv08Vr2j7LP9Jcce/?=
 =?us-ascii?Q?5n7Fj2pHda8sCuyfFCADEpP1axCB3DCDvGkIIgq4Zt6rhcXMUoiz2mPkkz3r?=
 =?us-ascii?Q?G9Y7pODg/0WI4yno3MIODHYUw5Nd/g9uYlctlQv1gSKBjBhAzq75IL2A7uYZ?=
 =?us-ascii?Q?Y9CnwrztSZUWqHuZpstHc42Ub12bYEpqMMPpYV5ImJ5xaTWBdlIQLTuKyZh8?=
 =?us-ascii?Q?Pc3cgdSGWoOPyjXELvAGNYLWZUiQMQmVK3PiOTFbmCSVVr1AHyXivFNxA+cY?=
 =?us-ascii?Q?MR6K3k2tBLgBMwTnXQNJLwBAzmHZq7x+EdbSlAWLfmjdyie9ib18PpksF8UB?=
 =?us-ascii?Q?lroIDC7stmuQ4M21Otd/uhLwnKwmN0X39X5cvr10vXT6wEKcvYbSc8TwpV7q?=
 =?us-ascii?Q?Qiqlie1o56VlCxW7zkdVBUO5CMVQ1nq7S1byVOz4u6oNFiMFEUpL53J1aTUw?=
 =?us-ascii?Q?uX97UglM7zIOaYlwBPkd59ANRQLrS+emxlXRmioF2MQ78GrSEh6lK7sl1Eib?=
 =?us-ascii?Q?5qzKLw3c9P+Zctor9mJRGSHGHilC7w4HkfBZINg2qroGw/GVIp6j/Y7rKiL5?=
 =?us-ascii?Q?ktL9IuGpk6FzPdILyvb3KwLTA1J/8URff9OBek4/RaK3tbtBWPXoGoNR+KiF?=
 =?us-ascii?Q?hFlFlzXDNoJHMGn9NdxIpcssHrikA3wFbMNiaPK5eiXxX+lcrokYFP7KWBsW?=
 =?us-ascii?Q?mk8bRYcyrYAG7MJZjaX7hxEfnznAVaOQKcVqRpo9J3VnN4fNn7xvlh66u77v?=
 =?us-ascii?Q?a1STdE+NHGwPsnP2SG4gO3u6Iz0KEZtw9JomsJ465sU/9xQHg3dYfV44sjnH?=
 =?us-ascii?Q?okV6eSTSeiUDPSvA3RL0k/OnK0tcEOMXmopVyykDEEyHYPOy5SMY46bBL2ZV?=
 =?us-ascii?Q?WsLNA952AzycyR3uuhVOu7tvd4V4RR25OuEEJbGqCPbhUiZzEEy8U5mxievP?=
 =?us-ascii?Q?xkVd0J0FZ7ZVNAV7FPPVYb+Vx4z5ZJnwkBZpgljyf9ne/w3+7if7VSInC5sM?=
 =?us-ascii?Q?inid/5dYxA2GWZypMhrGBP/K+B7cwMd0gLYyPsaos/DUjUL9KWac4oFLU9gM?=
 =?us-ascii?Q?mAtxBHQ413o3CYew3SIN9AL7UarOTS/COhda3GxgIgfaO/zm7O9Pd1gaj7pm?=
 =?us-ascii?Q?Zj91X3rNEZzEt2271FHzU/7igLdRKj/uAZa7VrfsUugesY+CPOysSF22HMer?=
 =?us-ascii?Q?xNkJ+BWfFZjvX8TgMgdY02hG1n9+86575dJWvSyQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678eded8-7f75-496b-d14a-08db9ce14ff2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:12:52.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NYqVZxP+MLtHj4Hy9CNe6hayn9qBjmich3QolhPPRMsbSo2T6Cj1tBdUp4z9+qyLGfCcTlIh/P2TDf7Wi8/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_091259_419449_4ECE08A8 
X-CRM114-Status: GOOD (  13.53  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
> On 7/12/23 19:14, Aurelien Aptel wrote:
>> +static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)
>
> Why do you pass both req and rq? You can derive each from the other.

Thanks, we will remove the redundant parameter.

>> +{
>> +     int ret;
>> +
>> +     req->ddp.sg_table.sgl = req->ddp.first_sgl;
>> +     ret = sg_alloc_table_chained(&req->ddp.sg_table,
>> +                                  blk_rq_nr_phys_segments(rq),
>> +                                  req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
>> +     if (ret)
>> +             return -ENOMEM;
>> +     req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
>
> General question, I'm assuming that the hca knows how to deal with
> a controller that sends c2hdata in parts?

Yes, the hardware supports the offloading of multiple c2hdata PDUs per IO.

>> +static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
>> +                           struct request *rq)
>
> I think you can use nvme_cid(rq) instead of passing the command_id.

Thanks, we will use it.

>> +{
>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>> +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +     int ret;
>> +
>> +     if (rq_data_dir(rq) != READ ||
>> +         queue->ctrl->offload_io_threshold > blk_rq_payload_bytes(rq))
>> +             return 0;
>> +
>> +     req->ddp.command_id = command_id;
>> +     ret = nvme_tcp_req_map_ddp_sg(req, rq);
>
> Don't see why map_ddp_sg is not open-coded here, its the only call-site,
> and its pretty much does exactly what its called.

Sure, we will open code it.

>> @@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>       else
>>               msg.msg_flags |= MSG_EOR;
>>
>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
>> +             ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
>> +                                      blk_mq_rq_from_pdu(req));
>> +             WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
>> +                       nvme_tcp_queue_id(queue),
>> +                       pdu->cmd.common.command_id,
>> +                       ret);
>> +     }
>
> Any reason why this is done here when sending the command pdu and not
> in setup time?

We wish to interact with the HW from the same CPU per queue, hence we
are calling setup_ddp() after queue->io_cpu == raw_smp_processor_id()
was checked in nvme_tcp_queue_request().

