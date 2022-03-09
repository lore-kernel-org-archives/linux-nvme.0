Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAAAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/ZI4LRYMYFfmZvELCcnlnvi0vSZaNEjpzkEMaNUGP0=; b=L2xpkJe5+Lop+YmV8RslMT3g2A
	cAHycRyT0VcdwC4rt+WxMQ44mSvrOmmBsUKrcvgyRyb1EBBQpRYIVCwyDt87W1U+S15g30STTthX6
	Nn7+Rs+CS01gaYriwubpjMaR/bLz6pPz0BiU6z+ZF8rcqhQpxWRzQf8uPcqIoQMq4x0arGNGHPn5T
	PWRrLnuDeMMuxo+p00uGNMqKfxXUOnSHfvRu6u0fDN6NnTp559ADjR1gQy/EgtjIalvISP7GMLAA3
	6Xi7dF/I9TQvvOSIetR3DTkGXdTjt6hspWlkaLsN/h/JX9+oxJiz3Fq7YM6kME5IqBHEKAmYQc1g+
	v16kNGtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpmO-007W7y-VP; Wed, 09 Mar 2022 06:26:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpmL-007W7S-Ug
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:26:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7560E68AFE; Wed,  9 Mar 2022 07:26:30 +0100 (CET)
Date: Wed, 9 Mar 2022 07:26:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309062630.GA31508@lst.de>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_222634_165258_A4826E27 
X-CRM114-Status: GOOD (  16.26  )
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

On Tue, Mar 08, 2022 at 05:45:20PM +0100, Maurizio Lombardi wrote:
> We suspect that the root cause is that the nvme-host driver doesn't
> enforce the 4096 byte limit for the IDENTIFY commands as the
> nvme-target does (see the nvmet_execute_identify() -->
> nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE) code).
> So if we pass a 8192-byte buffer not aligned to the page size, it will
> need 3 pages on archs where page size is 4k and the nvme spec says
> that the data buffer may not cross more than one page boundary.
> 
> Does it make sense to you? What's your opinion on this?

Combination of a broken application (does what the spec explicitly
tells it not do) and broken hardware (does the most stupid thing when
fed invalid input), not much the driver can do here.  But we really
should talk to the nvme working group to ECN the text for the single
PRP requirement to spell out the consequence in more detail, and maybe
also mandate how it is handled for the next spec version.

