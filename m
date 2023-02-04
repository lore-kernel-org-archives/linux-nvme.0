Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA8C636D3
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Feb 2023 03:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP0zd+/kgeurbE7inPJPQwOrnP3UZjvGO/v7NbOG+A8=; b=zczqm3+tCjLa9zIy6hvTJ5Vhnr
	OKXvbg0dxWinGP8hstuqEr9nCCABewLGhzBW+pWLascX+15n+cYTy9LHDOXqjEa3gRCXhSv0ou3BW
	iGV0TfAZgFRKkii2A9qJCJrN1LoB5uSb62WbFjR0zEFUtrtZF7m1Z+pPXYWE+Sqpb/XaIIGJQ7avb
	Sx9EnPKKzx3I2OpkHEUPFEvBE1hMmFVsYrt91/CwDNV4taeTl9khJezeBPewTFu23OVSIlxeDPZBR
	Fu3uRPldojP+++q/qhrKXl2VVTudsRERTK11VTNgvtnGvbhQFZgDHIi+AYEdUehXoHxOw94zZfHel
	62tGLu+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9Vo-004NMe-A1; Sat, 04 Feb 2023 03:46:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9Vl-004NM6-04
	for linux-nvme@lists.infradead.org; Sat, 04 Feb 2023 03:46:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4A2D06203B;
	Sat,  4 Feb 2023 03:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CA2C4339B;
	Sat,  4 Feb 2023 03:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675482402;
	bh=GYVDyk137AVRx3mF3z/QJHZl7iFfZl9EQ8tG6LElj3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3vBD0smJFaLptaqKa/q6n1c1zxeWEPP84gqPSGrHML067NUxrb+c05eCNQLUJEfP
	 ZAcSz8bbqZEPVwHyzGYGRgxuq+6JrFUTTiFrtpWdi58tJfp4IGK7gTavBl7DuM+OiZ
	 Gm9RXft5Jg301swKwIzKfzTrka9mKH4xu/G/YgoDU3228S+DBLEAQfUeUUbXUuAq+L
	 QlohYhGJXf42zFKu++o37GXJZQ0r5oBOcAvTrS5RuCxSY2+za6X22fjTYUd1YBK5ze
	 8dFkeVyHSdfv1e5hrmjCOSl34zWyGskXBJIJW1OUcZvWPyMRCHmbRu3RAW+cE7MRXe
	 WWlEaT/acQBkg==
Date: Fri, 3 Feb 2023 19:46:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v11 03/25] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <20230203194639.688d39f6@kernel.org>
In-Reply-To: <20230203132705.627232-4-aaptel@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
	<20230203132705.627232-4-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_194645_110470_3CDE0C57 
X-CRM114-Status: GOOD (  10.38  )
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

On Fri,  3 Feb 2023 15:26:43 +0200 Aurelien Aptel wrote:
> This commit adds:
> 
> - 3 new netlink messages:
>   * ULP_DDP_GET: returns a bitset of supported and active capabilities
>   * ULP_DDP_SET: tries to activate requested bitset and returns results
>   * ULP_DDP_NTF: notification for capabilities change
> 
> Rename and export bitset_policy for use in ulp_ddp.c.
> 
> ULP DDP capabilities handling is similar to netdev features
> handling.
> 
> If a ULP_DDP_GET message has requested statistics via the
> ETHTOOL_FLAG_STATS header flag, then statistics are returned to
> userspace.

Acked-by: Jakub Kicinski <kuba@kernel.org>

