Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93355CD5BD1
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b24eVHz8MUC02G/JGsH2uS7uvP8dbxDFQRzJ7hCxvJs=; b=axLSRYDm+dN/OPOoG+svUWdp11
	OdhYPbtqtiJSHt8WQdu/fY1LVMmfxLtIM8UPqnLI3Wsol58CIjrC3ec/Zh2VZlJHiMv3UlXCPN1Rs
	ZZ246FJNAzN3PBr95A5fexasDSM7Jt2qYOhEtF/pfHvOIS1EEKaDbFP3LrWys0GO3UptkH726aCiS
	sIk7VY92KWPuOViZFCYrjxL01GmS0ccHuXULAUKBBFqZhBDyggyaqvriVmpnItdBvLo405v019Pw8
	9Hvr9MmeifRPrFIs9fojUicwj/u6IUxRBhStHVa/xC2wadc0euQGgJb/MCrTUPHaOXdYhHVwnerTq
	Uvww8leg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUT3Q-0000000DbCe-1JVh;
	Tue, 02 Jun 2026 17:37:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUT3P-0000000DbCP-3VDm
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 17:37:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4619E60098;
	Tue,  2 Jun 2026 17:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC21F00893;
	Tue,  2 Jun 2026 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421847;
	bh=b24eVHz8MUC02G/JGsH2uS7uvP8dbxDFQRzJ7hCxvJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oso/TiscCHftZr0R5jssZNTwXj9sFo/Nn5P+uqJjUSkC40MYPeXx9AutHFgzwfZel
	 /jsSP8GwwskFyEZkMbGu9hD9o8hyTvIImZpYMZ9uXopaTaSz0FK29bnWsz8eREPtBq
	 QZEMOPtc0LTMUqrWf/K+C38Bv8Q/Z2JFSOQw5DYmx789i4kd8xomP/hi37J+eoB2TE
	 9s3+UhYoD44Wot8jhmbJUJtVcooR2D3wRPtHw35SEmPfKa3BnaGwqIh3Z9ueleyCst
	 ibhfj7fjDx866hOvgicq6MYH7F1Ns6IX0nIG24N261agZ9O4yyDUCLzMDCj12+E0Ml
	 dk195HxRUw64Q==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	stuart.hayes@dell.com
Subject: Re: [PATCH] nbft: use the correct interfaces for NBFT connections
Date: Tue,  2 Jun 2026 19:37:20 +0200
Message-ID: <178042183382.214157.16095466226130069527.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
References: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Thu, 07 May 2026 15:23:45 -0500, Stuart Hayes wrote:
> The NBFT specifies which network interface should be used to connect to
> each namespace (using the HFI descriptor), but that is currently ignored
> when "nvme connect-all --nbft" is used. If there are namespaces on
> different interfaces, some namespaces can fail to connect, unless the IP
> tables were already set up to route these in the desired way when the
> interface isn't specified.
> 
> [...]

Applied, thanks!

[1/1] nbft: use the correct interfaces for NBFT connections
      commit: 685861ae563e3bcd77f2224d0206e448e426db01

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

