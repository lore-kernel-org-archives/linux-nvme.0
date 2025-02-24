Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE72C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7dbZc3Eb9seSjio9bwyiCsOBqGXmsfU+ChFw5HFpag=; b=EWT2VSM6d1OiR6KD/Bm6pnTRIE
	DKlC889I2rEbmcE3RZL7Cj9cTkuWmfALGG0v3hIRj0PYnfsCW0GDEFeBJpLrUtH2xCdMnzgS0v0S2
	d1mv4OU6XdQktfaGr2oKCd//xM/iKomRC/EJGrY+LTtnN8HHa4ZT+/KFLVgw/PCkHtVLGUwm1c1r0
	aIy6nvHgodL7vkkLKUgtGu+rRt+FHXu+QrtWyP73qGvUVq72/AeUb26ymd6sH27+JGvB8bPH8saRt
	99CBpYNkvsj0pW1vGICGzz8YxCIgzu5DtsUL1vbFsAmlurpiRq4jrSOV8ICp50tOqU3NsIG8MDq8D
	akZZuQLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tma0I-0000000EDBG-0nQr;
	Mon, 24 Feb 2025 15:04:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZWt-0000000E6vf-3qAE
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:33:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91FF868BFE; Mon, 24 Feb 2025 15:33:51 +0100 (CET)
Date: Mon, 24 Feb 2025 15:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Xinyu Zhang <xizhang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <20250224143350.GB1406@lst.de>
References: <20250220235101.119852-1-xizhang@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_063356_092059_BBDB4A95 
X-CRM114-Status: GOOD (  11.54  )
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

On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.

How is that actually going to work?  Who is interpreting that address?


