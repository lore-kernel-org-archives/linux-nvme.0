Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7965C44512
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PYDjYKDYIcVvSIln+MGCU7FABx/uEvFLiL7uonJgiU=; b=tPOgI7HNNk7pMGySJ2ybWflxUn
	1Q4iTbLXhFBtYlQFuYE06RNXILKp6qqQAORPOJ9Bb+Tn3ezfypG/3QWOwJMpytQou98NN6/Kejf17
	YB/ym6WrYMrEHTXVOZsLDOmz+q3IClKKBjqXqFQYsoRzureejL2nGGyNA6fxnl9w0CPtblka0JQic
	zOfR5FRTgdJ88gZ83PG/MNxEryj5rFgTXE1G/jEKzdrp4ycOpV6jVM6hs7ITIJGrtl6mFJMg1VLv4
	/S1nLF04DqFuSENBfg1YnhSko6Zztk52Yga3lw0yD9jToreFOLVdkLjxzpAcROHJl4RCcsectDVwP
	8Owjbktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkQQm-00000000KsW-2r2K;
	Thu, 16 Jul 2026 18:03:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkQQl-00000000KsE-0jsB
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 18:03:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CE7140705;
	Thu, 16 Jul 2026 18:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375341F000E9;
	Thu, 16 Jul 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225010;
	bh=5PYDjYKDYIcVvSIln+MGCU7FABx/uEvFLiL7uonJgiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3K+IBqYDM+fUe6P4XUiZKBdSQFWVRWxTJtEsTqbLAX0SdwW4hQxI9eYOXZ0aOwiT
	 iZQRE4jw58uEw3Dr2RG4OaL0QTnG0yOyTgSruw3f0S6qcJ1kZYaAXlI+Ck+TuYlJyF
	 wgSk1ESht0hkqyPQH8jTEajCBsXgDkRVYZ4d5LFfKiZ6DpqxODo0+BZVLp3ub0te36
	 MAXd69LUHcR+VCz+NcYWBfCoSbj1RsVjgkP9paZbHhaYYniJ4XMj0FPCrLoi9WuUCY
	 +1KAhki56wP+OJ790ZKIxzmNITXD2w4E7CzEFQWODEMY3x9y0BDthpVb+KW6ZaxebD
	 naXC5aEFUNKAQ==
Date: Thu, 16 Jul 2026 12:03:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] nvme: fix cdev lifetime series
Message-ID: <alkc8CmRt6JGLTIu@kbusch-mbp>
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713104238.3034640-1-john.g.garry@oracle.com>
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

On Mon, Jul 13, 2026 at 10:42:36AM +0000, John Garry wrote:
> This small series addresses a problem for the NS and NS head cdev
> lifetime.

Thanks, applied to nvme-7.3.

