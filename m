Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C17C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=; b=Y6DD9f12+aoRbEsYPLvIXmXnSv
	pr+sqr0nLAPCpuSUcnhdfsSI4gE/wbcwDNP6+JP31jDFQf8psgyfIk0T3qFtUeXwFHT9SEVZZcoah
	Oa2ODJM9qXhDM4cfagmrkZ55aqqvs67OlQWMqJG2lZ6UcU2mijMvc9ao3zXTFw9ueYNmutcj9Ia3n
	Z+1WQmh7eNYNi6E1uatO0dhCE2lMGs9i6Q/+FvSe0EKqyGe/l4SZ9pWX+mCaRe+BTbuqa3cUylqGJ
	yusbVazhacyrGtp4g+5YI0QW+dfx9lx0c7J0hFlszL3kUOEoZhTMOR8jILZb1gd/Q3RB1Y2fJcidF
	g1nWdNCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAyLK-0018qI-VG; Thu, 29 Dec 2022 19:13:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxs3-000tNS-29
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 18:43:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9136F618CB;
	Thu, 29 Dec 2022 18:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54130C433EF;
	Thu, 29 Dec 2022 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672339392;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+OBdfuSw4VOQX517g6q5EguwCRbm0l0qJ51JEhmnZE4fzbFO8j8eVZppHhAgTwfq
	 xOIO9HUmtSLSwHP1TW2zxfICi7TpQfej9s8/t4jlQsrRk2d5NeXx2UCkw4Ui9b6rO9
	 vJaeewC6kmyndfGHRuGvZOEzH+V9xqUoK9L/7D4WH+7zYss/ZF1bIcT9sm+EHF1mU8
	 4zZVsgztSuyEtFdRdTPgxJ8gpGZcZ479dml8cHibManlzjNtG5pjh2yAQjM3n3RdFf
	 pL8+4LIEyi1jLaNU4stn6ZFAejXKTx1kZEsylmNz6qpvQ2NihICOB/YmOxhFSy6LU6
	 D6DBDdCqJQ8/w==
Date: Thu, 29 Dec 2022 11:43:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, t.zhang2@samsung.com
Subject: Re: [PATCH v2] nvme-pci: fix error handling in nvme_pci_enable()
Message-ID: <Y63fvFrlFZ1Z8yqm@kbusch-mbp.dhcp.thefacebook.com>
References: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
 <20221229183731.4013056-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229183731.4013056-1-ztong0001@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_104315_202021_2FDE3BBA 
X-CRM114-Status: UNSURE (   8.07  )
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

