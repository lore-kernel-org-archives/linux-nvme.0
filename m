Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EB3C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=; b=ORFW7S3fkhJcpEXIZLEGR2pwV3
	Kni939/m72unLzxZzrte30ICXf77xGWcbW6wacmXD6r3Eu2AoEeJj0oR4dSM6SahOnyCYaSvvNQnf
	cQ7y6QbF1dcA3m54oYNpN1rNwpdQQBoc7A3Dlm/8TL5fXOa2wYQSAgeD78hsHnHbA3W0q5H5ECXb2
	0v2l5jcF9YGzkfSpPc4QcgAE/4nScpPSVGKV9zBwK9VjVqSqsBpkiraCwo3jAtloFmHAZTp74iZvc
	v5aEjlYQU3a5Zng9qkKGZtGLqkyBZFYayDXN+VlvT2ULlue8S8LcGQDsInLGmsyuw1P9Loz+Xl9DR
	BFSZuy+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5Bg-00GID2-BR; Mon, 07 Nov 2022 16:41:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os51S-00GCKA-Gh
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 16:30:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2608A611BC;
	Mon,  7 Nov 2022 16:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044DDC433C1;
	Mon,  7 Nov 2022 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667838652;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRCfJoBpaNAj+NFYNkAJXp+xETmr5ljKBq06gsFRsF6tiRRbz7E9UAKDLv4moonL5
	 EQXTZnXVm9kFNx0N2jOVwqXhseVTdoYQdtTQ9PcxPcwtzi3KLv8LIl3WxAqp/4FBXn
	 7YVdNszOIjYNXa6uPPjt+UpHIDgm1lKfHmAIcGk0JzjdqV4ZCTeEUKcyBzdvTgIEov
	 CTvt6fC0eFtJL/tbjSquTQP8bg2cZeuXxoHeQPldqv5hJwSoqTQkXbYaXyChPuGa9g
	 +nVcnJL4DL7MbSPNDfIGI7UI74zDV9jRYHQrIY99s2TiDW5TlLjD8fvfFOhfgHbkUZ
	 BjBq0fhxqdY/A==
Date: Mon, 7 Nov 2022 09:30:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: implement the DEAC bit for the Write Zeroes
 command
Message-ID: <Y2kyuRlK1eK33PxH@kbusch-mbp>
References: <20221107162108.1777681-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107162108.1777681-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_083054_636159_368AB8CA 
X-CRM114-Status: UNSURE (   7.75  )
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

