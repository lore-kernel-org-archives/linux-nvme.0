Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3316D2B926
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUiqPF7eEk2d6y3IpY6xcJvHUXSzKbQ+vpPCoyVJt4U=; b=EQPf16VTBOzTvQycMsvomEnTvh
	pX66ZrWPHUEgqOuuN9s+IsZmZjAQaLgpYtmDtHjXfXz3GGEHkS0T5EJlCtTb12U35Vp2QRjm7PPqI
	RbVhzCaM+o+e9kcomVyQtFVXthYjMy13C+6iYUFasTfblKL7OiDpvvggQN3um/5q4QUf6+gkyaviJ
	4OLNsTzaQAylW+T3rMqCGN69ad6jPfPf2qc93kgOgK9zTz34ZzDiWnqeFpJ5GwcRsFX5cFNSgIZpq
	e/VdEf3o6GNRBmBYoZSKwgEEuEfYoUhimrGo+F9bplcUBxXLTn/DfkjhZhyTFHGL9PdLeDtPBaHtC
	UFG0fRtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8JSX-0000000H6ST-0S5P;
	Tue, 05 Nov 2024 13:19:01 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8JQ1-0000000H60k-1gyr
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 13:16:26 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso819914766b.2
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730812583; x=1731417383; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUiqPF7eEk2d6y3IpY6xcJvHUXSzKbQ+vpPCoyVJt4U=;
        b=Tt0mGu2Vmba1OPz2W8p+H3V5A8QjKulhBsH2+MAjRTZZ6JTtRm6/W71QT/VBCmkYGw
         WZJuUS6sVS1h0yz36UJWAFM3XrNh3lNOavuj9qZROW8i+M+uqOW/Mdb7q/n0Sppviqzt
         EmABfaBFUxnwFAkhlML9Imoqh10+DJCVGjEV9dWeNQfJ5ko5KXfFiE99SeNxLvZPnszW
         546OS42FfvrysnW8XRe+e8nssorxvOVLNeY+ViFxZBa1KfRH3LdFxXBCNZi67NHplHw3
         fCZlv5775xpG4RNn4ukdiX+Of9j5Fd70UKEsJucbRssksPxX4TDpFTqRnncryF8Q8Y1W
         Ssfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812583; x=1731417383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUiqPF7eEk2d6y3IpY6xcJvHUXSzKbQ+vpPCoyVJt4U=;
        b=g5DVyctpwDxP4AOiOXJqiDLYjwYdqwlrhJTU2DjOsIhGBeHPNpbmfO9u2AD/uoOxvp
         EB0HtJyefj6ZlEfOF+METPAo3pi+Z9ex5iVd6uJRQtmZqDaly6CazDd2W5sY6sW1ovld
         agpomk+vfye9at+tv4Ez53wHjBqp9SmbRpzFXZAXBr+bq+soArhbnntP2M8tvbcrrH4i
         5gJ6fpH++dlx4AWFt28rOvpmDMKdNNb88tHjsc34W8gFlnoQebluS2sS2niIt6DhwjQv
         EQ3+3MINVnXzqNz5wtGEP+K4bB8ZJDYy56wumcDp30uqxkifdqh9RifhJQ8f3kk6+lKo
         2oUg==
X-Forwarded-Encrypted: i=1; AJvYcCXdP9vOS4PDF+t/jgNBbWMJUcuOVnYKK30c3TRNecFeNRcbMng37Zb1WRyAieZa/IGwAYqLYsbwhW5S@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4ZftO0tg4pfTdwRKF5FDytao7bwsSPimfpOUIgHhGrzix6xuf
	mdToJplaABArw0Gxeku9+tawOWM5hdR/pIRv+GDwq0quvv2S0JqaR+Da8LHZfXCj3UcOjEF0Is5
	t5fGXAWJWsDn4o6vU9op2ulasYg==
X-Google-Smtp-Source: AGHT+IF3BGph15U/Zucx/r0do/TaPI1aR0aJxfp41AlvjNpG2PVZbfdERVwBWNmIyHG6C8jDgVR54P3npeWrufTwIpI=
X-Received: by 2002:a17:907:72c4:b0:a9a:f82:7712 with SMTP id
 a640c23a62f3a-a9e50b672abmr1982167566b.52.1730812582661; Tue, 05 Nov 2024
 05:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e@epcas5p4.samsung.com>
 <20241104140601.12239-3-anuj20.g@samsung.com> <20241105100307.GA650@lst.de>
In-Reply-To: <20241105100307.GA650@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 5 Nov 2024 18:45:46 +0530
Message-ID: <CACzX3AvrzJCdOntY3yCLomgo9jrUQBpG2_seRYPuXWk-xOpieA@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org, 
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org, 
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_051625_465133_2AF77D22 
X-CRM114-Status: GOOD (  10.14  )
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

> This shouldn't really have a from for me as it wasn't my patch
> originally.  But if you insist to re-attribute it, my signoff should
> be the first as signoffs are supposed to be a chain starting from
> the original author to the submitter.
>
Will change the sign-off order if I have to iterate.

