Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087CC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmLRlU3RkidElvGJ3ROUjwOZ+zx+L+cw76uy1nI2ldI=; b=lYf/E/oaoDynaeHHrCbWruIZVn
	OcI+iIvnFEsNRbjVONut2ePFhHHauEOy67faZ3Xmv4vhYLjGMW/VTgjI88YRmkkjFNN+OTVLhFHCL
	1K3aer2x/AxcPQ4B3s1fKBGDrQCNwTjob2ya2tIkRzHtSikAXIwfSPQTQqhJ9tzP4jF9TNUI8vR9a
	BdO6Bt8tKp/jiTUlqUookMviCyvQPLGZXuSvELCZQaNiDuTkcB2wCfYDEINdm4cWH1zkL/k+UfUj0
	ieKtttH6gpNurglG/DuGc70OJ/qei3vy4LnSqfLl5wsPh1gOeHZOhrN1OT1UA06UP6L65G98AXzAs
	eNyiMAJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPen-0000000DUcQ-2SKu;
	Tue, 20 May 2025 16:17:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPAo-0000000DOpG-09rG
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:46:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ACEBA5C5798;
	Tue, 20 May 2025 15:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191AFC4CEE9;
	Tue, 20 May 2025 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747755992;
	bh=rChcasa9L+BOd++7NWSBBfQY338XTkmbluXv6ZdONKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCdxXt9JhUVokoniJirxGZOpUiNeeiVwcadgos+N56aElGqxV3x+WjpYo+EklH9iZ
	 /o1iRCimrUOu4MyNDSuvx8Rdt1TrDFZd39IiHFOPlQ4qt6qLpcs73b39FcHNl/e7hh
	 EcRS+irUDY6W48xIJ8dtgnoCES0F0JoUHKfEeimeZh7tiQmYgRZ4d3W2ORW6c3DUeo
	 ZJIFlYp2qk5E5IPOIn4pn+QrIDOrYfga63tRQlWeDf9n1RX/kls0iMKAdwCAFbhvJu
	 29qUqmn3XdGYKriqNWIjpB2j+HFg7z3HVbQj2FuSl49KYEnmgt8bo6Of40tU9u5t8x
	 zm+OakPeThnQw==
Date: Tue, 20 May 2025 09:46:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
Message-ID: <aCyj1Yk6UT1x0Ysj@kbusch-mbp>
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
 <CADUfDZpkUnWqtiMBOd1p=Ws2HuQDZhLr6xNYGmfXswwJ9BXpmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpkUnWqtiMBOd1p=Ws2HuQDZhLr6xNYGmfXswwJ9BXpmA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_084634_132314_AEFE0F23 
X-CRM114-Status: GOOD (  16.40  )
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

On Tue, May 20, 2025 at 08:42:36AM -0700, Caleb Sander Mateos wrote:
> On Tue, May 20, 2025 at 8:28 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >
> > nvme_map_user_request() takes flags as the last argument, but
> > nvme_uring_cmd_io() shoves a bool "vec" into it. It behaves as
> > expected because bool is converted to 0/1 and NVME_IOCTL_VEC is
> > defined as 1, but it's better to pass flags explicitly.
> >
> > Fixes: 7b7fdb8e2dbc1 ("nvme: replace the "bool vec" arguments with flags in the ioctl path")
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Keith had an earlier patch to fix this, but looks like the series
> never got merged:
> https://lore.kernel.org/linux-nvme/20250224182128.2042061-4-kbusch@meta.com/
> This approach also looks fine to me, but not sure if it will
> complicate some of the changes Keith wanted to make.

Thanks, but no need to wait on me for this. I will revisit these
cleanups someday once I can arrange for fewer distractions, which may
not be any time soon.

Patch looks good to me too.

Reviewed-by: Keith Busch <kbusch@kernel.org>

