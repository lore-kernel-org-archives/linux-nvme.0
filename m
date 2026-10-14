Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F0ACC6B19
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 04:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfEZCA8VL6uz6TcvhscsscR7mUB9fi+NvnfvwC8x5AQ=; b=5GY3Dq3TBxj/e0ljrqaSz3O/D2
	ZSDjIys4F/Kkom/OtE2r+WY+QmkYMJFl7aYxsWlQLJ3ipxhIZqsWpaC0EFGoeRAELu17V7dmYrD6o
	zo9Zfaq+ePQm/L9KrJxTFNuvw+93kN9J4C4rXwkM8tMkUTG5Ykm6Cab3AchB2V3g4o95Sc0GWJqA9
	X9FEbkiggtItmEL5WNLRGO7hIU4701aURKm4hsUciY3Iv6v+gj3ZLqfDtdX6sJjB5JKa49VGUCxN9
	zHbjrdW1ctEMqsw2q/dyHx23vM2fiUhB9Fx7raI7ujufxLdWMN53iQV3BLbH5ylfds0BUQXp2XZfW
	difRMWaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGqt3-0000000EWIB-32ki;
	Wed, 14 Oct 2026 04:46:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGqt0-0000000EWHw-0y65
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 04:46:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A9E760213;
	Wed, 14 Oct 2026 04:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2015A1F000FF;
	Wed, 14 Oct 2026 04:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791953200;
	bh=gfEZCA8VL6uz6TcvhscsscR7mUB9fi+NvnfvwC8x5AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LBbywHTepEkYAWh2SSkLXaLQQW52OzKD3JYyd5woPCHjKtNuJwZjLvqgjrWhmOGRO
	 9a3LxYhoF18DeV9h7OW8oMY11dRyjfyztKvIgYzxqDV0RtGlSTr6oeNNsyfTGX0Via
	 GS9U63mriIYUNYhB9M5KI7vMDflrOrR+PJlNjpsI=
Date: Wed, 14 Oct 2026 06:46:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
	hch@lst.de, axboe@kernel.dk, hare@suse.de,
	linux-kernel@vger.kernel.org, security@kernel.org,
	stable@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable
 by root only
Message-ID: <2026101434-wrist-playing-51b3@gregkh>
References: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>
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

On Tue, Oct 13, 2026 at 01:32:41PM -0400, Martin Belanger wrote:
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Change the mode to 0600. Writing the attributes was already limited to
> root and is not changed.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Cc: Daniel Wagner <wagi@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
> ---
>  drivers/nvme/host/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index e1e3dcfd084b..e0cb34545b97 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -864,7 +864,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(dhchap_secret, 0600,
>  	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);

DEVICE_ATTR_ADMIN_RW() perhaps?

And no need to cc: security@k.o for public patches.

thanks,

greg k-h

