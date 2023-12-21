Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE981C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nasrBGlLSAs6X9x53XtOyZ4dnzBxyVsZQHMpt3DU94g=; b=ng5kl53Ceq7nX1PBBV6snecid+
	D9gbkzYfbDag6PLU0Z8Ugyo7lan3+qdyLhVoRb9U046LPtpCG4Tjy15NbR6uIvd2dbWEQ39zbnCtR
	1hvRnoLQHqEvg5/dvuOP29bQdoMFv7N9mFyMP4ErB88X/3/k66Jh59NlV/AHxhbcj2ft5+qFFkV1s
	rpz0yO0n6v1vhpW98XRRxJAOZTHclKUIjOaagEVWXlDF1IzHnKLAOdDUGu6ChUMBIURVq5fWpUNGo
	+Qjcjyqf+vLuV+Tbqeag7u7KbzMYbAd0mLDfzp/syiM+KcmAgLNUqJ52E4RBOIbjoOfmsuazZQDvP
	9IscQctQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMrF-003fGI-1i;
	Thu, 21 Dec 2023 17:29:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMrC-003fFi-24
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:29:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3A97618E8;
	Thu, 21 Dec 2023 17:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CDC433C8;
	Thu, 21 Dec 2023 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703179753;
	bh=MSkgqAaXD1i/jAA4Y/ptncsI7YaiFUOuQ4xw+k9NJ2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2BlaiFsZUZj2cgu62pfPiALlhoXER+JeXr4gguK3lSIymeHtjDqIXggUL+K+bGkH8
	 ahIRtJkRxza5ee27P+DD7IsWm1pGvDV4SS4jjpGV+yxH9k5B10pNLc/w7CCNn/eJx9
	 PpBLAKxGDbPaIAmqSHf9UYsjAxlzNkuwlj8yq79E=
Date: Thu, 21 Dec 2023 18:29:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de, rafael@kernel.org,
	bhelgaas@google.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <2023122111-squealing-spool-b86a@gregkh>
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-2-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221172257.2234320-2-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092914_723473_34377452 
X-CRM114-Status: GOOD (  11.75  )
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

On Thu, Dec 21, 2023 at 09:22:54AM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with an additional entry point
> to enable devices to implement two-pass shutdown. The existing
> synchronous interface to shutdown is called, and if a shutdown_wait
> method is defined the device is moved to an alternate list.
> 
> Once the shutdown method is called for all devices, the
> shutdown_wait method is then called synchronously for
> all devices on the alternate list.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

