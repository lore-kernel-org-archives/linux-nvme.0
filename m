Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CBC982FA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIA3RmOKE6FujkPBUin/Ujl/ok6f+idIC3nlbGVqyxI=; b=jz5d+GkzGgaa1g2lrVmA08RTl9
	SX3EaeXtWd7LbUuj8IOWDJP906pjhNDGuABpknGDAOJSvQDJaumBXIPWk/DREsKLKt390z0XFUapq
	KVP7xb50yVLjQaLbFqj1qex0jd+fzLeQWT6NFaoVkDeubFUk/wIPUiAiRZMJlYghhUXszDDrIQovH
	Kp8m7Eq7qDVKnsrdNOQHhNuKnJPWLhPObvVgA3glQm0b8+fOPPL8KwDZDKFDVKhYbhl3Yr2u4Q65g
	9l+91HadfHxecdvPZLfZ8gfiJ9zfA1yiCxTWaTTKJ3LlaQClHfZLZW6JwyAdGoBhi8AFQNsR+27Tk
	zFrhxK1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9HaR-00000007Qa1-1ssD;
	Wed, 23 Sep 2026 07:40:15 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9HaJ-00000007QZC-0ev3
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 07:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=Li/7CtQT9ekhb/
	rzTQeU0eAMCKM+r3+9eXDiZG06pV0=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=e+Zed52sFs1MQhswBlULyyhS2wxFpwwD6DmHL
	Kdx5wffvjxDThp6IUMki2uLx/J3ZQ3InYVtukhdxOpdu7pq9TnRPT7GXZbmfUIwD9ECBGV
	e5YaCjF5OaXZFdL+c7P62gi53t27r885zhjQvg1rwGWx7WOfyQ78dTKGlcY140+LyUz46T
	21bKs2RPW/cj2rnFwJyoRD/TQu/tUwUzGv20GYtjfAdTuwmvrYNHxi1wCzaPwz+RXveGkk
	LSBFn1xao3GYrqB8ZMlObyVOFMZzUyDffrA0/DjbpyICphiQataFCtbUR4f99qCJPbqiPB
	ZoLLnWpPrmwoHpy334RjbtwZg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 58c282aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 09:40:00 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 09:39:59 +0200
Message-Id: <DLMIXHATYR90.4RUG08AMWH8U@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH v2] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Ing. Alfonso Kuen Arroyo" <gerencia@idkmanager.com>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>
X-Mailer: aerc 0.22.0
References: <179013720383.9364.11263428288753603011@idkmanager.com>
In-Reply-To: <179013720383.9364.11263428288753603011@idkmanager.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_004007_850476_3E2CD60F 
X-CRM114-Status: GOOD (  17.12  )
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

On Wed Sep 23, 2026 at 6:20 AM CEST, Ing. Alfonso Kuen Arroyo wrote:
> The constant is 0x400000, 4 MiB, but the comment next to it said 16M.
> Use SZ_4M instead of a value and a comment that can drift out of sync
> with each other, as suggested by Christoph Hellwig.
>
> Noticed by Maurizio Lombardi while reviewing "nvmet-tcp: report a
> bounded MDTS instead of "no limit"".
>
> v2: use SZ_4M instead of the raw hex value + comment (Christoph
>     Hellwig). The file did not pull in linux/sizes.h yet and had no
>     other SZ_ user, so the include is added.

version differences should be put after the '---' separator, they are
not part of the commit message

>
> Signed-off-by: Alfonso Kuen

The mail is missing, this should be:
Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>

> ---
>  drivers/nvme/target/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index e598101..000000 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -18,12 +18,13 @@
>  #include <net/handshake.h>
>  #include <linux/inet.h>
>  #include <linux/llist.h>
> +#include <linux/sizes.h>
>  #include <trace/events/sock.h>
>
>  #include "nvmet.h"
>
>  #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
> -#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
> +#define NVMET_TCP_MAXH2CDATA		SZ_4M
>  #define NVMET_TCP_BACKLOG 128
>
>  static int param_store_val(const char *str, int *val, int min, int max)
> --
> 2.53.0

The change looks ok to me
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>


