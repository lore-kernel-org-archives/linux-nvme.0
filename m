Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551CDC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLSqGm74MPi79s4y2Wlnn0wLSkeqeKzqXqNm7lM3Qeo=; b=TO52fWpyw1MDstZFfYSRTSYxZM
	GA07yM36wAoeCXVkqQ5f86Iai2Dbm/nonZXFsGBud3fefat6S+SoRYsIYIVm1sr0h7PaaFwdAJyfX
	hci+8PucpagsbVhVsl2la4GbTSgpArMaLi4Yha1Xist95d0o2tOAx3aeoqCT5JDjinNvmpDYTDbZu
	pvsPjqG29ZCgZXblqF/9XGjduiT86E1SHcCCRv3O0uIHB6t1YxGh3JWyTlG4hrXgteT0DVVBpnFZ7
	MaNmK2yIASYM8QYl9LZycNPuu3QzWYK5zOn5VQpC4sLyT0UH0LMXtVlaFJn5UtZcoT4aCECmIRyRj
	xgtAftGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvru3-00000005ZTB-2pUv;
	Mon, 17 Aug 2026 07:37:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvru1-00000005ZSa-0bj3
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 07:37:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FE7068CFE; Mon, 17 Aug 2026 09:36:56 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:36:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Message-ID: <20260817073656.GA19508@lst.de>
References: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_003701_342497_A9465D7A 
X-CRM114-Status: GOOD (  13.16  )
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

On Thu, Aug 13, 2026 at 04:31:07PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
> with match_strdup() before validating the DHHC-1: representation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, I think the size and structure of nvmf_parse_options helped to
get to this.  If you are interested in a little improvement project
in this area, it would be nice to add a separate helper for the parsing
of each option so that the strdup allocations are limited to that
scope (and don't reuse the p variable used for the token).

