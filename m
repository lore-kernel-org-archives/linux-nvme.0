Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768AC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 22:46:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6470E22D0A
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 22:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6470E22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mYM4qUIqwUrPeqbNXY4OM+/6EqM/RzwUwDWomT+ygn0=; b=i4Nede89G8lIw8IKLKGgCytN7
	xqLAU7OqwRjpMjOtpbXPFMoKrOExoV4t+twAHFbADm4vzUUDK0966tmL4o9RrIboa7MdwUnlMJrmO
	bLLMJF+JTKq10rzM2tdTf+rmcVEtCLsA+vD92cGz7GaanPL4MoCiYsXuHCBTr9/2R9OcQ97nwwVLf
	QwVLPFvJXix7gjgqUMFYQB7NQARbyFKTsR02JKGS1wmfDhX3ivraz/dYzpQP9slxP1Nfc2zvGIoMS
	poBKYQeYw7Z36vcadxD1BwkIVeSn7A2P3AnL0/Au0gyWxb3UE5sJ11aWgket9w/PqLSoixs+O/fGo
	bIpyRVQKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpJ5E-0004f3-JU; Tue, 15 Dec 2020 22:46:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpJ58-0004el-Vz
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 22:46:12 +0000
Date: Tue, 15 Dec 2020 14:46:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608072369;
 bh=KmhdxbEWbjxMgbM9k85U/Oe2ahWpdxp/ya5SYYDbN9w=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=KVqbps7s/RWiBNzxVbl6ITd1IvxXUuDVZX6Uu4EKtJxkA12AXE9Hvp+yXxqvcR5Cx
 RNFFUxdCHOxuum+vrPbcuUh3JAT7KC/aRwRiEGY3LcWw2r0rJkgCk2L4ifShp6QTts
 KjNQET7h7GBInbWRW5jnEoSyXv0N8AGkc+7jNjeEtF+UXnm7gICqKXXR6gPMKKaK2b
 e6NII92AdMVuCB8e+qEv0F1kO+FR47Pn/8X/ezFyr0Fo2ESJbg9zLAcmQGyhbmP0kx
 ee5wOmIPgguWqMC8IvZkS0a7NjdO+zu7AH4Z1PEKjSyuU6uHsWHt5tWalPdtoUQvoM
 Y0qwu2YpR55iw==
From: Keith Busch <kbusch@kernel.org>
To: javier@javigon.com
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
References: <20201215195557.30169-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215195557.30169-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_174611_118777_727391D3 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrote:
> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> +{
> +	char cdisk_name[DISK_NAME_LEN];
> +	int ret;
> +
> +	device_initialize(&ns->cdev_device);
> +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> +				     ns->head->instance);

Ah, I see now. We are making these generic handles for each path, but
the ns->head->instance is the same for all paths to a namespace, so it's
not unique for that. Further, that head->instance is allocated per
subsystem, so it's not unique from namespace heads seen in other
subsystems.

So, I think you need to allocate a new dev_t for each subsystem rather
than the global nvme_ns_base_chr_devt, and I guess we also need a new
nvme_ns instance field assigned from yet another ida?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
