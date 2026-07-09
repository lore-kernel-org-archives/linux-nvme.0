Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623A8C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tn9y46FBQkzAHGteukZJJfq/tSoiUF3r0+0GZip7VGI=; b=rM3XJ/g+D9QDu99YaehqpY49W4
	9iaOtLZKa1KPBb4ydAwTnMhivD8JIPrEbZhdet3Ci6ZF8M4Yj00dRPINmOhOq1DBSsG+bRWQq2lng
	jXKlLCoNcmZQNGJW3WGf1+/oTtdg03Am8LNNsQT/oPXvvzkZMbhQ8jBiSr8y3Su0SLl3d38anKOP4
	wZ2vLt9lFphhwfdKqLiAPa2hkxA7G2sT6a8zjAEZoKAigQ1E3clBt97d62+PvRCvsqD22M0a+3f53
	k2XWqckd7A2Q0SeUPu0QEdCDAboOhhA1/xYvDbMkITfmqgL+JADCyZrELZT+3z7lxnGPKycR0WwEt
	THfkt3mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whj83-00000001H2D-2rJb;
	Thu, 09 Jul 2026 07:25:03 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whj81-00000001H1Q-3Ro9
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 07:25:03 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1299248a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 00:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783581900; cv=none;
        d=google.com; s=arc-20260327;
        b=F/UX+arSKAe7wgq49hCW4hVDXnGi0E9mFcFR2rD2rYyLE6/8rnLZ5e0+WG7S5xFPBU
         BSypamUt7FN0wtYpOmoQXrI7FyrlXujXXD3vCSczJpqGk3Gc8kLFXqMtljzvG4SG5kXC
         OD9CiKOpbvqeAzq2KofU+n8hvrMMCT/hIbYEi934hqDh9CjrhWbzZEW/6orVHurkKwb9
         0ltKYHEzvPAU82OAcfMHu2h6dhqfxCdnK8yjmY+U0etHy9S1p+7gSVhSEjQFqIc2eCdP
         24xOIypiXsS8wH3SI/BX+nzsT+mqUsB5aQvQ/UK2FBAIu0PfP+bZbvSkygXksWl/y5bR
         KtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tn9y46FBQkzAHGteukZJJfq/tSoiUF3r0+0GZip7VGI=;
        fh=HfyrBXzqELskL8d1oDsfq85m1J8kr6Pam70vBaiB0EE=;
        b=L/oE4uAx0DKAlF+Cs1MnX3uctD7/6sGc9MELOSeQ+xUl3WOvta8qqrH4EgkKWvtCsi
         KkDV+ZVKKWlRcwa0ZYLfCBZz46UJ9LTSErWt6NOyBF3oDW4FHpxmnPtLljMumRRtlqm3
         opBHws8KI4DUl39+rlt76h2NvujiCcXNuh6G115fSrVmHsJRghmyeUj/0hX5MtbzRciU
         2c1wFxBzt5u0Y9PDUfL0MgYYnRT20MyM3FTcf8g+a7VPYMj9cYBfyZxTSP7K8BwVItD4
         XYAQmWulWacXj1HuOV4VMVTUGQrcTp3HJuW5cBRATqfPkJbLqiirAaeqmJJ6M1XiE/jv
         mwyQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783581900; x=1784186700; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tn9y46FBQkzAHGteukZJJfq/tSoiUF3r0+0GZip7VGI=;
        b=gdbfbQEyQsssqdc+lfu6MJwJ/MmP1VFeIC1wQkKepxVDWdugOZtoTk/liMdPLX06IQ
         GB2uEcTX8mX7vymKcYCbZ6IOOoiuqNLdC3Yyp5b0347sSSR8Nl9g3DXyjL1yK1A99dUT
         ze1T4JgrmmdmdPSiUe43F6VfUgr7dmv98HpbHOTu7vmMMiZIw8OonkfnZIfhv9kRQSmE
         76WqRrWO2IZj9kjUMT1YcTCqCCd1zc5jr7U2GNgJszbza1QeWjrOj8CZlUcHimPLI3N4
         T+u2tygJv3/UeJJW+LsNnxlDsO1g3jPayLPB99o5s2qXpZ3wh2G7VF5FJ+Z4CCRqq1IK
         anYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581900; x=1784186700;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tn9y46FBQkzAHGteukZJJfq/tSoiUF3r0+0GZip7VGI=;
        b=FyvyFDxz7tMtfg94CQ6a01SnbNsoCoZWiXr1skhZGpSHaedty2zqDDBx1iEWhULv2+
         6iLIMHsgi2R+GlZ4SKTKXGPbR2Ow4oTLlB0AjgusQBBRe21IqSTlvnayn9/xekQqZedQ
         tBkDYbBa7G+sYOUOWeiIdOIKAii6UAovsguXQU5TGX1I/ftX2rChvRgP532idC/bgCLR
         uZ2pt2vHktFVKCXdaxC6VeRB1Ud0hdechiamLp1dZqeUntpqpAIOVQX6lIxc3SeSqb1A
         n+i6Lw+U5BGV+wo5rPPiNPcQeYnDK9V3h1j9eCloXJW5xvQrZPhJm+oXJ+Xgdp2vi67Q
         92cQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqy1tfV2e8nlN2Z2yOtXSXI9zk5DzTIU/wqVY0wu3mvIQaNTloOyVdNURmExDZ+xRWtQOwTQFp2fZEG@lists.infradead.org
