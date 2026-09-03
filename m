Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D46C624D7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DdIokEjR3Hep86CMJFAfHVJnSB6eCK9wOnMgg3FzaAE=; b=jsUVSC+ziGGCr6ybn45T6CByPL
	e/Xg5ZEGSo1eRWgecCmWRoii+d+bcBbjoJdSTJTgcyPPk4RezwPLm7CQt6J8KxO1FWeCos057YYNA
	C0poW5+MKdIa2IU90AjKJNSEdjfcqW5O+trhMwf4GH1N6qbWpjHkJBOr1o02L4r3spuaVgnTHmVJ+
	56o1NLCjH5PSN3nCMYJgJeGudj6lLNrWB3IZIvv2AQg6YLjh/f9xmwBugYO21QryHNbNeeCAMMiGZ
	z2roPKWUXsV5MEzNWtefdyNsijBYdOHqyEJ5xyqtg/nj06FOw+xGK3RwJFVY+ho+JreIY2/4WLBtu
	TZuaOUWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2ELA-00000000a5j-1KbU;
	Thu, 03 Sep 2026 20:47:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2EL9-00000000a5Z-38zb
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 20:47:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C4D9E60219;
	Thu,  3 Sep 2026 20:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FFC1F00A3E;
	Thu,  3 Sep 2026 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468438;
	bh=DdIokEjR3Hep86CMJFAfHVJnSB6eCK9wOnMgg3FzaAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XDJ7Q8RslubZrqmsTngCVxVXwsvE3+cN+KH6XxeWw/4/sPTROE8nMw3Gqm7J3Y3wh
	 C4Dm8BJhUEySA6Cc/1eLuwTimcDXnCxv9jocQpCyIp6iZrnbjSGIms/bSDFtOgFPJH
	 DQ/xTbK2Vfyh/kn2dO72I18ITYqvZiQ2AZ9gxwommPWSdU/91lhXYilwJhuiRVfLpT
	 iSUYmtM6qpz3ufW7d8Zs53keaoV7UYjJX1KdUoUZ3c+TvmY2ByfJSjU4ISF+26H6iz
	 Ec42jGto/v7Xx4rROjIoq5MWrUyLn2dlpQ1zeGfyLGRiMIvmLAHo3SZKWz7CpL7RBt
	 o0I3GW9E+b61w==
Date: Thu, 3 Sep 2026 14:47:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme-tcp.h: drop kernel-doc comments, fix a few
 descriptions
Message-ID: <apnc1ElrDkaTHwdY@kbusch-mbp>
References: <20260831060501.3482765-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831060501.3482765-1-rdunlap@infradead.org>
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

On Sun, Aug 30, 2026 at 11:05:01PM -0700, Randy Dunlap wrote:
> Expand @fei into @feil and @feih because the field was split due to it
> not being 32-bit aligned.
> 
> Struct member @hdr was described twice in struct nvme_tcp_rsp_pdu, so
> drop one of them.
> 
> These structs are defined in a spec outside of the kernel, so kernel-doc
> comments for them aren't needed here as well.
> 
> This avoids kernel-doc warnings:
> 
> Warning: include/linux/nvme-tcp.h:95 struct member 'rsvd2' not described in 'nvme_tcp_icreq_pdu'
> Warning: include/linux/nvme-tcp.h:113 struct member 'rsvd' not described in 'nvme_tcp_icresp_pdu'
> Warning: include/linux/nvme-tcp.h:128 struct member 'feil' not described in 'nvme_tcp_term_pdu'
> Warning: include/linux/nvme-tcp.h:128 struct member 'feiu' not described in 'nvme_tcp_term_pdu'
> Warning: include/linux/nvme-tcp.h:128 struct member 'rsvd' not described in 'nvme_tcp_term_pdu'
> Warning: include/linux/nvme-tcp.h:169 struct member 'rsvd' not described in 'nvme_tcp_r2t_pdu'
> Warning: include/linux/nvme-tcp.h:187 struct member 'rsvd' not described in 'nvme_tcp_data_pdu'

Thanks, applied to nvme-7.3.

