Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF2FC77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZwOFaZCsGo5Z6NIy7+xs42xc8Amx32M/il4XYJjhbD8=; b=NpAabg1d9aPSLh0aE47y7KYwZB
	CShW7q5v02vKzK+XCEK2Lltf8US3i62LhpCtAUt3GFJuCftjtCESxD8ItzvCEu0aLCs5xuiqTRn6k
	VaLOE50E118+1IvHSAchKvqPl8jVh5nfcZEAsAr6ho34W5l8XFdUdHu878BNX7sktNn7Iek+gffXM
	JEVp3wIxjyaAmwx8cJuIZzgXmhzFPf9+HzKsSNW6RerFYGP8Ats/mi64jG+PqJKG/eJfnIhRqphhS
	NznO8MoVQaUcqP+O/LtQePHdeTiukw9dsKw7Lh10x6WJTViuiwlNElhJ89DDQ7TIQ7M9Sw+jHa5wS
	9dVNheIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtP-00BHlq-1E;
	Mon, 29 May 2023 17:42:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2iJw-004VNm-16;
	Sat, 27 May 2023 01:02:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BD690654B2;
	Sat, 27 May 2023 01:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C2C433D2;
	Sat, 27 May 2023 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685149331;
	bh=ZwOFaZCsGo5Z6NIy7+xs42xc8Amx32M/il4XYJjhbD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fc1jYAjBz04h3V8l4htX8rqAQJ7PLOdb2JvNQpK0YOjXOKXp1btTR69FHHfS2RMsH
	 TWLelyvSzOoucga78KhbNqg+T9KMUfMvD14ABNMLfviKBWEQn0op8ewHeXzb1OH8cf
	 QXEiYWrKiValrxacMzVe+xfy4a0SMfBj6lSrnsGkHPO6BMeQigISxOFjOUjm1xsVU1
	 yuK6nr6zEi1I71vC3v/GFVMLMmswCpXZ7H4PIdjGnwItwx8jz/IrFaaUbDMdNWwmQ+
	 wYisGm+TES66BOFTwuuFf95hMqee1x+CabpMF3pk8eH//byAghGAMNWJQaSOwdUmSK
	 rrmfwWQTNAu8w==
Date: Fri, 26 May 2023 18:02:08 -0700
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
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 06/12] mm: Make the page_frag_cache allocator
 use per-cpu
Message-ID: <20230526180208.3e617818@kernel.org>
In-Reply-To: <20230524153311.3625329-7-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
	<20230524153311.3625329-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_180212_441271_3ECB48C4 
X-CRM114-Status: GOOD (  10.90  )
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

On Wed, 24 May 2023 16:33:05 +0100 David Howells wrote:
> though if a softirq wants to access it, then softirq disablement will
> need to be added.

Pretty sure GVE uses their allocator from softirq.
So this doesn't work, right?

