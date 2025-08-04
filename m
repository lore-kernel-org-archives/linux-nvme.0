Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C145C87FCF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=hyDm52vWoJYniht4a0YmiXu8MrRuUtXEqfcS9JBBlwA=; b=NFofYGKmbw3fJJ
	QOJ/3u0zBkjMgGITDdXDgnq+om3nJLA4+OSBD8N9rCsNY7G5oY62oSWlttphCNuTery4/0LgA2AF5
	hT7+vEgWx5pef4ChWf8WcUCFFpX6iNRhDJ20MghMlDqdngPI4iCqdgeMpIYENVVxTN2IX1Qu1MdZC
	l5+VzrlLa8Db7C9SXPf6regMUsXyX0jgi5wbLrTh7rvuVrNcQcf4KNIF+Wp+43vGgJmt+KYg1tOUs
	XHZu8rb1cy+AXMIqKIv2yuegAjXL/+5jfjLCZBG1zA9xZGQ+PQppu/YVRmRkDer/Y1QfmuNicaOCZ
	23zJz/mPV1xKfsqOVf7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiyKO-0000000B0nr-36Qo;
	Mon, 04 Aug 2025 16:46:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiyI0-0000000AzuU-0Mx4
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 16:43:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BD30601FD;
	Mon,  4 Aug 2025 16:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7099C4CEE7;
	Mon,  4 Aug 2025 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325834;
	bh=HwwhvUJEgRxZzgYaIY7i/bxccq2glEeWYwIutuF1Two=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H4JRyZYlrPc5stxDRRVAkPlrAe9cOjB307fL67owawgAeM7VEfvighQ+8e2GVpBdh
	 tfk9TTjMWN4D+FfeYo9TVSp1BCO/rzMKWgdUf0emUgIPEDheUwu1c/RG1ctIouqQOV
	 bR0TGJQbiACBFM1g3j94ncUnA+Eyt2kyP9A30UEm6ZBxc4QIn2Lp7xrpI3djqgZhsN
	 v3QLih2xj1pJHbWtTEMCQ0OjIl1ogkEkMlrlGT5luDIPYdZiYIgJc/23t7pXIkFL6H
	 Pzde1r3z6sT99RXyfwJfdXRNouMVrwdlIBnDkDa75oAGzJxoNU+NOtaRYwM5tGRw7e
	 nf4809atviG5g==
Date: Mon, 4 Aug 2025 11:43:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, jgg@ziepe.ca,
	yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com, mjrosato@linux.ibm.com, mgurtovoy@nvidia.com,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	Konrad.wilk@oracle.com, martin.petersen@oracle.com,
	jmeneghi@redhat.com, arnd@arndb.de, schnelle@linux.ibm.com,
	bhelgaas@google.com, joao.m.martins@oracle.com,
	Lei Rao <lei.rao@intel.com>
Subject: Re: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver infrastructure
Message-ID: <20250804164353.GA3628649@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803024705.10256-2-kch@nvidia.com>
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

On Sat, Aug 02, 2025 at 07:47:02PM -0700, Chaitanya Kulkarni wrote:
> Add foundational infrastructure for vfio-nvme, enabling support for live
> migration of NVMe devices via the VFIO framework. The following
> components are included:

> +static void nvmevf_pci_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev = nvmevf_drvdata(pdev);
> +
> +	if (!nvmevf_dev->migrate_cap)
> +		return;
> +
> +	/*
> +	 * As the higher VFIO layers are holding locks across reset and using
> +	 * those same locks with the mm_lock we need to prevent ABBA deadlock
> +	 * with the state_mutex and mm_lock.

Add blank line between paragraphs.

> +	 * In case the state_mutex was taken already we defer the cleanup work
> +	 * to the unlock flow of the other running context.
> +	 */
> +	spin_lock(&nvmevf_dev->reset_lock);
> +	nvmevf_dev->deferred_reset = true;
> +	if (!mutex_trylock(&nvmevf_dev->state_mutex)) {
> +		spin_unlock(&nvmevf_dev->reset_lock);
> +		return;
> +	}
> +	spin_unlock(&nvmevf_dev->reset_lock);
> +	nvmevf_state_mutex_unlock(nvmevf_dev);
> +}

