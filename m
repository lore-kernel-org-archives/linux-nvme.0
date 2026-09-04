Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD33FC79F82
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWMdt4xelSS3XutaBqfp0rye6ojxHME7341jO04CtRw=; b=Z99Cd9QOgv8X0HJRe5UhUKRFng
	+JSbla5holIZQgBb/QhFRfUIiwxjqwikHiA2+l+tjTp7ViGrK7zqkkrmtZk5FZTTqolf9//jiyXr0
	fpLoqVgsgREn4Tv4Rca2VWARCW+H0OBrbaH7k1WHuVpW5lhgqEPjkZu1avVY+elKNY4MlTmPnaM/H
	owcV++o7thp6/O6W7avUwD4yFkiPiZvoI0JQR+jXYVWdLDk1/gEu1KkpYQIO0Syo/dNtsnvYwH4M8
	gB1IcfO11w6GR9Wj8dhHNU5r1oXUxP+Bl3wNA9jVT1WCXDK0JZrvuW5t6lHHfw0kDTNevrfrs8QAL
	EoNu69Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2dBw-00000003StN-0xpw;
	Fri, 04 Sep 2026 23:19:28 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2dBt-00000003Ssj-2a4J
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 23:19:27 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-853e2610bb4so1886521b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788563965; x=1789168765; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWMdt4xelSS3XutaBqfp0rye6ojxHME7341jO04CtRw=;
        b=JtA61taID1FftrKiGtOdJ/CgJqWzXfl9h71Z5o5xO4cNPIphlq6a5du64SxaOQznfv
         /hvrGUgO/NnGthYtT8KHVu1iTWRtqAEPaRvHsQK/GKbXWZzHNPqclpvkibRs42lcNT4V
         lX76kGp0JIIzTmQm7BwFMSf9IOXtqi2uNsDnGgd8/TgjQ2a7W7TWVkqKv7Y/9qqG2c/h
         LizkHbbRaAQhmdGlCtmij1HhhSPxBWNIt4puU0NuzSlkUKVlMekPIqGirAIBbLh20MuU
         hJNpIyNWGat/AjqwNAk5mhIdj0L4uDKbGmEw6EVFGDeZUsCbKfwMCr+HpPJdj3JF1Dj8
         c6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788563965; x=1789168765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PWMdt4xelSS3XutaBqfp0rye6ojxHME7341jO04CtRw=;
        b=I/pRoKRDS5573vSBqbm2TZMe1Din3g9E/wsLx/NBVUioeOE0FAB7RHL3uQXbS1I14U
         MtpL63z9yhGWrair9E+mc9ZVs/a6ALTvPckgLJyf16WTmhO64k0qStjdnDkoMfkOvdpb
         AaeKuBFr5yeGgSDKLtOAeFQ7JnEFBPBiQAc+RkfSmpc32M/r9JQkflaUo1sKqyO7s1VV
         Lgl6ezbcNDjKRXa3zpSYpDn2eBCQ33qsazudglix8+nWJjX8jXLg/yvlTkabDcGU7HDi
         KMHUdfD3OT5VYOFEJx2ovDw1yI2E4y97HwMtnYOtDZsseWlqwGphXuspJZ3n5bUaCliK
         vduw==
X-Forwarded-Encrypted: i=1; AKwUvBz3UVvfPqBl0PORzJJ9KH7p0YFWHkvDtdlzvL1OATZTx1JLIZl44q1AQGULp0QVuemdfDA576zdBdJC@lists.infradead.org
X-Gm-Message-State: AFuF++ngEFYCOdBGRkxLyWEZEqWw94czjxxRrJolM51qaznSF6D9C1bE
	FCql0fTrHqt+17NyOpg35JePLds+7SV039AU9HXpmnzZlX+dTF/mG8Jfm+zaBgBAjIE=
X-Gm-Gg: AYBFou3q2rG+4mzrnZgxbKNdUfa8qakT6BaqIHJTq/C7DjXIw5O+CS9X7VPs9WDOs+I
	A4dEtVrgQ3OAZgxsHR09F/VPfF82MZ4lHycX2JXQRB+t70mRRunvlxVYMvaWhoVrZ5/E+ZWiU38
	9c4BXPAcqa8qSWD4Z3eT+VpRrhNIaubZ2s6+V89kUudzTgZJNf09kRAdzyHbgMxF4xldTx6fdk2
	p3nH8sFbiOJtAD4HsHxc9Gc6lehS5QM5p1hjn/P5xyuvbmDxr71aTAemmT45aWjOhvVZhPv1rLJ
	R2TnwJe77KKC9DecQ0FDbvpbRAkkKDnPIl16Oi59fafDbGqFu7kS2GrI6jyKHmgVl/s7neVjMkc
	W7lFKN/xQce667gOg6HOYBIhl+bMWD+qLH06kqzd2l+LoF7zvHRBhJ689x5jdzMS/bNIuahWGWJ
	933xqxIZjLvzuRzvqwvvwkYtALlyhg2Zs8+Ky+v/k8+gQfn1w8gu5n1R92szEFtXySrgs=
X-Received: by 2002:a05:6a21:7117:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3da215aacc4mr17994990637.17.1788563964413;
        Fri, 04 Sep 2026 16:19:24 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm8818568eec.9.2026.09.04.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:19:23 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:19:22 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/16] nvme-fc: Refactor IO error recovery
Message-ID: <20260904231922.GF5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-13-mkhalfella@purestorage.com>
 <da754227-87f9-44b1-926b-9b3b6ead6e19@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da754227-87f9-44b1-926b-9b3b6ead6e19@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_161925_669084_FC4537C8 
X-CRM114-Status: GOOD (  20.98  )
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

On Mon 2026-07-13 09:29:44 +0200, Hannes Reinecke wrote:
> On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> > Added new nvme_fc_start_ioerr_recovery() to trigger error recovery
> > instead of directly queueing ctrl->ioerr_work. nvme_fc_error_recovery()
> > now called only from ctrl->ioerr_work has been updated to not depend on
> > nvme_reset_ctrl() to handle error recovery. nvme_fc_error_recovery()
> > effectively resets the controller and attempts reconnection if needed.
> > This makes nvme-fc ioerr handling similar to other fabric transports.
> > 
> > Update nvme_fc_timeout() to not abort timed out IOs. IOs aborted from
> > nvme_fc_timeout() are not accounted for in ctrl->iocnt and this causes
> > nvme_fc_delete_association() not to wait for them. Instead of aborting
> > IOs nvme_fc_timeout() calls nvme_fc_start_ioerr_recovery() to start IO
> > error recovery. Since error recovery runs in ctrl->ioerr_work this
> > change fixes the issue reported in the link below.
> > 
> > Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/fc.c | 119 +++++++++++++++++++++++------------------
> >   1 file changed, 66 insertions(+), 53 deletions(-)
> > 
> This is hard to read. Please split it several parst, one with
> open-coding nvme_reset_work(), one with adding 
> nvme_fc_start_ioerr_recovery((), and another one with the rest.
> If that makes sense to you...

Okay, I will take a look and see if I can do that.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

