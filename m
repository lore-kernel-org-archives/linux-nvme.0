Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 15:46:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1714461155
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 15:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1714461155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mQJlHDxDtQmsOrG8uNS/+Ld+2oNZ1uLf+7dgdf7h4Pc=; b=eIuor0cchF1Mqe
	2m0qbda0pGTMzitYFZCxyHa7YhPx0binjEl99hxWfB4wSqWwhAf6sC6ZwC+IvMQ8tkd4bf3JwohN0
	jIpqjGuDJlsv95g7a+ftxXeQGFx4mZPCIz7CSPX5LeXb8Jhvg8nhbLUpxry5w4eOffbIjlzxIbE+6
	1l5jhhSKlgSja/EV59cvSiy8wM0KQN1s9o8SB9qYcHsfScmo0IpfNn2z3zMfL/xfj3VPpEWBPQfFA
	IxdTYjVvXfuDe01nZ2ZJdb410HR2I3zYBwJmQqv4SBdbghEb39jeWB6yE8/uMuzPYoz+iXbNGoAoi
	nezw0vi1rMgzSxr0ubBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQX7U-009SH5-Ju; Wed, 15 Sep 2021 15:46:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQX7R-009SGW-Dy
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 15:46:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EACD560EE9;
 Wed, 15 Sep 2021 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631720798;
 bh=mYmby1XnsXoFTtySu1dO6/vGj1d8ol4I+G1gD0HcPVs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b7M5P6/3dUyf6m8UQEhBrTzsq/Z+x8UyJ9NbHbOvxovy+RSWzCAgXtIZ/WdDZaSBI
 NLyATHztxqJ7hAql5A8EtH5YZdUfhIRCpeuCXhJksMuxjbOGAmGa3aSzkROcL0vB8l
 LzLYiWg0UdjyuAUW718Wi6jQERt6hTGXuU8tQCzjg9zF0jah5n21wIUp6CaNjGeWEx
 eyljHBfENx0+Spr2pEOIUqNw8Csqh/Xr1eNVBOgzW/yjt/xn2LU2hgYswq5jBxmBbh
 8sAZJa7psD8Glv4bYJT4EPkj4RDpdTg3eIrZ6pwNE/D86Yk0+7+6Ez0UaRe5+zLEPM
 hNa/OcxYn8tvw==
Date: Wed, 15 Sep 2021 08:46:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Message-ID: <20210915154635.GA3850143@dhcp-10-100-145-180.wdc.com>
References: <20210915153751.1457173-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210915153751.1457173-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_084641_540512_646EF1BE 
X-CRM114-Status: GOOD (  11.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 15, 2021 at 05:37:51PM +0200, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good:

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
