Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198CBC19F4F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kuNQNBgtBPmj82HrzPbdr+eSOKVPK/r02FyvgFRDDls=; b=zGehiaVTE5O4UV9ZeNM9faIkDc
	CAcibuTsmPRTk+Ckz5IvZCjYXbRmmGE9EZSGlGwWYkLwXBkF2nNvYksVLq7hZDg45z3KGp3zMUTV9
	sCePrFSY3j+yQuHsoufOElZtiHCsDJA7+j02E5boQTDMikiotGCa4rSeTi00352gjmh6fB3Ze37W6
	+oP6f13o0D2eQGdMPqlbq/4+0xkAGC8Qy8mOn/5vQuDxFpI14gV3Uk3asOXadV152UyjkeFutZ4zY
	RHq4jzk8clykigyaE1TTEDuZS01ktD7bXcmj8cIzuo3DHoUKVPGb3Fp1dYTmRNQbRla4sSzBwJr6N
	GHm9e+9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4h7D-0000000FaDk-14oe;
	Wed, 08 May 2024 13:13:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4h74-0000000Fa9u-1wVh
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 13:13:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 26D76CE18DA;
	Wed,  8 May 2024 13:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26FDC113CC;
	Wed,  8 May 2024 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174015;
	bh=S+L+g5yIhWlIr/9ZvbAOYclCZ1IhRvX6JyjpcHE5Uh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFT551bpIoawyrVHM6fj4ijVIne3bwjA9xNpjJ1QfejFj+ceOSqTntplF2gJq/BEY
	 U7X0fc60ZODbiXO8VXY/5WPVX02fM6F6NgzTEv912OO/3Rr4Y4wKGwOJ5H9E/irAx5
	 m4NjuijYppdoQ7LLzV/+bfUjC9FqJQ5hT4OSDrXfhWpvH5E0EJG5ySQGWJn4KV0vA9
	 5byfDbQOu12uvtUPasQHFNTRkmSRCZ+Ln8b0IW7ufUQRTPe+TGuTfkukaeRlxdlAIC
	 NosoGU04EP3kGw1oDGh25exqHUg1PsY5q2xCJ4mtxlwZ4yHdGFg7bG/mDLJ2gFRUd8
	 5Api71VsrTP/w==
Date: Wed, 8 May 2024 07:13:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
Message-ID: <Zjt6fDIxLupGfglV@kbusch-mbp.dhcp.thefacebook.com>
References: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_061338_710612_61C1B27E 
X-CRM114-Status: GOOD (  12.22  )
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

On Wed, May 08, 2024 at 10:43:04AM +0300, Dan Carpenter wrote:
> The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
> endian data and we're on an error path and both of those raise red
> flags.  So let's make this safer.
> 
> 1) Make the buffer large enough for any u32.
> 2) Remove the unnecessary initialization.
> 3) Use snprintf() instead of sprintf() for even more safety.
> 4) The sprintf() function returns the number of bytes printed, not
>    counting the NUL terminator. It is impossible for the return value to
>    be <= 0 so delete that.
> 
> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied to nvme-6.9.

