Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F8C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/F73bhC9vmaG0huNlBhFWiZSQ3nKQuQkWd8Dmu/Zbs=; b=2Kwez00Ev38tuI0g4kW/N3A/al
	oiRtbNpWJr9FM8AsXY3RL38XlaI3k1UeHHYiRFxi7mZLhGaOxR/WOnTeBNgm7V/FE/4Cv/2qtM/IA
	EWalKLfSHgh1Ft2TT/WwQK+s5loanigL44shokLECchfviff7ST1mnaENB3uzdKFwDzIuhLeShGfu
	3/96TUrJtKtEWfhRnhz8mLsh31H1rJOpqV/JkNT9q7iP7PgGwrw728WtQPbJdSQFllJ1JPdRkbJSy
	mgGv6yMivgYgNGw44N33wrlv+y6rnfreaSFcQqVR258pj2L56YrhCf4Cg3KjEZqd8TUkDybhOhc+5
	Ta81TZpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YIu-009rHr-Qv; Tue, 06 Dec 2022 13:48:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YIm-009rC3-PI
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:48:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2CBD2B81A19;
	Tue,  6 Dec 2022 13:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A421C433D6;
	Tue,  6 Dec 2022 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670334481;
	bh=2JYS2naf9E4zAIWrMEAyI5LO342tnYyw1XzP6ZaY6B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2omVqENBHzAwHg4smn2aRF4jnFXHRhuOxYLek0wV9y2ANZ2ICNy6r0t127kPwEV0
	 UjavF360bI6edL/lh71+UcGZNDZ/DytjcFKG9VK9c51vticZtLv0+Hk0SlyHnsxjao
	 lJXBTxkbA5Ll6lfiID3UUbbAzDvJggsJNUB9i+WfoPG0Dg3JfigCMu1JryIv9eRIWQ
	 wZ1zQD0qSyPTbdJDBmg6qZYEyP+W8BvvuZoTlKbDN8tIsboJw0yLX2xkMyNqvfi2cr
	 9lrQf4LBdD3F7C6G+EzJUFqSlBTT12XpLHzpAboz93x+CLRpIQ6JDbuLhSsF2bOuzf
	 ef8Wbrq3e/8/A==
Date: Tue, 6 Dec 2022 13:47:55 +0000
From: Keith Busch <kbusch@kernel.org>
To: Lei Rao <lei.rao@intel.com>
Cc: axboe@fb.com, kch@nvidia.com, hch@lst.de, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, jgg@ziepe.ca,
	yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com, mjrosato@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, eddie.dong@intel.com, yadong.li@intel.com,
	yi.l.liu@intel.com, Konrad.wilk@oracle.com, stephen@eideticom.com,
	hang.yuan@intel.com
Subject: Re: [RFC PATCH 4/5] nvme-vfio: check if the hardware supports live
 migration
Message-ID: <Y49ICyTJ/WExT+wN@kbusch-mbp>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-5-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206055816.292304-5-lei.rao@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_054804_985759_AF711E31 
X-CRM114-Status: GOOD (  10.90  )
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

On Tue, Dec 06, 2022 at 01:58:15PM +0800, Lei Rao wrote:
> +static bool nvmevf_check_migration(struct pci_dev *pdev)
> +{
> +	struct nvme_command c = { };
> +	struct nvme_id_ctrl *id;
> +	u8 live_mig_support;
> +	int ret;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.cns = NVME_ID_CNS_CTRL;
> +
> +	id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
> +	if (!id)
> +		return false;
> +
> +	ret = nvme_submit_vf_cmd(pdev, &c, NULL, id, sizeof(struct nvme_id_ctrl));
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Get identify ctrl failed (ret=0x%x)\n", ret);
> +		goto out;
> +	}
> +
> +	live_mig_support = id->vs[0];

Considering this is a vendor specific region, it seems rather presumptuous to
assume this byte means "live migration supported".

