Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85830C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmuilfNrcNqikxPSYG2vhAJk/+9dUt/pQUx/utYGH5k=; b=odd1btLYa/lPnKeTJDBsMqG1oV
	+WvJPGDYemSbcSctihBaSJ2kNVTnwSs4TKNfwA20Ltjl6yzvwaTto/9u2dyP19/6b3w3AAAIrlnRL
	tijPHjZd5m7d+HehDH1SgNeXi37Toz31/QXUsql1KYT5CnZKmMuZ4/4CP0x4krCSdO2MBPze6M1Wx
	oHltMjI1xr/418oYtaq4iOs9kbfK3a7EGj2ELb0Qu4Q/Q0UR9Zdv7GU6Ai72FKKElwqytnTPw6sBg
	SHLJyTYimLu8jHzJG1zwqdUbZdMxs4CgU2G4f6xUhzuyOMiJb3RQDyCPwS9tO7YSWj6iCjQIJFnZK
	6JcuOHFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoPy-007You-A4; Tue, 18 Oct 2022 15:22:10 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoPt-007YYV-Kv
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:22:07 +0000
Received: by mail-lj1-x22e.google.com with SMTP id a25so18406577ljk.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmuilfNrcNqikxPSYG2vhAJk/+9dUt/pQUx/utYGH5k=;
        b=oeEZ3tNTjNZyFmk2Bmo0N6R2/1MlTI7gbb75VorIrfbf6DjQUTfOkhflildre3FAis
         kTKN0GdfD7DNH6wMReT2he40wu7slmAs9CE/Wh1aYjoPAPiCNo/BUMHVok7yCJgmgaMY
         0nT4n0EKeO6vgSxmbP0x/OSm0nFjxty63+ZMxeIEMVw2D3nzNEyiXCzUZwv/fo+jFT8t
         UgOz9yhh3FxLQIW/in1DwV3ab406z6ypwaeZOzZp1JBHs81kJ/+gs+N0zKikwiOf0N0J
         MoFbLp1Dbq0i4JE3gWjursjzNFs5V2nUBty9ARj7dIIVoBJJHlmnHtXWy4M/d1U6JhuW
         znIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmuilfNrcNqikxPSYG2vhAJk/+9dUt/pQUx/utYGH5k=;
        b=0DmjoXgAi8oB+Dk9kUdMJ7lrB4NbkCB7sS8MBsAkL9prVZ0hvebdt39V2e9Tn0IDCV
         xEfgKK5i0ISIE4IJMJIsWjudMcGl2DoB6ZrBy0lh0ffMkOtYYXqVHS7h2N1P28FSkQQH
         7RadejIHkkdgBJrnf7icCVyIm0SX9g4q8SLNBNlPskW0eJpUVi1aPevHa3qVKwIc7Ihg
         MCu5W75nBxjfmboGPWEgfK5cwwZod2flJh3kvhIJZ5V2evGMKxbcwLBSKOeNIyfZUJB/
         VhXHwgnbyIyyTNkH8pdQay4Wr2m0d/zmeRkcqjtneW6BrCD4GJdityOJn9NaY9ZC4SiS
         oXVg==
X-Gm-Message-State: ACrzQf0O+d1VVfD/FqpTWH7A7BjL08+RItC+GpxyuMD7XSzCUaWlzvPM
	xFzc+fiDO/qWIk4fzAJInSNiyQUg3p1RAw==
X-Google-Smtp-Source: AMsMyM7Q0yeYb5wFXwCeBrpSaw14wriK0tzg48T7lR07J/ma1mMooVOlI43RbQ4I4yKAwsbXnHJAQQ==
X-Received: by 2002:a2e:7d16:0:b0:26f:abac:78cc with SMTP id y22-20020a2e7d16000000b0026fabac78ccmr1291644ljc.70.1666106511457;
        Tue, 18 Oct 2022 08:21:51 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512078500b0049c29389b98sm1883127lfr.151.2022.10.18.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:21:50 -0700 (PDT)
Date: Tue, 18 Oct 2022 18:21:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018152148.ok3fmq6vuu4kbd7q@mobilestation>
References: <20221018145808.681327-1-hch@lst.de>
 <20221018151421.jeqe2bi6nyj3afzi@mobilestation>
 <20221018151625.GA22639@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018151625.GA22639@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082205_712244_AD45F120 
X-CRM114-Status: GOOD (  18.13  )
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

On Tue, Oct 18, 2022 at 05:16:25PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 06:14:21PM +0300, Serge Semin wrote:
> > On Tue, Oct 18, 2022 at 04:58:08PM +0200, Christoph Hellwig wrote:
> > > An NVMe controller works perfectly fine even when the hwmon
> > > initialization fails.  Stop returning errors from nvme_hwmon_init to
> > > handle this case consistently.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > I was going to resubmit the series taking into account your resolution
> > on this issue since patch #3 still needs to be resent. But you just
> > submitted a fixup patch. Less worries to me. I'll resend patch #3
> > separately then. Thanks.
> 

> I already have a locally rebased version, so don't bother.

Just to clarify. Are you saying that you have already got a patch for
the sed-opal driver which fixes opal_dev.{cmd,resp} buffers being used
for DMA and takes the Jonathan Derrick note into account?
Here is his note:
Link: https://lore.kernel.org/linux-nvme/cce74aec-61b1-d5eb-1b62-746e45ebfe69@linux.dev/

-Sergey

