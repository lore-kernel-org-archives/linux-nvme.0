Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD72EB64D9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jun 2023 06:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+XHgMbMq0J+uaWFUaNtRknLHAmV6zi3L4rkgEwFtaI=; b=qL208D+TKKWiRw5O9h3wJT24NL
	PmOwPlnRSDnwMDj/hOgQzDM92J+zAn7YPLu+ytFvFWp/Uy7wlLrzoMy4EBFT7QdoWcZITmQiVKeAc
	3UrTDVpg85KCqQQKu48m9QdpZNVNgcp0Pdr71/qnhz+OkHvPHJWHW1UtyFmI9DVDRYq3ZgImQw7hQ
	ryBDRBA6fY8UeZXn34REP4/u4hh/WeCb80EbZRU4IjQGtjFVD1kUPVRUhORdfHZ1iEYpaWgH4BoK1
	ELcRK0JWGP0TZEuLmzg9meY/WMbCft94zrQeLLxFyonbMp/5IusGNnQt4yyxffR0WQD8gjLVNqfL9
	JGrW1zLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAPNu-002rzI-0R;
	Sat, 17 Jun 2023 06:26:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAPNr-002ryf-2B
	for linux-nvme@lists.infradead.org;
	Sat, 17 Jun 2023 06:26:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5C59360CF9;
	Sat, 17 Jun 2023 06:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761ECC433C8;
	Sat, 17 Jun 2023 06:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686983161;
	bh=rezx+M8908cDTpOHPzi+nyIHJCB2oKTpnAepFHfkj5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTabzfWdgptwDPUTFDIXj0nvCQveVgOBY8gKsgkSJcTUDVLxYf3ZZ6eN2R5t2N6E/
	 AFao9CPtQYQjF5cPPV49m4wGqHbOJUX05U0Y2WCAFC6EXpu/8UXKhniUpF73Egou9V
	 7E1UXW84hHr8ydcCupT2w8SMXUgFG8mT2BbtAppmUvtoQausKoMFwYW+TjI2NrxaV+
	 eOCvOhIaLSZlVJLmjlrjijReLrLwSPsv8QYwol5imNLAYKaFJ9YKurSzbuQobi5/+l
	 R5hyM2DbCXBup4UgLd/9tgrwObJvGsQPi/YOfN7YPriTHAJuZR82NvsP8po3h7TDYS
	 RL2qw4iG7CVdA==
Date: Fri, 16 Jun 2023 23:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] net/tls: handle MSG_EOR for tls_sw TX flow
Message-ID: <20230616232600.6a18f5e0@kernel.org>
In-Reply-To: <20230614062212.73288-2-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
	<20230614062212.73288-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_232603_779638_BBD57A7A 
X-CRM114-Status: UNSURE (   8.50  )
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

On Wed, 14 Jun 2023 08:22:09 +0200 Hannes Reinecke wrote:
> @@ -1287,7 +1290,7 @@ int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
>  	struct bio_vec bvec;
>  	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
>  
> -	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> +	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
>  		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
>  		      MSG_NO_SHARED_FRAGS))
>  		return -EOPNOTSUPP;

you added it to sendpage_locked but not normal sendpage

