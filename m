Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F878C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RG0QAqnhkN8VsgsFISubsUwICF6EYLvwH56+TUqE5XU=; b=DDY6CYrSXXq6fyF9EPmz7kOAGY
	t/5OM91X07X/kDewpyGtUxi6SVoM2dle7rcogg/OK7vyU5S6UVb70WmYmHySNwbF/AJGWB1WVWkze
	hTnEJyHkgIqQhcn7Z7sRGh7cOA3MkuSWFas1PpK31EQoNp02T4D/2mPgEDLxwLA0SwuC9xi9MKrR9
	II0b5bg38gBqSSsBPP3wZQ8WSLdiyyNjF+yLctUPTuwQgWWcLVws4yDd7ttf1Zgk7nWBEmk2b3ILU
	8gk6SfFteWR98RqmH2KC0gZ1hpk7KAapJH14mnoTH86xwHyOURqx1UfvBVpNrlt2MNHQ+82Aqt63r
	0U7ZPySw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPZbI-004skF-4p; Thu, 03 Mar 2022 00:45:48 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPZbF-004sj0-6J
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 00:45:46 +0000
Received: by mail-pf1-f181.google.com with SMTP id s11so3361377pfu.13
 for <linux-nvme@lists.infradead.org>; Wed, 02 Mar 2022 16:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RG0QAqnhkN8VsgsFISubsUwICF6EYLvwH56+TUqE5XU=;
 b=DqyYhbIc3DP15IOLqAJOc8RVKzK9W+48wR/9C0kOjxxpLNrlwIPqBHwsoJSOIC/QhD
 UEx+f3tnbEkNqDtz1AH+3YfkSBZk0dydrPiZRIcYBbYVCkHAhHefutoWlw1GMA64J+yp
 hNFNyaOQvhSv//a/ysorFLQIf/3N8QvCl2P5pdnpw4mvY5zYun+g7h+m5/9/zqN7MYJa
 NS8wkmet1i0OIBnEUhc+h822m8WoAj1mEPLrdbnvL6Etu2faCVJA08UC8GPw4jIUQtgo
 M7ThY7PmFIvdWLTEDI727CFxqIel3IB8aC380lX/GCDW1iL8NynrhNuTqy7mEFvybf5v
 XoLw==
X-Gm-Message-State: AOAM530Tpj+Q3zBWRPZBHWva9qOjd1B1VuBeTq+BGdfyLrQeDDSniL5Q
 /QxLLCZVO8z76/VMj0bU1dJbdDNh8x8=
X-Google-Smtp-Source: ABdhPJwHsPleyILIyHbK8t5jmqxDA0ova8fC9S8sWNDR2aRXpq3VbA3wibktuQ3GMn0tgtUkrPawsg==
X-Received: by 2002:a05:6a00:130c:b0:4bd:118:8071 with SMTP id
 j12-20020a056a00130c00b004bd01188071mr35659074pfu.28.1646268340881; 
 Wed, 02 Mar 2022 16:45:40 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a63dc15000000b00378c9e5b37fsm282669pgg.63.2022.03.02.16.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 16:45:39 -0800 (PST)
Date: Wed, 2 Mar 2022 16:45:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
 axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, javier@javigon.com,
 anuj20.g@samsung.com, joshiiitr@gmail.com
Subject: Re: [LSF/MM/BPF Topic] Towards more useful nvme-passthrough
Message-ID: <20220303004537.yceop3zwrwzg3wni@garbanzo>
References: <CGME20210609105347epcas5p42ab916655fca311157a38d54f79f95e7@epcas5p4.samsung.com>
 <20210609105050.127009-1-joshi.k@samsung.com>
 <d9e6e3cc-fedb-eb45-7a3e-5df24e67455b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e6e3cc-fedb-eb45-7a3e-5df24e67455b@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220302_164545_281665_1D62A407 
