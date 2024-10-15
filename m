Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34167CFC268
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 04:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vn1FRhgIokVecwrNrRDhnNrzlXpJr1LwwlQDDxoC1HE=; b=GOR1XA2bbFxvQyfd2AfI6cxKnn
	Lg6bqPcrYEmIA5RLI3qRRCg0I88zU4GObYvpNjXel/TnsejhEP4ufiRloaZlXvIgCXc4Y5ntK9aIk
	IaczA/iulYs+fNbAWpXcuoo3IbI55L2uq3at7jzwJPS43f71mS6EVLyC+4zWL27rGhM9T/Fm0zMJi
	PAcHV9S41d6Wkyb3vZV/yjt6WsMj210+WoT0mI1mq0mAsQmg1yuDRdjV/ESD3pZgS6t07NfyLB+2m
	Zw+T90uEFSY0JpQV/3LovZlvgj3eh52UeYiB7uUSkK7Q2//pxD7nfn7EAl9+TyYhnn5If+i4GUqzm
	skJ5293Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZbN-0000000749T-2B3K;
	Tue, 15 Oct 2024 04:56:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZaV-00000007463-2SDb
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 04:55:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08A20227AA8; Tue, 15 Oct 2024 06:55:13 +0200 (CEST)
Date: Tue, 15 Oct 2024 06:55:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1] nvme-tcp: forward context to teardown admin queue
 function
Message-ID: <20241015045512.GA18157@lst.de>
References: <20241014165329.639998-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014165329.639998-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_215515_794623_A4C47026 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, Oct 14, 2024 at 06:53:29PM +0200, Daniel Wagner wrote:
> nvme_tcp_setup_ctrl is called from different contexts. If the function
> is called as part of the initial controller creation, the argument 'new'
> is set to true. This tells the function to free all resources when an
> error occurs.
> 
> Thus nvme_tcp_teardown_admin_queue should also be called with 'new' and
> not always with 'false'.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


