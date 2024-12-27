Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D32E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2024 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOJewqRKxhOtVz12+HWADtGO1WfdQDeEx5EoPawXFu8=; b=F8DP4VR9JCmw9YiKM8aFRr8ygJ
	/2+V7hM2rr3/HFxvHGCtoplxXl3ws92CBy/29DRpDOD01sMB/d1KjlXPDgSkZsD+RGE1UUjyGVTxZ
	lA+u+oHzb3R4A0qxNGKreU3zAjGwcrEztMDw376nF2pMQsljPcderrDjwXCYWg+Whq11V/lmL7und
	yrlOT+HIKe8TdGpfNnWMXxBgFjesiCFRSZJBtwMW9CNBqDnTzFSn5VQAJUKv4hSpO752C/YYTzyq+
	kUfQDQvPIvrS2VtbtMl8xrXNyAKvlJiji3EP0n2kuXLJZ1fEOczy6ftsvByzai8/YoqDfxQQJov/I
	L5TVPTOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHx5-00000000yvi-0Kg6;
	Fri, 27 Dec 2024 21:32:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHt5-00000000yTB-2cnP
	for linux-nvme@lists.infradead.org;
	Fri, 27 Dec 2024 21:28:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E845AA40348;
	Fri, 27 Dec 2024 21:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF53C4CED0;
	Fri, 27 Dec 2024 21:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735334930;
	bh=AH44EXiULz6xo1SUWUuJcIKZT4kZJZp7jDJYd6Eo6kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t04navfIkIay400npAHhshjMsa3DvQdpgpvVSXqBqfTUvpkIb5XAVXjY5jj9RMrPm
	 p4+eX268363cDlhWbW8VqhEd6DSV6eT4NbxjCPLNxv6pwZIfHtqni7xbA2RASqPzFK
	 A22evs44JiZazORywWz/IVw0o3OPv3fRG1plnbL/bw1x72UWb5wrx3GSOhBHFBmvCP
	 sn9u1NobOKNpMbRKNZW/6J88lqekVPjBxKrRUVITIHPTv0l21tNLF6mis9oRVz9bZB
	 ehtxwjENqlGH0cr2jKvZbv3ExQ0sopamml1gZbRRgO5AEj9d9LFnz4TeFyJ+6lnq4X
	 JV92hUdDZ9kRA==
Date: Fri, 27 Dec 2024 14:28:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	sagi@grimberg.me, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet-loop: avoid using mutex in IO hotpath
Message-ID: <Z28cD8-KFFdURJl0@kbusch-mbp.dhcp.thefacebook.com>
References: <20241211085814.1239731-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085814.1239731-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241227_132851_731996_EB7AC65E 
X-CRM114-Status: UNSURE (   6.17  )
X-CRM114-Notice: Please train this message.
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

On Wed, Dec 11, 2024 at 02:28:06PM +0530, Nilay Shroff wrote:
> Using mutex lock in IO hot path causes the kernel BUG sleeping while
> atomic. Shinichiro[1], first encountered this issue while running blktest
> nvme/052 shown below:
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585

Thanks, applied to nvme-6.13.

