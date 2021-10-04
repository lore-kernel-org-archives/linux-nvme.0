Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE90C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:28:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD2461153
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BD2461153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bqguL1kY2ymgqDhx/BeuubflVfskmCda8KA2Bo8IYLA=; b=w9dTmHtHgg+0SE
	tUTXXy7Fe/9Q7Wmpq5s7YbQAO0HhBbI9htmkNG5yX/Snwzta+3VYnkjo7lhR4JWvb7BohoKppfhnq
	yGT1vmpEPJGX4HUmSIsub9XlbjULyMs7u6JyO2ehAi+z693EZ5/wyyy9gvaQf3pW1r2COe/aNg7Z2
	cRrudv/IpIazDkRoYMHE7Q2tcSfoex+ozL+hyAT5WwDfd7KBxwyCnUlyEXvsdVC9fU6lso5L3onJB
	OBC/cXX0IN8eXkLJuC8qWCqiD6sLqMPvuHAZpcZULmsmbp0N4U6YEAT2uisTiJB5Sq3d3eHq/N1CU
	pRl9u29GMwCIMsE4951A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXO0i-006f74-Eo; Mon, 04 Oct 2021 13:28:04 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXO0f-006f5q-TX
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 13:28:03 +0000
Received: by mail-qt1-x829.google.com with SMTP id d8so5624066qtd.5
 for <linux-nvme@lists.infradead.org>; Mon, 04 Oct 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
 b=iDoHZmkGlGlOGmyIALhCRv5d0FGVqcyqzKnkCSrwDERdEycsj9nKdyI4CDCY7dUkfu
 xidxgyjRN5kfHIRBmzvXWUYCVWONcmsNAfVlEJPerQ36OixcgdNf6z6xIX+i983wIGxX
 Fm+2zsmQUKlte1RY1Yvt03JDL8dJLW8PrakA/6MUOUbzXeejqw51g5Eeeoks+5BR2RWt
 8H1t/KDZUmwt+6LpGInv6V0CGPBr9+/eJziRGIauTdgjFf1nuaO3lqEPw168Nple9yyR
 oLcnT0bAheHnXc8spN7mnErr+Hx9iaPz3jI3W/1sr1SvZCmQMtgwq+8Jx3uPm4zXeBnI
 0JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
 b=Y/dZAsuaRtqVM47HoUfmn7i2eEwmJ8FDqh5U0qbYn5Fdk+KdW45bLE5T60uEl0OBXt
 lAOnzhNzimwxlhByqymTuQ75Rb1Y6mM+kcaTSHG1thGWJjiNZVtq+wmBCBFhPJqaWBYe
 iRnRqpmxWxWNbCYlVYmwfZz4juGa0ufYTlYa2K5RFiHxV262R4EucxoE1uRNr/QhjdHV
 e9eWQQf6AxVkST1u79cN1YM1VLpb0otyUDxCtu6Fu4/IrlGQ9kq6uRvWNjJVM0Fxw9X+
 vI9p47omi1M6YXSp0FpGDUMr6DZ/JCbzxbox0V1QXX5TACsWhua+NF3hOXUbqc1Uq/e0
 6kXw==
X-Gm-Message-State: AOAM530hlnMEegCf6rKecDnJRW81RMxkSBhyO5S7yAgrJt6V0UrO246Y
 WWUVA/63mUq7qLi3/JjJYlCUCA==
X-Google-Smtp-Source: ABdhPJxtUT/KaZLX4EROxMBuImUPAmVtvIoSFGbrT35tFwl+26IbFnsgo9cxZTq9rMwrEpHPo9O3KQ==
X-Received: by 2002:ac8:564d:: with SMTP id 13mr13726534qtt.228.1633354080469; 
 Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id 205sm7652317qkf.19.2021.10.04.06.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mXO0d-00ATnh-F3; Mon, 04 Oct 2021 10:27:59 -0300
Date: Mon, 4 Oct 2021 10:27:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
 Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>,
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211004132759.GX3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
 <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_062801_993900_F77D250E 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBPY3QgMDQsIDIwMjEgYXQgMDM6MjI6MjJQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKCj4gVGhhdCB1c2UgY2FzZSBpcyBjb21wbGV0ZWx5IHVucmVsYXRlZCB0byBHVVAg
YW5kIHdoZW4gdGhpcyBkb2Vzbid0IHdvcmsgd2UKPiBoYXZlIHF1aXRlIGEgcHJvYmxlbS4KCk15
IHJlYWQgaXMgdGhhdCB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgZ3VhcmVudGVlcyB0aGUgcGh5c2lj
YWwgVExCCmhhcmR3YXJlIGlzIHNlcmlhbGl6ZWQgYWNyb3NzIGFsbCBDUFVzIHVwb24gcmV0dXJu
LgoKSXQgYWxzbyBndWFyZW50ZWVzIEdVUCBzbG93IGlzIHNlcmlhbGl6ZWQgZHVlIHRvIHRoZSBw
YWdlIHRhYmxlCnNwaW5sb2Nrcy4KCkphc29uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
