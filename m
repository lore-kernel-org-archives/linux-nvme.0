Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761DDCFD63E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bCjh+HsugEPYGnwtLmsQ7GPkRsfYdenz+yJhTVwHn8=; b=PuCWetWEG2Lyq2Umm6H5Fd5nZz
	JBfU6UrKHORm6NESSUf8WUZngh7YgTpD8RjmdFBN8v+DnTSvtBE1h2z0zF6ZdKWIbckNZLNhrQCpF
	lq5LDm3uS6o4rGNCO4ev9uNXJs5n8SheV0PUBrVh6aYdzQedeaq8QBehtSt4Lx7fto3cI/9rDwKid
	HX6h+UoD1h7lfWrlJXqIk8f7eeZeUQ0L9i+RTJj/3Z0uD8voSHPTgKxZ7X5nVyhzZtXENaKGLijMp
	/YhB9q5vvWUhX1TFDHn7Gq829MZiuf9jxzaSm0M8f/kFMDtJz7v/NlCW/L9jLqMEZDSwKhBjNiZ3O
	munwODzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUbo-0000000F69U-0uwW;
	Wed, 07 Jan 2026 14:34:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUbl-0000000F68w-0zO2
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 14:33:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5359F227A87; Wed,  7 Jan 2026 15:33:51 +0100 (CET)
Date: Wed, 7 Jan 2026 15:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme/host: add delayed retries upon non-fatal error
 during ns validation
Message-ID: <20260107143351.GA14506@lst.de>
References: <20260103-nvme_ns_validation-v3-1-c9ce67393261@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103-nvme_ns_validation-v3-1-c9ce67393261@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_063357_416600_8F4DCAE4 
X-CRM114-Status: GOOD (  15.64  )
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

On Sat, Jan 03, 2026 at 04:52:00PM -0800, Alex Tran wrote:
> If a non-fatal error is received during nvme namespace validation, it
> should not be ignored and the namespace should not be removed immediately.
> Rather, delayed retries should be performed on the namespace validation
> process.
> 
> This handles non-fatal issues more robustly, by retrying a few times before
> giving up and removing the namespace. The number of retries is set
> to 3 and the interval between retries is set to 3 seconds.
> 
> The retries are handled locally. Upon success then end. Upon fatal error
> then remove the namespace before ending. Upon non-fatal error, retry
> until the max retry amount is hit before ending and removing the ns.

What non-fatal errors do you see?


