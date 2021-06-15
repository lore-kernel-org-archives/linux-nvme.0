Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479B2C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A32261414
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A32261414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MZ91ycylvjk8erCOmYeLyfja2deUDcuRfDacF7GIxYI=; b=gkFNROY/egF03W
	4/9fmq/F3OusocKKaLR0I3On4NaFdV+dNoXs8UT/pt9xQJxa93vof+xtDjWytwlN/NiHSMJNoTd83
	il7HkNBYmnKJDREkUuZ4Oit6twq6FLOs0x1qwXHfptPvCcSOxaUVxwPdOJ1Iej6dn1WANRgGsAqHF
	oWmckUk8JKLFhiBJ6WR+DY7jS3Z6ToSGPnmAQwlrHDDdvUqcI4yPPIWZHETJlOoAGz/eE4MfbAlqp
	GHd8fJ5QJpME3FekuZMbhPICS61zi7l4mbxRjBoCw3Vpq7nC9bH+RhtXyfmEpVzjNu6xMuITGWFZC
	r+aUQZGGIyIlvRDd7Stw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltCkA-001goP-Ef; Tue, 15 Jun 2021 17:20:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltABh-000dzD-EJ
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 14:37:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2475F61464;
 Tue, 15 Jun 2021 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623767828;
 bh=xBkTfMcRJbm0r2yuh07T27aOb/wH4z9qzwDyOpM5Gls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oo0UExwt0A314sDdrtZxUnok0jEzA4xHWLtCJ6GRMW6uQytwGSGmdCtapFX9IuM7t
 q7QoKS2cHRKztaK18sa2Hwx5Iao5tcUkvauEVln7nz7R4iOdfq5QwlxfHh4YeZCTfP
 gflDfbYrqueDUJxxSRMDnIGznkbUlDZiLjUI4YDywOIf6beuTxlog2G+tiA04ESbto
 TsQW5PNpzZyiGgT3JMLOTC18yEWx+4xoiDcyyF8t1M5fY2WAXwxxEPX+MD25GoyhB+
 BpubDUTmwWljXOIcs9yJJvHeMgmHoTMgezora00weH5XisSOBqXvMzlwgPEciidjuk
 tlVIUwSlDN0kg==
Date: Tue, 15 Jun 2021 07:37:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Ming Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_073709_582277_218439F2 
X-CRM114-Status: GOOD (  11.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 15, 2021 at 03:10:18PM +0200, Christoph Hellwig wrote:
> Chances since v3:
>  - rebased to the latests for-5.14/block tree
>  - fix the refcount logic in __blkdev_direct_IO
>  - split up a patch to make it easier to review
>  - grab a queue reference in bio_poll
>  - better document the RCU assumptions in bio_poll

It still doesn't look like a failover will work when polling through
pvsync2. We previously discussed that here:

  https://marc.info/?l=linux-block&m=162100971816071&w=2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
