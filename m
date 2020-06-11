Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B3C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 20:57:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61812073E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFlgEsh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW9gNa1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61812073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0NQiNlMmwiLPKo4fF+WGIonJbDW8k2TJf0ghc8CLbLo=; b=rFlgEsh++zV+ah
	v2v59k4owhuYQPb+TfUDsjLlryb/Zx7aSVdFvuSAZAa8f7q/Reip4yd5T/tMrdn5AwHxiirL+Iyy8
	0pee9i4oZz3kC6SIIwjpxwFP52LaXy33o5HVeFBTSJNKIQrbJurF05qZxKFY1ddxOJtP6HjKNrEIb
	BSqN7TcszT9e7CnNSZU+jHGC3fCLVqCPRSDiK+nw+HW98zdoZNs3zJ5HegqTL9pDybZ7JlkRNB6hX
	CJn+jJxplue/Q7dOIZxnWgkjaAvivVZPgYtvzfWQDeb/zOAyqua5wIzDHAFI5BsuezBb1xAtddbz9
	sBjI9oGdBl6er+ZrfehA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjUGX-0006hn-7L; Thu, 11 Jun 2020 20:57:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjUGU-0006gl-W4
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 20:57:36 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2602F2073E;
 Thu, 11 Jun 2020 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591909053;
 bh=0n/GOsnSr7knZn27n1qrF/Kp618ue9O37Wp34i+SZn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hW9gNa1j1AEcJ8zt6p/sv6zaMpmx526iJhyKfet3u/Z6YqvA2sGaIBmoZ9lSoxGab
 pdgTRdLHYl27pk0pVnNtqS3MXEYqM7BGSh0XfD4NePYKIaDWhtiyE8x7bgh+uRIcay
 6kbKj9+wFNgDEBPaH1FJ2If2Y/OQxDxRL6oGo7+o=
Date: Fri, 12 Jun 2020 05:57:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH nvme-cli] nvme: allow addr family to recognize loop
Message-ID: <20200611205727.GA6561@redsun51.ssa.fujisawa.hgst.com>
References: <20200421211254.17417-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200421211254.17417-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_135735_052215_713FD13B 
X-CRM114-Status: UNSURE (   7.48  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 21, 2020 at 02:12:54PM -0700, Chaitanya Kulkarni wrote:
> This adds ability to decode discovery log page address family
> when NVMeOF configured as loop.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks! Sorry for the long delay here, patch applied.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
