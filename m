Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE47C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUHXLbw4PSncF+UV30q8W9gxIbZSJpFygIOkkTyPMzs=; b=o0LM8JhmrDcxlM5DSFrUfrdmRU
	EjajqczyjzUUClh+hybkUXYvfpismp7jdQ01UyqUwIw1klBpTnI+h1KXfkbTX8P6LTelKCqyoBqhT
	QUWr4Zjc20YoDQFbtQ1aS3jVslFypWYsYlHtIWSINRjKFJvHuaV64FkwxflyPcig6xKTBbk0nUytR
	muX9RcjpXRo3WeicTMiwsTWz2lrmBFY8YYaAx+x6lt/Bh+PqMZw/GAQPz2A8qjZ8rDntoQ6lyk9Go
	WeXFVxEl5wfjJzjPCRyVVHusCiTJaG3RIaAXn6s9JGtgqSI8MBNu6wWnEgQt9j0lXXqVz4mFyVT+Q
	zt6dSBRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IT3-00000008BUy-0gNe;
	Tue, 22 Apr 2025 18:35:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GU0-00000007uXh-0Dye
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 16:28:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A87761126;
	Tue, 22 Apr 2025 16:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6787C4CEED;
	Tue, 22 Apr 2025 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745339307;
	bh=MUHXLbw4PSncF+UV30q8W9gxIbZSJpFygIOkkTyPMzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSz5iqRvgzAMb83kkkytfCNeIhtAYxm3/9bS85K1gDX3S8KCYhR8i4ZhYw/UwNOeH
	 EF9TjYIiC3LDuZHcnMeNp7oMnUmk5T8siYSONDxBL6Wm42jO4v1qXH0F64fsYHYuX9
	 /qyL82i999PgbBbwiJF3deb5Xw41HG2ai64GgZShhRyAagnI1D11uPOmNi/vlPzNIT
	 Q4v9X5OwXXXpFJUKiZu2MmcbDIjNRfgnAkZxjG9n7jLqIebKWOeiYj6a/HAUrsiFXH
	 bPoVFvXr6gzIDt5bA7a0j7ewhFJWBF+MSUjWTTnPge8c8pP1MGNaNo1KriSbt6VswJ
	 0CVdIrt8E3SkQ==
Date: Tue, 22 Apr 2025 10:28:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] nvme/pci: factor out nvme_init_hctx() helper
Message-ID: <aAfDqHtCwNWclrgz@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
 <20250422161959.1958205-2-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422161959.1958205-2-csander@purestorage.com>
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

On Tue, Apr 22, 2025 at 10:19:58AM -0600, Caleb Sander Mateos wrote:
> nvme_init_hctx() and nvme_admin_init_hctx() are very similar. In
> preparation for adding more logic, factor out a nvme_init_hctx() helper.
> Rename the old nvme_init_hctx() to nvme_io_init_hctx().

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

