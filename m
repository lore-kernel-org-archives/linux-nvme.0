Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65FEC2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 05:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60976611CD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 05:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60976611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HG+JP37ww7sVL2+/tc8+Foj8MNQ7w50OiF/GONa+7GA=; b=SOfk1zHkJUvpjZ
	AxCknC2DbLvOfoeZMJBz9WnktXUq8abvP3YHR58ysMiZ+KaF02cjmJU2AFrbS4XRShfQJVpk5xS+L
	+FsKyrU2DI3Gccdpq0gM1PF+1C/X0+m06F4L1BMfWxP8Oguq+YXk28khMo8LQEwR7+nSh2A2qOReQ
	GkP9ewB2FAbqvVlufIBjxk0LR1AzBBTRKx61mFIac4xofttu3O+97X9iHR20VU+nFpCsKI1dn+JPt
	Tm4zFPDb4chCm+VtcBtxvmbrzX8TrHYw/jcCKWxTrdOg4BQzTAy0XVPGDN2bfZzJEhJve8CqS6LvD
	uHO/61CINFzSGhCAthjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llmTV-00BL74-AT; Wed, 26 May 2021 05:53:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llmTS-00BL3r-14
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 05:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622008375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQoAAF78VkC+gZnJ/d86NUEv5/PSyTm+sv9rpnki6Io=;
 b=cmPwG1FZVJkhhMVAtbrKlNAGDAwF8BX/Hqm/EIWVlN99Df5dy1+02tZMjykNZsnCz8+sK4
 1QW/ZuuTlp/dkc3AkzNYZwswXHPgOuwp6OLbq2fBYbUSdcvenn8tpuXAFUMH5tlRMwOGv5
 aw745wyIm2K15hoL0nvUzWwZjvcQBjo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-cEoM1-jBNpuJ_tZSnk4jNA-1; Wed, 26 May 2021 01:52:49 -0400
X-MC-Unique: cEoM1-jBNpuJ_tZSnk4jNA-1
Received: by mail-yb1-f199.google.com with SMTP id
 o12-20020a5b050c0000b02904f4a117bd74so378189ybp.17
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 22:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UQoAAF78VkC+gZnJ/d86NUEv5/PSyTm+sv9rpnki6Io=;
 b=sR8KNEy4kS7dRIPld4tyOquEp7vyy+kf0q+VzXlgYfHH/ZM4bzvXeUBHOxyQ7qKenV
 DARlV2fljYvEhtx6n8TAIeIVwdVd7lCdUgA6N373HFumvQmBL3FZbCJKa2urbu0JQZjX
 Vd7ODdmc2kzR8BxqgEgq2f8InWHzxcVAPpT3DVioeZi6/7gvMm8rVb9ie86vhp7W/6Po
 uqTxZrEyjl9mkhMImwP/dPA2no5TBwgygFP7qUr62doMRj7Q1jFXZ89KcV0+fvb9E6On
 o/H0CwpD5v3AfLcA2kN5PgtOnyUfmg06J1PIW15mIVw263HVIJ6mmTGBSHCsDEq323Nb
 L0ig==
X-Gm-Message-State: AOAM532TPYgRvb45fyTDblk3CU4KEpC2rdbIdxazlQ5L9HYsU5SWdiQC
 stRjN48tSaTF5b1aPl4OQvAg4y8KDHrp3EGPTBN5WrpdSAySMh0yYqAXEGhEKWei2WKpW6D7syN
 wEKRzeotnUJp07mUnK/ejz8bZ4JR2zc7hknWCl2ze05Y=
X-Received: by 2002:a25:6887:: with SMTP id
 d129mr22413356ybc.251.1622008368785; 
 Tue, 25 May 2021 22:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxSIe0KScAwarTwSA13V98E2smjPtCCInpOBSXN+u0Sk9fsZo1zQNfY6b40Hs7pNi8Q7s7BJKFVVSTkbz+Caw=
X-Received: by 2002:a25:6887:: with SMTP id
 d129mr22413336ybc.251.1622008368566; 
 Tue, 25 May 2021 22:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210525154905.2245888-1-sagi@grimberg.me>
In-Reply-To: <20210525154905.2245888-1-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 26 May 2021 13:52:37 +0800
Message-ID: <CAHj4cs_g68raDLLKTYXKa8xSvp8kNmR-cQ=HpNfkN8+8jO-ZsQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_225258_219876_0241C04A 
X-CRM114-Status: GOOD (  26.31  )
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

Verified the issue on the latest linux-block/for-next

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, May 26, 2021 at 12:24 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Controller teardown flow may take some time in case it has many I/O
> queues, and the host may not send us keep-alive during this period.
> Hence reset the traffic based keep-alive timer so we don't trigger
> a controller teardown as a result of a keep-alive expiration.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/core.c  | 16 ++++++++++++----
>  drivers/nvme/target/nvmet.h |  2 +-
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 1853db38b682..e991b4671aeb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -388,10 +388,10 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>  {
>         struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
>                         struct nvmet_ctrl, ka_work);
> -       bool cmd_seen = ctrl->cmd_seen;
> +       bool reset_tbkas = ctrl->reset_tbkas;
>
> -       ctrl->cmd_seen = false;
> -       if (cmd_seen) {
> +       ctrl->reset_tbkas = false;
> +       if (reset_tbkas) {
>                 pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
>                         ctrl->cntlid);
>                 schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
> @@ -804,6 +804,14 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>         percpu_ref_exit(&sq->ref);
>
>         if (ctrl) {
> +               /*
> +                * teardown flow may take some time, and the host
> +                * may not send us keep-alive during this period,
> +                * hence reset the traffic based keep-alive timer
> +                * so we don't trigger a controller teardown as
> +                * a result of a keep-alive expiration.
> +                */
> +               ctrl->reset_tbkas = true;
>                 nvmet_ctrl_put(ctrl);
>                 sq->ctrl = NULL; /* allows reusing the queue later */
>         }
> @@ -952,7 +960,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>         }
>
>         if (sq->ctrl)
> -               sq->ctrl->cmd_seen = true;
> +               sq->ctrl->reset_tbkas = true;
>
>         return true;
>
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index d69a409515d6..53aea9a8056e 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -167,7 +167,7 @@ struct nvmet_ctrl {
>         struct nvmet_subsys     *subsys;
>         struct nvmet_sq         **sqs;
>
> -       bool                    cmd_seen;
> +       bool                    reset_tbkas;
>
>         struct mutex            lock;
>         u64                     cap;
> --
> 2.27.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
