Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B0FCE8D61
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JkZQ1dp3pixCi38Uew4Sdils2uNimkzNGtXOq1QRrcE=; b=cIQqOXly8HB1su2nS8/3+0mnPg
	7JsihWv6PETE0YHdsSvC14h3YQPIn13dmmHMQfNgpuVFZJQ8dda911+dPbDwUuEG0Kf8oMah8vngP
	RqrPwXpDRG/VUOeSHQbyGJ2qEfN3IrDL9VVMCdZh+iMTqUu46cuf2deIPK0AbLJxEitY4aYPS2TnC
	Nq67cZskko0zTnr7oGPGZIg9AEurGrzC3laOJSfSAXh+rRX0/VGFWcF0whoakG8yixaI9/8eBmTvt
	wfZYt6lXPYmFpVTEF7Ccru+L0SjgAO1TXU1bT5wSoyCYMg54PK4nTbfvwVOF10ZhSy8L0eZe0Q4CV
	Qc9Je6tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srD3Z-00000009rJc-2cKo;
	Thu, 19 Sep 2024 09:02:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srD3W-00000009rIq-2BdP
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 09:02:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 846D95C5CDF;
	Thu, 19 Sep 2024 09:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695CEC4CEC4;
	Thu, 19 Sep 2024 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726736549;
	bh=f/isTUsW8X8R3KoT6iEY7Bm5jbFtMMQEk/dFReJwsgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTzrUyD0LWN0xPG2Fv4rhZHsnzSvQRxnEOyrZMpWwWx5F9qgj/eVploDnwhO2IH+s
	 PaO9ddnc5GPYXCdm4PLNFkXXYE3cfUcOZCHUGsgghWlj/T83jX6jdK2+E0jr/namCk
	 l1PftTTqfZx4gx79T444YHdkHzB1Vfup8auxv+tY=
Date: Thu, 19 Sep 2024 07:17:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091938-pamphlet-chapped-56ed@gregkh>
References: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_020230_655188_0E1783BF 
X-CRM114-Status: GOOD (  16.36  )
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

On Wed, Sep 18, 2024 at 11:31:43PM -0500, Stuart Hayes wrote:
> Modify device_shutdown() so that supplier devices do not wait for
> consumer devices to be shut down first when the devlink is sync state
> only, since the consumer is not dependent on the supplier in this case.
> 
> Without this change, a circular dependency could hang the system.
> 
> Fixes: 8064952c6504 ("driver core: shut down devices asynchronously")
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Nit, no blank line between Fixes: and signed-off-by is needed.

> ---
> The patch this fixes is in driver-core-next and linux-next.
> 
> Please let me know if this needs to be a V2 or if it needs anything
> else... it is the identical patch I sent in yesterday, except I added
> a "Fixes:" tag and the comments.  Thank you for the help!

In theory, yes, this is a v2 as something did change, but I can take
this as-is for now, thanks.

greg k-h

