Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16865C369A4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UcXz4hmyM5NzqOHUkvtN4rSbEHNbJVlCLt8QyDaGx5k=; b=J10rtHTQs8bPWgTgLdtSkcURFa
	treOGlfpGzGHi5J7FS+cpgC980VLtDc7sYbEK0Off+XWZH2tjdgKfO8j36Skkf2snegwjIxkP8FVt
	U0badjw2mteNuK8SnQclKTD222/DdaQfIMSg7C88Fxt8zleRnJwEAH2g9ykyFZJr+5Hp/VeRSCVWw
	NNXGmcvjhr/AFyjuaE/MB6mHuCAQ5W0QAwpDZNpIiYtiPDYz5PbLOcR5ojT79iLw+HJ2LIlqJ+jG7
	X72HoKSxWn0KuFLw4uUcFVXTqauezivtR75h41zVjiy8bMY+414NwoKrb4/5ttx2405kHvQU+LGqT
	KqZrr7RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nNm-00000009lfm-096H;
	Thu, 10 Apr 2025 08:35:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mvo-00000009fwk-12ou
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:06:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 592B66112C;
	Thu, 10 Apr 2025 08:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C743C4CEE3;
	Thu, 10 Apr 2025 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744272399;
	bh=WP29b0V4hny6efm8KQ3RY0rAMrLNn0QTVw2j22H+Gg8=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=GQ6GsKhHAijX++DEmqec2gilIKobwaaq9bfa1XBKg8cFuN5KujpZisFE3/edhTH1O
	 5TAJ0iOQxMZwIwNE60OhRhJK92a3YNLlO0NSBoFsfR1G2qEJjFPe8RB92vSzaeBAVP
	 zMBT+kY3InpDNkw/m8VJQh/uitvUoy1fV8FbgTS/fF4j2F20fG6njwG5LIQwij3b64
	 9qTD4DNsZNyjupDjiVYCE4m4cuJ9U0FXZdm5H1FMTg1Nk23NkGU8hN3ktA/IEMhK2N
	 LYnsl2jZl1TT73KEWe6OlIRckgyUZGnk7OfWKj/dvzIcGdv2fE+3sg8FJ0ycsgOTIO
	 vrVqMXlm4tdOQ==
Message-ID: <ddfd83f9-faf3-4e4b-823f-4037cdcd7e58@kernel.org>
Date: Thu, 10 Apr 2025 17:05:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] NVMe PCI endpoint target fixes
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20250408024733.690966-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250408024733.690966-1-dlemoal@kernel.org>
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

On 4/8/25 11:47 AM, Damien Le Moal wrote:
> Two bug fix patch and one cleanup patch in this series.
> 
> The first patch fixes an issue with completion queue entries
> initialization in the case of failed commands.
> 
> The second patch fixes
> the initialization of the CC register to ensure that we can always
> detect that the host is attempting to enable the controller (with
> CC.EN).
> 
> The last patch cleans up/simplifies the management of the PCI link
> state.

Ping ?

> 
> Damien Le Moal (3):
>   nvmet: pci-epf: Always fully initialize completion entries
>   nvmet: pci-epf: Clear CC and CSTS when disabling the controller
>   nvmet: pci-epf: Cleanup link state management
> 
>  drivers/nvme/target/pci-epf.c | 65 ++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research

