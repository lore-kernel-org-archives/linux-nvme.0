Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2682EC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGDgdOIlKlWN/TqJdzPi47SvqzYEA0jZtanNIJOdVf0=; b=VlhDMJ60z7MeFpe8IQBppcxEpF
	upnE4PcAuWnaG7b9+bbah9UR1dPjf3U9lMPhx02+YV0pbkfdfkDi6jmVpy+flAd4Gk6kWcEU0iGXR
	pmRTgVuWV5k6ServEIspUHTcA+B9dj672fHTvtU/mYxf7+cx7k/cIzSoyhjUAVk3uE/j3pPsJDjOU
	acQJJJ2rrpMehgCuoap1lqqiV6nudJrITZxkbV0pUIF887S/O45ZUtC89dOJ+lyGqe83HPEt0gn+O
	gd+S/ncLMczU7iaPwSrGVVXBGqFqLFxm5/paELE6j6ivKzg+q5te4jiOHgC4bc5MglN00YmJNu8Of
	CPMDb61Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCif4-00000007qZq-2NcH;
	Thu, 30 May 2024 16:29:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCif2-00000007qZP-0LiZ
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 16:29:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2744B628D9;
	Thu, 30 May 2024 16:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9EEC2BBFC;
	Thu, 30 May 2024 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717086590;
	bh=U524ZsUAKhEOk9ZXD2PhVrMoPv47pKeE5YxH1QOhi6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1hWotsEj/PGHpHmsglcb9ykLfNB21fnIkIMQnsA46iL9+6S33raia6A6t63xO8PR
	 +n5P96zwh+5soi2+EA9A+SJZw+bk+kElozKGNORNidSc6Y1Xq3F1j7sc+CIoXXwdxF
	 Yc5eRvcWTRZhpZhqkUFen4v4Iw3NwMPsOCam2sAAppMiWKYo2OYh2GeIfk1E9kSC5D
	 mrzGdDSH2fSSp0DnZhKI2UPFr2/rKlxgTkjBssezEniEeX/ddsKgnwsWy8vBRpbks/
	 yFVSiAgjgOxbZlM9D0CuAd6FlswV5oCorEmVkH8zlEjcqD8pDSgLPVi2M50rFBNUQb
	 MmwPFye+TTZ3g==
Date: Thu, 30 May 2024 10:29:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: blktests nvme 041,042 leak memory
Message-ID: <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
 <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_092952_270079_0EFB00DE 
X-CRM114-Status: GOOD (  12.46  )
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

On Thu, May 30, 2024 at 09:25:24AM +0200, Maurizio Lombardi wrote:
> ct 30. 5. 2024 v 8:59 odesílatel Sagi Grimberg <sagi@grimberg.me> napsal:
> >
> >
> > Lets just do that... and add a comment that we don't want to add
> > function calls that can fail post cdev_device_add() because we have a
> > cleanup problem (with a short explanation), so this is less likely to
> > come back...
> >
> 
> Solution 1 will work even if it's not 100% perfect because after
> calling device_initialize()
> you're supposed to use put_device() to release the instance and not
> free the dev directly.
> 
> (The nvme_put_ctrl() call in the error path just releases the
> additional reference taken
> by nvme_get_ctrl() just before the call to cdev_device_add()).

I noticed that too, if cdev_dev_add() fails we are supposed to do a
put_device. This driver seems to be making it difficult to use the core
device interfaces as intended.

