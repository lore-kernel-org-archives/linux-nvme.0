Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A17C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOzZr5AoPsGnkB9DjHQHde7sL1I+PEKiFSNQIphm+9w=; b=ByxempOqNzf2zADgjR1F3mF41p
	qjbXnhOAzD9BroiSqFuTsrageQcUfygwV/cPPQ/94ZqCq7kZP8WagK9IMNJ+rC2GSJxPVN1E7kYqW
	n46VsEkid/751QutknEVnpSFt+pWqA5VqhA/c7beuRIIfVp6ZYHgCf0biJya/CDQbR9gRuxQ2brAK
	3KgnVsuFTRjv0m6bGLqkmgPOxGn7d7nSpDpEFNX3XlVybhBTn9YiBqQof09/UVaM8DDlrDneizjVP
	Zsv4WTy0YPzxxc68TaK8YSWoPEss6REwzjrfJECSFFZUOis4TaZwGPwdCQDgmYLXou2F+GwrrV5rp
	yrPLX+nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gLV-003EVU-2l;
	Mon, 27 Nov 2023 18:28:37 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gLT-003EUv-0s
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 18:28:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 033D1B836D0;
	Mon, 27 Nov 2023 18:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE90C433C7;
	Mon, 27 Nov 2023 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109713;
	bh=BOzZr5AoPsGnkB9DjHQHde7sL1I+PEKiFSNQIphm+9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avSDdpbohYQ0iZQj/KCeUjsGpYJUzyponfYfVD9jrYUU7xE+y1xfV4657tQUkmTol
	 efZj2Z1ZGh774iHy0UNuiRtYK5JbTRBG0UTAjDHiip8jJ2Ve1WvtUgg0DSpancF/PL
	 gvfyEdh8cDlRD8VhUcZy7vEKGeilPun63F3CalFrkFa2+EUKWQxZEJWpw8Rzkn6O+n
	 iCcimvvL1BvkBbAV0CpVecADniBF+AgX6qgz02vYPl3H9N0YFvkx/fDTShv/3KPk66
	 5E/Bb8lP08kq3lt/LHqC0BfMPLOy4MQgYobecsJmz092ASKkfOzvPVmcRTccUB+20m
	 6SHbOm58CtWEg==
Date: Mon, 27 Nov 2023 11:28:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, emilne@redhat.com
Subject: Re: [PATCH] nvme-core: fix a memory leak in
 nvme_ns_info_from_identify()
Message-ID: <ZWTfzgOoR6Rj0dM1@kbusch-mbp.dhcp.thefacebook.com>
References: <20231123140741.411735-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123140741.411735-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_102835_442276_5D883007 
X-CRM114-Status: UNSURE (   7.13  )
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

On Thu, Nov 23, 2023 at 03:07:41PM +0100, Maurizio Lombardi wrote:
> In case of error, free the nvme_id_ns structure that was allocated
> by nvme_identify_ns().

Thanks, applied to nvme-6.7.

