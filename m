Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC389C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjo6H2YyOx+obyc7MJeZJrvJHWXIIgppXX/hFCpk8vo=; b=JxdIVLjBoyVy4Oc+TWcJDoVJjU
	7fscSKAObe7mbrCAeMk1sea6TcqNZqrjNDz+IGSdaDztB/U588zTohiGHnsAcGOiSVhwA32VvZHpC
	e9WQqSxITrpqhbyxz1RNNsN4mPU/lAzaHlShX0HfKV7y0i8c93PCGcMqBrE9fxH/Y//wzkxrWVcvE
	m0QUfNnDsvXpjizH1G2CvERXcXvPAerEmshVGaUtM5vOf2M4jWRkAHB/tBbPtNkDjbxMXIZlNWpuK
	lI3sT2x8e8pX+sjt9srU+wyZB5FagVMz9j6DlpIx6jltlsbGEycvhQgprQfIvQX5xEyE3RglzbvHj
	bNnJo26w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoAj-007RGb-Je; Tue, 18 Oct 2022 15:06:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoAi-007RG2-HL; Tue, 18 Oct 2022 15:06:24 +0000
Date: Tue, 18 Oct 2022 08:06:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Frederick Knight <Frederick.Knight@netapp.com>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Message-ID: <Y07A8HxPj4cM7RVT@infradead.org>
References: <20221007072934.9536-1-dwagner@suse.de>
 <20221017173817.j7cjvxnvs2lcntea@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017173817.j7cjvxnvs2lcntea@carbon.lan>
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

On Mon, Oct 17, 2022 at 07:38:17PM +0200, Daniel Wagner wrote:
> Hi Christoph,
> 
> Please consider to add the patch for the current rc phase as it fixes an
> invalid memory access and I would like to avoid that the code fuzzer
> army is going after us :)

I filed this under enhancement and planned to add it to 6.2.  Canyou
explain the invalid memory access a bit more?

