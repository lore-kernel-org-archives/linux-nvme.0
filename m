Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B96CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 06:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7yDeCbKK7RJMvZiIVbGogXmcuCznb6lg3vpgldc7l0=; b=luPGmNX7sEgDsY5uPdLd8YMelB
	0Jeu4QWc6Rea2nr+7Vkz3Cq+iNZUY+EZCZQU39wLjujm5l415fF3h+M2EjJ+IOm9OXYhdHKJoVobA
	dQK2aEHAC7ymGLCAU3/EvA6F6cIF0JsSJb1Z02oDSUfRUwUvZqCNrXLTK3GOYrE89+VEkPMnLSPCq
	RtclLBgXrJVXunuk9T69MlSEWldVPIoK4m68uPn0vZPwuBLfhIHn1D6l0sspn61npJra4Y1OioWXB
	s+3kJnb6N+kbHBH9a7t+NSFeFlZDTZkNVZT9af9LW7GO/+FoNT2xM57AWDwvmO2PSXDCZIfN0kg2Y
	dHkeRmAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtM6c-00GS3d-2v;
	Thu, 19 Oct 2023 06:02:02 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtM6a-00GRzB-1j
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 06:02:01 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4919610b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697695316; x=1698300116; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7yDeCbKK7RJMvZiIVbGogXmcuCznb6lg3vpgldc7l0=;
        b=QKXysCLeh0QWd4KGyAAI3cj8Ft/kDPMi6BYanYQK+m3OtZpqtrekdSKohBSW6CbMgZ
         0iHzgDpwubbp4JpdBrbIC47EKFiN0vLobocoxtXFTTgnDyDo2/uiXODZ5r6IPo7BiiND
         x8pUe94vCHqI+6REOO0Ci7CmQyhhktBEHXqWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695316; x=1698300116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7yDeCbKK7RJMvZiIVbGogXmcuCznb6lg3vpgldc7l0=;
        b=VHcLDVpdqqjue/m4WoCm9p9yz8ac17i5OTrKfP6T/T0JThwZbR3G8ENI8gJzs+dFLX
         /s05fZH0dpzVPXD3DBe/URDND4TxX7o9RcAFJxdsLKI3gfru0u4+dpIwkxNnVEVcfCOT
         IT/Ow9IkEBvsUAC1c91CyAKAV4YeVzPWAfYGGT6JkCHpfkM9LcHai5HwzD21zxwrkZsx
         plue28MwZCDpzzVIdTwpnS1kIUs6DHq+hKxv+1Y3KmtjxUJnO9HIjbkdSJleVK1p3EoZ
         5OG2N0sHWQinpa4cHf2XmGoppzNDZcpZLJvla80Mt5MH5Xki8VwJJV+uRG7UWoTQ9LyJ
         irVw==
X-Gm-Message-State: AOJu0YyzLy7k20vrB33K5yIPFu1its5X5xqfQDvYl6e8e1ZqNbEbMfqq
	L1A0cxQGKxW5W66lK11zA0Qypg==
X-Google-Smtp-Source: AGHT+IFscLXN1xjak16gaHb4xEL+yenHdprgdAzW4lIxpVAmm+HGFxqot9MJirUqe2eamHFP5LRRhw==
X-Received: by 2002:a05:6a00:cd6:b0:6b8:a6d6:f51a with SMTP id b22-20020a056a000cd600b006b8a6d6f51amr1126768pfv.31.1697695315885;
        Wed, 18 Oct 2023 23:01:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b006933866fd21sm4291678pfk.117.2023.10.18.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:01:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 23:01:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Stitt <justinstitt@google.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310182248.9E197FFD5@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019054642.GF14346@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_230200_592160_1C3635E2 
X-CRM114-Status: GOOD (  24.78  )
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

On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> 
> If we want that we need to stop pretendening direct manipulation of
> nul-terminate strings is a good idea.  I suspect the churn of replacing
> one helper with another, maybe slightly better, one probably
> introduces more bugs than it fixes.
> 
> If we want to attack the issue for real we need to use something
> better.
> 
> lib/seq_buf.c is a good start for a lot of simple cases that just
> append to strings including creating complex ones.  Kent had a bunch
> of good ideas on how to improve it, but couldn't be convinced to
> contribute to it instead of duplicating the functionality which
> is a bit sad, but I think we need to switch to something like
> seq_buf that actually has a counted string instead of all this messing
> around with the null-terminated strings.

When doing more complex string creation, I agree. I spent some time
doing this while I was looking at removing strcat() and strlcat(); this
is where seq_buf shines. (And seq_buf is actually both: it maintains its
%NUL termination _and_ does the length counting.) The only thing clunky
about it was initialization, but all the conversions I experimented with
were way cleaner using seq_buf. I even added a comment to strlcat()'s
kern-doc to aim folks at seq_buf. :)

/**
 * strlcat - Append a string to an existing string
...
 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * read and write overflows, this is only possible when the sizes
 * of @p and @q are known to the compiler. Prefer building the
 * string with formatting, via scnprintf(), seq_buf, or similar.

Almost all of the remaining strncpy() usage is just string to string
copying, but the corner cases that are being spun out that aren't
strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
and memcpy(). Each of these are a clear improvement since they remove
the ambiguity of the intended behavior. Using seq_buf ends up being way
more overhead than is needed.

-Kees

-- 
Kees Cook

