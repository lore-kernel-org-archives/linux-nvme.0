Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9DFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pL0l5fTJnvGCy4hRyJloQZ6/JLqBp2lomsJ75IgeOs8=; b=cUK4kqjzkUs2wCOhaB+eQ1zfHk
	SNSbjdG+jzBIqGT3RvInViP0uE3kJIzK3pzwJNF0wrU6vvnVuo281GqRZwyV6CmS47LAIBY7UN9gR
	1y2fJtj4Dj3hDv588LedYcrpSdY8M6YR2repW0fk91cfvCwTiE+o3jVdhuBDJHPm8iNIdai6RcVi+
	gdC+dt/Rjb0W1xUJTC70esFIXTqQk4KoFKQ56pQi+J+4uiXkO8aAPG7F2psoQXTZ+gzYvXVrDpLgD
	1/R5s7FBIWY5NJmoyikrl2zZbEit5n1lt+k4xztgXUo9Gx8uJDDMUc8oG/F+yuuPADY3ZiTKrIgPT
	VJEPjpOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtAyy-00GSk5-CQ; Fri, 03 Dec 2021 16:00:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtAyv-00GSjI-N6
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 16:00:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED8F62B37;
 Fri,  3 Dec 2021 16:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFEEC53FCD;
 Fri,  3 Dec 2021 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638547216;
 bh=pPtSJeCyzuiCr16NQbZNhSrMqCUYV9xdXobe+ja8HsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VWV1zqkGkNvYkeIp8MRSK+3ZcDtauwm3ovUIGrQAzV4XO57s/hNiTIt9sYvP9bBy5
 3RmjGQIWoTOf8SNW9zgRCN/sFcCd6jcXEazMJmFxy05G4jVErwGll8TV9gXNU2cOYU
 i6LdOrls27lXymreOJOF6kID2KPzvFkh/nXxZqNhTlhtzmQmlVLoqfDxNf924++dz/
 YjYMvlWwH0qgJNmIY7RCQ1tqOnDKWntKnk0Cd+2nRTmAoLfUHVZa+GdWY5u/5n+KPC
 iZ4W5NBPoSvxQ9ApxpB05OTPuzMzTQlzyuAdJL0Xty0y4LA55M/XT4C41bKTMfCgjZ
 phfigUeTGhs/A==
Date: Fri, 3 Dec 2021 08:00:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Message-ID: <20211203160014.GD3839336@dhcp-10-100-145-180.wdc.com>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_080017_821073_CAFC5ADA 
X-CRM114-Status: GOOD (  17.50  )
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

On Fri, Nov 26, 2021 at 10:42:44AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The write pointer in NVMe ZNS is invalid for a zone in zone state full.
> The same also holds true for ZAC/ZBC.
> 
> The current behavior for NVMe is to simply propagate the wp reported by
> the drive, even for full zones. Since the wp is invalid for a full zone,
> the wp reported by the drive may be any value.
> 
> The way that the sd_zbc driver handles a full zone is to always report
> the wp as zone start + zone len, regardless of what the drive reported.
> null_blk also follows this convention.
> 
> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
> pointer for a full zone in a consistent way, regardless of the interface
> of the underlying zoned block device.
> 
> blkzone report before patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> blkzone report after patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

