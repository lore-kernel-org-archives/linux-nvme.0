Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C06C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938A42465D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWdP9evi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938A42465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ukrXoPpm2DS9dsYn+zGJddrAM5v+isUGh4NLBAeFZjY=; b=pWdP9evi64UFYU
	TbGTsRxXqoziORV6U6oTbXe6JHcQtLefhZJyZuPfzhGMHWn/6hKYdRp4HFmCvRoC+2xAllo++uKzj
	NdqpIWWCDwO3ItCJmOrnL0bGyX4AD4duFGYFPgodUtgHwazMpoXYJzRj1RjhOIA3EuR30uA8uvT/Y
	oyM5VJraswyBc6u9lzOMtRF3XDk4NvOeJm01JKDXtGfBV1fvq4BPQwcBOyuCb8BDAdYI3/9uVpN7v
	ZP9FRoaissq6WkPqSf5KVyP7+J4gsLY3DtzGGxYSG9nIXfIs6gzyEUhyDs4uaaGUzMNDWWoyb5ndC
	beOi87oEF91YfNtUf51w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4S7l-0001EE-RI; Wed, 19 Feb 2020 16:22:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4S7j-0001Dp-UA
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 16:22:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 15E3168B20; Wed, 19 Feb 2020 17:22:54 +0100 (CET)
Date: Wed, 19 Feb 2020 17:22:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3] nvme: code cleanup nvme_identify_ns_desc()
Message-ID: <20200219162253.GB19584@lst.de>
References: <20200219161431.5025-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219161431.5025-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_082256_117427_7557A132 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 19, 2020 at 08:14:31AM -0800, Chaitanya Kulkarni wrote:
> The function nvme_identify_ns_desc() has 3 levels of nesting which make
> error message to exceeded > 80 char per line which is not aligned with
> the kernel code standards and rest of the NVMe subsystem code.
> =A0
> Add a helper function to move the processing of the log when the
> command is successful by reducing the nesting and keeping the
> code < 80 char per line.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
