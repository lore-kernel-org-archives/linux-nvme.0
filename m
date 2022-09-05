Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6621BECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=KB/mJ80SVcBhC0m4DqlKt1nDKQ
	p6fdZcebzddHEHDVOwBji+NUIiipJ2A962QdPL/EOl0rstC6j3Geu5APVAREFn/YPoRF2+LlIWIr3
	8i8QJP3bFN6+4VQtZmQ7MSttLAjz5Q+FYyKen96yYkEJxwClc4LSsaTVsZYuvKS71Nx1tER+H4GUz
	7c7RlV+ujc38HNuGG0T0spwr6L2H6Oov1L34RgBH/SsfKMkwpJPBctjesLqiIxcQf8cCWq4q88ke3
	XnRAuchhSeX+ivCOPuGVsEASkt72+Z2NDL9hy90VITDYSfLrmyGF1cdYGNwA+bIavdd3Fs3/nCrbQ
	fKE+bBOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVENW-006KW1-Vt; Mon, 05 Sep 2022 15:51:15 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9w2-000roB-3U
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 11:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=Rv5sl25fFTBZlC6K3zXAm/gWUk
	Kl15h8L5pAPnMJjwrza6lz6TLqV3SIW8fEOwOfELgigh9fjHv6r5PKkKcNsghmNqxr0k87ZSPRYJ6
	DswYODWnJBZd0A/2/ULx+gftHT5le+BkJteLVAXKMLq9LWrdtmCpW2iQlBCb32aHS935RdhjxVZeg
	7tqkZD7O/I7sj8MN2dgC/FRRHCOAoved0hNEjwkLs2xS1RYC8TtOwPLAzOSABYVn00jp7VUZ3uq48
	xULL2T9t/R1kZkw4GrcaqCI0Dh6BVKB6uGJqE21uTjD6qZlfyp7d5qq429D2iQ2lXdMrI58xCiOM0
	yZiwWnhw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9t2-009YeK-4r
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:03:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64A9C68AFE; Mon,  5 Sep 2022 13:03:25 +0200 (CEST)
Date: Mon, 5 Sep 2022 13:03:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Genjian <zhanggenjian123@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: Re: [PATCH v2] nvmet-auth: remove redundant parameters req
Message-ID: <20220905110325.GE21823@lst.de>
References: <20220823021441.968488-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823021441.968488-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_120328_384738_7413B695 
X-CRM114-Status: UNSURE (   7.83  )
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

Thanks,

applied to nvme-6.1.

