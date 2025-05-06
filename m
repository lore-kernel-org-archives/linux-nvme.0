Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E144C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RK8CB/ILucoxkojMLroxyaAqpj6rXkr8cb1h0tuO+FM=; b=kF109JNyj/yOuqSQ95B55xH3ML
	9Xi6dl8GMXtP4aag8YStHltng2uTGyVr9pMMtR+yjFQP+ZRkgYMceZpQGcL2c5PKjHw2Kg/RKgivC
	xZRMFjiglds2rH85/KmPrrqVhqetCfVbwXx7F+n9TLQdRubbQz8fFtl9uL8MIszfZ9CDGdVVsVpxM
	NtR/rMK2sjSWE3v16OQeEdXj/yrpAAGZZ9j5pmKyhv8vtwWEnTAaVYsY1ypda+jjn+kocjzJ0H3Rz
	ER7SidRfiDVYExTOJsZ2wdMsI/vlvX8APgx8K0Cs2au0pAV72De16Cn47GtN5TGsFlcUM1d05Yht/
	O7ey/2NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCCbV-0000000AteJ-33f4;
	Tue, 06 May 2025 07:20:37 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC86F-00000009lpg-49mt
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 02:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746498699;
	bh=RK8CB/ILucoxkojMLroxyaAqpj6rXkr8cb1h0tuO+FM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kafLiDKXS816BmywaQFx+/F9Y6knLlHjegnJC8EOCpdTsnxr/e1yaY6y4wWVWU5Cc
	 pEmJcSIFvrEg1Nxq/uND+kyneyz+lm4cL848VLV2wWlvOab3SEPuOTkyOQdSj+ClQW
	 LZ+Ex6H0L9ikuOIyZud7Tr25Wd3PVQAdT9G4v3o8=
X-QQ-mid: esmtpsz17t1746498663t4c1b9905
X-QQ-Originating-IP: 2vhUXsJq6NqiLO1Htm0IxhFYAPx746WeA0MvTVyM9nk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 May 2025 10:30:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1353101163767275647
EX-QQ-RecipientCnt: 52
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: hch@lst.de
Cc: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	andreyknvl@gmail.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	boris.ostrovsky@oracle.com,
	bp@alien8.de,
	changbin.du@intel.com,
	chenlinxuan@uniontech.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hannes@cmpxchg.org,
	hpa@zytor.com,
	jackmanb@google.com,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	jgross@suse.com,
	justinstitt@google.com,
	kasan-dev@googlegroups.com,
	kbusch@kernel.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhocko@suse.com,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev,
	paulmck@kernel.org,
	peterhuewe@gmx.de,
	peterz@infradead.org,
	sagi@grimberg.me,
	shameerali.kolothum.thodi@huawei.com,
	surenb@google.com,
	tglx@linutronix.de,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	wentao@uniontech.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yishaih@nvidia.com,
	ziy@nvidia.com
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
Date: Tue,  6 May 2025 10:30:53 +0800
Message-ID: <AB2D78307A5FD403+20250506023053.541751-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429123504.GA13093@lst.de>
References: <20250429123504.GA13093@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MIXayioyWBZjdXIIg9vqEFEP1rndaeDbBxgcX+6TdOBY4fgPWBVGCH7p
	2JsHdKJTuNk6u8AM4q4ieHCa2JqpFTHWwRRL4JiA/mhRy6XEomq0Rcxy/vNg3zyQ8FVuKLk
	8u8FKj8M5lKtxCc/AqTb4cgg61ofZ0b0vrixlYN4JBF1kCxPgn8qobIDmHUgdW9IFOYw1+N
	NzCrUuumdTal59UvJXIVIFoyfA9UBsYY3QApHJufslFjIYbt35eMNpV5rvVKf1I/YYKCDNC
	P9yTyAZep/MN4DPY0aYU4VKEhzq4hfUEtrTG+yS8IFi8cu4WnxADpZzlhEfh6sgIPFr9D/5
	LAjp9zJsR/w/WJBlV0/AeccvTg2ivMv8/8ld0KRxxvkD56dIxmj6YXZNshVuONjuE0nJjBO
	/ZkGZ6luDwhjEO+vkDN/jlP28nAAeQhf+qskcK1/Y9pNoGKLQM3DBAIcozpo04ivN/6cYTB
	mj2nrsDyaK1C+tCjVrjTPZFIfhssizrE/gf8iGN1F7O/hmuxJwA/dK3NI1t8SeRqO7lQz4L
	B4hzjQne+6C9oeYpkB+VOOK9PsOSswtEhn02iTK5I9PQ+Ycv7ivq6ZY5n6oWMcqKlxPN7BO
	H5JnZY5xmDNSQq3b5Wuosg7tUvfTmTgSSX4FEIzlh0XnGAcc9uh0LsxhMPWJEoyR1zYtXT8
	wYAyFsEm6cQkmgHkhA1RIcJKVmauWeY1Ior96a9f1buQZB8VVfJt+WJbMtDmDfETYG5hNrJ
	v32eTkTlFFTYKKE7IcWnK/aaTY4CI/qOHh5uVSzxCPgXjhOLX3h3MBL7nZPgOYEiV7v/m1b
	LeNwKkEEMf/YAs1XwZqw6xD/OrRuB9gCzaDRun3T8Eq2tb0DK8XA3tPUX/869R/Ki7azM8P
	ztB3y+QhyBBY/ymt6WbrLX+aRWFcGEL38eFBGQtoKi2UIVz7HU4hJjuodhguJq7uPcST0KO
	L2QyrEpCbzrrs0aGqC9GCbTWQp+Bzf9NeEGo3iubNJE93+fc0YEPkQoz3WNGg0lh7Q8ZEbe
	a4N/7YW8KVwYAvMNJi3geZoASlc1w=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_193204_853914_47159114 
X-CRM114-Status: GOOD (  17.60  )
X-Mailman-Approved-At: Tue, 06 May 2025 00:20:37 -0700
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

On Tue, 29 Apr 2025 14:35:04 +0200 Christoph Hellwig wrote:

> On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>
> > This series introduces a new kernel configuration option NO_AUTO_INLINE,
> > which can be used to disable the automatic inlining of functions.
> >
> > This will allow the function tracer to trace more functions
> > because it only traces functions that the compiler has not inlined.
>
> This still feels like a bad idea because it is extremely fragile.

I'm not entirely sure if we're on the same page regarding this issue.
However, I'd like to address the concerns about the fragility of NO_AUTO_INLINE.

Maintaining NO_AUTO_INLINE to function correctly is indeed challenging,
and I share some reservations about whether it should exist as a Kbuild option,
which is precisely why this patch series is submitted as an RFC.
I cannot even guarantee that I've addressed all existing issues in the current
kernel repository with this patch series, as testing all possible compilation
configurations is beyond my capabilities.

Looking at the functions where I've added __always_inline in this patch series,
nearly all of them require inlining specifically because their calls need to be
resolved at compile time.

The fundamental source of this fragility stems from the fact that compiler
auto-inlining decisions aren't well-defined. If these functions were to change
in the future for unrelated reasons - for example, if they became longer - and
the compiler consequently decided not to automatically inline them, these same
issues would surface regardless.

