Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CCC388F7
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBDA2068D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="25kq1zak";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfkaFzLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBDA2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EP8lpOxBTj9wW7EATUB7Pc5UIv2AgtJVeygj15+CHXo=; b=25kq1zakjPusBgzf2hR+DdFbM
	1fpyDFyKxFmL/zGCTLB5+QXbjbT7B0dOauP+PwyXQFEC2+uueCbyZlhclumwUoclK+0TrNMXrOdIM
	u/KSHuzsVoo9YIcZQGITdWx4+lwgg0/GvBiEzDOeRHjwX/l4oGSGzIbanl6XkKHEdQ04NYZ5+3G7r
	EnOjGhzIVgHtkU8T+gi4rx2cEq7vy37eSCoEitCiWHkSqAuMO/hsK4Sill3ZLTsjMUybQho8smu1K
	13tBPlwjK/Omz2Xsy20gSHYkHDIkYVybUhM8EZQBzCyHafzc0lDC2298a/ZyHwVVRPPm2msjyBS1M
	x9UBN5qJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc7dz-000819-Db; Mon, 09 Nov 2020 13:55:39 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc7du-0007zJ-Gn
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 13:55:37 +0000
Received: by mail-qt1-x844.google.com with SMTP id 3so5967386qtx.3
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GMJ4mpfGxerOX0IArSsoe0rUQxIJkHjRxiT6nbHNgbk=;
 b=NfkaFzLo8TyiwTISMf9KmkM1ixinP22m3KHeSu7YytvWhnPsXLSYbMKgNHEsPMp6fC
 vuIiH4OBfgZzvZ1f6Dot66OYsK4vEjvHpqafQ+q6EydZoagUbYtwbkhutxnSlCVGc48G
 7oLOtrwsGQekbHud0HADFBKA/fNwK5it0hQChCVaGa7R/xpB8rQD9pfm6J93R6mzYJpg
 bykijqclyRcE1oAxwvACyH+NyX5cuEOTQ//Yj9uLGD9XNB6UKVYjpKeO/l3REEyWz0rP
 NOYsnHr1Oz9KE2yslCdbxzUWb0/qJrqIl/tRSg/BfMmj7m+/UIXRbPvb2cxJDqaNlq2g
 BmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=GMJ4mpfGxerOX0IArSsoe0rUQxIJkHjRxiT6nbHNgbk=;
 b=UbwffTcB8aso81C1KYcEpMsQf/H9rVNkZGSqQePSMHoe/y5tp1z9e78dw0amII0hyz
 eJCjaX57Gc2YBS9YnQe55xZD3KN4YkxzbfPPAiED/rCwmMvNccD/V/upN4CszooOYBjN
 /9HWJCCqWPSoP07Mp6WE0KX3VB6tvPDOn01EwKlyFZsGsjpaG+Na3DuOyYhmsxN1FrqX
 dduZICW9WT64kG4xqMFifrm1gf2Tb6haA215X2h6TMR/JeVU0/n7mYfilX4vhbKlVwjX
 8MtYPzDEUDwu9MPcajP+KoG7FhmGgrPgBGTbEYy1KlWREQYyM6ZFM33f0iHe21Pm9FhX
 0uXw==
X-Gm-Message-State: AOAM531DzN65E9/bgAPaTDBHiRRXO7FgIIKOM5VS4wBgAU5WZGGhocYx
 ptv27gVcvCJ9ftMu+rpOZ9u2rFHVGI2OSg==
X-Google-Smtp-Source: ABdhPJy/utpYjERO98eQpMFyeNQiowofecq1/I3Qc+4nrhWq9ZVxnExma/TCcQS8NSvhAp7xEi+uyA==
X-Received: by 2002:ac8:6608:: with SMTP id c8mr6394223qtp.203.1604930132665; 
 Mon, 09 Nov 2020 05:55:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc2b])
 by smtp.gmail.com with ESMTPSA id o63sm6275514qkd.96.2020.11.09.05.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:55:32 -0800 (PST)
