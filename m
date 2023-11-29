Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7146C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9XNqtLvsRJtrzMjiIvC8O9vDwIWDuR/s/9ezsWp9E4=; b=tKjonsRCrZBX2CyFgvWKnOsphX
	1UQqYJz53K1Mv1BVP2Xlea1vX/wnJAf3lGawr+MCXsA+9YJ/GVhwpFAnbQtYhob1PIfhXO2/mT9fU
	bM0Abo0bpMa/3d8MTfIrnKGzlfMpQT79eOiXWdzl0cl8iMveMn2S/P+Pkl9PLYEUQoGiaa/CPu+4z
	1UKhTgPrPhSwtWuUB1H0IOie/jUs46yalsPNKDCBuoUQG9s3abmgtRz3XH1b9z7VabdQqTKB43LEZ
	D3xld1pgw56xMA5HXtz4cdH2IanaKnZaxGvy78Fk8oqgJ8hlDnIVPc0iDpOjTkmh84ksVnCw24mgn
	RVfSU0wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8L3x-008Y52-07;
	Wed, 29 Nov 2023 13:57:13 +0000
Received: from mail-dm6nam12on20625.outbound.protection.outlook.com ([2a01:111:f400:fe59::625] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8L3s-008Y4C-32
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 13:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO+cckbu1jPl6UdQYFxyiz0Exd2mDduSwfNASd6oyBxqclr7WBjfJxDjeW5cAU5l31TJ2S2du/r3f54/ib+R7iwoTaG6iEkw9TTMtbMSkG1fvXZWRk8qB0iZsdJZr2e5timlMlAiuln8OaA8lSGQRvtz6uuWVKp+1L20FfxISSowzBftx+gWPkEHWqTZ8B6+rIJu7diqX9ic6/43gSWTzgIH4KQT6hBCG1UPsBlI6ttU/PQlZtwNpb9jBzTiurJsyU/KeIwAP/CvmX3U6d1/nXfEXRUKnPWHKKCOLjh2clz9ckIUlRwYfmAiYQRboxquy9TvGr/RoLjpwKQ4h4pCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9XNqtLvsRJtrzMjiIvC8O9vDwIWDuR/s/9ezsWp9E4=;
 b=fSbZsitZO2l5tfijUa414Ng1pGCdAeaE7klR3AcwWyNoSrTmmwNjIBBkTuwiT18sIrnEHCzQyHqGNQFNUk3+cU8oxJ06wfyHEdVeWevCyZXWOJqMofBP4mW0ZZTkpZrq5mHIPrhRl4/TzXQjxf16N5u4d8wL7MKuTdtis7on1VHOJXvNjbZPALYfokEIPpZD27WY3Bcp5XVAE5wwyucfhF874lWVPa2ydcpBFYIpHS8F5bQUkgQa0+zvJWK6RNstpTIOsJ5U/j9BsGx3ZvU6y6vMMUn0hcLiur74MQt2+YE5i7Sm1YnHdPlR+9UIid1qmgPq7xbh+AP8cc4mls4wzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9XNqtLvsRJtrzMjiIvC8O9vDwIWDuR/s/9ezsWp9E4=;
 b=SVlD+smdC7rkMHETAh1U3iyVPiaird0+xZ3diICEGkmS829wQAne6QA/1neTgPGLrGy180yL3reruiYSY+1xUFfwEivosJXRgiGnxIlzAkXQBBSalfdxKsKZhAg+RFJzYwvUanGl4l5ThWPzv3qiYe8bnJeU10RU3tPktJX4WkQBJpRt7lhFfBzMlUUSMMEuIpZeMO9OT31QMbrQszFPMXeLqSjYw/o4orkRjb+ygY1K/s08p3vNuWq3JAFC5wUhXZh7LekUnUh7fHybXwP5eTNZBby88g+TRCnz79+KHovVd7RbgyEwPeV1TbWWTIM77Y1w+f4x48r2XT2jHeIp+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 13:56:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 13:56:58 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v20 07/20] nvme-tcp: RX DDGST offload
