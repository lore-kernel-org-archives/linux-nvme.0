Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C7CDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 12:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1M20rOLnicch1AJt9tL/DSiAlhfyB+vmDyTkYhot570=; b=4kLlo9Mg8lW7H1ryH940PggtUe
	u+mDbnveNwn0ohlFQGPmI2FuTwNKvf83XneAYq4kMAchTUl1lMyBXPbYzR3QWrgaeKsTtqy17Ukmg
	eXYWJfwa9kYZWJOzYNpRJ4rY3dZ4rP4f4pfKUI1abR0+qBTtjhpYjKCgvPXIulbCSHGBaL5zej9kW
	YQ2HoGjYIcqkeLlfVJVYGZ6lmmF5Ds+FMxUjFsxu7lvmqx0OcFBRMi0kErE0S6dCvhuRUhuqqKvEF
	cAowP4uRHMBGcZiAAjztPonstBEHhrDPi8OdbsC3SyyrWtC6+p7cEzb5oG6kU2mycqbrGsECJnCS3
	fAD3kcFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0LU-00000006H3z-0K1v;
	Tue, 23 Jun 2026 12:35:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0LS-00000006H3c-3KDc
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 12:35:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2506940241;
	Tue, 23 Jun 2026 12:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC2B1F000E9;
	Tue, 23 Jun 2026 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218114;
	bh=1M20rOLnicch1AJt9tL/DSiAlhfyB+vmDyTkYhot570=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MC3szYxKZnUZSPUxBM4S+EYvKC0en1xOam0FmQ0A4yF5ej8oTIYNY8h5TcK5WQChC
	 7TfQH5OqvXFJbX9TjD1EEeaCqwxD3YoseohwK3z2vlz4Ozb18ppdiJf2KYBR0nQdc5
	 6AC9ocAwgeZnOnXWE22XWMZRsUoAy/ulTZGYhDlul4GnB1RdPahGi06RGjw3KGpoz3
	 Cfs2ePG5TgqRwLIkUTLhf8mGDfLQkd8gFuBMntmfAlynFDeD8EohNRiteW6S2c7XW/
	 NYRkTh/krb7t8c/BPJOVvAmtPoYD5dPjUElUqTSngpnLjzldorYQSnRvNVgp9SHigy
	 noGulrnuUIBtA==
Date: Tue, 23 Jun 2026 06:35:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-multipath: expose path_state via sysfs
Message-ID: <ajp9gHepQX-j1-Lz@kbusch-mbp>
References: <20260622130318.2346995-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622130318.2346995-1-kanie@linux.alibaba.com>
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

On Mon, Jun 22, 2026 at 09:03:18PM +0800, Guixin Liu wrote:
> The attribute reflects the result of nvme_path_is_disabled() checks:
>   - "enabled"                   : path is available for I/O
>   - "disabled (ctrl_down)"      : controller is not live/deleting
>   - "disabled (ana_pending)"    : ANA state change pending
>   - "disabled (ns_not_ready)"   : namespace is not ready

I'm a bit late to looking at this, but just a knee jerk thought,
wouldn't you want to distinguish "enabled optimized" vs "enabled
unoptimized"?

