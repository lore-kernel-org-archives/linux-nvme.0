Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3492FC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqWfcsTxpbUoXs9AsLKSjYQ7eFeCp3TfPJh1eIE0gPA=; b=NQ9tz8Gs0GUxf4m9CpIIMTJilO
	anQh4/pBTDbVJhYJluK5hTc2brxhSmpZenJUd50OM/dUB5U0nq3XqQcxhh6W2K2ngENt99oJ+zrFL
	JmtdJ26l/QHHP5DKzQ/NKRfkW9SgATYpKxTX1IMukDuRLPtlvOwuzdfZYx8/0V0eOCyR6EM6yTE2Y
	CIgSW1MfIO8Ro2HC2JbBgYkjHBuWlmfNG3oFjOD3TdRmTnSf6c2DkuHstapw4pOJl5n4AOqm1VrxK
	pr85FlXarWyJDY2ftAgksUuMvlWiOMjNmPid67d+9g5L7X6h/9PUeGOzp/Br03/RTv0DZKpl2Pk/r
	Ut9AbWGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQJa-00000004S0f-0gH5;
	Mon, 12 Feb 2024 07:01:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQJX-00000004S0M-3sub
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:01:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13259227AB4; Mon, 12 Feb 2024 08:01:05 +0100 (CET)
Date: Mon, 12 Feb 2024 08:01:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' to an enum
 shutdown_type in nvme_dev_disable()
Message-ID: <20240212070100.GA17718@lst.de>
References: <20240207214044.2374295-1-jallison@ciq.com> <20240207214044.2374295-4-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207214044.2374295-4-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_230116_125975_88ED2C82 
X-CRM114-Status: UNSURE (   9.06  )
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

>  	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> -		return nvme_disable_prepare_reset(ndev, true);
> +		return nvme_disable_prepare_reset(ndev, NVME_PCI_DISABLE_SHUTDOWN);


> -		ret = nvme_disable_prepare_reset(ndev, true);
> +		ret = nvme_disable_prepare_reset(ndev, NVME_PCI_DISABLE_SHUTDOWN);

Please avoid overly long lines.

The rest looks good to me.

