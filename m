Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F085FC001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-ID:Content-Type:
	Message-ID:Date:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:
	Reply-To:Content-Transfer-Encoding:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYjHp3o9P8Cia+iW9Qd/SxIqGvJuLOpQ7rbxFixcDkc=; b=MTXFw9ibHGtuIlzR6oDV4rARI9
	HdjI1Y82w4FybXJTC07PTYx9qYRg2yAD2USv4eseOQ2/R7NhXMibTzVvnTB6faCKiADiRl5a7zFiD
	xLJ3JB26TQsToGtErUbO8ONtaJLkDoG85m8BKN1T5lLRlTDRAXo9/wz6liE53WS7Jah0N0oQHkiKM
	sa3OyZZK2rKyJAaL5CTHW1MH9lnI2Nb2WxQAV8FOp+5ZhPpH0q9dLaDExtGOuOIH7HyWgaYwkZAwC
	ReOPjEh18RzJKkDgM3sdZTx+3RDsB/5rVWWVxNFi0Mjw1tylw0vvuiUtY2xOjJQ7gioA4VZuYsPM9
	qeh7BMow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5v0-007m90-2H;
	Thu, 10 Aug 2023 13:41:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5uy-007m7u-0s
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691674892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYjHp3o9P8Cia+iW9Qd/SxIqGvJuLOpQ7rbxFixcDkc=;
	b=JdWhrfkTXx81zloqsvWVJEdpspeb0uHB0wC+61VK3JJVhx8G+I5jiU3nRN/ZVE7qJ8k+im
	9TB/QQB5kVzLWiqcQzOZ5WZwOGFJfgJNhecm0rGNM/ZOy2gy9JTB3QcUEAHZSsQszeL3OK
	YWiZj4pmU2oNpgHimLpgZhRzVuIhY1I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-OeaAztSKOAebCNx7pnd1dw-1; Thu, 10 Aug 2023 09:41:29 -0400
X-MC-Unique: OeaAztSKOAebCNx7pnd1dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 885761C0E0CD;
	Thu, 10 Aug 2023 13:41:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE0E81121314;
	Thu, 10 Aug 2023 13:41:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230808165354.123499-7-hare@suse.de>
References: <20230808165354.123499-7-hare@suse.de> <20230808165354.123499-1-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/16] security/keys: export key_lookup()
MIME-Version: 1.0
Date: Thu, 10 Aug 2023 14:41:27 +0100
Message-ID: <3481012.1691674887@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3481011.1691674887.1@warthog.procyon.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_064136_384316_C5E0734C 
X-CRM114-Status: GOOD (  18.01  )
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

Hannes Reinecke <hare@suse.de> wrote:

> For in-kernel consumers one cannot readily assign a user (eg when
> running from a workqueue), so the normal key search permissions
> cannot be applied.
> This patch exports the 'key_lookup()' function for a simple lookup
> of keys without checking for permissions.
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ...
> +EXPORT_SYMBOL_GPL(key_lookup);

EXPORT_SYMBOL() please.

Otherwise:

Acked-by: David Howells <dhowells@redhat.com>


