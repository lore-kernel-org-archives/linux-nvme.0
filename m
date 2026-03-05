Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC3F47CBE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3N6x5qBGz0ipyP8W7/D2fFEs07YW7D6/DW/veEtgvjs=; b=vRd2m5UB1AsVts47yHzdUOkJGK
	bkH8bqQrvGm9qG+8/mrTeYH6HVsXFHjVU/bk0tjD4dKgbIk2Dv9u0hQ/WiX2sUBVZDnZ42o3L9MtI
	FiYkDgHghyrvAFaENx9MnrNjuUMvYNy145S346EJRiLYbcgRAhKQSIP4fRmdn++3tzKmWBEiUvVZ4
	Cc7Mps9x7cBsODoLuIBdAi97L2PnhG9puXhVtOLADx+Rooyx+JPL/QT4sSXFJ8RJg77MJr8Rqf/9y
	gspH7EWQy9N9AzNpncmzSBEd4hxf+cV/TXmiBj/Q6LU5N/dU/08vEj01N4bEB96l9e2ygfds4snzK
	H07wBlbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEQQ-00000002Si8-2Tgf;
	Thu, 05 Mar 2026 19:31:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEQN-00000002Sha-2SNd
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 19:31:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E92640455;
	Thu,  5 Mar 2026 19:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907FCC116C6;
	Thu,  5 Mar 2026 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739112;
	bh=jiH3cPo01fWhlFeVyhSM+sERjE9JFWIPvuBM/2lEIvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUfeNTTrgvv4qxRcxJhMGTT2RE8xIq3C9hocWsyhnSD3lk0r//nJVHVlmtU3t80m/
	 71/yZOiF37x+dmie0YaOBZPIQUtIulfFyLevxKD69agNwtRfckvCGU8C7tyETFyQbl
	 CICXvpVfykoXUg5S/HP/dZf9DX4s6oq63NT6ld1TBX+bybTvsyp/fGcFOl+apUO9lK
	 Hv10VoPmjubMgU7a2Bx3GZVJ9s414wqDLGtY76H5iEtyUI61/XDsXoZk7/tUWKEckq
	 lHZsKs633G3WAUCL7R2gASGCBEV4q/z+p3ahxWmWjoZ5rfdjq+tgx474QJcmKchfib
	 UbmB7A28C0mFA==
Date: Thu, 5 Mar 2026 11:31:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <20260305193150.GF2796@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132327.GA15515@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_113155_647915_8920AC65 
X-CRM114-Status: GOOD (  10.10  )
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

On Wed, Mar 04, 2026 at 02:23:27PM +0100, Christoph Hellwig wrote:
> Thanks, this looks really great:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.  I assume Keith will pick this series up for 7.1.  Keith, I
forgot to include you explicitly on the recipients list (I must have run
get_maintainer on drivers/nvme/target/ instead of drivers/nvme/common/),
but I assume you received this series via linux-nvme anyway.

- Eric

