Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F6C02192
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 06:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4AkyGCWpfB4HO6/Dygc4KvngmgYW7kw4uDWB8B4bUc=; b=fuKQl0IxUqdqPFz/BDUIV+lMVR
	1rCI7Tw+nXuG0qadjrFWG/N8VF3qh0e2L2FR3H1tIY7Jra/h+Mj+NkW0tgVNe8Slyoj/GHNaSDOGW
	TZIN/E5xReb+/5JiPMQM06s6URsvbl4lUFNnDo6/+q66ecmJ9kBW+e9XbqAy7LAvv1BW5tN08ojpD
	eS3UMrdn2I1lYp7V8zxxibbUELtLWrU8egGFohARwoBIslXAkEb/ZBKnOSwk8H86XvzdGWVFIaAWq
	A3OKdLSg4h9TM+2nH5ugFLFIy1d+QptA2QO2Im8NaEBr56w4I1oQJ9Ut2pFH1DUrBASjal2/Eva5R
	XbufbTMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td1Cn-00000006Nss-2APR;
	Wed, 29 Jan 2025 06:05:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td1Ck-00000006NsX-3skq
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 06:05:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 544CB68D13; Wed, 29 Jan 2025 07:05:34 +0100 (CET)
Date: Wed, 29 Jan 2025 07:05:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <20250129060534.GA29266@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_220539_104874_A1E9B436 
X-CRM114-Status: GOOD (  14.51  )
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

On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> If a lot of request are in the queue, this message is spamming the logs,
> thus rate limit it.

Are in the queue when what happens?  Not that I'm against this,
but if we have a known condition where this error is printed a lot
we should probably skip it entirely for that?


