Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF3C4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8FKAtHagTGdp+uxF7N2+IP7iFiHuwdl75mB278C3X4=; b=34MsokLlGuxYLntp8K6QrQlK4V
	7794k+wdVssY2exbYbWr/YkXE5gLQXFdIFAvJmfJb//6u/DNfyXMtZQuhEnX8x4mh47nrFBxkbXRC
	Wbn9qDM3re88uurbXndBh6fag5zF3lqMsQllMQubP2ESaAOU5qoTdH4h0IxUzYVsWFLR16Kp+5xYQ
	SoDYW8hH32CULGomXebwFzo+kkec9S9qKms+ZfxHg76QTYv6zBY8tVfpMwDk+vzIpZSYaTz7iNowe
	OPlqkcbaf2CupyQlRyZ6sMXLcxoe0oy+ZAq93g0C1hq8lM6DebrvblRfH1HdkmwStDUJDxvFzWVgT
	u4EktFfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNcpw-00DK8d-3D;
	Wed, 10 Jan 2024 17:57:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNcpu-00DK72-0c
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 17:57:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DC326617EA;
	Wed, 10 Jan 2024 17:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD99C433F1;
	Wed, 10 Jan 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704909472;
	bh=/aVUftzx5R6EVk2Wz8C/SG1p3tg9lFAKcrt2WO5Hq6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKcO2UJw0ZM3KywBws0bnPDwwbfKKvx1NgVgWMcNCE0eWwWW29585tNE9ms2Njf0W
	 TKf0bW+fj/ctPMv3KESY5iVQCJYzc8QjGeFTPAZqt50hFGoJfjExObL8+h3XD+noWT
	 CzjosJfjr7/7qyRkVNfn2gXFqBlnh1YPT3ehlPfjOenObJPmW1dXMwKKDX4qip/Hrd
	 CZHSV94psbBM8sPI/RM1f/s2h98nWjYTWx0KNVgYXnONyTsPN8x95uJXD0qWqbTTek
	 bPpBdXZd5tzRIm53Wybh8OjMpRHVStXCaTf/RrQ8JHtdZyqohIBO5vhcZcaVfEz/AN
	 1WhoIZ1J9gPdQ==
Date: Wed, 10 Jan 2024 10:57:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: support reservation feature
Message-ID: <ZZ7anaPnLxW1_Byt@kbusch-mbp>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <ZZ1713_D7MojvHUu@kbusch-mbp>
 <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_095754_293070_FB74F853 
X-CRM114-Status: GOOD (  16.87  )
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

On Wed, Jan 10, 2024 at 11:19:20AM +0800, Guixin Liu wrote:
> 在 2024/1/10 01:01, Keith Busch 写道:
>
> > User space could be listening for them. The driver doesn't have any
> > particular action to take on a PR event just send a uevent.
>
> I will analyze which uevents need to be send and implement the
> notifications.

Sorry, there's a part missing from my reply. I mean the host driver
sends a uevent for unhandled AEN responses. The target doesn't do the
uevent; it just needs to send an appropriate AEN when applicable.

> > You're checking opcodes that we don't even support. I suggest we stash
> > the Command Effects Log in our target and trust what that reports to
> > deterimine if a command violates a reservation so that this function
> > doesn't need to be kept in sync as new opcodes are created.
> 
> You mean I should check the opcode is whether supported?
> 
> If I put the checking after validating the opcode, is this still needed？

What I meant was using effects to see if a command would violate a
reservation. For example, instead of explicitly defining a case for
opcode nvme_write_cmd, you can check the log page for the LBCC
attribute.

