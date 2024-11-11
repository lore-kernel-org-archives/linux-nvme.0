Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3971D3ABDA
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=klzmfKyB/vBgrfamePB8Kw7IbfktcAotCZ7Mr4rgdZk=; b=Dw8udZsKkIp/qBmjJtLLwHbtgh
	2zBR8vqNU9m+zeiI6PGsi+Whvcjh/tOKPyYGlZ/NRgmhZj17Db7Q9c5VXRbfX9225X1bKeHx6ITmT
	LSOGe4/cczI9f9DiluIJTyzKK8QR11VAfsQwaavA2TmLWB9JaI43E+OEuDYJxGSpwFf5zjlKzzyOw
	JbY8Fm2zkG+gIZ08JaSEfH2ae05koxV+dd0z+e3TtvpwUYfJKXqGwJcT3hP3Z/1Fwt3kZrFnDxQX1
	IDTc2+ayXTrLE8hBORvY3L+Crxq8X3eXwLkO+HGDZhQ2FRDcqliIX/L04ETYTT5HJmKu3GeBMqIR1
	V2QzERXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkp-00000000one-3oDu;
	Mon, 11 Nov 2024 18:03:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYbs-00000000nGU-3u1k
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 17:53:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DEB9FA417C3;
	Mon, 11 Nov 2024 17:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58216C4CED5;
	Mon, 11 Nov 2024 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347635;
	bh=klzmfKyB/vBgrfamePB8Kw7IbfktcAotCZ7Mr4rgdZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lE8EJMOlST1Yy2524LlIlSUwvEzlmT+nRTgWwR57rv1KM4DXK7kd2/TPXAhVHoT/u
	 FA6xlSKoii62Vz8oX6uruWmYknoq+lHzUbaQ8ZCWjqkXgB4DVTGk3zqA1X6yoUQJs5
	 TQVyJoivMDI9NuVsr7E1AMNDOa+2jwgllJgiLYBKFPngSM61F40jJWG/BCSaHDvdSl
	 wxH+M8xw+FacgXkBkzDtTjAch4zRJPLJVP+hCCql9figcOFqMJDcWDMrx92S57ckay
	 Kjdyuzi+QIN4cGyUHtw6Y+vM4XCFP3aJtm6C1XDnthDBxOipbAUkHkj8KBKqhqtK0N
	 wmf0J51vd9j5A==
Date: Mon, 11 Nov 2024 10:53:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	linux-nvme@lists.infradead.org, linux@yadro.com
Subject: Re: [PATCH] nvmet: fix typo in pr log enum
Message-ID: <ZzJEsfRcohmA2rwv@kbusch-mbp.dhcp.thefacebook.com>
References: <20241111145649.18332-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111145649.18332-1-d.bogdanov@yadro.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_095357_054725_547D021F 
X-CRM114-Status: UNSURE (   7.24  )
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

On Mon, Nov 11, 2024 at 05:56:49PM +0300, Dmitry Bogdanov wrote:
> Fixes: 1900e1a4495b ("nvme: add reservation command's defines")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

Thanks, I folded this into the original commit.

