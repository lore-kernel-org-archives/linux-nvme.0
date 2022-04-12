Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824F0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJd+rSSt9baxFi09j62hStB7LcucNkK02j2k4LpCu5E=; b=rPq3ecKZOkokBWLPGOYUJfTxON
	pzbP7n1ItuZLa6M+yOEeFzyH41VjFYiuBQYxgzsuzfRE1odGzMM1FlzU7r6fZOrUidS5AjEZUQn5k
	j8nqRBvQDoP6OgtWHJIDRp8/7UjUAhJOhxdKeRDptib6Hzv/acgp9eJfXowJPHkXeBJAYoA6FWL0+
	FZFlfRbk3+cybvaI+T84vU5ib6jeGkQrYfPKPCFTlhZ9SWjIcLxrMyFbihujY1fdg8k2MVjtMIDtZ
	dlqnXnKrOMy8okrDU+2pCXjwCZoNo+ct1jSLgVnWftxqWyc85egWbcmvvASnaOJ4F6bMMNqPvfDFO
	V/NfTJFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neAX6-00C2iE-ER; Tue, 12 Apr 2022 07:01:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neAX3-00C2hB-Ui
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 07:01:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC85168AFE; Tue, 12 Apr 2022 09:01:41 +0200 (CEST)
Date: Tue, 12 Apr 2022 09:01:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Message-ID: <20220412070141.GA11394@lst.de>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-2-hch@lst.de>
 <44f60505-724d-0a5a-1f0e-488c323acdce@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f60505-724d-0a5a-1f0e-488c323acdce@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_000146_166739_C0ECBF66 
X-CRM114-Status: GOOD (  11.98  )
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

On Tue, Apr 12, 2022 at 06:56:07AM +0000, Chaitanya Kulkarni wrote:
> +       ret = nvme_id_check_quirk(cur->nidt);
> +       if (ret)
> +               return ret;

We still need to process the list to find the CSI.  This is actually
relevant for modern qemu, which supports multiple command sets.

