Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B39DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HdLl7MajgTJvKqB3xN9BEd172XN5Nc8uUl/Aon1bjo=; b=GMATCbV407yk5mj+BEsN590Vw+
	jWNuQQ/ksGddDqcYR7/DwPEvCjvJeJ/cralFUJCtSNmfFYGL95fheeretkvtLSR2N3H431OQ/xfWR
	5h7wEnC7/cVVpAizR6l0+i36vb4sK5thhJE2ZuNORcDy7uCv4Z9/2uGckJsMQ3tFB2BYl1UGmzY9B
	kFuZzwqS6z5JG5v7VEAG5Pjyj1WumqOrpeupXAO9CYHvZP95wYbkMqmZecDHeoOxhsEdY2ie1STs6
	BrW1m9JWlqbzf8CVu9Wp4zFdsXIPAnNl3dnLv9WbP+sG9GQL1ses9XfvgIUR3ybSEE4WMB2+KucNd
	XKhQZmMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEo8s-00BRsZ-IA; Tue, 01 Feb 2022 08:03:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEo8p-00BRrr-8P
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:03:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 910C768B05; Tue,  1 Feb 2022 09:03:52 +0100 (CET)
Date: Tue, 1 Feb 2022 09:03:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/4] nvme-rdma: fix a possible use-after-free in
 controller reset during load
Message-ID: <20220201080352.GC29518@lst.de>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130092119.595854-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_000355_468281_DADBFFFC 
X-CRM114-Status: GOOD (  10.14  )
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

Same comment as for the TCP version here.

