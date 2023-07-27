Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40915C001DE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESICGvQrx+KEIuM7HBc0NdxjEgaHPeH3KKQW4k80Mk0=; b=sGQ50aRYqcNHfL6tud8KMr7t41
	ImGCpSUtyEde28+u5fl0Xh/BpbjAlYjdNhoFM8Pn+gvBkgHtoWF9vMrUorfzPRskYB9p2TdQ6Bsta
	cVuc39Fexetp/233O+/ltbrXZRQe24nOPqU1mgxdGRDa8LShPjvmyjhjI/UeXFE6mxUZD2qSVrKNH
	0WB3Il67MFjJ6EfdRWtmU2Oze2TZnfpY29pW+HkQkdI/+22kL7sYYz+QIBunG9CfB4NArMDcv2FDl
	wW6dCqfQ13kaW5Rdl7etDOCQSLmIFNstdTnH/vf2JTL1Wbpc/wHZuI0/WKm34rk8PIx6Nhr4DM6Jt
	GiqY13Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOppu-00BsBL-2d;
	Thu, 27 Jul 2023 01:30:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOpps-00BsB1-2S
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 01:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690421435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESICGvQrx+KEIuM7HBc0NdxjEgaHPeH3KKQW4k80Mk0=;
	b=AFv8ZGF4gbxA6lBbubJB+CNEgqAahFE0DF9566VhzyWQ6to8R40jfQI+9r6jFxR5fUetaP
	jSHUHBzCaz/2WaRSLWY1PRMvaqbssywEVSF4NODIrNCCp5ZSQK271od0bmFF8DepIa7LCE
	icaZ2r9CrY9pwOSsb6evB3bXk7MJ0zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-qMRzWzQ0O9-IhVqg9TcZgA-1; Wed, 26 Jul 2023 21:30:30 -0400
X-MC-Unique: qMRzWzQ0O9-IhVqg9TcZgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70C2C185A791;
	Thu, 27 Jul 2023 01:30:30 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D43D9145414B;
	Thu, 27 Jul 2023 01:30:26 +0000 (UTC)
Date: Thu, 27 Jul 2023 09:30:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <ZMHIrcv+GyqB4FfM@ovpn-8-16.pek2.redhat.com>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
MIME-Version: 1.0
In-Reply-To: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_183036_871567_4F7DF7DF 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, Jul 26, 2023 at 01:52:04PM +0200, Daniel Wagner wrote:
> FYI, I got a a bug report [1] with a 'stack smashing detected' when running
> 'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported against
> udisk. udisk recently added libnvme which does now a sanitize-log call, so this
> problem might exists for a while.
> 
> We figured out that an older kernel such as 4.19.289 work but newer not (it's a
> bit hard for the reporter to test all combinations on his setup due to compiler
> changes etc.).
> 
> There was a bit of refactoring in v5.2 which could be the cause of the stack
> smash, because saw this recent fix:
> 
>  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")

This commit only fixes DMA UNMAP direction for integrity data, but is
there integrity data involved for 'nvme sanitize-log /dev/nvme0'? 


Thanks,
Ming


