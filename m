Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D45EE7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5w+/O3HjzzsxJsPly6kvqYp/dkWSaoDv8uwoLFudjo=; b=G5CzxLPhUpVZesLRXSuqmxmbUN
	LAVkGoWK6bu6jsi3X+QvyEVXt4F0Z9UdKHZRiVc4dyrlva8e8/aSvmoSJno5t7+dlX+cxMKsWXU4/
	rgShFShzDIqTmVIToDNYSCKleQK/5umiC6FzyLVC1NnDSxxlc0s0YSxdcLK8HIx6aXK62ZHdl1cAm
	ZSzMtu1BwmXOeZ4ofzn5QysIni02Mk6W5Vk5lF5hASYqaZfopxiYU6aTxhe+J/bz1tDFQ86NSPNKx
	YqJO2aJY2NYKv3sjkrB3gv08RH2H6ePV+64nDhjd3wTriaaJL9cViFrKCZASSH3zrkU+PfCDnYedz
	RWLufDTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNOho-0000000C5h4-03Zc;
	Tue, 17 Dec 2024 03:57:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNOhk-0000000C5fe-2kN5
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 03:57:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F5C468BEB; Tue, 17 Dec 2024 04:56:58 +0100 (CET)
Date: Tue, 17 Dec 2024 04:56:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Simon Horman <horms@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, netdev@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
Message-ID: <20241217035657.GA14719@lst.de>
References: <20241217012618.work.323-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217012618.work.323-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_195704_839558_4EC9DDD5 
X-CRM114-Status: GOOD (  10.66  )
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

On Mon, Dec 16, 2024 at 05:26:19PM -0800, Kees Cook wrote:
> -extern bool inet_addr_is_any(struct sockaddr *addr);
> +extern bool inet_addr_is_any(struct sockaddr_storage *addr);

You might want to drop the pointless extern here.

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>


