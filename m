Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDC1E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWBKmIekLtd0t89F7AjuLCz4cjbTnsPqij3UTNp7rZs=; b=Qy9o/+Ykad7xfgDIo2an90uEqb
	e3Ib1mCnj1N7LajxXATdpWLF0x8eP+4J5cJDMYGqPzDJdvj9qURIsTOqDTBaakJbhVZ0MLpMRfnaG
	Tw6Zf4DHVaPc6aZHwdizdoV5DDR9OxZcDhRyYIZ89Oa53YI0bQHZiEeigIz0LunRR5neIxzECLCRQ
	TWEyoMhyyWX/EfZsqckdEGAB8AsvcfzbJQAvh57l8BpP/jyUPJNEsRJUxyzMuhK5BchuP3z2B45Sk
	inGBBzvlVUp6T8JoP9fxaWH3SrJaqhPuQK2tnR+3Hxa7GpSu8+melK4wIg5f9z7fL0Q5fGXrGt0ZV
	JE4wZUxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZWW-00000009Jss-3EQd;
	Wed, 08 Jan 2025 17:07:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZDj-00000009Fd1-2ph2
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 16:47:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0E71F5C1E57;
	Wed,  8 Jan 2025 16:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36127C4CEDD;
	Wed,  8 Jan 2025 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354870;
	bh=HcHdZnNtxHK9vuBjXUlt763uNHlznt0/+9Y4QmnUYcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqkz4DIRXPUkvu2qJDXuvZCM1lAp6Wq9dzr7iTXb8bEHIZ+FfJm2Au0T15h6k5nPo
	 v+kybitSa7OFgt4BkP+nGCTncmgKZNxVwQk0LUYihN1adI1CBGMMgprOIsr61DL0Ii
	 5hlg4f+efnKqBVWiGsiGZ+yzNkcPzbnevMrz0GKz8Xi/P2zVtdrycmJIzbQ9IQ7B9E
	 3vtCPsUNA0KQc+fXA8MXBukuPdvTv6gDfSkCAXJsE6R1t6mUsr0zozqy4aCBj3AwSK
	 e268SZ8FqkV0+5LkZdP+SJj2S51S5aLx1Z1eR0raUm71cC/ZDn3IJFk1n2WuLAtvGW
	 v627qj94RYH3g==
Date: Wed, 8 Jan 2025 09:47:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: dwagner@suse.de, hare@suse.de, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv6 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
Message-ID: <Z36sNBMPV7--2XHw@kbusch-mbp>
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213041908.1381196-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_084751_753161_B04F5DCB 
X-CRM114-Status: UNSURE (   9.05  )
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

On Fri, Dec 13, 2024 at 09:48:33AM +0530, Nilay Shroff wrote:
> This RFC propose adding new sysfs attributes for adding visibility of
> nvme native multipath I/O.
> 
> The changes are divided into three patches.
> The first patch adds visibility for round-robin io-policy.
> The second patch adds visibility for numa io-policy.
> The third patch adds the visibility for queue-depth io-policy.

Thanks, applied to nvme-6.14.

