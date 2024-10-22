Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFDDD2CE0D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HmsH66Vz9dQaAoNTfa1vNFXmGyi84kaurw1GQxQ2VtI=; b=tzcPH4usZeXhC1ElczwBw+Hcuu
	T+F48neXect19gxM7eBbJxAcv0mifSUiQuHuGHZLxk+/fcHlYdTQTgvdbPYsX+1tfU9BZzGdBUSXo
	ZZCiS/X6alYGCefMQxeBF3FO4auSNAroXeCZbny+Zr8z4JmiqDVZ5BYHxHgP1chB5OErYDH4/0GM5
	ck4bULjEgjNBxUbwIvSmvhpvp9OG7gaq9Bmm53L8QRTqOezaqM3rPkdakdN1zJ0PhHHRnbfdxAsk1
	Sx+pbg3CNIbJSfKN0rZIfLu5BBPIwyP0JFgD8WOkaBCy3C7aj2bmGNLRLKCPDSXTP6NXdqed4hlRL
	+IeXS0oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Iy2-0000000BiGN-0hmF;
	Tue, 22 Oct 2024 17:46:50 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3IlY-0000000BfR4-0Zom
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 17:33:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0B34CA4430D;
	Tue, 22 Oct 2024 17:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDCC4CEC3;
	Tue, 22 Oct 2024 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729618434;
	bh=0/wkZZzh5kJAtUsKVRGEGpEHoJAI9VSJbhopQTtvE4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5fRaUq7xr76tKwxGkjCX9JhRaSZKxw9mKgsbRZra1w0nfAC3K+CpxqneDL/hSDcG
	 dVW8lFAKQLMkZgE6OzxsognXAEPQptyHYOTY3JXJwWjcyvMJ+rNUcWtFirIwPIMeH2
	 aju44+BYPYx+K7B8a7PGgFL5YmKhUasg5byVywSY/bVR6KUDNaPbCBW13b67WOPxKs
	 c84CXvZbbZ44n6OuhFUksNfT88947HH5AOeC9FGEgAulKKvZDCksvEaxTH190wlEFS
	 e7SsyA91TjOwlbGnNi6gFfWV6jUkJkQjgppopy35Cdt1vqOf1xQdnJ89ZeKOLPqSjc
	 LcJPWyVpTRaQA==
Date: Tue, 22 Oct 2024 11:33:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
Message-ID: <ZxfiADxyL-uZYgBf@kbusch-mbp>
References: <20241022163504.10738-1-ikegami.t@gmail.com>
 <ZxfY2IT15o_2vTZq@kbusch-mbp>
 <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_103356_261621_FFA3509A 
X-CRM114-Status: GOOD (  10.02  )
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

On Wed, Oct 23, 2024 at 02:08:52AM +0900, Tokunori Ikegami wrote:
> The existing function nvme_configure_metadata() code checks as same as below
> but is this checking case only okay?
> 
> static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>         struct nvme_ns_head *head, struct nvme_id_ns *id,
>         struct nvme_id_ns_nvm *nvm, struct nvme_ns_info *info)
> {
> 
> ...
> 
>     if (head->pi_size && head->ms >= head->pi_size)
>         head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;

This is merely checking if the metadata is sufficient to do PI. Nothing
to do with usage of PRACT, which is what you're changing.

