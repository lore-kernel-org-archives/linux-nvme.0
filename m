Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D12E9129A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYmMysROMQf/3xbswvR+C1js4FpU+NWUAdPsaGV+dq0=; b=gtlqBk5LKVU8VbFcxxO00veSTM
	Idk6teJjkSiQ5FS+k+BES1CIUxe/YHuK1MnfTEis4g6XdvhEMo/N2YIf+YbSIi4kG5x86v3wVIYCx
	QwR4JFVgSi10796j7s74VozXhyH7WeZ/8+B5byYB1rIVmbAdG02E6LPQRI2Ga8j+UsHWH7V1d3Yx3
	wfSHpmamiRRKD5sLJB09oBbujbL4QltZIXI8crdMgirbyj6ufzaqPkCZCweP9H9aczmfNOGxjNuTe
	yYYdkjOL5upG2ZWQLjTD44aZIBpAsmCvU2l4s46xHuUeO6HFUawSe0lrS6ruPcIGcG9pnyA6tJ/9p
	fXB2s2aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo17D-0000000A7qe-37i0;
	Thu, 05 Feb 2026 15:17:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo17C-0000000A7qN-2v54
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:17:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B847E60010;
	Thu,  5 Feb 2026 15:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D237C4CEF7;
	Thu,  5 Feb 2026 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770304673;
	bh=QYmMysROMQf/3xbswvR+C1js4FpU+NWUAdPsaGV+dq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A144Uw1rLpNJ16Xmbxq4p5rERz+odWfRMdh2ZFFIw1JMfyDOAHn8116T7D8VHDp/k
	 Re1c+ArPlNi5E7u5SdlmPK20piaiFwJFQfGd+13cbFmSf5DE3VJFncenIFtKIwflEF
	 Pk9Eg+M641QWu+dL4qlIl5gOj2ABjthT7/3ZfNreUSJBHfaK7T5Lyrwt61Vfje9mXS
	 TvDKvNFUJLxntC7xwrI2Jw1uO1+UH6Y5vVAK16TYA4hwdU1UtXdTUoOugCdHRAeJ4x
	 1MsZHtSA7yJI2Wu4SPEoVpELP+DSZxOc8F2FvQ5giFPbebtaBPF3kRFMMP87N5UbCY
	 XgsEHFyla9ZWw==
Date: Thu, 5 Feb 2026 08:17:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>, security@kernel.org,
	sagi@grimberg.me, YunJe Shin <ioerts@kookmin.ac.kr>,
	joonkyoj@yonsei.ac.kr
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
Message-ID: <aYS0nzxaR7s0wX8C@kbusch-mbp>
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128004136.946596-1-ioerts@kookmin.ac.kr>
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

On Wed, Jan 28, 2026 at 09:41:07AM +0900, YunJe Shin wrote:
> nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> length or offset exceeds sg_cnt and then use bogus sg->length/offset
> values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
> entries, and sg->length/offset before building the bvec.

Thanks, applied now.

