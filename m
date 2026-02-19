Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2B6E9A055
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4aDxZx39M1BsU9K7wpK3aVo13ujL4rsNjaAKBXlWhB4=; b=c0E4Fk5Z9xeFldfsup8t8YFlnz
	w1wZ4PtEId/AgSeVbPv6NiHvjsTpJJuYDVFUIqGp6T4EziEcwnM718UD5w94NwTsZUSSNlB7qxZCU
	9xvPkVRO6jHcrs7V+RdSy9ynyk1y7tHbtcxCggAlUL+NbvlwLgxx0pVVp+d9qvmRHZAbxAWk6VPZR
	LIi23Tjrz5Xt1DibEaEHeriD9KuptcECnpsIMhLc/3ZS60BvWKZbKChinVsw0SgxHTza1ge3BqLA5
	6ZEuu/u83ZhUz47/JTRli7Nce0On6kLUKQQpSsyRgIu1XJLixAA96Kmr3JGaPT2gaLldfr4TdDmUg
	crKGbZSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7jw-0000000Bgz4-1WYU;
	Thu, 19 Feb 2026 17:23:00 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7jt-0000000Bgyj-3PAy
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 17:22:59 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 045cc1fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 18:22:54 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 18:22:54 +0100
Message-Id: <DGJ42477U84O.MIIO0U7J75II@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>,
 <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
 <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
 <20260218175452.GK2392949-mkhalfella@purestorage.com>
In-Reply-To: <20260218175452.GK2392949-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_092258_188157_C77408EE 
X-CRM114-Status: UNSURE (   9.49  )
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

On Wed Feb 18, 2026 at 6:54 PM CET, Mohamed Khalfella wrote:
>
> Yeah. I got it now. Thanks for the explanation.
> It would great if there is way to update admin and io tagsets timeout.

Yes, it would be much better.

I think it can be done, the only driver that in some cases sets the tagset
pointer to NULL during reset is nvme-pci, but only after removing all
the namespaces.

So changing the timeout field in the tagset should be doable, the
only problem is avoid racing against nvme_alloc_ns().

I will try to come up with something.

Maurizio

