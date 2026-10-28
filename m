Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967B606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UmkeICUF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te3eXccs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4ApRypjtvurvU8lrMAvVl2EvzMRrjCy3MkYP8jr8EAk=; b=UmkeICUFi+pW166/Hw3rDmdtZS
	Cf9IViiwxalg7r+xEYmHJd70kbo7oKitUjbYLTG1tfrRwhVrbDvv24D9IrE0uY6IG2RjiAM6B5qFN
	N/+7TpxaMNbRBboba9wCR3ASpI9xcyiKt5SZNf0GD5TYMPyVpenPGvO5SNv9+ObBWP41f49yqvqJf
	/z5INI/2MH5R1tRcba19MgKvMmD8KRQ2j+634YMyxs7BBDYae/MCW4uUrqPZheuTBX8X8nZDZOOtN
	58DZE8rfI9XKXm0SmYkkrjmG2uB3f2A0Tbe8FwoTPkg/X/GXDk0rYfv5x3OnxoiBwu2To9JI/GiN4
	GoiDzAew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM51n-00000007GPD-1HrK;
	Wed, 28 Oct 2026 14:53:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM51l-00000007GP7-2ZFc
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:53:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C308B44508;
	Wed, 28 Oct 2026 14:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441941F01828;
	Wed, 28 Oct 2026 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199200;
	bh=4ApRypjtvurvU8lrMAvVl2EvzMRrjCy3MkYP8jr8EAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Te3eXccsimcAhBFgCflRDCKdZnX2NngBUXpllFjHfYidqlci14bgVUbEczVoBf9lM
	 2iQeil42ysT//7I+gNeBTHMQLsVkVHBtiW3lYcK6U5+tUk1TwbwIa4T7WBu6EKZIAn
	 DfBwnHv/eUdYZi++3LdbWtobxUWi2yAjibSfcf4B+P+JWODKJ0gSuuaf8kyQeUFnA+
	 L2zsYNq6yzwQsKfh9kPRixrK4xKFXLKxE0ZB8OEp9jquaqKXLADbcNYKNtDyB18yvh
	 0VF78Q8o1xQjTe2jX5mS6Dd19kghsrYrm8jSFdS/7nGhiFSGv9Cy3fXMnA/SCnYi7e
	 r6iw405Dzinrg==
Date: Wed, 28 Oct 2026 08:53:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, sgogte@purestorage.com,
	wagi@kernel.org, kanie@linux.alibaba.com, nilay@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme-tcp: fix NULL queue->ctrl dereference on
 reconnect
Message-ID: <auIMXvQcd3JdJbNI@kbusch-mbp>
References: <20261028143343.221936-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028143343.221936-1-christian.aurichzm@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:33:43AM -0300, Christian Aurich Zanettini Martins wrote:
> +/*
> + * The I/O tag set is allocated, and grown on reconnect, before the queues are
> + * connected, so blk-mq can initialize requests on a queue, and dispatch to it,
> + * before nvme_tcp_alloc_queue() has run for it. Set up the fields that do not
> + * depend on the connection once, when allocating the controller, and keep them
> + * until the controller is freed.
> + */
> +static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)

The comment here has a weird cadance to it, with all the, comma
separated, thoughts. Something more succint like "Set queue fields that
don't depend on the connection" would suffice, but I don't think this
function needs additional explanation.

Anyway, no need to send a new version, I'll just remove it when
applying.

