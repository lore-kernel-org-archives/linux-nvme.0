Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D23CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 22:49:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F43D61425
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 22:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F43D61425
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IsxoQH7vpArW0XZ4f5ZgDo+ezbcBXfmucB89cPf8/EI=; b=FkPYVWC9oX1OR6
	ZuOsJXsc2dLhNS2yFYfPQ9yg891X+PsmuCrTUyx6LTqA0qVIuQcUryUmA/vZHRE83Td5curWG7bEN
	9nAClt/X3EVgAp15cdSdCmI5AcZFC6tIEugynLxLnwkhSeILx2aj2D7cHOPzLnNaE5luVWb5Lf7Rl
	AXaQqKf9wcXap5IKeYdiNQY0h+S0yLhNpWRws4qWRbnJVZ1C5hwvS+TEvjLHhzLFZ9zDKdMhJ2Fqq
	beObBGYBbRUG2/XYYz6u5N3Slygb4lM4WUdIoVtIaYZo9fhC4mDyARKxVlGyyYhAXDKEOO8neUcEb
	YZ+GJviLUsmyuTul3jkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mViNS-00CXBx-Oe; Wed, 29 Sep 2021 22:48:38 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mViNO-00CX9Y-Lq
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 22:48:36 +0000
Received: by mail-qk1-x731.google.com with SMTP id p4so3970109qki.3
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
 b=P9N1xixIbU2CQZqPgthtCxabWVb1WaKJas+T5Bbtlr4fD7rztRWCIEl7HQ9hsYT8aF
 41wF7TSRaJ3f9seP9f0KrtpHt8gvV/9kf7XUzRs3fIottSWd5Jos1b7FSN+JKsFTdWUh
 cQmc0BxR1at5W66It0VtetEvP3kxr6TgFG71lefSWpCHrqHfP2E1T4XXYFzcdwOAnPpb
 WlKs8E3Ae/btD+bQUn9uA6WCV6uRLRFmutfEb0Vg/FCMMltR8qwOKBC/i/xs0Mi5ciI7
 QAuN+ydzCbvdhC6HuPboTTSd7wkOyLMNyDUAGQreZfH9ZakjqoboD9OYItawKLMdXBtS
 NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
 b=AtTFTlF8Cwv29R5Q1MxuTT+LxX0bJdKfwEzJDwghFgm0EpMdIeIJ7k6qj5xB9uoibC
 bPdU9ZuslPXkDnkoBzCFp45NHWmzz1RaiAYr+qzh3BrK2ZKURD+OqU2+bfv6gUPJsm37
 5fJZWO8YDKcLdv949QDUxsnH9R3eETGBZMbzTnxPAi9Q5XJZi73MViNACvz33W0LaduN
 ijNj/vfXENnK0V3Cz7sX/HrxdysMZbtJSq37S+hPwl7PDPu1oJEKUmXxkyJJUaB8apiz
 ljKKzpGdCcmEk2PIfSdGnu3GylQ3lnl45rhfILODXcgxHU0/ZlHR4mvdjggPgnGq+A4p
 A+1g==
X-Gm-Message-State: AOAM531GsM5QQFbO1syBKEE0aX3HMdyzaBtFeaOzKXvAHPWgOlPhtCB3
 lMJMsr10RihzjcbQUJ/pP7sq4A==
X-Google-Smtp-Source: ABdhPJzspya2uDxnOQP6RHXKg0GJNOh86aMtX4Pki+BqPF0YRta2WtTuRpyPIif49H7Hs8Tu/MZ3xw==
X-Received: by 2002:a37:8ec6:: with SMTP id q189mr2083152qkd.145.1632955713476; 
 Wed, 29 Sep 2021 15:48:33 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id q14sm748591qtw.82.2021.09.29.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mViNL-007i7c-U2; Wed, 29 Sep 2021 19:48:31 -0300
Date: Wed, 29 Sep 2021 19:48:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210929224831.GA3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
 <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_154834_915371_B8F58573 
X-CRM114-Status: GOOD (  17.54  )
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

On Wed, Sep 29, 2021 at 03:34:22PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> >> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> >> allow obtaining P2PDMA pages. If a caller does not set this flag
> >> and tries to map P2PDMA pages it will fail.
> >>
> >> This is implemented by adding a flag and a check to get_dev_pagemap().
> > 
> > I would like to see the get_dev_pagemap() deleted from GUP in the
> > first place.
> > 
> > Why isn't this just a simple check of the page->pgmap type after
> > acquiring a valid page reference? See my prior note
> 
> It could be, but that will mean dereferencing the pgmap for every page
> to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

It would be done under the pte devmap test and this is less expensive
than the xarray search.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
