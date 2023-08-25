Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0DAC71133
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSoodF+/yO9T3TSHu/gc2D91Vzq+Or2TIuu34gY5RO8=; b=FO62mFI7qhsMvLFp8K/Dyoj1yf
	anrJ6ql9qlc2DafqyAh5Z+xcfCx9YKYmS+ZHkU9o4hkYy3jb6pDphax64DWY5OXJWFBwN8xM7b7Ro
	t0dKdesvo+uO0rmzLm0i+H1VKoBGjkpeLT9LrAAq3K0YmljthX9j8GvfFSEb+JqYUlp98bLyL2i8E
	SRovMoBdSuICxdI3L4w0KPXjW1risJO7MmFy09AIx/L9WE+KFyNZGRzoOy18OuVTKYsIkWoXNGcvA
	+/5X27Q1a36uYbcaZTNmDwvrhnzC4xfEJoxDmD3v1IgtFcGsb3goxbLMj//1zBS+RA2GxeqLE2oNn
	3s1e3+lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZVfv-005Lmu-1j;
	Fri, 25 Aug 2023 12:12:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZVfs-005Lle-2B
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 12:12:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D724662A10;
	Fri, 25 Aug 2023 12:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F5C433C8;
	Fri, 25 Aug 2023 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692965543;
	bh=M3cpTHOb+iXz0DwXB5N8EGyNvTPaJrfg/BGZSnD8hzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvspKuGVkdo0pbXROBUOk3J6Ql0juVzHlQErFSucYWbLrpR4NQFpQfaL+z07nPHPG
	 dZDIFr8dAHPMt36SX+bDOeU1Yx5789p/E4PFcCV8TsY0Xq6bs5NX94a9V+IYGwFa1p
	 1aJfyy0A6ClZRNwsJXR8sgFui1QhfJ5XzZf8PTDg/MnJJ4jVF1G4FD9HWAQ2gyOjPh
	 6qbNF0n5pweHIl6KVKiR3VZ7f/TzIiHi9S7F0o2nnx2kS1DQMbNso96zZsW7yJ/Jcv
	 uMHobIaE9uOsjsAN5fkRi7tGp1Tml1hmAxU0S75odNjtGcKdkFDlyfV9DkLJmhWyGl
	 fTxg5DOTG3RPQ==
Date: Fri, 25 Aug 2023 14:12:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Message-ID: <20230825-argwohn-befallen-9485f981c8c9@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-13-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-13-jack@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230825_051224_822694_3B23410D 
X-CRM114-Status: GOOD (  10.95  )
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

On Wed, Aug 23, 2023 at 12:48:24PM +0200, Jan Kara wrote:
> Convert nvmet to use bdev_open_by_path() and pass the handle around.
> 
> CC: linux-nvme@lists.infradead.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

