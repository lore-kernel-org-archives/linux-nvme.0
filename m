Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15758CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RN2qntWdnm8iQCa3ucOR+A7nRbIj7pe6atpwCdTY5hc=; b=ukr4hF6hWSHiM2CqTR3iveVpvG
	k4IGU7l61ERxSfMU7ZuRYXKvvAURfg3vhSvhdsCK5Fih8civEWF0CG+nUGrWDOtXw/pL66AQHoLWr
	ewU3LIVjSjESHacNip/WElXcWFgf1gweeqw5FeSVBi7PCqb+FiYt7K4WJaJ+jda3vCDjlQXp/L2FH
	C9s0qLs2Dd1+TdN/dXOkr1VtKjJaEnrLDwRJlEd2VvOwSgO/o9lEbejpAIi6Lvi2FIm8K5oS41LMy
	9jFBmxYVHj0au7RWmrpl3caBXmhuIiOotosesimBwN6fnVNUv3pmtWJlHKoNayrQrMwli92nWhlKW
	+neds/FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsqau-00DBus-27;
	Tue, 17 Oct 2023 20:23:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsqap-00DBuC-1v
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 20:23:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0C472CE1FBB;
	Tue, 17 Oct 2023 20:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78F3C433C7;
	Tue, 17 Oct 2023 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697574184;
	bh=RN2qntWdnm8iQCa3ucOR+A7nRbIj7pe6atpwCdTY5hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kexVT1LjUADLEMZcwzPYh+B8T3ZXHHVqzFu062qi1WOnQUOAD/49GeuKjIyhR4X50
	 6KRCaNhOtR7XlMHECyKKiIP1s3NvwiCZCCXZoCdCiOsbtR3HYRopUCs17Ujuu2RmX4
	 ilndW6XgK2rMgQNha/d+3M0BLS0PKOC/pHQtcS9O4vZ9h4gJjNBEHpzCHpEbbiMEOI
	 UkWe1cicfCcIdmWGn/774JBdZFotmIVteOveqLLvyMd6EKhCMXr+mHAPL5iOxzqXrY
	 DQDzn88xzRFLjOOeYfzGEVR/cB9mBkpwnsejqR4ahMH7fXsEbm5S+lDHXs9B9l+9Au
	 XD4O+4+BQbzug==
Date: Tue, 17 Oct 2023 14:23:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hare@suse.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet-auth: complete a request only after freeing the
 dhchap pointers
Message-ID: <ZS7tJcZEWiPuuz9q@kbusch-mbp>
References: <20231017082845.545085-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017082845.545085-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_132307_835025_27861E35 
X-CRM114-Status: UNSURE (   4.82  )
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

Queued up for nvme-6.6, thanks!

