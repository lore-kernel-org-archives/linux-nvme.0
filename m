Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C3CCC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7pyNGqh+SbryYMg1hFxXJ7uKTFQB5hqKmPbvQYFBI0=; b=kgn+dsv2o1blG6njVO9+bgsI8j
	5HRvlzZ1EHiRK5Uv/esdcnqDRkgU1T/SSj5cMIYiU0MuF4QzItmJw0px7VT3yDKk/HgsasSrJtaVf
	77FnwVxdo/deCM/Jfwv1dx798su8ToZOV2Rf7aFhoOiZpJBLW9ZSYSSc43AzMioZnhF2wnrrHkEIz
	jPLisZ5UVo3C4uIJt6erLJmW2GyqTmen48Zmm3Uf85qda+Zw2IuV0ixgODJuBu8o8aGARkSkvd9fw
	xY7m8W7fQy0k0/99XfCI34yQtai912dOC/n7BtKrYjL+jMVFRgUjyC+57FFHGeRpyachoGEudJWrI
	0fmyPOZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzxY-0000000FjF9-0Jnp;
	Wed, 14 Oct 2026 14:28:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzxV-0000000FjEv-3kps
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 14:27:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 641A1400EA;
	Wed, 14 Oct 2026 14:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243E1F000C4;
	Wed, 14 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988077;
	bh=B7pyNGqh+SbryYMg1hFxXJ7uKTFQB5hqKmPbvQYFBI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=irkxCvfv758WtQRJ32C5x1JbWXyNYhw7VbuSHpcl1SUKwxBkHo0P397A0qRVKTeuY
	 ZV/FqHvVKaMLDd5QldjCd9LDR0L1Q7zNUIOpZ/GZusd40FfF9pXzWw4DWCsHMNpBi+
	 PktjkFavSuiIXozvi03UdHaK/9FLKZvaXa0H2OVtx1IyFXDkQ6SpEa81j11FChqwor
	 dgU+kc4C3tXvx5Dub62EhZxDECeMYtSBclNfKdbiah2bAMusDnPIVoIdiQrzFgzGt7
	 e6W/mPCN2nW/Hc0A7JGengE2JkQwFn4VBXNRMylRymriRFeaA753WmVhzRB7FX3/af
	 hSZFxgobc045Q==
Date: Wed, 14 Oct 2026 08:27:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: martin.nvme.dev@gmail.com
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v2] nvme: make the DH-HMAC-CHAP secret attributes
 readable by root only
Message-ID: <as-PhyF3rsVXcNdi@kbusch-mbp>
References: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
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

On Wed, Oct 14, 2026 at 08:02:57AM -0400, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.nvme.dev@gmail.com>
> 
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
> macro takes the show and store functions from the attribute name, so
> rename them. Writing the attributes was already limited to root and is
> not changed.

Thanks, applied to nvme-6.4.

