Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF922C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 05:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrS6U7zEUOj13SGeFTsTsSudwKE0T9NiFh1VqmOoaqM=; b=1YNQeBXzzIHj0WvbNsnT7Ze3bk
	PZHsViESzF5t0MRH5jDz5gZtV76EvkTUiHl7yMGktgG0+2QtzEluRLXvQg564MGkla91UjOWnZF95
	d5NhNcZc5l767GUkKGwmvxMB0oQtDFdRdexIsp7hWtgKSgDzAv3GOsYgA8AG6UYqKXTbTReCnm7c1
	66g9xQZ0s2bfpjI+PHcAHzza7IbFqNH5viN/zm5vwqIH6ILI7IOyZfXZ/4Mv8oFK8b+/Tc//qqv01
	6WBNQuE+zXR5IdB5Z7ODNRh2yNHGUjhPUqZ0KCFjuwqEBlnXH+KzsWiEIaW5rXaO0N+H7cspQghGO
	262mpODA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxQp-00000006jc6-0d5X;
	Mon, 02 Jun 2025 05:09:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxQm-00000006jbO-3cxl
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 05:09:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8509768D0D; Mon,  2 Jun 2025 07:09:49 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:09:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jaka@linux.ibm.com, jlayton@kernel.org, kbusch@kernel.org,
	kuba@kernel.org, kuniyu@amazon.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sfrench@samba.org, wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250602050949.GA21943@lst.de>
References: <20250526053555.GG11639@lst.de> <20250530030308.3216933-1-kuni1840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530030308.3216933-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_220953_040381_54A5E739 
X-CRM114-Status: GOOD (  10.89  )
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

On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> I actually tried to to do so as sock_create_user() in the
> previous series but was advised to avoid rename as the benefit
> against LoC was low.

I can't really parse this.  What is the 'benefit against LoC'?

