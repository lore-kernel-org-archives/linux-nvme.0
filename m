Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F3CEE356
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ds1oXOMKrdE8Gh4QEDhhWqS3+K+FGCpiEZHcgaGaXwE=; b=XXU6+K0FIHAJj0jGdK4p7m99v4
	yqDlEFp/czXZla3Gn9bz5v1or4LmwgAhVckANDklzuwN8wyAYrJtCbxgx62fHvFT/0FsQQcfFKuqF
	dhTasZP3JC4lskzHozWE760GbTIwPklS4xazHjZf8XtHGbsk03+SF6jat+oSzYyQgDzd3e1bL11JO
	jgGG/gcADUKwyBChni2Hv89Yz9BU5yaZ4J0YklcDTEHsEr0XSUuH7DkHCVeGxJKSpq1nIEbelh7tC
	dZZiguTZNvbHIxWKKBPL6bSbcIxKI+dX13BSbqzvqyujo8OD/2ptArm+p0PK2EvvxvTEn+Qv618s+
	aXb8erCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syeqU-0000000AtE8-0TB4;
	Wed, 09 Oct 2024 22:07:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syenO-0000000AspJ-1FMd
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 22:04:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E45CAA41A2A;
	Wed,  9 Oct 2024 22:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79861C4CEC3;
	Wed,  9 Oct 2024 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728511477;
	bh=AMSusgK9H+jWI7oO8gdPw9qq/6p4ZY3+UDfUXVIseZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kh++yUqwGVQ3TC9w3UG+kZMIli9PM/1vzR+uyKXklUbtJ0/XmmPGpn9wXXnxhrDAS
	 LRsSZTUlXe953pLYt9kfXfeTA5qOrVRC0KkTyeQ5e3oljLongMjXYuhICeiBak6O35
	 CYpPpcfBMNbINo8kPsZKh7DAav/BqQNv59ecPUl3bc0laBktcjEES86kPpeLUs88PL
	 xwRG60JVyA3yFqSsaDvvRP5xROSVQ7tTLEn0f7MciZ334pSVeqf0ISJ7WA+kGBLWl+
	 5EB1JKs08huUPWP3+TccBtDbzWsvW9vFqQGQgabEBamLqRTs9kqFeIstPAYo2q07YJ
	 5lnbU+j18F3PQ==
Date: Wed, 9 Oct 2024 16:04:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <Zwb98YIioIGRAQBe@kbusch-mbp>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
 <20241007193324.5846-2-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007193324.5846-2-gjoyce@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_150438_418366_C7D1A9FC 
X-CRM114-Status: GOOD (  10.50  )
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

On Mon, Oct 07, 2024 at 02:33:24PM -0500, gjoyce@linux.ibm.com wrote:
> +	/*
> +	 * Setting CRIME results in CSTS.RDY before the media is ready. This
> +	 * make it possible for media related commands to return the error
> +	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
> +	 * restructurade to handle retries, disable CC.CRIME.
> +	 */
> +	ctrl->ctrl_config &= ~NVME_CC_CRIME;

We could just delete this section entirely. Nothing else sets CRIME, so
no need to explicitly clear it here. I guess it serves to provide a
place for the explanation, I think we can remove the flag setting
anyway.

