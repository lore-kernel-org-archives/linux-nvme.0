Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986CDC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dwLhTSzpGkLN32tbQ+jJ/dJ9qzSQoYfUlh3m/q7Q0I=; b=brcxxlLXsybGO2MLjkxX5hIfsi
	gUQmLvhOAaobqX1LJSAcYYP5OA/mcdXMDpYrRfrkYwqixfv4Vy412dkV8deu193c8Hs334SsdJ8mZ
	S5dU9FM9ZTkiHfK/BjJzu2THULPzwPnxAeaHMIeI5Y/gVk6l/OUNcTtuRM/w31QqYmZkkMjudYVcH
	knyNGo6xWH8aiCPEnIhSqvcALM43LPHk+x7PA/FeAayWLTV7XaxMQTsUpqJ+RGNS/AjMrsvsaCdNr
	fRS88eB00Bk7yy7b8GsMthBg+Ee1ONq0AtXjkg2wT6grIFCvmpyk0KZT6A1p0FqXiSc6+3jLZxQpr
	c94gS8CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjwQ-0000000BbTS-2wqQ;
	Tue, 13 May 2025 07:20:42 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjwN-0000000BbT2-3ng2
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:20:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 04AC8A4C8B7;
	Tue, 13 May 2025 07:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03402C4CEE4;
	Tue, 13 May 2025 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747120838;
	bh=eQJ5ZXUwh3MvMV9IDCdqU3NKPE08Yk3L6A9yj8lz6Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kanzj+85LHT61FZKNduodaSgpOQMJW5faP7XBl6jXmtpQcHOSqUbOlQXrKxTtJgWp
	 yFGku+uPkWl7yA1n/N48a4XgfouMv1+LCEoaQydzvwb4Y2JglfIca3TA0IN+yWMhJ4
	 y/nSZjNc5j0RDhbSdR17Hz78p7Bix59TljKQZrW91rT2izIvD55dn/+DGmRqNJgAKK
	 3NkG63uLTE36NnMj+vweS8WDNiSf58w89fKiSTFZ2V5cLtWgLhp1H49Kx+pXjtDWEI
	 cTl5YfhncWm20JhO0sHZB9ZDnwm1dQcG23n6B+7GbcWlEjtDIok1K+JxIooadtfIOU
	 e6IqvwY4p/uaw==
Date: Tue, 13 May 2025 10:20:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/7] nvme-pci: use struct_size for allocation struct
 nvme_dev
Message-ID: <20250513072034.GG22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_002040_011945_39AE17AA 
X-CRM114-Status: GOOD (  11.01  )
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

On Tue, May 13, 2025 at 09:00:23AM +0200, Christoph Hellwig wrote:
> This avoid open coding the variable size array arithmetics.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

