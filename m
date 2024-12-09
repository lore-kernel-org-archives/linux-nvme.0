Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE5FE77181
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fd7WCXHSC5/Jk4tL+GpSKWOPvOtQEFWdZGmhIEfi8Qo=; b=q3wPpdtt2KDB93e+nz3k1IznXU
	DmyKdnwUE0Yb5Z4bWrb2nHrPivC32MRQmPcz2rQVY5xMUUJ/hCUZ3QWJZFf3jf/gUILuKDrpDebgO
	o3QvvLWKSkg6cqkdqOiwaCu3BhWde4ViIePjGhOXLpyNFZbB1VvO84kApRl1cwfvIR7IRW7bycFpN
	IRIeQTBys4853Ai5vNjj6yqZk091tvTcjS3vTl7BPIhxarCJc9DTHsG3wgqYoZoPlrtW//HEcJNxI
	sIy5Xe0zLCgJBFYmsKxLpvqNbMi5wx9iVjSz5T5q9QjWGa35dXqsTpGtzNl3EHS/cKWzlp6BfVWne
	JXQ/Haww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdqi-00000007zqH-0kJN;
	Mon, 09 Dec 2024 13:30:56 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdo4-00000007z7V-0R0C
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 13:28:13 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2163b0c09afso12597925ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733750890; x=1734355690; darn=lists.infradead.org;
        h=content-disposition:in-reply-to:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd7WCXHSC5/Jk4tL+GpSKWOPvOtQEFWdZGmhIEfi8Qo=;
        b=JqZuWdO6llLr8pogddsws4mhhrQzwFZtX3biKBbvpUrxNNmEYUNW0qudFnYTEdHi/b
         IEgto+OPF0hrBm9kPMquSW/nfYaAb2cqyaDsXiBMvBgnJq8CcV5WSaW/CEIj8q0m2iG8
         rMH2WPCXkpBmZKQst58v0XQW9BRTMaEJw1CDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750890; x=1734355690;
        h=content-disposition:in-reply-to:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd7WCXHSC5/Jk4tL+GpSKWOPvOtQEFWdZGmhIEfi8Qo=;
        b=ORfUGy4Ae/lsQsnEdYtd5d+fV1ju9WO2MR6HsNbnH9x6mYyjMkuGQ4Rrmf9iWANtqp
         NxFunMC3HAJIjFjZgFCT628PD8xZq4h6AoPQvqIRAds0wVcSTPkhpOTwOOl6kyc8gGf5
         N598NV2nbgVaKUet3HH9ebNr+qD2ROJvbuqe0fP4MRB7Zcaqibnef/2FUOV3SxCjDkqL
         a+5N8XSl5YG3OOpDZRNZz0ooLDEyMyox7JJ/WpOxOGqMfZsT0rM+rNl9pLIGa9UZl2vu
         KmE0yIA0GlLMR7FOhLeUozcOejx6/zwtxJypZszfWkepDLPXhU+gHcBO8QRqmbPlJkMP
         7/ig==
X-Forwarded-Encrypted: i=1; AJvYcCU5sEJunlSN273DTB22aooKEXT8J8zRW6BW7vvRsEcVJBqjsZ9qnGWTZnKru93dxFcyoIlcwIfNtyB2@lists.infradead.org
X-Gm-Message-State: AOJu0YzYH3Be3QIae2feOsh6g3bEc+l34C8loJDPLHzKsF5CpumSpfbI
	18HDF8D+E7t4jRzuUgkJfKLS9gvZ2I5dLOBi3iziEXBkZkY5w8MFdQYToHYZtt4GUzW7qF1ILBv
	Pi+rLcpNChSMhC0PAYfyl8/nPuQwjzbelYaRRTS4gIanstnOkoRQnY9W6RSn9R/nijr5Rp/U=
X-Gm-Gg: ASbGncu4CMo42p4Mj1d1bLcHdpvN83EV6h3WuouwYA/r3KG5EsjfHI4HYu01lWij0nn
	RxT4bffk9el7j4algEOxvnMrQjyAtcnESiVdN9MetGPFN3V/Tg3tY0SCft4W64kEwckcbxFcEMH
	pIDZXF+7ih8hcw2OGAQoIZ5tEvZS2sFc6XM7vfaKn1HrU6jn4L/0OGsngBBWe/tvG5TMcabTRuZ
	wUpMXMB8J0k6X2yQMp00C+83cW/S9/6bhxWb2RCabA=
X-Google-Smtp-Source: AGHT+IEXEF+rNG68kHHNem0Qgp9UuWlzzelfrL2sQzjRvdx8CWtYXdW0hHCmfcAEAdTcOjzS4IjcXg==
X-Received: by 2002:a17:903:124e:b0:215:a434:b6ad with SMTP id d9443c01a7336-21614d6e96cmr161483855ad.33.1733750889930;
        Mon, 09 Dec 2024 05:28:09 -0800 (PST)
Received: from ubuntu ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e22d4besm38457465ad.230.2024.12.09.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:28:09 -0800 (PST)
Date: Mon, 9 Dec 2024 13:28:04 +0000
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix return type of nvme_poll()
Message-ID: <Z1bwZKaEimphzLjq@ubuntu>
References: <20241207045546.119933-1-ysjoo@kookmin.ac.kr>
 <Z1UOyFnUavHNJu5H@kbusch-mbp.dhcp.thefacebook.com>
 <Z1U7npo/DINh2MR9@ubuntu>
 <20241209075836.GA24705@lst.de>
MIME-Version: 1.0
In-Reply-To: <20241209075836.GA24705@lst.de>
Content-Type: text/plain; charset="US-ASCII"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_052812_400759_026ED50F 
X-CRM114-Status: GOOD (  16.32  )
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

On Mon, Dec 09, 2024 at 08:58:36AM +0100, Christoph Hellwig wrote:
> On Sun, Dec 08, 2024 at 06:24:30AM +0000, Yongsoo Joo wrote:
> > I agree that all the "current" interested callers seem to expect 
> > boolean-like return values from nvme_poll(). However, the return 
> > type of both nvme_poll() and nvme_poll_cq() is int, and 
> > nvme_poll_cq() actually returns the number of processed CQEs.
> 
> Maybe add a patch to switch the poll method to return bool instead?
>
Thank you for your suggestion. I will submit a revised patch soon,
addressing the concern using the word 'fix' and the suggestion to 
return bool.


-- 


