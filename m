Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD7C021B6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FB2coRC5Xvdz2JkQeRjRUfHW18kfF2vXDsAXY+wq5yw=; b=MF1KKlC1h53nxbYGPbd4a5ebaW
	rPhcri3yojD14hCUHRMkiveERxLMQ9AFt2QZqkYWuxGWngFh8BNgPewOUL2VgW2e4ZQEUfNElh/Y3
	QaTBSd5qZNYeb5LcUq4k55gj6h7GdkqdD8FRAdKR+3l+ZozImhT8IHK10yBk2bV9B7cwvkW2yturf
	d+eMxNfJpGQdqGUSYJFi2/Su9ENVUYG48yduejzsSgjlHlmZgAjUHoF4vF889TPk7yA6G6KSZWudz
	WcjE46Qif4kCDtnTFC38kc1lLZTHZiSPskSShQlubFDLewqShHJ4IccFPrNPKKfJEZDxeT7FTa8HX
	8U9ltQSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgsc-0000000FMKc-29BP;
	Mon, 24 Feb 2025 22:24:50 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgrm-0000000FMCw-2e6e
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:23:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0563A611F6;
	Mon, 24 Feb 2025 22:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05621C4CEE6;
	Mon, 24 Feb 2025 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435837;
	bh=kqT4tDg5dCkD3hgQSrkH5o63fPewR7O1WP+cJX4FB94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6SWXZOYcJms528jmQGsYJm/NVyFTJeLeP3ZUApiptjmqXh3Dy3+UJNPuZgWwWHTi
	 qTEip2FB29TstLOhNSIcd74wE57+PCYfW+UDm5LLkUs6U0RBN8WyoOJiwSwJncj3IK
	 wW7rRQdm0fBHWMwcg/7KuZVDi18H3HB7RuYg0IS9mYaXlFWiOqATEAUXKP2eiV2Auy
	 bNKIi1U6tMUBmkDu/LtxkutGk8vIacPJnn8V8FijTcV9fUb8MwT96Tb9yD0mVr0mme
	 4c2ZlPJgFvOirNaODU6zYAfCjbcVIj16v7XLx1atHGsUYCS1Ak+v7sxOaG8nbBhcBf
	 mJevczY/PSiEw==
Message-ID: <84baa0e9-de75-4a22-b5d7-b43de26a99d5@kernel.org>
Date: Tue, 25 Feb 2025 07:23:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme-ioctl: fold 'vec' into flags
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-4-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-4-kbusch@meta.com>
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

On 2/25/25 03:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The vec indicator is already a flag and used as such, so use that type
> instead of implicitly relying on a bool to happen to align to the enum
> value.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

