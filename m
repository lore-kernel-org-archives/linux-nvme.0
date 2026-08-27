Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C85FC61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVyT6SJ1XC4Ev63As2WkQ7SvZcqntdNVSI/mm6dpXks=; b=cmufFUZoDyzR9tfuGVAqkGKWo4
	FzFPJ5e0fHF3pc+VFDZxmzKfNWlIRgVkEIy1FruCABlaU4vS8QAxwXlxvh5eM0Aglq4rwyeJysUow
	D++ZXSeti9zhumGcHyieSCmBKFMYX9bcJMSnFZBehPpgs0kubBV9G4ndi8Zewmk3/RfT/C2gt94Q1
	l0nMM7W70bRr/cEhC+keTw92esF/+pUBv3ENOmc2OkWk+e21xVUn25Sd2hHaJpW3p3xZZr86VYIdd
	Me881riYau6cyUkAN3pAS72hyTSHhtY+Wc9rt1LGmyZa9ZHP6ca0mG0TixNo5rzvNT6eFQDqj4T4G
	CseLuOXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzi0k-00000004puL-0s0k;
	Thu, 27 Aug 2026 21:51:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzi0j-00000004puD-0oMF
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 21:51:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8654942D89;
	Thu, 27 Aug 2026 21:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA371F000E9;
	Thu, 27 Aug 2026 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867508;
	bh=sVyT6SJ1XC4Ev63As2WkQ7SvZcqntdNVSI/mm6dpXks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebPY/f1N2Ot4aeFQ9gH6FxknSvSgg4u7RXPUnffmi2GQALy7b9YmntZ/yE+N+9I2e
	 xk8RIqUhNCm2mdICjFcLzYocPnvyxTIMweKntjKcE8rPbfQ2YRzRfrDYIW+uk/PuIa
	 LNgTufCqhQx2v2UCNwVsVi/w2j/a4TXwG5od5gPVxKOTDyE9E3Re78r/vd2wC0Icvz
	 Xn26+vzhlkvdpvke/t4UHt+zUixDUimi437H6noqXqUZovJUK1lTihveZn5+IGrMC+
	 5Flm71feo5qFdiQET2D8TRNNkN/a2m4xP3icidZXA2+f+XfuSXudGQqSvruid8zu3A
	 9u/PvlyE65pLw==
Date: Thu, 27 Aug 2026 15:51:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
Message-ID: <apCxcvW33xppjCf_@kbusch-mbp>
References: <2026082755-stucco-champion-2bb9@gregkh>
 <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
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

On Thu, Aug 27, 2026 at 03:24:55PM -0400, Shivam Kumar wrote:
> nvmet_tcp_handle_h2c_data_pdu() accepts an H2CData PDU after only checking
> that its TTAG is a valid in-range command index and that the command's
> data buffers are mapped. It never checks that the target has actually
> solicited that data by sending an R2T for the command.

Thanks, looks correct. Applied to nvme-7.3.

