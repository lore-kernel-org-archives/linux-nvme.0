Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41619CD8C92
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6MmMbvB5v7Zob+FdP4EXMCN/Yb5M0pTM0t7/3axfks=; b=fUaJN5ijiRENMI21zSF+/GCAxE
	l/PKYN7pQI4SMaz1JkcdV0ilDUkNUZeb0u/vVB8fkBanFsRRvX//kG0PhsSQmcO4/MZW4Djaluer9
	knzRoB6dnbi+InNKIiyhBz6VxQL1ZvgKgvndgv5CAOSOXlpqkjwbQRmGFKLRGiWG3woWh/O28Fioe
	lbks7eOxHuyPkq1HihMz+IoRFmUkkr1X73JYvnWtQpFihkkLd9+dnRI8VaPsgUmvwhdscF34aS00K
	MiPdocquZXEbVydy2AlgqdDB2xHrYD0XrFnFzFY44skSq8gMKY25430+HiTB0JrRlqALPniGNsYWY
	npYaF5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWby9-00000003ySE-3Uqv;
	Mon, 08 Jun 2026 15:32:53 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWby7-00000003yP6-0Ydg
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 15:32:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=qCebp/S8RPQB4D
	rPUIpliz/r6LW1DixA/nrML9fWY+g=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=fEKJxhkv6IBrmFEtYQI1lVEa35loFYeHkJtSH
	Rd35z2uEcP7z+ZDixm6Y7g4pLJmV8TNlip3ceDuNiKB2Js+aLybYFRhnmo6IREwJbRTfqM
	Bpi/r9g0Nhef3vTf2mJMIRGvyamzgKMgRz8XgwhRPW5mJEitPolUQ1iWX7l4QDsXLrUypL
	UNbaGIAv3a+EoGddp0xkf0qdFL6GJZvv2YGDPfTg92ermN63lRaMVg67wJeUDezq66af9D
	lIShgZ2lSYj02pMaoeFEocsGUuJ74aUIJJoMnHZ8QarkHHVB5s7AaLwuuYN561C9irtKF0
	307S7AG5Wn0G6t2IjnmzAuxzw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 5f95462d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 17:32:46 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 17:32:46 +0200
Message-Id: <DJ3RZ66X527J.142NQ4F7IYVC1@arkamax.eu>
Cc: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH V2] nvme: fix crash and memory leak during invalid cdev
 teardown
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260608100445.180908-1-mlombard@redhat.com>
In-Reply-To: <20260608100445.180908-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_083251_807245_3E3BD105 
X-CRM114-Status: UNSURE (   6.66  )
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

On Mon Jun 8, 2026 at 12:04 PM CEST, Maurizio Lombardi wrote:
> In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
> nvme_mpath_set_live(), the error is ignored. However, during teardown,
> nvme_remove_head() unconditionally calls nvme_cdev_del(). This teardown
> asymmetry leads to a kernel panic if the character device was never
> successfully initialized.
>
> +	name =3D kasprintf(GFP_KERNEL, "ng%dn%d", ns->ctrl->instance,
> +			 ns->head->instance);

Please disregard this patch; I should just use snprintf(), and it would be =
much simpler.

Maurizio

