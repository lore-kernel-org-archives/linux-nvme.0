Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D684C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hhOmyJoqhlpndmpP3GwUuCxO8G
	hvjrnsHhvgrcgKGlHj9oMupyV7h8v331P0Su6NjshvktD/yJ/pal7pqe56hHivmz2UPQFspFu7IVS
	2+JkQQKnGumpMA9edlrKLnJi4oG7bzJMPtccDq2D+skNbtTUcdDNjN+GslOxvSmarRijlp5Ftyscz
	USe5Co6UZXJc7nTB+zG5Zu/oIPVaVFa+TLhzLz1bqMLX3qNSST0+CBUYk2M2Oc0QV0flVpWnFsBfr
	TXj890bAtjBI7sU6LtAkV0q0O1T8dAPYZl4i8MIiohTcN4VQYwXxa6rnOH+bihCv7KCCrNcuvXhcs
	ZEFdKh1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppqv-00000008ND3-1pdQ;
	Wed, 05 Mar 2025 14:36:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppoc-00000008MYi-1hw9
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:33:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CA3D68AFE; Wed,  5 Mar 2025 15:33:37 +0100 (CET)
Date: Wed, 5 Mar 2025 15:33:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 1/4] nvme-multipath: change the NVME_MULTIPATH config
 option
Message-ID: <20250305143336.GA18526@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_063342_580952_B5FDBCDC 
X-CRM114-Status: UNSURE (   9.14  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


