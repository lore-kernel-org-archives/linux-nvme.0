Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1962EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7vXUOLSVCJhj58CJyiqvzWuHESa+8jb4RZd0RwY2ns=; b=KwxsVe+WvlFSyhGTsMKjubkoZh
	dNkL5/TgviWGcEHQBcS2SqCbjs+2H8m1MjkP5WU5wTaaGgdvoaOHIGfMbNwkruwlNIErytEgHJDpD
	bV2CEd98DmQ15+2th+69G5HbobQR9Ke4M0Gk6dMP8WBhQ7xkPKzY+X4cSwQ8GRtQijT8+ZKoMckgp
	4D0egYfMOvI4LZD2C/uG6iqPFnrsaPKTPFAy4dsSan6YfadXC+IeutptsfmM32BEX2wU3N6ZUGYks
	3QhjJEeqEClMCrFoGMV7sWU0TcQWaBgBI0evtVcJ6H6LOMPcY6AosoV+YJJxmzQGMiqtvQmrGNlFR
	ZHgBhrmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qC0yN-00F7jh-2J;
	Wed, 21 Jun 2023 16:46:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qC0yL-00F7hK-0G
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 16:46:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB7B6160B;
	Wed, 21 Jun 2023 16:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34DC433CB;
	Wed, 21 Jun 2023 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687365979;
	bh=u5z3ftv6BB076pT5euIJojw2xnPqDLGdMYKakdyytIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hj63S+ykIPE+j7FWCIXD97o63nTf17Gp0jFj++wXidUxhZ67umI9k+oGfZZpXlIJZ
	 QnHEYWbweXL2c1RcZ3ZRcB8b1RZw7ZkpPnWC0jr4DE4sYbYBDLYvgzI7lOp0qeQn25
	 9ZKRVIc56nsK7zOV2MRJEgYtLYwMrDQ0XiLbxVSPkixx1jp0lxtlEN31CzV3LTJczn
	 IH5r6t4oAhwVLmAbdOKKKhZGXgogIHDdoO0wxEvauQdI4KMw6TpoTyrfgKGgvBaGjt
	 Qf2Sdoeywzmk/rW7W2Rym5MMTuLE0cCucvxcTl6TH0ha6BgbjCbIL54MianYuXT/Nr
	 VMUNaPFRkuykA==
Date: Wed, 21 Jun 2023 10:46:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615094903.1341683-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_094621_151785_FC490A47 
X-CRM114-Status: GOOD (  13.23  )
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

On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
>  	if (effects & NVME_CMD_EFFECTS_CCC) {
> -		dev_info(ctrl->device,
> +		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
> +				      &ctrl->flags)) {
> +			dev_info(ctrl->device,
>  "controller capabilities changed, reset may be required to take effect.\n");
> +		}
>  	}

Thanks, patch applied to nvme-6.5.

A question for Christoph and future consideration: I *think* the
complications that had the driver stop refreshing the controller
attributes are largely mitigated by the fact we now handle effects
after the request is freed. Perhaps I'm missing something. Is there
a risk in just bringing that feature back into the driver?

