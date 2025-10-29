Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF6CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MN4/wn4zxa0vrCzDYjCuQcG3uO463Ndy2R655UvTag=; b=2nscVgHkbl8flvLF+9cGJuLQsr
	F+rZ914YKILg0goewvy1VSOm+XxSoaoWz4UAY6PbajCIyHLCXwJadN06BsOV4D970Fz4zWB9rsrd2
	iA6SEmAaGybQJhzueUTkDJ51tqE+tkaRPbSZwmsGw0JL/xO8PDoR+7BC7BqV/MdrG1lYIT06WjAP3
	pnGMD4XM9BsJlvD1yuQzrjx5YuNPh+m8EdRQz3ipFm0+L//C1+6AVBlPjCLcI37qy71mmEq1urJG+
	7dAhjM+MGsnd1+cjpY9l+4Mdvml5AnFLbIrfmKVkJjSTPU/PvkOjCKRp9TTt86zQzm6dido7wFNjo
	Mu6aHqKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1v5-00000000NjJ-1QF1;
	Wed, 29 Oct 2025 08:52:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1v2-00000000Nhi-3M1R
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 08:52:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8734227A88; Wed, 29 Oct 2025 09:52:32 +0100 (CET)
Date: Wed, 29 Oct 2025 09:52:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
Message-ID: <20251029085232.GD32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_015236_976607_3448490F 
X-CRM114-Status: GOOD (  13.39  )
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

On Tue, Oct 28, 2025 at 04:26:23PM +0100, Daniel Wagner wrote:
> Nothing is using lsdir member in struct fcloop_lsreq.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


