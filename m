Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2C6D637A8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qyB8N+3JfV6lb35el2DpbeH47uBTypoiO6BlPDTUkjI=; b=zBvaRb+iDuofgWz8Fz1uLmohDN
	W4k6JHCkZmD8b9ZE9OfVEoLQXQ1YAyP/Q+Xcz1ev/TTAkxhVnvZxB0lHIqHQZxzZjM9MIglSv+p0v
	QDryTFGwXR4jlmD+lcqGlvRT5OIS0+spS/ShKk3MGIFiD2gGoiO9wKDJCV0eCGzhaBEuHf+QG1tUd
	q/uYe/ZBQHgOsz2R8Kce99+8Ni+I1nyJVVWDIqGc3bgG1jMekpN6/dWC3dbporpW1Vyn6uQR3s19v
	k3VCCSoCoDz8ESm1X9googFbRmQiZ4VLTwCJFFeLuVV868stYTDddIsug5jOwCJeghyfN20fCJzbJ
	9Dwc1BWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIoN-00000007ooz-1YAl;
	Wed, 13 Nov 2024 19:13:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIeS-00000007nPg-3ZwI
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 19:03:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 094FEA41452;
	Wed, 13 Nov 2024 19:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7ADC4CEC3;
	Wed, 13 Nov 2024 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731524619;
	bh=Ih6n3afma8hugiSd02MVTojr13PQh5SNuHn4AQX0Ya8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDymXMZhLQ/Vq6S0sM45/V1tPovTNJlSfrT0cPHtmiD8HHMfGQ8PKT0jhI43uvbYl
	 AzuinSRrll9KcFaatx/X6OO26gB06Zp710v16Qy0Iusrb8jBXtibVzv1vD59ihx7e2
	 kpv3xJf+tKSeyjhxLS7zayx2ni9+WxH1bt8dd3uU7fouCUHxHVTRImH6o5hfRXzvi1
	 cmwjoQZMZHZ4/gUofMCHPpV7KlxmHem54qM1fYptYarl3+1eFKNXuE0BHa6K4xof35
	 hKElXIDUnh3N10qMNtYqewYAUEbEPtRzipapGy7V5iU2D3wpXYMbSvx1maqrtKlj5r
	 2nhpBBd+zl0VA==
Date: Wed, 13 Nov 2024 12:03:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
Message-ID: <ZzT4CHjrmD5mW2we@kbusch-mbp>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113152050.157179-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_110340_993832_D7870858 
X-CRM114-Status: UNSURE (   8.77  )
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

On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it

You copied this commit message from the previous one for the nvme
driver. This message should say "virtio_queue_rqs".

