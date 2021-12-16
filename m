Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A23C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+loWFP+6KWat0buvPbRlq91Z5ql6QhEjhblPzjaoFM=; b=r5GMB0B8m2gxD3DjhZpi8Dcfjz
	sbeoyIEGju+SqCp5qnc7dQSvsZwlXjiAHnUb5QMmn1TxoPB5+cGPJTVLnNilzqqC9fRgau0i8xwUh
	RHnQcq1mHeLoH3/Kq8r8d1bSOia1wTTJLPwJ9QBszdiIhxrvfADi9iJ2UN1MQQvXNalfbs3bhf/ag
	K4y0o6SiPxPz/pzytNTx6JInm4MUpfYqyfpCPy6S8xLW0ZZKpH+SU8Bk0ZPRgQBSYmbPpPrMnLK+U
	9RO+taZHC56QXFceEMMEKrmdWcHCQcwTjWf+4QOm/QFB/ocXhTuVcpMlyVwPUkFgWXItCBscuTPMq
	1mFrXn3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmHa-0049FH-2X; Thu, 16 Dec 2021 08:38:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxmHD-0049A0-6G
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 08:38:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 79A9968B05; Thu, 16 Dec 2021 09:38:08 +0100 (CET)
Date: Thu, 16 Dec 2021 09:38:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add 'iopolicy' module parameter
Message-ID: <20211216083808.GC24927@lst.de>
References: <20211210131444.120946-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210131444.120946-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_003811_410532_A881D625 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

This looks good to me, but does not apply.  Can you resend it against
the nvme-5.17 branch?

