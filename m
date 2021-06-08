Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F7C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023CE6127A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023CE6127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLms8daZbCf6sI5UTfIJnTRWZc42Gey1nV72lL9mgxA=; b=rJuMBo6mfBk2Ml
	dnUP+I/bTLfWpsYtqzVnGEdZhYc7P9wJCAZpKDxW2lNr6i9HUthaLovv4l0B8dpPwp8iuXqWoFQNJ
	b0XNXlfg++HVMqZgdVdV6GH6DDaRALPc7phbSbS9XWmmLUrj/hHGMownp3DX2klPyKGNfmp9QTmCc
	qqmQHXXeNmYDIz8tnvv7ViF6MwcEAb/zG1Ie+/JL3PkZRaDZPrTfXXi2SMRoK+saJa18gpB4s9Q2d
	KX/uxHhA33wltioRJGo8tq9A45/qULTmBeAmLe/AVDcTwWYGxpIHCAvavPHdy2Kw9susK58AaSbI5
	gFxqXu6T5npLbYzOazpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqeoX-009Z9H-C3; Tue, 08 Jun 2021 16:42:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqeoU-009Z85-Hz
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 16:42:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C3BD67373; Tue,  8 Jun 2021 18:42:48 +0200 (CEST)
Date: Tue, 8 Jun 2021 18:42:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv5] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210608164247.GA12430@lst.de>
References: <20210607133435.138525-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607133435.138525-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_094250_775519_8335A246 
X-CRM114-Status: GOOD (  14.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While I do like the look, I don't see how this could actually work:

>  	} else {
>  		ret = -EINVAL;
> -		if (!is_shared || !head->shared) {
> +		/*
> +		 * If multipath is enabled we might hit an ns head with no
> +		 * paths, but that doesn't indicate it's a shared namespace.
> +		 */
> +		if (!list_empty(&head->list) && (!is_shared || !head->shared)) {
>  			dev_err(ctrl->device,
>  				"Duplicate unshared namespace %d\n", nsid);
>  			goto out_put_ns_head;

When we get here with an existing ns_head with no namespaces attached
to it, we can assume it once had namespaces attached to it.  Because
of that NVME_NSHEAD_DISK_LIVE will be set, and we'll never add the
disk for it again.  Even if we did add the disk again what prevents
adding a disk and removing one from racing with each other?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
