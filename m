Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41EFCF3180
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcI/GQLU8b3ZFjGItnsCjuvSBjTElsN1oEJE1k5fvFY=; b=wlyLWUWQz5/lj1gcJAoIxa6Kg1
	MFirVvaowEFqfwH7dFT0f+yOKN8LA4d43CmOrMCn/iLy39IIEhT53Iz//1cw7QyAm1O6yR4MoUBUt
	p10pK0LzIt7nQTK+kOxM8+6omNYmjIcSfD88aXw4wWMiJDkQHI4nIpMNmLfqwZ8pati8PYPXBdER8
	sB43qK9EfIrBTbGZOb8GZlMc02gr7fLDVLHLWyH3IG4IRWtiHgtPYfHuNA0iqyJF/nlwTOhoKyj+K
	pxuzZPOnj9Z487Og2nHshLGb7o8lFjccSg3AG39fJZ6bEPpygmNEj5C8Q7juMsE9qGdNzcf0hjV1v
	2D/No9Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svjff-000000041Jz-2Njv;
	Tue, 01 Oct 2024 20:40:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svjfc-000000041Jb-363p
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 20:40:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BE1575C302C;
	Tue,  1 Oct 2024 20:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B28C4CEC6;
	Tue,  1 Oct 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727815231;
	bh=ogTyAHp3idGhTeodC4DnrDF0TptwCKWBNC5H5UedXrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXaql7AwRmRKyexAqSTzB3V9FForGG0ZKxH0E7Tls+0SNwt5nQ6q1yO+1bx1sXl8x
	 a+rROJqvl8SKw3KMfnpQJprSpqlCIloMvOm1wpwpxYvp+eT8RzdRmL1vLv0LhIhIL+
	 p3tGM45FxhL4l42jB4Kd1kZ7yZ2aMSGOYQj0lLflf1PKa0Wdi+eIGUAwouUgfegmLo
	 epCZhaF/spF1X9JOLQ5hARz6fWA5M33nj6l9o2nSXXCq8ckVI+YRJuRZk5kYYFKvJj
	 02sbXgqJFGvcWdKZ9esrdajREBl4VNuOgRmQKev4vhXDpu1x3gTu53DhB2YveZREzE
	 jCxpova+t+IAg==
Date: Tue, 1 Oct 2024 14:40:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@fb.com" <axboe@fb.com>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvmet-passthru: clear EUID/NGUID/UUID while using loop
 target
Message-ID: <ZvxePSX0zRcINHja@kbusch-mbp.dhcp.thefacebook.com>
References: <20240921070547.531991-1-nilay@linux.ibm.com>
 <89d4d73d-daef-441d-beae-e9ba52001911@nvidia.com>
 <ab01d3a4-3f23-4c77-9fe7-c59b25041d44@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab01d3a4-3f23-4c77-9fe7-c59b25041d44@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_134032_844286_1E7714C0 
X-CRM114-Status: UNSURE (   6.16  )
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

On Tue, Oct 01, 2024 at 07:37:45PM +0530, Nilay Shroff wrote:
> A gentle ping about this patch. Does this now look good to you? 

Yep, looks good, queued up in nvme-6.12. Trying to get through the
backlog after 2 weeks of travel and conferences.

