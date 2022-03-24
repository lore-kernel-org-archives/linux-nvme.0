Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CC1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnV+bbe8nKm5kw2RaNFok2C3mDpDUiwXqu9kxL8n8KY=; b=08a4WvrFtfzP0nAYSAyd76DGxj
	LMynOaxkZiEeilJpEIKeIqIP4Opwa7lZY9u2rvUwNIbtBcupx93aoX9EoLseEFy8CaSqTkW5lJ6Ad
	7vQpk814icRAOZh72T/Ij8GTmPCR8u2ILOpH1dpJmH2r5W8my4HaXSo+ZX5VrHZ0gWc6KUzU2jrB/
	lepp3T0lytbdUdJNUoeBInxWWT1ITcoDn/am+i8fmdHKpdgxdrh6iNObQKDx8JtCHfn8XQ0x5k1oZ
	1Lu9sKFXTzYcpuqhYybQtHG1oBw3UNrTsF0JRHoaJ5y0MUdS1WrXAcMZrdz2xe6BpYKIh7oZZp46+
	O4ntkphg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXFxh-00Fcyk-IQ; Thu, 24 Mar 2022 05:24:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXFxd-00Fcxw-KL
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 05:24:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 278D568B05; Thu, 24 Mar 2022 06:24:31 +0100 (CET)
Date: Thu, 24 Mar 2022 06:24:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live
 over reconnect"
Message-ID: <20220324052430.GA11718@lst.de>
References: <20220324000620.4127-1-kch@nvidia.com>
 <a2e49e16-6e4e-9a70-b7b2-82bebfc2bc08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e49e16-6e4e-9a70-b7b2-82bebfc2bc08@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_222437_840851_82449CED 
X-CRM114-Status: UNSURE (   7.86  )
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

No need for a revert, I'll just drop it from the tree.

