Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC109CD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfP8NKcMlHtMfZcRLcHNeEjsbWbku0UoTWiakaXjTxI=; b=RBLLj/HnFYMBO0XMfQxAbh+zcK
	TjRGGRaPbenH9xlGkKyBmHaqoPepjruF+egruTvUc27tN4XNJ81wXTYHTH0HxTxHZxbvrcOzFi9Yp
	a0pG9kPsT+YRact+kFHKm2YSK/0BUAJACEY8aqh16vmDesl7UZ4dGIZDHOkB5QetLlF9pYbVTjivv
	dM91jhLkm66ZnYBTwHXhHdCZBKZ1aRMEQwXqrstyhSQh+zon8OFnIowQmWyjdc/9OMxcsD0LL8Lfi
	zTUZ8jZHy/O9QjUkvkJ30NQlOAKRQpgcT+o6Hw20CdeJfXJKSA9NF0zCTzk9VAjILAfnCvGD66UZ6
	Pqh8Sffw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZouo-0000000HHqE-0Ln3;
	Wed, 17 Jun 2026 11:58:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoum-0000000HHpz-1C1T
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:58:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4F0C40415;
	Wed, 17 Jun 2026 11:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9D81F000E9;
	Wed, 17 Jun 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697519;
	bh=sfP8NKcMlHtMfZcRLcHNeEjsbWbku0UoTWiakaXjTxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGf7qQy72QyJp1CRbbYfG1VrmYLNTp5zik9OTbo52gyRXWgj1IJeENfjTl44ez8G+
	 am5gXYp8w7XN5Hr9kkeOBzjrwrqpNFXgDlORUf2G0gBnO2ixKZDf1qgwGUJM+HHLIM
	 MkVZs62N4OUS2xzmJpgC0yw3KMQySJPraKOGPXWIGD8bnCybgEztqFT6PBpaOQLavS
	 jcLWk1qOKdbGd/9Tna7P6RVDJuaUVkIxQEp67muVLaw14gUB3NcE4DY1NSp2Y9Nkau
	 i454FWNpVST1IBR9P9geC/scyn+KRjDPLzfkvR/hRitWWWXsvTmMyBsZPXpWmBpFes
	 7FE5FbJ44zhvA==
Date: Wed, 17 Jun 2026 13:58:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/8] namespace-aware configfs
Message-ID: <20260617-unsterblich-fortziehen-quietschen-f52ea8f40d9a@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
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

> Open Issues:
> - I've added a new function 'mnt_clone_direct()' to clone the vfsmount
>   entry (the original code just did a simple_pin_fs()). Not sure if
>   that's correct. Christian?

I think we can put that issue aside for a second as there are a few
bigger design questions.

> - The current cloning mechanism is not really a hierarchy, but rather
>   always using the default namespace to find registered subsystems.
>   Meaning you can only call 'register_subsystem()' for the default
>   namespace. But then one shouldn't call modprobe in a container, so
>   that's okay I guess.

I'm not sure I follow what this is trying to say, sorry.

> - The original content of the configfs remains visible even from
>   within the container, and the new 'mount' will just overlay that.

I again fail to understand what precisely this means.

>   Ideally I would have the container start off with an empty
>   /sys/kernel/config to avoid configuration issues. But again I've
>   no idea how to do that (or if it's even possible).

Shouldn't be a problem to implement this. Just means more work.

So the rough concept in my head would be that configfs is a
multi-instance filesystem that remembers the namespaces it was mounted
similar to how kernfs allows to be tagged with namespaces. It then only
shows/allows registration of subsystems that match the relevant
namespace tags.

The challenge I see is that configfs shows subsystems that may be tied
to different namespaces.

