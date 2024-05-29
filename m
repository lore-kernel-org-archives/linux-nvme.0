Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0839C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPWxoo3Octa3ozjVRDKuc0VPnloCrLmkUyiQlQp+JM8=; b=Ro2wJ2MkE7cy+ABX5aiNZgfQqT
	PuDeQ6EF8wVherFvCuDhIjA0F5RM5q+LA++Q/AWqdUHeuRB0Ru2ndXA7uQFpAFjfkzFTOpfFmcfi7
	U8Ue64UozmbZbbOI+V1Xlsvq399tm5QQtlCht58fC9fuZj9Q+JvORsHYS47aGlbHtzT7nmKFNqiGq
	sP8z0u0pbrpkjH2K+4fTH8B58CXSigdpr3Xrxo0dPMUw+6BcTYs75+TUhWbau9pc9Z8livu/rCy3e
	Hi6/QY32KP+frDamhzOgZVg/XS2cY1F+aRwIAfGlW1Q3Dsl/Fm0bkh86WeBVb5xUGnXO1ryAZxWxf
	9Sov/YFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCMTo-00000004zdg-3ZFD;
	Wed, 29 May 2024 16:48:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCMTl-00000004zd5-3hot
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 16:48:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15A5F60E0A;
	Wed, 29 May 2024 16:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552C7C113CC;
	Wed, 29 May 2024 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717001324;
	bh=/cctOPDEH7v0Bl+F00Rnu2WHd+kVaNvOcOeRpEaE3oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0ljw/Nki5X07fVWY3I8YzJdE8Lhkg2yqNinEBQ7+SpjO1vJGDFdihR/zWe0oB5Yq
	 IKAxq2ko+thtlVQhGsqKhU+CJavOaM1mdaIXRa6mJDjgF8wczYSCEBkiv+Dj1oXS57
	 16KczuYBMWtbpac3j713eHC4Kgdy3rPuqndJ40OhYqnvzt9ha3coGrz2uJcFw4r3v1
	 D3SgQubA4GwNgRtC55eAtcOxrs8Shqh2cT+/xpE7w7/KrdZt39WWGd3bh4DOZPHXbt
	 g/ekEiwMBLKtRkKhzmO/ut7dXxFJuVtkrcjFeqnMUZmjiit9rDx3vrP78uB/NTi9x0
	 wkYql8nzMubIQ==
Date: Wed, 29 May 2024 10:48:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: blktests nvme 041,042 leak memory
Message-ID: <Zldcag69LsVZWTNk@kbusch-mbp.dhcp.thefacebook.com>
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_094845_996474_30AF5FC2 
X-CRM114-Status: GOOD (  11.91  )
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

On Wed, May 29, 2024 at 10:25:18AM -0600, Keith Busch wrote:
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5d150c62955d..72c9693e1df61 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4601,7 +4601,8 @@ static void nvme_free_ctrl(struct device *dev)
>  		mutex_unlock(&nvme_subsystems_lock);
>  	}
>  
> -	ctrl->ops->free_ctrl(ctrl);
> +	if (nvme_ctrl_state(ctrl) != NVME_CTRL_NEW)
> +		ctrl->ops->free_ctrl(ctrl);

I think this may be problematic. If nvme_init_ctrl() is successful,
there are other things that might fail before CONNECTING state has been
reached, and those failures need their free_ctrl callback invoked from
the "NEW" state.

