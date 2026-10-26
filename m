Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51034606A320
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yHB7ZTL+;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=WH4Hsm86
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QW3sLtRWxfBZuOWJq/rGSlPO0jYxXYDcOJrE1b/An2w=; b=yHB7ZTL+/HalDdRCTBsLHwhSph
	RCBPA8LlUdodkOG8o6hYhVeTHk5cNnzZ3JPhgH9ft9FmyFmdhN8ECeNpZFQJPriSdZg2htUQkmIrv
	lpHKzbNNBEcvx5JAnNkuDwyQrXV6mPiC2sw7RXzu4ZqL7k6A5dp5UQHpNNc92eeTRJIfYNtOCPl42
	yGZW6jEL1VB2WBEVtLDfS6kwz7naDfTWXPOerHrHrcaz/ctREmiu64ofB0NT36T81faoB9NMxfjs9
	bAITwANkacu39K04936TO+hA2wJ3dqR4ccUH9SuKQmQ6Mzcny+WhLra0kbUwli9tI53hvlT3eHdos
	y9u/1ONA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPBy-00000003301-46IM;
	Mon, 26 Oct 2026 18:13:06 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPBs-000000032z4-3d1l
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:13:05 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-48e47347279so1254738f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793038378; x=1793643178; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QW3sLtRWxfBZuOWJq/rGSlPO0jYxXYDcOJrE1b/An2w=;
        b=WH4Hsm86Ni6LrfWBLcpxj97lssKG//N0LRwOPnynGlhbifh9ZA4IQBCV1w3Q33wKDr
         bAguytwOiKRbNKT5ruF8VY5mBQLa9PT9xvRXu1egWdeVnWz83Ez+jVD8TH2kakAvTvi7
         Y7ujXEuEbS9qq1a9kT4d+Lub7ZAeBvqPfCmCD+bHTvpKQCvYc9FtWDip139epg1M03sU
         KQfoG+mFL2YjA9/WV+18BqEydpDDPl9HtxN0Lg7RMpnoIA/f3uIGLdGZwIf9KZ0NdWQ4
         BgU5L8le2lvCR85D4kIcblQ5I15JWNSwd1I/tH2+pGdpv7M3gq2PEsDMfUcgoIN7/kvu
         JxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038378; x=1793643178;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QW3sLtRWxfBZuOWJq/rGSlPO0jYxXYDcOJrE1b/An2w=;
        b=GAxieE5hAw0r31Br8ATTVzT0T2zV/vwcMpdFlRCx4iKtAxgOwXaZBN7gIK2YbD3TBl
         Tyj3d8pxsoHZPrRJv07WNPSO24JSxcyixziOSWo/bGwWm3Fb60xxYLMb8z7CY4GxLFJk
         999gMUXVdeEPC8gEJ7IhY7vE0Rb0MiSB8V6xRuUGXvvIAi8gzG1bc+pwNUMsTH/FkYWK
         iJextA89Ly+1F2HV0Dc6xBIQShH862IcrkwsRj8VWK0jDaaIC+OipuvnLFtYRCHUau+I
         WC1nx5tdYgnNZiqxBLuRvyBkrjZSLoPzVVVPRvTdN+e7N5NKmgnUdeUO+FqI/97J6bAA
         Jbfw==
X-Forwarded-Encrypted: i=1; AKwUvBzNotlWzqg2apzBh+vZYy4Xg1h8rRlu32lPuiNEl7QSjFoDrIAU2zNx6ZbOuhDVaYxsQx4PehKxv694@lists.infradead.org
X-Gm-Message-State: AFq9FYLjuwpNP/L3s6ycBnuo04mfGZt115xk+oKmlM0qC9e4SlPbC+Yh
	7LjzskHQ1xd/JAK61f6XBnhv9VPYibW/GwVhgK5xOleTe53KyJ6b+pJbqAXqOYDLpKs=
X-Gm-Gg: AYBFou0OBLRJ4/5iDC1frb8MZNI8yhd37ljI7AJw6Pa2hITdIg8LXhGRMEvf+w04o4X
	hp0Gkdxg3R1z9RDZb11x1PxYRFTPgqYM4JqILqAEHb8q5yR2JKHK8uXpg5NVDWoUZbdXdTt8nr6
	1FjAeb9rCLgOBZjvbBpKlEzeDRsFoi2PSKxIhEMQALQ7RoIOntwtBfEMlzUrteo1X1ZnYRjKdWQ
	iIbQpVcS7pe64p62KAMbevL+yupZUfdmDLtkz0TPF0Jcz1ADkeBYXXyJnEOwPRCjI5risGHZQBn
	UJ+SjAv/eg9Mzdf160p2aNmjMYl4ZAtpeWVxPkiYs3hjUbdQbF3TmA5911VjRWV8LlHhEpiU8pr
	jPHXg2F+uOEhKKUnauth67y6ng4CaGhqvNrPXBR13av0WtQQsLh0nO7O1n9NCxUlTrGIu1R/vae
	ZazCU/7Sy9wwIyPx6YhRBuwyYv/7goassMWPi7aE5/NUYmnx8N0upl0ZiR3CYOC+76BeiXhKQ+I
	s6LlVdRvNgoIMFjFLkeP4tAy+qUJy1bV9iluF1tK9zVTO2NbI6FUYKsem1V5otAYeZtX1cFD6zw
X-Received: by 2002:a05:6000:41d1:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-48e3eb82f9amr15096144f8f.18.1793038378341;
        Mon, 26 Oct 2026 11:12:58 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm22665445f8f.49.2026.10.26.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:12:57 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:12:54 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 11/18] nvme-rdma: Use CCR to recover controller that
 hits an error
Message-ID: <20261026181254.GA2653700-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-12-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-12-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_111300_911995_32E5B273 
X-CRM114-Status: GOOD (  13.85  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun 2026-09-20 11:28:09 -0700, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Hello Sagi,

Can you please take a look v6 of this patch. I applied the change
discussed in v5 by moving flush_work(&ctrl->fencing_work) to
.stop_ctrl(). It looks much better now.

I would like to get these changes merged in 7.5, and getting this patch
reviewed leaves only nvme-fc change which I believe Daniel is looking at
now.

Thanks,

