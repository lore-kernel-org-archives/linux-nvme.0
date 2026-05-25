Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7606CD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mEvp6E1uZYwArkSwoi+Vn08rs5/YXn8OrbytPCNf47Y=; b=D+eF4Qr87a0+vQkSHHwGCHsU3B
	9YNDxqLEmzXGTQqnbtm3ZsShn7iMVZ/YtDXKSuGFQrth7cUVnxE69ig/I1yVtMANHPCnhJevo7zrB
	wUSJ/GgBdtIetZQPm13wKOfhf8LmUXGWbmpaA0rZQ2NvrOKiVS693rmD5XjsdzRkfPfYw1caXF5uS
	omHJ302+jKTB7i1hozPB0mRVhEo/JwexD3TSOFnTMeaVvnY58ozFaTUUD1pvhp8e+z1he2Kst8Tvd
	N5oL2wZulr2xKNUiXiNWTYNhL2nvAXy5iE1RrnTdUAX9fejDFVD9djYtGVBUqBWrPbOe8IAeUVAO4
	Z6N2+Nng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRa9N-00000000F6s-1bXK;
	Mon, 25 May 2026 18:35:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRa9H-00000000F6N-2xSA
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 18:35:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E34943B24;
	Mon, 25 May 2026 18:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110DF1F000E9;
	Mon, 25 May 2026 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734134;
	bh=mEvp6E1uZYwArkSwoi+Vn08rs5/YXn8OrbytPCNf47Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h5hqwouB/XaiUavPuT1WP/R1PBl7lwm33dHIHA04m10yywq7BEH5AAqxRaRYNtYFx
	 VPD6EVLU192q+09/AtaArq24xoRD5Uv9sG+MqTO1+6Kbp0EsnyHWyOhtf6q5Lviier
	 uLCjuqCGt5kpiuVXm2yeh7YraNj9/XyyX4rO0LRCGMdXZpAeGUOgHCahBHKeobEkRz
	 6xiJKyMpqVYjDF3R+ZfRe3F7JRQ/Mhzy2hIgLao5EynYOvH+bzBtQyaNr86cO5Bpya
	 dJd8bjUL/g6Zlx3F6Y1gWqZa3KEnYGLYH/SfULjmT2NFRbA/0UHDEBNKziBsCffTl/
	 R9sZmP9IPb5FA==
Date: Mon, 25 May 2026 11:35:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chris Mason <clm@meta.com>, Christian Brauner
 <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@kernel.org>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a
 pinned file reference
Message-ID: <20260525113533.6405efa0@kernel.org>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_113535_775758_EE054F34 
X-CRM114-Status: UNSURE (   9.30  )
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

On Thu, 21 May 2026 10:47:06 -0400 Chuck Lever wrote:
> Three things in this restructuring want a careful look.  In
> handshake_complete(), the fput() of the request's file
> reference has to come after hp_done() -- fput() can transitively
> run handshake_sk_destruct() and free the request, so the patch
> stashes hr_file in a local first.  handshake_sk_destruct()
> itself is kept on purpose: it owns rhashtable removal and
> kfree, and remains the backstop if a consumer path bypasses
> handshake_complete() entirely.  Third, handshake_req_next() now
> returns its request with an extra get_file() held under
> hn_lock; accept_doit must consume that reference (FD_PREPARE on
> success, explicit fput on the fdf.err path), and any future
> caller has to honor the same contract.

Sashiko indicates races with handshake_req_cancel() remain,
and impact the code re-written by this series. What's your take?

