Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF4C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVtDSo6PGaazsq37Q/DpkFtSLpK2ZXHx9D/glDLsYfY=; b=LSY+/wVlnK3Xx8Fif7/O9q0GVD
	Lq8thFF7WPG6oRyK6Gz8QAviiu284no0d/Nioh8hIwOY0RqUPIC6BbATCJ58oo1iph9m4NLpGqB6v
	/pqxCiYLBbCivU93kSizuv2hoGjW+rVB+83TBd+8yx2CStEauWLfP7tWssiwqHCfnSfVOSKtHS7AI
	WwKjDeiRkhE9ggw4EhDuGCAai6JK+aCt7ilnlWjb7MqUWJtaDXQYescMWAV+X7e8iaibycyEn9Gba
	Gbc5L36mGSx0TUcDLVgPu4RC25hi9+iKSm3PW+Hgryeuxn53tH2o0MrZPyRepI7MO0lMuC12sOUth
	V5XymQEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWjn-00000004UhO-0xDX;
	Tue, 01 Jul 2025 08:53:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWhE-00000004T6p-0nWF
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 08:50:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A45FF5C661A;
	Tue,  1 Jul 2025 08:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9F4C4CEEE;
	Tue,  1 Jul 2025 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751359831;
	bh=7VWffLYp/5JzoHGHAqiHQaV/1rpYb+lDQUQ4g0pcvcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKCDd3wEXm29SJcVurH9+m/uW5A4keQOlXJTla4aTXdGUjj1H8aHgANkWJlf/CD3Z
	 8XK3JEcPYZ912uJQ0a0SID7bDuQBxxTNJGNPEFbapRbk0F/sSbTkpV03pRlhXrSR2q
	 HRQvkVC2Mkf2QqU8bjSKMOuR99cA2IUnCmku9KXI=
Date: Tue, 1 Jul 2025 10:50:28 +0200
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
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 2/5] driver core: don't always lock parent in shutdown
Message-ID: <2025070157-undaunted-curler-bda3@gregkh>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250625201853.84062-3-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625201853.84062-3-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_015032_271273_CFBA2624 
X-CRM114-Status: GOOD (  19.52  )
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

On Wed, Jun 25, 2025 at 03:18:50PM -0500, Stuart Hayes wrote:
> Don't lock a parent device unless it is needed in device_shutdown. This
> is in preparation for making device shutdown asynchronous, when it will
> be needed to allow children of a common parent to shut down
> simultaneously.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cbc0099d8ef2..58c772785606 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4823,7 +4823,7 @@ void device_shutdown(void)
>  		spin_unlock(&devices_kset->list_lock);
>  
>  		/* hold lock to avoid race with probe/release */
> -		if (parent)
> +		if (parent && dev->bus && dev->bus->need_parent_lock)
>  			device_lock(parent);

What about parents for a device that is not on a bus?  Don't they need
to be properly locked?


>  		device_lock(dev);
>  
> @@ -4847,7 +4847,7 @@ void device_shutdown(void)
>  		}
>  
>  		device_unlock(dev);
> -		if (parent)
> +		if (parent && dev->bus && dev->bus->need_parent_lock)
>  			device_unlock(parent);

Same here.

thanks,

greg k-h

