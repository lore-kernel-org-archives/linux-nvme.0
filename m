Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A5FCD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYZSspCnlcWtdxovtmqEqCygbTvVVNxg9U8mlLNO2SA=; b=fynJzJEAmmID1obKuyXQoJ5LjH
	ixjrI5T2ujTCwX1Qro5xjJABXB19uaGStT6PtCs4JSm54Dnr1xZ3h9y9TMjU8biVKKmYcIfjY0Pdo
	4bmlMV9Xv4ypbCQPRSn/ZCZiYr6HMcy2BLIGkli6LiGx7TmdUVMkn51la4UrfML0xSiy7vtLCKW0L
	1hJrajLIkc20JaNVn0Rm8aXx4btPR39M3NaMIoKygcBSlu/jifSKI2F9MPVuRDbmEl2lecRpnjlDD
	Wi2GvqD5vspZaRb0XrZxRS3TyMl5hdlk5rxH0MXyZ3uS8+8w7dBWcZwtHe2ftaVI2OiJqhjpblOAq
	hw3CgAlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZooE-0000000HHGz-1BFG;
	Wed, 17 Jun 2026 11:51:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZooC-0000000HHGT-3RPl
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:51:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9441F4341B;
	Wed, 17 Jun 2026 11:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291671F000E9;
	Wed, 17 Jun 2026 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697112;
	bh=tYZSspCnlcWtdxovtmqEqCygbTvVVNxg9U8mlLNO2SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mf1B+y26Q9JqpDF/hmHwuD9HbGOkMow/sPiNIhiX5BkTZuiiSLXD4FkVJAFB3wcwA
	 R930hfvxFdRJ0tMy5fYID8TMf1S7iCQot/3MzO+D4BnQjZJwH3Xxppxy6J4F2WlBkj
	 R5G7loMhX6b7YclN5f1OcgRo6ClsYab10/Vwh840FNQefrcq7Jbb4cXPnhA1jQntr4
	 Veu7vvq/aoTC928cDuj8WTBcE9VborZkvtsKOxCkJJgZGibvcU/Zvi+KpKrpQLJo2n
	 U7q8fdUXbQ87eoE/iTIvZ8fwk6euuoGefUt55aCGMEzj8jxAWi1lccX3yHCKDZtnv1
	 wRvQzYkAZmeVQ==
Date: Wed, 17 Jun 2026 13:51:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/8] fs/configfs: switch to get_tree_keyed()
Message-ID: <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-8-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-8-hare@kernel.org>
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

On Sat, Jun 13, 2026 at 01:14:36PM +0200, Hannes Reinecke wrote:
> Switch to get_tree_keyed() to instatiate a new superblock whenever
> the mount namespace changed.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---

So I wonder what keying superblock creation to the mount namespace
really gets you. Imho keying the superblock by namespace only makes
sense if the whole filesystem is tied to a namespace. For example, the
mqueue filesystem is semantically tied to ipc namespaces so tying the
creation of a new mqueue superblock to the ipc namespace makes sense.

But configs isn't semantically tied to the mount namespace at all. It
encompasses a bunch of different subsystems that might themselves be
semantically tied to different namespaces. The specific example you care
about is nvme tied to network namespaces. But there might be other
things that tie to other namespaces.

So even if you tie it to the mount namespace you presumably still need
to filter what subsystems a specific configfs instance will display to
each accessing task based on the namespaces of the accessing task?

