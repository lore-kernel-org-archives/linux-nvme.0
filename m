Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7C4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2tYdizKTIshWFThjBTeAJGUpF74jo5FnvbdsKAlPgg=; b=rAf1zpj8+c0NRnT8Uytu16Rrcw
	PLj3wh6p/lJsZxqXOzZCeXAAq55Hy74UId7Ty5CQ8KQBJt0+9Hwt3g59uTOfcqpL8bt6CHRXjXJGn
	rAXYPWWEB/12h2rn7mKHRDHBEZi01X9CrtEnIGuaHRvNlesDyuPXVr1EuiJxozs9hZE6jHNd6BoBi
	rEvKAZrHwG+4Sgsj9NptAOvELG+bPdo0UVHMfio2+3f06BBSwpGRJk2eSn87kwllH4U39TMXECU4Y
	34mVvV4YfphClvIHIr2OvzNC8jAfPUtLJw1XBEu2M52Qo2gjrGhUltcoyKo1Zbo+GhQCmN0Wgc56n
	cCHmTC5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSNlS-00DjoM-HX; Thu, 10 Mar 2022 18:43:54 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSNlP-00Djmw-L4
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 18:43:53 +0000
Received: by mail-lj1-x22e.google.com with SMTP id u3so9096519ljd.0
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f2tYdizKTIshWFThjBTeAJGUpF74jo5FnvbdsKAlPgg=;
 b=L+NAx3DQW/kLZvssrOMcN20V+NDmLBkLyZ7yh4g09+9QiiNtUZZrTYVFbgyuJwgRa0
 npVQz+VlciSI4GFCb5GeQs1B67E4W4gQWwcHLKvG/i0BH3YJ+E1kTSKHlU0Rh2G8ve8O
 bwwzm0UVfMCfPzvN22b9mEBjHMCE3t6IgTCCu1XzJszdmF0YJsK4INNTpjOx5G5eHOEE
 Lpi1zSGNmgPo3EyAqProc37ugId5l3l+RcRz8AgVLPdfMJ0iyy72qqUPhp5ARp9q+X5A
 W1RZMimkPG7xwcQpRyzGjMrlPJoOP573x1t+jxsFAl80LDq7uV+YhJjLY0STZFoO90MH
 qzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f2tYdizKTIshWFThjBTeAJGUpF74jo5FnvbdsKAlPgg=;
 b=ovViii55KGErh48c13iQ7JHlC3lEIvRL+rg3D/snTL2u2jLb7Lt5jfT8wWccrpi6B9
 xWk85wBnSSReAZ3JnwB8Q/IAuGrxhvqDwyYLYU66X4BggBM+metyQC1Wv8QU7q6kI2Xw
 qHChotowT2uuZ6e3U1c6RUXo81MAnOEG9i/SpkfCdkriaA87MZsxMD0ocaWnQ9Zl7xtk
 G/pXDk7YGRp2k0v/IpUNpn/E08P0fLWkbchvm1O6Y+F77KuqC7rnwzHXenF3V5WnGVGh
 83rfrtU1smxZwheg5G/VBrXmKBLEsjrmR9VtR7Zz23zTc2oM5+mU0t9+nMU0VZicH/9S
 Utag==
X-Gm-Message-State: AOAM532ropCLw7pNK9o9aC3krxRVE5OJpJQpaLgEDBiMcU/28gYEg6m5
 n27suAaCpNB3DjjTzHo2mxAD3W3NEM0mlyGwamo=
X-Google-Smtp-Source: ABdhPJzQL58I6OV6Ntzjf1Sx72ym4uZ1I9t+0tr8hmh2IxxfBECQKSnK2+rNZtDoJC83aKh8L8hI7BYJ/Rb/x0njv+8=
X-Received: by 2002:a2e:8403:0:b0:248:31d:3e35 with SMTP id
 z3-20020a2e8403000000b00248031d3e35mr3682631ljg.445.1646937828736; Thu, 10
 Mar 2022 10:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
In-Reply-To: <20220310141945.GA890@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 11 Mar 2022 00:13:24 +0530
Message-ID: <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_104351_712851_A4DEB0C4 
X-CRM114-Status: GOOD (  25.79  )
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

On Thu, Mar 10, 2022 at 7:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 10, 2022 at 05:20:13PM +0530, Kanchan Joshi wrote:
> > In sync ioctl, we always update this result field by doing put_user on
> > completion.
> > For async ioctl, since command is inside the the sqe, its lifetime is
> > only upto submission. SQE may get reused post submission, leaving no
> > way to update the "result" field on completion. Had this field been a
> > pointer, we could have saved this on submission and updated on
> > completion. But that would require redesigning this structure and
> > adding newer ioctl in nvme.
>
> Why would it required adding an ioctl to nvme?  The whole io_uring
> async_cmd infrastructure is completely independent from ioctls.

io_uring is sure not peeking into ioctl and its command-structure but
offering the facility to use its sqe to store that ioctl-command
inline.
Problem is, the inline facility does not go very well with this
particular nvme-passthru ioctl (NVME_IOCTL_IO64_CMD).
And that's because this ioctl requires additional "__u64 result;" to
be updated within "struct nvme_passthru_cmd64".
To update that during completion, we need, at the least, the result
field to be a pointer "__u64 result_ptr" inside the struct
nvme_passthru_cmd64.
Do you see that is possible without adding a new passthru ioctl in nvme?

> > Coming back, even though sync-ioctl alway updates this result to
> > user-space, only a few nvme io commands (e.g. zone-append, copy,
> > zone-mgmt-send) can return this additional result (spec-wise).
> > Therefore in nvme, when we are dealing with inline-sqe commands from
> > io_uring, we never attempt to update the result. And since we don't
> > update the result, we limit support to only read/write passthru
> > commands. And fail any other command during submission itself (Patch
> > 2).
>
> Yikes.  That is outright horrible.  passthrough needs to be command
> agnostic and future proof to any newly added nvme command.

This patch (along with patch 16) does exactly that. Makes it
command-agnostic and future-proof. All nvme-commands will work with
it.
Just that application needs to pass the pointer of ioctl-command and
not place it inline inside the sqe.

Overall, I think at io_uring infra level both submission makes sense:
big-sqe based inline submission (more efficient for <= 80 bytes) and
normal-sqe based non-inline/indirect submissions.
At nvme-level, we have to pick (depending on ioctl in hand). Currently
we are playing with both and constructing a sort of fast-path (for all
commands) and another faster-path (only for read/write commands).
Should we (at nvme-level) rather opt out and use only indirect
(because it works for all commands) or must we build a way to enable
inline-one for all commands?

> > > Overly long line.
> >
> > Under 100, but sure, can fold it under 80.
>
> You can only use 100 sparingly if it makes the code more readable.  Which
> I know is fuzzy, and in practice never does.  Certainly not in nvme and
> block code.

Clears up, thanks.

-- 
Kanchan

