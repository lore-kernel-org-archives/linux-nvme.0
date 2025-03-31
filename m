Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E636C3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OiwQbZVEoLdsUasHkUjyrBBz80HdRY4OjIKtQNPeAM=; b=C4G2ZZH3XY6VnWYVtU+RSYv+IC
	WV7Si/CEG7tfY4KiAWgr6KWKzVlKGd1+d+K0I8r5Sghro3sQ/TYweotneNjAh+suOnnkjgGsor4RA
	wF+ifJ6ClQA34RBxCafVQNkVmHefQZkNneT0a6qgfD9xj7ufMqRBH56kic6cEtJzqUaGb7Cz93Yuy
	kYeqdfXTc4wYT9vXInU2C11OZpbIG7jNCZFwEBbySJxKKfoRaBKGmHF4rhBbAnW2d+sw5Z4Rpz/Nr
	nHrJjzu3VEyElXU8nZLXe5di15GrGtfm7kPdhbnbuGw397N+9EBog66qfZvtJXSmBCCVXw3BfHdRt
	YY3QCcIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzGgZ-00000000h0J-2xah;
	Mon, 31 Mar 2025 15:04:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzGFr-00000000aDl-1UfC
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 14:36:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6EA595C138C;
	Mon, 31 Mar 2025 14:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6394CC4CEED;
	Mon, 31 Mar 2025 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431806;
	bh=saBfwSTx9+zrA2PPu4GkKVVeKaJUPYevf/A5oECr0ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIR7XGd4L3Iz9uJZYZ/LcQjWI9ZXFd2ChMXVauWYXRo3tIRGb1kn3kwp/B7V2Jskb
	 6PDPr0nOrrCS2KTkQp8zwJPJ7qwsdTGnTHLyEHms9ZErYZE8aand4okT8pSWsLgXHQ
	 ybNAiGdg6EORQ4xfV2u4PSKvE5dZq9+IMPgWcQ/IpFL5v5Jus3F7SKMhgEl9jTEds9
	 Wm00667Wx3UtCd1xzPJQlVt1Tz5X0/tuZfQapA2UBXtEU7ZtX9FnNzBxCppbSfmspK
	 86P63Vs1o3tDnvbXpDntX3NkoyoigIUZ4eX25iPgUUmI7g8jYBc1oCgkfIPG0LePEw
	 p5IuDtle2V8Qg==
Date: Mon, 31 Mar 2025 08:36:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
Message-ID: <Z-qoevl5Jaf7WFsQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20250328154647.2590171-1-csander@purestorage.com>
 <CGME20250328155548epcas5p2368eb1a59883b133a9baf4ac39d6bac6@epcas5p2.samsung.com>
 <20250328154647.2590171-4-csander@purestorage.com>
 <48b9a876-0e3b-4c89-9aa3-b48f502868c3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b9a876-0e3b-4c89-9aa3-b48f502868c3@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_073647_451737_13E6B537 
X-CRM114-Status: GOOD (  16.41  )
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

On Mon, Mar 31, 2025 at 12:16:58PM +0530, Kanchan Joshi wrote:
> On 3/28/2025 9:16 PM, Caleb Sander Mateos wrote:
> > For NVMe passthru operations with fixed buffers, the fixed buffer lookup
> > happens in io_uring_cmd_import_fixed(). But nvme_uring_cmd_io() can
> > return -EAGAIN first from nvme_alloc_user_request() if all tags in the
> > tag set are in use. This ordering difference is observable when using
> > UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table. If
> > the NVMe passthru operation is followed by UBLK_U_IO_UNREGISTER_IO_BUF
> > to unregister the fixed buffer and the NVMe passthru goes async, the
> > fixed buffer lookup will fail because it happens after the unregister.
> 
> while the patch looks fine, I wonder what setup is required to 
> trigger/test this. Given that io_uring NVMe passthru is on the char 
> device node, and ublk does not take char device as the backing file. 
> Care to explain?

Not sure I understand the question. A ublk daemon can use anything it
wants on the backend. Are you just referring to the public ublksrv
implementation? That's not used here, if that's what you mean.

