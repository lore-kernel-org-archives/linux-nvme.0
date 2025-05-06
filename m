Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493DEC3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atkSe4VYR3KeJA16cjqRJP3eVfGhs//A/juS1N6cUxk=; b=1NJWTuVgOS9IWyWyXCyuUHCGoq
	U79TcJQ4vYoB88ockmxOm4d9PfjsheniL29ZWI2s+swEQwW82nJbbPuOv9AqnuUU0XQHAWRHs9sJe
	9lhbpVzE35cbxYtKmrSoPsYRVL0Ofq9mnGx9uHKTkKBQAVSThlu+v4WwjR6fR6FpeuYhh8C8r1vtP
	miDBOaskZ/IlIjAOtsw3daaRy1gv+LYDldYQwJOeXMtAuWr2mKM9v0NKEPXEfyE1BusNJ1S0sjYz9
	9GTMlYROVIb6Dgf9gC4rbDzklEDKR5caYLvYUU5yVhL1EXgW09q4kJmCviZrSw6UGe+Kym5OP0rgP
	5ytqx2Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpN-0000000Dfu7-2naN;
	Tue, 06 May 2025 23:35:57 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMjI-0000000CwPj-03Mj
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:09:21 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso693628a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746554959; x=1747159759; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atkSe4VYR3KeJA16cjqRJP3eVfGhs//A/juS1N6cUxk=;
        b=YcqrB+/1KbiiCUls2PpqBhPRIbpydHQ96MJn0b5BwcDcpCn2GMbfu6iaa9HiFaggTz
         wFtuLBpBiVFqrR7JpuH7+rBY6bPm0eTVRA9c0jEzgt18sgkdMZBpVHaqmBMnW3rKJvhN
         6wGW+rGz9rTu/mfvRPExfO1dwEG3rc/Wo1a2eqzYBiBJwycE83rR1NSTQa0a7ugYHnvC
         jphUqPYaHmnw4M8sq8yfNNxic1/FZdIQaT5Fte7yMPtOiAQsdH64f8kbyF6VkHGVPcWq
         xZl+x6N8oh6ZswEbd0vbLUdgP6UVGKqIDmR+M14gIQwOOAPmplegYRLCGlSqL/u1HEGM
         JZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554959; x=1747159759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atkSe4VYR3KeJA16cjqRJP3eVfGhs//A/juS1N6cUxk=;
        b=QBjX5+EczGHA7zO8Abf8zggUfDzUJb4b73PonIT20H/bSBub0EhnqE7GVz95F9mXIn
         jTAgATihqBjzWRJPnggrtLag35Js52mdHT5Tn5ucnhM8eOE/qf+W+58YdbOxEa5OnBrt
         N4aPjf4yKOnYpl26lgY63JbCG7Xeyq18HuJhE9PRTJq3H9MKuSu3d3Je9CeIafGY+p/A
         iIkd7ixotZ3lbUzt/k4cSY2t+gQEikK0lE6CQhqwWBlV/+jurTZs4WcIP2tofDXH0yYn
         UylN/39z8+DOgxGadH1Ix8Wjwr1uRjQ2Ug6F4hUpbcJ8UdfLu8YM0uaxJfzRB0Rp5KCr
         ws2g==
X-Forwarded-Encrypted: i=1; AJvYcCUTAV9BqXeUkcxhg2dQCD3QVI67v5HSa8uRA9+9bu5U2y7u5CLE/8kNazHq3kgGd7m3jalwrfJFTJn6@lists.infradead.org
X-Gm-Message-State: AOJu0YyE/9++eRvALvpfKDgjRHnf4u0XpRUsa/7beG9LM7KBmflVTXOx
	pc634zEtM69w9KFaeaNZyFQopdm6vd2Bw06UJ3DzvZmFP2JVqvLkf94iz0Hl8S9YXw43MMA+bXn
	ep02/70S/iLqlQ4vUmQJHiAciioDhqw4SAwtxyrd8obWjl+C9FLcJAQ==
X-Gm-Gg: ASbGncsYozTxa887ahvT2ACIbr7ny7h8Qd6yCUj9ifVnFcWifNvmSLdgomKW4GLlgsi
	+BoRgMkujevZLNrpVZyHHZ2QtXes75NhsYvxOG8Tck0v5bSaA7r7UY5UrGp3hPpkjP2QfTIT8KX
	I75e8BINELfVQ021060jum/+inRgytxUH6
X-Google-Smtp-Source: AGHT+IGbHSLbuje4f0dLQ/RkCpL0EYMes1DcQ2HXZ6Pi9rXTsSVNOJ5+q/dXVCUMkrE8u5HlqV4+zEBiTGDCTUUCpOo=
X-Received: by 2002:a17:90b:1c04:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-30aac20b749mr212914a91.4.1746554959102; Tue, 06 May 2025
 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
 <20250506175656.23151-1-joshi.k@samsung.com>
In-Reply-To: <20250506175656.23151-1-joshi.k@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 11:09:07 -0700
X-Gm-Features: ATxdqUEbuyAyFzz_ugNIstraYAa8NHkT1F9Nljnl5O9ooEEVn0KA79h5WRef7EE
Message-ID: <CADUfDZq-RY-mMUZpP5Dc04_kCWTePa8cQs5OUaip0tNd28f+QQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix incorrect sizeof
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_110920_057779_E45B1C26 
X-CRM114-Status: UNSURE (   7.43  )
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

On Tue, May 6, 2025 at 11:05=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com>=
 wrote:
>
> Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra.
>
> Fixes: 38e8397dde63 ("nvme: use fdp streams if write stream is provided")
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

