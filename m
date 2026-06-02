Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085D4CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBN7+LCKUuURwXu2/RKNcqi0MvqbJNp++LcpFA1slnA=; b=P+tE+bP3N0a+EBytQCFM+RGqwk
	h8hMg1WfnVP45EZgytrsSGzPPk0eUmV+1wJm9ecasmmTUHOY13yOFy9gf9+OesuDxa06DoVcm6fLS
	n/n+5UJ/45dg5MceioTv1NFkhz+GV3F5Urun0jHHo2iWt9HBANCXDxabBY/e9fge88DVlC4GutfGI
	Lg65uCoHerYBVID90rNB37iSWUdIEWXWAVDel1hAlDYBrMob4lbIOITBHVAmhq8eHFuk4bJqBA0Yy
	g8qV/tz6I2yuk+a6jrG2WVqyAPTWP/KpdYKwNmp69695IspnCklYOsspqhP3znPKNnt8ocT+XXCxJ
	f/+NAw8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMaO-0000000CnX3-2Dgw;
	Tue, 02 Jun 2026 10:43:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMaN-0000000CnWu-0t13
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:43:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 658CE6012B;
	Tue,  2 Jun 2026 10:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF21F00898;
	Tue,  2 Jun 2026 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396982;
	bh=dBN7+LCKUuURwXu2/RKNcqi0MvqbJNp++LcpFA1slnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcV/x2VeYtkg5UrNU9uOcrK0TMbijwcJJ4toN0W6+5548cpZqaaR9NWLhSGy+8oSF
	 K8t7EzxcQklb1nFS1xNxnXyhDXU7bH9dg0DcEjHhR29y7dfK4CwHKrkmXRMbAzMdrB
	 3sJ6AxcHv7PPkZXo0gC0ydXyYczOb8q8Ot5u5cAYekMudp+Nu8C746mJlC4qJDvP2H
	 G43vGNSNW4CAV7HJdoo6xt1N4tWd6xjWye96QYgKX/u9PTShz/wNHSJGQF7CG/9PF9
	 xU4abwF2FgkIsIyqQMLNgvhcK9/zb8jTEVFu4tu3kKhOMVWCS3JxeAi5qLxKk4F0/Q
	 RQ0y8kxELSXuQ==
Date: Tue, 2 Jun 2026 11:42:56 +0100
From: Keith Busch <kbusch@kernel.org>
To: hexlabsecurity@proton.me
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me,
	kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in
 Discovery Get Log Page
Message-ID: <ah6zr4-8hLlY-Gzn@kbusch-mbp>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me>
 <20260527132353.GB11071@lst.de>
 <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me>
 <20260528083537.GA7590@lst.de>
 <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
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

On Thu, May 28, 2026 at 04:02:17PM +0000, hexlabsecurity@proton.me wrote:
> From 6710e68439c458d691a4fe5c7fa354404745dd0a Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Wed, 27 May 2026 15:00:00 -0500
> Subject: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in Discovery
>  Get Log Page
> 
> nvmet_execute_disc_get_log_page() validates only the dword alignment
> of the host-supplied Log Page Offset (lpo).  The 64-bit offset is then
> added to a small kzalloc'd buffer that holds the discovery log page
> and the result is passed straight to nvmet_copy_to_sgl(), which
> memcpy()s data_len bytes out to the host with no source-side bound
> check:

I've manaully applied this one, but next time, could you please just
send a proper patch instead? This whole thing is badly formatted. Have a
look at the raw message:

  https://lore.kernel.org/linux-nvme/39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me/raw

Just use 'git send-email' on a 'git format-patch' created patch.

