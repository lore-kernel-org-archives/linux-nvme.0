Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FB5D3C522
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYYzYlSasJsG6wtrJup7nVCmcPO43Q/w+8Jc5iMvz8E=; b=XixnPwwg/V42m97Wsv5ds7PqOI
	YqKY9U+d4coC9ZNE99Bl6jcMmKlifiQAG85+7Kjvnlunufpmf/0Lobk86OpHCSkYeNmSlNPP8CTUF
	yxbRnem2WqxF960lGplBpZz/FOI6r5nrGCQ1pZDXGbxgywjnTL3iWsu6gXQcKL6GZn/INorqg8ieq
	HtvRLae8T9WyoslvFIqTCcEnnLBhO9CCcDrzM/PusECedR5dOrKwlQGns3JLaZMf7FZthmqFs8fAg
	73tyB23RcHwdh5g1U5Ir7JsO3DMg07uzOTyfZjm/CfCczhJbDO0H2JXTLuGyKlpRDbELXQZZjh1NB
	3NGWmsyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TcC-0000000FYYu-2BY4;
	Thu, 17 Oct 2024 16:44:44 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TYG-0000000FXSk-3aJC
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:40:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21D10A441DF;
	Thu, 17 Oct 2024 16:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54798C4CEC3;
	Thu, 17 Oct 2024 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183239;
	bh=6eOYogsD0a3OKM1weP7TQicoaifRnyoiDZo73obPdmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5rmp3w08F/HfPsrqpYjiMQjPQ6IMkiosR7ZoJVI48ooEJMumCKcpOwhHExA0WYEe
	 hHBVtwHzs9ItTfcRDYXq5U75vKDFi2FUu2JiIcRJNvbyj0uIy189ZiquAQ8vNZWj7t
	 LkuZp4AoptEThaPY4ObBlDsXR0/LQ/H8GTm9J6b9zyNRS10PxfaJyS6DNOpaEkp5YK
	 UQUe+qKKlICYQaL8W7biAXjcH6ptiTINpcMVcg94RL5hejrPj0WsD4MrXEJcRGv7+j
	 rgT6kHMeVFgmbmm0K9E7q68zc/PmeGpe+Ijm8Njhn9CgZKKBDuzC+NoWL9SDIk0fXb
	 uf9sT7Oz3SW/Q==
Date: Thu, 17 Oct 2024 10:40:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016213108.549000-1-abhishekbapat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016213108.549000-1-abhishekbapat@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_094040_977767_A5E9FA33 
X-CRM114-Status: GOOD (  11.56  )
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

On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> max_hw_sectors based on DMA optimized limitation") introduced a
> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> (MDTS = 5). This restricion was implemented to mitigate lockups
> encountered in high-core count AMD servers.

There are other limits that can constrain transfer sizes below the
device's MDTS. For example, the driver can only preallocate so much
space for DMA and SGL descriptors, so 8MB is the current max transfer
sizes the driver can support, and a device's MDTS can be much bigger
than that.

Anyway, yeah, I guess having a controller generic way to export this
sounds like a good idea, but I wonder if the nvme driver is the right
place to do it. The request_queue has all the limits you need to know
about, but these are only exported if a gendisk is attached to it.
Maybe we can create a queue subdirectory to the char dev too. 

