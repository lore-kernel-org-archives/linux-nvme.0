Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01045C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENu8IM63AcDSK2j91mbDMwAUEGTW39H9hh/NgLey+9U=; b=C7jUltxWgIS8XlcgMjjYsNuQvr
	XTDnNALqXWwTNWm0yuR/NQEtoT0EdKjBLjjsxsNrR3qQUzMFRuSW2Oqh8LKXPPf5OFi3HAPR03rYd
	qJiNAP9H7NbFmi0nBh/w5zqEiVctBj/AGQpyAoNlXOHF/UG64WCVnKvO/p02TX+73g1U+MKNpZfEw
	eMFMrCjSFi3zJPwpoTcuRu8js1ddX+qFk33HJZHos2k91wP6A2kaii2/kO1bvmIso5LMR3oPdqBWk
	jRlpcVooqBlct2WMLg9lq1GILiFgsazR7VOPL1z4IdrnOLjYQfbyBMi3VSfaWEoEdE5KMAQSt+atz
	JA/YzJgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMl6w-00DIUB-2Q;
	Fri, 21 Jul 2023 08:03:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMl6t-00DITI-2Y
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 08:03:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4AE612AF;
	Fri, 21 Jul 2023 08:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA7C433C8;
	Fri, 21 Jul 2023 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689926614;
	bh=94sOFZYZlXgDp94s2qFcEOi2pVWZd27doNO/7fb3TlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfq95p+9bjGFsM+3/tkMzWm1dNRWCrp6By1tod5Rro78wZ/zvdex47YzfycRl6Hpo
	 ya2em6owAn2GLBBKOGckNpDEzewFLPLkdWuWG6xc0EVO8QmDM3w0raRsiN5EGbsA2O
	 IRyOQ5U3MTEWHHn+SroNUInrxqLOmpUXz9bfxQPqnBIuwTY30xZ0Szwrhrzz3ARd7y
	 YE9Fs/AdIp2ZQFsrroxmEYjE2Q9opbwwljMiDRxVsMXu40AGcdGEPBCXNx7fk2tLhL
	 pCQ8phFr9gL5BwFu1cGCgJ8+WiHCuvWNKOfKK37ZeiP7S3Q1+dyKerravNGM1gt2oH
	 s+mddlRVbSfHA==
Date: Fri, 21 Jul 2023 10:03:30 +0200
From: Keith Busch <kbusch@kernel.org>
To: Martin Bayern <martinbayern@outlook.com>
Cc: linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: Failed to enable trace event: nvme:*
Message-ID: <ZLo70opGfRVMxBQu@kbusch-mbp.dhcp.thefacebook.com>
References: <DB9P195MB14891E0E72F12377031315CAD23EA@DB9P195MB1489.EURP195.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9P195MB14891E0E72F12377031315CAD23EA@DB9P195MB1489.EURP195.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_010335_867613_7AF604AF 
X-CRM114-Status: GOOD (  14.70  )
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

On Thu, Jul 20, 2023 at 11:08:41PM +0200, Martin Bayern wrote:
> Not sure why NVMe tracepoints cannot be enabled during the boot phase in Ubuntu, I added "trace_event=nvme:*" in the kernel boot command line, but after booting, I get the following error message:
> 
> "Failed to enable trace event: nvme:*"
> 
> I found Ming Lei posted the same problem on the 2019 Linux-nvme mailing list, but don't know how to fix it.
> 
> Does anyone know why?

I don't think the trace event command line option works for loadable
modules. You have to build it into the kernel.

