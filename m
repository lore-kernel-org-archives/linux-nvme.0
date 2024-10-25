Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA3AD0C608
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=+DUqoN8vOUbI7OOzjYrkuFWgqJLyKddpc0opWW34GKo=; b=yjF3HcAD9eoLBX
	LdDYvOSnwnXKUog5/QLr5dlb6DoTpNJ+6gM87tjhpIRi7IExl5/kqA8pfW7gqtj6LlOjwf3JRtDBl
	CuuUZLPyxizuEtlc8M4h1fv4v/j3BGPgZ530ILlixIt1O36bw0Ym1ffwAQODZ0IyHC1INciIBa4Za
	HIaZhXp6ryQuqNAxUBAslAcPkMy+f4nbrCCAgZ4XfHHuQlEoMdL52q7m81xZGBWvtBLkzflcXh98F
	mn46T+A7ZVeiLUvF9prDdp319McN3mG/4/HkfCrJGQIytmimSqp71I63oWzBZpDD5LAzmhG+mE+jf
	y4Kc7pKxEZUhL4FA3JUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4K5Z-00000003lvt-0iWF;
	Fri, 25 Oct 2024 13:10:49 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JwX-00000003kSo-4BOp
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 13:01:32 +0000
Received: from fpc (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2C75040B1E72;
	Fri, 25 Oct 2024 13:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2C75040B1E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1729861282;
	bh=+DUqoN8vOUbI7OOzjYrkuFWgqJLyKddpc0opWW34GKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=swDCX4J8y19ceNvifb0Fkwr7OjUSrrIRLUUV0ENKzBwS/Fzqw/obPFs+H/Vx5F/zB
	 gSywSQu6Syd3ufy4Rjik17Z7wMUgtZJIFyWuWVdyXvzuHQpqyu+A3p7gdwvikxQ0Q0
	 bElOuYpdkJ2RPuJ2CefDQPh6RuHcC0K3Gf3GKZqU=
Date: Fri, 25 Oct 2024 16:01:18 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917061226.GA3839@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_060130_588921_0A81C6C0 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

On 2024-09-17 Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I suspect the patch has been lost - it's still missing on nvme-6.12 or
nvme-6.13 at git.infradead.org/nvme.git.

--
Thanks,
Fedor

