Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF42DC36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7KrKArPmFqkiPK3PafYiIn4p3BfEpnbjyQZiUDP8ng=; b=PzZKizpnM1TCfwGT0PTVcNSugU
	u7p+Jfw80dvrVo/p+Bc9BKw+Mpj3IF1rZLCQ8pxy35puyyWY0Ay9pFAClBa+xvBxyPoeyIZnWdrFr
	Ho1ynzh/1CSlenaBMBw5LiFVr7givQ6PIGGyk/I0h6XAX9G55Ef3kJg4V3uDoXLUwGezUsLLIiglz
	S3GPNdyrXcVF6zlzVHosDXsZ0gjrXaTAdfohVyvbBJXrgoO4XNAc+7yTdr8mkVCm0p9nuiPmJLvcm
	dWM8h0D6/vyt2d2w0CHzCPGZdEoVbxLIF0baUalBHCib5wK8a6iXDu9miMTK4PR3TXCwQPjRhMftC
	bMwi2zbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CqH-0000000Ebkm-2NN3;
	Sat, 05 Apr 2025 23:22:25 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CqE-0000000EbkN-48Wj
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 23:22:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 342BAA482CC;
	Sat,  5 Apr 2025 23:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B5DC4CEE4;
	Sat,  5 Apr 2025 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743895341;
	bh=8NjtXCMkd/RSJ1KOqzU/yjbaHExhXHdmKwzbvJgCDwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I54nFU/mrEUvFwVNC/Zzg5UYQwqiEcPUqa6Qxj8MtYGSsJWt/UhMpWCY39YjEElUR
	 3CXh4e7LZ9KCTpM+T2Pw2ZtHKhLEDqGg3HE09+un8BhuPN/qzUpa5MRsQXNEqFzB5a
	 xgZmCaEw/xfBIbXtidgtTGOCHGxvxIjke0Vg5Y+aGbK7JPFQa8etdWG1rQVIy1aueZ
	 2J5FEXoNiBP57+yeQZCKIhh/T2Aaxgm/YMaQZATbxqCbD3g7RDNZunfXIlln78TJaX
	 MOaEqNkZnJio9hYvRzGADXBp6WjUuyAeKD8oY/tob7ZXON/lMkLxj10+qOXVf1nNx6
	 KU3kR0FpzvvfA==
Date: Sat, 5 Apr 2025 17:22:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@meta.com, hare@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, mlombard@bsdbackstore.eu,
	zhang.guanghui@cestc.cn, loberman@redhat.com
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
Message-ID: <Z_G7K5UOpERc1rd_@kbusch-mbp>
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404082801.1614252-2-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_162223_092401_294CBBD7 
X-CRM114-Status: GOOD (  11.70  )
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

On Fri, Apr 04, 2025 at 10:28:00AM +0200, Maurizio Lombardi wrote:
> There is a potential race condition that can occur if
> the target closes the socket while the host is in the CONNECTING state.
> 
> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
> function is invoked. However, nvme_tcp_error_recovery() is unable
> to transition the controller state to NVME_CTRL_RESETTING because
> the controller is still in the CONNECTING state. As a result, error
> recovery is bypassed, and the controller incorrectly transitions
> to the LIVE state with closed sockets.
> 
> Subsequent attempts by the host to communicate with the target
> will result in an infinite loop.
> 
> Fix the bug by initiating the error recovery process to correctly
> handle the disconnection in case we missed this event
> while transitioning from CONNECTING to LIVE.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

