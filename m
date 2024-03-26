Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D2C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/knT6/SOepQTrGlPW28RCg6VHfQTOQq6nfRNbCZIObE=; b=vgxf9ibrGQ5gt+y0G1OCLIq1Bu
	Tv/TZyI17FyIFxRO7TTstbksWQi7Q6oOpdaX/kXuLEu0mEsJPkqXW/7erSTyATlqs1WIP+s2O+A+/
	XDY4H0SIK+5b3yBfH7wWUCqGdJzCaYGeRJ5ud6U4A4iTJyxVaHjI0azFtYUcQeNW2NOWugT53iMfr
	dKocqfb4QmOLYrGFq9+YuaCp09rICZQAzGbaFMVKj9SbylhaxSLrSawQuyWREWGZfAaUM/r6hNIgN
	sRZwTmrZ/cEM5GOtCy1oRjQy2exbQD+5BSylbLoAnOr7bswgstBLrRjx0T1smn38YkqEmVkR94Dl0
	ez8WPqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8s9-00000005EFf-3TYE;
	Tue, 26 Mar 2024 15:37:57 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8rS-00000005Dca-0fRE
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 15:37:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D8E6CCE2272;
	Tue, 26 Mar 2024 15:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6906CC433F1;
	Tue, 26 Mar 2024 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467431;
	bh=vKEX0AgAJUxDwYAe3RTNxqMJQv7lNPPP+smh9/aBopw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQBMtYkLnedgslterOSUxAku/GdNIG2nNyiVe0O01RF04+juhMx1ljJZXsputw4Vn
	 YOb5wpqJUmRTRzDAVPOkrgK65UjqF1FYdMZGFtx/uvhLARVQxeWt/QcJu27AAJNyH6
	 23cx1RBUuqhaSE3TlSbM+LZ7QWUoa79n6k+BH8fljWRUuKDIioS8vb7Q2wlOXeRh6c
	 KNlDbSQKqS+o24FoopjyWwtvGg2mGXvN0Cyx7VVCDg+38v6SO8OEtJ+tpvMccuvntu
	 SqKuZMNP1DQ7n3Q1ml9KEn8QMViW+uhN1NtYI1fUzGjZ9LQ6x/pfRJfmWJkt6dw8/0
	 rYd0men5IHBpw==
Date: Tue, 26 Mar 2024 08:37:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Message-ID: <ZgLro-TUD821wu16@kbusch-mbp.dhcp.thefacebook.com>
References: <20240325154503.11510-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325154503.11510-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_083714_553641_2FC3C2BA 
X-CRM114-Status: UNSURE (   8.79  )
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

On Tue, Mar 26, 2024 at 12:45:03AM +0900, Tokunori Ikegami wrote:
>  static int ns_head_update_nuse(struct nvme_ns_head *head)
>  {
> -	struct nvme_id_ns *id;
> +	struct nvme_id_ns *id = NULL;
>  	struct nvme_ns *ns;
>  	int srcu_idx, ret = -EWOULDBLOCK;

This is a redundant setting. The first thing that happens to "id" is
reference passed to nvme_identify_ns, and the first thing it does is
this:

	*id = kmalloc(sizeof(**id), GFP_KERNEL);

So either kmalloc succeeds and overwrites your NULL setting, or malloc
fails and sets it to NULL again.

