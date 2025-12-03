Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D88D12D6F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=; b=XP5JML7DHe8Tose2HrHv0t/OEm
	ykQOh2i108GyOM5omCNq9+r55JXEe/9DqkKUair/uJXD1VTXOTMPm2TvzNp8q6W+sC64UNfkHHAFq
	x7E1Vh3pFL2rFe6EoqUs90mS3s4p9YAA3C+CD8ip1g/1ZxRybvYRjKE4c8fC72cIf+/7BltmLXGGN
	DVmspNjrbupj3rtqpL52Kcw/5x9pQ+S/8JZajQTuVeLCrzxiMCrpz2eswVJl5srSic/202qms6Zdh
	HoBRdueIUkcRidrvNVigOwQIshwb1jh+T3KlfBsARAudfl/qfghK1spC4awvQ3Al0XftQW39OlP4V
	7fk439yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQoEC-00000006fTH-1IRh;
	Wed, 03 Dec 2025 14:53:12 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQoE9-00000006fSd-07Wh
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 14:53:10 +0000
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-44fff8c46bbso2085569b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Dec 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773587; x=1765378387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=iPFjJzW4WzP0A9HdWQSzmOYlQpaPlMue9iz4rxvb/s0EDCUXqFSMCulSpr9WpQ6310
         xN6Mgd/Bd1Z3CYQMimo2rns+J7wtNKZNE+etX7JsNPeqi7om7B6UUCn/sC6YlWfo2qh3
         DAqb4TYiKFb7wm/yVCAFK+r0KlbE31gxsFPybUsXVasixhB4Sq3Osd+AIYt8j8a9UB3q
         Zre6PzOWHLwu8VcYJVZA/oD9ITOxlUYyeenDYS5QbULPbIxTgRCEdIncjc72QMzAWKDx
         7xurU97gouveW44xvLfnF1VMiZfntlIx6qeS9a3LqLdtyOc9cN0A8OUVkxsMu3tU3Tqc
         razw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773587; x=1765378387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=udO+Rvt+n+0PRWUfCY3dzdRkcH6+opVpQMbXGxCkshkRvo9RXMPGMLA6QozQwW2iT6
         +KcMzBe27v5cpD9zgEdTkFJ3swxJjrRExqelTjl6J8PvfNfADDxrNXsw+wl/0dCe+dWU
         fiUVYJK45o9DU77E9UKGEjLLGzgIJENGEo+YHL4OS01n4XVjWq6GmMfQzpBghu8UlikW
         THk9kva4oWPNooQt9d18sVGTM/wLcRn9Wfh/EufpLskm0Csmm+7dAaaVOwchta4Ces+S
         bUN2wFORw577KPH0SuOTD7tTO3eJ5d5aaYJgXDM/wbQ1Uwm17IzNfqIPF2vbOn6sPb68
         R5hA==
X-Forwarded-Encrypted: i=1; AJvYcCWh9Lx0EQ/rjIPx/pBVj1Sb6bFQJhVDc9xp5RwoMLvMgmWgdWDUBbOZA84tXnLgjCxtO+PIP5mCKS+2@lists.infradead.org
X-Gm-Message-State: AOJu0YyNDzi53ta6hWHyqr4GCJgqzIg6F3yPNHIbaPzzPKboR+i5kTpc
	lHIt1bLXeC9q47ojYIMqLyg/RrqrgNK2FjOz/6rGAya0zb9INXx+1eZUdCcaBZyeICQ=
X-Gm-Gg: ASbGncvt4d95+YjAauuFVSy5q9VyloBb+4SScYkRJDABhG1TpxoFztFIAvwXs2VLkzk
	av+jYr81Gc4RWsxqw8RuJHPv4sTSY0BFmJBDa0WMsd6lk6yOF9X65ljAHlQRgMdnqoJGlw4JGuU
	aOg8UhKtKAFAg75oa72wDCO7cd2FanJQnL5wHLIUpa8C5bWLqgP2GOanlhhPKvSai3fM/AT25mW
	xyTo04VLHgh4/GOGLum0YUedmRNbyQbuxGL7HVAps12m+dqNwsGWZ+kPGdjTjEMi3O9cJUY8PTe
	jGrlVyB5Ec1keVzRjmFuNgCJZyjSM4VsLkJxsuKA7GfXnE/me3UPpsVQFskFUGlt1uzkxCj8ynd
	2GdOyaPt4gms7Ve2nKWzYAFqWJHl7HSL41YJ7YJE+VVtLDPD2OuKFJkdVHXeCYVzvONXWsdnB9l
	ISfw==
X-Google-Smtp-Source: AGHT+IEmBEK6bTGKnMdujI3ujDy4UcJas/45ozXk4d/lBkl5ABzvdXswERHZW/FvxgYvWIyzTXS/0Q==
X-Received: by 2002:a05:6808:1a08:b0:450:907:b523 with SMTP id 5614622812f47-4536e3af4f8mr1301320b6e.6.1764773587425;
        Wed, 03 Dec 2025 06:53:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org, 
 hch@infradead.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, 
 ming.lei@redhat.com, linux-nvme@lists.infradead.org, 
 Fengnan Chang <changfengnan@bytedance.com>
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
Subject: Re: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Message-Id: <176477358617.834078.6230499988908665369.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_065309_183192_E22B0CCA 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message.
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


On Fri, 14 Nov 2025 17:21:47 +0800, Fengnan Chang wrote:
> For now, per-cpu bio cache was only used in the io_uring + raw block
> device, filesystem also can use this to improve performance.
> After discussion in [1], we think it's better to enable per-cpu bio cache
> by default.
> 
> v3:
> fix some build warnings.
> 
> [...]

Applied, thanks!

[1/2] block: use bio_alloc_bioset for passthru IO by default
      commit: a3ed57376382a72838c5a7bb4705bc6c8b8faf21
[2/2] block: enable per-cpu bio cache by default
      commit: de4590e1f1838345dfd5c93eda01bcff8890607f

Best regards,
-- 
Jens Axboe




