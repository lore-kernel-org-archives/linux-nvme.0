Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C945C77B78
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMYlrOiYwuHpiCzz82q2JdlBawHmwhXn987SOyt6r68=; b=n3pvn3ubAJ/W4EUrS5gNt3kBi3
	5ds2+TEe0+IpXnj5LWNb2zMGX9dGaLbn3p0nr4ZOEAJxNsI4FaLmCGQKyVuUM22CEVfR4DSc7JiRj
	pGXjX8WZjtb0veyPLtTQjGF+SljOPqoJLeO3CDmohwHyZtA+da9li+kBbPqk7y1zecS5U2Fq3T19f
	0kvsU+9fsnRKzRmSJLNWHTjBbQwax16c68hw26sj8aKHjbfzgNd9bJ+SvfQyMdknxS9yvawNbiLbP
	z1oUAjzGlflCTxUbbNzTrMjgah9acFIa5L4B/goIqa+8sDQHj3MZsZ74v1fCnRGa87GFDREU4th2Y
	kpcIvzgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkIj-009ph8-2K;
	Fri, 21 Apr 2023 06:31:21 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkIg-009pg2-1R
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:31:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B1BF1FDDD;
	Fri, 21 Apr 2023 06:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682058677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMYlrOiYwuHpiCzz82q2JdlBawHmwhXn987SOyt6r68=;
	b=b/I6zq1CKotcYM/fXxRhgmgmUjRjQ93BmFNWBuDRkA/6Ax+AnUBSGfc8i5OjlhW4Ce0ia1
	ikPtJQ1mS89PN4jic8NhDi+XFCCp1zfjd0GHfvUFDOlFp0gD9mfkym4LfNwxsh6jDlVjAr
	iwP07uZHKp1+qrFv++yWhA7deiKu5lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682058677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMYlrOiYwuHpiCzz82q2JdlBawHmwhXn987SOyt6r68=;
	b=rjzV+m7tpeprEh1j9u3+K4IvHvu0e4J5XeIQ7NA8evCYorN8U0tl5gPbIz7G6eeX09lUq1
	iaL+jV/XqA6PCCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16D151390E;
	Fri, 21 Apr 2023 06:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PhqjBLUtQmQocgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:31:17 +0000
Message-ID: <1b0b700c-7138-0324-dd95-e56fc0e8d04b@suse.de>
Date: Fri, 21 Apr 2023 08:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 5/9] nvme: Make test image size
 configurable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_233118_638235_50DC039E 
X-CRM114-Status: GOOD (  12.92  )
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

On 4/21/23 08:05, Daniel Wagner wrote:
> The reduce the overall runtime of the testsuite by making the default
> size of the test image small. For verification jobs, the default can be
> overwriten via the newly introduced nvme_img_size environment variable.
> 
> The default size of 350M is the minimum requirement of nvme/012 and
> nvme/013. These tests rely on an xfs filesystem which requires this
> minimum size.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/004 | 2 +-
>   tests/nvme/005 | 2 +-
>   tests/nvme/006 | 2 +-
>   tests/nvme/007 | 2 +-
>   tests/nvme/008 | 2 +-
>   tests/nvme/009 | 2 +-
>   tests/nvme/010 | 5 +++--
>   tests/nvme/011 | 5 +++--
>   tests/nvme/012 | 2 +-
>   tests/nvme/013 | 2 +-
>   tests/nvme/014 | 2 +-
>   tests/nvme/015 | 2 +-
>   tests/nvme/017 | 2 +-
>   tests/nvme/018 | 2 +-
>   tests/nvme/019 | 2 +-
>   tests/nvme/020 | 2 +-
>   tests/nvme/021 | 2 +-
>   tests/nvme/022 | 2 +-
>   tests/nvme/023 | 2 +-
>   tests/nvme/024 | 2 +-
>   tests/nvme/025 | 2 +-
>   tests/nvme/026 | 2 +-
>   tests/nvme/027 | 2 +-
>   tests/nvme/028 | 2 +-
>   tests/nvme/029 | 3 ++-
>   tests/nvme/031 | 2 +-
>   tests/nvme/032 | 2 +-
>   tests/nvme/034 | 2 +-
>   tests/nvme/035 | 2 +-
>   tests/nvme/040 | 4 ++--
>   tests/nvme/041 | 2 +-
>   tests/nvme/042 | 2 +-
>   tests/nvme/043 | 2 +-
>   tests/nvme/044 | 2 +-
>   tests/nvme/045 | 2 +-
>   tests/nvme/047 | 2 +-
>   tests/nvme/048 | 2 +-
>   tests/nvme/rc  | 1 +
>   38 files changed, 44 insertions(+), 40 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


