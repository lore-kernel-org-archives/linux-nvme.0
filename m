Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3360FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EIizC0oADjccfZDZYGHNvmamuQK2rgFmQbwFJPTJhRE=; b=HszLXmx4FjTvymc9X6Cme9gNYz
	ber5LaK5GCxhB6U9YXvMFZMpl15s6aDNFUB8EiRuajvtLWZjiNhMgloSVeAj09LcTiX7TWkt9AZ4U
	GjvlJqVwqzPYdM4LLRmB0ycL0LyEI0uEKIx6M3fBA/4Xwk+CUZIL7gfUr38hh5wH8OfvU3g2VPmHv
	CqKfehtrpGY0b6KD1hK/ywrJJ0HYLkksFgRxsOUwhlnS/kD2OTQhLFZiR8i1HQocioOoYCBnA9lfr
	Zn4NjBm+nvGY5lD+xUNKY66sRvq28ce6ZIYhketlefIk2kL2rB2RBs1nVg0v+ZmL/Ry+9vmpzRZhG
	X4AUSn5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n82lx-006Xdn-SK; Thu, 13 Jan 2022 16:16:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n82lu-006XcN-7x
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 16:16:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ABAA561ADD;
 Thu, 13 Jan 2022 16:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA7AC36AEB;
 Thu, 13 Jan 2022 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642090577;
 bh=f4RAl0sDMj6T36Dk3Gy0xhmQBdxNZ1uToc88x00Z5+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ONu9CB8s0kXwJwe45EwgTHR3YSFddZdWo5tKceKVjcGJSOJDZ0E0pwNbynccOH7To
 8OLvm89hMdhpYN8eeB2YT8X3CINVQUxhzy9uZFleNsCTS5t/50uwryf0btfhU2kGH5
 6A4y6ojp9650LcFyp9lT+Evj7Tfetl0JJpX81oUP2K6VJDMog6D7X91agxKs/OdtGe
 MuDUYXuKX3yz87oHHxtAYn8Pd+SuR9QihK3v3cHMkOL17MpetFsb5OSo/fH1A2YGLV
 n0laYu9xY2+YfiJzmPdE8Bq58oHLrgDka+efCXEbz6kZOvE6S8MsCREwqTN4ftw5XX
 dcPn0II+BnWHg==
Date: Thu, 13 Jan 2022 08:16:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/5] nvme-fabrics: remove unnecessary braces for case
Message-ID: <20220113161614.GC3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-3-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112062101.90102-3-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_081618_355200_2EA665A1 
X-CRM114-Status: UNSURE (   9.16  )
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

On Tue, Jan 11, 2022 at 10:20:58PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Braces are not required for enum value NVME_SC_CONNECT_INVALID_PARAM
> when used on the switch-case statement, remove the braces.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

