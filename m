Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313A8C55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WBqsL4NAgO1e29Er+hM7sQMQNsCb/xGeYAKa+tQtBJI=; b=4/U+A3AHvP4oMzHrXLxCr6MHho
	OCp55RX+yWCckoBrFSQzqBzFIZpKN/Dyw4LK73uz8GvZIVbTfU7deVXI9bAfWicoKtQ8oG1KoLPmB
	UgDm1VwhY6QPpOFbTevIdpn9mY08nr3cTE27zLrp6TlMsZkbqzHURv5rF3vu9p25fkY3L8rbyp0lx
	ivd2dVeyS8Pz7auGuIz06aarDYvFDk9gB0JIsu4BjEHlUjaV38q3YF9QDiA9GcMypzC4XjutU+I7D
	r3HHeEVQ0mHF9IYhFYH7NlY+JZeXe4oeIX7MZXGD6VGEpeSj9imJBuUbZYCfGMgAHBmgrzuJdo6Sy
	iV0StTsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr6mu-00000000zIe-37aV;
	Tue, 04 Aug 2026 04:30:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr6ms-00000000zIJ-3CgS
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 04:29:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D9C543F6F;
	Tue,  4 Aug 2026 04:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA31F000E9;
	Tue,  4 Aug 2026 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785817797;
	bh=WBqsL4NAgO1e29Er+hM7sQMQNsCb/xGeYAKa+tQtBJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DkPkbb73c+xW3DXG20X+XanbY1bTl85ujK9oKiJ+zAkbcjua/WmaiUsCIkRbRNpxG
	 G1Tp4YSNsj9ryO+BxuefiE0Kp75b6rku/XYxEPNrzeuslpFcJgjqvZQzZNv9nlALAu
	 jsobJgEV2+eApun3Ugcm8AXa8q2RK4W7rWP/QVVtaTHLzrBrhK2ze2SoHKu2u+dnHA
	 cwDOQ9/7Ma++eRTQ6+aSQjLgMIxsPVELqnVkJ1mLGuRdnMfJe/qPJtMkaNSqMkn/R+
	 tOcAcVG+Vrip9HIRvNeNCEEb9QZtsu2xMqRzLoz7PHoydXOcstORPcEQY1kXe0z8iX
	 7qY3e77JEXoew==
Message-ID: <617efddf-bf71-477d-bdf7-a05f60b41336@kernel.org>
Date: Tue, 4 Aug 2026 13:29:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_ns_zns()
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-nvme@lists.infradead.org
References: <20260804033605.3973127-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260804033605.3973127-1-kanie@linux.alibaba.com>
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

On 8/4/26 12:36, Guixin Liu wrote:
> When a host issues an Identify command with CNS 05h (I/O Command Set
> specific Identify Namespace) and CSI 02h (ZNS) targeting a file-backed
> namespace, nvmet_execute_identify_ns_zns() calls bdev_is_zoned() on
> req->ns->bdev. A file-backed namespace has no block device, so
> req->ns->bdev is NULL and bdev_is_zoned() dereferences it, oopsing.
> 
> The I/O command set is selected by the host-supplied CSI field and the
> command is routed here whenever CONFIG_BLK_DEV_ZONED is enabled,
> independent of the namespace backing type, so any file-backed namespace
> is exposed.
> 
> Reject the command with Invalid Field when the namespace is not backed
> by a block device.
> 
> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

