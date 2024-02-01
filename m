Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17181C4828D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLPdCvsUCPJzXM0/sHKaoHH5Acy+bfHEBUAwhcIHdp0=; b=KcnDM+BXMrP8tNEiJnai6F2v9i
	BcyfASaU5m2WVNV5Tz8NfdTBQAsw9pAs980SbpBA46czz7JJLTaLca3jOPXrwWuxrrc0JlNVwgAn3
	aFh/vnGATtbl0lCdrDj2BnhaxYtP8Yh53apUDk5kX2juNtd7yYhi4SJXvAe8nPxlQveyeZMjynffS
	k+uZ1+XSQuUNQsryL35kEsbfA/59rSF3o9zXKGVD2WxQ2KY4uvc4KWx0zOqJ99zL/IYoTs/EunSFx
	ZCc18TtfbC2Nxx6d3+tywLVQYvKc/m2p42SluHh5AptniRXxJGrY4cxHNx4Pt9vYGUs1B3b+6/Qdz
	ArWx/KiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVYrQ-00000008PbF-1ZrK;
	Thu, 01 Feb 2024 15:20:16 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVYrN-00000008PaS-2yvi
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 15:20:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ED7A0CE1E66;
	Thu,  1 Feb 2024 15:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B8C433C7;
	Thu,  1 Feb 2024 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706800811;
	bh=NJ8k/M4K7ga2oaV+2nOdHIZNLT3Ef31OGGrdew2UNNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuHU5K7huoa3rVXMHwO4Yu0KqGC9i1j8H92ADYoTwrAKQ5nPqeCGz3GxCu2gchC7J
	 D81ZYZ65fzXRGC4BrIK2Sz5GfYwcroSGpGFTnTGZBMl7GHO1Oq9TYislnlQi4eqQFm
	 JSYlCqhg1dBlORGZF1Ag5PutX7D1Jlnvl9oLoz+MW3hX9hsxwHKy/w1FgbNjsWd5BN
	 DDvp1DfC2RLMKTnzJoeOavxTpugIsZlY0q44BcaGuhhst2P1EXGPXWsFvZPQaRaUEC
	 9qkiUCkMZSKdvnQOGfxVUW03fmwxIPUcKDn4Oty+4SdCoZ3Kxvb07I+n+5l7kU25rf
	 vGMW3cdKkcHxw==
Date: Thu, 1 Feb 2024 08:20:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Message-ID: <Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
 <rbpa7bx5rfhnlhnrzucz5hi5szflkvihdtdmuksuccekwy53qf@nbotapgudm6r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rbpa7bx5rfhnlhnrzucz5hi5szflkvihdtdmuksuccekwy53qf@nbotapgudm6r>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_072013_946248_472C9E69 
X-CRM114-Status: GOOD (  15.10  )
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

On Wed, Jan 31, 2024 at 03:34:14PM +0100, Daniel Wagner wrote:
> On Fri, Jan 26, 2024 at 03:10:37PM +0900, Shin'ichiro Kawasaki wrote:
> > A recent commit in nvme-cli v2.6 changed the single letter of the
> > --opcode option from -o to -O. This caused the failure of nvme/046. To
> > make the test case work regardless of the nvme-cli version, replace -o
> > with --opcode.
> > 
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> Sorry about this. We introduced a couple of global flags, -v (verbose)
> and -o (output) and this changed a bunch commands. This was done in the
> quest to add JSON output format support add to all commands.
> 
> I will refrain from doing more like this for the 2.x cycle.

Changing intput/output is always going to trip someone up. Maintaining
backward compatibility vs. improving the design is a challenge.

IMO, though, scripts should always use the long options. The short
options are convenient for hacking away at a terminal, but they're not
readily readable. The long options are more descriptive for when you
have to maintain the script in the future.

