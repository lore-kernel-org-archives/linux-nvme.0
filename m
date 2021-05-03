Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FFAC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:00:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0FD610C8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0FD610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=81xcWMguPaCDRrccqAhhoSy4ZVnmtq0upoJqHS0CKgw=; b=PQdfosPUfuQJ7OsAsdJv5FjWw
	vwT93fog9k3YfIEiz1U8zVDSQKaXbD2pRkfJJpZt4K/ykaURHuF8Wp80OJvRLXRknAp0xqCJ4zz+I
	K3o4e3k/BcWR3XwG1Dr7qfwxXqMo/vk1vrWE9j+h8DRYcqBHowVlSX9tQixRK8+WPHpdFNMiGQ7jw
	ekH/245ipPiFo8/cwRLgmngQiphVJ1RClTE69BOYSBkbY/skllkI13t7V1arjlKD8UPZBFeTPzcI4
	tV+j34JMmSP99oemaUN+yH0jdxnXv791Y4LEEA+q8P0x+7V2nR1G/FSTcGeXtEn8M4oHDYapd957I
	c3KcNTLDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldazI-00EJwc-Ni; Mon, 03 May 2021 16:00:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaxL-00EJfX-Aq
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=GRATXEdDLtmHYm2zR9BEphk7UXJZV3Wtupp7N/wM0ac=; b=efrvKuNX/c2U/niA/rnZ1tNayU
 B6DB8nMOFU2FC4Q8hhzS1/h+hPJFrFSxJFhDK88/Ddz96JtUUGbCOvzBtrdvm0ZZcWf5KiRCBClI8
 6Cq573sCLhqwNzmFSl7NnFp+NyHVmyinPVoe7nX7sJwZ4/LEErOiPyAwOdVtLba76NJeVIg/01eSr
 DAya70Wdur7wRR/WUMhOUYR7zAWNMYhHnSLlgMX8mcUKHJl+DgNqZrnZ7nPc88matiyFiplvQp7OV
 eoL9jDFmUyA8dxpmJ3KL4OG/90XlxKfaK05yezV2V8rBjFhVt7L1RdWprvMrObg1IG6g1UgwqRQSz
 GjnZk1kg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaxI-003D0O-Mq
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=GRATXEdDLtmHYm2zR9BEphk7UXJZV3Wtupp7N/wM0ac=; b=KNKJz1k9cORPoOeawf3gcXlCu5
 eI5GgEzgHHpsYGlQc305kr/f0HuWYO8UNczmVWxt1wCYcoLWokF5N2V6w0Tr7HbLBBwOhuaZYiBVJ
 RXbD1gckXcqlsUMeH9JobfBXeFE5SdNlofp70fCSoNaQ37ycRBY2AiN/N2MGbLxcVQsKPdjEDluEe
 xb+cwsUh7oSz+dRCBwiTM/nRSQ/P9EnqjLLnduy9HUZFFtdlvwQIiZwlOJ3I55O2xSohd2rV9g6Un
 JoFznbmJCUxco07ATLbqEg9Sb2LPcjgV4llvYQvj9+M1NAvWehU2wAYl3X5X+lgSipjOFaQhNM/X1
 iheL+1Kg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldax0-0003G8-Dd; Mon, 03 May 2021 09:57:39 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
Date: Mon, 3 May 2021 09:57:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com,
 ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com,
 dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com,
 andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_085756_814112_B3E0F37F 
X-CRM114-Status: GOOD (  23.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-05-01 9:58 p.m., John Hubbard wrote:
> Another odd thing: this used to check for memory failure and just give
> up, and now it doesn't. Yes, I realize that it all still works at the
> moment, but this is quirky and we shouldn't stop here.
> 
> Instead, a cleaner approach would be to push the memory allocation
> slightly higher up the call stack, out to the
> pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
> the kmalloc() call, and fail out if it can't get a page for the seq_buf
> buffer. Then you don't have to do all this odd stuff.

I don't really agree with this assessment. If kmalloc fails to
initialize the seq_buf() (which should be very rare), the only thing
that is lost is the one warning print that tells the user the command
line parameter needed disable the ACS. Everything else works fine,
nothing else can fail. I don't see the need to add extra complexity just
so the code errors out in no-mem instead of just skipping the one,
slightly more informative, warning line.

Also, keep in mind the result of all these functions are cached so it
only ever happens once. So for this to matter, the user would have to do
their first transaction between two devices exactly at the time memory
allocations would fail.


> Furthermore, the call sites can then decide for themselves which GFP
> flags, GFP_ATOMIC or GFP_KERNEL or whatever they want for kmalloc().
> 
> A related thing: this whole exercise would go better if there were a
> preparatory patch or two that changed the return codes in this file to
> something less crazy. There are too many functions that can fail, but
> are treated as if they sort-of-mostly-would-never-fail, in the hopes of
> using the return value directly for counting and such. This is badly
> mistaken, and it leads developers to try to avoid returning -ENOMEM
> (which is what we need here).

Hmm? Which functions can fail? and how?

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
