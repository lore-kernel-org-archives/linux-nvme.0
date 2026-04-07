Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14301FF513E
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0Rb6Syr+uyB0QHqFMGe8rTCN44fF3340UUGjzkUSv8=; b=nPYeY51WJkIVdVMWThICgkeyOA
	kCL3e/XLtkeZZbd6bbGTmCS5xhf84NY4DfOhRRaAffCKm1rzrkF6wWiVMbkZJcVMwGuVRNrxHIM59
	4dDyRAvNLO0SFFVFAqM3OUdKhw7nZWypMZmub/7EuA6JRz3ZPknvQQdk7ulP98Nle94DWyZcAWjFz
	zV7zWr80/sazBQr6jO4aqvU6Zj3xoI/Pq1zg1FM+o6KAfsMcz6d8dfOqA1AQXjfPSWeziCrOaQrZ5
	C149Dbeo14MivGd+HnQl+H/Bb40PXn9L7HDWGIIbq5kM9GO9i6uGNAx0qE9yFMVlo/CuCaMWoSoSf
	zEdnmMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wADK8-00000007nvi-0nrW;
	Tue, 07 Apr 2026 20:47:00 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wADK5-00000007ntb-09Hh
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 20:46:58 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-12c1a170a50so1108536c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Apr 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775594816; x=1776199616; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0Rb6Syr+uyB0QHqFMGe8rTCN44fF3340UUGjzkUSv8=;
        b=CI7w6mqVzRJkf+0RlqoiGpZN/gaw1gFxZFxke7Kx9MWMqv8FE2Q/SgBVoCjLTKNrbr
         GW3+o3z2JGcv1njtZGteGf8WExz55ZxCgyfxZyUJ61la5NsQMH/eEG7hswSL+qp8TBpN
         /zoNAfyxoEqaG6+U+oHUmALFHqEcF62Bps+FBSMDl52SEbfhfrr9dTQFrez5C5emQsE3
         os27j7jwevlbpU4AHhSYL69GAHK8Aa+NPuzFfge0n88mHyHHwAQlz4SW8hjJImKNg/tv
         qgbKT6OF11JwMf+uf7uV0P3KpD9irYJ2D9P4fevL4h9qEiiCqBkfmnqkJ/RnAQVV9IQL
         uiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594816; x=1776199616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0Rb6Syr+uyB0QHqFMGe8rTCN44fF3340UUGjzkUSv8=;
        b=KzZuWGvNVW+ay+C3CXJ4Y8PmuFBNGsbxHoyxfSBOkSRbpTh6emsovZWdC3F7fT+OF+
         99vXfCBqJK0II0nHMbwcYWsW5OOHBwHYEVoz8rVa5mWq1+iwq4LIOPKfw8ORmfhzdLRq
         0FPloKV2BWy0nVyD13BuM7lt1TQFLFbQCZx2Lsz9F6tqv+NWvzzvW7JuK2fb8DQO3TIZ
         j/QiV1u4JXM7CVD9kZVYs6tR1z5IzRH4my/m5NDAhWNdKqL4GUoyH9D2oA8OClxQ2Nfg
         U01xZvTarftHAmJS/Nrc9HEfowOuh1YQKb4bWzs9rBynpEd5K6EExIRHl8hNYbFgEsV2
         4Xag==
X-Forwarded-Encrypted: i=1; AJvYcCXyd+mHIY7DfM+99XhV1vHdW3PoPUsmu3fevHXqNY3E1g/XrxKdjxf6C1IK7v+p7lFUIqCy5lY7ZJW4@lists.infradead.org
X-Gm-Message-State: AOJu0YxGdolVueRSmjw6vdp+3uTv3cfp3NgJALN/NmEJo/lL7rt4YIwS
	NZALHHV8F/jLN1AEmDw64//YhhioHg3wmWuNmms+Mvz+fSNevJ4Piv0kOWLVvepG1Ag=
X-Gm-Gg: AeBDieutPRFFI3IO7xYegaUUtKYIp1bl5OL66tdr8gOClaCejuwoDk/oFM29ojFrE/2
	OQ819QFHsSyerMCiZNN+tDkE7mn2gKSzXTuBR1tO3OgGRxlGMoF+LiZnHW8sKWdriBx2K2Xb0jr
	zAnTDB9UhQC7uMKZMUmc/lghH+1onzkz8mXnsp1tdm5F4tawkTUiitKmSth4sewAHlhiHR8ESwZ
	i2uHwN0dTxyg1dQ1QKW4Q7WJ9gi3rD8I76/1Gid5hzkgh6n+s7CYBXsbuxBHd3suk3DhEl+JKW9
	gIQArtLlxi/WVSmVEFdxGXHpylfdXTL8JafpQkoEFIwLNWC3OOudl5gPAxdVr6FToubUoRP9dtY
	BAfuSoWu6oSpe04+3XaCFdq0k6dZ9+gLfygQwHk66I8B/pM0YM7sF4dvR4LG+1OYFfYceZ+RQu1
	ojx7HjX29TJqECfA9sA/MhbeJIaTCr8AE5s1HLMYcTaA4u
