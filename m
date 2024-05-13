Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D50C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 04:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxbkHf14amdHsrWm057Yk7FRpmdQJweT5/qFx7zt+TQ=; b=mzu9ga09Xi8IHiMAxi5Ht/weAK
	wbK2ApUb4y4B971XREvipDoqM3krz5CMkYF+ACuZN3blPvd0aG6QpnucmOSpurkKO/YQAt09ccV6a
	0hoW56EOyrDeiqe7pNsjG/QA1xFmYTjQJtpA3b2o6SiIPEZoFr2D4q2BrNpi9UigydB6VRmhXuMlG
	xZDj6YskeMN14YC76RcrmTyFb586J8aiSxA6/WAh0DT5kI6dCUGyaTw1OBryeZWTXQW4hcB08LDWa
	UobSA4slrm6BKtirQjdUgwfb/8GGXuYxD19/Vu4lLXgJ26332JiHnFFqEYnhD6ommgORdupQZ3XBs
	a0sT0QHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6N0M-0000000Baqm-33lq;
	Mon, 13 May 2024 04:09:38 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6N0I-0000000Bapz-2FMm
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 04:09:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8AAE7CE0302;
	Mon, 13 May 2024 04:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91875C113CC;
	Mon, 13 May 2024 04:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715573367;
	bh=97xzNdFXn7bXOhErhH7/34Txqp1Fv9DyzwIOOKmyNpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2mVsuIfyOEsff90ewqpzE+c9bogKeONQUB4ED7gar2zqsLUPlYt34EzuL6Adskzz
	 nKi54hJpYs6HX9czwvgmdDrxT8fmj/Hi6OZ2Df7JosBhBtOkVIzlqsipNPD4qhGx6t
	 IsjXiw+yuvnWFfBhvwWfJ2xLrOLqdl/qxWi9GZuahEXD6YccvqamMlISpQkykJb79+
	 Qc3Y3JzQ6LoVyP4gtasNnjKc+JYqjq09wpLVrXbXxPlNJlsWNN+jtVm9pyLso+Ok9g
	 qOpPAVPedYcQSZK6eqpUus0qs8xShHNqEncYIpafWhW9vx0JGOgzdaEv8VaYLY9Ylf
	 hsL5r/A8aD1wA==
Date: Sun, 12 May 2024 22:09:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkGSdj_bI_oDp4Gz@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora>
 <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6/gqxxDD74IYR6@fedora>
 <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
 <ZkFpGlEMs4yHL+Xv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkFpGlEMs4yHL+Xv@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_210934_780910_33261D65 
X-CRM114-Status: GOOD (  21.20  )
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

On Mon, May 13, 2024 at 09:12:58AM +0800, Ming Lei wrote:
> On Sun, May 12, 2024 at 05:16:13PM +0300, Sagi Grimberg wrote:
> > 
> > > > Everyone expects nvme performance will suffer. IO latency and CPU
> > > > efficieny are not everyone's top priority, so allowing people to
> > > > optimize for something else seems like a reasonable request.
> > > I guess more people may be interested in 'something else', care to share
> > > them in the commit log, cause nvme is going to support it.
> > 
> > I don't have a special interest in this, but I can share what I heard
> > several
> > times. The use-case is that people want to dedicate a few cores to handle
> > interrupts so they know it does not take cpu time from their application
> > threads
> > that are running (usually pinned to different cores).
> > 
> > The app threads isolation is more important to them than affinity to the
> > device...
> 
> That is exactly what CPU isolation is doing, include 'isolcpus=managed_irq',
> isn't it?

As I've mentioned previously, that option is a no-op when the incoming
mask matches the isolcated cpus. The use case for the kernel's isolated
CPUs doesn't align with the use cases for user defined IRQ affinity.

Let me redirect this discussion please. Is there a techincal reason why
Linux can't let users use their CPUs as they intend? They will take out
of tree patches if that's the position we're forceing them into, but why
is that is Linux taking that position in the first place?

