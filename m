Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C62ACED61D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8n2+txT6iMc4vPU2nhfohToAa6JBx/GfkMaNr88468=; b=dHsA2GCi7iLFvhxK+7A2wjcA0Y
	aG6I0KhFclhDt/KtjqHHBGg1FlMCCYj1fM9R7jtsvOfErlvHp4ySYunLB3hrxuXE0KsRyxG7JThNY
	Sw0HCQm8WDk/vOfMpp+uJPfi72XYcFgmOL6DlyNTPV1sscXU6k9b0vA4cKqoBurmPLVSyaVoG5QYN
	+dveBtEZjas2JzsmnK3lLdJtGdrczhz17EWMZF2hNshsdcmJ5Q0iA5RoN95HpLxaBbGEta428fRQn
	XEkMK8XszNPVgxxroO8afMIUjZZzILniC6pHhh5xcapy/U5thxyJKBzm8zmELnxepEAF6vRfoTh3X
	bq6LlLzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRa4-00000008L4D-0ZJY;
	Wed, 09 Oct 2024 07:58:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syRQY-00000008J6m-30PW
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 07:48:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C8AC227A8E; Wed,  9 Oct 2024 09:48:06 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:48:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 2/2] nvme: add rotational support
Message-ID: <20241009074805.GC16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-3-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-3-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_004810_916882_8D1C8E69 
X-CRM114-Status: GOOD (  10.48  )
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

On Tue, Oct 08, 2024 at 04:55:03PM +0200, Matias Bjørling wrote:
> +	if (info->is_rotational)
> +		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;

Entropy from block devices is pretty useless.  The only reason we still
keep it for SCSI is because of retro-computing platforms without a proper
platform hardware RNG.  NVMe HDDs reall should not show up in those kinds
of environments.  Also without a add_disk_randomness in the nvme I/O
completion handler this won't actually do anything.


