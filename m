Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39CEC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6SJicJ9BucqOu96ENJp75afWx02l2PtqBTutuq4cKg=; b=iSKOT6lQ69uAfMOBiI5+1zkWRX
	zYqbHIsgxzYHdSMfzRBjm1KCjunzAmqRQnlLafImMh2x7+PHyuW3Vcn/SmSTmQ84CRCYhmczyWXcO
	AtFapPHTvi+mfMUw09X2gIuS2UFRm7PSgHkqgEMsOD3qprntKU2yR9JcT65svUyOWzTAlaqqOERJI
	YQ62tBdqzkslVfllDhPX3fNw4xioNrEmWEbaGZLLWfqU2ugC66B+/F/+uXicsud5ijNc42uwhVQqh
	qoJa6kt2RLn+dRyJcskhpM625/WymBRQZdJuJVGW/lDooy7qrtImNsgoYgDjLvwyiDAPWhlTBsTH4
	MbI7+IEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMNR-006DFL-Sg; Tue, 25 Oct 2022 16:02:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMNP-006DEA-41
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:02:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46BD368C4E; Tue, 25 Oct 2022 18:02:00 +0200 (CEST)
Date: Tue, 25 Oct 2022 18:01:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, smalin@nvidia.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, borisp@nvidia.com, aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: Re: [PATCH v7 02/23] iov_iter: DDP copy to iter/pages
Message-ID: <20221025160159.GB26372@lst.de>
References: <20221025135958.6242-1-aaptel@nvidia.com> <20221025135958.6242-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135958.6242-3-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_090203_329269_5E8A8342 
X-CRM114-Status: GOOD (  11.05  )
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

I don't think this is a good subject line.  What the patch does is
to skip the memcpy, so something about that in the subject.  You
can then explain the commit log why that is done.  And given that
the behavior isn't all that obvious I think a big fat comment in the
code would be very helpful in this case as well.

