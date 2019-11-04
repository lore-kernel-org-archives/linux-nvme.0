Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B73CA9ECF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 09:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B6821744
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ujvmd0gA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lVpTdCWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B6821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AxVasADb7mn9COQoBh1fGrLWTE0sORf0GAczIOqisvQ=; b=Ujvmd0gAlVRowQzkwAkK2gxZP
	TrM57J7LCWXsgEaJCKQ6mcJbS87CLTdRIONyuwmhCVH3zTAKDkSI6ju6QLDM0WFJYEtjlrMeNu6bO
	a2wP2uzauQtMHRhzo9ET3FQdCjSLfLjUYIuXNtdzfU7SDctiVGhrNM4BB3XzC4CP77HYM1G+4G4Bf
	QBz5fkUEWPlVnUN5vuD3Th79+Rx4Mmy8ivl9gZwN2QW77DUBjqiSpctYd5MksU/OkX25t4yhoKWYh
	+5XI3q7WEX9YBI4fjFDyCrDesE4y2szG1r8rHgAN5LmoyVYQrnU8ASS7evDrwJ2xbc7zcxN+aNEl9
	hho8+IjEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRYnW-00069R-U7; Mon, 04 Nov 2019 09:37:18 +0000
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRYnT-00068r-Js
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 09:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjY8Sdo0JtQlgjRn+kENVlGXLJfBEVKYI+RK02ymli4JBZmCPUfAsCgBXJ8dgv2bcrYQEeMKAp878Ztnv/f2FZx/6Fm0Feq7YBnCklOxeV7CbjDGyNCf5SkRbuBW5W93caPbZJpMP9V4gYmBuYohx9WBb/EpkFtr1Joi0Lkl+MiknXMjnj2gUnum+kcJG7heLIxQwSyHFt9bcvhmvTXdVHGBTXluLazWPKTgzaT0ETcpBe/uCjvXmapz+HJk0pgPPtSMQJon3wkAdiW2Cji9QM/4nUE3cDxd4avVRpFQ4UBwaEfLs2DSKLn+Bo8xNOYfrng8EcCvej32bm3rrhlC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDrX+FTB6pC2LqK98mL8/hZFG72Z8Lm6cCQFoW1Wfyg=;
 b=gWF/xvgT0cfkM8N4HkEvnjcFB0BKBWQtCZSZbWtmGjE00LbEkESKyDIyxsUkeNhS0BjJnR4l1H+htv1OBEBvo/hdZl64RBRGHxTc5bF1uEqUlxy3szMt3WDbsPp5t5LgYpPgNg50W03BgsnMekN1dYRy9RNFRYyO3cd/1h7xXGOVdQLVJZyUkeJRJvA31DTrL3r6D0F0XWLrOGqDSukZaVyX7We4DcPL4hHvpacWcymrcACVDgAiMK15vUQeEwx8A+2ruy2dpdCrgYE+lK9yBfzgiByh9TGWn24xnRRylzWRtWPjWohWfHKXWOObOvZXM5QV628/npuS/k7nxyHT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDrX+FTB6pC2LqK98mL8/hZFG72Z8Lm6cCQFoW1Wfyg=;
 b=lVpTdCWQUKTlpUirrffjHpqSqVP9647X5lDTCKzkA9UcuDaZpDETEu7ZKWPhaq9Ot4nSliginNmOSI/IR071FhybBQX3qTOftBEtv9U9EnWVYQdTBkx8otNrba1XpZ12pdxlkiPP5z0UHslw3IMGnnJNhxkOQR6ShGHyy3M+MhQ=
