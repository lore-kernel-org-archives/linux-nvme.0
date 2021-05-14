Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B2EC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:31:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9F061454
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9F061454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3pzntkVtHyqNNMV0FwaoyWDcr66pwWyXj6O3NcQ7Zl4=; b=S8qMTNwQApLnYeYAn8whtwhP6
	QRnPSNbKhvzHHB05xac6bRvtVd/cLR7MyCikGb38aqjKPO6LFxFsxCoV7hgXg9UiFT3LiDbwNkAjN
	oIDyNT65mIxzrDFMD5keD2KqGPyQWJ6AOqEmJGmcIPzXJIqCvT8u665WRqxqbTqJYz3aom3Z2GSvn
	su0VVq3EKlJw4r/XWRllr92712/lyWcuPIQq8ECVE0MXHmXWKVswIpaM1dZ/oJ9zkGKvMGVVzMPBs
	ldBGUFYVeBLELp8bgL/EYE2WaWfO2XpKfu012vYDBBHifMAB2BanY4qCYN9pqsGhpUnTJX2n3nk7L
	iJXrMD3sg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhai1-008Uzp-3k; Fri, 14 May 2021 16:30:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhahy-008UzX-7J
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=xV6ltS4lNS3Jm/f8TEnktWg1U1xW+UrFzR8b6RAQyww=; b=hnisRkMnMjlDI6FnicPiY/YDFi
 IU955AmISk/+PHs+p6akHTyaN8yTYmi35GEyCizalDI/QQc1XGdklFEaNbt7QPkBmlnvqFvnxs9Qf
 wwR0+VHv71g6f/qu4ob15EvcdHuAYYprtmLI6sbr1+9BkMFVZ5oLNapJhfxsPzaA0UWxFUH3x7rrk
 NDTkbrKnADI4He/+aFwclB1puhBPJTYvQwzKgYrTrYVzaMW5oxb7nRJHEWmpfAU0U4unwU/WMnDVq
 glCE02gQWgld9m8QnE3ZoKkjNl4uKQmGp5tbmze4Fkbg7Wcbg6ZSQfMs4VZI6bV9zgIlzpJ3NOSRM
 CDIVPYQA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhahv-00C7Nt-Py
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=xV6ltS4lNS3Jm/f8TEnktWg1U1xW+UrFzR8b6RAQyww=; b=s//zBlCpwgQ1lLSn3XKJEQOaWd
 rI8rRBGrF3aoC3g+QuDXDug4GzbnkaS6nBtWhDM3pUOjQYKZYx/6iqfRigkJyI290iga8e7o+co0E
 QbXpFJsOWAQw7fOVJWNVDxDk/PaOaE0YGfRnol4IiEjPWjENwy9CRw8DjR6tZ+WmbEC0OTj1tjMV/
 /DRMXbA8j4LTuFwWSHMlTxZaa7XowzY/YiYS5R+3nywlL9wmmsoR+uFEzvV5+oIlKCVP0Tyx8aJlM
 CWWYGc4JPwElN6+U10s+whCtXjoZyIVemlp2K/nOQSPMyhE1NnQR98UkoaVAkuMTzmLnP7RlAicuB
 8O/5DBLg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhahm-0006Ih-Qz; Fri, 14 May 2021 10:30:27 -0600
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
 <20210514140007.GE4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91ce86db-e2f9-85ac-12db-91df72ac4648@deltatee.com>
Date: Fri, 14 May 2021 10:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514140007.GE4715@lst.de>
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
Subject: Re: [PATCH v2 00/22] Add new DMA mapping operation for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_093035_853855_8E640EC4 
X-CRM114-Status: GOOD (  15.71  )
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



On 2021-05-14 8:00 a.m., Christoph Hellwig wrote:
> On Thu, May 13, 2021 at 04:31:41PM -0600, Logan Gunthorpe wrote:
>>  17 files changed, 570 insertions(+), 290 deletions(-)
> 
> I'm a little worried about all this extra code for no new functionality
> at all.

Yes, this series is really just prep work for allowing new
functionality. And a bunch of cleanup has been tacked onto it. It should
make adding P2PDMA in userspace a lot easier and I expect other P2PDMA
use cases will be better enabled by it.

A lot of people don't like the pci_p2pdma_map_sg() special case and
can't use it in their use case because it only accepts homogenous SGLs.
This series gets rid of the special case and allows it to be used more
generally.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
