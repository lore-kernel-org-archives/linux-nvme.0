Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A07FB5197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t8su3zMZjRWFsSvEI4ErubNyYtWvKgmIMbExWOsxFQA=; b=lXdkNwv3EFMaNhCy4XrzfdHdHj
	hVy9gceqAUMeSx8dA/ERGC63Yu77/ap2uiB1Z21z1YH36FTEgP5ThB2dxexV087VBAICDqhHvJ3XS
	d+egCx/YON+NB8nr3cD+edMOkdfa4beTPa+tDB5J2UJjxeJHLiBvE7v0gtU+5isCgmWgQSt/BdB+n
	W4Dxb965T+YI3Sa/cM3EbsdDOBXk5xeUkx3czvPdRbE86XN4jrBAsTOJdB04y17t43YqgT6u0Rn4C
	9CCm7D//njlPP2+nmlclA+MnsnwVHAQo7vKhutbroHXv7eX832iY4SZBr985ZmPaFk9sJAuovFe4r
	z2G4B3hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zIr-00000005wlD-1JQS;
	Tue, 07 Apr 2026 05:48:45 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zIp-00000005wl4-3sjd;
	Tue, 07 Apr 2026 05:48:43 +0000
Date: Mon, 6 Apr 2026 22:48:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Esteban Cerutti <esteban.cerutti@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <adSau_eHqy0LxP5e@infradead.org>
References: <ac7eHEnFQlLN-vDy@yanara>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7eHEnFQlLN-vDy@yanara>
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

On Thu, Apr 02, 2026 at 06:22:36PM -0300, Esteban Cerutti wrote:
> Today, a successful write completion indicates command execution,
> but not necessarily physical persistence to non-volatile media unless
> FUA or Flush is used. This forces the kernel and filesystems to assume
> worst-case durability behavior and rely on synchronous flushes and
> barriers for safety.

Nothing relies on synchronous flushes, and we killed barriers a long
time ago.  FUA does as you say provide persistence notifications and
is heavily used for the (relatively rare) case where it matters.

>    - Normal completion continues to signal execution.
>    - The device assigns a persistence token ID.
>    - When the data is physically committed to non-volatile media,
>      the device emits an asynchronous durability confirmation
>      referencing that token.
> 
> This would decouple execution throughput from durability
> confirmation and potentially allow filesystems to close journal
> transactions only upon confirmed persistence, without forcing
> synchronous flush fences.

This is so complex that it's not going to work in practice.

You've also failed to explain where you think your model is actually
helping to improve clearly identifiable workloads.  Note that all of
this would be limited to consumer hardware anyway, as volatile write
caches aren't really a thing for higher end hardware.


