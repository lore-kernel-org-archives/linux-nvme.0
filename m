Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B962BC021A9
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J79TEdXfE+iWaaIa8MfgOKZ3/zOHHAHWGsYVnbn7NJ8=; b=IZzsMznCUzTFVgVZfj+Pk5AZYK
	yszV12qu0Q0CvtPaTUd+Z/S3QADnwCuQnRDiiGbSY8qbdWgqEdxetfP3YRC8fCKhJHSe4tqa/v5UQ
	9YpWHETirtQJVbaJjXUEJuSM3s+g0+um9HovhQLY+sY5fKL89VNQ1abkc12tm0z9ar5WhltLQk5cF
	a+EXwpHW/SO89N4b1AmfFAwkFTm0Qb4DHiypoKKPDOjxU6ZSN6a6JVat4ZLPPBm1YyRjEmhvlBMRY
	FBX1wTBrA/tiJGB2n25RG4ReQZdztvFXd7oAaIFOQHh99f2sxUxoTl4zvTuH+56ftmtD1BHxy1r+a
	QLL9/36A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk1Gc-00000004geJ-0nyA;
	Mon, 17 Feb 2025 13:34:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk1Be-00000004fTQ-3bYl
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 13:29:28 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 5f287c8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 14:29:22 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 14:29:12 +0100
Message-Id: <D7UR98V9I95P.27RWOE2DTFULD@bsdbackstore.eu>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <hare@kernel.org>
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
In-Reply-To: <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_052927_230773_EBC5F865 
X-CRM114-Status: UNSURE (   6.24  )
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

On Mon Feb 17, 2025 at 11:56 AM CET, Hannes Reinecke wrote:
>
> Can you add support for nvmet, too, such that we can test the patch?
> (And maybe even a blktest script for it?)

Ok, going to look at this.

Thanks,
Maurizio

