Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2364EC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4uxNqOBD/ogCW1O0rrQ2A0HcfFujRPCySOpF/YO01oA=; b=fDymOFVXteEDbHOPHLySDTiusP
	786MMYf/iMo7WlVUzUoNT+3M1VdykxPBWdiWJRrpyB6l3CNGAwHcmZGka5mZoxH9VVxN5xWgnxkCa
	8jHKEDV+B7/bjdscI4DVsuYyqU9fOPX/LtVt7J+9wcoNAK6LQhsD6yqrdj8i1dQffrYx6+lmzC343
	2Tw4CZya16N8oM9EQJ3SvLx+MUTRkUVSAZzwpbXVzm3UobleyD0AUjOIOLOWCS2xX8QvpxCWVAm6d
	1UDqE0QSf6AEnsWw+jjNF0Xlabai6Lw4zHlyYg2BLjvNDZ0XGph+jif4AXhidc+HrbZbhjmg6W0fD
	To3Q8Ozg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5r9m-0000000HZT8-07AJ;
	Fri, 18 Apr 2025 19:13:46 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ktW-0000000G5K3-3x7U
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 12:32:36 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so1583454a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744979554; x=1745584354; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4uxNqOBD/ogCW1O0rrQ2A0HcfFujRPCySOpF/YO01oA=;
        b=Jk7zLqaSlWsckTwglwGr0m69z7RHqLRNBZOVayavNOzg+x6gl7h+FnCRNkITQ4+qRr
         U+Y/L/QT3UutGcZil+zWTF6Lce9z4Cd/VFQreL9qP8Cp4jyJ+L+Q28ZehCHyr1vmQO97
         PC0/wfwgvxI7XCu7cBmougzJOsTvDvoExY9/wdebzDWjFtvhTVZR5bfogRtO3uVUxDJ9
         oLQMbfR8PBXQjSLFHMQXC+iykw+jTGPclg0YO9Ts7i7CwjXhAKaWsYsNvflbcdCIY5Wn
         woajq89Obn4e0va0VWYrBc8aQm2LkztNUR+So3DVg1gknEhFbyIuQm2dP0Wu3gcmPaty
         shXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979554; x=1745584354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uxNqOBD/ogCW1O0rrQ2A0HcfFujRPCySOpF/YO01oA=;
        b=TsB/DvKmzokyifh25i7l0wK0Gijrinds4xktaMeXj86dfJBuq+NZdF/2/SUC1SLh52
         5chkHeMHAbk2Gkybar75Z2My1xsgo6dAhXoQxhAe9GeDC1wgGZOZ45zhKsYN2QVpngSl
         tQjdVGWoFVczMOiKFAgZb1hEPM2HxqSRURZIFUhu0yTrnmEo4DkyhE6AxrQtxxouVpob
         8K115021KwilMdvtxwmGGLs8mlY6zmFt75VGy0OCqnF/GYJ92c8FlW3LdyKu4R5UA8Gr
         ChDt/rhAnTHGRY0k7QabBXmYEIDJjd95F1u7UfIaE0LDqdSi87pMA4YwBBnQWk/k8OyQ
         EWtg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSeUBFoZFbUjRIHKdYq3hgjS4UD8JnnlMf3AJ/j41Tnh7NtQsYqIquEWw9UtDnkpn5/r7c0Eh1iwk@lists.infradead.org
X-Gm-Message-State: AOJu0YxcPo/bST/7d4RlRDF68XrR6r8MxmNftgFlAR6p/lYRHIASGM9+
	1mzwo65P8xd00I0WJX6hgvo4gzRJoyjbl/w+SPbne7al6McHJ8PKLoo62S7+nXKNsffKmZEjKf4
	/chP/2ZxcGm+1/8CeW+6BMU8Acuo=
X-Gm-Gg: ASbGncseEGajo+TdDKFJlAt12yX+0FznWX7Cp6EPfYZxZhoiQ2l9l1T8bv8yOtwxtoh
	UaLjyJOwaQkT1OWpO+XQuU0oLuVjYloci4Bxsbhs6ZXEW7ZG7yeloYccL1fhFtobwAUJnG8kuud
	n7QLv35O9k6lHUGkFXDtEzoGvnli/wYPCNmeAFNhwkb9/ktSDtdhAC/uNL
X-Google-Smtp-Source: AGHT+IE6KPLtDnTScFEtJJlvCdwmMFGgLV6Sh+PZ7MHmYiMb3jtvP1cSpc1ynbu9LO+7GJYkCunnvOZCbjH4BPDTV0s=
X-Received: by 2002:a17:90b:2e03:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-3087bb6f117mr4849982a91.18.1744979553652; Fri, 18 Apr 2025
 05:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744825142.git.leon@kernel.org> <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
 <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
In-Reply-To: <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 18 Apr 2025 18:02:08 +0530
X-Gm-Features: ATxdqUGyYBEsfK-IN2nZn9q0XDVh1xSRZINsNgbIk6fSYXOiPXAs6WAhmbL1EUw
Message-ID: <CA+1E3r+9kEs-fqND-VD+y6FWfiGqr1vN8M0GufD3oHdwLdFcrQ@mail.gmail.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, vishak.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_053234_981082_B2665AE2 
X-CRM114-Status: GOOD (  13.94  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

> > +     if (nr_segments == 1 && (iod->flags & IOD_SINGLE_SEGMENT)) {
>
> nvme_pci_setup_prps() calls nvme_try_setup_prp_simple() which sets
> IOD_SINGLE_SEGMENT if and only if the req has a single phys segment. So why do
> you need to count the segments again here ? Looking at the flag only should be
> enough, no ?

Yes, the flag will be enough.
I started with nr_segments first, but felt the need of a flag when I
reached to handle the unmap part.

This can be changed if the series requires an iteration.
Or I can do this as part of the cleanup which I anyway need to do to
replace the "iod->aborted" field with a flag.

-- 
Kanchan

