Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327C1C19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uMuZwWVDZvuAiyqKaKTaJ3JINEwJGVOcMFBBvJKRWs=; b=eDyPeGd9g7c9PPCSFrGh7/TTug
	CV1k1IhrOuwaisHVh9UriTK/qre93fn39m6kLKfaJj2Tse/89KYV4DrNfdAQEP1BmFnZ31I3V6HlL
	TFUPTfEDoeEe2IHyZmgHDS0SU2kiTn8JjbTH4xMjDjJcI5EXTknq20TF0/tfJEOsqDRCjUFsCBhV9
	29IOQVhrTREPAG/BMkA5iTgdqOQvVQE7wZLbwC1AOUUCXDFQc11KSJVKX0F8aRqv5OCr3nn5CJR8d
	ZKDU1iOjTVRdtxfHq7NkCc85lTkW4ijvWmRp2S1EShuNpGJQ2ARzzRjMtl2oJdi3KU4V6M5VvKEVK
	OkG+g6VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJGYG-007ER8-J7; Wed, 03 Aug 2022 15:44:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJGYE-007EPF-3L
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 15:44:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EB2F36172C;
	Wed,  3 Aug 2022 15:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00D5C433C1;
	Wed,  3 Aug 2022 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659541488;
	bh=8uMuZwWVDZvuAiyqKaKTaJ3JINEwJGVOcMFBBvJKRWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lm6xRFvU0KhPo0RXcZYDotGCny5Q73YSg7FtpKcKwfKVbXyJWncdkndbolKRaLfSt
	 W0AI7rFLHP/KV2ZSKfKA4rKiaIJEglhSzGcvzltQtUbEJg/h+6EuuZIuTwQEUBHXkg
	 RFTfB4TCM6Y/FILxuzGWGqdxyEKiH9ZtDriY1dbQ6XzhfBtiy+dTtVhPkDxpaAwdFc
	 nqs3KePoKL9j1f6hMxYuXRm3Pau15cb8aspq0XuPIZcQ4anT/QKM9wyxCyQJhfiBCk
	 v65TYOOKBlMeA9WJQd0q6Uwa/s1lUULKOLkWHDWuUqukwzIFDG4fbR2uQ5ETSE8l9b
	 ZdISnw0MR7dqA==
Date: Wed, 3 Aug 2022 09:44:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: allow ioctl to submit io command with dif for
 NVMeoF
Message-ID: <YuqX7dur94Vr1PIA@kbusch-mbp.dhcp.thefacebook.com>
References: <20220803094436.23407-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803094436.23407-1-lengchao@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_084450_213881_A91721D0 
X-CRM114-Status: GOOD (  13.03  )
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

On Wed, Aug 03, 2022 at 05:44:36PM +0800, Chao Leng wrote:
> If nvme over fabrics support t10dif, NVME_NS_EXT_LBAS and
> NVME_NS_METADATA_SUPPORTED of ns->features will be set to 1.
> Now nvme_submit_io do not allow the metadata if NVME_NS_EXT_LBAS of
> ns->features is setted. Indeed It should allow the metadata if both
> NVME_NS_EXT_LBAS and NVME_NS_METADATA_SUPPORTED of ns->features are setted.

I'm not sure. As a passthrough interface, don't you want to set up the host
buffers with the inline metadata instead of relying on the HBA to splice
separate ones?

If you really want to control this kind of thing, it would be better to use
NVME_IOCTL_IO_CMD instead of NVME_IOCTL_SUBMIT_IO.

