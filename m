Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0621E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CutMUf+epe0XejLYJGLqvbfBoX2q3z2kz2yvs7QPS2A=; b=H11bn/Skh2HVEtsgwe/ET/TC73
	0c1wggXEs88IP1kPfbuQYOyMSrFB9B3IZcDqlQfOlOnr2efJbDuyuHAqL6SNEqpnSVnnTZIq58GaB
	igpO8y+r6hzvH227UCvQ0JSJP8N9cuUKSXfaVL0HTh2VUIWFmUjXzmaHqlzkfya21bUs5xnZFeCjZ
	vzLGuzXfIrZa/anGR78jHpmKdzps6tl4pwAQlRWmgiFo8jtwahNOExStKq4ek76daMgB2/Uoga690
	797TEEderEbRXqgDVU/ZF8mp4NAMOQSAJeTPYhRoPZ8Bn1qVR659CMh14NHD+2H9ZsySUXLBHxXuC
	p8bI+poQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVD96-00000005nZn-2HdK;
	Tue, 07 Jan 2025 17:13:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCki-00000005hgV-2Vva
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:48:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00B1A5C365B;
	Tue,  7 Jan 2025 16:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53626C4CEDD;
	Tue,  7 Jan 2025 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268503;
	bh=lW3lyuLJmNieNkGGyGqKsg7/aJNJ59SJY2wjQG2I7QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/ogSSOHKEHnf+wC/6HAh/bVEAMkW8puxlUD5jmFRvJo21uu4onwSqyWyuOpw2bzf
	 NzcT+zw1kmXk2bVbNYmGA7e9bNvT9XuMhF6IM7g17OP7JSDSbDVVorpx909/NLQrE5
	 vvhbXoIc23JDm5oXeaUd7QFi20xaQKnLoL7XK+uWzCc8YwfVjARKH2aSCVJzA8Eckg
	 q+mzPNVx5vDQoySeSbrzBB3VsgK3vXvVJKy+ToIjbKdK0Qg+MrOD7f9YbC+KEo4ZVG
	 d6s53X63HPaVDoJODu5/ueWRVaGvRNy+yfbOyRT1VRMFEWYWA4p98iwjzN+yhwbBtK
	 qDK4kKd+eYqhw==
Date: Tue, 7 Jan 2025 09:48:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: change return type of nvme_poll_cq() to bool
Message-ID: <Z31a1eE80KswWyaJ@kbusch-mbp>
References: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_084824_680372_79A980EB 
X-CRM114-Status: UNSURE (   9.99  )
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

On Mon, Dec 23, 2024 at 01:05:17AM +0000, Yongsoo Joo wrote:
> The nvme_poll_cq() function currently returns the number of CQEs
> found, However, only one caller, nvme_poll(), requires a boolean
> value to check whether any CQE was completed. The other callers do
> not use the return value at all.
> 
> To better reflect its usage, update the return type of nvme_poll_cq()
> from int to bool.

Thanks, applied to nvme-6.14.

