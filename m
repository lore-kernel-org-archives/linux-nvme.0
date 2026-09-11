Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48372C88E45
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFcP+msEndaEluKtP821wQ6ElXTJ5PN1JPySFto66po=; b=aitxNCszauPcnNwDEi6VWYGcuL
	u1+NMIu3WqNjuWZO8I0s++zOqVArv4kucT8WeHvjs2zeyRJ6S9qlt6JWhXMrsy9d1B2Bb/cxMhiIK
	qU4B6eyGyhtwksIvcqYABFsBWfjN8nJFshA06DLJFfSOrFJaLUU+YnMAJtEJFD47kvr4+5VdFAAgD
	A/cT09NNTjgCtbXpFeymFxlMbAxilwI/yPjOjSqLFQQj2Mpl5BWIXijGkLeRN7b9r+U3+3F6nhD9S
	22DcwPiCe8pMVLxwOaxO30iuAnD/CA2j92lB3S/Xf35J3V52m3VGFxE2pqSR6gIXPoAFv4wpWK8JW
	sJzoDNiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52Vu-0000000Gx2L-1dLI;
	Fri, 11 Sep 2026 14:46:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52Vs-0000000Gx2F-49iW
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 14:46:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6605340950;
	Fri, 11 Sep 2026 14:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA84A1F000FF;
	Fri, 11 Sep 2026 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137960;
	bh=mFcP+msEndaEluKtP821wQ6ElXTJ5PN1JPySFto66po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fkhhj7ACqa8z2Q8pjPFjzBPAfZE3LEXQT0RJp4M1YO5I6P5NVPXdxG6o3GVMKhxxY
	 stazg7i8T8V77rOH7bh5IH4diI7duSCK4VyFPc2IZ0icORgoPPcSbApAK+b8leZYAj
	 7dQ5gYZtSqgA7n061h/bcn2VYdv34RaRaTB2c/G4fd+F6BBDAKfiAcGpYXQ7amZ2DM
	 mF7TLwClqLs8QcYm1MCXkcSyzH2BKm785kYOCcDgQby4OKxyq98k/z9vWEFz0xKAII
	 RA2cKz/Dlti+LA36KRv9SYiNkCk07XqkKy/bX7DR7iY0QlTLWhovz+a78jTsck4cHo
	 QHFQpD/t6ojcw==
Date: Fri, 11 Sep 2026 08:45:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, armenx.baloyan@intel.com,
	james.p.freyensee@intel.com, ming.l@ssi.samsung.com
Subject: Re: [PATCH 1/2] nvmet: preserve device path on allocation failure.
Message-ID: <aqQUJtsY9JdGoVgb@kbusch-mbp>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908033519.2721210-1-sunjunchao@bytedance.com>
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

On Tue, Sep 08, 2026 at 11:35:18AM +0800, Julian Sun wrote:
> nvmet_ns_device_path_store() frees the old path before allocating its
> replacement, losing the existing configuration if allocation fails.
> Allocate the new path before freeing the old one.

Thanks, applied to nvme-7.3.

