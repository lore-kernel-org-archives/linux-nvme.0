Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE50CCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpQK1s/pLVkE3wbH1C/ia+7421Bxt4wWUK2253L58TU=; b=WAL2zB9Jg4I4tS0LBgQVV+YCOs
	+pvIX++uadgpPOJaP1cuXiaoGh8eI4u8HnrUT2+O50KROyWxQM2nG5A1yaS8ncdgvmDeODdBMyi/z
	wjj88o1DqygvwaAbrf/Nk2TRNuYMSClnAC3uQ+HLskycbTF/7X0zOR9L2bks/LUxMp8mneyxXtuEC
	1VlfdIr7/K/eqGzsOC/Wey8NUuV/CvRSh7oU5BBtTRQr3fTkTgYzd1bcliyDR/VB8BbLqQn51mGyy
	wX9taju/rFre9/rKgZjb8L5SZsWGGqGWCKXhDuxEePnXa5P3WxtypCDO5ZN63SNsmgJJCWt3LRm4h
	cNmjErTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCJk-0000000BPm9-2mmY;
	Tue, 04 Nov 2025 08:23:04 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCJi-0000000BPkx-3C6w
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762244583; x=1793780583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIF/ykNkFRIMVMhvlAFTIDIpUW32hk5+t/M9Wz6+bQQ=;
  b=UFQh8KZptbRkFSxUA1/nnWPmZVN85sg3DCJt5lr9HIaoINqWERwIF4nt
   QjSYPL2OYdF5gNENMbb1d8klcXESvouMGibqSubCU2kieDZq/OW2YbBPv
   qhJWW6HYaEjNpv7pjaYQFUs6k/WuTS5Dn7QaIfenS8TyJBlkssqjSesvc
   ZMqpp14SfcjR/rj0zKy1OBdsWZleX1iJhqyKTf0Emp205NqfKPMjXyXZe
   gOC3rivRluRa1ppuQrNHnKvpawM/c3Yq2yZaoqCFSMTa81bvdYDUOCPPf
   xxN3Y5zY2iS2mdT5R+fCOQ4Y7SiaClTwY2rMLXP3Dmrazzsnt7+1d3ttX
   A==;
X-CSE-ConnectionGUID: trmDetc6R76buLqmwH5Zhw==
X-CSE-MsgGUID: QHCOVXysRk+Aetft8inirA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67987637"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="67987637"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:23:02 -0800
X-CSE-ConnectionGUID: vWdR5/+sQb+P/zt3KyKAbQ==
X-CSE-MsgGUID: GvGvYjO4RBmLtMYACn0KcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191406230"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:22:58 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGCJb-00000005P7y-1jmY;
	Tue, 04 Nov 2025 10:22:55 +0200
Date: Tue, 4 Nov 2025 10:22:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>, ebiggers@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
	idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, home7438072@gmail.com,
	linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <aQm333UwRAv0c4d3@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251103172739.fd799d3df4edc014429babc5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103172739.fd799d3df4edc014429babc5@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_002302_838718_5E7EC8CA 
X-CRM114-Status: GOOD (  12.42  )
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

On Mon, Nov 03, 2025 at 05:27:39PM -0800, Andrew Morton wrote:
> On Mon, 3 Nov 2025 19:07:24 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > Since I believe many people test and care about W=1 builds, I think we
> > need to find another way to avoid this warning? Perhaps we could
> > consider what you suggested:
> 
> I'll drop the v4 series from mm.git, thanks.

Thanks! I haven't got yet a newest Linux Next, but I think tomorrow it will be
okay for sure.

-- 
With Best Regards,
Andy Shevchenko



