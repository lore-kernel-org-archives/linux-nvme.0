Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B414CC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AMHjS2IjbcijjovBD6i5h4XxYqdhXTlZ7Bp+d3CoLA=; b=VFtyGWSyGHarrkMz4co28Qq/Lb
	NRSjDFTOKWuenKSRFF4I3VVImKVfV3J1SozUI0oqZ+TT7heNUOfkpJBL18sycZfuP9AxRCv49FpXV
	ecgFxJJsl69zk938TQHC3uCxJzMoLHPwgDIWrDBxRb/OPuZsQ60dyyDMwzhW56YIliN6lr8G/CkQa
	lFkOE3/otYjsun6V7Atp9pM6yhEZ94BY0vrCQQmFh7CZAy0NgxvwaF7wFNpcatbh3Jd15kxzbkT0h
	WjYS1x/nqxYH4awoQ0thyB1qVtoe2UthLWjrJn55v1n1/Vy+Q3j0gLTQqWYT79Tr/ChexfHmine5Y
	iNkayngg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5reo-00ATEl-PS; Thu, 15 Dec 2022 17:04:30 +0000
Received: from [2601:1c2:d80:3110::a2e7]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5rej-00ATDS-FC; Thu, 15 Dec 2022 17:04:25 +0000
Message-ID: <fac7f8be-58da-f588-f6e4-4cf64529d55d@infradead.org>
Date: Thu, 15 Dec 2022 09:04:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
 axboe@meta.com, sagi@grimberg.me, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20221215125130.261098-1-hch@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221215125130.261098-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi--

Just a couple of small nits below...

On 12/15/22 04:51, Christoph Hellwig wrote:
> This adds a document about what specification features are supported by
> the Linux NVMe driver, and what qualifies for a quirk if an implementation
> has problems following the specification.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/process/index.rst               |  1 +
>  .../process/nvme-feature-and-quirk-policy.rst | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/process/nvme-feature-and-quirk-policy.rst
> 
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index d4b6217472b0a0..0dc33994ddefc5 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -50,6 +50,7 @@ Other guides to the community that are of interest to most developers are:
>     embargoed-hardware-issues
>     maintainers
>     researcher-guidelines
> +   nvme-feature-and-quirk-policy
>  
>  These are some overall technical guides that have been put here for now for
>  lack of a better place.
> diff --git a/Documentation/process/nvme-feature-and-quirk-policy.rst b/Documentation/process/nvme-feature-and-quirk-policy.rst
> new file mode 100644
> index 00000000000000..eee19f3d9904bd
> --- /dev/null
> +++ b/Documentation/process/nvme-feature-and-quirk-policy.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Linux NVMe feature and and quirk policy
> +=======================================
> +
> +This file explains the policy used to decide what is supported by the
> +Linux NVMe driver and what is not.
> +
> +
> +Introduction
> +============
> +
> +NVM Express is an open collection of standards and information.
> +
> +The Linux NVMe host driver in drivers/nvme/host/ supports devices
> +implementing the NVM Express (NVMe) family of specifications, which
> +currently consists of a number of documents:
> +
> + - the NVMe Base specification
> + - various Command Set specifications (e.g. NVM Command Set)
> + - various Transport specifications (e.g. PCIe, Fibre Channel, RDMA, TCP)
> + - the NVMe Management Interface specification
> +
> +See https://nvmexpress.org/developers/ for the NVMe specifications.
> +
> +
> +Supported features
> +==================
> +
> +NVMe is a large suite of specifications, and contains features that are only
> +useful or suitable for specific use-cases. It is important to note that Linux
> +does not aim to implement every feature in the specification.  Every additional
> +feature implemented introduces more code, more maintenance and potentially more
> +bugs.  Hence there is an inherent tradeoff between functionality and
> +maintainability of the NVMe host driver.
> +
> +Any feature implemented in the Linux NVMe host driver must support the
> +following requirements:
> +
> +  1. The feature is specified in a release version of an official NVMe
> +     specification, or in a ratified Technical Proposal (TP) that is
> +     available on NVMe website. Or if it is not directly related to the
> +     on-wire protocol, does not contradict any of the NVMe specifications.
> +  2. Does not conflict with the Linux architecture, nor the design of the
> +     NVMe host driver.
> +  3. Has a clear, indisputable value-proposition and a wide consensus across
> +     the community.
> +
> +Vendor specific extensions are generally not supported in the NVMe host
> +driver.
> +
> +It is strongly recommended to work with the Linux NVMe and block layer
> +maintainers and get feedback on specification changes that are intended
> +to be used by the Linux NVMe host driver in order to avoid conflict at a
> +later stage.
> +
> +
> +Quirks
> +======
> +
> +Sometimes implementations of open standards fail to correctly implement parts
> +of the standards.  Linux uses identifiers based quirks to work around such

                      Linux uses identifier-based quirks

> +implementation bugs.  The intent of quirks is to deal with widely available
> +hardware, usually consumer, which Linux users can't use without these quirks.
> +Typically these implementations are not or only superficially tested with Linux
> +by the hardware manufacturer.
> +
> +The Linux NVMe maintainers decide ad hoc whether to quirk implementations
> +based on the impact of the problem to Linux users and how it impacts
> +maintainability of the driver.  In general quirks are a last resort, if no
> +firmware updates or other workarounds are available from the vendor.
> +
> +Quirks will not be added to the Linux kernel for hardware that isn't available
> +on the mass market.  Hardware that fails qualification for enterprise Linux
> +distributions, ChromeOS, Android or other consumers of the Linux kernel
> +should be fixed before it is shipped instead of rely on Linux quirk.

I would s/rely/relying/, but either way:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb77a3ed9d5423..59e9f2dfa842ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14827,6 +14827,7 @@ L:	linux-nvme@lists.infradead.org
>  S:	Supported
>  W:	http://git.infradead.org/nvme.git
>  T:	git://git.infradead.org/nvme.git
> +F:	Documentation/process/nvme-feature-and-quirk-policy.rst
>  F:	drivers/nvme/host/
>  F:	drivers/nvme/common/
>  F:	include/linux/nvme*

-- 
~Randy

