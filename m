Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E475FCCD195
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZAldAcKCtdOPcQeCIEmeEOxggqwe9DU923hlJ/uJqc=; b=QRCp0oKtHZwmpBTyTyMKD3Hk1Y
	9CSbOwXkRt6aswK3nkDIhDa9yGRsRqJoLrbuKAkA65Xzf9IhaA31Rp/DIEvuV17aXlAGZXFJ9ZLNn
	oKDwbHXDS4Xx8ySZJ/1eWDjlhwgBiFo3tO5OViPMpnf03VCRU/oCRgMiM8br/L67o2nVaKLg+swVu
	qaSa8HqR4eWitG1JgVp5Er1UI5HSxiBDbXIgj9rXuvC1PTCxbXhxeikZ8XPS5qX4tQ5mSQylDtxs3
	QQ+9ruSm1X7ZjbXzfqTd8CT5uWu6HIdm4jYB5Wj2nUY9995b2nyxvCQ+tDMua2Rfg7MctXtRjZ/sL
	D6Mkg5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTaP-00000001wpL-0DHk;
	Wed, 22 Oct 2025 07:48:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTaM-00000001wnx-3kTA
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 07:48:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4699D628A8;
	Wed, 22 Oct 2025 07:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D07C4CEE7;
	Wed, 22 Oct 2025 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761119321;
	bh=hg7ZnStODXk0tmaNXauC9GSR5tXux7ipULBbQ6CkS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b58lm7+wL0fRgZMY5Gh+tA/3XTEhcmmzr4oHWEEFeDU/BagECZHcN8XJEIxa2eB1k
	 f108R3zMg+KsB2OH1v7du+IyYLsP2sQhy6Cu5iOvxAlsfKF4yKGJQZYzcnVL7EIDjE
	 OEfg4hPtReB70EUEUUjAnbJ5JEeUbmnOFB1W7Kg4=
Date: Wed, 22 Oct 2025 09:48:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <2025102230-omega-octopus-3cf1@gregkh>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
 <20251022062634.GA4790@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022062634.GA4790@lst.de>
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

On Wed, Oct 22, 2025 at 08:26:34AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 05:29:07PM +0200, Gerd Bayer wrote:
> > Add a new error message like
> > nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> > that makes failures to probe visible in the kernel log.
> 
> Is that really a thing drivers are expected to do?  If it is generally
> usefull I'd expect it to be in the driver core.

We have that already, dev_err_probe(), no need to create
yet-another-version of that.

thanks,

greg k-h

