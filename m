Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D387E77183
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRDS5R3z+oZXF4mYAnLDStGIWef+y4Q8AhQKmsmOLak=; b=QK8Lc01OsnO2L0TIJ/S3VaPDtJ
	SGom4poHXgVE3nOLhucKub0F2pE8l+PaqXKcn8cKG+iV4MdiSfpw6vbKs3krv9s/NDY1ol5fYWNue
	yzC7yzj3OheL21UlJcymfPO92m/74TLxlM6aVlJb/dACOIcLzxWguJFjcOgo9VAtBNg8DuB2RP00S
	tOdR8hBLKjeMFTFLZSErEAKLospkz5MwT1G2ckO0ldHnzqkOwAhzZAwl9PY0ZFt8xU48vyv7tdZYp
	nCieZ08sRbl+uhjZTsZ0QQoH2+wu2GAoCYLqcjbnRx3oXSiEd9p9ddoIk3YVkz0YpzyKcW+1o28Xh
	oqQ5FFXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNoLi-0000000Fnaf-1NZX;
	Wed, 18 Dec 2024 07:20:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNoLf-0000000FnZC-2DcD
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 07:20:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 574D968AA6; Wed, 18 Dec 2024 08:19:50 +0100 (CET)
Date: Wed, 18 Dec 2024 08:19:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leo Stone <leocstone@gmail.com>
Cc: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: Don't overflow subsysnqn
Message-ID: <20241218071949.GA25990@lst.de>
References: <6761b929.050a0220.29fcd0.0070.GAE@google.com> <20241218005909.89092-2-leocstone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218005909.89092-2-leocstone@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_231959_709885_1C9E485F 
X-CRM114-Status: GOOD (  19.34  )
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

On Tue, Dec 17, 2024 at 04:59:10PM -0800, Leo Stone wrote:
> nvmet_root_discovery_nqn_store treats the subsysnqn string like a fixed
> size buffer, even though it is dynamically allocated to the size of the
> string.
> 
> Create a new string with kstrdup instead of using the old buffer.
> 
> Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ff4aab278fa7e27e0f9e
> Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index eeee9e9b854c..3fa25f9f7d92 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2271,8 +2271,8 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>  			return -EINVAL;
>  		}
>  	}
> -	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
> -	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
> +	kfree(nvmet_disc_subsys->subsysnqn);
> +	nvmet_disc_subsys->subsysnqn = kstrdup(page, GFP_KERNEL);

This needs error handling, pobably best done by using a local
variable for the new allocation, which would also help to keep it
outside the lock.


