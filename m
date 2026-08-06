Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E41C56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTnsp5Hx0praDGaN0w7FZ76YqqKOkfoY2eAvZYJLE9k=; b=0S+eCl0XKOvxFbIZIFMRwlG5g2
	7j0AYa/QE4LfkhGmf/W0P5Sv6b1u97TwJZEax+U7cxslHaq6uQFPuBb/ADNx6J8mlVfAi78gF/cA9
	IqeAhCdm9GZylHd2qnugtyJuWD4LTRkZP3eksZs9UX36BUpzbb1VMIrzJfd05S9xar38Z8cdm/pAU
	RVnRyvo5wcU0a8VHlKNmpNIZWb6TVW+bL15ut4lELqkIXZrcrRA9q5YnPTrvA1xfNA5+5LKjOrvXu
	HHl5zg56ISB76RBwA+F74EMaVHmd3828Lk97/xr5FCSd3TNjD0bGw3yLwR7YrstewtCAj1PSgZplb
	9ga87nbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrw8U-00000005d7b-3P0w;
	Thu, 06 Aug 2026 11:19:42 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrw8R-00000005d5q-3nkZ
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 11:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=sTnsp5Hx0praDGaN0w7FZ76YqqKOkfoY2eAvZYJLE9k=;
	b=pH7HndcINEZ4hDb+NIw8hUoODRUToJI52BDwjawGV5OvF+gAS+DXn1AWrVomw7
	pE1kHTJSe4iKCmrBgA75DfQRq5LTMmycpcIejad1FJaCFOCEVmi2Ozx/oVwhDJb0
	lU0N1rOYO32kQPNfl5O3+GknaAqUJdBFQyj9er+bUiGU8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXSQGGbXRq_setLg--.29444S2;
	Thu, 06 Aug 2026 19:18:53 +0800 (CST)
From: Jiang HongHui <jiang_hh2019@163.com>
To: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Cc: Jiang HongHui <jiang_hh2019@163.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: fix invalid free in LS IOD error path
Date: Thu,  6 Aug 2026 19:08:31 +0800
Message-ID: <20260806111830.786384-1-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729110206.207755-1-jiang_hh2019@163.com>
References: <20260729110206.207755-1-jiang_hh2019@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgCXSQGGbXRq_setLg--.29444S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUU6wZUUUUU
X-Originating-IP: [120.204.117.76]
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC9h46emp0bZ5X6wAA35
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_041940_375569_D155B2F1 
X-CRM114-Status: UNSURE (   5.23  )
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

Hi,

Gentle ping on this patch.

Thanks,
Jiang


