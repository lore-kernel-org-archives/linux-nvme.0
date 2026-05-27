Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0821ECD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KPsfbD7GUFo5m7xuR/hN4FIrmteOXfb+l9aRn/BMCa8=; b=skJiLKkRMHt7Hxe3BbRgBRKG48
	Es6e85sSx9hemb7j/m4fuUrETElGg9HBw19drYS81wKSL/WuYKD9y7YyIZGL+Xj3SzfULj1R5CdcL
	KxDn0bNx7LnE1zAxl8ys9x5BtWoNthnsi+e0FB59oVgeIhPSyuM/qWd2U8Ib6a1zLTOg82nVVXw+z
	3S7XiU56CEtn5z8XK6MbBJFRek6DR6aeA/BhKcLtrplK5EeJgPTFsUN7daENHJIgSVZp4hWkUqcVh
	eGw8NxsUX5CSP0/YM/FrAVgRVYGSuWXZPUwKYk6yZhQXt3HicVPngZbi7uHCoBifWkItaQg4qNoi4
	eD1GKoRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFlq-00000004M3r-1MDn;
	Wed, 27 May 2026 15:02:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFlp-00000004M3k-1GJm
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:02:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B67A46021C;
	Wed, 27 May 2026 15:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3CB1F000E9;
	Wed, 27 May 2026 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894128;
	bh=KPsfbD7GUFo5m7xuR/hN4FIrmteOXfb+l9aRn/BMCa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2i2Z98l+ISElxUihwIcVfEU4ct7TCiY82bj9QRkY6Zmvf/G0LrFrZ6q7PriSrnJs
	 mKown2yhdl58oFJzYEiq5lXnS3kfA0xcME/eXONRCsLchMmjHgBYZrul7PmcxDhFgi
	 E76AD60Cp0jxIZCH8Obmt876V8q2fiLZvlFISMZFWXAZXG5ieR3rEQsg8N3OwwH/Em
	 WzKHxXTF893VGZSmzv3zTwXHTSJFTLHQkqTKCwJmLKHRN9Q7TMUKKmXAx+5zz4Ufla
	 YLYjkKRrkM6SkXvwCLJFNWmP0p/PNRka+WxbFWS4IkEttmo4UukeVTxDGU92mCCT6i
	 srux4xSRGvwLQ==
Date: Wed, 27 May 2026 09:02:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, bmarzins@redhat.com
Subject: Re: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for
 multipath_sysfs
Message-ID: <ahcHbge8q4_gLEP5@kbusch-mbp>
References: <20260513095030.2771178-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513095030.2771178-1-john.g.garry@oracle.com>
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

On Wed, May 13, 2026 at 09:50:30AM +0000, John Garry wrote:
> Use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE instead of
> DEFINE_SYSFS_GROUP_VISIBLE, which means that we can drop
> multipath_sysfs_attr_visible().
> 
> Incidentally, multipath_sysfs_attr_visible() should have returned a
> umode_t.

Thanks, applied to nvme-7.2.

