Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF7CCED61D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 07:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6DwY5+EzyLl1NLS5Pi2HSWtJ7j1QXyYJI13SAXLTnk=; b=v7K5vzWPqwKUAGRN2S2SF4Oi5X
	8B7KCU+Y5yj1nh2t/mLw5KBR7CZ6kGx4anv5zJruWHNddZRxtYLp4Dc54ckoGWvDo8jCjNT6cuWDa
	8uTPfViPfdYq/lQcJxRXkGHxTbVOrqw07CirqucOYLzH2VwxGSvSoAkFw24XE2vDIqjgNSxrdccpS
	I08UYXtanfppKcgmaMVd09W4b5Z7aZAOt0Z4zKsAz9AC5jH8PCYPTWw2IVoqN15GdYt6c88RpD6kh
	yLKIdikf5NVt/3RElaxgGtxPgeVz4EWX9LUAO10yrPyFIeW6jbgHpf/UFG6C8T6NBBkkkatOkxfEN
	/qaYOOiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRYf-00000008KXT-371F;
	Wed, 09 Oct 2024 07:56:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syRMc-00000008I8x-2WAA
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 07:44:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 803BC227A8E; Wed,  9 Oct 2024 09:43:56 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:43:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
	Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <20241009074355.GA16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-1-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_004406_799471_6A1B48F0 
X-CRM114-Status: GOOD (  11.76  )
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

On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> Enable support for NVMe devices that identifies as rotational.
> 
> Thanks to Keith, Damien, and Niklas for their feedback on the patchset.

Hmm, the only previous version I've seen was the the RFCs from
Wang Yugui, last seen in August.

What the improvement over that version?  Note that it also came
with basic nvmet support which is kinda nice.

