Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A64C36010
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdAW5OMLgxn0iT/97WfeeZuejIujQ87BRBijNZM3SUE=; b=0gWTRdQSUSoYHrZVuEgm+P7Zs/
	oV9MavJf4JFRoqyTa3E22+uTC+RVrJQTWz++/5AR9bhVtpmvF+9HKNeeWP/1ISMCNl1V8m/B0MqX4
	sKD3Hhx7q5IgbogzLGya7AEDbKM/NK9JzkNrCY0EkZWOlnNVanETpBg+XKe1hUvi62/sipUVASSZu
	MDV4YYfw8CbdmyFhETAmeNXCWDlg6k8JUx2veR3xlseHUv2d6DWYBK+sf8J4a1S7pz2zhz0H548wp
	nUQrjYYld5NX1I7rW9GtnG736Q6gKve0cLa8BBLl0syJ7zH1iUpf82YUx4gQ7ng5cSjbV2+73whmU
	RIByZMGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3DVE-0000000DkD8-3MWc;
	Fri, 11 Apr 2025 12:29:00 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3DTI-0000000Djms-1DdB
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 12:27:02 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2719cf1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 14:26:55 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 14:26:53 +0200
Message-Id: <D93T4EWKZL30.2GOT457EZWDQ9@bsdbackstore.eu>
Cc: <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V4 0/2] Fix race conditions in the nvme-tcp driver
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <hch@lst.de>
X-Mailer: aerc
References: <20250404082801.1614252-1-mlombard@redhat.com>
In-Reply-To: <20250404082801.1614252-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_052700_661208_50D485E1 
X-CRM114-Status: GOOD (  11.22  )
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

Hello Christoph,

On Fri Apr 4, 2025 at 10:27 AM CEST, Maurizio Lombardi wrote:
> Patch 1 fixes a race condition when the sockets get closed
> while the controller is transitioning from CONNECTING to LIVE state.
>
> Patch 2 fixes a command double completion when a send operation
> fails despite the fact that the command has been received by the target.
>
>
> v4: added patch 2/2
>
> v3: Do not check for -EPIPE, just call nvme_tcp_error_recovery()
>
> v2: commit message: clarify where the error recovery is started
>
>
> Maurizio Lombardi (2):
>   nvme-tcp: Prevent infinite loop if socket closes during CONNECTING
>     state
>   nvme-tcp: do not fail the request if send fails
>
>  drivers/nvme/host/tcp.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Can you pick up those 2 patches please?

Thanks,
Maurizio

