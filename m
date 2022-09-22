Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D6CC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lIqeYmIYKdZ39Sv7iKx98PZ/aFncvZ/B1l8HysQoIhk=; b=4zOQwiz45//88O
	m4Eqevq/jZnN6P0L6fLE9yKIrdo04BCStmg6DBc9eZFLgA1TYMrWQUhLvj73yV+3i/RU7fGIiYAYZ
	Gdd4yAFYgV6PwdnzNxJvUifAnIn8csi8KtuPEw2V2I6UxMfue/0Ns1vMbGkmwG4DAvkTnLJFzU7H+
	MLTShZ9lfrCYcC+PEnFD0R+oZU9OQoKx8xfYFq0iM0nPTKjKx2kCODfqwr/Y+vzfCau4mK/H2fNqF
	Xzpilv5xk1CtLog11pFSUbklXj7RBVW7i8bnCbc9cofTGNub+EcR+cZQmA6LS7Ap0GBd/InodVKNr
	CMdiHR7fZ43U+hMd/ccQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNqt-00GJvf-CL; Thu, 22 Sep 2022 15:10:59 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNen-00GEAD-IR
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:58:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=lIqeYmIYKdZ39Sv7iKx98PZ/aFncvZ/B1l8HysQoIhk=; b=I75dP8r9MX4OiRESuJQ15NM69H
	E7EPt6dmj1RLUSLfLdHSdQgN1mX1Mps+QUyXlvHfee+UqpkHTb6XVDmWWJmc+SsSXElXncswhSea/
	n7ClPcuX8C+GwiXwMt/bA9+YVdTDgHYaqcPfaUTSE2PgJgFZGhE5WKHVUC+x9lJkdalVuklY4Xq8n
	nEI+f/4MSCesrWAsHDl7LEYeD/yhSatwrHa4riE/CQsWfphlfqxmoZ49pmeUh05ZlrdcurIihp0za
	NSFZ6gpSHMV26d1luCPA7bAblBb7vBlDXKICtG6AtRLly1VcBQJPVRZYaHZ6jleuswBvQRteHobdp
	Z4DBeTVg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1obNef-00848L-ST; Thu, 22 Sep 2022 08:58:22 -0600
Message-ID: <0074a009-9ece-6617-b66d-d003593d153e@deltatee.com>
Date: Thu, 22 Sep 2022 08:58:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
References: <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
 <YxGad5h2Nn/Ejslc@kroah.com>
 <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
 <20220920064613.GB17325@lst.de> <Yywe9rBMB6hlUwqw@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yywe9rBMB6hlUwqw@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_075829_657365_E0421650 
X-CRM114-Status: GOOD (  16.81  )
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



On 2022-09-22 02:38, Greg Kroah-Hartman wrote:
> On Tue, Sep 20, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
>> On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
>>> See the diff at the bottom of this email. I can apply it on top of this
>>> patch, but IMO it is neither easier to follow nor maintain. Unless you 
>>> have a different suggestion...
>>
>> Greg, can you chime in on this?  Besides this item we just have a few
>> cosmetic bits left I think, and I'd really like to get the series into
>> this merge window.
>>
> 
> I don't seem to have this in my inbox at all anymore, sorry.
> 
> The original should be fine, Logan, thanks for trying to split it out a
> bit more.  So this can be taken as-is for 6.1-rc1.

Thanks Greg,

I'll send a v10 with changes from the other feedback later today.

Logan

