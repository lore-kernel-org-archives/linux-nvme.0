Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE7C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zNtdkaQRUfcx/vqx1s+woIZh7Ll5dsRud2MXT3ps94=; b=E+ZdnHvRGgGLVFz80EDl0D96gD
	EuotXxnyHi0mRSThWR5mYI+lSjHEtI9E5znDHx0Qsod9LHHiLJDjSS5IcRRZJzjCQDyO0Q+B8va5b
	cWAhfbFJqj1DZqxd8HjKNVgD1eD/TqyASv5ks39MOfBvupwIE5OJW6S+VKSfElYIh9eX+b/vi9tuC
	xjsyLv7qrebYUw6a8WDE4whXQZsYim8uB/LZGSk03gIQEh+gQrDZhXfmpWgnQhrV6SAi9osQJXtKR
	eJvp6UOQfmUIDpMPjYsOKcvKBKa+gIqPVL2zzKEGenDzr7Jpy3KIHdOnARQzhyy56Jp+W1kFvhM84
	A8LhhBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7IVe-00FiWo-G6; Mon, 19 Dec 2022 15:56:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7HOD-00EuIa-QG
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 14:45:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC6460FC5;
	Mon, 19 Dec 2022 14:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF2C433EF;
	Mon, 19 Dec 2022 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671461112;
	bh=q2jB4wqEtNSHi9tIgkaz6DBpGBgAt+Ul4cmP5WHVh4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxPUJUhziFGW95Iad+fYFNC9hhp2BzCJw/OlBJrRIQaCG/qsQiqmhY9m4flGyDtgQ
	 SexL9VDoUAfd6zfoCnflLEwlcTccuVsGuqofFuuYHds/z0dkYzyxffbwUBj1kdJrr9
	 uT+Zs8ZcU28/yKcFj26BOBd5e7r4eJeT3LTE+JBe64cnNVqjsqFWuD9dJ4NNBlT3Ws
	 DqfbVZGn2JXvcQluO0jYFcubz7K7BAghiTDTVK+59zXfRwOJEJdG3NkF0tnhUOXArA
	 f0BXv6nNd0QmyKmCtD0UkuSwEICONm5BAUejDmb7JodBdAbGe/UG7pKCK9+UoPJkRi
	 GysW5sfDyDRfQ==
Date: Mon, 19 Dec 2022 07:45:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
References: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_064513_990784_C4F0ADE2 
X-CRM114-Status: UNSURE (   8.07  )
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

On Sun, Dec 18, 2022 at 09:08:19PM +0900, J. Hart wrote:
> Here are some consecutive fsck runs done on /dev/nvme0n1p3:
> 
> -bash-3.2# fsck -f -C /dev/nvme0n1p2

I'm having some trouble following some of this. You mentioned nvme0n1p3
corruption, but then show nvme0n1p2 instead. Could you possibly relay
your recreation steps starting from a freshly formatted nvme drive?
Partition setup, device mappers, filesystems, mount options, etc.?

