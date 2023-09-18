Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50275C46CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Sep 2023 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnA4TTXfxnIXAex9Sf4c6d0K7c7fF7QcjexyD43qLOE=; b=w1iptOlENtkhS6LUdXoCpgukyH
	PHVqhtbb2jFRcHYdiTRfwof5G89LLpvue0YJ7sgQoP4ZiA9WZipSAgu5cIq3EKntLRstqx4aXBvJE
	382DWo0obDHJZrNlc/MrmB/4N78AJ0dhdlO1/2SJ96OM0t6RGqK6QqQBxk8Q2Pyym6Fkh6MQ1IkHF
	SGtenmIUNBr5HyfVKIYYMh3TN9VMpt3XdwfpGNmDlAbjoKuXgmJP8UuPlofjWzSV9StbO5v9esMp3
	wVu/9Wr/Yu3o/itF9ibQVmbJvgLlEK83c+m5Li79mjyNE/kpH9CBoSsJZRpPf28VGnz66YIxHnUX7
	sIxSSodQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiJ1N-00G5Ou-1G;
	Mon, 18 Sep 2023 18:30:57 +0000
Received: from mail-bn8nam12on20625.outbound.protection.outlook.com ([2a01:111:f400:fe5b::625] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiJ1K-00G5NJ-0N
	for linux-nvme@lists.infradead.org;
	Mon, 18 Sep 2023 18:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmwa8uJEX8p5u6dV4kVEy/g5pnlErV/ObtfzWOnyzvdMGYbnsbfj+oUhdngYgQFxirdZe8yzwhiUUW2V+OW81pUHiRTJO6H/Z/9O0ydLNaH/boxuGNb0CyCP+ELkCf876DJsZJoG/v6LRmKUJDQRb05Y9TPsnjFtk72Xvm2nPdEM1ZQEojXb8VksBBxBL+BSTv16fN5EyCtmhkO50EG7nI5H0f7QcC+FyhEEZGfxYPLJDS9tby+pgAsfUfAUu7EJte0rklpnx/fEJHEvk0sWAT6gzkzsKroJKb5i4s+Ym/uJJPAzkboKagkzgpdoLcAGYGYZln/wNlGRrb4l2VGP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnA4TTXfxnIXAex9Sf4c6d0K7c7fF7QcjexyD43qLOE=;
 b=cEPyCZOyUiIxyPeLr7p0oVFfrbvXmWcptIcpNJDo6RUokZPxj5Q5iuRDbQVvwVpHs2SOuEPtN3ke7V7joVEenzI+2UL0/Ymb0ij/Y5Rtuq5rgAIHNEQltG4+FYf+NSh8VOnMpX27cOb29sNUS3gS6oSvCxNZZAg5t4SiyfI0aIFSA3F+x+0d3ofvmZEGFz1OLcDiwcYxkaG7oSlab/Yl51+bA1tUu5JsrLcSqSzryPeLs+DMxdCNvyUFUB3D1XskyXPeDO9uwR6e2NV13uMHlk29qiHiPcpLFViJW/7Sfsscp3ocQQ1Oq/Uh8h138bthSVebYTKlqBHO/qXDLSopeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnA4TTXfxnIXAex9Sf4c6d0K7c7fF7QcjexyD43qLOE=;
 b=pz+bTp6aQABV2iJs6NstWNDZGuvr1OVdiepoXetv2HSjIFX0iDLw00TYLlmURF6izlHc5IgnZC9odDb3fMC+opn5mbkH+CO6i4nOu8Q3rhvPvtl2pOGFJNCwFnz7egianBiuDgNYuUwyOTauLvTJhlbSRL0s0AW1TFk0e8JvUL7xZksAx/JB6VCjUyhEpZezw+uT+t1y1HtB7wwkwhGhxxRh7NqZjf2NN1yJ8lrTbKZ1y06GQtoCvg5NfY8gqStlXJzbeZvTCRWsY3l53eNXF4cYDPjcx4x/fIH4laGnv7lzkvuch0zk7PfvcJiPM5dent7Ye5FGM0Vs7pB1UaEdxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 18:30:37 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 18:30:36 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
 <d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me>
Date: Mon, 18 Sep 2023 21:30:30 +0300
Message-ID: <2531qevgwqh.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 71276211-e7c0-4df8-ad3f-08dbb87559d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7btd4fcAKjsDCSC8MuD2yVX/Nqt45ODO37AjSSAEWkfna6Zk3PSoZa3MAdWO6GiLmN8oD+kg9EU/lz2x5PgQiR3NZfJn1JBI0Tixd1HHD4kXhGJKzo0BS7LQ+Skzmt05/kQCPBoLDaeefy5kVW2PozK1WAoW9BNM/UEqqHffVkxhwPpyRRfu+0VQbsDqZKMMRPjtACEE8M3Ln6A/HEZ2Y0v+ME5MKv2WiKd5QnR8a2wwzJh+9r4a2qMDKhmDtRx8psZZK8uhybGM+MyykUwNnjDNYtECDGeEr4F5bzxvxZ5Y1Kme1qgbAbQtPCr9LXVHLBtAH86zkDjhr5z2iMgLTufdMXxqlHGoOps1vcCnY4VH3bZpburvU/7fl1QwL+1Wcfofjk48tGNxDCT3++NMcJ9e/jSpA+3/DZhIhxZAkJH7l/eNOtgMTd1uaC0mzeMBmhL6CGSpS8EuRceUgQKBfXKS9B3INSSyjlNmptimAc2QARYd4RQc+F4wMUHinJzMmLy36pwCxFxTcDtCOQ+Xnl/llLxFZ20MQjgWK5puGPAXRX3MBZZJz1thSIUwvOT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(6486002)(6506007)(86362001)(6512007)(316002)(66946007)(66556008)(41300700001)(66476007)(38100700002)(5660300002)(6666004)(478600001)(2616005)(8936002)(26005)(2906002)(4744005)(36756003)(107886003)(8676002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ejNyloq1nVE+6cQzEehmT5i0S4tRee6EtwCy+jMsH5p18zmpzSJXW33TFHbl?=
 =?us-ascii?Q?ho1INnqEcWQwUNvGYWpAqTTVLcASq0HWGifWuti43nw8iE9WUzDWIivLpUug?=
 =?us-ascii?Q?VCYCms6KfH0JrE74pvUQgYS9J/la0j9Lkbyhb6qgNGaIav6qQYuQVOkl/Oa1?=
 =?us-ascii?Q?6vG1K1c2P/dLU+JwmuROBF3atIKxg6kg8qz7JG0VFmUK3NbgJWiKYmUzdHqv?=
 =?us-ascii?Q?8ADFE77iKPZjfmGN8/UUvzLgLm2dH4KO6MOG1SDqm5yRz1ol39NF9mhFgv+t?=
 =?us-ascii?Q?5M40Qm2Kwbob8apnsx1/+hwrT8a+i6qJ+pAQP/XOYqg6yEe6CCo9Ok0I3XNM?=
 =?us-ascii?Q?xl4XPli8BEyHdh2ykVvM0qo/eup72p/jWr9vumGPDVB4D2jCf0HADNkQu3vO?=
 =?us-ascii?Q?BD6FzJsvo0M+swTeVCo6MSx5O6Uko6Azxtk+0RwbUpwbHtEe7IIr1zxzb237?=
 =?us-ascii?Q?j/9z5yYxR1MmclASnjjh59lbs11emy7AlMrZQ0SlhjrlApcaAhk0w+TThlbd?=
 =?us-ascii?Q?ssfGacXTT26DAzxIvaWhA3KEJmO99wqWnaGCM1Amd5F5pD9SGI1RG/19e4Ta?=
 =?us-ascii?Q?nfQgRNbdfKBqBoXD47YH634HFMc6VMgQD6CejbsUV4tWQdkaWVeP444no5oi?=
 =?us-ascii?Q?G5NXAn5XW9G05emONAtDovL4xifXFb+QaWeZwwVtmFgh90PhXt33VHIfyt8A?=
 =?us-ascii?Q?eNATzrULwnQaJZ56N8hzyRj/xBym6nFjJ31T6XVV9S5cgrjEPi58vz4/qHvo?=
 =?us-ascii?Q?NqAZaZzRsHQGiC7kJfD/MefDX/oTcObjHVUztLP1zVxK8CsU4DH03HBA1QwU?=
 =?us-ascii?Q?OdkEGMoujQXyvdHM7h7E4Snwad291HZoowDt/8RiIlygnh+XrTE+wK2IgvsY?=
 =?us-ascii?Q?RZmiUIIuTXCBNHmypO7rGqPg+tclUqchbBen2QhcfTqlt7J8vBuc+4EPqP3v?=
 =?us-ascii?Q?0zAeB2wcQ+xuuaJM/xBKnHEmT4FYMH6q66o0/7MretBByuvQ7iYaBS8CywKO?=
 =?us-ascii?Q?tvSP/VSK6VhroLMeSgWDlh3KckSWlgT+PvkDxkGje4a2hUZHY17zeDN5cIR/?=
 =?us-ascii?Q?hB+IlAPfGtOoUQ9iXTqVU1VbIpSVmWwDL1HVSwHS03IrHfPHimYi1WMObTcC?=
 =?us-ascii?Q?TWiIlWyqPrOf+4SHiAdDrLWBJOKUPcFynTI31hO0JdyEIbjUL7ZGPKQ7vl3b?=
 =?us-ascii?Q?HQMqBfFjt6qzg+G0hutHe4qqLq40scV0Q5H191+8xUK8/crY3kC80hoUsXe5?=
 =?us-ascii?Q?eP3zpPXtukhd/3dsNuguJFlQw+WFgN4T5VUDqBFBaYF9v21XqxTf7N5wu00U?=
 =?us-ascii?Q?I+lJK8d+OWxqZIy3zlrwCfbJHRkIQmZe+pp4CyASraDoRKIuZ6cQMpsBJEeb?=
 =?us-ascii?Q?Lcn6OsvaR6Us5u7gtssxRM77vqMhanYuBgGb3V8OTFbrBK39iG/EBlVufM9e?=
 =?us-ascii?Q?cde2d4Jp98ztK0NR5u+OFefAuAwLPKklDuDX2JDM6FoGugRqQZH3nzu54tM9?=
 =?us-ascii?Q?twq4OrSNTKtLo6W7iolWheAcaviJVVvjm7PQ/FsmbnvSxgL9cBuh9D0K6vNa?=
 =?us-ascii?Q?n6AiEWyUMR9Put8maCENrewUOEWP3rekDNdt49+M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71276211-e7c0-4df8-ad3f-08dbb87559d1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:30:36.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5o7rLYVlbo3Z1x8E+FVWGJ7k22kPg2MXuLeEJUpHQiLO2MDVKnO/9yvuHfuX4cZpUh9dxHEMW0EAA6OHyldnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_113054_155887_E1451C95 
X-CRM114-Status: UNSURE (   7.00  )
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
>> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +     struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
>> +     int ret;
>> +
>> +     config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
>> +     config.nvmeotcp.cpda = 0;
>> +     config.nvmeotcp.dgst =
>> +             queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.dgst |=
>> +             queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
>> +     config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
>> +     config.nvmeotcp.io_cpu = queue->sock->sk->sk_incoming_cpu;
>
> Please hide io_cpu inside the interface. There is no reason for
> the ulp to assign this. btw, is sk_incoming_cpu stable at this
> point?

We will move the assignemnt of io_cpu to the interface.
As you suggested we followed aRFS (and the NVMeTCP target) which uses
sk->sk_incoming_cpu.

