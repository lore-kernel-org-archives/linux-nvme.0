Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB4CFD313
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gx+YBPwNjOKDiS/OvSawhzYaH9sUldgY20/oZYtw37s=; b=r/2N4ZSPP/V9mG+zAx4vfAu9If
	2tkdDEjwWXzpC2RtzMwaswD9/wbCp+lmAWxdNZf2SK8wcNwt9SCxuRD+yR5cAO2Vv5cwCGaQUWUVh
	Ol4ixp4sVoudAMod3NZPFfKJvokuL/F3Jjv25EfKGNo/WszTLPwlkcBBRaER83UU0YejLpF7oFJoo
	sal5SM2nX9NGlp/okXKSQKuFjy5P/Kkren8OKAarIdDegSmvM6LEj9WDabVw6+syTNrAIxCso/QyN
	jVnc3BQ6U9yYe3Adf1AkqJsG9EoSeY7hPCPwrXRajwQTlET+hA05ktDnWoVvBk34sk8xENZgEtxSN
	RE1TpE8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcMm-0000000CFr1-1bZ4;
	Mon, 24 Nov 2025 19:36:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcMj-0000000CFqR-3IzU
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 19:36:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 75FBD42AD0;
	Mon, 24 Nov 2025 19:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD3BC4CEF1;
	Mon, 24 Nov 2025 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764013009;
	bh=OL3okPX96JuUPTbgrH0HQh3n0Y+t1xonvad58NS6QR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkF8qjzEbL1qbsDR5Xhkoxw/RIUPsyEbr6e6nxVk1Ne513E4gFIfzKj7VHuO0fP8+
	 3MH1vnb37SJwWNOwjyDCu+xvNH64+FtYl5rCWGPm0om+tWdRKJIzuezSS+tlbFSQmO
	 QbkVcP1e/UAiNXJDLFlPRtWomXMJWk+63vtIsiM1FYYeSgxJb42oZPqnOMVp/vCPOA
	 RcR8Cu9yVxOK6LjIczast3OaNOjCNi+oEuK+EdrPX+zIeg3/Wm5dhZ4YHN7vwyW9CV
	 6CQVXyginIf0fg4dgvoUxI0tmCywVTbpKL2q9kfV2e6OdVb3VsAkuL8YReVFq6S1bS
	 JfjlHElfRX9LA==
Date: Mon, 24 Nov 2025 12:36:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jsmart2021@gmail.com, justin.tee@broadcom.com,
	Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
Message-ID: <aSSzz0yCClwk2p47@kbusch-mbp>
References: <20251117184343.97605-1-justintee8345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184343.97605-1-justintee8345@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_113649_842180_CAB5D688 
X-CRM114-Status: UNSURE (   7.67  )
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

On Mon, Nov 17, 2025 at 10:43:43AM -0800, Justin Tee wrote:
> With authentication, in addition to EKEYREJECTED there is also no point in
> retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
> criteria to determine when to stop retries.

Thanks, applied to nvme-6.19.

