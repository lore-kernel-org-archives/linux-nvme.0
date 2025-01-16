Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222CC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 01:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=badvh6S2RxULwIaqqX+hsOhudrZdjvKK1XCiRZLW5yQ=; b=nhQ0jNn8AX5shGJAbAbAXvn1If
	xFeCD9c4Nr67k7e5ZVL6XoH1k6JEKsQBctLAXrBEQL8TJU5pVaZcl3GRsLz5kLCuYv7CuIJLaJR9N
	f5iTfnEJOAjjAQAI5M3BE3ER0CAGNdCC3PA2Xvh6/7W2FA81+anDSYiiiRZaD0JBubFuziUZMtICt
	QMM0FxZq3OQDZgVVaXHxVzex+rsNr2VVW2Du+Bpt+Pt3pvY9zohmpYolxwbO3ciuoqN9hHmAs92rX
	9PHa56w1POzefGO1uvOZpjGISnY6ZNR6dOiFZsnDR/tAjK2jF8vUYAnU1Ub1rNsuA84r6EGpk7z1Y
	lqI7ZNfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYF9l-0000000DaZX-3lPS;
	Thu, 16 Jan 2025 01:58:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYF8Z-0000000DaN4-28w5
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 01:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736992653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=badvh6S2RxULwIaqqX+hsOhudrZdjvKK1XCiRZLW5yQ=;
	b=F/28dhwm0lljvTZVmZUw5bwC/YSMjKYhpMsOdiZ+0XMbYh1MEjacfrMR0ShDjfkvzDe28A
	UTWYyktKkXIHiKqayRWqjz5Om5wz/QPlxK7gCKLdOmAXfxZ/25BCg4IDdhDTLT3hLqPCvJ
	b+DO6xEe1bHmLkmH9roZGuSKIH5klhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-3_bf_zHkONis9F1KvVqoEQ-1; Wed,
 15 Jan 2025 20:57:30 -0500
X-MC-Unique: 3_bf_zHkONis9F1KvVqoEQ-1
X-Mimecast-MFC-AGG-ID: 3_bf_zHkONis9F1KvVqoEQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748391956050;
	Thu, 16 Jan 2025 01:57:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E647C195E3E0;
	Thu, 16 Jan 2025 01:57:22 +0000 (UTC)
Date: Thu, 16 Jan 2025 09:57:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ewan Milne <emilne@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Marco Patalano <mpatalan@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
Message-ID: <Z4hnfSFc1hobsN7g@fedora>
References: <20250113124446.830697-1-ming.lei@redhat.com>
 <CAGtn9r=bqfqm6d0ipf6pc5Rure=NdkxdX+K=gTp4iAQ6qUYVtQ@mail.gmail.com>
 <CAGtn9r=pJjpZVoGt9deesQxv=G9tC4r8ZNAWVX2nTErQWAo3Rw@mail.gmail.com>
 <CAGtn9rn=rUsaOACWyOLAx2=E++WvStwtQwyXZR=kxYmuCQQ0_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGtn9rn=rUsaOACWyOLAx2=E++WvStwtQwyXZR=kxYmuCQQ0_A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uwtkUdyrbryVGyiae1nzLmzczTyGmlWbHFvXlb1vtl8_1736992649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_175735_624154_B4249EA3 
X-CRM114-Status: GOOD (  13.31  )
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

Hi Ewan,

On Wed, Jan 15, 2025 at 12:33:50PM -0500, Ewan Milne wrote:
> Moving the tagset removal to the end of nvme_fc_delete_ctrl() ran OK and we
> no longer see the WARN_ON() seen earlier, however I think that there is a
> potential problem with doing this because the keepalive is not stopped until
> nvme_uninit_ctrl() is called.  On our systems w/FC kato is normally disabled
> so we wouldn't see any problem but this isn't true in the general case.

Please see e9869c85c811 ("nvme-fabrics: fix kernel crash while shutting down controller")
which stops the keepalive request at the entry of
nvme_remove_admin_tag_set().

So your above concern shouldn't exist.

Thanks,
Ming


