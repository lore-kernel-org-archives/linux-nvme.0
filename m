Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B948C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ho7QJYtFXdA+Uv1VPG7OSuL494UJCUtlhHP87/+dvW0=; b=hhay+8y7petpjfG2dmgoAMP5fh
	ai+EqTNq5Gj3q8Zr8lZgEQw7SW2SznyRCXQTbTHOU+LE5mb0jQSAWDnNtLwsrRbGWRqVLOAJ30ICX
	2r2Iqt9yQKQhKbTwJF31rflHBFuVEHBmdZUPp2YeFAC2RTsYLWrVXX8vUmSK2woNLfACruNzAeMzF
	OmoOrbdFDE0fuqsZDnrJLZDrrfwE3IAJlI+6gZniQ4737H6UhojeNvg5gFv8O+K2PtuPch918Iv4X
	0Ij5iKiw1rBCdxLVi0VgEdpPB3kmrf6Xxms41THWFrjZ/146U5qZ0qKYRVzfOw5/bbynsRLrCPeWF
	vjBGDHLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoLr-007VPX-8h; Tue, 18 Oct 2022 15:17:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoJE-007TbN-Es
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:15:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E13A4615B9;
	Tue, 18 Oct 2022 15:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01CCC433D6;
	Tue, 18 Oct 2022 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666106111;
	bh=nJkRE53OC9MoMDkut+3wmy6FSfYPw6pLU/nfNYW7TP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktk4xtdDUXExatdLn5iYyjQYroBaiWsdZ0cmINjITOW37leGM2gZNESyTeuoKJs0o
	 aFv4HbnMtiA/mUEgviLrX0izstcNSjZ2DyjLubCcKaQ8Tf26R1MXH4Z/GO5URde0s8
	 pdVn88ja/3jr7W5bZXQcWR3TY+B1dazKtSqqHv7zyLldTir9c/SpbclIsDi+CcO7MN
	 50KIVXBR11gseWLZnNpnFM6jz/guBkYcSvlKWWKPtS0x+utwZFB5fNG91HF+Gnd5sp
	 /pftY3YoDYlrS6O9GqDbHR8a7efqBJRJ5bzXr6CT3TogfYJupjmyFPXQPLuLNiiGKX
	 ZprY4YCHgLwhg==
Date: Tue, 18 Oct 2022 09:15:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, fancer.lancer@gmail.com, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
References: <20221018145808.681327-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145808.681327-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_081512_580723_33C7C31E 
X-CRM114-Status: GOOD (  13.34  )
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

On Tue, Oct 18, 2022 at 04:58:08PM +0200, Christoph Hellwig wrote:
> @@ -3261,11 +3261,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> -		ret = nvme_hwmon_init(ctrl);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl))
> +		nvme_hwmon_init(ctrl);

We still need to check for < 0 since nvme_hwmon_init() sends an admin
command. If the admin command times out, the controller is reset and
-EINTR is returned, indicating we have to abort initialization. All
other errors should be ignored, though, since the controller remains
usable.

