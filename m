Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D1EEAA72
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Sep 2023 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuZcIY077npfEKXHffTbmUkUdNoOUeGNyt/vNJcrCnA=; b=iPRE4up+TBwiCaFDlwSPcHKlWX
	P17sL7ot3wVkbckVoWvFV9DvPDq0NikAPqgzZqi8jSXWTkghqSeHAlKiuJotEOc8pQQrihX0c1qJe
	Buo5E87VyKJ7lJXWCPSm3g2NWFH3PzGzkmG2PgDMzUTHvTkdJmBqyyX6VJZ2/cifyjKXyA/o82GFj
	KTR9C6LZlli4d90ySmVoDgdvmVaezcHJoKwePVcpL+GwBxqxEeFersvjFlLxcDnxq1nzyN4HrBt+z
	AVxSZecybMA5heRzxaf4CJ3Z20SUajsAPYdjpZv/dbSQRBVUX1VyCSoUDiQd3U7Scyat7s9T9LCRH
	0zdkp1gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgsTj-009BrA-2c;
	Thu, 14 Sep 2023 19:58:19 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgsTh-009Bql-0U
	for linux-nvme@lists.infradead.org;
	Thu, 14 Sep 2023 19:58:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id A5993CE290A;
	Thu, 14 Sep 2023 19:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2FAC433C7;
	Thu, 14 Sep 2023 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694721491;
	bh=vnKDFySNlhlKPH3BAirwdbJlTr4ajeTiH5Uwamjt5sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PizRjT492y/il0bT9OELXX0UH+GBnfpE72LcuxQKmztSQ0MzJt8Mm0t+3Hk2bW1Cx
	 A8xIK6Rg5P2ecrSao6UD3dOImO4YkyyVfPFqdl4e/pTkryP/pQgcLzLL+XOhg0JPvy
	 7NUPEZNXkBckchn0VjFIdbhuzsGiPHJhD1BUO6rq3WTlHRQjf4O/EUqRFPvWRrUzI+
	 COeWH/io/bKrNYlgcfC8PH4Ex2ABSEbn+Q9e03oO06BTV05HxVpI2RqGGjbfW0426w
	 B4b67vLrw3a5LzO2s+sRDNeV6X2C6TfJRMRd7Y6DtXTfhz/SCfRJ/peZXEwATb5eQU
	 gE9G7cUqK7eYw==
Date: Thu, 14 Sep 2023 12:58:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Felix Yan <felixonmars@archlinux.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Message-ID: <ZQNl0WMd9E8obFcs@kbusch-mbp>
References: <20230913202810.2631288-1-kbusch@meta.com>
 <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_125817_366510_901DDB75 
X-CRM114-Status: GOOD (  12.44  )
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

On Thu, Sep 14, 2023 at 10:48:55PM +0300, Felix Yan wrote:
> 
> Thanks, verified that it works well here.

Thanks, okay if I append your Tested-by: in the patch?
 
> I noticed only one very small issue: dev_warn_once seems to only print once
> when multiple devices are affected. It may be more ideal if it prints once
> for each device, but I don't know how to really achieve that...

There's no good way to do that, unfortunately. We'd have to create a
custom "print once" based on some driver specific flag for this path,
but that's overkill for this issue, IMO. I feel it should be sufficient
just to know that the fallback is happening, and doesn't really matter
for an admin scanning the logs to see it appear for each device. My main
concern was printing it on every reset; that level of repitition would
definitely cause alarm for some people.