X-Received: by 2002:a05:7022:e23:b0:128:ca83:5aa1 with SMTP id a92af1059eb24-12bfb70eee8mr9003118c88.16.1775594815694;
        Tue, 07 Apr 2026 13:46:55 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12bed93f861sm22095867c88.0.2026.04.07.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:46:54 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:46:53 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
Message-ID: <20260407204653.GG2861-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-9-mkhalfella@purestorage.com>
 <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
 <20260331164733.GC2861-mkhalfella@purestorage.com>
 <5d3fecf4-9101-4028-858d-bfbbccf3d8d3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d3fecf4-9101-4028-858d-bfbbccf3d8d3@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_134657_107299_303A66ED 
X-CRM114-Status: GOOD (  28.62  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue 2026-04-07 07:39:09 +0200, Hannes Reinecke wrote:
> On 3/31/26 18:47, Mohamed Khalfella wrote:
> > On Mon 2026-03-30 12:50:24 +0200, Hannes Reinecke wrote:
> >> On 3/28/26 01:43, Mohamed Khalfella wrote:
> >>> A host that has more than one path connecting to an nvme subsystem
> >>> typically has an nvme controller associated with every path. This is
> >>> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> >>> path should not be retried immediately on another path because this
> >>> could lead to data corruption as described in TP4129. TP8028 defines
> >>> cross-controller reset mechanism that can be used by host to terminate
> >>> IOs on the failed path using one of the remaining healthy paths. Only
> >>> after IOs are terminated, or long enough time passes as defined by
> >>> TP4129, inflight IOs should be retried on another path. Implement core
> >>> cross-controller reset shared logic to be used by the transports.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/constants.c |   1 +
> >>>    drivers/nvme/host/core.c      | 145 ++++++++++++++++++++++++++++++++++
> >>>    drivers/nvme/host/nvme.h      |   9 +++
> >>>    3 files changed, 155 insertions(+)
> >>>
> [ .. ]
> >>> +
> >>> +int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> >>> +{
> >>> +	unsigned long deadline, timeout;
> >>> +	struct nvme_ctrl *sctrl;
> >>> +	u32 min_cntlid = 0;
> >>> +	int ret;
> >>> +
> >>> +	timeout = nvme_fence_timeout_ms(ictrl);
> >>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> >>> +
> >>> +	deadline = jiffies + msecs_to_jiffies(timeout);
> >>> +	while (time_is_after_jiffies(deadline)) {
> >>> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> >>> +		if (!sctrl) {
> >>> +			dev_dbg(ictrl->device,
> >>> +				"failed to find source controller\n");
> >>> +			return -EIO;
> >>> +		}
> >>> +
> >>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> >>> +		if (!ret) {
> >>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> >>> +				 dev_name(sctrl->device));
> >>> +			nvme_put_ctrl_ccr(sctrl);
> >>> +			return 0;
> >>> +		}
> >>> +
> >>> +		min_cntlid = sctrl->cntlid + 1;
> >>> +		nvme_put_ctrl_ccr(sctrl);
> >>> +
> >>> +		if (ret == -EIO) /* CCR command failed */
> >>> +			continue;
> >>> +
> >>> +		/* CCR operation failed or timed out */
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	dev_info(ictrl->device, "CCR operation timeout\n");
> >>> +	return -ETIMEDOUT;
> >>> +}
> >>
> >> Please restructure the loop.
> >> Having a comment 'CCR operation failed or timed out',
> >> returning a status, and then have a comment
> >> 'CCR operation timeout' _after_ the return is confusing.
> > 
> > I can change /* CCR operation failed or timed out */ to something like
> > 
> > /*
> >   * Source controller accepted CCR command but CCR operation
> >   * timed out or failed. Retrying another path is not likely
> >   * to succeed, return an error.
> >   */
> > 
> > And change the log line "CCR operation timeout\n" outside the while
> > loop to "fencing timedout\n".
> > 
> > Will this help?
> > 
> Yes, thank you.

Will do that.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

