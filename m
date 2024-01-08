Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C35AC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01+C/KevZ257G3zxZUF//KkGiaSYjLbbEe5VvNmzhbQ=; b=EIdu6ZDLZAFTE9Gl0ErLTBKz/z
	cacJ0kDRqwCZJIqFL155UtBwNaKYo2YafBHyp9OYUPklGc99GCstsO1kLYuHPUzucnVaCUbD7b9FD
	oQgvhxyyyOZJbEMM/hjGxz2OF1qtvYJWPTxriF2blx9re1Y0PxDiwwkCE9nlIAxQ/eqQnI+aH1Igo
	anayhYPuAfwmVaE1VZgZsWxfJiKyQPq5iVq3sV0gYWYP5KI6MciFQd3KdG7cP+nZxuZf7oW5O4MlJ
	wOmF92i7N159fPA+AkeEguOI1CePcsN0ytFXZQLTdF/5InoR1clnd0YxXQM3yiD8rcPsKUv55C847
	Wq2/WANw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMu6l-005qkF-26;
	Mon, 08 Jan 2024 18:12:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMu6i-005qj9-2U
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 18:12:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DF7B8601BC;
	Mon,  8 Jan 2024 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FC6C433C7;
	Mon,  8 Jan 2024 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704737532;
	bh=l+1fwC2FTT/pU/oZp4VvatHaY/XEjpDK4zCslH1NPfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmNYWLEJCjGdLqlOmRUYy22la7cwAj8AICSj2by6n6nZpW6ykK7gKa/Kmd7m+xUcT
	 l7DiGoxbIxcN4Gk4ER1pdYAdwLjM2IrUsxUxpSqjO0tGDhTuEREQ8dl6mpR+Cd8+ZF
	 tJwJH/rUQIi3dGAWJ1vcQ6FyqTcuBKT4r7hJr5Ce6if2oFVxzvr4VqdQ8huFAcez+5
	 pEMs8cMrQSWNZG9Sgb6U5EA9hR69cCMbKZVcemlF533dg2/1FSvajTEKkmMxwOpdPk
	 KSrjOJhjiiWfyHCo8egMnswdRGVN4ZJsvkwBOto0qjrMMlxUdzJkeMGqSNh7rX38mg
	 CsN59100+HehA==
Date: Mon, 8 Jan 2024 11:12:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet-tcp: Fix the H2C expected PDU len calculation
Message-ID: <ZZw6-fVDr7fuiCYz@kbusch-mbp>
References: <20240105081444.172961-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105081444.172961-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_101216_850799_94182316 
X-CRM114-Status: UNSURE (   9.28  )
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

On Fri, Jan 05, 2024 at 09:14:44AM +0100, Maurizio Lombardi wrote:
> The nvmet_tcp_handle_h2c_data_pdu() function should take into
> consideration the possibility that the header digest and/or the data
> digests are enabled when calculating the expected PDU length, before
> comparing it to the value stored in cmd->pdu_len.
> 
> Fixes: efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Thanks, applied to nvme-6.8.

