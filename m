Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C1ACAC5AE
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QjdX7VLsbVycGf5I/sVkByGph+VBYvxz+Jtn4G857Pg=; b=y7xHtCH9FXtK8C3sPYndOiN5AE
	gjn1cO7Lp5mRvL7wKpGY1GOuFtpZOdNSPEe6azkWzUlHeLOgmzunEknXDJXCCFP2P7BrOFoQnCFWE
	M+cq+4r+KVJZv8Q8AzF7BzPZuMsulZx8XH7hwuzS7kBFYPA5z5OfaCTWZ2b/nwpN3Mum0IwI7qpwm
	Y9DDqN2l8J1gON/hpccY+c8a1/+o8w2N8BFKyXcpOOW5mZnToSjfVsVMaUNIwgRXF7xV7NKUi6JOe
	tECNvzHlU7H7MrBAbs8mIgdovaoEQ3Qsd2J9sI3L5O3sYDFIFenVC0j5Bu7F3CGef+i3WaNaLPTDY
	sr5ivz9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Xkj-00000004CBb-2vt0;
	Wed, 24 Sep 2025 22:14:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Xkg-00000004C8R-3Fi3
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 22:14:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 753F843FF2;
	Wed, 24 Sep 2025 22:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06054C4CEE7;
	Wed, 24 Sep 2025 22:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758752058;
	bh=QjdX7VLsbVycGf5I/sVkByGph+VBYvxz+Jtn4G857Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVWzX0o6Q3OQ10T2T9oaMpMwt5EcLIkbzYfHCXx3OeLLoVWvrLg1eb7wx0JSF7s3E
	 eZBUcsrm+xixOTRrkhL3u8P4lvhs+edS33i2ylQyaYOoy3XJ+8iypE2Gl6xjMxB/yj
	 l/N+cnRYV/uwxHKhhDFN7tDgeypLFmFOLhwmNXqvqklVB3dT+bWuZp/6tzucQxm9OA
	 KuKo+zj6OP2FcF06YkI+yW1IwLXXO/LGtGwkoGgdfZCqg2PnOmfA1Un0KZrI/jC9Zc
	 qJU1Ik3yGxZ8NFU5erpjJ1lIiYVdvXLQx5gpjxHH+eOu2UTc7KAm5SyGzhyPHvue7E
	 WlRWxXdJhESTQ==
Date: Wed, 24 Sep 2025 16:14:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/1] nvmet: remove redundant subsysnqn field from ctrl
Message-ID: <aNRtOKEmWMYrDT6-@kbusch-mbp>
References: <20250924203402.10688-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924203402.10688-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_151418_831264_D062319E 
X-CRM114-Status: UNSURE (   8.78  )
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

On Wed, Sep 24, 2025 at 11:34:02PM +0300, Max Gurtovoy wrote:
> The subsysnqn field in the nvmet controller structure is redundant,
> since the subsystem NQN can always be accessed via the controller's
> subsystem reference. Remove this field to save memory and avoid
> unnecessary duplication.

Looks good, applied to nvme-6.18.

