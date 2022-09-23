Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803BCC07E9D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNVLh7QhTGQ0fcTY+ctZvZZG3IwOkyYDgRdATbQqFOE=; b=IYh2+IvcGKjUJw3Pt/QwVo+wc8
	DrbWiQj2w7VX0vLJsbGCsYw5ldJZiRySmmL9WTP/F/tNsGkX++EQr7NzVO7dP7c54bNLTRucn03Q2
	BgD42GjZLNxhpvdhbGS+dOFYS7eM2VlS6MJZyoMmeISyhQVyOcKLFIQ/nOO64iXgtRyOTuueNF3To
	crVuHmConFRteKV2Ntk2GgaAPjQHBwe4L3HO1TBMBsaFsrhC/b+Ud48+zt0+FT2ROrazLlVkMwKSH
	5IjpLYphGY4wWghiCpIlJyNQIO4nawO1CRF9KeRIJxefmWrzDqzl57Q2WcTkrm98o1OEnbDK3rGGx
	QN92395g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrdJ-005ue2-7H; Fri, 23 Sep 2022 22:58:57 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrdF-005ucn-Ep
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 22:58:55 +0000
Received: by mail-qt1-x833.google.com with SMTP id h21so988550qta.3
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FNVLh7QhTGQ0fcTY+ctZvZZG3IwOkyYDgRdATbQqFOE=;
        b=K6ThUhwaPxzE2uNJlUneDV+lEcb3sOSkMme+uJcOlA6PYnkzlx9eWnQI1++F4JHPTq
         6r5PK01FmTenaqwabhqB54wtpEtSh4q/f93LAarupwwOtTOjD+IgB/VnY7DUeuIhnkQC
         ueJpGrhUyrDSBys3KiQqSXiiBkciEmtt9rHzEbu8riWDZ48ZSyiWrSiPky8YDf3TxmTw
         JUiu1YmBDldxsDnWcSHllSPx0BxlwyOXe/lppV6D0S4dxlwZK9P4DpsQeTWyB8t6HwzK
         z3SSHJoW/95nBFxiW6hEVkAM1qDx4k+3uHGKOmgxxq5NvqNGbvm3e45Zg2lFjxXsyWRU
         k//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FNVLh7QhTGQ0fcTY+ctZvZZG3IwOkyYDgRdATbQqFOE=;
        b=uYVx3TOPrj7+L+u8YyhJ1tLxZpgWxwzJKw4c3ryCpZDxOeT0+b0Gm7EVze664BKAbR
         bDj3shb3l5JLWkseRiW0VSVkJpte2CRSM9gde4NzfDqhIBh/gQTDTXaDPQktVUIFmvF6
         ZYOB6St/vl6RNEBDURAF1rsPhdJMlcgnhuU9/rvOreoPgYBTKPV6wVZa7NUIAI75wd+f
         2f8pBPzAPsbDBjURZLXg/CAI7X33lAf59jbOB3fH22oYypyfx8iRems1BlJzdQrDp2lP
         Nvg8PbHDlsd5ybexYq6HZmpniOScYv0Kcy/tTHNmjh2cw/kM5GvFYO4bTA34bnT9rrGB
         ntew==
X-Gm-Message-State: ACrzQf1RnWaNuW3DiqsJaX8bN786h1fJ+G+Z2dXSRYlVwR4PA4or3OMv
	fCMmlIzLBjDrYfLOy6lLbZwVlw==
X-Google-Smtp-Source: AMsMyM47dsm4TxegiRkZUeLCH+5O+Wr8H54uLORgq4Q+/7wXo2aoGW0gmLRhcDSR3jPPk1osSOqTXA==
X-Received: by 2002:ac8:5a8b:0:b0:35b:f5c0:d5c9 with SMTP id c11-20020ac85a8b000000b0035bf5c0d5c9mr9233331qtc.14.1663973931136;
        Fri, 23 Sep 2022 15:58:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006b98315c6fbsm7255492qko.1.2022.09.23.15.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 15:58:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1obrdB-00316G-At;
	Fri, 23 Sep 2022 19:58:49 -0300
Date: Fri, 23 Sep 2022 19:58:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy46KbD/PvhaHA6X@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_155853_848273_255DB5BD 
X-CRM114-Status: GOOD (  24.99  )
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

On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-09-23 13:53, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> > I'm encouraging Dan to work on better infrastructure in pgmap core
> > because every pgmap implementation has this issue currently.
> > 
> > For that reason it is probably not so relavent to this series.
> > 
> > Perhaps just clarify in the commit message that the FOLL_LONGTERM
> > restriction is to copy DAX until the pgmap page refcounts are fixed.
> 
> Ok, I'll add that note.
> 
> Per the fix for the try_grab_page(), to me it doesn't fit well in 
> try_grab_page() without doing a bunch of cleanup to change the
> error handling, and the same would have to be added to try_grab_folio().
> So I think it's better to leave it where it was, but move it below the 
> respective grab calls. Does the incremental patch below look correct?

Oh? I was thinking of just a very simple thing:

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -225,6 +225,11 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
                node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
        }
 
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page_folio(page), 1, flags);
+              return false;
+       }
+
        return true;
 }


> I am confused about what happens if neither FOLL_PIN or FOLL_GET 
> are set (which the documentation for try_grab_x() says is possible, but
> other documentation suggests that FOLL_GET is automatically set). 
> In which case it'd be impossible to do the check if we can't 
> access the page.

try_grab_page is operating under the PTL so it can probably touch the
page OK (though perhaps we don't need to even check anything)

try_grab_folio cannot be called without PIN/GET, so like this perhaps:

@@ -123,11 +123,14 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+       struct folio *folio;
+
+       if (WARN_ON((flags & (FOLL_GET | FOLL_PIN)) == 0))
+               return NULL;
+
        if (flags & FOLL_GET)
-               return try_get_folio(page, refs);
+               folio = try_get_folio(page, refs);
        else if (flags & FOLL_PIN) {
-               struct folio *folio;
-
                /*
                 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
                 * right zone, so fail and let the caller fall back to the slow
@@ -160,11 +163,14 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
                                        refs * (GUP_PIN_COUNTING_BIAS - 1));
                node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 
-               return folio;
        }
 
-       WARN_ON_ONCE(1);
-       return NULL;
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page, 1, flags);
+               return NULL;
+       }
+
+       return folio;
 }

Jason


