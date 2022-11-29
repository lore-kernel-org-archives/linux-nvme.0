Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A994C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1O0UDq25m9AbVSAfrOCHfIqgVDXg13TfoncZ2aiq0s0=; b=JkeNDqGp/joKCGL65ErTBhEjZy
	usqiPJIhZIX+yc+PCeo/WaGLbT52VuhiqwnJEAeOGcwN04yZ4EOUOjWkiQnkuJr79Twygt0MpgYTA
	IiK5nyzSElwztcdqrF802QpXTKcMUwqiafg6PdOX8YI4swNJqG98eLgNFDlUfqS4XPYPdOnOL14cp
	6bpFr/4QBByMUHb5GHX1S5symw5xriQltxG+z3rpgWXrrDhDnVaeC1Ijb8P3Zo7fnyU9R8opaFrEC
	LvbWyKw+O+t6XrRDt/qMvT9jDFpbmRjcNpuN7PzUUd341L3BXfO2h8v3TEhjdSGsWxFATjneYNmHd
	fv3SSVrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p03hj-00ACuw-VX; Tue, 29 Nov 2022 16:43:31 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p03hh-00ACsT-5L
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 16:43:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9AAE3B816AA;
	Tue, 29 Nov 2022 16:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DCC433D6;
	Tue, 29 Nov 2022 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669740206;
	bh=1O0UDq25m9AbVSAfrOCHfIqgVDXg13TfoncZ2aiq0s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV1OWyO0Y7rOm+5dkYluQVgHHYX+w9Gcy4Hq4SlyHBpd/8GX+p5DNS/giPGCe1gO+
	 Vlf/E8KQBlAtDNDENAOmd42auMlqaaa4jKT6tMFLcUJgejwo4gHCe9U4e/uLkcr94Z
	 eFbxv1sCV9FWExHNSXIhfLHYsnOtFl+nkJNGUSM9/vQLC1mAqyoF0+sIv7RTyVIu9V
	 NgUs/1tdRZqlOO1v5D7iJi2f2LbiuJ0r6dHccnYB3FpRQmX+6jZqbvKZt/YD2DXfq6
	 gQIZNBkAVzCpqFXCGvumHPYa8zZCqmCx5z21y1POzIwT+KhNdAaGJhoPeu6SfqURHk
	 296eVLh6VltKw==
Date: Tue, 29 Nov 2022 09:43:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Message-ID: <Y4Y2qjDgtJucSOoK@kbusch-mbp.dhcp.thefacebook.com>
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221129144510.GA18909@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144510.GA18909@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_084329_367112_171366D2 
X-CRM114-Status: GOOD (  11.35  )
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

On Tue, Nov 29, 2022 at 03:45:10PM +0100, Christoph Hellwig wrote:
> I've applied this with nvme_start_request changed to an inline
> funtion.

You'll also need to change patch 2 with this inlined. That patch needs
to either inline nvme_mpath_start_request(), or add an
EXPORT_SYMBOL_GPL.

