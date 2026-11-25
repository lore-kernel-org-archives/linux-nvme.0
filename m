Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70961606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JOwOwClp;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HPA3FqaL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Eu5mC4X7hlfKuEq917frPND7gjL/jy3R1aIhp7tO1rI=; b=JOwOwClpP/oZAc
	A00pl6HJN3m2hh/uL33lqVJy5Jzc7ll67FmzceNFVtASsByAuPWvTNne7HrUthP0gW/dQVbbAxWGH
	5LEKoEOyIke4XIy5E7HIK8B/lptzP0cpR3z8liHxciL1AcTqvGlAbNZ8PK4SceWp91TmTCKDH4cH+
	vBwXyJjuVs2ZfOSltqKw1gS4XysoHJ1TlGwYGL6bflcahNlanR8prDnGnCqtYjibQCYUilMfbp5ex
	hOObqra/RowfARGnqsjtacKROQXiZ+r4AYldJ4Ubh7zEkcOcs+CI4k5NfKhQ9Sykw02aCl0GoZJS6
	pLv6AoXdBWGjhigAo6Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6en-00000008j5l-444s;
	Wed, 25 Nov 2026 06:39:05 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6ei-00000008j46-41A2
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795588736; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Eu5mC4X7hlfKuEq917frPND7gjL/jy3R1aIhp7tO1rI=;
	b=HPA3FqaLxSTq6FBTP3ZPSTNFpAtTKwUSiyX9/P6VnwYYO6rzf4RCjQZxJiV0+xCDSkkileGXdrcWL4zy19EaMgK9oHdjiQRkOIxE09xi6QPhIAj6c4mh1eLVClp9PfhoJQrRhs+V178TVxAdLFRdI8nlal/zONPBeU4u7784Juo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQiN4o_1795588734;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQiN4o_1795588734 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:38:55 +0800
Message-ID: <39f6f1d0-c532-46d6-bf71-9225f57d9d37@linux.alibaba.com>
Date: Wed, 25 Nov 2026 14:38:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: document the per-subsystem iopolicy sysfs
 attributes
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116114208.2226472-1-kanie@linux.alibaba.com>
In-Reply-To: <20261116114208.2226472-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_223901_164169_A9166B5B 
X-CRM114-Status: GOOD (  23.40  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,
  Gently ping, this patch may have gotten buried in the malling list traffic.

Best Regards,
Guixin Liu

在 2026/11/16 19:42, Guixin Liu 写道:
> nvme-multipath.rst only mentions the global nvme_core.iopolicy module
> parameter. That value is only picked up when a subsystem is created;
> changing it does not affect subsystems that already exist. The runtime
> interface is the per-subsystem iopolicy attribute, which applies the
> new policy to a single subsystem immediately, plus the read-only
> iopolicies attribute listing the supported policies. Document both,
> and note that discovery subsystems report "none" and reject writes.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  Documentation/admin-guide/nvme-multipath.rst | 35 +++++++++++++++++---
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
> index 97ca1ccef459b..058894187cbb8 100644
> --- a/Documentation/admin-guide/nvme-multipath.rst
> +++ b/Documentation/admin-guide/nvme-multipath.rst
> @@ -24,12 +24,37 @@ Policies
>  
>  All policies follow the ANA (Asymmetric Namespace Access) mechanism, meaning
>  that when an optimized path is available, it will be chosen over a non-optimized
> -one. Current the NVMe multipath policies include numa(default), round-robin and
> -queue-depth.
> +one. The NVMe multipath policies currently include numa(default),
> +round-robin and queue-depth.
>  
> -To set the desired policy (e.g., round-robin), use one of the following methods:
> -   1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
> -   2. or add the "nvme_core.iopolicy=round-robin" to cmdline.
> +To set the desired policy, use one of the following methods:
> +
> +  1. Set the global default policy (e.g., round-robin), which is applied to
> +     every subsystem when it is created, using either the sysfs module
> +     parameter::
> +
> +	echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
> +
> +     or the kernel command line parameter "nvme_core.iopolicy=round-robin".
> +     Subsystems that already exist keep their current policy.
> +
> +  2. Change the policy of a single subsystem at runtime::
> +
> +	echo -n "queue-depth" > /sys/class/nvme-subsystem/nvme-subsys0/iopolicy
> +
> +     The per-subsystem "iopolicy" attribute shows the policy currently in
> +     effect. Writing a supported policy name to it takes effect immediately
> +     for that subsystem only: the currently selected path of each namespace
> +     is dropped, so that subsequent I/O is dispatched according to the new
> +     policy, and the change is reported in the kernel log.
> +
> +The list of policies supported by the kernel can be read from the read-only
> +"iopolicies" attribute::
> +
> +	cat /sys/class/nvme-subsystem/nvme-subsys0/iopolicies
> +
> +Discovery subsystems have no I/O paths and report "none" for both attributes;
> +writing to their "iopolicy" attribute is not supported.
>  
>  
>  NUMA


