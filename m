Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91456C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxAOnkj+qBoZ5iJfIdIJo0NLCNsqB7FsT5aQqD1aiFE=; b=D5Ki2J3W1xnq6H3IeBS1lRzSdY
	9a9zxmwC+eJrjQWC1Is0qPVal/vqWGr+2aVOFBQTf6GQM4U6xUfLpLnF401KzpEL0NIGM7CT8bc/p
	C5T5ljUm1yiPnmW1jy0bYEoN59WyquS4sZgP53OG0eads+ttiFaLaRK5GkNx7hpQ8dTWuELKKtKtY
	+hXLG8PFZ7Op2JZ5TrZLNO5VK4wG2VgKVjqBY2pbVUQ088d/JE2qORJPT/L2mAED89mJJtKpinPkz
	a79okkosDGVAN+zhkffPHpy4cvQVg9pqd7vOFf4BFWbgEM0Bh1yxQHB+sXOIrdJpJ+la3P9wSxNt6
	4TwX4MvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWblt-00000005f3M-1SkH;
	Tue, 01 Jul 2025 14:15:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWaRD-00000005Ng3-1uFu
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 12:50:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAEC85C5CEE;
	Tue,  1 Jul 2025 12:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A3C4CEEB;
	Tue,  1 Jul 2025 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374214;
	bh=BG1gTBZXgf+EQIjAnAdvj39qCVM+cDiy04QR+WLx1CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQJKVTQeHoA7r0kNUxz6avtUVxnrROsYqMJgUiy1q83r3+a06ZpqHDh9sD1lsCaKJ
	 NOyU6alhVj75qovngWWYDcyJsRuYGOJUQdi4m/f6iZWg2s25cRTzdslJ2C0Am5rXAi
	 0TkkXZ8KiSaAQDrDM8inh6olB5i3bN5SNm6G4bcqm+uPHxnQVzAM2a2jF/Z8m4uG9i
	 XgRAkmrsqXlpj2Q58248TlRwqAvrnivrzP3H5c113Ho/Rmk+SJ9YWwxnaG4An4/e5H
	 Rn7yWIMX9aYeFwmoaDdviT979hOsUG20xJl5yL594F2J8KI+zSg2uKFUc4rXxD0qRa
	 qUT/iKZPCp1NQ==
Date: Tue, 1 Jul 2025 13:50:08 +0100
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
	gus@collabora.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v29 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <20250701125008.GP41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630140737.28662-3-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_055015_579722_E8D70607 
X-CRM114-Status: GOOD (  23.76  )
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

On Mon, Jun 30, 2025 at 02:07:19PM +0000, Aurelien Aptel wrote:
> Add a new netlink family to get/set ULP DDP capabilities on a network
> device and to retrieve statistics.
> 
> The messages use the genetlink infrastructure and are specified in a
> YAML file which was used to generate some of the files in this commit:
> 
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     -o net/core/ulp_ddp_gen_nl.h
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>     -o net/core/ulp_ddp_gen_nl.c
> ./tools/net/ynl/ynl-gen-c.py --mode uapi \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     > include/uapi/linux/ulp_ddp.h
> 
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  Documentation/netlink/specs/ulp_ddp.yaml | 172 +++++++++++
>  include/net/ulp_ddp.h                    |   3 +-
>  include/uapi/linux/ulp_ddp.h             |  61 ++++
>  net/core/Makefile                        |   2 +-
>  net/core/ulp_ddp_gen_nl.c                |  75 +++++
>  net/core/ulp_ddp_gen_nl.h                |  30 ++
>  net/core/ulp_ddp_nl.c                    | 348 +++++++++++++++++++++++
>  7 files changed, 689 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
>  create mode 100644 include/uapi/linux/ulp_ddp.h
>  create mode 100644 net/core/ulp_ddp_gen_nl.c
>  create mode 100644 net/core/ulp_ddp_gen_nl.h
>  create mode 100644 net/core/ulp_ddp_nl.c
> 
> diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
> new file mode 100644
> index 000000000000..27a0b905ec28
> --- /dev/null
> +++ b/Documentation/netlink/specs/ulp_ddp.yaml
> @@ -0,0 +1,172 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +# Author: Aurelien Aptel <aaptel@nvidia.com>
> +#
> +# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> +#
> +
> +name: ulp_ddp

I think that the name needs to avoid using '_' ('-' seems ok)
in order for make -C tools/net/ynl/ to run successfully
on current net-next.

...

> +    name: caps
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: Interface index of the net device.
> +        type: u32
> +      -
> +        name: hw
> +        doc: Bitmask of the capabilities supported by the device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: active
> +        doc: Bitmask of the capabilities currently enabled on the device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: wanted
> +        doc: >
> +          New active bit values of the capabilities we want to set on the
> +          device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: wanted_mask

Likewise here.

> +        doc: Bitmask of the meaningful bits in the wanted field.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +

...

> +      name: caps-set
> +      doc: Set ULP DDP capabilities.
> +      attribute-set: caps
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - wanted
> +            - wanted_mask

And correspondingly, here.

> +        reply:
> +          attributes:
> +            - ifindex
> +            - hw
> +            - active
> +        pre: ulp_ddp_get_netdev
> +        post: ulp_ddp_put_netdev
> +    -
> +      name: caps-set-ntf
> +      doc: Notification for change in ULP DDP capabilities.
> +      notify: caps-get

...

