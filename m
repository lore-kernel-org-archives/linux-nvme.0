Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F4C38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1kBHLQIbqcERE+0Hifvmf1keuKKCTeeDFTH8tT6YIM=; b=Y8j+alEk8HclFiwpfur6FfoWBJ
	UDtuVEQNGwZrAdo0DaJiVyTrrBIjmqxdqF4pLbD9sfGD6ozfRr5Lxj5LrCkQP/jsGKaxjuxSVgOYs
	V91/dpGfYmj4I1z34905y788+pkRbwNoLeimR5lcWSAQ+in6dvPQ3qop5Lh3KrSJ3MGPQ/fOwhJhL
	SeZbjQwHxVNMiDVdYytlYuv2+jVa6ITgfeJsSrSIK8Gerz9q7pj6f1X9hfHwqnAhc35TlW6oxRnnM
	Nj/vy/oB3S0/5Lgg4EFrbuTzrUcfCvtd5y4W6r+YAXtg73c6h2l/5z8H3jHRMl7+y8bqpBcC+YWjH
	OgI7V0Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoyW-003PYR-V5; Wed, 07 Sep 2022 06:55:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVopR-003L4e-1X
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:46:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A52368BFE; Wed,  7 Sep 2022 08:46:24 +0200 (CEST)
Date: Wed, 7 Sep 2022 08:46:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-auth: set the DNR bit if authentication failed
Message-ID: <20220907064623.GB21620@lst.de>
References: <20220830124925.40711-1-hare@suse.de> <20220830124925.40711-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830124925.40711-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_234629_296635_604D503C 
X-CRM114-Status: GOOD (  13.03  )
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

On Tue, Aug 30, 2022 at 02:49:25PM +0200, Hannes Reinecke wrote:
> If authentication failed we should be setting the 'DNR' bit, as
> each retry will yield exactly the same result; we rather should
> change the parameters to 'nvme connect' to fixup the situation.

Why is this code using nvme status codes in host codes?  These
codes only apply to on the wire communication and should never
be used for local error reporting.

