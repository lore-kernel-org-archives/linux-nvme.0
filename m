Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A6C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A8B20721
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P69JQJu/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LcxSVzG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8B20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n7FwoEYQrIbQ0o8b8uwRHUFgLsP7xnHc4yZYg2GmWeY=; b=P69JQJu/g1VCBC
	VDrdG1BQSSOU28CJPjI9Nq3487jwUu30OSSlDKfOXtMR4kmRlhrhEnHbdUMNILOUvgbPonauMKSV0
	7fwxM1kqaOocifYMRx+YdggGFWgCk0iW6s6JJ+FPSzY4n+mMowOF265ykS1Gh532inx1OgSVtp44R
	PVGepFx92OLWlQPTMgPfnpQOck/nkpvN0cpAI61UKZp2EQxjxL7fWY/a1okq//sqZQAcECOMYbdF9
	4YkHSjng1DqtMm0TEExg8/UT0MhxjurYfIHaPrkiDRnezsLegYAvCafvIZOW11f0FSe1uU639VGPN
	XP1FXIMAHvXxGxEgj2VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipwVT-0004gs-EM; Fri, 10 Jan 2020 15:47:27 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipwVR-0004gI-A1
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 15:47:26 +0000
Received: by mail-pf1-x444.google.com with SMTP id x184so1331398pfb.3
 for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2020 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z4ABlzGfi6l9NY75xhWGkqHQ22z62lYF4lGV0Z/l5RI=;
 b=LcxSVzG5beLFAGBipNshQyqz86YJ4TvGiOt8WALynXqSjPkkq7quMQSkFPFePo5f1q
 kJd0E4o7b+dPaAwBlXzfg5j5FKpHhUCAp057Fb328BFbzN8FK/VNHdiDhDR1bzkAooFs
 EzOxEsiGw18GT7yVSM8MCsgBXWLwE304YYV4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z4ABlzGfi6l9NY75xhWGkqHQ22z62lYF4lGV0Z/l5RI=;
 b=unEzVX4HNLJGzDyqx5SnHTrRMyRFcv7vS0HcZQnFhjT3rphLFwC7CvPMq2Ij/MYpiN
 oEV/YpeqHbQRbgeU3pwRwmdf/OG8YGTZml+jL07XkV9LjObhHXcBwpf4WaZxDZhyEeny
 0w1oYBYCZHbwQiWPf8M1mauLemYT8Py/ozO819NFfpMJHY8TYv2WTCXr/XR7pZfSZ9iL
 RhDqWxAJlP1PNIouGUzpkiYkPHUd6skcnS5wRPU9BG6JQkdao1/+JAfDn7w+jEBii7e3
 dgDShPHqkRK5SYoSlydBOnEjXyh+9flF7u/ZZH3d+RDXpw+6csrMzQnSwLE5UqxydSFm
 g9Yw==
X-Gm-Message-State: APjAAAUtRnqbdPvxmnxJhl8iWqCf2QQvhiw90pYK+5QCQiJaGeOqmnPK
 HQbCcII6dOA1Jfp42MCDIzdnWw==
X-Google-Smtp-Source: APXvYqwJtzElrbQ8rKden7GP/HTNQxSyjLQOYjfY8yPFbp0XjIM+yXed9Z3lzn1NH9U0cYSbLjiIow==
X-Received: by 2002:a62:c583:: with SMTP id j125mr5021922pfg.27.1578671244168; 
 Fri, 10 Jan 2020 07:47:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
 by smtp.gmail.com with ESMTPSA id z26sm3137300pgu.80.2020.01.10.07.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 07:47:23 -0800 (PST)
Date: Fri, 10 Jan 2020 10:47:22 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110154722.GA128013@google.com>
References: <20200110132356.27110-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110132356.27110-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_074725_355845_C058EF63 
X-CRM114-Status: GOOD (  16.12  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel-mentees@lists.linuxfoundation.org,
 Christoph Hellwig <hch@lst.de>,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> ctrl->subsys->namespaces and subsys->namespaces are traversed with
> hlist_for_each_entry_rcu outside an RCU read-side critical section
> but under the protection of subsys->lock.
> 
> Hence, add the corresponding lockdep expression to the list traversal
> primitive to silence false-positive lockdep warnings, and
> harden RCU lists.
> 
> Add macro for the corresponding lockdep expression to make the code
> clean and concise.

Amol, thanks. Could you fix this checkpatch warnings? hint: Use --fix-inplace

CHECK: Alignment should match open parenthesis
#50: FILE: drivers/nvme/target/core.c:562:
+               list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+                                                       subsys_lock_held()) {

CHECK: Alignment should match open parenthesis
#60: FILE: drivers/nvme/target/core.c:1180:
+       list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+                                                       subsys_lock_held())

Otherwise,

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  drivers/nvme/target/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 28438b833c1b..7caab4ba6a04 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -15,6 +15,9 @@
>  
>  #include "nvmet.h"
>  
> +#define subsys_lock_held() \
> +	lockdep_is_held(&subsys->lock)
> +
>  struct workqueue_struct *buffered_io_wq;
>  static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>  static DEFINE_IDA(cntlid_ida);
> @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	} else {
>  		struct nvmet_ns *old;
>  
> -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> +							subsys_lock_held()) {
>  			BUG_ON(ns->nsid == old->nsid);
>  			if (ns->nsid < old->nsid)
>  				break;
> @@ -1172,7 +1176,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
>  
>  	ctrl->p2p_client = get_device(req->p2p_client);
>  
> -	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
> +							subsys_lock_held())
>  		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
>  }
>  
> -- 
> 2.24.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
