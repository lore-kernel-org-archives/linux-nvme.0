Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FE7C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2oqt9w9se5xqD0xq3HO1YVubTWdxt3SKIiZ823pUMhM=; b=E97HGtWjPX2Q7KhofR5Obly6fw
	fimUidjzlMeigPAR9Ms2nIiKReVSVeJjJMwG2l3aiesZ9QIaRadDy70RK7gQlBMT/aH+68rzNNdfh
	/J8lRHbthr020xusb8Nxzm4TfGmKjmYwiZGltW93UFfygPuUbT6TJRC697NPTEy/Sp5jMEoAV2dSg
	Q710ktj0E237+tU2BD2zi76KOT4w6M0Xc8UzDPijZNE/y2QGuVQx4a1yrv7lPWshTQdraE9dRwZ0e
	ZL9MWSG6o+AFfoaxVEKl+oPpsT935fm15vRpxCCBn7VnRvWwV29sMSUWEzsL27qRscvVZ2SMUix2s
	6o7YBeTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puZxc-0085bG-2Y;
	Thu, 04 May 2023 14:29:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puZxa-0085aS-0r
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 14:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683210567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oqt9w9se5xqD0xq3HO1YVubTWdxt3SKIiZ823pUMhM=;
	b=F3PADjC5+/weqCBCsjUBjjn/vcnUXNrNcXL4AdAjRgLT9z/cDLxWODUooNBZ5REX6WdOnY
	puaH3a050HlEpLqARwKYoTfwD+uZA/qDZU8RWSXkAXqFbxPgBqWQuNn9VrwBuKPdG/griW
	eYrQu3EG3ZmHp6tnwdEYdcajAF6+QuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-A0_kp1gJPtGgj9ECZFr1Qw-1; Thu, 04 May 2023 10:29:22 -0400
X-MC-Unique: A0_kp1gJPtGgj9ECZFr1Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F22685C6E2;
	Thu,  4 May 2023 14:29:21 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D29801121331;
	Thu,  4 May 2023 14:29:14 +0000 (UTC)
Date: Thu, 4 May 2023 22:29:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH v4 2/3] io_uring: Pass whole sqe to commands
Message-ID: <ZFPBNWx6ZqYxiqB/@ovpn-8-16.pek2.redhat.com>
References: <20230504121856.904491-1-leitao@debian.org>
 <20230504121856.904491-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-3-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_072930_394303_F6413624 
X-CRM114-Status: GOOD (  12.82  )
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

On Thu, May 04, 2023 at 05:18:55AM -0700, Breno Leitao wrote:
> Currently uring CMD operation relies on having large SQEs, but future
> operations might want to use normal SQE.
> 
> The io_uring_cmd currently only saves the payload (cmd) part of the SQE,
> but, for commands that use normal SQE size, it might be necessary to
> access the initial SQE fields outside of the payload/cmd block.  So,

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, there might be risk[1] when accessing SQE fields which were read by
io_uring core code, and I'd suggest to document it in future.

[1] https://lore.kernel.org/io-uring/ZDlcXd4K+a2iGbnv@ovpn-8-21.pek2.redhat.com/

Thanks,
Ming


