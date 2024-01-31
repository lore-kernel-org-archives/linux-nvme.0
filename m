Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464D2C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HMoFs5UTO1KjR1CUM6CAk8CHCx
	aPQ9pwEhcsjeRutEPQEVTuxSv5e1ixHSP38Xlk9Oilq68NIoxCYN/qbbLE4sNXfZu+0a+DBocdLM4
	vtUbylx2xuTj322rh2gBTZVuL8MGQ0UgYB/079CZXN/rujkpx6j9MOKIKTMYUirkXY4dKV/d4lrWf
	LR4QfLAH4giqWWrBEx6T6t+y29GB8zxGRAERZM5F6dGSZkm8NsMEianCpd+IlY2If33sz9QonRPK8
	AT8EVDp4+hM9R8nABTjR96AcIObl/G4vlbGsM5FTo3RL4h5MBZjK6MO95kMULeSSXhzivoiJN5QuK
	2pgpI4ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV40F-00000001dNZ-2hKB;
	Wed, 31 Jan 2024 06:23:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV40C-00000001dML-2j49
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:23:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F82A68C4E; Wed, 31 Jan 2024 07:23:14 +0100 (CET)
Date: Wed, 31 Jan 2024 07:23:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V9 1/1] nvme: allow passthru cmd error logging
Message-ID: <20240131062313.GB16102@lst.de>
References: <20240130001938.1103354-1-alan.adamson@oracle.com> <20240130001938.1103354-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130001938.1103354-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222316_832818_CB665D46 
X-CRM114-Status: UNSURE (   8.23  )
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

