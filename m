Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BCEFA3743
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=nfFVWOVv2uNsI+A+DVp0Xku1Cd
	UV4fJfVqeZw/s+vRUK+Gg2R8Pe9whmhtll++gL5prCg0kQyDKEA9r82sGMS8+IR9s+ElEoKCvjtY6
	pBiHU7Htus+mWQh/+MsBSo1vGrz0nqaTvLBV9B8RQpoVA3gtV7ii9Wqe7VD8toPzlGteXTSrLLCzH
	99rc1F6BwJhEKSN8h9HmRDf66eNPpHKtMqJDFvLT3RY7usqmT/zW2ZyqrsXrnnLbU01dlZfCmalAt
	lFjj3LVGmgdHxr/m87+V2sRIY5rBotZG114ttKYtyAiXcCsBuHRgcnX0lyu4cqIz6eldGiiNhWNE+
	CD5iFXGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnqM-003kBH-O9; Tue, 01 Nov 2022 09:46:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnqJ-003k9I-5m
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 09:46:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D63468AA6; Tue,  1 Nov 2022 10:45:56 +0100 (CET)
Date: Tue, 1 Nov 2022 10:45:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: Improve memory usage in nvme_fc_rcv_ls_req()
Message-ID: <20221101094556.GA12904@lst.de>
References: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_024559_376505_A30CF429 
X-CRM114-Status: UNSURE (   9.96  )
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

Thanks,

applied to nvme-6.2.

