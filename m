Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D208ACD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INXS2v+DNedghuRDrdYVMYbVqhoo5ekQGBCjzBdWhzk=; b=j2Wx3+h3KnqpGzDuJ5lQyvr/OC
	EgkM15mfVIuZlWkjQB9SH2FLlHCY0LGY1JkTasewvaJ34FYLzmHDnyt1EmrRKUDo+apbOap2RxDWj
	TdntMFqg2MP14raAMZOogj72T8olwgnttk/Yh1pwLbglDxZGDLpF2LU3f0yQ+AxwIEwsjTj3K0QZ4
	y/ybYZdOhJk3PX4E9tm3cfXny/K77+vloR3GIb5IOSeLmhBC47MGdTvEWDkchwMMIRoeLolCniAec
	BXJTiMNSvbz/3aSaDzjAaAIKk0X3DeFy4Kji/FBwpD02Y/llyoiZ52Ea0uDiwLGxm58JH5je0G9kI
	mLC4GTcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX0DX-000000067dW-1Do2;
	Tue, 09 Jun 2026 17:26:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX0DT-000000067dJ-11ke
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 17:26:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55A286024D;
	Tue,  9 Jun 2026 17:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB10C1F00893;
	Tue,  9 Jun 2026 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781025978;
	bh=INXS2v+DNedghuRDrdYVMYbVqhoo5ekQGBCjzBdWhzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlzO4zIq9amJfyKqo1YDwj5rppQ9W8BNLNfUdE6VRP8QzCR5dP9fb8VAK1eQnfboD
	 alMxu/SRoEKa0TWzQVeVFZH/bqs5Zq0WR6YSGCjn2HLuAoIjQmDbK/AxW73OuxNgnW
	 fj16vGscquBMyFWJUFO6qnbzmF0Kn2ABP5sN/DlDMjwJnaPenXXPCJDQpI0xFb2YgW
	 I7QW2/uJ7yzQD0To/AehH55zPNRGYkQi77mzsIstO/dXj6tROT+RlT/IfQRfdKIeXi
	 6bfor0wltiqBs8owmIOltPYHCvB87w0+zgFFtFGzkAmB8oYpARbhfDgTzdMFOavc0I
	 4n9TDJ/E79RIg==
Date: Tue, 9 Jun 2026 11:26:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@arkamax.eu
Subject: Re: [PATCH V3] nvme: fix crash and memory leak during invalid cdev
 teardown
Message-ID: <aihMuE_mLbLl3HMc@kbusch-mbp>
References: <20260608155357.256966-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608155357.256966-1-mlombard@redhat.com>
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

On Mon, Jun 08, 2026 at 05:53:57PM +0200, Maurizio Lombardi wrote:
> In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
> nvme_mpath_set_live(), the error is ignored. However, during teardown,
> nvme_remove_head() unconditionally calls nvme_cdev_del(). This teardown
> asymmetry leads to a kernel panic if the character device was never
> successfully initialized.

Thanks, applied to nvme-7.2.

> +	if (ret) {
> +		dev_err(ns->ctrl->device, "Unable to create the %s device",
> +			name);
> +	} else {

...

> +	if (ret) {
> +		dev_err(disk_to_dev(head->disk),
> +			"Unable to create the %s device", name);
> +	} else {

I added the missing "\n" to both prints.

