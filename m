Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2AECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 04:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=T/rYEC5v0fansJqDZrGtiNB0hi
	HSVrhrg9beZy/nrwaF89RRaJ+u0tW9pFQFfWBC34dYaKmo40ITSlpFrYf7BBusr+jSRrI4LAoH7JF
	UfxX0xur6hvjmsd1on2TA7s3hUQLIQau67fJNoAyyM9kpAvk7vCwJb8J7WsMRcS7hDIFazh1wNXOA
	i/AvOi5BL4V/XKiPjO1s6yNVOumYKUoBEv4T/O1tJeDHCsoqeT7p736ozemncHA9mU16uvnEVKjRI
	5yI6x3vkYmKKIolVaCwddmDgEEpQacVP7G4VuGbJIiAwh2E8IijVZ4cXFxcAAh0c9my8QYyrNI/LN
	AJnOe6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFoS-003o6l-9m; Wed, 31 Aug 2022 04:58:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFoO-003o48-JD
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 04:58:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF96368BEB; Wed, 31 Aug 2022 06:58:45 +0200 (CEST)
Date: Wed, 31 Aug 2022 06:58:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de,
	kbusch@kernel.org
Subject: Re: [PATCH v2] nvmet-tcp: fix unhandled tcp states in
 nvmet_tcp_state_change()
Message-ID: <20220831045845.GB18042@lst.de>
References: <20220829124030.1194759-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829124030.1194759-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_215848_812953_E71C3059 
X-CRM114-Status: UNSURE (   7.97  )
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

Thanks,

applied to nvme-6.0.

