Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F0C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1bVntGfi9PYOqW2w2sEKFCjGpKPAhuPekyPqw5Ea/s=; b=mWxlBzOuoWvwTYTaAplhtbf3Cy
	w8rwlzwPNggE0fPS1pF4kNygNmc142h6WI8stlfSTcePfNqTht3/o73M2jQUBbq3M8LlYlmalGuvk
	SbgjK+OWe9X9QMK4JmQTJas28pbI7Pxx5aYN3wgsOkCUc6Tsk5TxgqFbtkQn4TgQ4GzJpYiDRz/oq
	SHShhR9+gGEXD+rgPuiPG5uhMFpd6L4dAePyW9HKex9cb7rGrg9hzfuScX7hUhe9HQ96eSue6jMyp
	LHpjRFe3e/GaEr0dPmjRAs+/RhCqwh4pmQD/jU1RO3MncDGpiKoKNtzAT27lfNUXlKXioXNkOoHVt
	ENtIgbvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r02au-00H7MY-2L;
	Mon, 06 Nov 2023 16:36:56 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r02an-00H7Lo-24
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 16:36:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id F06C7B810B5;
	Mon,  6 Nov 2023 16:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A2C433C8;
	Mon,  6 Nov 2023 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699288607;
	bh=i/ae4hJdIve54O+1/N5AmqSGvw4v4QG1RuIz6Bfe7CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L857G2yVMIhWjeGXQli2nFJEwQ0RSUX8law95qewMP8pO770uwM75kzCM+9RHP2xd
	 bDklj+dQFl3KO3+LMMGUoQJbKr7kI4bWrhxtAXUitScGAj00A3WjjtrggYUyqnFB5m
	 qdzzL/ukBqUkmrRCiF/53Alr1Np7gu/D8eqACXQXOAVq51BVq8h6GNp2/q9gwvNQiw
	 eQViz11kodlKygGXKutlU8+TyEiw9swBw5zBgehVtNWlBYl/zS4ZmZzp/8eBwlPhT3
	 dQqJluzNO4KQ/GRX0ZehccHL7qNp9O3SFhY94+qaSwIHXUbrS4NVNFsruuvpLM0Cw6
	 tkhPk1RU4Dy4A==
Date: Mon, 6 Nov 2023 09:36:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v3 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Message-ID: <ZUkWHNgXt_RNQVwG@kbusch-mbp.dhcp.thefacebook.com>
References: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_083649_853189_FBBA066C 
X-CRM114-Status: GOOD (  11.79  )
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

On Wed, Oct 25, 2023 at 10:51:22AM +0000, Mark O'Donovan wrote:
> The first patch is a small unrelated fix which makes it clear that the
> response data section of the Success1 message is not optional.
> 
> The second patch removes use of the host sequence number (S2) as an
> indicator of bi-directional authentication.
> 
> The third patch causes us to always set the host sequence number (S2)
> to a non-zero value instead of the 0 value reserved for the secure
> channel feature.

Thanks, queued up for nvme-6.7.