In-Reply-To: <bc6ec871-de51-477a-b27f-4d516e5bc3e1@grimberg.me>
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-8-aaptel@nvidia.com>
 <bc6ec871-de51-477a-b27f-4d516e5bc3e1@grimberg.me>
Date: Wed, 29 Nov 2023 15:56:54 +0200
Message-ID: <253jzq0irx5.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5da57a-2fdf-43cd-da7f-08dbf0e30e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYKBUnXl6UuVTFwTNg+isLh1Zo7Ge3S5Px3nj3thxmGRLQ0a9nld789Lcfu0lyx5jY6ngNNbFGshKHfQMC5Rz975dYRCqQA1WkQxZcRpgPcYWZo94iLA1UjJs+FZNM5NeAwZEqiY8KM96IDG8NYyTaYGCwFOqi4E1PdMMKmfve1aPEbYiGOoKiMco+GqqP2+RE1TkmhgDEaWrAkzh9ipA4fewTNhdo/eDE09Ag5vTtkG2Th3eqBs91nFzebmekJrLv440FtCMGsppXIzFz14Q+oICSo7CZleHvh8OibV/N58NU9bHHapNgKs/voXy5NmfNe2jAmNkhHTLy8KPQgOLa6P6HF6HIzIEmgRtygE5U5dv7UGUV9VMrqMPCC6zVReCmw6j9UUFgbWHWeH8uMBn4Z6DezpF0ClvWyLeSaocg1nu6YXIDRGA/oOhnoXR+P3kUbFhXxt4/N/wf6OMFySuQPtPaIEBYDidCRxBditWOBoyq5wwl6dz/FaRlFNhpDJgZLlDFO3woReWYehEIqDI2JO2w2eD1tmOiFZERAP15Adqdd4wSTO5mLJxdD0yjWm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(26005)(107886003)(2616005)(66476007)(66946007)(66556008)(7416002)(316002)(2906002)(4326008)(8676002)(8936002)(5660300002)(86362001)(41300700001)(6506007)(6666004)(36756003)(6512007)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eVEfg3m96OzTqgeQubECudGdbhRCfq9x0SZ6GQpP0/oqU+2/XBv/QutVy5G?=
 =?us-ascii?Q?kQ9O9MsItDI7SdTwBcL765RRD8aalVXyYEUQcp0vEAev6fNu0xcpatMZKAmJ?=
 =?us-ascii?Q?qEGusOdFVMcYufdtkiyk8hIrE7F7e3Z2dZyMlzRu2Csmw+2E0oHFi1irvE7n?=
 =?us-ascii?Q?m4Gjlb++2K5ysk26IY3NJujMGmxBZfdTAFleog7lvcnOTzVsXuLFki0fe6M2?=
 =?us-ascii?Q?BRTsbrUKPmFeKulQdIz15OTi76Usn3G0/m2QRj4b+AlA29kqrBODT/s12V1h?=
 =?us-ascii?Q?CGfMDvXFg8wzMNPqPtTmEGSmRqXz2DssklUIUPQVo8rJM9B54EFqh3Qn8u2r?=
 =?us-ascii?Q?SpThChLK457kc2O67WwK8+YDz09W+Erw7qw/vGVE1t/xUGKOaO08V1jI6BNB?=
 =?us-ascii?Q?jZ3VVCFQac6vQYpeQYKAwPLA8uS7Bjw7qNlDfSIrimWfIEnW/fQSAGDVZC/0?=
 =?us-ascii?Q?0RIuLoUxHyHwzyOa89qiEkKMAsPsfZaZoqdUpuSwuFE2r9e1gX9f/KekXwyr?=
 =?us-ascii?Q?ZtyKzi7IXxokSioL1JuP88fCr0B4n/MeW2LLgpzkwjSFcQ4uiyX8QrFgzkag?=
 =?us-ascii?Q?eUFKimRLsBdQx8wzMTrcMkWuyU7Tl8eXsZNkPWvrYyt3Mv8AwMJLNQLw/y7M?=
 =?us-ascii?Q?H2mEiTfYPPdOYEBl2+cUPxZmQuvsNV7ILAgzYLX63EaqkMbRgGfgaSzAhGMT?=
 =?us-ascii?Q?SLycdaSKXk2Yxd0/zu9ENFC4McsDGdIJX9AgNcCIK33KQJCfEsVBNqXQtiBH?=
 =?us-ascii?Q?ITa2Ew3Yp3kyW/1MzvHn9l4KIq6n14yHOHG8PmgQUdasWw7OVSmZWGlj91fe?=
 =?us-ascii?Q?TBtEOYKDRpbqlRHnKttkZjLzTqMtifuOipg5Gc12WmDpq/U4HJgbCfPPg8mg?=
 =?us-ascii?Q?T84rD1D2g2mo8x/vhEb1qCNKAbD02f4q6AQGAbxDiRr+FKFCKfLuo3d6d83J?=
 =?us-ascii?Q?eTDiWvNmulNc0SVxA6p7gxAH8z+J0wQQuanxmK/RqT7bNW/zTNvMMuOmPSr0?=
 =?us-ascii?Q?1bMRQin3EFL7O4ykZ14pHXJL2o/E5F2W+2NLtGRWenoYEEkYhQ1iFRHm0j7Q?=
 =?us-ascii?Q?OXwBhN13Ms5u66N83b0PEWiVucUt1QHh+BPt5BeP61jQxaClPgvKBVHuLwFe?=
 =?us-ascii?Q?1VCpKjcifLOndUfZ+rdbGwk64w5saXdldvGA9VHsfoaQKOl7+NlM2uJ9dxYd?=
 =?us-ascii?Q?d6pLXS2Qvu4hm+yl77QOIzYsSzn0LiiSCV88II/LJuGNPC6Y9nBzAnY3ukxW?=
 =?us-ascii?Q?HcW50deOOdLMa3FTtB39R3e0rqi4wKBR3lI3U5QTJoIP5bFXpVnUqX0h/hwr?=
 =?us-ascii?Q?ZiU6TfqbkFZ7afWUt84+/ybeR13xnVL+QT06E1LkcjSMpd/WLyOhK7RhQvOL?=
 =?us-ascii?Q?1/DwA0i28gZgn/jtXBDQxJ67CIGD6DcxZ2VZEAMxPXRP7OuXihr6Gr5WqcWa?=
 =?us-ascii?Q?m5+M1KvNp+JVV3wVEabuBg/NaEJ8Kigqm2wuq+RtIoNDuO6hLqauiBwFbz5C?=
 =?us-ascii?Q?MLnEnsO5WnYeJvu/+w7FHq3VkNF0ZpUGZyX+Z+QsHK94ThmPfKnPmEDDPDtJ?=
 =?us-ascii?Q?HsV/5DYT2iMw4A3rLE3XF8EvjKFjreCeO9j7W6VD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5da57a-2fdf-43cd-da7f-08dbf0e30e01
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:56:58.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMAw0VWpdfDnKlQ5jZpyazRvNINh2586kOEvh0I++z0KiVWigLcohbDXrwQOgm3zLfrx5t3fQRmMZTtM7R5kRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_055708_986565_E4A7E874 
X-CRM114-Status: UNSURE (   9.87  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
>> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
>> +                                   struct request *rq,
>> +                                   __le32 *ddgst)
>> +{
>> +     struct nvme_tcp_request *req;
>> +
>> +     if (!rq)
>> +             return;
>
> How is this even possible? And what happens down the road if this is
> indeed a null rq?

You are correct, this isn't possible. We can see the req is fetched
earlier in nvme_tcp_recv_pdu() so it must exist.
We will remove it.

>> +
>> +     req = blk_mq_rq_to_pdu(rq);
>> +     ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
>> +                             req->data_len);
>> +     crypto_ahash_digest(hash);
>> +}
>> +
>>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>> @@ -430,6 +459,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
>>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>>   {
>>       struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
>> +     bool offload_ddgst_rx = ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
>> +                                                   ULP_DDP_CAP_NVME_TCP_DDGST_RX);
>
> Not sure a local variable is needed here.

Ok we will remove it.

Thanks

