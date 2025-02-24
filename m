Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D79C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5jZjuYCmFu17MIcSQirIuPFbnpu7bro8wwtbQoAgko=; b=LrUKdeUIYJGazdn8Onz/dUt/K7
	xs03QDPpXlpTuKxvZse1BvjAIluGu2VFrLECva0SGX2tps2qYfjVzMK2DAMZ/aIRGsri5lTSEnsB+
	Dy2oeHKiMv7BNSgQf7cVFkOj+ne9eOwE98u4Xx82BzBVpwHY9S/AJ/B1ZFp5Be8TkcF1JEld6a40w
	7WgioHI0snBTTtwUMZHYfwS0aM4bGYpRk4ztX+T8b7CxfSGR0CYy+fJYjEJPoI3hpheQSkgfvN3Is
	zLpXTleUn6nrD4hVcoUDHFf+JSSS+vZbeiOh1ayyII9BwYoVoD7xR7phV7fi7H5F4EDEd6VGGhfoc
	EvVeqSlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbdN-0000000EUUo-2Ch1;
	Mon, 24 Feb 2025 16:48:45 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbdL-0000000EUTm-0TUH
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 16:48:44 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 5ed13e02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 17:48:40 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 17:48:38 +0100
Message-Id: <D80TVRHC1LFG.RHYVKMPXX3DF@bsdbackstore.eu>
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <hare@kernel.org>
X-Mailer: aerc
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
 <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
 <0e3af565-f8e6-4647-89c3-6757f6bae3a6@suse.de>
In-Reply-To: <0e3af565-f8e6-4647-89c3-6757f6bae3a6@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_084843_485000_0BAA20A5 
X-CRM114-Status: UNSURE (   7.91  )
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

On Mon Feb 24, 2025 at 5:04 PM CET, Hannes Reinecke wrote:
> I really wouldn't be doing that, as we need to terminate the queue upon
> fatal error and don't really want to delay that (eg by waiting for the
> transfer to finish) and

I did some tests and it seems to work with MSG_DONTWAIT as well.

I am just wondering if calling kernel_sock_shutdown() could
in some cases race with MSG_DONTWAIT, preventing the packet from
being effectively sent.
Not a big problem anyway because, as you said, it's a kind
of best-effort thing.

Maurizio

