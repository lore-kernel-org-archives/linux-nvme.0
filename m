Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5448C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qg/6NSlTLuktSrz4fg8G6tBh9p4MUN6HlHwOEKkNeyg=; b=O6d9uHJP0bejYWeLFfj8hMiqc4
	oSHaV7lkemAHsw473h/aExaOVNWl/PvM3sBGJW0AstfTlVqNLLUY5MaKFBelZiRdawgmeuGfLocsP
	PuQHNu2Zc0b1z6AWwptD77S/WJMn0AQK3cpRs+vg6HXkQR99T7s05KKh9RlhnCy+C6iGxrj2mCtvT
	u+gIw46x3EuONTMKtPJ/oiBXtCCZEF7Op9Epf3hdO7zkZxSJY3cpnVo/rrQhGQ6lDL0ukzcLsvjqb
	jiIvFHxaBz4bAlfLz1XyUoWZX0a5cJuxaXteLcHaSWszQGM69vQXSCo2oladYT1NRNVA5Q+mVysRq
	oYlhVbig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc9aL-00BE4Q-1n;
	Tue, 14 Mar 2023 18:41:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc9a8-00BE2A-0V
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 18:41:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4DDE4618C7;
	Tue, 14 Mar 2023 18:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F962C433EF;
	Tue, 14 Mar 2023 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678819266;
	bh=gsw98yfzihruESmv2mo1q2H+updBBFL/jK+YIM4Kc1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUTpGsMI8uIK5Dn5bLWY39QWEXb3ZqV5VCzrBV25BkiQfPz6qAzpZXipvvXLthS1R
	 FbtVyqh5ozQVdY+7Xfltu9rTdbRSIyCVavPV3tFex/hc8AICNHOFaaDLz5WxaSJLIG
	 R3wEpVInVonP8CaPzkyAEVEWBfk9QQX3bNNLpBN314UWVon4VMsUJ0NZxCF9yArO8d
	 JA+bMsNsAzvI9NKzGeJL2D0wUfmCSDXSw75U+4izUplYt68Ae7CPJGTVXZ5XQb9ec3
	 vJG2yE7ARmNlsvc+kXeLa68uKYfBYkr3Ul5R5OMG0DCrYY7t6mo1ha+h7UXvlXxDvd
	 HpwrEG9CDpKrw==
Date: Tue, 14 Mar 2023 12:41:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: Fix error handling in
 nvmet_execute_identify_cns_cs_ns()
Message-ID: <ZBC/v1QR6dIsELD5@kbusch-mbp.dhcp.thefacebook.com>
References: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_114108_870549_FCC6CA74 
X-CRM114-Status: GOOD (  16.31  )
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

On Tue, Mar 14, 2023 at 03:20:36PM +0900, Damien Le Moal wrote:
> Nvme specifications state that:
> 
> If the I/O Command Set associated with the namespace identified by the
> NSID field does not support the Identify Namespace data structure
> specified by the CSI field, the controller shall abort the command with
> a status code of Invalid Field in Command.
> 
> In other words, if nvmet_execute_identify_cns_cs_ns() is called for a
> target with a block device that is not zoned, we should not return any
> data and set the status to NVME_SC_INVALID_FIELD.
> 
> While at it, it is also better to revalidate the ns block devie *before*
> checking if the block device is zoned, to ensure that
> nvmet_execute_identify_cns_cs_ns() operates against updated device
> characteristics.
> 
> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

