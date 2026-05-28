Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D182ACD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIgos72Cm3IfTWMmCN5oml+JjbfxfQGDyXLbhC97Awo=; b=LDtgXmZB4o5+A5CqwKhSBgKvF2
	5yl3zFzUV5c4FQaMt0sgR9TCkDc0ZUitWeSAoCEOPCifvCNYB+LsZPJBZk5a4fZrxlQ+pVXdlz3Sq
	NVgvcfbATu4+Ibd9nrQlh9s//rLm8sq/3HMiyhZ8gw+83+htwtqpON6ht3Y3HgGQORbAATX3IQjIQ
	l3ElRgsUmDpOFDVERW5Lyneh4RuJR7PUsJxnAjsLG3lCOT1H6kBkjQy3dwIHrHAbo1atARAv+kxIP
	30dXyIi323zcUFUiHI2ZeBS66ggRIVpbQqUHTCXi3cCVqwTdTFagAqKiBzvKDAGzpU9/G6Q2g4hrd
	+u4w9NHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWJq-00000005PyR-3zRE;
	Thu, 28 May 2026 08:42:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWJp-00000005Py9-37DY
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 May 2026 08:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xIgos72Cm3IfTWMmCN5oml+JjbfxfQGDyXLbhC97Awo=; b=AsoUGZbaUsw3JxPr8BfR02KDHR
	08pBf0lAJxoNTZXUbfrKelGkqyFvPozL33rI6fcLFRA5HcNyDwVHAjuFiALL8Cq4q8EqjKH11KbFr
	4oIhTO0wOEqmt4McfJH2dQMKHaoV2u9KIx6TjX6f8lEHw2Qg6TuEqFmebTK/VjJqGm/+fanVMjErx
	oRRP9t0H/0FN3JtWX8f+8PlLRz6d7SwwDkK3pioeXLVtsgjoagvycTR3xGrLYETX0HeY1WglBWUty
	/tzIDH4O/29LtaIRxCaPRU2YA5lOi3adW6GlM8eqYs3O3zCIT974zQCfngmJHLg107tv/qtGNwnR/
	Cj0WaSLw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWJj-0000000Fs4i-2Ex2
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:42:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FAB968BEB; Thu, 28 May 2026 10:42:11 +0200 (CEST)
Date: Thu, 28 May 2026 10:42:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH 00/11] NVMe over MPTCP
Message-ID: <20260528084210.GA8141@lst.de>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_094216_236776_76BD12AA 
X-CRM114-Status: UNSURE (   8.80  )
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

You need to talk to the NVMe technical working group, not us.


