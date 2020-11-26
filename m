Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA18C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:31:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B1020B80
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="16mY1Lm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B1020B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n46Bhl3IIo4cnU10Ph+HZaIm7JoBp15hiAAFzII5tUE=; b=16mY1Lm9AlouaG74zrtlVkS5z
	Rrd+AqviIBSZ+mioRBEfIPConM90btcAiqDjQhzYSQfg2xyBsV48sseWVbj93cwU3s+uevkz4ghxc
	H8GTZe5qsHhYbu2R70LgVceatmVKMBvbIm9UKexwb5sgmn4Z/PVxoci8j4zAn5h3b5iiYqi01Rcms
	lfAK7JpBGUtixB11OK0RgBakNIDiV54QuxzL36MELj7XQlgUQHaC2WRjxmj6CIuUsxn4GTvHa0vxF
	TTVp2USFMpEFqklevvjaURbupKC213WC93JRWd4loZ4pZYtXRi/13uDpzN8qHKGak9GRF6OVOrWTO
	9yq3XtFeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiKBC-0008U8-4k; Thu, 26 Nov 2020 16:31:34 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiKB9-0008TZ-LQ
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 16:31:32 +0000
Received: by mail-pl1-f196.google.com with SMTP id l11so1380676plt.1
 for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2020 08:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sAd42amj9f2C4mx3yl4ovRpJPs9IZ4Qy5bcEqP84rIE=;
 b=BbwGXNIysNy+ksGyXGboYSAPvWTh7Q1tGzCPoz5Pz2CBTAhBwTZlLTACjO1ZbqDLjn
 Id0vGOIkAHzfxEUM/Loq4bLQ0l2uJ1lwU2U+t0IyPLV61N5boAZb63Bz4W8sS0XjgCrc
 C6+HwX2OKGJoh40KXIxNT9BQYdyaHONd+bON3hD/b/Nd9kwsYnSi7pX8IYZ8J8asGFYQ
 +zLChCd5L6lhRxxZFyp4tL6GFPQgCscgCfW86XN2g6bu1Gks+MV0aIR7ItPENFumUf/F
 c0ZHSGx08GLs8qyB3DgXMtPfE2s/faeGzykeuoIkqDG/uhGuSUsv6mFi4UFgv5ZJP/Wr
 K+hg==
X-Gm-Message-State: AOAM531jR9p3pVSlu9hwOpUYhH1pJmn5PWUiQ6rVVCqxCF1k44jOYIKP
 GJ4s4WFL+/F0/6KUdG8xWQQ=
X-Google-Smtp-Source: ABdhPJwvA6zWhWW27udzLt0xEIbgV08WY9y94+8iULd9Hs3laDqPTrcBYmuYz6EM5F9CHTBg9JTVxw==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id
 x12-20020a1709029a4cb02900d6a250ab9fmr3389313plv.20.1606408290007; 
 Thu, 26 Nov 2020 08:31:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id h70sm5273090pfe.49.2020.11.26.08.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 08:31:29 -0800 (PST)
Subject: Re: [PATCH V3 blktests 5/5] common/multipath-over-rdma: allow to set
 use_siw
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-6-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <86b955bf-6714-0739-3601-d290db8cf04e@acm.org>
Date: Thu, 26 Nov 2020 08:31:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-6-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_113131_907939_4D8C8B49 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/20 12:35 AM, Yi Zhang wrote:
> With this change, we can change to use siw for nvme-rdma/nvmeof-mp/srp
> testing from cmdline:
> 
> $ use_siw=1 nvme-trtype=rdma ./check nvme/
> $ use_siw=1 ./check nvmeof-mp/
> $ use_siw=1 ./check srp/
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index ba6fa0d..b12dec3 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -12,7 +12,7 @@ filesystem_type=ext4
>  fio_aux_path=/tmp/fio-state-files
>  memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
>  max_ramdisk_size=$((1<<25))
> -use_siw=
> +use_siw=${use_siw:-""}
>  ramdisk_size=$((memtotal*(1024/16)))  # in bytes
>  if [ $ramdisk_size -gt $max_ramdisk_size ]; then
>  	ramdisk_size=$max_ramdisk_size

Reviewed-by: Bart Van Assche <bvanassche@acm.org>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
