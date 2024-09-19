Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5C7CF3944
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxc9waFJBWFVmkFv5ioLSwhRTCqAWeKSXrsyKCD1EBs=; b=wipLB80WLhdIQyTrYtAXhgrABd
	T9ip2CS8+KgXRYOhMnK6lFaTFNDDUYXMoGVI/ejb1/Ty6aoU/bj0cpbXKIuHy8/efwRhiJyONz3it
	XZRlafCN0cguhpZF0hdJFsZs+nKlZ+HSVlzi+xZV5xFRz5pP9BfmfGcakMyMedON3N1T+QCjbIoG6
	r92QK+rtEc7ri2cRcseN8fnQww2OFNK1jV6fF4dLyM/wi70KwvGobx9WlD5Oh4HQTwW6O+KriK/K2
	7qw5Kl/cyorSVNm9Vy5lDk9oiovJTo4VIKx4tTn7eeDtUWdXNw9VY8QlH1s19qrT67M8P18YR8Eb+
	xWvlaGNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srHxx-0000000AQYo-3Csu;
	Thu, 19 Sep 2024 14:17:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srHxv-0000000AQY9-25pt
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 14:17:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 361A2A43D31;
	Thu, 19 Sep 2024 14:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D68BC4CEC4;
	Thu, 19 Sep 2024 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726755421;
	bh=FlNDW5bPW8BWDMVEN7jqfSs7j6g8jfrFGDuO3tlJ0wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leFwDVN+4OMZdlwlSETl2m2UU/PWNkHzMhnM2FmP/ysAXV601rdZuZpNd0pp/s+Hk
	 2jOQZw8XwYcHULhIunASNjnbXbYnnSKv6H46YK9Rm++SHtHeyy4sOteR9Upj4G61G5
	 yWfuhK7w1vHfq82YA5NPDjJKBt+oLJdHNhl6xcAfFG1zI5uKxIbzBeI8JT4qjuzaA4
	 MFEmsH96oNPD+JCfS/qaVKSdRpjvtWTu5jOZ9jxtLFcBZBb9WeHacQpgXb+4sVpCEc
	 aOKjyxYwRvrOk0kqIi+qA3W2sd7sqR+GhyGtawF6QN8O6h2FhIzEj296AXXhYpQPaK
	 k/Pg8BWSEICsQ==
Date: Thu, 19 Sep 2024 07:16:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <20240919141658.GA3737785@thelio-3990X>
References: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_071703_624146_106E9493 
X-CRM114-Status: GOOD (  25.62  )
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

All of my virtual testing seems happy with this change.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> The patch this fixes is in driver-core-next and linux-next.
> 
> Please let me know if this needs to be a V2 or if it needs anything
> else... it is the identical patch I sent in yesterday, except I added
> a "Fixes:" tag and the comments.  Thank you for the help!
> 
>  drivers/base/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b69b82da8837..76513e360496 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4898,8 +4898,16 @@ void device_shutdown(void)
>  
>  		idx = device_links_read_lock();
>  		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> -				device_links_read_lock_held())
> +				device_links_read_lock_held()) {
> +			/*
> +			 * sync_state_only suppliers don't need to wait,
> +			 * aren't reordered on devices_kset, so making them
> +			 * wait could result in a hang
> +			 */
> +			if (device_link_flag_is_sync_state_only(link->flags))
> +				continue;
>  			link->supplier->p->shutdown_after = cookie;
> +		}
>  		device_links_read_unlock(idx);
>  		put_device(dev);
>  
> -- 
> 2.39.3
> 

