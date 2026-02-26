Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27825FD9E1E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 23:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6aVatOQZhnn3/l3DG/K29SIadSoM5JJykVYfBXclQE=; b=pbtUt80x8/Fyn6Rci3ANn5bRf7
	0hgd8tP5ocknPK1H7C/ftFP1jUCjmj+iJYU5JzvXqlPnurqotcotls7lV2pgU2e+tUiVnMkicqlIJ
	k1O2yDXDoDo+V3+h6HqKcO4eqYrlwMOA31awDRelykoQpFQa1U1a8cu4NCmmcKPtSfYl4+WNh0RRh
	wprPNKMi9M6NHL9x5zyMHXV5nZP3DTur4bCn2y15ZmyC3Gbk9QFob78lWvVB3CU2YbFzWFdZ/fyhh
	CRLXakc3WnUPtKnkYeuLNPP0mScgl9/wsfvJzkmb3QXyIIogYlrDuX3wHzGl6TI4GIVGMZ//ohaK7
	B4iIhLCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkwG-00000007O4w-2UhH;
	Thu, 26 Feb 2026 23:38:36 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkwD-00000007O4Z-3GRA
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 23:38:35 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1270fc2bdf2so4426c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772149112; x=1772753912; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6aVatOQZhnn3/l3DG/K29SIadSoM5JJykVYfBXclQE=;
        b=1errujLvovnOXQt4w+bIbOs17AkZjcXWnkBboZB4vkX89Fey/cjiQa0semht+ptDxO
         3zffe3rmKEw0EsRnmLI0IR7c/y+kKVQefQAC51NIVfzYj8+Haj4UmBHdju2t01IE1c8R
         X4qcfMNCpl/xNwkgsZ1U0gg5gk05FIGiPqiW53wtt1I7d1KbgPis3pdUHj38MqJuVc+s
         MKIGQ5dzdIDftolyGlx4Ted/9Y0appjytma18UcV66EnovnIM2j5/LkzEuG07u7tSldW
         c/ElsmL+lzRItRH3Lg41WFyEKojZs+0jy0zvE6LhvP/u6cIwilfjaXQ4iedgoyNvsbVw
         960g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149112; x=1772753912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6aVatOQZhnn3/l3DG/K29SIadSoM5JJykVYfBXclQE=;
        b=Yq7XEbYcKyta37Z0WXcaOWoD/rIQtaJaH7lMfCDrGYS5VsoowY1xab5eqIAeol8xNq
         lpbOWGlTf8NCjA7zV18zviE3e/+4tjmZbRhW1BvMwhK3u7aZb0b0Z+K4cyd7zTtfiW6H
         WxnkVnimSZ1WQDht6rS2l9wgZJABeNhwcQ+svBDIJ29/yhrf/pR5Gf9ySfzTIXqRR3i9
         cZrG8gurYwPFq72M3OvpOF7zz2NU0dXQs+CX5BTc+pPBFnzf6IxvkocHLIdMv3ejXRIT
         f/kti4pV2V3E31vVfJKd1ht53wl0zbjYuDgk0hfH9xKvPY7VxRXczoHKuRRYd88SvWG3
         CdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMOx4mA6K2kEOcvQkSBj8iCae9vgkjZt6L/Zl274caeOh6gRqZIWEbD06HG8Hcvrx84zH9FONlYag@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3Bz54VRrLDgASpZ263+25lonT/i6I2bucfNEs/8R6g+VWZIcB
	jOMTx/LeyyXPwNa4vMamz64oKNgv6/AnZa+Z59KE5DoDyIsw+K753QL7yXwPIcPATQ==
X-Gm-Gg: ATEYQzywfmk6nqO7CB3gG1IXm/f8higHRB7UWQZRm08pVPQjq7jVg3Qb52TMORMRjBK
	5bz+6uwQ8w67IxK+06ge8JyzCNtRiMMlSXkoJtbR+objvuBXCxr1r+HLvFYccIGoJsVLoBh1as9
	6L42CtCCHW+84aVQcsLym4fmJLBaIabmCPJlpCgOnSHHzGCrF55kNo0Y1DrI/54usEvligAXQRL
	E75dhQD4Rd/ngpZ4/obbI6x5yPJr7BD5pIBq5WLJ2IGf3breWpsy4SJuTV8MviVnmsmV2fnI2Yy
	Fse4IOvyeOxzxRQJcOKpOaoLauo3w0Xb1txTmVTiuAnhh8FycahKBP20wHx0aHarpEJCSnFeI0z
	uuwRlzaryQ4nmvrjTlzYzum1OblmoFb7kmn8AFLLvnYtUhDu8dV9badI920rhjd+vGpwkKxe/rh
	pzbWoYZCpSJlWMD3KEvhYKXMq5VnLFMwBWOCj15TYuFQOaDuOlaqEdQ520/we25Jix
X-Received: by 2002:a05:7022:f10b:b0:119:e55a:8091 with SMTP id a92af1059eb24-12788fe0b17mr248037c88.14.1772149111311;
        Thu, 26 Feb 2026 15:38:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2e51:8:d9de:6ece:634a:85ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c3csm3225980eec.17.2026.02.26.15.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:38:30 -0800 (PST)
Date: Thu, 26 Feb 2026 15:38:25 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aaDZcZCwIqTrE7Z1@google.com>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_153833_844594_63DED098 
X-CRM114-Status: GOOD (  25.17  )
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

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
> 
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
> 
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
> -- 
> Pavel Begunkov

Hello,

Thanks for sharing this, I am interested in this topic. The io_uring
bit specifically, as it might be helpful for a usecase in Android
for loading a file into a dmabuf.

Thanks,
Isaac

