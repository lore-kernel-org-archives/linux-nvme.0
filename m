Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D248C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=67RduiWIwQ7nznTBnhBoa7LsmNzt7Kv8cJwgEIe4fRU=; b=JetEwFdoVHcYSu0jJqfft6axnH
	xJ1R9d8Y8KGbdWVfzheFp0XPrVNBb4Tm4yukN2RxQ4StQhHYUI6OtXKF8ub2uVraQ1kmx4yLJ7ods
	zmw1n5Llz6Y8wFqW2L4zLx2t76LIkfkmjsjBPb4nHRdKQf3LW6s34lkiFI5YDxh3CrmVvShCUNLkM
	O1WwKjm6WBBXubjeALh8kvVKd2W7fsc+L+3MqKPdG8xA+wWjhPbjnhmkBge15IN0a6cTChjSBulcD
	ihVhku82Q38zpeRm+la/n5qsVbZMwUM1ew4Wy6bp0plc0GXRaa9mLFFTWHhiEYUPAIoyDCrh7h5E4
	JHGSJKzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGIVf-00FN7f-KC; Tue, 26 Jul 2022 11:13:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGIVa-00FMLl-Nx
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 11:13:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09B1368AA6; Tue, 26 Jul 2022 13:13:39 +0200 (CEST)
Date: Tue, 26 Jul 2022 13:13:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Message-ID: <20220726111338.GA32638@lst.de>
References: <20220721003358.543509-1-ming.lei@redhat.com> <Yt6DJBRXyGXbShIF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt6DJBRXyGXbShIF@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_041350_948039_9C6D7BE4 
X-CRM114-Status: GOOD (  12.30  )
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

On Mon, Jul 25, 2022 at 07:48:52PM +0800, Ming Lei wrote:
> Hello Guys,
> 
> Ping...

I'm waiting for a review from James, who apparently just got back from
his vacation.

