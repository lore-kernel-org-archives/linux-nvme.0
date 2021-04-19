Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A992C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:20:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C623E61077
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C623E61077
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wWuuZP8OLryvNpiZBgI2UfvaAY1NTsKUtrI1jsIkXrQ=; b=e9L0MM0qwEnxx2XGmQD9ARx42
	44FkepEz+I1Q27F7sXHIvXPc5olOpEcAP+HpTcwX8UJE5g5qEgtSY4fyEA0vrR3Ed7TGlLOEVbHar
	rVpmxKFk5aZ5dbulljiB1rOF9qiL3AAQS3yrLTJaLehu9NrgvEfD6dqbNBNByoBmOpaHnRtgYu7k7
	G8J2N4W3oEq+nwFAp0ZAHGG9Ug0lm7siIwCmw9cgCPQNETYMoCuNIlmCrC6oW1yf7BnlUKK6AI4jE
	9lJby256Qpg86DK3yIPVvNdC9GhhPsDlBzrheZaJjate8y4oamIbg14q2Px28DOrjbUEUCbcNX5tf
	S1qn7Ac3Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYWcu-00AGne-Pm; Mon, 19 Apr 2021 16:19:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYWcs-00AGnM-CW
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 16:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=ULfldEWCeiG86bWrzItwxbpSXvkNGw6z9N7T1wXEGhM=; b=XyKBXjWDroeWpKdHNd640lTUhy
 0tLAyURMa3/DCDXB+joGOdsvOwsY3GmxNZOiIRui1QpPHCm0vjDXMM5SgfH5YD3MTeLYHfWITz+zM
 Pj9kF5m2xxhz4JhybrxdqDByElUwoB8mBApVHBU8Fx4qVaOauqbc9WI1xBYy5uV+dRSXVaGCOq4UB
 syb6++VUe03L86dQu+y0eIVXh6EFKA0uP6d9M/pP/8Bo/Zzxy9Pn67TKZEIYVF576MKwXOLLa7L/G
 sZW7NiJIQsTFmfnPVLe5gGK+/dF2PbC/zkmQAw7JfWjGCeLE8O9nIb39L0Uuxf7ZnXLdVL9sxht6m
 Lpj5n2Sw==;
Received: from [2601:1c0:6280:3f0::df68]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lYWcG-00DzdO-8w; Mon, 19 Apr 2021 16:19:22 +0000
Subject: Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
To: Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org
Cc: GR-QLogic-Storage-Upstream@marvell.com, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Nilesh Javali <njavali@marvell.com>,
 Arun Easi <aeasi@marvell.com>
References: <20210419100014.47144-1-dwagner@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
Date: Mon, 19 Apr 2021 09:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210419100014.47144-1-dwagner@suse.de>
Content-Language: en-US
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

Hi,

On 4/19/21 3:00 AM, Daniel Wagner wrote:
> Allow to set the default dev_loss_tmo value as kernel module option.
> 
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
>  drivers/scsi/qla2xxx/qla_attr.c | 4 ++--
>  drivers/scsi/qla2xxx/qla_gbl.h  | 1 +
>  drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
>  drivers/scsi/qla2xxx/qla_os.c   | 5 +++++
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 

> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index d74c32f84ef5..c686522ff64e 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -338,6 +338,11 @@ static void qla2x00_free_device(scsi_qla_host_t *);
>  static int qla2xxx_map_queues(struct Scsi_Host *shost);
>  static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
>  
> +int ql2xdev_loss_tmo = 60;
> +module_param(ql2xdev_loss_tmo, int, 0444);
> +MODULE_PARM_DESC(ql2xdev_loss_tmo,
> +		"Time to wait for device to recover before reporting\n"
> +		"an error. Default is 60 seconds\n");

No need for the \n in the quoted string. Just change it to a space.


-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
