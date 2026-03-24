Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC70CF54AC5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeXEeU69osjk99P2YHHqeTzDzlD9zNtM/H2NU1ulbrE=; b=RER9hPpuHSIzPsJkVTU6LZQU/c
	POYI1joguA1UTeslWlpHklYuKs7Xx9uqnSgdH7ibQ3x8bA7kZ9ryJlIa2k87GFDuI1CJa7PNrQuN0
	jC+u7MuZei1ano5fog0QAJCrdMlH1K4VoUd/6m7RLaN0BAnzDcWeFFICHIwqU7GYQGEhwMj2nSREW
	5Oa8AupfNWOyfg0oJ8Wfg7jwqNWork9ibWlYULh4w38gSvFwo1vyooScpvI6pzgs4ODs+VeVtWqZ/
	E3NJV6oT8ABVZIYh7SplIPzzMODMTSw5TrciT3wGJFvv/jiOfHzv15Pdm5aUGjlhZ85uIn4dDYYiy
	sb+MJZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53SO-00000001jiU-2oGX;
	Tue, 24 Mar 2026 15:14:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53SN-00000001jiK-0dE5
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 15:14:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F90B600AC;
	Tue, 24 Mar 2026 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CBC19424;
	Tue, 24 Mar 2026 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774365250;
	bh=ENT/ULSqbWEeD9L0Qioz3ZYUW1QBKtq6piTZNHSw8qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ca1xzj8Vs2ZTi78BTm9lnKqiJMubvTIwvbMDtnDKFzjMqVxBH6MN1LGhQrfeNeX6o
	 klYQ/UdW+TFkTnqD+DbKVULBDk7+YTkO942NjBOlgx63JJNGSxYQNzo9ea4xNCgTIK
	 xRlnP7kKKdMkUvMWLqRYDOBRv7SMqVCmbIy6YJ9x/YQMki6LkH/JT7AHqc3ZARzPNs
	 V4L2iS838qk1ZcSa9k36sD1aQg7PhQ1Hp0mxzEtugw9r69mu2Ef2uvZ/wR5oZFCJDu
	 YSnAXpheBy9hjl8eu7qPzB/RbC5IMC2qYA7XtKfFkCJdz+tNYLARXADZSRLWiaUgNq
	 alXQ4dVVBxtcg==
Date: Tue, 24 Mar 2026 09:14:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yjshin0438@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
Message-ID: <acKqP2QB9MOSv0--@kbusch-mbp>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
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

On Fri, Mar 20, 2026 at 10:20:44AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In preperation for using DHCHAP length in upcoming host and target
> patches let's add the hash and diffie-hellman ID length macros.

Thanks, applied to nvme-7.1.

