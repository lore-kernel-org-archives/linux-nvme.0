Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FC0C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIlNnsAW++j+7Vd8HGL9baesOhQoYRxmYvz6+hl3Qf8=; b=soOphGAebI678NZBQl6CjPrmr/
	8BaUnSDlaY6lbVQlZ1nfvBwdH5dewKxUBmMElnH5Y0zlPI0XGAo7R5LYZRNx3cA+FRVhcBTdAbqSV
	wqBO1ZYcDeg8MUjpxhpfc9NyRhzh2INKJcLauG6TJWacZS3VzpJUdZc9aemQJ8shg0uCqaQiALKZd
	9hsHR4Co+c8iWuDo7SZSY1DjDJKkVY4eQdB03AqDT2D/qJBA6yZD4M0K0SmmYbcK6SHdVZN4jb9ba
	CAOyzdPftHhVVc4ViwAF8Ts69O/NGX8yyqwUpKTRXrAb7sjrA5EdXD97oYd0JCS0klrIgi7vErjMp
	ZM0fuFHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRHg-00DScX-03;
	Wed, 15 Mar 2023 13:35:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRHd-00DSbj-20
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:35:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E671D68B05; Wed, 15 Mar 2023 14:35:08 +0100 (CET)
Date: Wed, 15 Mar 2023 14:35:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/5] nvmet: Fix identify Namespace handling
Message-ID: <20230315133508.GA24915@lst.de>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com> <20230315105939.305825-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105939.305825-2-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_063513_810822_C57C749A 
X-CRM114-Status: GOOD (  15.45  )
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

On Wed, Mar 15, 2023 at 07:59:35PM +0900, Damien Le Moal wrote:
> The identify command with cns set to NVME_ID_CNS_NS does not directly
> depend on the command set. The NVMe specifications is rather confusing
> here as it appears that this command only applies to the NVM command
> set. However, footnote 8 of Figure 273 in the NVMe 2.0 base
> specifications clearly state that this command applies to NVM command
> sets that support logical blocks, that is, NVM and ZNS. Both the NVM and
> ZNS command set specifications also list this identify as mandatory.
> 
> The command handling should thus not look at the csi field since it is
> defined as unused for this command. Given that we do not support the
> KV command set, simply remove the csi switch-case for that command
> handling and call directly nvmet_execute_identify_ns() in
> nvmet_execute_identify().

Yes, this CNS value pre-dates the addition of the CSI value,
and thus CSI should be ignored.


