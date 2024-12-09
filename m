Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE9BE7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aj4YArb85oWxT6/cQslSDh3s4mn66AgnVQ9Qn+8+c0M=; b=SMUsKUWdan9jiCC4cBf3UpubI7
	y7oynFOGjGa4Ku6lhG598+/C1dLsNOhgWQV32LtF+/1EP0dmvW03C8sHzrS4NMChq1bQyiJtC1d4s
	hF7ynBiyl8pVASNjvPKzHaFw5K4lSB0ldFQxmlDnKuAiQAj4xVOerXMkiiQ3M5lycfVlz1chPlFEW
	8JHuigL9zmXU7lVTiZV+tDzsOKjdXf8jKXaWqqMuagB0Y1zMdG03NTZWrV3jIl7q8MRebjRktgV5z
	kENlWYW+FFfEWSACgYHbdmFMj9CJcVEtOFbTWpQCQt9rUt/W8GEUoOGU00vcNt+WJX0jgmcr3n5/N
	NxDA0AAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdXM-00000007tQH-3EbR;
	Mon, 09 Dec 2024 13:10:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdEf-00000007nOO-3pBu
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 12:51:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB78D68D09; Mon,  9 Dec 2024 13:51:33 +0100 (CET)
Date: Mon, 9 Dec 2024 13:51:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 00/10] block write streams with nvme fdp
Message-ID: <20241209125132.GA14316@lst.de>
References: <20241206015308.3342386-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_045138_092735_C075896C 
X-CRM114-Status: GOOD (  14.62  )
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

Note: I skipped back to this because v12 only had the log vs v11.

On Thu, Dec 05, 2024 at 05:52:58PM -0800, Keith Busch wrote:
> 
>  Not mixing write hints usage with write streams. This effectively
>  abandons any attempts to use the existing fcntl API for use with
>  filesystems in this series.

That's not true as far as I can tell given that this is basically the
architecture from my previous posting.  The block code still maps the
rw hints into write streams, and file systems can do exactly the same.
You just need to talk to the fs maintainers and convince them it's a
good thing for their particular file system.  Especially for simple
file systems that task should not be too hard, even if they might want
to set a stream or two aside for fs usage.  Similarly a file system
can implement the stream based API.


