Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA3AC3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 01:32:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6445720866
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 01:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJIUXKwl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="B6FDQgsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6445720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dNxnODpz4jr/gX/nGZknFdu0JTID5RF435Egmq6Bnew=; b=KJIUXKwli7KJY5
	B+PJXEzrX/q/AnGYhy+TYjFzHkikKzV+MieGpQgj9BdT7y/01B94/9g6OAdmY6tAL/JYdacLuXEa8
	WJmwGIoafYJ6hWB/t7GHvf6l8QdAsCuui22EWB25lwrlP8xk6stVaaB//ieFqOvbsZo6CcA6otsYl
	vqBSd51rOcoRLaWeyy0I6RQM9zjXcLaARxEX0POgtkuYz6gq02hODO8dcb79+gh3U9BzxOZ3SdJUg
	aUml7ycaYZZoqOvcrXIz3LqfNLYFDzzg25kqWkgiaphESpJWjvVi261JIxGpauJ8wbJ+SmHQEC3GC
	Aheix8/qUovOcg/YXkIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9fNW-0000u0-BB; Thu, 05 Mar 2020 01:32:46 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9fNT-0000tL-Bz
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 01:32:44 +0000
Received: by mail-pj1-x1044.google.com with SMTP id l8so1756211pjy.1
 for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2020 17:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nwxPFZEgGm11LzXMpujG1wPjJC/1DwOKVtUkVXRUzU8=;
 b=B6FDQgsc5Di9w6Ee/h4bm0Vqvi19NC4Z0jZ9Xyw2MLAxzFadmBUrK6O4p9PAKl+CMw
 QGWF2PsP3DT73Lx11XKs91hR6qg1sf5U+IgLb6cZo2lGbc9u5NZ+5F6Xp9ZifB+I0sbI
 8cNkgrOaS5xtjkUQG1/Ati3fPt7SOmJuoMvvVYtQ6RPGDBhBjTi+q9To7wG1rsTiaq00
 T3zUbouArrMUSBaWrpYtL/Uw9hPodXEDtvzXQw3aNuRzyOujO8WnZLeLoPOwGmA9AmKR
 kFjw+HRjxGAC4iMm8UV1zWhsqFV4JH27U65n6fZHxeCGazUgasKAGdExG5HKCQ+LLQeG
 TzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nwxPFZEgGm11LzXMpujG1wPjJC/1DwOKVtUkVXRUzU8=;
 b=fOgxh0U7ELtWbQcPWkaZJy8TvMKoY6MOzd9t3K4hXhB6Ye7jSj/BTiFymER6afUPVN
 DFr/FdQ4U2xM+HkvBb1QiyAyDhqV60u6axUOm+NrZclscDP2uzzzMsGWw+Hl5yXovfXB
 k4GTJdbukLlk0lRdZv9/7W09FMsyoWFhiw1JdraIasAhPMQnXQwFDAGSyEa1LjsMe7h2
 1YJGsyJUEjWu6GXfbJ+BmSVzUBZV3nx9GiK9qAVEVB5NqbK26U5s3DbYGuVRQK7EFOqg
 y3MKTkHRZpIByiazF/RfI/NDtrCzn+lOOuisALjoqHQneLsKvEIOROdDBNNJhDY8+uwV
 fXwA==
X-Gm-Message-State: ANhLgQ0hobdFU0nXQ9BRr1XH1DyUyxP/alSoGzV0TwIny7gv3SjOVXqk
 sav1KPERJfU3XjX4tTZoMk7y0A==
X-Google-Smtp-Source: ADFU+vtElY8w+ZmRXAghnthJ3g79718sNeIGHlH7lBnBlLwJwAqVpwiunF08EKg8w1kzRgIkAlMuJg==
X-Received: by 2002:a17:90b:3586:: with SMTP id
 mm6mr5714748pjb.147.1583371962448; 
 Wed, 04 Mar 2020 17:32:42 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
 by smtp.gmail.com with ESMTPSA id 188sm25812591pfa.62.2020.03.04.17.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:32:41 -0800 (PST)
Date: Wed, 4 Mar 2020 17:32:41 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests V2 1/3] nvme: allow target to set cntlid min/max
 & model
Message-ID: <20200305013241.GB293405@vader>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
 <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_173243_413015_73B1B7F4 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: linux-block@vger.kernel.org, osandov@fb.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 05:38:29PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced model, cntlid_min and cntlid_max attributes.
> Also, this adds SKIP reason when attributes are not found in the
> configfs.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 40f0413..e4b57cb 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -121,11 +121,36 @@ _create_nvmet_subsystem() {
>  	local nvmet_subsystem="$1"
>  	local blkdev="$2"
>  	local uuid=$3
> +	local cntlid_min=$4
> +	local cntlid_max=$5
> +	local model=$6
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
> +
> +	if [ $# -eq 5 ]; then

I still don't like that we ignore this if we also pass the model.
Instead, just make this

if [[ -n $cntlid ]]

Then the caller can pass an empty argument if they want it ignored.

> +		if [ -f "${cfs_path}"/attr_cntlid_min ]; then
> +			echo "${cntlid_min}" > "${cfs_path}"/attr_cntlid_min
> +			echo "${cntlid_max}" > "${cfs_path}"/attr_cntlid_max
> +		else
> +			SKIP_REASON="attr_cntlid_[min|max] not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
> +	fi

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
