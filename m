Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA800ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mn3VERy0s8rwu2J3nmnzKseb1Xv+6b55gPqcv2R29Do=; b=D3fDYfUjtA9o+X
	zNc6hRzlX95hkj9BfR0kmTanLbbA0+Z8jgQw0AAqogiA1SmDWhVMAIrI4Y0obTYOh772JmG+q4rPL
	3fSxNQtOfMg9mkNqPZw8xEbOP6dw/8GgJAJQ/Tx/wo0fM1sLa13l5cZ9FonCO0COgA7oxrxBi1EWD
	OqCEchXlHw4H6EHHhqXw75X6pXUmwc2GO7Qt6mEi4xJVvePvZCFyFsjXeJWhpBnOHwkInjTTuAqcC
	4HCWGYwnjoc9AYTmn+AXwt5DLZ1peYdyoxBArst+7Av20Pv6/uLc+Scl18ZH+GQX7VctUkHdO7vfy
	fwvXUVFpNaEbXW2T6+LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTpga-00EBb7-Fr; Thu, 01 Sep 2022 19:17:08 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTpgX-00EBYa-LU
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 19:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=mn3VERy0s8rwu2J3nmnzKseb1Xv+6b55gPqcv2R29Do=; b=YzaqHznkMBYAnCSOLqSHdegCox
	YKGC4eoem9/8GT5zgWrOSDaNjktJxP8yRvpJYQxa1Z8TVgSJMiKxRYBzMwVpxfst2k9K0nTOV1HBS
	g+ph5690L3SgBn1e1YgO7JjiEYivUW+H3wpACNHc9roxwPBpKqP9k77Y82r0mkv/FNfPaaPUHfTvB
	p4qZfGw6uCBlrSY263wg1z6zYHA/Re3+5UA8DJ6RvGYmERMmO74bYgDyuhsaCDe3OouNe43APnOcv
	6drCz4JVkp2sBvXA1RP/eGJ/WdeAGxetZaWgUxT+1aOmV3OaCU44xJq4EEu+L4J8FIFcXmhtYUgpU
	1D7gy7Vw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oTpgS-00Dx2S-Se; Thu, 01 Sep 2022 13:17:01 -0600
Message-ID: <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
Date: Thu, 1 Sep 2022 13:16:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxD7uZYaV75gJS9d@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_121705_737429_18C644BD 
X-CRM114-Status: GOOD (  19.99  )
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



On 2022-09-01 12:36, Greg Kroah-Hartman wrote:
> On Thu, Sep 01, 2022 at 12:14:25PM -0600, Logan Gunthorpe wrote:
>> Well we haven't plugged in a remove call into p2pdma, that would be more
>> work and more interfaces touching the PCI code. Note: this code isn't a
>> driver but a set of PCI helpers available to other PCI drivers.
>> Everything that's setup is using the devm interfaces and gets torn down
>> with the same. So I don't really see the benefit of making the change
>> you propose.
> 
> The issue is the classic one with the devm helpers.  They do not lend
> themselves to resource management issues that require ordering or other
> sort of dependencies.  Please do not use them here, just put in a remove
> callback as you eventually will need it anyway, as you have a strong
> requirement for what gets freed when, and the devm api does not provide
> for that well.

This surprises me. Can you elaborate on this classic issue?

I've definitely seen uses of devm that expect the calls will be torn
down in reverse order they are added. The existing p2pdma code will
certainly fail quite significantly if a devm_kzalloc() releases its
memory before the devm_memmap_pages() cleans up. There's also already an
action that is used to cleanup before the last devm_kzalloc() call
happens. If ordering is not guaranteed, then devm seems fairly broken
and unusable and I'd have to drop all uses from this code and go back to
the error prone method. Also what's the point of
devm_add_action_or_reset() if it doesn't guarantee the ordering or the
release?

But if it's that important I can make the change to these patches for v10.

Logan

