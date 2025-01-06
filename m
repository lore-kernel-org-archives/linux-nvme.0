Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EB5E77199
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4UtI+O2C+ipmEMNnb8ze2GlLUjDCgToFX00Vv4aTUQ=; b=GpCtHT9nX1kStAk+dwy9InOVih
	dypy5y9mTwnkmIxxXIDDEPO1ox5I0ymZSuLjuVFpX1dwBczZGNPzc7f7afXXLTxUlt4jmMR2UDGZ/
	p7fIKIg/S0U00IU6TwmRehAPtVdjdYRhOyINBAe5qp8gASmTnBRF0aqLZeUESxXZN3QwDfcQPaOEP
	+3EcfiHkc3sL8uxr/u5OZKCQbMV6tLaaJohVTMVDRHd6+/Uh2eqa3jYVRAKMaVUxzzneo+WRnjHqy
	lS2g4ns7SFtQJCKoBTbxuRxgOqGFIF9uD7rMHgJF3fVH7nXV4iUgTWiCBvXSLbZqIXdee4CmAq+y7
	bPwm+Xog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrtK-00000002IZv-340q;
	Mon, 06 Jan 2025 18:31:54 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrtI-00000002IYj-0z62
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 18:31:53 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e53537d8feeso19157304276.0
        for <linux-nvme@lists.infradead.org>; Mon, 06 Jan 2025 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188311; x=1736793111; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4UtI+O2C+ipmEMNnb8ze2GlLUjDCgToFX00Vv4aTUQ=;
        b=BJngPCUEmd5gxfak5gC+1HbG4dhxgWxZQjZ1NWjfqShBFwIz+I6P2BAoANkUIHqVA6
         4f5qAx4q9Oor9dxW2H0sBvf2tvb7gUEC5vbyp/n8geZrNjfv+WG02G9nWTesEv1d1XWY
         lUHhMLX/vG/YINXDTmtCfMSLXsHHSp1FUnRenuoSPE7fXJ94FXWR8c5UAWSWgfV6uaVG
         QcsyvexU7K6/1X8Tga8bKdMNgSHCrMNg4QsubvIrK50fq3Ki5yspbXZZHVwEoJ0zO/dw
         Boyxtr+T2BxLOqEQJ29ibEJmyUw/GQ4400s1HijKEfExvt9OGrTA7aKQEXilhdAOOsTN
         eMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188311; x=1736793111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4UtI+O2C+ipmEMNnb8ze2GlLUjDCgToFX00Vv4aTUQ=;
        b=Xzk5ZAr7PlMpSfH+a9CCsuWlfHaiZ3zt+rRq5fOPpd1hhD+TAuh6cGtyWrJrVW5P/f
         G9ulrO2VY7tdTyxJy2bHq5pFtVwnHQhM201B9FeWA5SjPdBDQwmL0nmfS01sdtmD9FDU
         O57jtxxOhzNuy/Zf68gV6GvQzZ5MKY24C/yUBi2Lrv8qmJ5jM3ezWjnD3bSQLRdTiHUn
         u22aj/l/0AA6tTe9n1pa/LBeWmmmPpR32n28kfPgdQihTb/1YlY9R0GewjtPRUCj8m8n
         WdoNAWuSAZbG1Mqdb8e8E8++fWVMkWHUJeUGvRPrgT1NouDEAtgoJdKV6BZGTOfBXoSX
         Wg/w==
X-Forwarded-Encrypted: i=1; AJvYcCWYjSOnGlwxeyA1BE1+bik9W8egAO6ePi6qFNXb3Jg0WyP35SxFLIpRc3fl7sgF1UGKZntXCubMtQ0f@lists.infradead.org
X-Gm-Message-State: AOJu0YwDCKgWmcLz96dQfjktDUT6gSWeNSIceaRZ8QZHNIn3v+AhNjgj
	N6oToc0IRqj32DIQcK9xchWTW5KqDUFmMdwr4k7gEdl6oVLOCU/J9sSXNMhaTWscNqUlB/v9MZ+
	UxAts2yvOkLCz+Fme3M0O6Gy6I+o=
X-Gm-Gg: ASbGncsJuVCorAIipS1QRtfwEGu6TjJUKkHDOvPV8UoMX3DocF7UXFW2xfph/l3HdqE
	7VwHy8+Ult7hejBlxBX7KuVhi6Isj/+V7aurnU2EK
X-Google-Smtp-Source: AGHT+IGdL3AYLUBSEON5gNiuIQ+2Prh9q/GSoTmC9qNYgbc363YVs89zzoKH878KkRuBJlsOIvE1B5C9fAT/BmzCEc8=
X-Received: by 2002:a05:690c:60c1:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-6f3f80e42e9mr477565047b3.6.1736188310767; Mon, 06 Jan 2025
 10:31:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com> <Z3uIOPxr4s09qS1X@infradead.org>
In-Reply-To: <Z3uIOPxr4s09qS1X@infradead.org>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Tue, 7 Jan 2025 00:01:39 +0530
Message-ID: <CAJHDoJbvdEajX_hkuF4GqCULjSERZzMgc3FsMf4qmO_TrdNz8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Christoph Hellwig <hch@infradead.org>
Cc: Song Liu <song@kernel.org>, yanjun.zhu@linux.dev, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_103152_266063_B03F9FDA 
X-CRM114-Status: GOOD (  16.49  )
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

Thank you for pointing out these critical issues:

1. The sector tracking approach is fundamentally flawed because
drivers can modify sectors during submission
2. I'll look into the blk-filter work as it seems to be designed
specifically for this use case

Could you point me to resources about the blk-filter work? I'd like to
understand it better and potentially contribute to its upstream
efforts.

You're right that I need a better understanding of block devices and
filesystem fundamentals. Could you recommend any specific
documentation or reading materials on these topics?

On Mon, 6 Jan 2025 at 13:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> > 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
>
> You can't.  Drivers can and often do change the sector during submission
> processing.
>
> > 2. Captures sector numbers (not data) of changed blocks in real-time
> > 3. Periodically syncs the actual data from these sectors based on
> > configurable RPO
> > 4. Layers these incremental changes on top of base snapshots
>
> And all of that is broken.  If you are interested in this kind of
> mechanism help upstreaming the blk-filter work, which has been
> explicitly designed to support that.
>
> Before that you should really undestand how block devices and
> file systems work, as the rest of the mail suggested a very dangerous
> misunderstanding of the basic principles.

-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

