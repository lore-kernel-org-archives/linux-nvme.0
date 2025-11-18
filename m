Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87396CED27B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mO0382qH2jBNLd3h79dRjTyTIqnqLvgdnKrZ1v2Wh5c=; b=BJNu+4bjPvveeGYt7x+IwJjRBd
	hn2MOdIviDJblHuKamzjFwJ3YTXBq8a3dTKmvtsg9F/S8vq/SBdAmgsr59fpvemuz6YBa8z1Y5Itk
	MUE6eLjo493i0Xe7TwhMe3eHauhmtCx7ZsYldg7HLlpacXg4EkFU0yOCMr4/lnA0nxvWMGfxljMuN
	3KWZkRz3MDJwbIqDEucJPDYUuDDOzJzMh3E1qrxc9J9nUCuCVb4puVTC3jFfLXffs7xHo9sIB7KfA
	CLG9qCgm5AR6xAOq/xVUTiNEHTd2q+qVW7ghV75qa8lUebEAjsVylCyw3yPCtPfYFM3h2Jh5u9Nxe
	Zae2bEUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLJ6t-00000000GEh-3RVT;
	Tue, 18 Nov 2025 10:38:55 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLJ6r-00000000GCg-16nf
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 10:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763462334; x=1794998334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iyd3lOPVc6CcM+zX3Th+vnH061kObST/SiMYoPr5O5o=;
  b=TIS/CabmL/CSi78BioZtUvduzZLq/4R4WSQQXNyEyQTs8xKXsvvdJ9ER
   HHzLcIINwvld1Y+iXEKL83Jif+QuouyyVHqFrk2LD/fShFz48elhCJ13C
   9Jimu98+JLJua3vJ027tkSjKNtDyNZkEuYGeDUL/sGKhtexn6uT2T9JZ1
   R+fQBpwIjRmXKeV/Sc/XHI5AGzhkaTRjEFXI2AJEWNa8WiASXvG4lzyDg
   Ic65vtHC9xpkmwY0E7CvKWQesnP/kyxMmlmuPQ9kiCP2XUSB9pr4/rq2h
   pzv4q40XvsmaujPwYo1KC4r/n0PZ90+pWZhf3UY2deaCggt5Rb7vXODid
   Q==;
X-CSE-ConnectionGUID: fxuzBrstS/iMR/Z1GJjqAQ==
X-CSE-MsgGUID: AyqM5a7aTCGD7t83XjBydg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69097117"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69097117"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:38:51 -0800
X-CSE-ConnectionGUID: 3+5y3f4oSPCBezs0UuP3sw==
X-CSE-MsgGUID: T0VmNn06S/m1gpEJLK3+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214114335"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2025 02:38:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3C33D96; Tue, 18 Nov 2025 11:38:46 +0100 (CET)
Date: Tue, 18 Nov 2025 11:38:46 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	David Laight <david.laight.linux@gmail.com>, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <aRxMtmatG7wbqJKL@black.igk.intel.com>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
 <20251114060132.89279-1-409411716@gms.tku.edu.tw>
 <20251114091830.5325eed3@pumpkin>
 <aRmnYTHmfPi1lyix@wu-Pro-E500-G6-WS720T>
 <20251117094652.b04c6cf841d6426f70f23d22@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117094652.b04c6cf841d6426f70f23d22@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_023853_361347_F8BF5A25 
X-CRM114-Status: GOOD (  15.17  )
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

On Mon, Nov 17, 2025 at 09:46:52AM -0800, Andrew Morton wrote:
> On Sun, 16 Nov 2025 18:28:49 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > > Reviewed-by: David Laight <david.laight.linux@gmail.com>
> > > 
> > > But see minor nit below.
> > 
> > Hi David,
> > 
> > Thanks for the review and for pointing this out.
> > 
> > Andrew, would it be possible for you to fold this small change 
> > (removing the redundant casts) directly when updating the patch?
> > If that’s not convenient, I can resend an updated version of the
> > series instead. 
> 
> Sure, I added this:

The file also needs to fix the kernel-doc

$ scripts/kernel-doc -none -v -Wall lib/base64.c
Warning: lib/base64.c:24 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Initialize the base64 reverse mapping for a single character
Warning: lib/base64.c:36 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Recursive macros to generate multiple Base64 reverse mapping table entries.
Info: lib/base64.c:67 Scanning doc for function base64_encode
Info: lib/base64.c:119 Scanning doc for function base64_decode


-- 
With Best Regards,
Andy Shevchenko



