Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B981C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUVnm5cI41Zrmjz409ZmwNrNCts0BmR5dRN3JI4B2zs=; b=3ZJhg+x/sLRvQI3KihhmZ/Wr+x
	s9v/fND6o0b4UetEkOo9k2DNOc8LuTIgslo0owFeH9hYgSXyRmFLJ1Na6av9yQ1wIkyEwVQccCr+Z
	V4EUE9gtJyHIUlZhG78GpHsvqfLPUA83R9/x4n4vWBHS/5xd3RQ2wV/vVx5DX+EBu5wjJEKPQKEXT
	CpYwC73mQBHADdoTYtfq/zz+kzlw5apTRiH4S/4kK3k4iNqJsgXqxqbttMOjLhSvUYUqFXXCuHfaK
	jgdCfVUia+LmGgJleQgzDW4l/r5+dgmd6JlJ0H489/EUuJp3AVA9Vdxeq7Hse1QgZJs8AfgftxT+u
	M3O8tPLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNl0l-00HZ7S-TD; Fri, 03 Feb 2023 01:37:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNl0j-00HZ6r-SB
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 01:37:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 64BF861D3F;
	Fri,  3 Feb 2023 01:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E705C433EF;
	Fri,  3 Feb 2023 01:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675388224;
	bh=sUVnm5cI41Zrmjz409ZmwNrNCts0BmR5dRN3JI4B2zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0yXKquJLrckHZq6FWcV2Co7L5ejGLWMiFYSao79V+YtbJ2CCDUjTdYZNjxya8RCM
	 fjP+0k9C702+5Gf+1pxmL2B/1oFXL7pXXQUWRAeHLiANLuUNMTQ5lpuThn7FDI/PjZ
	 6c/632Y1uYUaKKDFgN3XEY0Q8TJ6mk4sTn1317Kdr5vaDI7hm9daFy9s5rb9+jIu5o
	 4BHSgzVKOWkKMPbPHLTTcezHVekCQHXZ+RNrkHVv61dGIDZ41Khh9jHn3aNWNVGBOw
	 pPp8wjsJzDzV+LqkA6AFulrGOjO4AQ164FixSJGKm8kHhcELOs4o7OYaHDn8ZmvK/b
	 DM6N17sKd0hpA==
Date: Thu, 2 Feb 2023 18:37:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
 <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_173705_963438_F9BE0EC8 
X-CRM114-Status: UNSURE (   9.76  )
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

On Fri, Feb 03, 2023 at 01:29:46AM +0000, Grochowski, Maciej wrote:
> I run remove/rescan for this Samsung PM1733 and it looks like it works fine on both 5.15 and 6.1.9

Sounds like the Samsung wants a longer, non-standard delay between SBR and
reinit.

