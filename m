Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ABC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qh5uamJ4YA8DNHf9pxrg5W2J2ciBrA8C7XUsiXJj69I=; b=3a9zRUIXrLHiVksCDKt97puYqi
	Swnz6xwJp2uYX0Bg4zpXzNaXR2AALPWtJdtyHLMQP2/fI3Byg4qha6Al3u2TbLUEi2SfT86CY4C9X
	Q/8WhmSbrML7Wti4ZRnQChg9in9ba7qQTZXx1AiohLaKlt+ab7vYhGL6EcFAhWOdspRccGZaxrBGX
	7jx1TetX4gIKfj05Epn8k1BAKE5d6d5bXXOZYUWxCXc7LZrcP8MwBHI7L9GnBmKBm51lc/GieWouj
	0UcxCZN8QNzCJ0n0sCaPvCxbR0k5homBn242w+A2V0g0JGcjzHRZDyJITTtUeLE9jiwRtM2WmKlKp
	ghcX407A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKMN0-007Wof-Vv; Wed, 16 Feb 2022 15:37:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKMMx-007WnZ-2z
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:37:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B0A9F61805;
 Wed, 16 Feb 2022 15:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDBC004E1;
 Wed, 16 Feb 2022 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645025845;
 bh=I+IHN3QtzQgKlFIznUtesTPsmN7eEeSUDNFEEEklp9Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MuGqmnIb7BpYuRfUZZSdFx8Ua5Yt89S2MSLSXX76BqSbl8l/bBGnXSwcuE7eggss1
 bxSZHfnAqPffhQgRM1Id6AT2bNhZhrill7s/0wc6fOo9uUveH2gUl3UXSzvEn0er92
 Rn6u1UJSIydpWFPUvZAuhq3q7YdfYnCVdoT1VoWB1YxdVIgQ7NKdW7hsBc1MUqlakM
 kOJ+ezZ637As5qiZQ78ZUWD2y6MW7DrOy3TbuQWK9LFUMkdm+NRwwTWXUB1fBEX9pB
 L1nzgT0OjFoUmMwPDRGjgRYrlc0LVawmggLGQNYQ7l8asoZo0WDd03hbGXOUtY81M7
 N4bbHD9S/xGIw==
Date: Wed, 16 Feb 2022 07:37:22 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150901.4166235-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_073727_216225_1C4F666D 
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

On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> -	fsync_bdev(disk->part0);
> +	/*
> +	 * If this is not a surprise removal see if there is a file system
> +	 * mounted on this device and sync it (although this won't work for
> +	 * partitions).  For surprise removals that have already marked the
> +	 * disk dead skip this call as no I/O is possible anyway.
> +	 */
> +	if (!test_bit(GD_DEAD, &disk->state))
> +		fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);

It used to be that any dirty pages would attempt to write, and get an
error on a surprise removal. Now that you're skipping the fsync_bdev(),
is something else taking responsibility to error those pages?

