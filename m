Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40925C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYTEN9JBCbSYZtYrxEfKSYcmjKROaJRwEA+42gL1fX0=; b=J88nhgtL7DD9eTWIn78CpRD2gf
	hFOEZqjmq7NI6Ji97DZJRek9rf0kPJ++C4x+n0djsoa1U6ojKTltmQ+vhZof8/3Pd7FNJA8cIYRq/
	xIJWOC/Nd+TdQEF6M0EG50cZUXTKclwNaayZpY/R9Txs9M4zQdhBXwBQTNaBKeGMAKBH1MDur4jec
	bl7MrogaECkpMNnIFCSSWSrXiQDg74D+Qk/NjqDrgG6dcm44RL1bnZ7/9+FGyxwUYYl88nlfiVW4x
	KFCMDiCllao8867sDwrtvifNAyT3Q0kpGyBN14JRTZC4daP+ZbV3OPG6Cxcj2Uin29+P2weZ8JN1i
	iRNjbOPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noQke-002VSl-6z; Tue, 10 May 2022 14:22:12 +0000
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noQkb-002VRq-MF
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 14:22:11 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id
 y27-20020a4a9c1b000000b0032129651bb0so3149484ooj.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UYTEN9JBCbSYZtYrxEfKSYcmjKROaJRwEA+42gL1fX0=;
 b=HlqckSy7O2WA9Nbjzc8ISiEjP/qp6WObJIYl1g8P467kHBSrHlD9R7y5nafUttXi/4
 y1PDSx59/7dYzMSX9OY9xbYT4dWYynH0Uoqsp7hSditGeYQdVfTWaGnlav4dFQ0+vGfE
 1PekGYB+THwtm3Rlp9rTjQs6ANaLBAfDo+yp/Zu4JCI1BvaBUWzUViVAjWnGrZ1lTNzP
 j0IhRlVTcqSa3jO557Gnj3c7W/mpANUMjL6Dw5W488rYTEuJsUIDZiI18Tww6lNn3pGr
 6Q9jpyYsARZjhgaaUGhodeSVJcQ+tBdOO90qbqpp7w9WsKl5SSL7Q89JKOefw/16VG0O
 sdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UYTEN9JBCbSYZtYrxEfKSYcmjKROaJRwEA+42gL1fX0=;
 b=nOT/scAIFTYOIBC41fgLfT2toOogFKYnpM8LCiAuJehzSIqYx2kx75AO/kJOFhaAgg
 yNt5+42COyCasKYFYPiCa7pcgJQOgwGkMI69YNPCQ4/3PvGtR7ujn7J7TE172mjm6uDq
 Tfsf+cyjG4eSj728hKaZeyPv+muZIsotPAMJC6UOO8Yy/MGP67koosf/QBMrjFmxMbQ6
 0CzoQOGA5FpD915jBL9pgS9AFVVCyclq0OC3/YVavKKcZ7GAkI5eSv17X3ZNv20t1DWr
 YiM25FE0FnXx4mpT5D2o31mZWlqbq9VcxDsjdJb4KwCmr3OL608uaVUL8YQCwjXjczfx
 j4LQ==
X-Gm-Message-State: AOAM532kOvwhkXkld2zw+0XQ4TO/Cb1hGNVPwqjuJN0VqnPss74/3yn3
 uVQ2KQ5HD/nXZGNDoOEKEuGxPr4pbqiCK4fCLe0=
X-Google-Smtp-Source: ABdhPJx+sB9EBiYJ3sTd3m1OfaATJn0Js6Kmgz8hanKpfau1B3v+UfLUb1XkaORm2q4oDz67a8VzaKhIYR/0q3j1hLY=
X-Received: by 2002:a4a:2cd3:0:b0:35e:99e3:a497 with SMTP id
 o202-20020a4a2cd3000000b0035e99e3a497mr8182960ooo.86.1652192526127; Tue, 10
 May 2022 07:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
 <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
 <20220510072011.GA11929@lst.de>
 <2a09399d-480e-8b03-8303-57287f7b5c64@kernel.dk>
In-Reply-To: <2a09399d-480e-8b03-8303-57287f7b5c64@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 10 May 2022 19:51:40 +0530
Message-ID: <CA+1E3rKGZ_XfwtO_NLFd15RiY8ZYzeaKAJHppOwaEwy5eAeecw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Stefan Roesch <shr@fb.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_072209_763254_E1447B2E 
X-CRM114-Status: GOOD (  18.60  )
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

On Tue, May 10, 2022 at 5:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/10/22 1:20 AM, Christoph Hellwig wrote:
> > On Thu, May 05, 2022 at 12:20:37PM -0600, Jens Axboe wrote:
> >> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> >>> This iteration is against io_uring-big-sqe brach (linux-block).
> >>> On top of a739b2354 ("io_uring: enable CQE32").
> >>>
> >>> fio testing branch:
> >>> https://github.com/joshkan/fio/tree/big-cqe-pt.v4
> >>
> >> I folded in the suggested changes, the branch is here:
> >>
> >> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough
> >>
> >> I'll try and run the fio test branch, but please take a look and see what
> >> you think.
> >
> > I think what is in the branch now looks pretty good.  Can either of you
> > two send it out to the lists for a final review pass?
>
> Kanchan, do you want to do this?

Sure, will do that.
Looking more into cases when cmd needs deferral. We need a few changes there.
I will put those in the other email (for better context). Please take
a look. If you are fine with that, will fold those in the newer
version.