Date: Mon, 9 Nov 2020 08:55:19 -0500
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH v4 02/19] blkcg: Added a app identifier support for blkcg
Message-ID: <20201109135519.GD7496@mtj.duckdns.org>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-3-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1604895845-2587-3-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_085534_719024_ADE381D8 
X-CRM114-Status: GOOD (  23.22  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, emilne@redhat.com,
 pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Again, some nits.

On Mon, Nov 09, 2020 at 09:53:48AM +0530, Muneendra wrote:
> This Patch added a unique application identifier i.e
> app_id  knob to  blkcg which allows identification of traffic
> sources at an individual cgroup based Applications
> (ex:virtual machine (VM))level in both host and
> fabric infrastructure.
> 
> Provided the interface blkcg_get_fc_appid to
> grab the app identifier associated with a bio.
> 
> Provided the interface blkcg_set_fc_appid to
> set the app identifier in a blkcgrp associated with cgroup id
> 
> Added a new config BLK_CGROUP_FC_APPID and moved the changes
> under this config

Please reflow the paragraphs.

> +config BLK_CGROUP_FC_APPID
> +	bool "Enable support to track FC io Traffic across cgroup applications"
> +	depends on BLK_CGROUP=y
> +	help
> +	Enabling this option enables the support to track FC io traffic across
> +	cgroup applications.It enables the Fabric and the storage targets to
                            ^
                            space

> +	identify, monitor, and handle FC traffic based on vm tags by inserting
> +	application specific identification into the FC frame.
...
>  /* Max limits for throttle policy */
>  #define THROTL_IOPS_MAX		UINT_MAX
> +#define APPID_LEN              128

Can you add the FC prefix for the above too?

> +#ifdef CONFIG_BLK_CGROUP_FC_APPID
> +/*

/**

> + * Sets the fc_app_id field associted to blkcg
> + * @buf: application identifier
> + * @id: cgrp id
> + * @len: size of appid
> + */
> +static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len)

I find the arguments really confusing, how about (@cgrp_id, @app_id,
@app_id_len)?

> +{
> +	struct cgroup *cgrp = NULL;
> +	struct cgroup_subsys_state *css = NULL;
> +	struct blkcg *blkcg = NULL;

No need to set these to NULL.

> +	int ret  = 0;
> +
> +	cgrp = cgroup_get_from_kernfs_id(id);
> +	if (!cgrp)
> +		return -ENOENT;
> +	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> +	if (!css) {
> +		ret = -ENOENT;
> +		goto out_cgrp_put;
> +	}
> +	blkcg = css_to_blkcg(css);
> +	if (!blkcg) {
> +		ret = -ENOENT;
> +		goto out_put;
> +	}

css_to_blkcg() can't fail. It's a simple pointer cast.

> +	if (len > APPID_LEN) {
> +		ret = -EINVAL;
> +		goto out_put;
> +	}

This is input validation. Maybe do this at the beginning?

> +	strlcpy(blkcg->fc_app_id, buf, len);
> +out_put:
> +	css_put(css);
> +out_cgrp_put:
> +	cgroup_put(cgrp);
> +	return ret;
> +}
> +
> +/**
> + * blkcg_get_fc_appid - grab the app identifier associated with a bio
> + * @bio: target bio
> + *
> + * This returns the app identifier associated with a bio,
> + * %NULL if not associated.
> + * Callers are expected to either handle %NULL or know association has been
> + * done prior to calling this.

Reflow.

> + */
> +static inline char *blkcg_get_fc_appid(struct bio *bio)
> +{
> +	if (bio && bio->bi_blkg &&
> +			strlen(bio->bi_blkg->blkcg->fc_app_id))

You can test fc_app_id[0] against '\0' instead of scanning the whole string.

> +		return bio->bi_blkg->blkcg->fc_app_id;
> +	return NULL;

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
