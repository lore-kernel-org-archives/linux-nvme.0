Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFE9C3ABC6
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJsNGbaefMw7bdsKH+G12242Nnl3+FvdB8oePEJLJb4=; b=r/poKO6ndqVxqXY/3S8pSUKmys
	PTdMmTF3QSb4mQD46EJYFddWasYnzchT+ZElDAtkjdVyColCgKP1PlmAgmZyQ3vuq25oRE+djOzGW
	S/8vDoil5EsWMNDE3s3hF9Bg4+aP91ZGo34oFyRHs/HJFmD5m1LGM7R/y+qZrze4nBcUJtdbuAIuh
	/XqpejzMdhSNzeptdgqojtrmdf7UjyD5xAvJlfjYGGF0WwNpWWBX9gxKgnpYyltunEIh29QrqGxOW
	ZqPI4ec3dLy+MtBlQ+GqvOtTRHzB9HwRW2Cx869UXi3kwbiPfeqXkA8BLTZ1bNM1Ni7FiwdsQojKj
	PbXNnEuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNAw-0000000D7ue-3nDz;
	Tue, 06 May 2025 18:37:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJZD-0000000CNRm-1zQA;
	Tue, 06 May 2025 14:46:43 +0000
Date: Tue, 6 May 2025 07:46:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBog09quIh39IL3W@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
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

On Tue, May 06, 2025 at 03:03:10PM +0200, Hannes Reinecke wrote:
> Hmm. We do that already:
> 
>         dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>                 qid, pskid);
>         memset(&args, 0, sizeof(args));
>         args.ta_sock = queue->sock;
>         args.ta_done = nvme_tcp_tls_done;
>         args.ta_data = queue;
>         args.ta_my_peerids[0] = pskid;
>         args.ta_num_peerids = 1;
>         if (nctrl->opts->keyring)
>                 keyring = key_serial(nctrl->opts->keyring);
>         args.ta_keyring = keyring;
>         args.ta_timeout_ms = tls_handshake_timeout * 1000;
>         queue->tls_err = -EOPNOTSUPP;
>         init_completion(&queue->tls_complete);
>         ret = tls_client_hello_psk(&args, GFP_KERNEL);
> 
> ... but we never evaluate the 'keyring' parameter from tlshd.
> Should be easy enough to fix.

That is only used to link the keyrind in tls_handshake_private_keyring
and never passed over netlink.


