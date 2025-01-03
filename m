Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A864E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/nii7YseQkcWJiesMNyKk9MSZS+ig8zwZB3MlFDPSg=; b=2wO6Op3MwzetHoR7PDRs8c22Ti
	JD4bIZjCXfpTizVv15qDaKQuLt6ZXD5lhE3CXNvXyndTmFT/K1v8b6IbLz6qyGo8WG0U3xNH5wsnd
	+Cy0x3AkIk+pgOMHPMXlhdQAjti0oqBqON7QkkvjNwkvim/YOQB7V4Vf/yKpVy9kq0bYJ3TJ+Yjrm
	5ZuL+FbYhpGYVZWjl9hm/0auJFUg+DCpeqN4mb+BeXM9h1vd7qgLvhcYbFzlX1pDwAqGa87/qY153
	k5zufVeZo1OTT7aIflTY1CxlOHed9qIayPZqlkteYERT08a3lHSZNa8soNWsDoYbB4jNS2Ao/q0W5
	2p9HNntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbgi-0000000CHhf-28Iu;
	Fri, 03 Jan 2025 07:01:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbgg-0000000CHfo-0PpW
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 07:01:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0745868C7B; Fri,  3 Jan 2025 08:01:31 +0100 (CET)
Date: Fri, 3 Jan 2025 08:01:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Denis Arefev <arefev@swemel.ru>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme: Enter string =?utf-8?Q?s?=
 =?utf-8?Q?ize_calculation_=E2=80=9Csubsysnqn=E2=80=9D?=
Message-ID: <20250103070130.GB28303@lst.de>
References: <20241226104546.13705-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226104546.13705-1-arefev@swemel.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_230138_286326_891470BA 
X-CRM114-Status: GOOD (  21.57  )
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

On Thu, Dec 26, 2024 at 01:45:35PM +0300, Denis Arefev wrote:
> When memory is allocated, the size of the string 
> is calculated nvmet_subsys_alloc(...).

s/is/is in/ ?

> When memory was accessed, constant size was used.
> 
> Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
> Reported-by: syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a84181c81389771eb46a
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/nvme/target/configfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index eeee9e9b854c..2f74204d000e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2247,14 +2247,15 @@ static struct config_group nvmet_hosts_group;
>  static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
>  					     char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
> +	return snprintf(page, strnlen(nvmet_disc_subsys->subsysnqn, PAGE_SIZE),
> +			"%s\n", nvmet_disc_subsys->subsysnqn);

This doesn't really make sense as %s already calculates the length
of the string internally.

>  }
>  
>  static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>  		const char *page, size_t count)
>  {
>  	struct list_head *entry;
> -	size_t len;
> +	size_t len, nqn_len;
>  
>  	len = strcspn(page, "\n");
>  	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
> @@ -2271,8 +2272,9 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>  			return -EINVAL;
>  		}
>  	}
> -	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
> -	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
> +	nqn_len = strnlen(nvmet_disc_subsys->subsysnqn, NVMF_NQN_SIZE);
> +	memset(nvmet_disc_subsys->subsysnqn, 0, nqn_len);
> +	memcpy(nvmet_disc_subsys->subsysnqn, page, nqn_len);

The memset should still happen for the entire field, only the copy
needs to me limited.

But i really wonder if we should do away with this mess and just
use kmemdup()ed allocations for the nqns.


