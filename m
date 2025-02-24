Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0BAC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwBebQALWtbP8g8j48tKjs/2b6aQ3oRZv6PwWsbZrd0=; b=xHCzl66IduPsITogTQdVkT4RyA
	kWFxSn/C8X7efNyDB99gmSfJJTYXLTs8+wmYr8zAI507h+fCdSn/SfQ36goNx7km05QPFHbbbF3jY
	3/P6GAM2Lg6hRgqQrtPYkZIG2lEHxtQnC8O9KR9mbPya2QIoSF/WeMdwFw7n6iagNzvvhNzfX0ifG
	WulcYoTswOXxOLHQ4nDbKE1i5Wo4lw4s31NFkE0TMTfEeouWfvG8bmxEDBGGo/F+fdXgxfryqeFHD
	/PoUIo3O8QYgpG4OWgR8IT1dupyNyURAhNrt/tCI22IFe5E389hn4Wf5u8v0ORP7kQu5hk/Rk7QO0
	P1CzOMlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgly-0000000FLDQ-416H;
	Mon, 24 Feb 2025 22:17:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmglx-0000000FLD9-2tem
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:17:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E2388611F4;
	Mon, 24 Feb 2025 22:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3465C4CED6;
	Mon, 24 Feb 2025 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435476;
	bh=fJYk7gNUVlrWpKa9va8rtet/bvGTyQZGCXEmhK8KYZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8WxzK5BicM4aGnpeGmlxBkbGDsvxgQn43U2MBY2Cx1XZowtZFBRqmbQU3J4pchQv
	 9SKyFJ6bz+TYTvmfWglAScqLR8/in4yDGxxanrCsdIwxDzpjTP5ea+dy3QEG2Kf7XT
	 IIIUd0zcAI2wWTaY7M+xxv+NBAi0yR7lAU4TgYeQWWTG2egmjQGivKuB2rC4++YoZO
	 4gZ4N9HL9elT0G0vdIy5+a4DWf/l3wbm81nDplnwip3so+XuxUuTDqaK5wF3lQFddw
	 BfabhhBHeyBiEsBLR0IgoOzDk8QApLkBEAu3Us3T4RvRmhS7h7AiS6sFYFMoDdww5o
	 5XlPxJPFC7DEA==
Message-ID: <08d99f95-fe9a-4f98-9cd0-326f0ef54b2f@kernel.org>
Date: Tue, 25 Feb 2025 07:17:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-2-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-2-kbusch@meta.com>
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
> Helps to reduce the number of parameters passed around.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

