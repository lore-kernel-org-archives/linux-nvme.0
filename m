Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F88CDE001
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hD4FEc334k5p7wS+1EUZv0M3YDlfeRjBdxRkz3ymdlQ=; b=xs+b6PVY9xz/VkHh6+GjkwVPkc
	LArtVTpnmtOQRIsXX/DHzn/fUzAaGGfK3iE2GM0ViE3wBoxl6sAK8tgvIQoU2t6hbwXuUuI4fn6BA
	GjOrP7CIF050iwmNZhslDMjt0Sgmwne0XKWxpu2CfSwNbTRpvkvWVueToO5peloTjcwf6ryUeB+mz
	oQGBkpISZWVth5UNTmutCCmVyfGC1GXqNu8fr8I/GSUCMSmrv7xwnsDrz76i3febbxuD5pw0gOMpr
	A+MfjHRB/X+8PCLbv8nJ/6vFkKBWYlMn5azw7ywwjRg6eYV8XksO7jAWCjyXAb3rU3HMtbAKrM4g5
	My2a7Rgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcQ6b-0000000856z-2sh0;
	Wed, 24 Jun 2026 16:05:37 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcQ6V-0000000856M-08kq
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 16:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=hD4FEc334k5p7w
	S+1EUZv0M3YDlfeRjBdxRkz3ymdlQ=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=FDd2vMQK2LoTxyh9w8EnDq82IP8B1nNYfoQ4b
	u6BW3U6fQi7iSE9TpLNwfA9zz+Sx9WmhrO1SSUHUjlKNgGShdHtBUAamkN6czrigZPbbfn
	VT8NtHzzA8ONr6PU2fRqmyZmRZnYsvBCkSst8xL8s1FXm0ZbMv52nUYMYUm0yI7Ynki3BS
	rZyoqM+rGGDcb50asDNLl97FQ2z1rEzoSDz2ovng1ca32sTRXt5Exp8X5TmSoHW6G0ICHD
	5nWhzjyKDYkXoIycxDxUsMSx0bVFsA1kQl7dtbZ04Fv6OsSeCKaMlznjG1qip0vL7ekrnJ
	QR5MpouiNBVVwlyeajgPeHBMg==
Received: from localhost (<unknown> [213.175.37.14])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e4795dec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 18:05:24 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 18:05:22 +0200
Message-Id: <DJHEOUT0726X.1GXII59NZR3YQ@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@arkamax.eu>, "John Meneghini"
 <jmeneghi@redhat.com>, "Maurizio Lombardi" <mlombard@redhat.com>,
 <hch@lst.de>, <chaitanyak@nvidia.com>, <bvanassche@acm.org>,
 <linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <James.Bottomley@hansenpartnership.com>, <emilne@redhat.com>,
 <bgurney@redhat.com>
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Keith Busch" <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp> <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp>
 <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
 <ajWOWdD0P5ri9bWY@kbusch-mbp>
 <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de>
In-Reply-To: <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_090531_714752_D7DDC714 
X-CRM114-Status: UNSURE (   7.15  )
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

On Mon Jun 22, 2026 at 9:15 AM CEST, Hannes Reinecke wrote:
>
> In general I fail to see the issue here.
> Any modern distro should be using persistent device links to access
> devices, so the actual device name is pretty much irrelevant.
> We on our side haven't had any issues here since ages.

In principle, I agree with you that persistent links are best practice.
That said, many users still rely on /dev/nvmeXnY links, for example for
some nvme-cli commands. Because kernel 6.11 made these names totally
random across reboots, it's causing some confusion for them.

But yes, I totally understand the reason why you don't perceive this as
an issue.

Maurizio