Received: from HE1PR0501CA0013.eurprd05.prod.outlook.com (2603:10a6:3:1a::23)
 by AM4PR0501MB2340.eurprd05.prod.outlook.com (2603:10a6:200:46::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 09:37:08 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by HE1PR0501CA0013.outlook.office365.com
 (2603:10a6:3:1a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 09:37:08 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 09:37:07 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 4 Nov 2019 11:37:07
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 4 Nov 2019 11:37:07 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 4 Nov 2019 11:31:50
 +0200
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 <linux-nvme@lists.infradead.org>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
Date: Mon, 4 Nov 2019 11:36:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(446003)(11346002)(336012)(47776003)(36756003)(106002)(2486003)(53546011)(5660300002)(23676004)(58126008)(6246003)(16576012)(70586007)(478600001)(316002)(229853002)(16526019)(110136005)(70206006)(65806001)(486006)(2616005)(126002)(476003)(76176011)(81156014)(8936002)(81166006)(26005)(8676002)(65956001)(186003)(305945005)(86362001)(31696002)(6116002)(3846002)(2906002)(230700001)(50466002)(31686004)(7736002)(356004)(6666004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR0501MB2340; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab08cb8a-8ea2-4df9-5bc7-08d7610a8f70
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2340:
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2340DF2DA5F6522DF1E15A59B67F0@AM4PR0501MB2340.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0211965D06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpxWHq8VzwEle7WSg7AH/F+ojSDYx7bm1eTdQ8v8BWK/Gt6RKcEC/tKpHlZAtt7PGwoCvaKy8HLEuv2zlJrmG4o6yjx97fJrMhbNIWr1jHQ/VNgVgRkHv+oLeomUYKWVTtAaUBiR4qYfRI1yzytSZ+TvQxLfNMX9YQmEeeUWvVMjbuBd6Hjq24vJqYgOiXdjShPwVuXtg25IZuEYJHrdjiT2EZpxR2b3MBA6V4hTrI5fOg7f4HCEr182HE22BWaQBCl91mMcc4fdcKVkNW53zMKskmQN6IsXrptKxz3yjngz1rRChO9g35kwYJyEonEIFIBAGbJDAYKroVJPSq7bxF5ppiceVWMtk8opTkv/hK7cXqatlYJBmssu39YUCshLLuKSXXP8ibSr1VCeSwwxEqZZF7yF9tB9mqBdnRnNgJpL2gp+h6yeBq/JPhgPaKxU
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 09:37:07.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab08cb8a-8ea2-4df9-5bc7-08d7610a8f70
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2340
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_013715_657811_CB62F72E 
X-CRM114-Status: GOOD (  23.29  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/3/2019 8:13 PM, Chaitanya Kulkarni wrote:
> This patch adds a new target subsys attribute which allows user to
> optionally specify target controller which then used in the
> nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

hi,

can you explain why we should give the user the ability to control this ?

In this case you will have multiple controllers with the same id, and 
I'm not sure that we want that.

Did you try to connect to it with -D (duplication) flag ?

>
> When new attribute is not specified target will fall back to original
> cntlid calculation method.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> Hi Mark,
>
> This patch allows user to set the contoller ID through configfs
> which is target susbsy attribute.
>
> Can you please take a look and provide feedback ? so that we can get
> it to upstream ? I'm planning to send this on Sunday.
>
> -Regards,
> Chaitanya
> ---
>   drivers/nvme/target/configfs.c | 23 +++++++++++++++++++++++
>   drivers/nvme/target/core.c     | 23 +++++++++++++++--------
>   drivers/nvme/target/nvmet.h    |  1 +
>   3 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..83391e54ed12 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -862,10 +862,33 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>   
> +static ssize_t nvmet_subsys_attr_id_show(struct config_item *item,
> +					     char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%d\n", subsys->id);
> +}
> +
> +static ssize_t nvmet_subsys_attr_id_store(struct config_item *item,
> +					  const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	down_write(&nvmet_config_sem);
> +	/* should this be %x ? */
> +	sscanf(page, "%hu\n", &subsys->id);
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_id);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
>   	&nvmet_subsys_attr_attr_serial,
> +	&nvmet_subsys_attr_attr_id,
>   	NULL,
>   };
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 28438b833c1b..2396215a23c9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1267,13 +1267,18 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	if (!ctrl->sqs)
>   		goto out_free_cqs;
>   
> -	ret = ida_simple_get(&cntlid_ida,
> -			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
> -			     GFP_KERNEL);
> -	if (ret < 0) {
> -		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> -		goto out_free_sqs;
> -	}
> +	if (!subsys->id) {
> +		ret = ida_simple_get(&cntlid_ida,
> +				NVME_CNTLID_MIN, NVME_CNTLID_MAX,
> +				GFP_KERNEL);
> +		if (ret < 0) {
> +			status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> +			goto out_free_sqs;
> +		}
> +		ctrl->cntlid = ret;
> +	} else
> +		ret = subsys->id;
> +
>   	ctrl->cntlid = ret;
>   
>   	ctrl->ops = req->ops;
> @@ -1330,7 +1335,8 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fatal_err_work);
>   
> -	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
> +	if (!subsys->id)
> +		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
>   
>   	kfree(ctrl->sqs);
>   	kfree(ctrl->cqs);
> @@ -1416,6 +1422,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   		kfree(subsys);
>   		return ERR_PTR(-ENOMEM);
>   	}
> +	subsys->id = 0;
>   
>   	kref_init(&subsys->ref);
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 46df45e837c9..a3d3471bdf2d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -211,6 +211,7 @@ struct nvmet_subsys {
>   	struct list_head	namespaces;
>   	unsigned int		nr_namespaces;
>   	unsigned int		max_nsid;
> +	u16			id;
>   
>   	struct list_head	ctrls;
>   

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
