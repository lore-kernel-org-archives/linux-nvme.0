Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC35C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kYxoa2A/VZYlmBEZXrShkN4p1jEZ2X0IG3XKqdZvMjc=; b=4gjLU7mTktBZPJ
	l0Q4+mG9lUV+sPVsKKZ++Sjo3jUpB4GHCfmBBdzJdlfKRXCgkGNlUYNyqyXyLUoVqredV87YagSh0
	BQoEHu95XP2dIEV+RT2uZz1n+0cm2A16ZcLAkHONsvts3LqNWLcZ4EnnRx3zX/5FbxBmEj9IHI6Oa
	muQamTy+OC8sWIQ7tvavHp0QpwCFm8YtGfbr/nRfp6w1YPLpg6dB5sSMiyIP0hx1l1eS7UqGVx2PH
	idUjzsP7wwffZX/1gxAigj910UmqEBxb506rGrc0+R5numRlVnWU76YFD2tv4dZFfAr/8TW9fBn/9
	JbAzcmG6EHTFRGnzFfpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrfv-005uvj-OC; Fri, 23 Sep 2022 23:01:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrft-005uvK-9z
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 23:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=kYxoa2A/VZYlmBEZXrShkN4p1jEZ2X0IG3XKqdZvMjc=; b=CGuPbm2GwPARkaL7H/tXPpvFFf
	UO64LxTPr0c+nRXbxMvb+qs/0Q4O0/BLxYyvU37C1j66pglYKB/XBmmbDukfuiAcY8kZz4RkDiDaR
	/xQNlnahak1tJ/MMIghDuE0H+CSB6ZX4vWT2i1x1HZhUR4r7hguNKtemm+qUwhRdOW15tICpUwg8q
	liudeqcL9JCPmsukgrQFCY0gMzjqU5nS5lhlX79x8HgsJ8JrgvPdbcllDxCNsWa0dLXQgX5VXLPDh
	JTRArRNjIdukkPz1/dfGue8Vu+o0ozOI6vcE2uXmqidCQSCam3/bLHQyGTaXDeZfFwYVKaEh19mte
	Gv8jsZbQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1obrfq-0090QR-Q4; Fri, 23 Sep 2022 17:01:35 -0600
Message-ID: <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
Date: Fri, 23 Sep 2022 17:01:26 -0600
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
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy46KbD/PvhaHA6X@ziepe.ca>
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
X-CRM114-CacheID: sfid-20220923_160137_380335_C19200DB 
X-CRM114-Status: GOOD (  16.84  )
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




On 2022-09-23 16:58, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-09-23 13:53, Jason Gunthorpe wrote:
>>> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
>>> I'm encouraging Dan to work on better infrastructure in pgmap core
>>> because every pgmap implementation has this issue currently.
>>>
>>> For that reason it is probably not so relavent to this series.
>>>
>>> Perhaps just clarify in the commit message that the FOLL_LONGTERM
>>> restriction is to copy DAX until the pgmap page refcounts are fixed.
>>
>> Ok, I'll add that note.
>>
>> Per the fix for the try_grab_page(), to me it doesn't fit well in 
>> try_grab_page() without doing a bunch of cleanup to change the
>> error handling, and the same would have to be added to try_grab_folio().
>> So I think it's better to leave it where it was, but move it below the 
>> respective grab calls. Does the incremental patch below look correct?
> 
> Oh? I was thinking of just a very simple thing:

Really would like it to return -EREMOTEIO instead of -ENOMEM as that's the
error used for bad P2PDMA page everywhere.

Plus the concern that some of the callsites of try_grab_page() might not have
a get or a pin and thus it's not safe which was the whole point of the change
anyway.

Plus we have to do the same for try_grab_folio().

Logan

