Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609E1C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kdi3DSPc/O+C8A9e2zv3rCFIPzltKhrlzZn7ufqHIaM=; b=VQi2meTnTBEejRwL8Im/MdRe5U
	D/6TNItUl4lcU2Rk+W9T7N7kdlrFKXo6g0fJWH9tFzzHLD/fIiSuUn/N4ZWOJ9gn8YMK5RClQgj1l
	2i9f4ag0jv/d2jrPCj8hxMzyQ3ujsbsBMIxB5enwRBMgzrWmNPITmM+JClSRwiGseR0lyPyN+B9yl
	2/hhaSdGa6JyHj386ej3KmOj5ytSYntvrEeCnsCnBnxq0zcWDCLECfEWvFxo2Oe1mc9nWRuyeWKxs
	oUTNel9/9OAF5NObhOyj5YUPjMxOwmTD5jTybqyYrLlw2ZvBIcoVCid7tJIcLB6/YG7Jah2F7MPbg
	IaS6IsSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0oV7-00000008CUR-1mHH;
	Sun, 30 Aug 2026 22:59:45 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0oV5-00000008CU5-1W1G
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:59:44 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2559723a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788130782; x=1788735582; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kdi3DSPc/O+C8A9e2zv3rCFIPzltKhrlzZn7ufqHIaM=;
        b=abbz2e7mxAkBLx1cJWXfM3X4DsF49v5OnjI6QUDT2B0xzQHI9eNEirautS+fXDOvmx
         AmEYc403J/I1cGODNuRbrq6pZFKyk0rMIHI7VURV3M984Nmz09cSOQ+n9pByGff4soRt
         yyHz8C5i6tZ2lv/Dz6OdBxBldTlJ5UTxt9R4rzKRkuXrPsrOfYDUm1eDu+rVg2K8PIFu
         yMJEKus34NugpRFaafwBSXlj1Qu9uvHOIXpA7IRAfHFgcMHUKUaDxKXdCB91I4NjwCKR
         MMvnATd7bIqHcAqMcyhUrlNEZiJofY8qbym5b8+6KQerivk2vQ7czVMh/kvckwF26jyJ
         VNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788130782; x=1788735582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kdi3DSPc/O+C8A9e2zv3rCFIPzltKhrlzZn7ufqHIaM=;
        b=IsWm+BbD4uwwt5ldlB5n4LPnmPNaq9yX7OJohXTrNkKJYDP9ecAVPPDlZtsvNuxaYI
         Axqh5e9L9kKCG64fe5Eb909JaCIE+PsiTmO9WzBNYZhD5eCrE7LF0OwylBa0jSSnxvGO
         1CfdMC69dIQlQq0h0fKejbw+lRpqWW7xyScIFNznQgXhfAaX91LfWINU0zTuZJyHsSKN
         VzOIPYOLUDh+ojwTjvYnsqezBeoZdUR1fZW2Vvr66ZdZcvbZOQEoNE6OjsLa/JOqAv6B
         O2lD1UYpt5F9JYCrgsZGkHxyvKPC9Q00CXw7HSonqKI42X/IBiq/X4KO5DwyAdElcyeA
         Y6Cw==
X-Forwarded-Encrypted: i=1; AHgh+RqUftquf4forZU+fem/bkvYz1isYY+6nMnfWBnk+XcE/dWE74TRRpH4YwzUHbw06k0sui0/Zbeg4G65@lists.infradead.org
X-Gm-Message-State: AFuF++kFruCAFRG0uCfnjNgGGhQGysNCyfSLTv4rfXnfN2XPxB7nRN93
	wXjQQI0JpG1d45J0uJdunicV/Jr6RBkVOaeLHvJAjS9cgpPCTI3lcAFMUZeIYTeCCHk=
X-Gm-Gg: AR+sD112nI0W/1cFUIdUDrmqGcY1R0hKSVOczCmJLbNWRE3m7liU18NSGGm3s39Zaxf
	cjyO9U6NFl+dmdz83bg65bgQm7xhbEQCvux8MXhGa9k1bLAqjmuua4+pBHTaz/lQUgNbqQnjaYR
	eFtiLuKivcsTn+93PUBTWAKVhScVGZleYDfXNHnnfuwx+Trtjg8I9MHs7zwvWGfKi0qVTMZdCKD
	SDdxotju+09RO8Hsk1WbT/6JULuY/deYT5+2M59yvcze6RIvlOi7+x8CC5dKx4d+bgs3yexKULq
	Ke0xZQ8SMCnrnImFSuCgo959T5xxG43ykaLSxQRYz8UVYUjDOhTHN2bMSoY957CJHJWqVynfnRN
	81Fja9zzpqH8qXpvODz2M4z51cdiDLC9/7v2NwZ0M8cOHvMCLzIFwfi8fpu+oy8LZppY21slwTT
	m4jhL7eYrxqyo/NcbZWjlxT1dUR/P7GbSCR2RiJCvoIgTF6JzPmbV+94M9F0GkizfDL9qm
X-Received: by 2002:a05:6a20:748b:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3d266570c5dmr31298068637.5.1788130782138;
        Sun, 30 Aug 2026 15:59:42 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm28921366eec.7.2026.08.30.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 15:59:41 -0700 (PDT)
Date: Sun, 30 Aug 2026 15:59:39 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, adailey@purestorage.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
Message-ID: <20260830225939.GC1842415-mkhalfella@purestorage.com>
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
 <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <20260830222558.GB1842415-mkhalfella@purestorage.com>
 <4f2d2b60-56f9-4ae3-b38f-bba9754011df@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2d2b60-56f9-4ae3-b38f-bba9754011df@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_155943_428677_83DC2970 
X-CRM114-Status: GOOD (  14.37  )
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

On Mon 2026-08-31 01:44:32 +0300, Sagi Grimberg wrote:
> 
> 
> On 31/08/2026 1:25, Mohamed Khalfella wrote:
> > On Mon 2026-08-31 01:00:52 +0300, Sagi Grimberg wrote:
> >>
> >> On 25/08/2026 1:56, Surabhi Gogte wrote:
> >>> -	ret = sock_create_kern(current->nsproxy->net_ns,
> >>> +	ret = sock_create_kern(&init_net,
> >> I don't think we can just change this...
> > Why we can not change it? Today the error recovery code running in
> > worker thread will be using init_net anyway, no?
> See commit: 1be52169c3488ef98582ed553ab35cefa3978817

Thanks for the pointer. I was not aware of that. What about error
recovery case? I _think_ it will be using init_net, no?

Also, Will the change to sock_create_kern(&init_net) break the fix in
commit 1be52169c348 ("nvme-tcp: fix selinux denied when calling
sock_sendmsg")?

