Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DC2C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkYOV2N+ye3AtTyhlMzZdDY3MG/RoGZzI6V5GzXN5tA=; b=vVvHSItp1lzFbqon3E5zaizJpg
	m6RGNgtePjmr06F2aLFNVFrrDaMfwpxA7WAd8FrdcTvHBJChV2KXI7T7Jdks3m+CgzD0hr0H2MkiH
	aKybdVDiKqHUVjlpXvc6lhXN4wdjBq7+qODViAGXaLbaDLPX++X0ia1mN40XTU4wfOp0rI8pf+MeI
	qsKFLKFIAGwI4EKtiBNS+vPZoh+29En5Yv2vqf2IUcPoAoJRvxveTD/DSAOMjSolWUyvvLVVgYJBp
	AilTNOXDXcKAkLWEU3gKan0tPs+Ss/USzxFcyhrEAoPxVdKJUzG7TNFqIKsxzbDeDJLYfVw8i24Ma
	fN88UdwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBRH-0000000EcrW-3bx2;
	Mon, 29 Jun 2026 12:50:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBRF-0000000EcqV-3C3g
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:50:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 170EE68CFE; Mon, 29 Jun 2026 14:50:11 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:50:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, elver@google.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 12/17] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
Message-ID: <20260629125010.GB23695@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-13-nilay@linux.ibm.com> <20260626064816.GB11106@lst.de> <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_055013_952815_CFC0DD6E 
X-CRM114-Status: GOOD (  10.39  )
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

On Fri, Jun 26, 2026 at 08:52:36PM +0530, Nilay Shroff wrote:
>
> That's because nvme_poll() and nvme_irq() both reuse nvme_poll_cq() to
> process completions, but they rely on different synchronization mechanisms.

Well, we could split the function easily, but it still uses the same
data structure and thus annotations.


