Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E98C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SE2BV/I2WCTdjt/JVI/yrTOgR8UHXlWscracel65Ehs=; b=kt7pON/NTyIlaJGJAPXPWPFtYb
	LWVOe4jyGPnj0nQxyNBEPzCpmsLqUJqXqB5cN/12LyMC5WdOPX/e7fj+ecLn+S7Qdm4cvWnoIGsa8
	+SQfMZa1r7K2OFSaplpjhakpnScbD7AP2GFg+E5uP/TRFwk0ElTzXn5QVGJCa08aJn57SQcPbolyj
	Wp12QsVnRj+0irnIyLRPU28QXuAB5vP2RWeSx4ZP4HM6TJ3DC3n7PvS33PyPmqaHMXsVBTyHe6S0t
	oYSf5ebAcIRqGMD59cL0md/MaIuIJfCB1vy0XmhIVq0PunGLqn5gp2Xvi9WsKUaKIPluoC/12jHms
	iJWwDvfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrcq4-006Bx4-0A; Thu, 19 May 2022 09:53:00 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrcq1-006BvQ-Ge
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 09:52:58 +0000
Received: by mail-ot1-x32a.google.com with SMTP id
 s18-20020a056830149200b006063fef3e17so3165771otq.12
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SE2BV/I2WCTdjt/JVI/yrTOgR8UHXlWscracel65Ehs=;
 b=KD2rSN+ExZyYTCH3Y9/LL748mKgIYdzAdup+QuIWktP6pR9UbY1Zm4Ue0glXyXAfq4
 FAqem4p15J594NmAOfkRWQF/o8L4nke8y+s5+VZYyjh2/gakkEjsIhoAwk/6giQ2f8v2
 ARBNEFXEPFn529xke2V25AS4EM7UKREHkRW3pUyiWtZPhe/re0715euHbFfYE2JuGLFI
 Z5RkfN91lLJSXPjasijTkCz7CbHDEWKHRM87iRqv5CQwjcGV+DRab4ukJQvyl+ubsu2L
 xbtAzS9/XEQbU5hyzPMEbp/92v5169THHIcrvvmvbK7aDhOd5Zc0Dbh3dxmU51h9uujB
 zOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SE2BV/I2WCTdjt/JVI/yrTOgR8UHXlWscracel65Ehs=;
 b=A6sF+o33bPqRdiw/hBKOCxVXrzN2ZiIh1bjmNsxvbx++BZ8kYWz+oTKyCXcXTxRLwn
 MTngSd3xod1B0ikqwHnKvM+U7Rqal0t66CSW4W1nx5PbIdlgHFluuNRKrIcGglaXUWa+
 1Cbd9Yar5bifDfFHgpOfyI+Rk+6WWjfPESWqxlY/MP/Cmu1TSD6J6wpGD9PktNdh5dy+
 mbs8cLwF/L77Uwefk4nSHrCKxq6g/x/m/AfVviqHpXVNj7BbRLjUAyUUrwr0U0QsihVF
 TNDhnACXicDU2it8Wieas4BxmFVHGLAd25ja5jpo2p6LNz35FRVH6zmuvURmcmSp4EBf
 GWvA==
X-Gm-Message-State: AOAM530Ltu8zjoBMa8aOVO8zofPwWeOQdvjO3mkZISgGLlND+3N2Z0Qq
 a7w35ZUnwVORKsTARjxG4lKkNSaW63kFSIUzzpMR/kJRVlA=
X-Google-Smtp-Source: ABdhPJypV9yibOSx1SW7iUC7dATNUjtwf5yVOB9WuOGtRq6k3NQOmGjJ5xp/RHHUY2VNKm6aJAIEguud4s+X+r23cU0=
X-Received: by 2002:a9d:5e8c:0:b0:605:f4ca:bc2d with SMTP id
 f12-20020a9d5e8c000000b00605f4cabc2dmr1579211otl.86.1652953974532; Thu, 19
 May 2022 02:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125@epcas5p2.samsung.com>
 <20220517053147.7925-3-joshi.k@samsung.com> <20220517081520.GA14308@lst.de>
 <CA+1E3r+9CeNJAxGH8EzC+TSNgGt8GnLVCC9544_3v=pdgqmTbw@mail.gmail.com>
 <20220518072955.GA1867@lst.de>
In-Reply-To: <20220518072955.GA1867@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 19 May 2022 15:22:28 +0530
Message-ID: <CA+1E3rKO=imZtY-1AAmAG7+v1igF7eO6PMRC9CRmPXeX=kfpGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: enable uring-passthrough for admin commands
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_025257_591300_1F3E46A4 
X-CRM114-Status: GOOD (  11.95  )
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

On Wed, May 18, 2022 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Doing the controller based ioctls on a per-namespace node has been really
> painful for the existing ioctl.  So I'd much prefer to avoid that, but
> I'd be happy to hear more opinions.

Not sure if we may get opinions before merge-window expiration.
So I am thinking to respin with only the controller node (and defer ns
one to 5.20). Hope that is fine?

