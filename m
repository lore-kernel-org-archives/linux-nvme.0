Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01F4D597BD
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=374jB6hJrNl0AK2nB6w/M/yIxwNVFoPWyu7dEI+xklI=; b=AOxZMUuaBa9Vb+RS3gxHhRth0+
	l9DnJrcR6IaTEHQBTCcOyRYE4LIeZQ/4F0FL8MhQ0ZxYHDdmCciyV0Bi8SiiDl/c5IkSq0n2iRWNY
	bkBxR7Oj+wPQ9nueA71V9keiKreUM7yGnO+KkRJDoF2e1VBWC/ufAIVy9fKPOSxB9bbNfq6pYW9YC
	Z5exxActMCQs14O2bxDDIuhxnpyN+uJue2WFztsSiUE9itTTLcWI0LfCyDUxJsTeuUqPBo5eTEswK
	f9bVBYIiEjAV5now+9TPsqvYQi9C4z5zbYjA1P9QgPlHMHepe+HUFuK9mOKX+2pONfSQE1b+Ibejl
	+yj7rBRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGhR-00000007Vxd-0Nu5;
	Wed, 13 Nov 2024 16:58:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGhO-00000007Vx1-34Ow
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 16:58:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A2B77A40D7A;
	Wed, 13 Nov 2024 16:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C33C4CEC3;
	Wed, 13 Nov 2024 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731517113;
	bh=374jB6hJrNl0AK2nB6w/M/yIxwNVFoPWyu7dEI+xklI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaAV9/ZjoDCpViX//rSOCAJ90zD/ltxg2N99F7CbsO5Bpha4OzZNG8QVX1h9VmrMi
	 nMOEwOa49ogVTA0ZWaOD4pklsVanTVw6dPIQN3ZnNWw83ueCsr97E0Ec+uok4psxlS
	 oBS13ZCFZgkE2PsO4Zr5hamwxIHFNTuNah49EVhQc7NnL0dD9964AeDkrGf6wVTWIp
	 PuIRg3MoJTKAiyj/qzVDtPeoKmDvdXIXcMSpU2bu9b+Q489R/tkhnZAh7Xgt5JW6RK
	 XgAIUTzMpktXCLJ+tiyC+qyxy0jALZSqr0iHF0BFCVHZQikd0zmdV20YTYhRlyeZDZ
	 07ZXIfPxmCpCg==
Date: Wed, 13 Nov 2024 09:58:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5] nvmet: report ns's vwc not present
Message-ID: <ZzTat-jly9CUnhoj@kbusch-mbp>
References: <20241113101839.101320-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113101839.101320-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_085834_858464_4FB98410 
X-CRM114-Status: UNSURE (   9.73  )
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

On Wed, Nov 13, 2024 at 06:18:39PM +0800, Guixin Liu wrote:
> Currently, we report that controller has vwc even though the ns may
> not have vwc. Report ns's vwc not present when not buffered_io or
> backdev doesn't have vwc.

Thanks, applied to nvme-6.13.

