Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E1C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CF461182
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CF461182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tz4LL9HrZyyXiu/pYQQpxw0e5apDNJDL6ee2lPa+PlE=; b=W+InaZHi7c2Jijqb8AzJsx7eS
	W4LCMnTd9umwaRPyG8aqO34nOIlS53eRYTFPZWSJ7cn+SohJjhiANMufxorbjeWwkIchv65KDdWID
	/XhmY5U36TzRibs3VHliey90gztG8Mm/gt6+JDmnSWCUJoxZDoq9Y2J2iG2Tp7hp5G0e8b6DM+SZW
	OiNNoaEa35LsNOjDSkZjZaWh25iWV34kBcxGR+F1aUzcL0xUkDR9ywlujy7FQduArVe2xQmlsKhUB
	gfGkc9gjbXqWKAHbiAHAZ5tc9En+8DFnXZH1nmlDFpGPB2ZlSzyO0YFzPUEiALUMverIQiIdO+gDn
	CVSZZwzQA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhaUT-008SWT-Nh; Fri, 14 May 2021 16:16:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaUQ-008SVG-BJ
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=/+y5cB9Q7a4Pvo8GJ697lhiF+rrko29gkIH4dIcvU3o=; b=0aD3KDFfYFraQ8uet1WhrGYnLP
 ov+2MzjToWGW02WmdgK5J8ZX6oigaxY0/8rjqKowFvWQHGFObQlI+8DdkgtEvAD/S69HNv0vMCTpt
 XZWCySSVuBBKX2p7CJPZQCeFCuIdhFAtxJ2i6F91MwUcF1n+FNdLzpsaJ3arcOBWNY9jsfUDQcwVu
 VBYv8ZOzJYZ6JjATXglFPcIg26o+XlqtyvBgTsX7La47Owm9NOTD1IZbYvLxzbXEAPL/i2FZt5xYd
 QCFgmgQZ+eKmMn38UUpjw3q74j9iz8rUk6wbV4iArHSXg5LtWXJCbsqCQba0HmaljdW0XHZYjQEU8
 BDkN6POA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaUO-00C6dI-0u
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=/+y5cB9Q7a4Pvo8GJ697lhiF+rrko29gkIH4dIcvU3o=; b=MmSRGhUuqxFDvX3OK+OEV4eVpd
 N/zgGKMQXAVlSEVeXQz+yWzkMeG0pfSpIiblq7NLJ0wupnrLMumK0rDjtFfd/FF0Q+C6GEtJn1SLL
 tmGX51BeuLVhgkyvD8B4j7MvaJBIzhzYyfu47Qf9jlfwBgAi4eGOADrfqJPFfdcwm4fLKHriYZkwB
 XWJGNXjx3vL7UZ0Gg4+cLIwWfdX2ukuUFEwI/isOFo7IfVxMrRMdibQR0bWuhrA1ObTZLbU/6JGtF
 NEtN+nFTqspeVtbQ/8atAXDLh7mQFhxOndy17QOrVYpfrcaQ2HCESVb57wBSg9r+wW/N8KqvIGTQ5
 +nUXCXXQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaUE-00067v-2Z; Fri, 14 May 2021 10:16:26 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-15-logang@deltatee.com> <20210514135331.GC4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9515a7c5-40a0-5411-a3b9-4216b25d63dc@deltatee.com>
Date: Fri, 14 May 2021 10:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135331.GC4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 14/22] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_091636_077030_8EB6F8EB 
X-CRM114-Status: GOOD (  10.64  )
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



On 2021-05-14 7:53 a.m., Christoph Hellwig wrote:
> I think helpers for the dma mapping implementation should probably
> go into dma-map-ops.h so that the header for the public API doesn't get
> polluted with them.

Ok. Will do for v3.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
