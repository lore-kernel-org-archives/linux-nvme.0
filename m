Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30706C7EE2F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUdtr6r3PmoAaW6qIy5abu2LwEp/uvxptQKJhnykm/I=; b=G4uvjEtq426q14aqWRvpk6beZa
	/8RGmQI4HgaiQ3weOINTvxFDQ9nRCkfUvEG5GcD6vrNhr4Pj+l9bqyLjsbaGpOd4mdFp8Ld2+ikRb
	nLIZb40Oc048JMg+VVon8QLCb+/l19zg+bREvAxMtox8kFW4zP/l7muW4xXr1mIlTXk6INhdrok5N
	INYzbcpvKTypmSK+mH6OfGPoV6Gog4lvrbY7nSwMgLw4Wq1IfRx7F+F/E3S9vgksgfuFLBNlKJoVe
	d1l9A+mMY9y/2Wxn85DFK4OMNapZWMYW6sHSugc59Alt/zss74imTdZ/3/hNtjQW/EGnunI3p7uxY
	drwtSV0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtO-00BHkv-1Y;
	Mon, 29 May 2023 17:42:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2iFX-004Umz-1w;
	Sat, 27 May 2023 00:57:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 110F761B07;
	Sat, 27 May 2023 00:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E64BC433D2;
	Sat, 27 May 2023 00:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685149058;
	bh=3vBQ3hNzB1htnPz205IbCSBNbcAAWMD/jc/FlGUItp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLfMMwQjdwdNcKtVFIzBBfhEKhzY8608s+2D5qjQ0I+cctckwK72Fr7Ero4sCyOay
	 M/qiFF+9oqlrfB5lFVHgvB/IQFsOfaf9ms4w4pJrRSwroXILirP80J7tw+IvtlmrB6
	 C+axsiXhIPb8oG6HjqUu7w30SCHCFMI12quWVnGd07HNn5WSmjsVZ80qw6vSUhzlYV
	 EFiVNxsX5sNgu7rqArJbv4j1C2nsqWjTEvKw/tWgLNDZQKKWCIFaxsDirhg7FmbgbK
	 bcJ2BPiFi68edlfm+RtL/oOWB1hkdQHSRtYO/JKM041QmrEIOMfmOFV+oB8n4stFXo
	 EfbKoqmE3Uf6w==
Date: Fri, 26 May 2023 17:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jeroen de Borst
 <jeroendb@google.com>, Catherine Sullivan <csully@google.com>, Shailend
 Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>, John Crispin
 <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next 05/12] mm: Make the page_frag_cache allocator
 handle __GFP_ZERO itself
Message-ID: <20230526175736.7e75dcf9@kernel.org>
In-Reply-To: <20230524153311.3625329-6-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
	<20230524153311.3625329-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_175739_684553_5A2FA524 
X-CRM114-Status: GOOD (  14.47  )
X-Mailman-Approved-At: Mon, 29 May 2023 10:42:39 -0700
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

On Wed, 24 May 2023 16:33:04 +0100 David Howells wrote:
> Make the page_frag_cache allocator handle __GFP_ZERO itself rather than
> passing it off to the page allocator.  There may be a mix of callers, some
> specifying __GFP_ZERO and some not - and even if all specify __GFP_ZERO, we
> might refurbish the page, in which case the returned memory doesn't get
> cleared.

I think it's pretty clear that page frag allocator was never supposed
to support GFP_ZERO, as we don't need it in networking.. So maybe
you're better off adding the memset() in nvme?

CCing Alex, who I think would say something along those lines :)
IDK how much we still care given that most networking drivers are
migrating to page_poll these days.

