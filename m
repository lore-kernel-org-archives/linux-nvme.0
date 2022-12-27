Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157B6C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Dec 2022 17:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uheutZUJ1YwGYloFam3dR5xFy5QIugd63o4Qjx3fvWw=; b=S0p12igbDNb1einXsUrKho4DPI
	g/B2OVwcaG2iWswHyrncIxtjQ6RPAyW9flArUU7/eCx3bgQ/veZuw77+8t9abKARmMCNDe5D86OPz
	+uXhnP3lrCVYVZPPSf1YCsoylVLYKp6VQCBAfiftbsGddREkN+8izMH9e432d7p/iFFVkcmmrD/Q/
	8u9UbwXB9TLzjRT0TKWSWerNoYUpj/8GePvrwFmd0hE8TgI9pDANx6ebnM5CQwiKLy+EXJkSZUHJj
	xsIjvzeyo7SqYH3ZyZVqwtu4rsL6gBrThZQfQvXc2W7A5+CKg9xs50RVGirAeP3n3J7Mh4PNWN36D
	PpuiErgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAE9I-00F5DS-23; Tue, 27 Dec 2022 17:54:00 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAE9D-00F5Ap-Av
	for linux-nvme@lists.infradead.org; Tue, 27 Dec 2022 17:53:56 +0000
Received: by mail-wr1-x432.google.com with SMTP id n3so12274897wrc.5
        for <linux-nvme@lists.infradead.org>; Tue, 27 Dec 2022 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uheutZUJ1YwGYloFam3dR5xFy5QIugd63o4Qjx3fvWw=;
        b=Siw6aYr3/8BkaCmmtUe0LaojsPT06VFSDLNtMj5WCnkaCNBFkOxHFfBBsaW7JtoBCS
         sk4GOR+d/e4ZcMoKULCGfULygYjHCm1waO3l8q2M4t4cL1C90BHcxumPiN6IoZsHJ0Gm
         553eexo/q+bqu/cts6BimMwpyHkCudj0jooFrQ3alU2b1JIWhAPppx/5SFPMX5WyLFTW
         +FklHFpzgt2LuuGWcTe6gco/g9SNNJCrApmIGvL5G/dvZxrNdapbG3I5shKoT0YL4KPe
         zb0M1YgE/0ja3LIFB5faKA+pDtIkomchzEKcakkBm0B1jd0qtY1gpRSApJ4FkqwuUhFu
         n2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uheutZUJ1YwGYloFam3dR5xFy5QIugd63o4Qjx3fvWw=;
        b=F949jTVWjYus1lhTTrbpYVFYlWt1Ewi12lcwCup0tAYOMK3ppq6pOraHohaIEnyNdg
         y6MRfXOnxq5GorBV9uo8jaznS2VoqSn6SgU6ju/GuV+99y+Cw51SyrBXUVclkgbSZw26
         FPlV1Syf9OgnEjY20LcCCJtxTzcgHj8mCE0FOypTJKIq+1+sf+L63E2Gmt6HpLZa7NLu
         nUqn0o8wrhj2biZ8S8+0uO3ZdRax2AlcAcIkmrwCBuJcGm1zUaE+lapnT9qEj4zPnjvQ
         um1+fW4kMOybpjzhPqWUZVHpLgZexJ5lp1vW8OPzPyn922cAprlPPtjenn03p+2YZXI3
         E/Xg==
X-Gm-Message-State: AFqh2ko+yLrDO0CTUoNTU+kOjw14+vGso222cn4rMoauUeFGMBGCFZvg
	uJUZdtx6kXMTtkFX76csRNw=
X-Google-Smtp-Source: AMrXdXtmDhJoQQBCvvH/p1TRK4qXRp/Dg1m6EoksiI95Jny4X+RNPbs9LiOh50sbf96AAP3aWzlCkg==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id bz16-20020a056000091000b00242733baf28mr19814253wrb.5.1672163631946;
        Tue, 27 Dec 2022 09:53:51 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b002383fc96509sm13314708wre.47.2022.12.27.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 09:53:51 -0800 (PST)
Date: Tue, 27 Dec 2022 20:53:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-auth: fix smatch warning complaints
Message-ID: <Y6sxLFLVvFmaxGzN@kadam>
References: <20221225112851.351885-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225112851.351885-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221227_095355_435203_D51D8BFC 
X-CRM114-Status: GOOD (  10.60  )
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

On Sun, Dec 25, 2022 at 01:28:51PM +0200, Sagi Grimberg wrote:
> When initializing auth context, there may be no secrets passed
> by the user. Make return code explicit when returning successfully.
> 
> smatch warnings:
> drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing error code? 'ret'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Awesome.  Thanks!

regards,
dan carpenter


