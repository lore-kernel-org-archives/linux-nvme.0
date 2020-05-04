Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4711C3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 13:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C3B206D9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tiydfie9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UnugNHGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C3B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a7m4/DGbZI8QY/en0fveTStTXr8uQZmG6HRmjrp1HO8=; b=Tiydfie95wMCAuUvVKeo3Ci+Q
	N76NdjhTveF0ty4JNtuynrMcLQqd1Bd+jgH7SIz5xPil3ufo7oNECNulugmGTLxEf2q9MKxvd55oH
	3S4Blhk80jL+x4/pztCS5guNMdEcd28giPj0C17RLIyBnL8lc4Jb7HoO1JWQojyUgx/pg2N9FTTxX
	2xC67qq5UR30g54IagxOBmyph0InDG+QHpHBOP6bpwN/ziQ8xdwixhk/3rVr4IjLpqb3Q62ZRd50c
	dSEXHVptDiZBc7MDPpbTnHF7/y0C6WGhdFP6fFbM/q6p7yhbXVgOBu38ANmNeQ87IYj7Pnyc0aTGi
	lUmC9bSSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVaj7-0006b1-7e; Mon, 04 May 2020 13:01:41 +0000
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVae0-0006wZ-89
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 12:56:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frsp1//iNsHIS5hj3hn9xlVOpOQisY7XUuVuYWZJYxvRNkQmpPNFK8V2Uw/GzAwOaM5blb02mNaIgnD0+fr6jBr+29htMtEMl1yrJJq4cJFAYXnfNfIlp1Bo2M3kBA0IcVdu6YUUHgKWKdMDECsiQVbHPFcX/ZSz6/MYua6taRaJEkB41k1rUEmn0inf12sI5w9+EIq3r1zKmBaMlyl+fklTaKp4fZ/bRtBwoDaiSK7BjWCagRIGCkb6DTc4/xGLJVpftNsirC5Z9QWwyvk48xXO1ix0wirbAsSHrzDe9RqACe0t4cNDhRlxqG0yXwAo+B8Eh6Rv6vGAZRHryJYVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pK7yeJe0hkRuFFefF9PnGNMcMecWy4WHQr7H8EeHXM=;
 b=O/tV5GuL06x7p75OE0WWXEfP3/8/pJPS3PylF1AJQxyE6isU4dfVAB91WHWRdlONqtg35IemWFQEfSlpH1un2uU5s8ztOLcwg2OF9O7Dft+ATKFBHYEmbb8IkbodlU+wLyJs2rm22q6f/ZXsjhu0ISUHOpJHqT3eCRYSif95sJitKMtaOz2U5IlUlbsxFkNOkpAp1T57k8UIC7F3CfZitEqGH5gyRuHtTE482VdHhrv9u5bZZW1az/lM2DqjunV7+kUKky+i3FonyiXxhkqVu3WmAL9hQqJxdIHZNqrB+wDZdw7vi8AVPWlVuLT36L56ZD6t47nAUZiOGgBDgUggng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pK7yeJe0hkRuFFefF9PnGNMcMecWy4WHQr7H8EeHXM=;
 b=UnugNHGzy8ByNlF7aXPW+meIAfnsZMWGWS+u9BF4MrmVOkjvLszdelJdKi3qJL8KD7reBpgCelaMdRALq+y89cbPqWEFBKm4pcdfU/fN4vf9msOwlYGh/WyqT9I0BNMp2Zsh+HK+seNJ4E+nIrNbj8BtKtAjwDDDlZjtLWf1zYg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6081.eurprd05.prod.outlook.com (2603:10a6:208:123::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 12:56:18 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 12:56:18 +0000
Subject: Re: [PATCH v4] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Weiping Zhang <zhangweiping@didiglobal.com>, hch@infradead.org,
 axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
References: <20200502072937.GA12656@192.168.3.9>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <635b65b5-f44c-95cb-e9db-3e1d638f9ed3@mellanox.com>
Date: Mon, 4 May 2020 15:56:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200502072937.GA12656@192.168.3.9>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 12:56:17 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5ee0e8c-c9a9-4200-c558-08d7f02a8974
X-MS-TrafficTypeDiagnostic: AM0PR05MB6081:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6081786FBD720A3FD171DBCFB6A60@AM0PR05MB6081.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBVMVdKdX0LeGAqG9841csiqo/x4DUARjfrQ5jGOjobhre17OXR2Hy+8k2s7vUveNxclT2zIUA6j+yeNViVItaDvS+HhOhgjHmsuRDp9S4U58fGJSFaUcdSDVto9iKlahEHied/v/hKgy4d3zRuEJxzyFjqgiic/FPAO6wB8jYQBXhU17rEXfZlo1gOw/lvfZmuDXs4eljaNldexNSte8rENMJzt3zOrjhqYpULZo6jYEXqp6pFDsHepp9E/UvKIikG2WsmDPCbN2ePOlYVnmwa/KGQ9XAw8+jHgwpfGuBmvlCIdE1xa+EyUVtbmPj5eGuGfcjj/zJUdmgVrWRvAG8P8dS172GPu8d2bMgfwETugON+j2JkdnmFNG81pagGdk/q4MBfAhRsDWQoGSHpLGmL/mzbFTirK+smTvuoc3pHJC5m41phyKulkF8ED7B5X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(4326008)(52116002)(2906002)(66946007)(66556008)(66476007)(31686004)(478600001)(316002)(16576012)(6666004)(5660300002)(36756003)(6486002)(8936002)(8676002)(31696002)(2616005)(956004)(86362001)(26005)(53546011)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MvHFzIAyBBIg2Z33FKlZGpKRoW+gcXg7fsAcFl30XN3O+c56hCRtXkuGvmXemiT+Oyb3M/W4+QRHShqBd7OZTzm83a7jZdVbKaYQfYyy0ilT6NEvEMNDuoPFjJgrWdADonMc2eqqgN0EtEx9Mg9JyU/C0qa9dE8rV162xMOW42R3trCvyXKnJK7EQ1cxw8nXXILQNcI4JVRcz4Pw1//pVNfWVXdCmiHEZzo1Igy/f5GFo9Nkp/1DgaI9SbF0UTw/E317ST6FXlYhxu4NspEVVIA7p3F3giyp1oYKr+aNhcO56DvR51CVth1AjVJDnkpu5Dx6jw7wKC11OHwRrgBx6xpbXOW7VUlJxjAo8WCOAJ4E05p9UGrj4Vk8jViHhuE6weSyoS1pWWJxo25oZoWvzdr6wDWDWGIp0zWBK1MEZvK5bGXPz2BBe0mIZNQfrRjW+cwick+MF83JsumB+H+Kgy9vzS0ANDYKwsZ5Cb1r3o5BXgaooU3ZJSBcJPinPyQBR3P6lfI3cCMTYyMF6i8vyC3+395z6HTjwUGigxxwfioQ0no0H7/f91ES4+RqGFduswZ1eGIr9Tut2hqI0Y76oeTa6Mq/SKc8ZWL5x1x2udiLefTishym2k0rc/MPYPrDYQyNWaa0gtTwmA78eKK8L4uA5XalZGcWjLVFyi8fXydwia02+EIo+zNiAhz939X2HlBS+Qh7B8aAVNdBu/P31oL5L8jctuD7r7M7MdW9hlCap9U8666qx1er5d+qr7bZmSVu8H3kkdBzdbHAYrjVDogWfqXCG6GNsgQcbbjAgcA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ee0e8c-c9a9-4200-c558-08d7f02a8974
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 12:56:18.5916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVMYnsnI3vpBaeef+VDWaOpwSKztfGzhQYWxSZP7GCOgId7HUbrnMmPAhxUFAH8unDKqB9FlkyVkI/x9SZridg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_055624_361992_639180DE 
X-CRM114-Status: GOOD (  16.15  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/2/2020 10:29 AM, Weiping Zhang wrote:
> Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
> nvme_alloc_queue will not alloc struct nvme_queue any more.
> If user change write/poll_queues to larger than the number of
> allocated queue in nvme_probe, nvme_alloc_queue will touch
> the memory out of boundary.
>
> This patch add nr_allocated_queues for struct nvme_dev to record how
> many queues alloctaed in nvme_probe, then nvme driver will not use
> more queues than nr_allocated_queues when user update queue count
> and do a controller reset.
>
> Since global module parameter can be changed at rumtime, so it's not
> safe to use these two parameter directly in the following functions:
> nvme_dbbuf_dma_alloc
> nvme_dbbuf_dma_free
> nvme_calc_irq_sets
> nvme_setup_io_queues
>
> This patch also add nr_write_queues, nr_poll_queues for struct nvme_dev,
> that allow reload module parameter(write_queues and poll_queues) when
> reset controller.
>
> By now, nvme pci driver allow user change io queue count for each
> type(write, read, poll) within nr_allocated_queue, that's to say, if
> user want to change queue dynamically by reset controller, they should
> setup io queues as many as possiable when load nvme module, and then
> tune io queue count for each type.
>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
> Changes since V3:
>   * drop sysfs interface and reload module parameter when reset controller
>   * convert int to unsigned int and place new added variable at the end of
>     struct nvme_dev
>
> Changes since V2:
>   * fix typo in commit message.
>   * don't show /sys/block/<nvme_disk>/device/io_queues_reload for fabric.
>
> Changes since V1:
>   * don't use module parameter nvme_dbbuf_dma_free, nvme_dbbuf_dma_alloc
>          and nvme_calc_irq_sets.
>   * add per-controller sysfs file io_queues_reload to enable/disable
>          reload global module parameter.
>
>   drivers/nvme/host/pci.c | 53 +++++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 23 deletions(-)

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
