Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA65C55ABE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2CIEmjkT8uauwSfFptpECfMoYlxWlmf41Pzx79esRE=; b=pRdrKuW25gCFxwkwmse5WDomVu
	h/V+1MrpdF3xS0cXETcSaX+FHGenuh60o7NgPgVdvWkRiXleoY2wkoqDF5+X1IS+LaPpLckXVlM7S
	pWq/oXdDpOGILd7bqeydjHFaJovgX/4W/wbd2lAMGqbtGtaMucRV2b76PC5srh60DsoR9eVIFtz7q
	jfoCvJO5sEbx1ERdDaZd908zQFQfFEI7KWcnwRMNvILPM/S21qjpzn4Np/z3G6s8zLjxoLCidEfKG
	OD9yiJRmPtjr45UKYG6RGq6EkAFSWUm11rhnV7TawkyM1SScSM5ID8jCKAi/KDQdWtNx2O6o2opNE
	iVCjc40w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPud-0000000EUr1-0Xz8;
	Fri, 20 Feb 2026 12:47:15 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPub-0000000EUqi-0bC3
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 12:47:14 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id ce667f55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 13:47:08 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 13:47:08 +0100
Message-Id: <DGJSTIHMGMV2.316EK4AH62YKU@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Mohamed Khalfella"
 <mkhalfella@purestorage.com>
Cc: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>,
 <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
 <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
 <20260218175452.GK2392949-mkhalfella@purestorage.com>
 <DGJ42477U84O.MIIO0U7J75II@arkamax.eu>
In-Reply-To: <DGJ42477U84O.MIIO0U7J75II@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_044713_521224_B81313E3 
X-CRM114-Status: UNSURE (   6.76  )
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

On Thu Feb 19, 2026 at 6:22 PM CET, Maurizio Lombardi wrote:
> On Wed Feb 18, 2026 at 6:54 PM CET, Mohamed Khalfella wrote:
>
> So changing the timeout field in the tagset should be doable, the
> only problem is avoid racing against nvme_alloc_ns().
>
> I will try to come up with something.

I decided to keep the current design, calling blk_queue_rq_timeout()
with the namespaces_lock mutex locked is the easiest solution

I am sending a V2 in a few moments.

Maurizio


