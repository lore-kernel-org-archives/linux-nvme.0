Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414D1C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFB8XxkqpnkVAtocN+6ovfDngiFl/Y0m0hWMnldeQUk=; b=dw951VXoNoopeEDvvDNCXzN/zE
	8IUhNPJgffL6K+XRivoafC4yi7Ehq+nZQY2tyDgpxqO1k6WdB4ecTORPx9yclrawxKOTpX2UmNyPC
	tnbn5cf5w34cc5VqpZpZGP5wbFZtHg6iBjpa65JOC2XbM/Ids9x+rujz3oYeUDxGZbA/BZk7MXEGg
	jjFrTmdybu1siStRObMq4tsJEJlhg25/2spK2If4HOqNzaHVuIkxYF+dcFN+Es3EilJKE+mDgUTL3
	cTKXiI22C3OlHJWyfqrT/sp+EfhoPBz35dFaOMGQjeEA+9IQR1a6QiYC+MvMbDKP3m27p3OE+SuRF
	HSMWRWDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8XvR-0000000185y-49Je;
	Mon, 21 Sep 2026 06:54:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8XvP-0000000185X-3IH9
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 06:54:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8AD1F6732A; Mon, 21 Sep 2026 08:54:48 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:54:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Ing. Alfonso Kuen Arroyo" <gerencia@idkmanager.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mlombard@arkamax.eu
Subject: Re: [PATCH] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
Message-ID: <20260921065448.GA13764@lst.de>
References: <178978695312.43804.1554581215424967584@idkmanager.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178978695312.43804.1554581215424967584@idkmanager.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_235451_983983_24C7D54D 
X-CRM114-Status: GOOD (  10.77  )
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

On Fri, Sep 18, 2026 at 10:02:33PM -0500, Ing. Alfonso Kuen Arroyo wrote:
>  #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
> -#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
> +#define NVMET_TCP_MAXH2CDATA		0x400000 /* 4M arbitrary limit */

Maybe use SZ_4M instead of having a value and a comment that can get
out of sync?


