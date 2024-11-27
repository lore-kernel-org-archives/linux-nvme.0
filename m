Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A88FD6ACEF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ml1RozNff94B0BhjvZJCHFry3hci8UdXXXA6OJ+EpJk=; b=17MvB5BZZaEtKTquNOqwHCdIyr
	6yjrAGYINMyA+CsG9/Kd7429KbTG2a0Z055oLJVt+iB2wvU3YZQpGldJKr4eQUGe+4Hhv6opt+bVM
	76Rlug7l2a4TFcIACow03U2ftThraHu148WX00pkr8lMQfnyt+xB4zmAwG1YXGWz/V+OEKK6Y6hGZ
	AsOelykj3b38GFDrESDVaGfFYCDG75z7gt1C+tRF8Szp8pgGAYd7agkgZZW0NNErsPZOyN+SaV7VA
	jDWmJrtY89//r8UycKXkA2feD+xX47m8ZpaizbC3GcYeuEp6u8dEeAkmwqk4BY5mxgNiX1m6U+gSE
	E9xWb0jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKE5-0000000DXb0-2cs8;
	Wed, 27 Nov 2024 15:45:13 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKDz-0000000DXZl-1UHQ
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 15:45:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4FB3FA40463;
	Wed, 27 Nov 2024 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94557C4CECC;
	Wed, 27 Nov 2024 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732722305;
	bh=qn7sxpy1KiYCfhU0sLNJxOceZ8bqcKtFJlugKbw17PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MofcEBMxZVpsLPLTyG3Utk6LTaHXFZximjaII2NSLeVQ7MLBrON1/oJiEnONf8h6s
	 Q1gpipFbOx5QycFoSj2Fpugj4/mbua1631HFY/RjUbqPhtSBo03QP/bTM5n2Fat5xx
	 Nu1jQczPFmfTDyyj+5oWvXAHlqKJ/tIZj730Iw5VVQJkmgjL9j1v+lfSRuKWD/Fc5f
	 WrjbEuYnBRqlly6Sz/BHvQwRyPl/mtJ8B07/Mvo7HEKwmhU404BTkOXD6UvBbVKoHT
	 I45ydRoof4woqiAyTwEiAVWycPrND04HNZt3XHHyi8SmRWINRJBKEMKGvLdhvYctTC
	 5E8I947d3tZZA==
Date: Wed, 27 Nov 2024 08:45:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Message-ID: <Z0c-gFbw4n0SaKD9@kbusch-mbp>
References: <20241127064218.42688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127064218.42688-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_074507_458231_E4158A52 
X-CRM114-Status: GOOD (  14.65  )
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

On Wed, Nov 27, 2024 at 07:42:18AM +0100, Christoph Hellwig wrote:
> Commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of
> nvme_config_discard") started applying the NVME_QUIRK_DEALLOCATE_ZEROES
> quirk even then the Dataset Management is not supported.  It turns out
> that there versions of these old Intel SSDs that have DSM support
> disabled in the firmware, which will now lead to errors everytime
> a Write Zeroes command is issued.  Fix this by checking for DSM support
> before applying the quirk.

I still think this is wrong, and we should just remove the quirk for
this device. With the exception to this firmware version, this device
generally supports both discards and write zeroes. The only reason it
added this quirk was because the quirk used to mean something completely
different (specifically, it would set the "discard_zeroes_data"
attribute that's no longer used). It didn't mean to prefer discards over
write zeroes, but that's what it means now, and that's not what this
drive wants.

