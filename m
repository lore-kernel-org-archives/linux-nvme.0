Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A34C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LgVpiuBiz5JKa78R7/9dNmTt/0WZ8QDqLNNOes1VYs4=; b=j5sV3AKAqvdLbUy2qaFZ0VYOx7
	hRoyxftyuQbYXOLOUx820bop2Hln77ctL51J+WUvwfDyQ44Gl1cJZ8B/o8a5+eio5RAXIJ3H9EqF1
	A/ZkOJ5bSvDO40Oj+hZ+60H5TRcoSwHhYbhx1Cw/g6fE8dfb6dklGfX3kPwGtFruu8V06UsieAyP5
	w59zjfnquHNyu7ud/zs0QGPAyUusLjPiiFsYxdS/m7QUnHvCb/7Pv7dpQ6F9q8h8NHNpW5YGovyNp
	+oGJ+GgubyppH4cp5MnTzA3fZX7HL0sEGm7BlPUfYob3ygq59rKHmS5jBGwQYJl3a56aDUFFppES5
	UK6zcBQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFGC-005yr8-VJ; Wed, 16 Feb 2022 08:02:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFGA-005yq6-T1
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:02:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69DC768B05; Wed, 16 Feb 2022 09:01:55 +0100 (CET)
Date: Wed, 16 Feb 2022 09:01:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 oren@nvidia.com
Subject: Re: [PATCH 1/1] nvme-rdma: add helpers for mapping/unmapping request
Message-ID: <20220216080155.GC10554@lst.de>
References: <20220209085449.40773-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209085449.40773-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_000159_109644_C1126BE9 
X-CRM114-Status: UNSURE (   8.36  )
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

Thanks, applied to nvme-5.18 after moving the unmap code back up to
avoid churn.

