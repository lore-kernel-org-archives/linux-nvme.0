Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0E0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrpO/w+My34bt5uxrUzjtjUh4+tEZjmXSqMBZgNaA5Y=; b=AxUdVhVwkJ1R97pyF9c6gUyf/w
	sfrFq8SvHatRdB66HN37Rv3Uex6N/FpCZ1pM8vdm3Vm2Dqyms1k7xqGIdBY3Medbu5nAjr3W9KqA4
	fuvJKq4bueMpSPisttl9g874VVtxNyZh8SEE1cneesjr+fCbxMCI7AO98uiTMJ3mndEAADUUbf0We
	nrdxIM4dFSubqRBsobnv3RB6Adaj4buKynngryvfBDQ+7sWlPQCI5Rym6Qsr+bIbA3o7dTiNXszow
	ELqPfYoJZtJInUI8FacrXlqRz6JoOfa9LvBYi+8GrsB9zqTYbI23sxwkH5fQKpka48li4336ROAEG
	RNU51f1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osodM-00FQ0j-RA; Wed, 09 Nov 2022 17:13:04 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osod8-00FPrH-Lw; Wed, 09 Nov 2022 17:12:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F1FE3B81F39;
	Wed,  9 Nov 2022 17:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D39C433C1;
	Wed,  9 Nov 2022 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668013967;
	bh=MrpO/w+My34bt5uxrUzjtjUh4+tEZjmXSqMBZgNaA5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huLsesn20HvleBPv/W6RmhDBOYU9scfsOY9vnXWilSRET9hZMlcF/3Jch68u+V1O6
	 MEvo5AzS8nZZexaM7WKmYEmmuJ4TD9CVBGaPZ0Z5SIL7bgzfm4s0QvsMmclVwcJG52
	 kwSWuSZVvGd4lJnpPwcl302qBM7n1yD9aJt7w0YXgB0MvN2lu73PgZpwFLY2CR9qA/
	 68gD9pZPZ0OkxMPi2hh1f99hnxeSonHTOSH5/avRk1ss3Hy/EoDRRQflsEzyIrsQ76
	 eMecpDhlbOiIwDb1sALCQuaIeW9IbcSGL6QFv0Mze1AdPJ1hUAAsX95KFKi7LFhqLy
	 vawW7Ey9ITtTw==
Date: Wed, 9 Nov 2022 10:12:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: RFC: nvme-pci: split the probe and reset handlers
Message-ID: <Y2vfjFc0UggRqjcp@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150252.2123727-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_091250_909960_20DCFB73 
X-CRM114-Status: UNSURE (   8.82  )
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

This was easier to review than I initially thought. This series looks
great! I just had the one comment on patch 12, but I think it's probably
fine as-is.

Reviewed-by: Keith Busch <kbusch@kernel.org>

