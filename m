Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 18:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1116360FBF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 18:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1116360FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1CYgFFFu6kGFqRf913SrZ8xkzBJqgma5gON8R05Pj2A=; b=CHJyHxnEctFOOb
	fnLhyNazTWwXU4c7vV80jUuz0vJAdLjbauCJvcMc3PSlufPaAyzleIxUmzDjvwufkS0DL5Y7TzXEC
	HvNrTmgdKg2/54LdLrSVqDUEDi2SQ+iEUQKsXtm5geGWY6CcXy4haZKzEitLs/QC3hA3RMQz8gn3u
	bYZaxLe4bJOy/vOnABwQIgsDBGP58xzGnI0DHMznwmcmqpfJbv1hcbptF7VdpA9eo9XwZCKEcSNT7
	6IYweoOpKFM+n4KEvGe9D90aNW34mZKur2ItGXljautGO2AY760QNg9jN5O1+DI6r+QpOV7GDA3SX
	ikNNep9Wsqdc/4/WiXBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQZwA-009ivV-3D; Wed, 15 Sep 2021 18:47:14 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQZw6-009iv3-PE
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 18:47:12 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 nn5-20020a17090b38c500b0019af1c4b31fso2890093pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SIWKZlon0kVVHDjSqUrAEDCIPd5swua31Z2cKyzZPb8=;
 b=iZtw+V2XmE2Jqg+Iq02Slnjco0vhgXwhxauMxKgS6sf41tYdogk6ms5rHdgvqHqF47
 ECXBtTCBXqsP43qBIEbYen4SuCQWjdeEIqllNmXvNK4R87X5VSUx6qfekBPMb/wBL89e
 GqiZWwQs2lw8Kquxzvk7xrVGBgjaKYuYFl8rEoEUxFYWU6U8grwYhw4TJwBHKC3w/V7K
 Y+TlPP6KsjQb4buy/L44LS31CfCsRjjvuFGnzknkLjK4kKPRv4fbi7esuQDFK8mKLr2G
 rhs3kYV2NCwJ3WK0Yf8IG7cSTs3G/M/9v85KHMXPtMuH0I9vvU985gpxAr6dn4pV2qfq
 gWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SIWKZlon0kVVHDjSqUrAEDCIPd5swua31Z2cKyzZPb8=;
 b=5aA3/TZ4BT/0d9I3AZBdSXS1hUGoyHinyIMUcxIT3wWSQrCz1UdEKaWdYiHG2JSGUF
 H8ljD5S9RsbgDUzyk6VwW0uHStof3LLETqTYbgd1ZcxRLM8jlzsnanXO0FZKo8kIoVGy
 zbHTkWxn8GM3gUaYC/RCJZ2Fwa+Q2b8QBNWkIesM7PNEk3i4gDDfw+KLisx8rAMHlvrk
 zr8BAy/Gmc61F4tBa2fs7AT1NEr31sIiyDbz3HuJYZpYo8ybkngcJCxfCqnHe2eLJaPP
 SQzzaFKXUhHE5Z/DNpRFD21SIozcwxWppf7dmGO+T9MCyXt6eADOwIqFEUVhxjh3jdMB
 0iug==
X-Gm-Message-State: AOAM530sHTG4qusnj0AODSj1sSCET8LQYTnpgXfhQAViPUUhqBMa/cT8
 CUs+D49vylta8HIJzC3Q9Q0WzA==
X-Google-Smtp-Source: ABdhPJz+H94oA3slDbuEtmrnuHQD9IxxbVVSy9ZTjnsc85lJzqK0BjRvFA6TfA92/3cDjHMxzafoZQ==
X-Received: by 2002:a17:90a:198b:: with SMTP id
 11mr1281906pji.209.1631731628724; 
 Wed, 15 Sep 2021 11:47:08 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1a3d])
 by smtp.gmail.com with ESMTPSA id r5sm379201pjd.13.2021.09.15.11.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 11:47:08 -0700 (PDT)
Date: Wed, 15 Sep 2021 11:47:06 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvmeof-mp/001: fix failure when
 CONFIG_NVME_HWMON enabled
Message-ID: <YUI/qlrbFw6Q89BD@relinquished.localdomain>
References: <20210912120336.6035-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210912120336.6035-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_114710_911476_1DF5314B 
X-CRM114-Status: GOOD (  16.67  )
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

On Sun, Sep 12, 2021 at 08:03:36PM +0800, Yi Zhang wrote:
> Skip checking ng0n1/hwmon5 in count_devices
> 
> $ use_siw=1  ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [failed]
>     runtime  3.695s  ...  4.002s
>     --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
>     +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
>     @@ -1,3 +1,3 @@
>      Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 3 <> 1
>      Passed
> $ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/001 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
> index 69f1e24..3c3e8d5 100755
> --- a/tests/nvmeof-mp/001
> +++ b/tests/nvmeof-mp/001
> @@ -11,6 +11,7 @@ count_devices() {
>  	local d devs=0
>  
>  	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
> +		[[ "$d" =~ hwmon[0-9]|ng[0-9]n[0-9] ]] && continue

I'm not too familiar with NVME_HWMON, but presumably it's possible to
have more than 10 of these "ng" devices. Should this be ng[0-9]+n[0-9]?

>  		[ -d "$d" ] && ((devs++))
>  	done
>  	echo "$devs"
> -- 
> 2.21.3
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
