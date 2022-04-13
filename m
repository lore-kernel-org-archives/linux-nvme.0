Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZJsY66c5TcYQ4vjMN6WkMeM3ErEPd6p9C0SMGe9KOE=; b=DfbYSWckzb/FNAYCsMfiBnE/81
	9fKVhjKaQz1lka8D3keE9JEIBtqsCRQWNyjEKqxGGd+w3svm93OwpTvIUzb7L9islxltNJ+eIHO1T
	ZLpCzgmOT7XMIzn6+0kASEl6Tcynhs2SHaY5zapBbFPBLV7jkWL2JyPF+OmI7Dd1HZJRNzlhJWmGt
	+EbthNoTlbjlGvjABWb0s7dVRJSozCqYvD6FzWtHaxvAy2nhRJi1rxUhpAJ7tVpEd6sEW0KyMF0Z8
	drOAd1IgF9MaBtH1SLMtkpaEBVSO0K3ensfQ9Fy7oUn+U663PVyoB7kXamr6Ik4hleeViLd4Rg2h8
	JpjP0KjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negwZ-001xwS-Cu; Wed, 13 Apr 2022 17:38:15 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1negwX-001xw6-KM; Wed, 13 Apr 2022 17:38:13 +0000
Date: Wed, 13 Apr 2022 10:38:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcKheNsvNSKZ3CE@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 11:02:47AM +0800, Yi Zhang wrote:
> On Wed, Apr 13, 2022 at 8:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> >
> > cat /etc/modprobe.d/nvme.conf
> > options nvme_core multipath=N
> >
> > And yet I always end up booting with:
> >
> > cat /sys/module/nvme_core/parameters/multipath
> > Y
> >
> > So trying to run:
> >
> > nvme_trtype=rdma ./check nvmeof-mp
> >
> > I end up with the warning:
> >
> > nvmeof-mp/***                                                [not run]
> >     CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module
> >
> > Are there times where one cannot disable multipath? I'm not using
> > any nvme drive at boot, but I do use one for a random data parition.
> 
> So the multipath is not updated with N, pls try manually removing the
> nvme_core module and retest.

I can't remove the module as a filesystem is mounted on one of the nvme
drives used at boot. It is not an OS partition, ie, it is just /data/.
The blktests is intended for some other nvme drives.

> Or just reboot can also help update the parameter.

Reboot does not help, that is my point.

> BTW, to run blktests nvmeof-mp, the correct way is:
> # ./check nvmeof-mp
> # use_siw=1 ./check nvmeof-mp

That does not let me do anything different as CONFIG_NVME_MULTIPATH is
still found to be set and the module parameter for nvme_core for
multipath is still "Y".

  Luis

