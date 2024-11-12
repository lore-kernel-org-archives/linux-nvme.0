Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E94BD42B80
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBU5Av/u7xXmUJfN0sedhN2rMoTXwD8oxtmBTUTHFfA=; b=QKbEeiibWjLZPDwdQFtKiPGFTX
	bRHrJ4KJRJxO3dfRB5fPsQvB4kXpCD212SZ6Htj+kxpqM+GsuueV6FpqVhpKqteMtCramxQIsN1s0
	ipH5ZJCTcs13XotwUetqlxGOEFdgjsKyaNmZ85/FgxDx0/SUAiw172cI9FzjAszilCUiRasxo424l
	ziUzH/tVp+9xt9IUwiwd4PQEHcSzHxBWcTZjChNfzt1EqcLYknDm+fqfjwOkY7l/4h/pKFBqe7+7s
	yY6AvrbgcnrhYBIfpHEIP42Ta02oe6X10b+GSNM7ZaO1o7OVOLlmZuomQPBJE1TSQZ0F8039qF8Gi
	NVVlpF9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tArCP-00000003dCA-0Fb9;
	Tue, 12 Nov 2024 13:44:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAr2c-00000003bEc-1ptg
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 13:34:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CDC268D0A; Tue, 12 Nov 2024 14:34:39 +0100 (CET)
Date: Tue, 12 Nov 2024 14:34:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <20241112133439.GA4164@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_053446_672060_C92AF51D 
X-CRM114-Status: GOOD (  13.52  )
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

On Tue, Nov 12, 2024 at 06:56:25PM +0530, Kanchan Joshi wrote:
> IMO, passthrough propagation of hints/streams should continue to remain 
> the default behavior as it applies on multiple filesystems. And more 
> active placement by FS should rather be enabled by some opt in (e.g., 
> mount option). Such opt in will anyway be needed for other reasons (like 
> regression avoidance on a broken device).

I feel like banging my head against the wall.  No, passing through write
streams is simply not acceptable without the file system being in
control.  I've said and explained this in detail about a dozend times
and the file system actually needing to do data separation for it's own
purpose doesn't go away by ignoring it.


