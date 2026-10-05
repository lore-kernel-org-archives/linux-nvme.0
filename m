Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34633CA6001
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmlTC20uhhp2IRMBlESxhWljeADxU55JrZ3UrIkCRzU=; b=pzesTFKf+C7HpQGGfUT4xEFuIT
	pfIxSnqbNrvGuewNyagPs4qvxUzzZQSwZws+24CBsoUyq9GHWaNHu6hMQZypvmR7/6i5phjxmEJF7
	YEBQvy90Wl0zub9vmyYeyYsCP++I52yCpViuSsSl9/lZF1fpKBQDNtXxdZevFcp5jeIhkIRTYPJ26
	F3SRxDo7CuxrhTgYVSPLzTv9r41koe88ClrBnSyTK8qU6lNpB3v0bgEuwKmicdXLtPMKPg9504OJA
	XZXx3am6lKjA9r7zcUDIok4RMvY8cV/QqZXPe4VV/UAepF3JCbjcFefCoik4ilMkm/IqJi+2dQolb
	4g6lAssg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeoi-0000000Fz7F-2gEe;
	Mon, 05 Oct 2026 09:17:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDekB-0000000Fyd8-0c9r
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 09:12:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86A1B68BFE; Mon,  5 Oct 2026 11:12:19 +0200 (CEST)
Date: Mon, 5 Oct 2026 11:12:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pavel Begunkov <asml.silence@gmail.com>, agk@redhat.com,
	akpm@linux-foundation.org, anuj20.g@samsung.com, axboe@kernel.dk,
	bmarzins@redhat.com, brauner@kernel.org, christian.koenig@amd.com,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	hch@lst.de, io-uring@vger.kernel.org, jack@suse.cz,
	joshi.k@samsung.com, kbusch@kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
	matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
	phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
	sumit.semwal@linaro.org, tushar.gohad@intel.com,
	viro@zeniv.linux.org.uk, william.power@intel.com
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20261005091219.GC10727@lst.de>
References: <cover.1790602223.git.asml.silence@gmail.com> <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com> <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_021223_336467_AECC45A0 
X-CRM114-Status: GOOD (  11.92  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 02:16:59 -0700
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

On Tue, Sep 29, 2026 at 05:45:39PM +0200, Christophe JAILLET wrote:
>> @@ -27,6 +27,8 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/io-64-nonatomic-hi-lo.h>
>>   #include <linux/sed-opal.h>
>> +#include <linux/dma-buf-io.h>
>> +#include <linux/dma-resv.h>
>
> Move up, to keep better alphabetical order ?

Doesn't really matter.

>>   +struct nvme_dmabuf_map {
>> +	struct dma_buf_io_map base;
>> +	struct sg_table *sgt;
>> +	unsigned nr_entries;
>> +	dma_addr_t dma_list[];
>
> Add __counted_by(nr_entries) and update nvme_dma_buf_io_map() so that 
> nr_entries is set at the right time ?

Yeah, that would be useful.


