Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0995AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:46:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747B422363
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N83B6w/E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5kCljRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747B422363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VOd9vgHWp6PLpQE3i1fRoV4h/w1XaejQQwyvenenUbY=; b=N83B6w/EbiNp8pKRhzrGCCaAD
	cTCq286fRSS2w+MiI6IzX4XYxUzZNVvMxgJlDQDiBHlH9sAG6+31UTRWuhOEB+bOpD7+ylNn/SVSq
	JMj57ZeX0S3ks4PXUYKVj2Mlf+OiTc6T/jAgy7PVlZYOW/UJYcNqA389fU+23G2U3pLnwT6u6fboC
	zUzLYlxy351xGhgF2l9uiJh7q2pMAoheMMZiahbUcHaN6G3ACfVDrNu1JJrujDgS6PxRoDK0EHyf8
	NOoe+1d5jQ4zAaPrIqHR9doTbp+yvwGw7AdlKrD6n2q1nspDxz9GOIkbherZtE3H49T8NEPdPyn4N
	+AOIkJMfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWQe-0005By-HW; Mon, 19 Oct 2020 14:46:28 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWQZ-00059W-6j
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:46:25 +0000
Received: by mail-il1-x144.google.com with SMTP id k1so307477ilc.10
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jH9tOACmpXUPBysf5MfcJ9Ja6eT9Sj9D2qdGKGGFkek=;
 b=p5kCljRgP6SMV3bkc97b6EXsb0T/kx746J4Pl5Br3bD/TqasJEYFTwCxm5eOi+0kkZ
 adB/R2hTn8nmXjOfUsh93W0122NTWr6/U6O9x9MGWaENG2/lvhurVOnM2t4EUREhCwK6
 f384Q/mhWOKPWbi6pmHTKDIdUNGH8J35PoX25DuFtjUqtBEOfa/VrUOXfe3k9+UNy/iB
 jKDrN/n0qsaE6pUT90ySKYPOmuBW+dnJNu378L3qKDKV7g5ZqNTBaf0o6fSDhHVgjINY
 HtcCumJgzIfZ92l2IgMobM+SOrQMVIJ56LNLUF0eFSHkCsTzrLn5bpeyuRsvXHDj5FNk
 1Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=jH9tOACmpXUPBysf5MfcJ9Ja6eT9Sj9D2qdGKGGFkek=;
 b=XHOgETS3fa5EPBQQ0Jdere2CvAP79jn/pjTCImgaxcEbvn0dkR/OdgOqJHrvxfU1p6
 Ebu+q6RcdstiBNHz4Dx/VMror/nomGQ6n3uTs8VM7PW4jzOYz/sTEsIRckycButzFDB5
 q82qL/jJOWGKu9VVg68TQHzEWLLJgLFfTRdsKXVi/1dXgPfNjNj4yATEiy9yuoTXotDJ
 LAP0B6arFqkFFyhK6ExU09Dr4rqnvDa+CzBlZqW+0TktkfsbNWCAHJnP+9gDXrGxsjQC
 qwMX9d7kS9ypzZibESBBh+TyUPry+MccayFXXo74KVNhS/5OiOVfLfGXY9eG/eQbqdQb
 FKMg==
X-Gm-Message-State: AOAM533kcdeX8KnTWOroWDkbKtCIVAIZPqjAmAEFuUNETb+sLRYZxFCG
 QiQyyJMkT2yWAAOGHduOkPg=
X-Google-Smtp-Source: ABdhPJx0dk/O5UfJ45rshBk7n2a6r7KpML5v6GQOoxGI9+HwAlhbXAPHpfSEUkgTBUN9/TrFv4seIA==
X-Received: by 2002:a92:98c5:: with SMTP id a66mr272692ill.50.1603118781405;
 Mon, 19 Oct 2020 07:46:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b34d])
 by smtp.gmail.com with ESMTPSA id c9sm11840964iow.1.2020.10.19.07.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 07:46:20 -0700 (PDT)
Date: Mon, 19 Oct 2020 10:46:19 -0400
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [RFC v2 02/18] blkcg: Added a app identifier support for blkcg
Message-ID: <20201019144619.GC4418@mtj.thefacebook.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
 <1603093393-12875-3-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1603093393-12875-3-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_104623_388494_3572E9C8 
X-CRM114-Status: GOOD (  25.86  )
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

On Mon, Oct 19, 2020 at 01:12:57PM +0530, Muneendra wrote:
> This Patch added a unique application identifier i.e
> app_id  knob to  blkcg which allows identification of traffic
> sources at an individual cgroup based Applications
> (ex:virtual machine (VM))level in both host and
> fabric infrastructure.
> 
> Provided the interface blkcg_get_app_identifier to
> grab the app identifier associated with a bio.
> 
> Provided the interface blkcg_set_app_identifier to
> set the app identifier in a blkcgrp associated with cgroup id
> 
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> 
> ---
> v2:
> renamed app_identifier to app_id
> removed the  sysfs interface blkio.app_identifie under
> /sys/fs/cgroup/blkio
> Added a new interface blkcg_set_app_identifier
> ---
>  block/blk-cgroup.c         | 31 +++++++++++++++++++++++++++++++
>  include/linux/blk-cgroup.h | 22 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 619a79b51068..672971521010 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -546,6 +546,37 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
>  	return __blkg_lookup(blkcg, q, true /* update_hint */);
>  }
>  
> +/*
> + * Sets the app_identifier field associted to blkcg
> + * @buf: application identifier
> + * @id: cgrp id
> + * @len: size of appid
> + */
> +int blkcg_set_app_identifier(char *buf, u64 id, size_t len)

Can you please use a name which is more specific?

> +{
> +	struct cgroup *cgrp = NULL;
> +	struct cgroup_subsys_state *css = NULL;
> +	struct blkcg *blkcg = NULL;
> +
> +	cgrp = cgroup_get_from_kernfs_id(id);
> +	if (!cgrp)
> +		return -ENOENT;
> +
> +	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> +	if (!css)
> +		return -ENOENT;
> +
> +	blkcg = css_to_blkcg(css);
> +	if (!blkcg)
> +		return -ENOENT;
> +
> +	if (len > APPID_LEN)
> +		return -EINVAL;
> +	strlcpy(blkcg->app_id, buf, len);

Shouldn't the cgrp and css be put before exit?

> +	return 0;
> +}
> +EXPORT_SYMBOL(blkcg_set_app_identifier);
> +
>  /**
>   * blkg_conf_prep - parse and prepare for per-blkg config update
>   * @inputp: input string pointer
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index c8fc9792ac77..5bd3f9f397ac 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -30,6 +30,8 @@
>  
>  /* Max limits for throttle policy */
>  #define THROTL_IOPS_MAX		UINT_MAX
> +#define APPID_LEN              128
> +
>  
>  #ifdef CONFIG_BLK_CGROUP
>  
> @@ -55,6 +57,8 @@ struct blkcg {
>  	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
>  
>  	struct list_head		all_blkcgs_node;
> +	char                            app_id[APPID_LEN];

Please use a more specific name and gate them behind a CONFIG.

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
