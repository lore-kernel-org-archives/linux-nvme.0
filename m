Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45899C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=DbCVvUn0ec1JyMvzm1XnokKWv0
	E2HKrVAJEetZG6x69wRcxFGybz6G0MW24pMYiKa/oWqZMSgvnujsrFn4SojgvAuYgzxHvCJe2HNOY
	eVK89BX9OnaRqYkyqfkBFErxr0Ci9/jaF1ClwZ64VjfiKE/sFPCrI2MjtLCanmNDX3E+MBWI+zWrp
	LcFZpsvmDmZD71KnLj3KJCHddKtT2NC6GHk9+P6aIoy2b9keHzlIm8I37TvpXkr3KdQ2BXsIR8ojc
	LdckFLTD2rw2eHZWHz4uxt0UcKiQXCVdRNAiGYr65isoJW8q2WM9BRoHhLzdltysEHPMpcpafjdBG
	T3AALQKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGb-0054dz-39;
	Wed, 03 May 2023 16:23:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGa-0054dO-0n
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:23:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DCE068B05; Wed,  3 May 2023 18:23:41 +0200 (CEST)
Date: Wed, 3 May 2023 18:23:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hristo Venev <hristo@venev.name>
Cc: Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: add quirk for missing secondary temperature
 thresholds
Message-ID: <20230503162341.GB2028@lst.de>
References: <20230425195853.322100-1-hristo@venev.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425195853.322100-1-hristo@venev.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_092344_430253_8A22FF5F 
X-CRM114-Status: UNSURE (   9.45  )
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

applied to nvme-6.4.

