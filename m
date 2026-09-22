Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE722C982FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfvUSx3nWzsWME0SMo6zV+P5ZEdJjsHo/ZxJ+7G2kQw=; b=lbYiWgvl407dcbzq+YOegCPmEK
	pxcI6HBPHRLLz1hwAHtw9xvpFp8TGpwe1U0jWRc2G+wVD5HILRhJyq3TLGSCJn49kOo2g4kR9LWgR
	ngiBKwB9hSlhUCSjbOac1eBZbuHR+80zVeY7E22yo2cF1jfklCRLu984LQqV9x9wikU5Mjv9AWIym
	4y1l/kd40jiXRrWH8pnIG7h1nbHaeCUlQfR0XRADFmsWxLBZYO4wc1Bek4r9bPbW8gdB9G9gxl5BW
	rrJpuVt4r1hGzWPO25SbmS8gWgNmmNU/+FzIXnUCzEPob0BqJYBOrFipKOH1LLgE3vH/HoOg5YXQz
	2B+2BPRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91yQ-00000005las-2Hsd;
	Tue, 22 Sep 2026 14:59:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91yP-00000005lag-1U1U
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 14:59:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D285E404DD;
	Tue, 22 Sep 2026 14:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577F1F00893;
	Tue, 22 Sep 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089196;
	bh=mfvUSx3nWzsWME0SMo6zV+P5ZEdJjsHo/ZxJ+7G2kQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NlzzuqzHeWanEbM6v4mV6hqSpZssW2vgN3ZR60wT+emilQBA5XlMQSyq0yj7QLNWd
	 JtlWH8dNTU0UESgg6+snD2SpjIUJO0+UNYClJUJjbt88ODutrSDCpw7skmJMNvRYko
	 mD/0BlnKnOR14BPz5GXvJzDW7BRQYvbvPHD1LZ0A8QxKQVi4vxKvnKg2MNvr18Xv0K
	 z6cU5Ua4ucOw5YDCY8amhcSY1bzXMB4EEQlp+7aDMZKy1LbYGZVpBM49jyEDTp27ay
	 azwPOIsDqy5s1P+J5A2b/75Tn6Nwse0ZHun0jeVrfmAjDyjwl+hvvw8JFMTVUJtY/y
	 B/5HVY3ONmiPw==
Date: Tue, 22 Sep 2026 08:59:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH v2 0/2] nvmet: fix subtle race in I/O processing and ns
 configuration
Message-ID: <arKX6rZq_CLz05X5@kbusch-mbp>
References: <20260918162736.802665-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918162736.802665-1-nilay@linux.ibm.com>
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

On Fri, Sep 18, 2026 at 09:57:29PM +0530, Nilay Shroff wrote:
> Hi,
> 
> This series addresses two race conditions in the nvmet core code that
> handles I/O submission and namespace configuration.
> 
> The first patch addresses a race where target namespace attributes
> could be changed while I/O is in progress. The second patch addresses
> a subtle race that could allow I/O to be admitted even after the
> percpu reference count has been killed or marked dead.

Thanks, series applied to nvme-7.4.

