Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEABCD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JcO01MWc7yXQx9WkQDKIRs6pMZ
	OVqhXHYo5/owRmzs/vlEvBjjBb96CqLcxHSdXyv6hqu8k4jDsqoq+4EenJ9weRzXsv+RbcG81YX0k
	qCtcHF2pgkWu9bo8c/VP43WLcVYmvUaqotXRcMmPANQLP8LuUuWtG2p21voi0NGS6vuhLp7mLBeld
	mk1GEVh35+mWYSQsQBsHhSphZGOIo2VdB4fxTeBV4HGzbAiSd9nViyd0y0eiPd5cUk9BIq0wvT2fn
	GA0wHn0tWWMgRnth+WUVoftTCjDU0dDUZpR+KoyCMQlDKGgljeNaJb9t4DPPXrdFr3EZJE0lY/qy5
	D3zm8sEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwp0-0000000AHc5-3NAp;
	Mon, 01 Jun 2026 07:12:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwoy-0000000AHbU-1ySL
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:12:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4F8368B05; Mon,  1 Jun 2026 09:12:21 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:12:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	randyj@purestorage.com, hch@lst.de, linux-nvme@lists.infradead.org,
	dwagner@suse.de, emilne@redhat.com
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target
 before it is initialized
Message-ID: <20260601071221.GA7533@lst.de>
References: <20260528092734.258899-1-mlombard@redhat.com> <20260528092734.258899-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528092734.258899-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001224_649768_AAB39F05 
X-CRM114-Status: UNSURE (   8.75  )
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


