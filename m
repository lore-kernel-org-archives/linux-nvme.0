Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D719DC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kM1BUwXXEiGl6OeCEpEfJfC1rd0xrarcVh2otN5ZVcU=; b=yhm6uEBOjKGEO3Y/dA8UEF2+3U
	Qu6lCrsd2hRIBzde+QcgrNpjq+et/H4fVjSBtX7Vc4yYaTwrWi0dFMRL205O5GdNjldjH5lODKEJB
	f+zxbnD/PT8t6bPVl6QmYJSkWDHzd4eds7J1B1sv489JGP0sQJik7onfkrrJ5zGXY+F+vXihzXdL/
	i1sRbPJtd7gmBK5by3O2T2T4lqAKKVDCFMSkTti/tGeMfcwXMUkEjUxRF08ke6nNHsOP3KG/ILawD
	TPs/cb3uhh63/WqaDgPXMfPxvqji72S8nmfOrFeZk2n0zhJCu+bzhx8p6q6jvYENjEplunSf0vFCK
	UZeGzg3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC0J-00000002IUL-0ewc;
	Tue, 09 Apr 2024 13:59:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC0C-00000002ISN-2lgb
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 13:59:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6AEA68B05; Tue,  9 Apr 2024 15:59:04 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:59:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Message-ID: <20240409135904.GA20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_065908_866222_4C457874 
X-CRM114-Status: GOOD (  12.58  )
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

On Tue, Apr 09, 2024 at 11:35:05AM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Any authentication errors which are generated internally are always
> non-retryable, so use negative error codes to ensure they are not
> retried.

Thanks, this looks much better now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

