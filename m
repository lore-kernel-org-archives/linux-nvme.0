Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218D9C47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 06:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Po0mnsSK2tMDCiG0D+BfYQxlavb/Qud9fTtc+1JXMIA=; b=Joy7nGAVKNAyyH29Evbky7zYKo
	B2kK1GeRV9KksDUEWULotk2FPkfi1F6TBlLm38KApbNJLRdJR/Klry3GTjrC857AC+xj3cvNqiopY
	PePpIaMBwzNRLySWsJPJAjNiApCAbyYWiaL8P1D04QdKlzoKQsdFAKT8j422zU4yBlR1qwtwYe134
	7nEBtlq5EQOon4q21lFlMnH0W6YhQxrsAdkcBk/r+v3tzcTLYaOLQmO/8fYYt3Ay5m+O/S5ZPZHm0
	YSqziprIcn9gH6VqKAF86hEOsIPZOMCkjVR6y1gkWd+AF/w6fDyMilgZ2ch1QrGtUvUJ2SThYX49Q
	GZOj12Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLHNg-00D0Ck-0z;
	Thu, 04 Jan 2024 06:39:04 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLHNd-00D0CI-2l
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 06:39:03 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28c0536806fso140080a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 22:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704350339; x=1704955139; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po0mnsSK2tMDCiG0D+BfYQxlavb/Qud9fTtc+1JXMIA=;
        b=P8NpD4CLayqtpTaRsA8lJiiCbrzlXmBHyd5HLqu7fCA0mFkk+XlYNSCMcDho4Vrutz
         3ILffE3MJSBvdrFT6hVFL0+lbHGOpxfMQT88oa2TMBePikTZGnpbe5FiIgnqfv0D5fBP
         +37foj4sx0G3VpF0w0OOAcfbdrWaJKd7cLMdzYFtsAeZhpTh+TRb9YsxuiRlTskjD1tY
         AaVK0cZUqbtK7g4oxdBocHNyuUTfWba+O4cbChY7RzLdv1yXasM0uw9BHdunHA7f4d9x
         XsV4Tqq16RkNRn3gDh091MFwmXVmtES20SiN7x5b2xkQ+GyngN5Vuz3WlMbAbwXGEWeN
         r4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704350339; x=1704955139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po0mnsSK2tMDCiG0D+BfYQxlavb/Qud9fTtc+1JXMIA=;
        b=TT/5FJv5aT4BJ8MqpeAFFYp0M2QZx32RNjbNwvnEdJyI4GEUcxagbUAMG79hgKzMyI
         IznCWQK4rOajrZ++/Qpa/kFRzgO47z3JEDFrKrc6Hxs0d4hpqo0G1IzSd5DgLc+N6fnN
         u5/orpHSa37XifJSRItgE6oJhJ5I/sCXkQag+pzTfrObKDDGvACgdIwVNsdNuky7/7tz
         CJtR1K6r+0RCCFMp9frBMXDxErpjN5CE6p6YrL+tg9p/fTLpppKodKA3xTKgfRbfVymH
         0I9QgfNkEk5ny+q2kAvRgliLH1dYH+vm0qBz2+Q4HF9Oq33xeeC0BNQXODwK/LyQJeZ1
         xiwQ==
X-Gm-Message-State: AOJu0Yyuc3fKYcoIdX6gYKRbVgo3IyCmA4CVSQaup6lQe3XTGOYOtv+y
	HFJCZ6DEN880AO9xiBc0qgf5redfG3O09DxT9sqfFxpXyHzebg==
X-Google-Smtp-Source: AGHT+IHbyhVISYfW6a6NmN0WBC6oQI8XORCGZZ+Rht7QK6+3YAvrfc7BmljyD0GkOF+c8Km2LDNeUozg7hS2/Ud9AC4=
X-Received: by 2002:a17:90a:c485:b0:28c:a31f:e5c6 with SMTP id
 j5-20020a17090ac48500b0028ca31fe5c6mr161094pjt.99.1704350338789; Wed, 03 Jan
 2024 22:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20240103210405.3593499-1-jallison@ciq.com> <775d4ce8-e9ed-4d27-80bd-3877e80b810a@nvidia.com>
In-Reply-To: <775d4ce8-e9ed-4d27-80bd-3877e80b810a@nvidia.com>
From: Jeremy Allison <jallison@ciq.com>
Date: Wed, 3 Jan 2024 22:38:47 -0800
Message-ID: <CADfv6KZ25t60gj1QV=_Pu0XgMsxJpg_+_HHFg76kV+g+MYVjNg@mail.gmail.com>
Subject: Re: Make NVME shutdown two-pass - Version 4
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "jra@samba.org" <jra@samba.org>, "tansuresh@google.com" <tansuresh@google.com>, "hch@lst.de" <hch@lst.de>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jeremy Allison <jallison@ciq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_223901_914400_897EC989 
X-CRM114-Status: GOOD (  23.52  )
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

This code is only exercised when the PCI shutdown function is called -
shutting down the VM is
how I've been testing it). I don't see a way of invoking that in blktest.

On Wed, Jan 3, 2024 at 8:48=E2=80=AFPM Chaitanya Kulkarni <chaitanyak@nvidi=
a.com> wrote:
>
> On 1/3/24 13:04, Jeremy Allison wrote:
> > This is version 4 of a patchset originally written by
> > Tanjore Suresh <tansuresh@google.com> to make shutdown
> > of nvme devices two-pass.
> >
> > Changes from version 3:
> >
> > 1). Removed duplicate setting of ctrl->ctrl_config in
> > nvme completion function. Noticed by Sagi Grimberg <sagi@grimberg.me>
> >
> > 2). Removed intermediate function nvme_wait_for_shutdown_cmpl(),
> > folded this code directly into nvme_shutdown_wait() by
> > exporting nvme_wait_ready() from drivers/nvme/host/core.c.
> > Requested by Sagi Grimberg <sagi@grimberg.me>
> >
> > -------------------------------------------------------------
> > Currently the Linux nvme driver shutdown code steps
> > through each connected drive, sets the NVME_CC_SHN_NORMAL
> > (normal shutdown) flag and then polls the given drive
> > waiting for the response NVME_CSTS_SHST_CMPLT flag
> > (shutdown complete).
> >
> > Each drive is taking around 13 seconds to respond to this.
> >
> > The customer has 20+ drives on the box so this time adds
> > up on shutdown when the nvme driver is being shut down.
> >
> > This patchset changes shutdown to proceed in parallel,
> > so the NVME_CC_SHN_NORMAL (normal shutdown) flag is
> > sent to all drives first, and then it polls waiting
> > for the NVME_CSTS_SHST_CMPLT flag (shutdown complete)
> > for all drives.
> >
> > In the specific customer case it reduces the NVME
> > shutdown time from over 300 seconds to around 15
> > seconds.
> > -------------------------------------------------------------
> >
> > Thanks for your consideration,
> >
> > Jeremy Allison.
> > CIQ / Samba Team.
> >
> >
> >
>
> Is there any plan to add a blktests for this or this needs a special setu=
p
> for testing that cannot be done with blktest ?
>
> -ck
>
>

