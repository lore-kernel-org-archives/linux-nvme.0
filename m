Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69556E83820
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OG0qAA5xbW3Ibn5X08VvAyN8MqMrXIePKScxqFmmU8A=; b=tKh6wmQN97dPDr6hLsDXd79acA
	oSO/pGBhdnldw6CbPGDwSzNlQAV+jk2Y0QZYcgnqf4n44vMoAapZCJRhDNPjSBg4ZC4BtOPhacVLY
	GmsKmXBfeoJMDNr8CK7UuPUZEO7bYjS9YwVkxOCkhLO6x7fDUFfnhvXPBtMlzgawUImpIWCm8kLwe
	9VlTKdauXAqSghZCL2lz7sPWPnqWgwOFKAS2nUgirqda2yUq7FumvxgOq9O8zY93qvNtDQPzaA+DQ
	tg75dpHT7NppF1OeVJ+sP2GRq0IHLShFw1XjmVP/S6uaTGpKeyfqiquvt9IZcjnHs9QQ5D92PCuQH
	W38T4kXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3b3-00000007AI5-33z7;
	Mon, 16 Feb 2026 18:45:25 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3az-00000007AHX-3i0h
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 18:45:23 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-823081bb15fso1925294b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Feb 2026 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771267518; x=1771872318; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OG0qAA5xbW3Ibn5X08VvAyN8MqMrXIePKScxqFmmU8A=;
        b=JHr/a6rWfLT2z1WlyR9JMe5aJnJbxgbSfxarElKw59v/VK8W1b/pECDtiJYTbCy0sQ
         rNnqgb/uZnYKfyBN2Idnz/U9Za6EpjI04LgKGglmperhcP9mGBrkOWR3Trsf8HvJK8CM
         8lCKe8/hD6WXUo5CPflJVKRvCJ1AEKd/j/kvnDNDxtSUifzKwfWZiufFWUibJsjBadt4
         SMDgd0x8t6seTOmizChCUe/KCcaZdGSPvMM+H+poGq17Eaxfi8pau4mxqrRtgiHmDSR8
         xZwZFH3gRmDbdY/ttj6FAfB/pQgj0iydlo1pIAOBkCieCIbbLYqw/paFPwVMM40Bv26X
         BnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267518; x=1771872318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OG0qAA5xbW3Ibn5X08VvAyN8MqMrXIePKScxqFmmU8A=;
        b=qfFpgfzCBnO0BDXurhl+52JHPjQOJRM+i5EgITb70z+kdkquqJLacLMLleJpP9sEkm
         FVfjtVAgfauLge5V9nry4z4O6Lox+OBDlE2rBbEkv600jWntEqOmkCB75vK02xzbrCxi
         5oFKCXUlI4aWkd92Z0IG+dhfFBh+Rv5N/d0uwBPgsfnwjD/qeAoFnUZIrl/wqqII033P
         MmaM+ma1Opf+qUFPdRWbkmzaNBwnNFjF0kmPOpT46fLYZszs0G6I9uVwv9LwvFqp8Sok
         r3nkHiIGG4/ExbCjdx6c6aQ/r1u17Nq23kkeX8v/1GtVznCHsSCqL8i06MUwTfiAHDG9
         dQCw==
X-Forwarded-Encrypted: i=1; AJvYcCVsk1G6Zlt1mkGX7A0Vyh6gxHRpKNaOmRzbJPjdWXl1ueBXKza92tgqd9dzv9X71HhHQOzt/mJX6FE/@lists.infradead.org
X-Gm-Message-State: AOJu0YygAxVFuSZviExFvWlfGl5HpCfqGFu6C7WIkY83Oodq4zSWNxWw
	6kUFlT2d5978SFKS+VbqeRazYDNiI0i7MoY9iZ/i8K/6dHdsecIlZOOzW+wVUfAi6oM=
X-Gm-Gg: AZuq6aL0ngOcAVX58IGCbo9LTwFFRD2z5rPAiy4vBkgUNcrce94H5leqWH/SXYUQnIT
	hPRx6Z2aFe2PjUtZj+cPUWGN5XTq/IAgkEiCx+75/JKjwJZ6SLezwOQbV9r/32SQhmxXHvc+1Xu
	FUgZCZxFRNRQkR5IxefFuqf3ycsml68RoxpiIxVp4D3/Op5/OnZsBYMPzUHwkDC98wcvFw3AHEv
	X1iLc/Q2Ezl+H41eyhZctgb+SnVCNTZCNJBXPZbbgl88t+vd5Ek4h38HD2RHjS1r2mdRC/vuDW4
	mF7d6K7e3uqpSY0JEGsI514u6x9fUFzLjyl1lz8eaY9H9dvIF1LhmHE4cn6Py3bFC85Vuh/sCdU
	25YzhkyPea8Dj2yvhppCJfxuQsphbZAA1arnwr4Kb0FdJTpWcXGwn7Lp/+1rSFnNwpThW5GmHs3
	GDugsW9EQkYn9sCDljbnBzFfiqHhY=
X-Received: by 2002:a05:6a00:178c:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-824d961c463mr7191647b3a.48.1771267517461;
        Mon, 16 Feb 2026 10:45:17 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-824c6b9528esm10424523b3a.48.2026.02.16.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:45:16 -0800 (PST)
Date: Mon, 16 Feb 2026 10:45:15 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
Message-ID: <20260216184515.GH2392949-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_104521_983221_263A9CE8 
X-CRM114-Status: GOOD (  23.61  )
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

On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
> On 2/14/26 05:25, Mohamed Khalfella wrote:
> > TP8028 Rapid Path Failure Recovery does not define how much time the
> > host should wait for CCR operation to complete. It is reasonable to
> > assume that CCR operation can take up to ctrl->cqt. Update wait time for
> > CCR operation to be max(ctrl->cqt, ctrl->kato).
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 0680d05900c1..ff479c0263ab 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> >   	if (result & 0x01) /* Immediate Reset Successful */
> >   		goto out;
> >   
> > -	tmo = secs_to_jiffies(ictrl->kato);
> > +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> >   	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> >   		ret = -ETIMEDOUT;
> >   		goto out;
> 
> That is not my understanding. I was under the impression that CQT is the 
> _additional_ time a controller requires to clear out outstanding
> commands once it detected a loss of communication (ie _after_ KATO).
> Which would mean we have to wait for up to
> (ctrl->kato * 1000) + ctrl->cqt.

At this point the source controller knows about communication loss. We
do not need kato wait. In theory we should just wait for CQT.
max(cqt, kato) is a conservative guess I made.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

