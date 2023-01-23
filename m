Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C10C38142
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwrOWhLbAjnWARjbA1eRU4AgGo6Xz5vcaVOD2FNgZDI=; b=ZAuBsJoxj5qAXrenBVu5O4/gcW
	qWxVzWZ5Oum7k8vU/cFSsJgLh5dEu3jyPh3iEDJMSk8qusmhzZxtdL8vGJVuZZNs60ZGjl63LDn0M
	f2TkkNOIWfO+ymnFCxJvggXRXmJPfGSGdufTGNSn63YCwV8c2N67N36FbPxMp/5Je7vlj6CkWcg8R
	fOzKplzvramoMkp14ZqUB/SpgpVV+J+uGgv23X756wMaPbOAfDCy5fNjsz/aB8Spo25txx//rYrSy
	MGBjL4Uwl9LBsgMaORHYJLfXa5lXYiuTlxy7AMM1fH9xo483XE6qvW5XMHkaSBm29t0B+wSsB2IaC
	XWvBe0ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK022-000gzB-Bd; Mon, 23 Jan 2023 16:50:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzvB-000dz5-61
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:43:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4926068C7B; Mon, 23 Jan 2023 17:43:45 +0100 (CET)
Date: Mon, 23 Jan 2023 17:43:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: mask CSE effects for security receive
Message-ID: <20230123164345.GA8617@lst.de>
References: <20230120171731.652371-1-kbusch@meta.com> <20230123164118.GA8398@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164118.GA8398@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_084349_434122_8EE0A3D3 
X-CRM114-Status: GOOD (  10.44  )
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

On Mon, Jan 23, 2023 at 05:41:18PM +0100, Christoph Hellwig wrote:
> As-is this only applies to nvme-6.3, is that intended?

In fact it doesn't apply to nvme-6.3 either, I guess we need your
CSE initialization patch first.

