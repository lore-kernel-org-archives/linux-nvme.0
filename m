Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454B6C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LvN/DmtmPJoSOpJELJVy3vJ1Xt7muNG/zcbvp6ZXMU=; b=e1BVaT+095ddz2AcyYelaxkI4u
	TG8kHkCCGldH9OU71L7H0M5leO8OAPEifuIZF6fMGC5QT4iWWIfhg+YTrV0A5dwS/9IYFa3xuqxTg
	3pJDVjnrMRCnNZN8hsuOQ/+669TrsbA1OLEAu+ewkI1f5fMidMk2P3V2kmTzks24WFUJAo1ZcWK0n
	OryiX1Fb3p72t3G5tmBToR5J73DcrnaohHlqLCqWRV4ruKWnlrT4bwNwJzhuok0dtPrXsYV8qiIqS
	OyMstYSJE7RMnPf9/ruiNc2mVeeIoIOeg+4aq91PjKeezH1XStOYenvBoc0E4B4qE57nbX1i6vD3h
	cSiBkV4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLmup-00HIGt-26;
	Fri, 05 Jan 2024 16:19:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLmun-00HIGL-1Q
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 16:19:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B5263619C6;
	Fri,  5 Jan 2024 16:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCFEC433C8;
	Fri,  5 Jan 2024 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471560;
	bh=WI4OyUjoaxnW9RoPWb6YWhLPccbdVIpbJXccrSvjZoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDDN8TXtCx42Pj/JIpikjVsFo61DKPuPUPknQMR520Mj0UPkXT6eHv6FlL/mKo7Sd
	 IpoCkTipYWEYcJogAhHc+bL0Lm0oIWrkfBOImJWjjPm3NoX+b64xp1N1cwSJRQW9Ti
	 yt4NNXaNkZQGoaaDVRoRI5x1OLESce6RTrbDAwsvM37u4frtDhbVDJoaJwreBhruVG
	 C9ysRNBYuFfmuzVWisbqYzIBj71wu9w9WuL/8FQsduzcoWJ3c6YmmU35Vn5zLpxSU7
	 dMM/UMFgcG/gXO0v95/BvPw0aSaNi+GaEQslvo6XJesBPO4Tihp+k6P+QQ7f3dP6QV
	 EAnZao2QDFPNQ==
Date: Fri, 5 Jan 2024 09:19:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet-tcp: Fix the H2C expected PDU len calculation
Message-ID: <ZZgsBZRblnV35e8W@kbusch-mbp>
References: <20240105081444.172961-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105081444.172961-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_081921_525799_6889AC8D 
X-CRM114-Status: UNSURE (   9.45  )
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

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

