Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B84C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:26:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FEF64DFB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FEF64DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R9aLJCIfzOzf4+vjsOPXydUE0Ei8nu1PcJVGwAlcss0=; b=SBjUqD1FkrLM5hpuyHCmKnBa5
	E5LHuZi3UC8M6B43T55ClGIM9S2rtaEi+fUm3sccfQCIJusNeTAZrG7HRJPWiS5RopqJy8uLTpNHT
	iCIsj5N81y+eqB1W0gA0cuyAzF/u0CX26XGqJpmUVC2l0rizU4LW6MjTZjTWJTjiqz9LLI0oH2bJC
	ZIhF457Uv2IfHtCj8ls9gPP4/Fa75j0hD3CNOrwnh5P/TnuY9PuPJcrCl3onOJB14yhPP0pKc/TMg
	D76kPrKSjWnizAZ8CHBiKFStmyl/cqRmmYeK7z4/8FBjFh4DGOPaU/oR/W13CeZmHjR97sILjBPXt
	6piG4lxxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5B3d-00042J-05; Thu, 28 Jan 2021 17:26:13 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5B3a-00041q-OZ
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 17:26:11 +0000
Received: by mail-wm1-x334.google.com with SMTP id u14so4948594wml.4
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 09:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FspasjBdvOyQr6r45W+eIjHtBw+6zev/SfrwICE1x+E=;
 b=M4blj2lAzwljc11390CinZGBi0ydd5QI0CCu45Tj5PhQGdcUSCE8b2Tc9hoho3g22S
 agCTwHalauhPkOOxRsPCf91BAO9tmGmA/SPZQXHPrsx3lrcVzOgxJSBI06BgHSLIKqkZ
 Dh6cZ681hcvvWJVnqkqgYmVWj+MM5j0Wn5guMLjWQNAUlE+IMTAVybQPWQlbkA+iyGnf
 vCEX7rU+XsJtbzZZBrTi6jE9d4GwdNcrmAr3ntZo3y7xjfaHWIGJKSGYzA7xJdBRHKvQ
 NDyUWpmzSLCeF3Rcsl/iA+jdu2koTbJ6CPFhUgaBSxBs07wvqL1GwORoM1SsETsq9cg0
 Tcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FspasjBdvOyQr6r45W+eIjHtBw+6zev/SfrwICE1x+E=;
 b=NOhbHL88zaUmheUKEuziNHePJeogv1mhbWC/PTScCO1pFzaK6hDufiZLgpaK1Qa2bT
 VQ3arhGlmcqslsig8oZs2rH5EB9JLQgOQmMJ7NqT4ZYb4l9yYd7WNfyVG/W8rDFgtAd7
 Warh7zYZC2fQKPPlDAUK8BU+OgttK1bO94hqbuTcQYKH3QfJNHWeqs+LwuDLLSsbU9vt
 xvbxYtYiUN0BG5kH+3qEa0ljo8ZVAzn+GkpjL2RvNAEUADf5BJLn4B3Ni/YyzQpom/we
 gn3t84vVtXy+uJreB+Wf2fYEe39um9oFEWhUvBCkct/4ngyCpA4avKPO0GnwZuAhb6cD
 qHwg==
X-Gm-Message-State: AOAM532wrjhg6uWVI8q7sH1YjdKzb+6Q/e5rI8xHd8iIWD8HnePM8pF5
 4yIQMjQBlyDQpOtfjmIdtQb8yT58YGh7cPTd+VY=
X-Google-Smtp-Source: ABdhPJzRZk3KfSDLq5r5eXz0qggXIiZNjt0V4LKZlF2sNSCmYLPS1wUhBg/Xdhnxvq7cEiQQ12TOE410aFGwN0dZUdo=
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr283428wmb.25.1611854769125;
 Thu, 28 Jan 2021 09:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
 <6d847f4a-65a5-bc62-1d36-52e222e3d142@kernel.dk>
In-Reply-To: <6d847f4a-65a5-bc62-1d36-52e222e3d142@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 28 Jan 2021 22:55:41 +0530
Message-ID: <CA+1E3rLD2e4yFsA-gxPGtp2Fg2Z0sdfpS3Rz+WsUC4i5aF43LA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_122610_811456_1ED121D0 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: sagi@grimberg.me, Kanchan Joshi <joshi.k@samsung.com>, anuj20.g@samsung.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 8:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/28/21 5:04 AM, Kanchan Joshi wrote:
> > And for some ioctls, driver may still need to use task-work to update
> > the user-space pointers (embedded in uring/ioctl cmd) during
> > completion.
>
> For this use case, we should ensure that just io_uring handles this
> part. It's already got everything setup for it, and I'd rather avoid
> having drivers touch any of those parts. Could be done by having an
> io_uring helper ala:
>
> io_uring_cmd_complete_in_task(cmd, handler);
>
> which takes care of the nitty gritty details.

Ah right. With that, I can do away with exporting task-work.
NVMe completion can invoke (depending on ioctl) this uring-helper with
a handler that does the ioctl-specific update in task context.



-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
