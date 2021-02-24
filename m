Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:31:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F70164EA4
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F70164EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xxW+j0hzvjkMQWKgIZGkP7Xzd9yHjzGDuQc16SBxVHY=; b=t5nOeMkyeydoTRvIVjBKxvDjV
	Ys4ZOcBfnfmhSEfOVWoP5ucekPxazFdrbdtDec1khc9SgEFVq8SxNteDVxc1wJ2xXTfAAOauw8CyS
	nH+39vJB9F3QAdbXjUpwPOGmkOdu0+pV0uFv9toYXsby1hKdGQjKkFANjAlQ7gMTju1C9NXH5nfMQ
	flSEJso+8Xk95CYi9a0UBbDRr640y7wFxSKRVg503T1l3HhdMxvjom0eHP8tV++KMwcytIYP9glwD
	oNaLtE8ZmqmyKe+hqZLICWI+88RnwVh5T6P8u7GgLddm8GbHaAWy6Vw+WrAy4RztixwH/UzvKhoLp
	7fY4UDMdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEx4L-0003sa-14; Wed, 24 Feb 2021 16:31:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEx4I-0003rj-Og
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 16:31:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 60ABC67357; Wed, 24 Feb 2021 17:31:16 +0100 (CET)
Date: Wed, 24 Feb 2021 17:31:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/6] nvmet: check and set the right err location
Message-ID: <20210224163116.GB10673@lst.de>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
 <20210216213112.20078-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216213112.20078-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_113118_949732_8E9BA19F 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 16, 2021 at 01:31:09PM -0800, Chaitanya Kulkarni wrote:
> The function nvmet_execute_admin_connect() doesn't check for the right
> error status value that is return from the nvmet_alloc_ctrl().
> 
> Check for NVME_SC_CONNECT_INVALID_PARAM & NVME_SC_CONNECT_INVALID_HOST
> before we update the error log.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/fabrics-cmd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 42bd12b8bf00..cf0baa911db2 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -191,9 +191,10 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
>  				  le32_to_cpu(c->kato), &ctrl);
>  	if (status) {
> -		if (status == (NVME_SC_INVALID_FIELD | NVME_SC_DNR))
> +		if (status == (NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR) ||
> +		    status == (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR))
>  			req->error_loc =
> -				offsetof(struct nvme_common_command, opcode);
> +				offsetof(struct nvme_common_command, dptr);

Can we just set req->error_loc inside of nvmet_alloc_ctrl?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
