Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69E4C4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtq4c/B5xN6nw1yVX2l6QLKwBzVUpgN+ux4EB4PP+Mc=; b=eZB6gUKBbtjYEsRLSPfvyVsvNf
	DPh22R+rV2FKTNFZMQfzwpthKd22QgrgzvbjKscOToB/CepeAmhXixfJrWuY94wHTySAGWHKgiAzM
	ajydqYX/rd+J0xZBmXnVw50brBsFNeBmnKZr4J1zWWn21esyN7Ehh5gDFB5z3JHwcuW9hoTK5WEVD
	lOcqXEBM6/HFXoQL0bPxHM+rLSPJJI2z1BNgHxpB7/O+6mTQ6QI5PDY8ThpGRmM2Vw3Bco5OYnXtq
	3+a9LBVJNZKzyHh4b32ZRhupREHDqQbLt/fh2VNpT7QLa94ZmO2mUoxmmB0f2jnu84TCTtTS8J2kW
	zAuLSbQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Yoy-0000000DCQK-1Cqi;
	Thu, 02 May 2024 15:58:08 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Yov-0000000DCP3-2m6N
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 15:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=gtq4c/B5xN6nw1yVX2l6QLKwBzVUpgN+ux4EB4PP+Mc=; b=Rsr+ZLZUKkrfuL777p2YLXe2Gx
	mcl87g+cSB/PzxGbN9+DqmyfNarPk8YN58CmIvQX6iN0EzhFFM9LzRVWIGuNYyX4zrLVDxZuQIjQk
	cwruWl2PcfNh0ZF+IXyMXhPLxEZCrO58kKDFnwb1e6b0RGILP45uk/PanV/CTpZ8tGyoL6c/zi2Y6
	n1QRyDsr+hdvlzoaBX3HK3NFut1IsCsOKjBn4Guh5FzWGUHH0q2rZ1+MxqHi1Ls7ebQra36wZa4zK
	hmpWxnriJbhl1JUk9+dGA4afqEnRE0o2OH2+qGhR4AnR2/kbxisU48su9Y49BEjqNdJ6LvyfAMkC7
	1o/rccmXtKM3U+lfOkbs13cvMJQ4YWLRCSfriwQSjGEJOcte05wTJyorb4cfMKpMYg2CbHuDBVZy2
	RgmKDEQFt3qDRDapyr1kXY5QfFSonHsd18xHxFcdP9v/BaNbgZGqo887wYx78rU52hsneHak7oTlN
	VDTkmmg9slsinAsInbCiOZYC;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1s2Yok-009T1N-0B;
	Thu, 02 May 2024 15:57:54 +0000
Date: Thu, 2 May 2024 08:57:50 -0700
From: Jeremy Allison <jra@samba.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK
 hynix PC300 NVMEe
Message-ID: <ZjO3/nUwTZZ/5Ej1@jeremy-HP-Z840-Workstation>
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
 <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
 <ZjK8IjHfwpAMQajT@kbusch-mbp>
 <1c826b9a-4b21-43c8-9064-c3ab095307c5@molgen.mpg.de>
 <522a8fd6-5865-4e8a-b8e8-b0288dfe384a@molgen.mpg.de>
 <ZjNSOEfDMgqJW01F@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZjNSOEfDMgqJW01F@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_085805_807600_2D77AF02 
X-CRM114-Status: UNSURE (   7.51  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 02, 2024 at 09:43:36AM +0100, Keith Busch wrote:
>
>This gets worse as you add more nvme devices to your system because
>shutdown is serialized. Some of us have proposed patches parallelizing
>this process. I wish I could spend more time on helping see that to
>completion, but other priorities get in the way. :(

FYI. The various asynchronous shutdown patches have been
merged and are continuing development and testing. I expect
Stuart to re-propose these once all the obvious bugs have been
found. His approach is currently the best option IMHO.

