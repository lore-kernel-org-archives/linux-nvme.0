Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B5C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:26:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97DD6135F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97DD6135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uqaox9OwjlBLRxUyj3SC6JBWLWGShKqxIIPuk2ZYtpE=; b=TZROEQTZ3q9Vc969w3r9Wfysz
	+dfD08wZ+eaJmBU8zsVDPzKIW5qaMSxQE2qxLKQduYM7PYaCJrauFj+qczmfUYxM5Wb9tCRNJSgA2
	5dENMLXbGrtlgFz6jCslu/osTvRJxP+1BOhtoamdHlBlRoPqekNXTFlGvmn56LF0ybFjWF78riPoq
	P8RFhzLAkWvwzP4IEzL/1bexvWe6YNia8wg/tGBtJllrTDZc1GSFeaMque8IE8u4MksDEAOV3MYYh
	+5/c/R53YO2hDhertkFYSiU21zM7XkNSmIPlfMQa55QsKdgPflKVXzbrn/3aRDe09mDQVP/wNtqXh
	jVXa53lxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddGY-00Eb7t-6z; Mon, 03 May 2021 18:25:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddGU-00Eb7c-67
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=cYF+eNW2SZu4FLOwYbv/+kuYPVYfUi+RRus6Kk2q7N4=; b=DVdrU/TPWQSAole2ZHBtAfoTUN
 4InGQ3tMKPOkutLNcZ3OZRp/Pjk6XuzREHxHCIpiSi9/nGfcDqDHpQiN6jgFh1b5ptZtRvMuBP00+
 XZQGePbKsDY4UkdeHEjHZwgRSn1QMEH5mZxHXxL+/qwevYW9x1E2Fdb/pEgEqqPmr9UM5EWpgrBE+
 md/WiIvdySZpsfPFecPogX5YPkBCU46bgICAaKmNKY/1ljT0FyHB9erDm2Ix54j5Pzkbl7fBSzMj9
 HcPYaUfOzUvwKGHhP0I2vvCqiTqqdm9FUzOG+KKi9WPV1X8NdsThW/tOLDwmcJMIvMPuUOAO4TCAr
 vDn83M6w==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddGR-003OTJ-BW
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:25:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4F8B568BEB; Mon,  3 May 2021 20:25:49 +0200 (CEST)
Date: Mon, 3 May 2021 20:25:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
Message-ID: <20210503182548.GB17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
 <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_112551_559804_AA6814B9 
X-CRM114-Status: GOOD (  11.54  )
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

On Mon, May 03, 2021 at 10:08:34AM -0600, Logan Gunthorpe wrote:
> Per above, I think the reference count is unnecessary. But I could wrap
> it in a static function for clarity. (There's no reason to export this
> function).

A well documented helper function would really help to improve the
code for the casual reader I think.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
