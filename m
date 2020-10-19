Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A0C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D6724658
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTeIqyVj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEOb/ar3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D6724658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3/9+LDVvQC4kIAbgFpF1n2wl6iVCT6OSxJP8QqzIQzE=; b=fTeIqyVjiCCcHp+WdzIWMhWlG
	+ESGSa/0qRWCf+HXGan9TEfbC/Bj6Mxq/WGxYXAIc2s9sDwatUW8/5/vkggCBrMWviaHd5OUcLeAS
	xB6XSnfZw23VmgI5oTaTCa04xEff6OuJbjf6bziX8iOUYdjxQNCI0d6pabNw9N2pbv8x3xbKuTIEU
	ZMuPVALOzdhCkMSzclFJT7vq0S/CSce+t5aJ67vcqIFo1iZsfML5v6OIO0ddMI5PhXH9inYA4x0Tf
	hNqeZHiuiVOHQ9Mf0LrTbNuwwQOo6OXheMn6xQXC5Zwdr2elJsb8zvWlxtHUQNjnPZtHmq77OcbxJ
	y7ajKvxdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVjCf-0002Yj-9c; Thu, 22 Oct 2020 22:37:01 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWNe-000484-KS
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:43:23 +0000
Received: by mail-io1-xd35.google.com with SMTP id 67so13218076iob.8
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UCIZcpV4okvtyvYLzB1AmMBudnMlsV1FmyZ7pm2zTZM=;
 b=hEOb/ar311KnaDTM2UMZcagpOXRn4M9EnHw6EnMBRarVUEBULXRiZBorpjbqcHGTn9
 rduZHFGftKVr+E2mK9daTTm8SYZzi/6ukVR1Yla5A/UzIRPZDRmfuaohch8WTR41/hhM
 UOl/4AXIf0VwfqoZyk/qlVCjQnHOTZAowabUKBQ5yR5d6CHb9St4aNXOfMuZN/cYuMNH
 3bYZncmF1jzG2se0rPWF24LzaIVleRK41PuaP8elAUcvxCRLtGB/SFiVb+bw4GPZQ4BG
 IHoWi000w7FZzHuBwRGw3tFMH7wQzGCXAbrrWSzy1RdxHCCltlG8P1gNjXnRJDI7RY2R
 7Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=UCIZcpV4okvtyvYLzB1AmMBudnMlsV1FmyZ7pm2zTZM=;
 b=C9cotw2c8j664UBMcfaiBgymmGQp/5DV1FIoZdkC3lHYTaUyFKRxYzOubKOYuw/sRp
 1fBrqVvvOR+aRqzGH84GAw3odgyrqLYK3W1U9uDmlT7mTbtEST2P4FiPRG/k6eqGvWDE
 SPvHwdRczJEfo0oF7jSv5+L+pZGvJyMUYsR4Rdsk3HrVFi63PIx3SqUwEc7IbufjsTWr
 mUHO9yg8uzIYD9fo5YQ60M2aYAcqN0Neol9WY7XYMaJUUxCP0LLvlg/NuQJhsjYNvS91
 CwZv0tpXRdDqgtC4RkwgNaapB6T4lc5fQuJc6PZWUXsMh+Pl7M24uIuwjk/+M6YmI/ER
 kKRQ==
X-Gm-Message-State: AOAM532J7fqbuxxhmi8fLGdx/0dzewITozaCEfq61anhkSXQkld5WpS/
 uZcaiUwOxpH2Q61yKpsTZPQ=
X-Google-Smtp-Source: ABdhPJwauXxkY1ronpAbuNbxWn5kAEPQu5M79XYCEJ2roZD7e5xU0VmJkeLiK1igK8SkXTpa+ubLxQ==
X-Received: by 2002:a02:cb0c:: with SMTP id j12mr238199jap.54.1603118598865;
 Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b34d])
 by smtp.gmail.com with ESMTPSA id n77sm12450163ild.10.2020.10.19.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
Date: Mon, 19 Oct 2020 10:43:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [RFC v2 01/18] cgroup: Added cgroup_get_from_kernfs_id
Message-ID: <20201019144316.GB4418@mtj.thefacebook.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
 <1603093393-12875-2-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1603093393-12875-2-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_104322_710176_A2F3D90A 
X-CRM114-Status: GOOD (  13.13  )
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

On Mon, Oct 19, 2020 at 01:12:56PM +0530, Muneendra wrote:
> Added a new function cgroup_get_from_kernfs_id  to retrieve the cgroup
> associated with cgroup id.
> It takes cgroupid as an argument and returns cgrp and on failure
> it returns NULL.
> Exported the same as this can be used by blk-cgorup.c
> 
> Added function declaration of cgroup_get_from_kernfs_id in cgorup.h
> 
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
