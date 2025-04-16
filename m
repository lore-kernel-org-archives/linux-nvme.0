Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A26C369C1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4rA+OYQ/k01wwgm+jiFIFEx4hVYW6A62leL4CloUvtI=; b=XRDlVDmWAygviuZPHj3TLQ20ww
	rqR++tNVudCcMKcFAY53BYF0Jx0hT4ZCajjKWK044iXPfbMwbsJxLB1stAgf5WPM/yWR+gCmiVyi8
	LD4LM35lk0ifjRqyIw8n+ArLctA9lMRkh0hv29zxtRCrkESFKVJiJMtxATWZT1fMZqy73IXFuWC8/
	xX/vqLcyuOHaUth0J5li4yzgoJf+15xiR9Vu2IjyTAdamljJQOmmuU+oHaqi8NM4iQxFFqjAoF5DO
	BvpmXH6aKQEEx5xNyOOayaA7zvoSssJkPEzCrhlShYcXiIpwRu9AoTJIWv8Dho2PkkWum0u4Q7SLv
	Zxb50/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u55qR-0000000AIlD-37Id;
	Wed, 16 Apr 2025 16:42:39 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u55Gg-0000000ABRP-0dql
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 16:05:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4Zd5Tk3HCJzm0yVN;
	Wed, 16 Apr 2025 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1744819525; x=1747411526; bh=4rA+OYQ/k01wwgm+jiFIFEx4
	hVYW6A62leL4CloUvtI=; b=IVpc4FxVxUl02nZnmIlRB8AfWVTQcXcDjI7g+qLS
	XSxRkVoM0SzjfHxAHdZabaGZYOhmKcE9S4Zu7Rvcsn2X1WMsxibhKmgF3d9pNm8B
	NLN3WRWoJBbLlzgpb+QDeVVYCNQ0WrSBzGhpEfENba7fXOJEe7ITKb2+L6NBxzqk
	WDLbgWblz4anjLuvefXnDadn1gWFq2NicjUStiM/py12gk9I0H6Clg9kjgeMilu8
	wjIHxV7rDmHF0QYAYemBOoWoWHBWfkfpoE1/Jg9FgZhPG/UrrIa5SeZP31NbUL1J
	ZVjskPOWJSo/jiJ3j8sXD5O3ynk+tekn5+d96iFunAf0Qw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 76cUTHYzIjV1; Wed, 16 Apr 2025 16:05:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4Zd5T91lhkzm0djk;
	Wed, 16 Apr 2025 16:05:00 +0000 (UTC)
Message-ID: <bb713790-0b68-4d91-831c-b18fa1ea01a9@acm.org>
Date: Wed, 16 Apr 2025 09:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] lib/Kconfig.debug: introduce
 CONFIG_NO_AUTO_INLINE
To: chenlinxuan@uniontech.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, Winston Wen <wentao@uniontech.com>,
 Changbin Du <changbin.du@intel.com>
References: <20250416-noautoinline-v2-0-e69a2717530f@uniontech.com>
 <20250416-noautoinline-v2-5-e69a2717530f@uniontech.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250416-noautoinline-v2-5-e69a2717530f@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_090542_267775_F9FF097F 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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

On 4/16/25 2:44 AM, Chen Linxuan via B4 Relay wrote:
> 2. Make it depends on X86 and LOONGARCH,
>     as I haven't test other architectures

That sounds weird to me. Shouldn't this option be made architecture-
independent?

> +config NO_AUTO_INLINE
> +	bool "Disable compiler auto-inline optimizations (EXPERIMENTAL)"
> +	default n
> +	depends on CC_IS_GCC && (X86 || LOONGARCH)

Why "depends on CC_IS_GCC"? Please make sure that both gcc and clang are
supported.

Thanks,

Bart.