X-CRM114-Status: GOOD (  32.79  )
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

On Thu, Jun 24, 2021 at 11:24:27AM +0200, Hannes Reinecke wrote:
> On 6/9/21 12:50 PM, Kanchan Joshi wrote:
> > Background & objectives:
> > ------------------------
> > 
> > The NVMe passthrough interface
> > 
> > Good part: allows new device-features to be usable (at least in raw
> > form) without having to build block-generic cmds, in-kernel users,
> > emulations and file-generic user-interfaces - all this take some time to
> > evolve.
> > 
> > Bad part: passthrough interface has remain tied to synchronous ioctl,
> > which is a blocker for performance-centric usage scenarios. User-space
> > can take the pain of implementing async-over-sync on its own but it does
> > not make much sense in a world that already has io_uring.
> > 
> > Passthrough is lean in the sense it cuts through layers of abstractions
> > and reaches to NVMe fast. One of the objective here is to build a
> > scalable pass-through that can be readily used to play with new/emerging
> > NVMe features.  Another is to surpass/match existing raw/direct block
> > I/O performance with this new in-kernel path.
> > 
> > Recent developments:
> > --------------------
> > - NVMe now has a per-namespace char interface that remains available/usable
> >   even for unsupported features and for new command-sets [1].
> > 
> > - Jens has proposed async-ioctl like facility 'uring_cmd' in io_uring. This
> >   introduces new possibilities (beyond storage); async-passthrough is one of
> > those. Last posted version is V4 [2].
> > 
> > - I have posted work on async nvme passthrough over block-dev [3]. Posted work
> >   is in V4 (in sync with the infra of [2]).
> > 
> > Early performance numbers:
> > --------------------------
> > fio, randread, 4k bs, 1 job
> > Kiops, with varying QD:
> > 
> > QD      Sync-PT         io_uring        Async-PT
> > 1         10.8            10.6            10.6
> > 2         10.9            24.5            24
> > 4         10.6            45              46
> > 8         10.9            90              89
> > 16        11.0            169             170
> > 32        10.6            308             307
> > 64        10.8            503             506
> > 128       10.9            592             596
> > 
> > Further steps/discussion points:
> > --------------------------------
> > 1.Async-passthrough over nvme char-dev
> > It is in a shape to receive feedback, but I am not sure if community
> > would like to take a look at that before settling on uring-cmd infra.
> > 
> > 2.Once above gets in shape, bring other perf-centric features of io_uring to
> > this path -
> > A. SQPoll and register-file: already functional.
> > B. Passthrough polling: This can be enabled for block and looks feasible for
> > char-interface as well.  Keith recently posted enabling polling for user
> > pass-through [4]
> > C. Pre-mapped buffers: Early thought is to let the buffers registered by
> > io_uring, and add a new passthrough ioctl/uring_cmd in driver which does
> > everything that passthrough does except pinning/unpinning the pages.
> > 
> > 3. Are there more things in the "io_uring->nvme->[block-layer]->nvme" path
> > which can be optimized.
> > 
> > Ideally I'd like to cover good deal of ground before Dec. But there seems
> > plenty of possibilities on this path.  Discussion would help in how best to
> > move forward, and cement the ideas.
> > 
> > [1] https://lore.kernel.org/linux-nvme/20210421074504.57750-1-minwoo.im.dev@gmail.com/
> > [2] https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/
> > [3] https://lore.kernel.org/linux-nvme/20210325170540.59619-1-joshi.k@samsung.com/
> > [4] https://lore.kernel.org/linux-block/20210517171443.GB2709391@dhcp-10-100-145-180.wdc.com/#t
> > 
> I do like the idea.
> 
> What I would like to see is to make the ioring_cmd infrastructure
> generally available, such that we can port the SCSI sg asynchronous
> interface over to this.

What prevents you from doing this already? I think we just need more
patch reviews for the generic io-uring cmd patches, no?

 Luis

