Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5FC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lc4SQcUrxiKhZAUyaZ+znlr6Na7SkODfrfLqIZqP0gY=; b=tSS/oWtfczDyIx+MNJFM6YB9Q2
	FMIyouEYVQWoZrfmQsMgD7r+LNpI8S6/kWG3CB/wMeMOPqQC7dSTTGcmaA3Tomqz6hfzs6eiXqIBQ
	BoQriZyu5wlK0GIViTriIHOmrsUFSVVxPDF0+53K4Dy+CQcTo1hL9vthltmmCFJmTI8qfRZ0RZW0d
	q/qRhGMW21qlasKNVNl321KUIzA+Uy/JHvTUWnsuuompbpbi4U/gOq1/ItkROEFC/ae+QLBv3cPUo
	yz1SKZmGjS29tA4Fs+pmzt0PTyXZuL65755TgyyfkkVquEsgc8rL8x5eNOZmvCbz8+hCq32EFl171
	GOOiNWEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv6zq-0000000ExL1-1kKl;
	Fri, 12 Apr 2024 02:50:34 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv6zm-0000000ExJt-3YnL
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 02:50:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9DED7CE2F0D;
	Fri, 12 Apr 2024 02:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66ABC072AA;
	Fri, 12 Apr 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890227;
	bh=kjuxR8BzjV6OP/rkIJ1d1EwNgR/Yv1mV6uPaGcJvTIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfrYjvO2m9VgxuM7NgZiMsDiuzHouTbjMiajCIR2I3hY0I+C1c+PHSiqPheAaW2y5
	 1QCm2fBdP6C5R/UDpIePxs9ZvZ3bqjUximnB0qYJb444NkI5MgAoX/kuC0+vXUhlis
	 wpg43bd6BE8HoYM9xfHgpP59SIHf7fh3ui0Fdgs/NXB3l3RAm3XMNzw6AFgAHd7pkb
	 TytTfnkh/el5xZjEKuW39ffbsACBjTzBRp4coUdZn2O/1A8SIe18LDpJLMaWwk/iVC
	 zRrXzCBLaLKbMQBlR5KxdWpTS3wM5IHLZrEffJlqrjqYa4LtmEuQPbzszegL7lrmq7
	 m2fEUyDpxShNg==
Date: Thu, 11 Apr 2024 20:50:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <ZhihcIORmdMr0Yas@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
 <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_195031_194190_421B1CB4 
X-CRM114-Status: GOOD (  10.72  )
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

On Tue, Apr 09, 2024 at 11:28:04PM +0300, Sagi Grimberg wrote:
> On 09/04/2024 12:35, Daniel Wagner wrote:
> > 
> > Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> > association was established and we have received a status from the
> > controller; consequently we should honour
> honor ?

King's English vs. Freedom English? Whichever flavour or color you like,
both are fine here!

