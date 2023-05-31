Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F537C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 04:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/w64kj3fjKCixcfritioxqaznbhat32z326S2jOml8=; b=abQQcxElmxBZbmPoc68GG1Dfm9
	M8EJxHfjNrr59klbuzZDN0Gc3kOMKxWeUrvah9aSSFNP3pTahDspC0O3pJbvOywnkwWmFMG0FISu+
	ZheTLdHDSZFmidbKlSATSo1uX+y+FHSseeSLDp7w6l68MtOVo814Q7P0w6Ou9PlFJU9cfWAH1l2yx
	/7JpSa61I2zQ3KHpyqbCvejibleRr6ldgu9GDSAbZVEHFOoXetcjxWXuGicVNGgnou7t69vjuF8A/
	fThe7F7P9kieR/BX6CdKemy6PngfXqOesYw/Vn0IhVmclHzBqcFPhc0O/pSwdm29JUlm2cgyRgVNG
	gqlDv0ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4D1n-00FykC-2d;
	Wed, 31 May 2023 04:01:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4D1l-00Fyji-21
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 04:01:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E429D63667;
	Wed, 31 May 2023 04:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D529CC433EF;
	Wed, 31 May 2023 04:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685505696;
	bh=fY4qHD7YQIcgg8OBxNEdeBJzECqWg8uISaDIA+xJ8tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjTfE+TJRRDOC/Jlx7cuKLuOdbE55/x//5zvvkf8RTIQSks1vc3XBdE3hbW7dGuec
	 JVZn+Yk7nZByj3t4G1MqQYEuq2ZuO3jBnMjMMoSnDBeVBxyyQOLbDgXYtzDhJZXx3s
	 fkzceXMRg/U26MEG2l8TUaP4ggKdW3yr1Q62UW6c0h0fS+OCMlpVsy+eL0USddTO/J
	 jgS6u6EG5JBvHf9X79uEuh9tX+cZLmJ2hoz89hXwyaIuVDR3Xp9VBqd9C8BBXL1Stt
	 gUXEPJvOGhDK1lSEIzQOFKn4eTboA8SqUSpjisWBjusB/ewsuThotyeSZKg0tzzBV2
	 1+m55yGt86hPQ==
Date: Tue, 30 May 2023 22:01:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-6.4-rc4-pull 5/5]
 drivers/nvme/host/core.c:1202:51: error: 'struct nvme_request' has no member
 named 'start_time'
Message-ID: <ZHbGnRzo0i6KTMPg@kbusch-mbp.dhcp.thefacebook.com>
References: <202305310532.V3y3hWXI-lkp@intel.com>
 <20230531000858.GA4119628@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531000858.GA4119628@dev-ushankar.dev.purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_210137_711593_021DCDF8 
X-CRM114-Status: GOOD (  11.20  )
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

On Tue, May 30, 2023 at 06:08:58PM -0600, Uday Shankar wrote:
> 
> My bad, I only tested this with CONFIG_NVME_MULTIPATH set, in which case
> the field exists and we don't see the error. The following change should
> fix this up. Keith, can you squash this with f041d3b83aea in nvme.git?

Folded in, thanks for the quick fix.

