Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B4CC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VOh9QcFEDE1YfzcxWIGp+1k7f+qP9ixR08UnNbWnKpc=; b=M0TisJEcQTUsnT
	74CNKHrMIkGLw0gGAEkeXWzN5yavAx8Qc4khzLyLDXgjvCuI/CAa+kHk+e1TkFCmIRpBXtpBu3dtG
	B01s3Iiv3yk4IpGvMh7Qt4Tdclfh3wP+rDaY2MZiyhyuJcMdqns8+4nCHbpZo/rImrL5TYy3OYy0d
	bH2Q9uROYECZiH46xeFTNpEA8FgxSrU2LdPkPN6f8KWaDYXAQoF+k4+Ggf2/UZHsLocmXv9oe5w2S
	PWWVOJfSY4tKtnLANkwZrNLU3giHlIMcbHSUSR4meNfLl7AtwuQ3H7AsVRvIyAsG55StTWH6YWL9B
	jWRQvDRMuvzt434APyeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odela-000SWE-6b; Wed, 28 Sep 2022 21:38:54 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odelW-000SUp-KW
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 21:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VOh9QcFEDE1YfzcxWIGp+1k7f+qP9ixR08UnNbWnKpc=; b=mOBFIK5m8mLy4ywi3FVTK4mL6V
	oj75zw9aDB26C9Y6E3q3Zh+2OVl0EQqV4erRsyOn6/kj0Tt8zleEZbtbluaojd3dKCXarw1p0vw2N
	Mjm+cJscVTFtRI6ZPBK1NMDtmJ37SkFDwrsyizQWmLDPIffvRJnH6j1msXmitMEuUo/Vnmp2R1D4p
	3eeslAUPK9oaVUW/PBgxclT7nvMxXVf6RSS/t7hKvCFdGuk4mom65QCMpDVM/oB2p4534U7GPMsT2
	IrYHvtiO2s/gVPnZi67xksWEgfLmwrPbCcD3YWEry/HYu/+x3cwqtiiEiJwyJj2kiqcaFXQ9u2+sd
	n5FHDhcw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1odelP-00D1s7-Da; Wed, 28 Sep 2022 15:38:44 -0600
Message-ID: <a375f380-b153-bdfe-1822-c6d8b1668c64@deltatee.com>
Date: Wed, 28 Sep 2022 15:38:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
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
References: <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
 <Yy48GPMdQS/pzNSa@ziepe.ca>
 <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
 <Yy4/f+s1jOCm7dFo@ziepe.ca>
 <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
 <YzIuSsFpOC+VN1/P@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YzIuSsFpOC+VN1/P@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_143850_766928_BE18D32A 
X-CRM114-Status: GOOD (  27.80  )
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



On 2022-09-26 16:57, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 05:51:49PM -0600, Logan Gunthorpe wrote:
>> Userspace code that's written for purpose can look at the EREMOTEIO error
>> and tell the user something useful, if we return the correct error.
>> If we return ENOMEM in this case, that is not possible because
>> lots of things might have caused that error.
> 
> That is reasonable, but I'd still prefer to see it done more
> centrally.
> 
> I mean the way the code is structured is at the top of the call chain
> the PIN/GET/0 is decided and then the callchain is run. All the
> callsites of try_grab_page() must be safe to call under FOLL_PIN
> because their caller is making the decision what flag to use.

Ok, so I've done some auditing here.

I've convinced myself it's safe to access the page before incrementing
the reference:

 * In the try_grab_page() case it must be safe as all call sites do seem
to be called under the appropriate ptl or mmap_lock (though this is hard
to audit). It's also true that it touches the page struct in the sense
of the reference.
 * In the try_grab_folio() case there already is already a similar
FOLL_LONGTERM check in that function *before* getting the reference and
the page should be stable due to the existing gup fast guarantees.

So we don't need to do the check after we have the reference and release
it when it fails. This simplifies things.

Moving the check into try_grab_x() should be possible with some cleanup.

For try_grab_page(), there are a few call sites that WARN_ON if it
fails, assuming it cannot fail seeing the page is stable.
try_grab_page() already has a WARN_ON on failure so it appears fine to
remove the second WARN_ON and add a new failure path that doesn't WARN.

For try_grab_folio() there's one call site in follow_hugetlb_page() that
assumes success and warns on failure; but this call site only applies to
hugetlb pages which should never be P2PDMA pages (nor non-longterm pages
which is another existing failure path). So I've added a note in the
comment with a couple other conditions that should not be possible.

I expect this work is way too late for the merge window now so I'll send
v11 after the window. In the meantime, if you want to do a quick review
on the first two patches, it would speed things up if there are obvious
changes. You can see these patches on this git branch:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v11pre

Thanks,

Logan




