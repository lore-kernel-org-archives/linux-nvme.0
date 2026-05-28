Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1696CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeykLMNh+i+b7z93yrRsajfDkm1hrJ8KBLp1SggWrKM=; b=jNeikdK/1eCrJfsBLtchI1amgo
	4bu634QXzgmdPzcPK0MMPxJTohTFyAs4gLLoyfoZD/5ER5Ki/3t9WR/gURM0LwT5fxCIEBWFx38f3
	KwsJyDsPPxEe6kx/E9QlrUJ2LtI16tgs3H/Faa5NKQ06LCxJhIhhGq5sXvOtGpHPg6MEr0859ngIO
	LH6BVxOu+LOhdq6RKXBIV3Fp+UAqsFLj7qv/ZSC9KFSHdcbF50Jm2n4v8zeZWQaT/sBnrRqEnpIem
	B8MUukuRtLrB5oUjAKz2eCPZOYsWU6OpKzxW5L+0yhFMYHAZ1yJRVaI6hDHD3QslfI9IgM0PHfur2
	36iyWgHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW8k-00000005ONW-1FOC;
	Thu, 28 May 2026 08:30:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW8j-00000005ON2-1nmC
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 May 2026 08:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WeykLMNh+i+b7z93yrRsajfDkm1hrJ8KBLp1SggWrKM=; b=cq3VMP3NC4VQbT166D0lioU+FM
	JH3Ab6Lwt5AR9dsgMnkYDMzpzW9Y5/gkNW6H7A9jjpeW2Z/4NugzMVh8mXLSaaMUcEeJIUtZ8+iaI
	k9m6V6B8LKEdky9aIVYpbvSU7CxQVWyYSKUT30pDgYg8wt/k3VuAt5ji3PNcFR9ZmpiBGc5L9BVLb
	3o2RgZ2F8sFQKttlzzum912y6LVVXmF5Y+NvGAltDzrcklM6FXdt0xOqylNli4N5z0OaVMADjusee
	vGWk9C1I9a7p5Hy2GwTqwkZIZxdO6mIXqGC07VgDXOp+xphLsdGgJqkDuzfHl/ERXHI+27eqvPgcb
	Fh+jI8JA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW8f-0000000FptC-2ZLr
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:30:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA44E68B05; Thu, 28 May 2026 10:30:43 +0200 (CEST)
Date: Thu, 28 May 2026 10:30:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] nvme: validate FDP configuration descriptor
 sizes
Message-ID: <20260528083043.GC7073@lst.de>
References: <20260527133205.GA12042@lst.de> <46b82f1d635ed01017fcceec5d56d5cfd5cfcb79.1779930057.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b82f1d635ed01017fcceec5d56d5cfd5cfcb79.1779930057.git.gliuxen@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_093050_095615_7028CC4D 
X-CRM114-Status: GOOD (  10.55  )
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

On Thu, May 28, 2026 at 09:43:26AM +0800, liuxixin wrote:
> 	<cover.1779930057.git.gliuxen@gmail.com>
> From: liuxixin <gliuxen@gmail.com>
> Date: Thu, 28 May 2026 09:00:37 +0800
> Subject: [PATCH v3 2/2] nvme: validate FDP configuration descriptor sizes

Same formatting issue as the last one.

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


