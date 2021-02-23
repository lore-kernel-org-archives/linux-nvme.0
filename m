Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BCC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:57:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595CE64E2E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595CE64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NGJhrikvDbdCnm6+gKfkG8HoA7sy2KnszlugZipX4MQ=; b=T1qPhJYHx0DpjViRDWS2gVffp
	cx4JD/u86y+NgC0EM/3o2UPZCFfhjD9cWZ/rACZ3tltAs8ISlkxjLYs32zRFmuK/a4/BQ3ZtHCENn
	S67JVKGh+3Pxg5Gx6i/nD5GXE16DTsJNHGXym16V8G9qqmtpwDFNiGnBn1ug+89ljDn78LksG75A3
	JbRuCFNU4Kvo+kd18z15Yx+ivyO5rz3N75Yg7C5ALlZwKEZXES+M7ZDyhrIaxXn9/Fux/cB6VjAKt
	IAhWUrt068N1tV7OcvO7RHMxqK+lc+vrd+YHwcXdz6uOh2RNR460M+Q+UC4m1GoV4ZZ2S4goEBMgy
	o5xCVDz8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEXFO-0003tp-IP; Tue, 23 Feb 2021 12:57:02 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEXFM-0003tT-KH
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 12:57:01 +0000
Received: by mail-pf1-x436.google.com with SMTP id q20so8711730pfu.8
 for <linux-nvme@lists.infradead.org>; Tue, 23 Feb 2021 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=B+8vQzq+6c3WXzqt86hoiFfYiVMwX/Xk+8ZZ6a4Copo=;
 b=mwn4N5H7eDjLhSdfYfpHs4jBvs6+2L/aqjmse0Ghf7NCDKH/rqfgPHOQzLo84RP8JC
 RNNu4kSTJ0vzRB0BkK4AL/QASZOcPwsLfWDG0KpAKLmoCnisGO/kf4xbTRUKtoaJF0Et
 qAz/0ESneZEw1ScmMacPwju62bTg4N0EBxxg0xAImuuqjQwSDtgjAzvY5kgCS5cRB6wq
 VAsWhcq6i6LI2YeBhuivgJR4PmdPMlKWxDAqJbSdn6ywQPLGBDmwKQHPwKJOzWqNeL7j
 dlO21OAu+dYv9M1c5ZfHqDq4o7WS8v87C98Cf+ftzeSJFxkGVynv1w3ukmoS5XEp8yxm
 w+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B+8vQzq+6c3WXzqt86hoiFfYiVMwX/Xk+8ZZ6a4Copo=;
 b=MiHEvJZoPWYn95/j4xWOJjPz8M4uj4L9Mn90PX8KywdufZ4Q/1Gbz5hW8jTUcQRaAd
 WEgryhLS5yM8UpEz7QQ90sWrgJmpsL6kh2iNlSrZZT383MADd1em6axPZC70cgvJn6u8
 evtbeowyI7zq/bby+p9Lj1VK4ywWFUogLNLaA3/olpCRhMPCoKLd6bWJG5xXCUaP0jNG
 DaoC8slB0HOd6i8ZS1lM1jRgpH7yjeAS5ax2jQDQ54VI0w8r9zVWtp/dWF3C749e/hK8
 iGoEx2DG71i2JBDy0UePb/cJVi/lYi1q7GgLVw4Zz4POGhNAxm4yyvyP0B6ALwhXRpSm
 5ylQ==
X-Gm-Message-State: AOAM530Oz2FASxRy2aOFhHKQ3+NBlsl3on7Cyiq9ySlJ3CXg4dfWA5bj
 1k1jQzphlcQM3XGYQ4SaMBs=
X-Google-Smtp-Source: ABdhPJzBOhE9dVrjOW1nV2kdH+BHwcJEYdbAY4mp6uToQlcXi99W3ntj6S+sQKoX0OER7KP9PNgv4Q==
X-Received: by 2002:a62:6006:0:b029:1dd:3af9:965f with SMTP id
 u6-20020a6260060000b02901dd3af9965fmr27464611pfb.30.1614085018332; 
 Tue, 23 Feb 2021 04:56:58 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q4sm13213626pfs.134.2021.02.23.04.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:56:58 -0800 (PST)
Date: Tue, 23 Feb 2021 21:56:56 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
Message-ID: <20210223125656.GC2119@localhost.localdomain>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-3-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223115922.104369-3-hare@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_075700_725866_0A94CF1A 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-23 12:59:22, Hannes Reinecke wrote:
> The multipath code currently deletes the disk only after all references
> to it are dropped rather than when the last path to that disk is lost.
> This has been reported to cause problems with some use cases like MD RAID.
> 
> This patch implements an alternative behaviour of deleting the disk when
> the last path is gone, ie the same behaviour as non-multipathed nvme
> devices. The new behaviour will be selected with the 'fail_if_no_path'
> attribute, as returning it's arguably the same functionality.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      |  1 +
>  drivers/nvme/host/multipath.c |  3 ++-
>  drivers/nvme/host/nvme.h      | 17 +++++++++++++++--
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2fb3ecc0c53b..d717a6283d6e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -542,6 +542,7 @@ static void nvme_free_ns_head(struct kref *ref)
>  		container_of(ref, struct nvme_ns_head, ref);
>  
>  	nvme_mpath_remove_disk(head);
> +	nvme_mpath_put_disk(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	cleanup_srcu_struct(&head->srcu);
>  	nvme_put_subsystem(head->subsys);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d5773ea105b1..f995b8234622 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -724,6 +724,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  
>  void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>  {
> +	if (test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
> +		return;
>  	if (!head->disk)
>  		return;
>  	if (head->disk->flags & GENHD_FL_UP)
> @@ -741,7 +743,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>  		 */
>  		head->disk->queue = NULL;
>  	}
> -	put_disk(head->disk);
>  }
>  
>  int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 3d2513f8194d..e6efa085f08a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -681,8 +681,12 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
>  
> -	if (head->disk && list_empty(&head->list))
> -		kblockd_schedule_work(&head->requeue_work);
> +	if (head->disk && list_empty(&head->list)) {
> +		if (test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
> +			nvme_mpath_remove_disk(head);

Does it need to call nvme_mpath_remove_disk here ?  It looks like it
returns with nothing right away if NVME_NSHEAD_FAIL_IF_NO_PATH is set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
