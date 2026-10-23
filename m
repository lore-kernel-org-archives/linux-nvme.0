Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBF606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KVVZjrMz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiSRgP9h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UKcU+pvppiT/HXqcm9TyPd5+qte9JOrZp/xiOQGR8Zc=; b=KVVZjrMzMjtBzssckCXycHkIsK
	algtAIZHS6cVrFT7SdpUjtkaoWA1HNLuu1CWunwLRdjAebvA+5x1YR+1BZLkw438lkPz3KLjGS/YT
	GkgZiUTBv3L7+Mx1srE4t3Y2QoMMTiiw1/tI2A1YIhjn5AfGTrclMYItjYZD7Puw/w5VWyxcLTeWa
	VGv3JOtq5fe/crIWJjtacOahVs5EWQVPfbWRMre9CjEhMatTceZnPr14tpeLyGE4XWFYTtZX3nX4F
	3sTf6F4pvHqn/rtrA9y42bHOlNgSXJtAvTZZpjT7m2LIcA727oF4p46CEF5/xkm3qMYSMqAI+uN9K
	wVtABsxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNOv-0000000H2CL-0aWe;
	Fri, 23 Oct 2026 22:06:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNOt-0000000H2CF-2LTM
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 22:06:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DCDE54189D;
	Fri, 23 Oct 2026 22:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891CC1F01825;
	Fri, 23 Oct 2026 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793170;
	bh=UKcU+pvppiT/HXqcm9TyPd5+qte9JOrZp/xiOQGR8Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZiSRgP9h32liGtKsazRVQc3gf1BToBrUi9NB/pWmGWQg4N6N8ULyV51eav3c2kOKP
	 CSPU3dUbY14282QeJ5NsBz9MOtwv/vmuJb5MmYZlX+n1Nc9DXh4zb0b+Ii4ePXS8cY
	 d9Z24S2KwEHCVIPpPuwlGyDfScnMBOTdN9nNza1pWknriAlPWJ7xZEhM97AuqLd+13
	 5Yw53jyAS7FEHfLWZecm7qkEV8QIkd+rPKJ7dLbhD+fGvwGNV8P1T+QsR9cXRL/uY5
	 gy8VtrvjV7ReiFsCYe6Nf8CWybPJHMRC0c/GxAUDrX/rkmwJVW/5W0UWNjssgQJ1ii
	 PE7Yz8Lh7iLhw==
Date: Fri, 23 Oct 2026 16:06:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	dwagner@suse.de
Subject: Re: [PATCH 0/2] Fix for nvme quirks module parameter
Message-ID: <atvaUapoiKXQ2kdO@kbusch-mbp>
References: <20261023094806.944563-1-mlombard@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023094806.944563-1-mlombard@redhat.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 11:48:04AM +0200, Maurizio Lombardi wrote:
> The first patch fixes a boot hang when nvme-pci is built-in in the
> kernel, reported by Ramon Jesus Miranda here:
> https://lore.kernel.org/linux-nvme/20261018155426.1299676-1-ramonjesusmiranda@gmail.com/
> 
> The second patch increases the quirks parameter's buffer.

Thanks, applied to nvme-7.4.

