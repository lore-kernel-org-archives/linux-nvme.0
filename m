Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FADCD98DA
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2026 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LmNnXOZQDfZlHIGLnJdMNdl0u37HO8ry7TKzLqYHyXI=; b=UBrOAG56RxCySl5AWk8lZ+bTnW
	9NRKst9uSARmHQEhaNcfpxeQA7U+DwPiDNPK7I/xq+C/6siT1zUY3LZUXKucDtrbh8TvbjeojYZnd
	VaYLwbDGCIsGt/qTTBHqb5hsUZrvqPf+xWgoqc1KLY2IY1xAsaxOb4E2PrC3cHEDYLcLzpQKSQjDR
	8MtEVWaVljOM+uvmlX0YPf/r608z9H5XfU2BXPzea0VPGJd/+shyTj2VWhoAEjRA6roWtcCt6hSux
	flmXl0pfbNe1eF9KNwuaKCmzU2oi8LmPQyVHj/6AG7zXoys5dy48v8BSffgUA+XiTt8FNt+h6PyKJ
	Ru3frR/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZPpG-0000000FVKM-1xh4;
	Tue, 16 Jun 2026 09:11:18 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZPpD-0000000FVJu-1fdO
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jun 2026 09:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=ocDPj1kcf3YrV5
	ATMrHOQMx5TUbcUx3qP3WFu5fA9bc=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=HXKnt0JlzGd2Zivhsk1PlnyDGhsX+w7Ty+/bZ
	VrpRa7jm7Hg58Kog6Kn/cUEQhgPeWs+fIQB5u7IX5ykTrFLOFvB5BKXWv9jteaVOfPtzqL
	TJ+3gBbJ0H7tRJYFXbevldbSY9ryFqUYeQIV5jBFAfX5gUzE24PyFaAMei4AXO1JSCVtFT
	fzmyQVOj5dOlH3+7+xe4Zmumshc9p4DMzPhEjacFT5Ly3yNlxb5yo1Rotgp1xWNkbJ7E98
	6+mGcbDv3TVs0pP1toBy+yToA8TukUqJfWJP6qHHfaQ8HlzpzuYwsKybMCZPyxlleb50Dx
	LsIX2ivs8Kht48pGEBP1ahlFQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 3a45603a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 11:11:09 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 11:11:09 +0200
Message-Id: <DJACVCF5YTMZ.3TWM3MQYJCMA@arkamax.eu>
Cc: "Jan Kara" <jack@suse.cz>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@kernel.org>, "Christian Brauner"
 <brauner@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
In-Reply-To: <20260613111437.101763-9-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_021116_100199_C126EDE8 
X-CRM114-Status: UNSURE (   9.25  )
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

On Sat Jun 13, 2026 at 1:14 PM CEST, Hannes Reinecke wrote:
> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
> nvmet configfs namespace aware.
>
> +static int nvmet_add_port_list(u64 ns_id, struct nvmet_port *p)
> +{
> +	struct list_head *port_list;
> +
> +	mutex_lock(&nvmet_ports_mutex);
> +	port_list =3D idr_find(&nvmet_ports_idr, ns_id);
> +	if (!port_list) {
> +		int err;
> +
> +		port_list =3D kzalloc_obj(*port_list);
> +		if (!port_list)
> +			return -ENOMEM;
> +		INIT_LIST_HEAD(port_list);
> +		err =3D idr_alloc(&nvmet_ports_idr, port_list,
> +				ns_id, ns_id + 1, GFP_KERNEL);
> +		if (err < 0) {
> +			kfree(port_list);
> +			return err;
> +		}
> +		WARN_ON(err !=3D ns_id);
> +	}
> +	list_add(&p->global_entry, port_list);
> +	mutex_unlock(&nvmet_ports_mutex);
> +	return 0;
> +}

Just a minor thing that I noticed: the error paths leave the mutex
locked.

Maurizio


