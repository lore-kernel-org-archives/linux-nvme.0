Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514CCA90AF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E5D206B7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jCfPlVTe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="iNZZ9dQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E5D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BzWWlYS1alo3434aRzsEi5wEaotL+K/Q4r3K1Qde8lg=; b=jCfPlVTegbhUs0+cFQCyIUV5i
	9HNHfHOCfE5COZJGQSiJv4KBHiplSMr5ilZcHzxpJRUbKNeBbcx4jk/Ao0jZBW3lECmwNL7gl5a+p
	fz9j91CAcDEbFy2tlOeGP+7aX1uq6nQlM45P0G+KJBGzgnO46QuJLMp7QaQKhbX6dgt5rn0+iEV+1
	BReuReSIcguXOUzRnLQcZ0P0nnvU/HwyH7q9/xf2AdaWHXLdMssWPrgU9BYacvOp3lPj5SZHZQY7p
	CpUn1O+ADVT9EAClo1ReiOMowdV0/UEscZkcojlxh1BrvfQSbf1zDd1wWT6QPCpQKWwpzW3bZm/hs
	TODOTol8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYXhm-0006Yv-J9; Tue, 12 May 2020 16:24:30 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYXhk-0006Xl-16
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 16:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jURGviWmfZ6MhmPjp9WqDkSS5pnf5hJe7dttwsgCEShT08o3mmbpZNX5p9c9ZJc9tax55+JxBCzvyyF5UtRfwzytW06famy6bK2f4gtIP7YdA/+j0CgTU8jDnoNHl9iqiw/uQbGWptD1cnPRmg9rGNJpFZDcdrCmONNzYuX4x9GSI0ocwA7p02BeK2EzHW/vH98k/A7I7LC7uXNla7mVOyBxkeeMg/0SctjBL1eJioBFwZkS9Uis4TjrVpz61OiaSNkk8Oio/BHXpbcQKTWvR6RkPe3J3Rclc9KwuNrrsEGfHIzdmwtDWZ2SQ4BSmWgIinGIGiTMgEZcGlSoKKDZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=112xVB8tNrEDHVIxIasJMrUU6rJosC6aJWiHbeLdXTM=;
 b=AG2hy+Sxq2llbkMiNSPYadM1QkCESto5ONnXC843kyYjFRFGyeFdHvDCtKDI7OZlwncm4X+o3vsVeS/8fy5O3eIBbkMk/BLVJAQrRy6xd436kQiYnSGYZOjVyXWyRlqv44wKYSm33be+UW7ICWI4UeShbhht6sfMx1tZf+sfHrdfOPB/uJO7Aic8bVaYMQVq+us6GIRZxoT07FcCwtDsP1x0QmbHDjplGetiHut3HtqNdM4r/moyH7DFhudFi+c7oC0+9avvc5+sOAHnvyhpLrTXLjmRN8q8bJbtmIp6MU7/H+Gg/pupc2FfnAIUuScyufx4jRoSm5z/W9lwTFkghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=112xVB8tNrEDHVIxIasJMrUU6rJosC6aJWiHbeLdXTM=;
 b=iNZZ9dQQfLuhNQsNHXPull/QsD9B3htjsi61g5z3IW01q4gpSy+ZwvgusR33f5dW/7AultvAk8WK4l+2cnyUscg2GHeZwAONGIm7HtuTPkRyL1JL2hqp/Ln4Vw1pCwhnnD5K7qhh89GTzTDVyLpgwaW3Ef2FeEM/JLR7UFEoEIQ=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6770.eurprd05.prod.outlook.com (2603:10a6:20b:15d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Tue, 12 May
 2020 16:24:23 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 16:24:23 +0000
Subject: Re: [PATCH] nvmet: mark nvmet_ana_state static
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200512161926.1822603-1-hch@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <962c56fe-4530-43bf-4f95-c732b74b09c3@mellanox.com>
Date: Tue, 12 May 2020 19:24:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200512161926.1822603-1-hch@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::36) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 16:24:22 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3817269c-bc2a-4265-0c32-08d7f690ee55
X-MS-TrafficTypeDiagnostic: AM0PR05MB6770:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6770304587E753AE3D157338B6BE0@AM0PR05MB6770.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73fqxDDJS36J7PULMOCZmgd8SqFtxCZFnWGXyUP2giXfscSEr26die6ObreLxCAzgKSnB8HdHmSNlL5nOeeMiHrSfMj2jYPOvcKhjyXIAwlF73mrZafFlWdesrg+EsSqwPE32jbdRmUSoKklStdzF9/ezKOVVari2ikWqNvycXZZ1y6ZIDyrpWvcqtMX/LsdJuYxhYCVNMXCt2Voj9tCUIA40DjarPYtPP/Uyl46kgUmmiL33x9bzRCL5g6A3KdVLrnUDtlj0mgzeiJqPxtdq2FyLgiJdjqHED3goepvyGe1vlsSjkWMjYXtdoI+PM88EWuAJxBHJ2XsLyjAKBiu+691dDKQVTrTJ9TMzq/ICviR7P6I0rPuDwjys6LjYLy87sCu4BC9ghZlEIj0sQ06rqDyHbrjVdJtRmBWgBmbAsnQkXfHUmQcw1dsjmTbaGRtMZs1PemJfBEgpfOeOqwFJuWpOFLiae4gftLn7Q8xfhdfYDNMbOIgyb/vgVTN2HbfDB82P+I0mHVAJMxMQnrrqFrAEV8TqbQw4odM9jCOvJkpT7GyTynDojIQdg6EQhux
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(33430700001)(16576012)(31696002)(4744005)(186003)(66556008)(53546011)(26005)(66476007)(66946007)(498600001)(5660300002)(8676002)(16526019)(8936002)(52116002)(6486002)(33440700001)(36756003)(2616005)(956004)(86362001)(31686004)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SF2f/jcmFWoX/RpHiTbKEQyMkj36j6UZND3IDAp582L6aocfZDaLBTgpUJSyOwPli6+7qXBmt0AGADu+4eyBHyjhBPOlZgdiDcK4f87xfD9T9jqlz2oQp0sMp4LD8Jr1c90qFqQc4tZVOPR9FqyEBHAnTrNP2CxbZp+vC4Vc36R61GJ7AxLVc9Q282mraIoq2sNqdDFUsf36q7bsh9gvbScXQ0QwEckK66x5XAFOKCV0mAkwHYgndXrSILP9zCvyKIO7YtL9XuldRO4O2O8RFr1PJGtMshufgcUNeJ77OR6sxCl87RpgqCdxHrhRKijInlwNylYffK6l4uLjb9ltJxP/er7qPf1LVXZtxSGzxRnA/Cux3CuVqoDuPKMM1DdnIcHquf719AWL1536xeQeje3OwdnTju3+dGv4XM4km0tFfSJGwQ0gnjDsl/Wgq/eQ3KMagW+UhJCm0G0Z/c8Ay6SyNkeLyUd7MtmDJaOJrd1kfS5uAyV/jHej0mwLPm3N
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3817269c-bc2a-4265-0c32-08d7f690ee55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:24:23.2368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsb8EdvqWG/BWi52PRaRzMsNWg97OsBB7JJfJvYmw3Ts5zEmBX1bhIxiwpeGz8gjcB+gotGZUdQftGIm9rcvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6770
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_092428_137448_5CEFFE0F 
X-CRM114-Status: GOOD (  14.06  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/12/2020 7:19 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/configfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 19bd5e1c681ce..24eb4cf53b4f5 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1146,7 +1146,7 @@ static const struct config_item_type nvmet_referrals_type = {
>   	.ct_group_ops	= &nvmet_referral_group_ops,
>   };
>   
> -struct nvmet_type_name_map nvmet_ana_state[] = {
> +static struct nvmet_type_name_map nvmet_ana_state[] = {
>   	{ NVME_ANA_OPTIMIZED,		"optimized" },
>   	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
>   	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },


Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
