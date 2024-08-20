Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAABC531DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BvEQbBOiCmoNUj22U512+XnmgJ2Rnn43p7E1aNOUrg=; b=Y/KNnFleY48JSbTYb0kUGg0niT
	Vjptc4YZQ5D50uijOCaIi+BjFYA3Tp992kG0AjloEH3vqWgRgntfNPeY1HONZ2MnduEt7Znvg5Jci
	0FcaSELUxxD/U8by1l1LwJbWyyDbVcHKh85GHrbkx+W99+HNsFPmdDjJP778XwDsNx9W6jEkAlCzh
	WunIZhm73TaK5L/+ZZsyYxuBlMtoht0mLrgG1Ql2pbooQWQgGcLK586DwQx7nvri0xW03nu2DyOhn
	VTy7hE9koHVZXNrxWIqbEOvGjwbqO9ymKCHpJUjQ8JaUjS6KfUbvAFkLFLg9hA62DE+6JvjBEdf5K
	Od60X3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgRHg-00000005usi-3mcq;
	Tue, 20 Aug 2024 16:00:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQ5v-00000005cSc-1nwG
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 14:44:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D271C60AED;
	Tue, 20 Aug 2024 14:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128CFC4AF0F;
	Tue, 20 Aug 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165061;
	bh=/BvEQbBOiCmoNUj22U512+XnmgJ2Rnn43p7E1aNOUrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVUwR/A43+Z11G0cUskq3cdoBKCu6N7I3x2/Dk99DWY/8z4ut5d0fr+tko8iqIZab
	 fqVs28mPDlw3HsS831A3iD/4cfbae02yQS07ayKjs9QmrwbPyLV/MbwuIxPfCNVpFs
	 6VWTwkpqwMwqrqdrNt+H7OolqbdVhfTOuV47T3yQAcsIGkmeObwd7NgynmW56Cm5hR
	 Xsc46EbaWkNE3bFqKWIhSg2UavPPX4mofO5cUE5KXRtCcmvJ7rREQvEZ5L946GM/5g
	 i7WSCnmHdX7TPMRiyuSHn8Z2tTDGnwuXLPzq/7yMEuO619V1INy4d7GacxIZC/+IKj
	 hU3Z2kk5MMFZw==
Date: Tue, 20 Aug 2024 08:44:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvme: Remove unused parameter
Message-ID: <ZsSrwsq2SCTEsGD0@kbusch-mbp>
References: <20240814135702.99402-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814135702.99402-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_074423_616474_283FF958 
X-CRM114-Status: UNSURE (   5.40  )
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

Thanks, applied to nvme-6.11 with subject change "parameter" to "field".

