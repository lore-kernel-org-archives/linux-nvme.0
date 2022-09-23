Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFA8C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UKGkJSDEegt6Km6YnASFgTL/rZgzcY69GV8aEjSrBsw=; b=QadmZbxklhshey
	G25Ju63O5h0lpyQ8/Y7RfZ1BGQfENTXe3M3BusaDTW18a2M9Pqm8iksUPMWwaT2Uy4EuCu2otZLP7
	3VhITyG3RrRRsw8mrMctCg6rFzR1/vXopqT5SEp50UdxlxS15TqvNKsnIaC1zPKBduNp+6Q17UuIX
	Dq2k2PpY9z6Br6EhaAQDzq9bBGtwiVpDEMxFpsohnD4czlzsNmwUP/aT74RyWehIf7tzrCHr/pioQ
	+Tx/AIuidUUnBJd1TTES2vO9utsPWLYt3rbe9Dol7a5XBBgPX2rExf9JKy/E0zFyvd0OtbZGMv1bE
	RpCYuvzL4kvDk7mHnDbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obp11-005cL2-CV; Fri, 23 Sep 2022 20:11:15 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obp0y-005cKN-Bl
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 20:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UKGkJSDEegt6Km6YnASFgTL/rZgzcY69GV8aEjSrBsw=; b=Uk3BJ2VHv+0S4jWHSA/rtq3PWC
	Zj9PsoIM/Z7XnRTaL5ne1xXzusxv8rr55DkC1OmoHUwIWkaZ+Jpepoglgn0v3hyI2SvBzpQQPB7/I
	pOzSUqMPA2jHYvbYN7r7oL1saGjNZNZxZZl/Qa9MxLkY2XbnIcupaFB9+/ymV/qcrL0ambaJlozZA
	iz9rqIPUWbtwxVNqkUFYgqxw8Tw3cB3ChEfoRI9T2u9bJwQnnupTD5u0NfCsylJQb8zJCg5sMGt3b
	O2XS16tx23f40e3Qwgn5Q7E+PItgegCw2qWKbMcuoZvBT0Rtwht0AGeyszOrU2alxd7kuxnWVCgDG
	7MWeKj5w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1obp0t-008yJz-3Q; Fri, 23 Sep 2022 14:11:09 -0600
Message-ID: <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
Date: Fri, 23 Sep 2022 14:11:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com> <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_131112_433295_F37B2768 
X-CRM114-Status: GOOD (  23.25  )
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



On 2022-09-23 13:53, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> I'm encouraging Dan to work on better infrastructure in pgmap core
> because every pgmap implementation has this issue currently.
> 
> For that reason it is probably not so relavent to this series.
> 
> Perhaps just clarify in the commit message that the FOLL_LONGTERM
> restriction is to copy DAX until the pgmap page refcounts are fixed.

Ok, I'll add that note.

Per the fix for the try_grab_page(), to me it doesn't fit well in 
try_grab_page() without doing a bunch of cleanup to change the
error handling, and the same would have to be added to try_grab_folio().
So I think it's better to leave it where it was, but move it below the 
respective grab calls. Does the incremental patch below look correct?

I am confused about what happens if neither FOLL_PIN or FOLL_GET 
are set (which the documentation for try_grab_x() says is possible, but
other documentation suggests that FOLL_GET is automatically set). 
In which case it'd be impossible to do the check if we can't 
access the page.

I'm assuming that seeing there are other accesses to the page in these
two instances of try_grab_x() that these spots will always have FOLL_GET
or  FOLL_PIN set and thus this isn't an issue. Another reason not
to push the check into try_grab_x().

Logan

--

diff --git a/mm/gup.c b/mm/gup.c
index 108848b67f6f..f05ba3e8e29a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -601,12 +601,6 @@ static struct page *follow_page_pte(struct vm_area_struct >
                goto out;
        }
 
-       if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
-                    is_pci_p2pdma_page(page))) {
-               page = ERR_PTR(-EREMOTEIO);
-               goto out;
-       }
-
        VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
                       !PageAnonExclusive(page), page);
 
@@ -615,6 +609,13 @@ static struct page *follow_page_pte(struct vm_area_struct >
                page = ERR_PTR(-ENOMEM);
                goto out;
        }
+
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page_folio(page), 1, flags);
+               page = ERR_PTR(-EREMOTEIO);
+               goto out;
+       }
+
        /*
         * We need to make the page accessible if and only if we are going
         * to access its content (the FOLL_PIN case).  Please see
@@ -2392,14 +2393,16 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr,>
                VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
                page = pte_page(pte);
 
-               if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
-                            is_pci_p2pdma_page(page)))
-                       goto pte_unmap;
-
                folio = try_grab_folio(page, 1, flags);
                if (!folio)
                        goto pte_unmap;
 
+               if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
+                            is_pci_p2pdma_page(page))) {
+                       gup_put_folio(folio, 1, flags);
+                       goto pte_unmap;
+               }
+
                if (unlikely(page_is_secretmem(page))) {
                        gup_put_folio(folio, 1, flags);
                        goto pte_unmap;

