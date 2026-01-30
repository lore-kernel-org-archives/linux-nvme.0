Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE43EE6BF10
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 20:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfa9qNd55QW4deU/fe2d3TuS1Nfuo7eInj1/Dwwn9O4=; b=xQYqHmkErkG5UrRnDMoacjTMTa
	d1iPnnGkTLKV4FjLOSYHGDHwcNLkRzw5n8I554TKNgaMdDlIRc9eMXxXbXM8Tl3M3BFqi0wgA2NZ+
	EgKmfqA0XW/xwEcVCcYU7lcW97C59K6OkF3aYdyoK38HHkQmiRbrbYHmxgnPmOGS6LBCdGQCBzpeA
	TwwWhVwYGOnOVatiADsMxkKc8fYhU43fhNaU5CNt0E/EXzjtxNb18cBvzbAPd+EZ8EwxOM3cYt2NL
	5RyyJ7jLq214VFXCOL1aSQUrHowtVsYKU8D4xH8kP4QuoVDey39JSNa9Ddd7K7lZt2ScZqY3CFFHM
	lZsdBl8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlvB1-00000001wYI-47Yt;
	Fri, 30 Jan 2026 20:33:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlvAz-00000001wXG-1HqD
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 20:33:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2046B440BD;
	Fri, 30 Jan 2026 20:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BB6C4CEF7;
	Fri, 30 Jan 2026 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769805188;
	bh=F/r0oh/AHPrjMPzJX69Tab82CVvC61pTxEqlx5KojXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4apg/Jm/MV5mFYMG8N7oZhi2sWTKWUYwT+2+kSBg4lAJgiM0m64WfLEfjrS3b1qM
	 5iDswCun0jwGwai4b3ldAPxvvDlOkcWrT+G9BUFxBul+a1wkti6cjorfXl5GM1QtTl
	 ro3XBuvk5kepFtNJc5e7yuUQRAw3XY8mbYnU4n7GnOafjvth0XIcbhSFxzwexb9zSp
	 jmOkch9rsfXTZEnVSno8YUC4JyrM0brWR4T2QAs2B7p7cW9CHmRBBRgS4xPKru/JNy
	 l+JnDY/rrRGVkUJ80fctGvXSO5XgIt5AqGkCbAkiqP16jeH5aw75W5u3hanB6Si2/v
	 09sorQQqHhSvw==
Date: Fri, 30 Jan 2026 13:33:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	wenxiong@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCH 1/7] nvme: export command retry count via sysfs
Message-ID: <aX0VgduYJckUaZ3O@kbusch-mbp>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
 <20260130182028.885089-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130182028.885089-2-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_123309_368372_F0920A0C 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
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

On Fri, Jan 30, 2026 at 11:50:18PM +0530, Nilay Shroff wrote:
>  	nvme_req(req)->retries++;
> +	if (ns)
> +		ns->retries++;
> +	else
> +		nvme_req(req)->ctrl->retries++;

I don't think admin commands ever retry with this driver, so probably
not worth tracking it.

And as unlikely as it is to happen, might want to ensure it doesn't
wrap back to zero. The size_add() function handles that.

