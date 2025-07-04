Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFAC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZwMhquw0UykZyq49vqhe/PlJISp6s5rTBYRngFt8cc=; b=xwDmA8RlqJ5bAT8yKbyjJX8xnd
	pLSmyLt7t7QCT+/clauv2tj4z0Hbotu7Q7PDoFQW9VihkuuvbZXbJ057j5gO6Gn2oI/92u8/CGIIv
	5RRAnHE5PrEmGKmbk85JS/s3Shc4EobI1lugx3vcs4yYJKNrHbDpIc5jvBXpObnLfoVqNQYZqfmJq
	7yuv+/YLenHl1YLVrooEfflsFH1uW3o6hBomN4Wc2IKbM9r7ZPZKl8juDaETxDdN3IZT6KRCS5VXp
	WxD5GSkA83HFlUEgUqYXScCRSLthMLU6WYPcTen/zX6timSoC+JU1gT7tfP9yBcOFW8EE04N5ZY58
	7ktU1ZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXh3r-0000000Ebzx-2Gpv;
	Fri, 04 Jul 2025 14:06:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgix-0000000EYgG-0gyr
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:45:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D8C85A53752;
	Fri,  4 Jul 2025 13:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CC6C4CEEB;
	Fri,  4 Jul 2025 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751636705;
	bh=U3nMWen8wac9iRLyb1hTreClQwaB6dhklFoVx7XgCxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9cCz12L7UL3Wm63FMSHtzyWrO82sqYhk62jOZ27qF2IsO50Me4cehWXDvZt0Y0vA
	 NyFqkUiCIklIJ4FyLMN0RyFCfwNIiSmoc220wY5QQhOPqi0k99NyNoj5Z3zfQxiqKx
	 EEJxPh56pc2i0XE1DLPzSpiP6M9jdaLH0mA00sf0=
Date: Fri, 4 Jul 2025 15:44:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Jeffery <djeffery@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <2025070408-starlight-pandemic-0266@gregkh>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <CA+-xHTH2rxWwAao0EuNbhubqA2mrXOTZ7r1p-hcTieieomx75g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-xHTH2rxWwAao0EuNbhubqA2mrXOTZ7r1p-hcTieieomx75g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_064507_287477_46850073 
X-CRM114-Status: GOOD (  19.28  )
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

On Fri, Jul 04, 2025 at 09:38:15AM -0400, David Jeffery wrote:
> On Thu, Jul 3, 2025 at 7:47 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > Address resource and timing issues when spawning a unique async thread
> > > for every device during shutdown:
> > >   * Make the asynchronous threads able to shut down multiple devices,
> > >     instead of spawning a unique thread for every device.
> > >   * Modify core kernel async code with a custom wake function so it
> > >     doesn't wake up threads waiting to synchronize every time the cookie
> > >     changes
> >
> > Given all these thread spawning issues, why can't we just go back
> > to the approach that kicks off shutdown asynchronously and then waits
> > for it without spawning all these threads?
> >
> 
> The async subsystem fix is something that should be fixed regardless
> of async shutdown. Async shutdown's use just exposed its thundering
> herd behavior which is easily fixed.

Great, then please submit that on its own and get the maintainer of that
subsystem to agree and accept it as I have no way to judge that code at
all.

thanks,

greg k-h

