Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CAEC5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQCYldpdidsXXOH3YCXLuw/VRa5qzRh67OUMoesUWwE=; b=03YSnvv84uz1asatip7Xy+Kvnc
	fjNxJp55NyJIPJMc94ltjLWPpEvnOmR5b9ifrkhopqsAGQzV6NFnSYEofpgD5jmKU1oOekcVjN8pP
	EHls1d1d11hwf57393WdgkR6KSv029JQjUN5kBOAF7dU/k0GzFU8VRzTKAwK9RyCzQGV8RMkF/YWP
	y2a/hIzzlTnKksnFMRiw5yFM6kvAYNF5g5UcBNUyRjErG10b8vpCW5a2BIEYyVE8l5+jwGmNQrXQl
	n6IACiJ234zcvNzADN3Ph8cMNYzI4KE5T0LhONRIsh0CwD/0JZHRRMulipfrE3tcVfbItTZ4as5S/
	hFsCV2Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiIB-0000000A690-0AM1;
	Wed, 19 Aug 2026 15:33:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiI9-0000000A68U-2WsV
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:33:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C233417B2;
	Wed, 19 Aug 2026 15:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C2E1F00A3A;
	Wed, 19 Aug 2026 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153605;
	bh=pQCYldpdidsXXOH3YCXLuw/VRa5qzRh67OUMoesUWwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mpcQJS/h/s66BxR7H38UX6GA0nB0tRtuhQ/u/3TLWcdXkWW+ncI0rZ1FBS+CDR/Ni
	 031ygE/vDq2sImrUAdISSDmASSqZmo0oHlgMHXEm3mnM3gNdbZ7VU0iFAkxkJJIlaH
	 zvk5+E5u0FD5YZMAcYNCXZhdJFktnz9mVCeestzE7tOA1m8qcHY3CVSQ/NDWhkv+GC
	 0ZPGsRe/jBufWFUJHDAKjuRPksEZ4nkSIDNTXYrOAacuY/qBm0slP1ClQYsWVzbdP8
	 wozvzqRF37gWhXwXtvQmJoiXx308KcWLg/8c6DGpHkTj4BwFURA+yBxG7j7/r+SHbY
	 n5M9bNhtJfmZA==
Date: Wed, 19 Aug 2026 09:33:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add opcode filtering for fault injection
Message-ID: <aoXMw1CKFlecrXU0@kbusch-mbp>
References: <20260811231152.1138761-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811231152.1138761-1-mkhalfella@purestorage.com>
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

On Tue, Aug 11, 2026 at 04:11:52PM -0700, Mohamed Khalfella wrote:
> Currently NVMe fault injection applies to every command routed through
> nvme_should_fail(), which makes it hard to target a specific command
> type when reproducing an issue in error-handling paths.
> 
> Add an "opcode" debugfs attribute alongside the existing "status" and
> "dont_retry" knobs. It defaults to 0xffff, meaning "match any opcode"
> and preserving the previous behavior. When set to a valid opcode
> (<= 0xff), fault injection is only considered for commands whose opcode
> matches.

Thanks, applied to nvme-7.3.