X-Gm-Message-State: AOJu0YzKIpRA63hNAoQ+upmP5BhT4SA3QeZPrtHj+NDGryrfAGugqH50
	GrUI04uaWgMVOXWFpGX0xHl98GSu+btWbDEyqux6qFv7yWyaUEEU+TQnqYcEexyprQi/+BlvC05
	1pWc2342LM/25aUAG9h4bdnjNPH4jMD5dW9IH1OQG
X-Gm-Gg: AfdE7cnksuG22GLZGkrol40N8hczpKgmXo2posv6CUCG+hSVnyoR7FRGhyMp4Is9fev
	Lu0HmUXaa4TRHou5YrqFT8a0lwcWjG+AQWIcYkc5Uzez0wz3BW8baNCNYEk1/gQXgKMS+4/6v+S
	quw7gjFMh7x4yMa7+6861SKeNR6AqKEFQ/laJVtPhrqjVXdYDndxvDQFPoGPToVQK55KNTJTEvM
	AC+2wQJkoPYTmfVmlYGaIxVKhvyaoO2YvX0UhMYozUyy19NWUgErrJwoSc608Z7y1vYDmWKYQ==
X-Received: by 2002:a05:6a21:a38d:b0:3bf:6edd:4dfb with SMTP id
 adf61e73a8af0-3c0bcf163e2mr6818267637.5.1783581899792; Thu, 09 Jul 2026
 00:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-8-nilay@linux.ibm.com>
 <20260626064335.GG10731@lst.de> <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
 <20260629124703.GB23417@lst.de> <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
 <20260709062014.GA17526@lst.de>
In-Reply-To: <20260709062014.GA17526@lst.de>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Jul 2026 09:24:22 +0200
X-Gm-Features: AVVi8Cc-zAoRoqkNx2JtxfvusGU3fJlG-0kIdq1h0-jtUKcAFxxzXzVdDdKvavI
Message-ID: <CANpmjNMzD6zyHZBybWNzSqcUC1-0WSLOT9Mb575aSb+eejyZjA@mail.gmail.com>
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for nvme_subsystem::lock
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_002501_873280_0BA8B42C 
X-CRM114-Status: GOOD (  19.29  )
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

On Thu, 9 Jul 2026 at 08:20, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 30, 2026 at 01:12:55AM +0200, Marco Elver wrote:
> > Initialization of guarded objects has gone through a few iterations,
>
> And all of them suck badly, with the current one being the worse.
>
> > so I don't want to open that can of worms again. I think the
> > infrastructure we have now provides various options (the scoped guard
> > machinery isn't the only way). You could just write:
> >
> > /* Initializes unpublished lock-guarded variables. */
> > context_unsafe(
> >     INIT_LIST_HEAD(&subsys->nsheads);
> >     // ... other guarded var init in same block ...
> > );
>
> Using all these silly context makes it total mess unfortunately.

The only option then is to just mark the whole function
__context_unsafe(init). We can't have it both ways: analyze an init
function but ignore lock-guarded accesses without annotations.

I'm out of ideas, because this is fundamentally unsolvable problem
with what the C language gives us. The C language has no explicit
constructors, and therefore our semantic intent cannot magically be
communicated to the compiler without additional syntax; we need some
way to mark things in C. My initial attempt of making it closer to
magic:

    mutex_init(&x->mu);
    x->var = 123;  // var is __guarded_by(&mu)

was rejected [1] on the grounds that we might want analysis in an init
function after the context-lock-init. And that's reasonable if we
favor safety over the minor inconvenience of marking initialization.
__context_unsafe(init) is the option to not need to change the code
but gets us no analysis in an init function whatsoever.

[1] https://lore.kernel.org/all/20260115005231.1211866-1-elver@google.com/

Aside, in the C++ world where constructors exist, Clang just disables
the analysis completely in ctors to permit lock-guarded variable
initialization. So __context_unsafe(init) attribute on a function is
equivalent, given C has no ctors.

