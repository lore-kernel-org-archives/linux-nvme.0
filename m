Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B02C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=; b=YOCslxaxqojuo5MnuMSTlSCzwX
	SlRwVBc8gxm7udY4lzAiEG+dboI0LEGX1D8w66c8Eh+d8505c9BDHPlX+W2dG7VvSMZxZsFI7cLrJ
	CcYmHrEhvY3bMfLaQuKaHy1814gdFnC6hc9b6vyn7HB8MGKJu7xO+j0nLWnf1dflNZ3V73KD3dwIl
	awrgSnyQmbLmFnFGqPjcflJZsSrW61Q/EQANKQ0XeF5523BShKzVPrYqeVgeYmwAHiaPc93tjcj8k
	s2oKmMa+NIR/uMcUhppXqxC/mSG6/P5iqlLO4gVbT+Dw5jpUVJoZc6+eDiB1wrhRm97kj6kaoD0+7
	5ko9roBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPe6-0000000DUIQ-3tgn;
	Tue, 20 May 2025 16:16:50 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHP24-0000000DNJL-3AS8
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:37:33 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so1121309766b.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755451; x=1748360251; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=;
        b=eH9NqlgWVhdP1pHQW0KNOKzCX8A05TZgPhZMBlMKhtZ6fymIZ1ZHEnrjGN7azaL6ym
         rStcljAmNhSVRUVAyhW4CCzUGnOWVyfVB/XLX/Bkt4djvWUZAse8n9dJT5NU5uvLcr3P
         IQaM3MoL/ZUf7pVCBYT7yksawcE+0779dRvWbNFobtyuwfYv1Ty5Wjz/hRVP8fB0Pzid
         GHakfPUhTsy9dwXOdWWhoAoIPFnvlbGHyDpM33kiaHvdFTRbVnBBD4ESg07BktwkxFGp
         NQbcs83+x3zgUijOVSVxo1Zbx6iqSXHflcXPKuIU6TyXNT2teYeiNxdfkp4t1R318/SP
         uB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755451; x=1748360251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=;
        b=FNptHPbJUKxkH2OlaPkBRIDE/DaCS7qvQGF7Qj31BLFyVClRYPNOUMOS31ZtDd0RFi
         ItR/n7x3mnULzpb0aribpadAJFI2gt03mWgfR6l/yrn2jvr1P6la6bTixryqEaZTJHau
         mOJLSiiIUtUksxFj4fQGIzWShpAajjG3S7EMlwDAs+e/IRdWG7kKkz2s+H6ZbfTiMOBZ
         HG3zuOQrNR/2O2O7sRkkNt0VCjLEAjZAVSl8+LgTL6ICsk9wf0Vl27Bc4/YY0cNSPYt8
         vXtKtzzklXuzXk/NHzC+35fHcZSnABjHIKOqBDRp96q1GYL8hvD33NKcnOci3xNc8u/+
         EAWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZdqEldrN6RRZohLA3hYc3g/Whd3SGfM8bRbbCX7OZ/Ar9Fwkqb07W76rFKXF4pAtSZWjl9jwSLCv/@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2B6XqHWoD4/4dyAo6piBK6UQkgZyBgGds14GMj31iqm6wVEk1
	lVP5YZZTCCnE8zJcZX323v24LspVZmPei8qfUTDFlqvC8vG37Snon0xtw+TFXwLcyBUg/pVMi7M
	g0VenYBhLgd6QZIRlRBB0OaJpLC+81A==
X-Gm-Gg: ASbGncu/Xy+j0tCLbxLTKeat/56Zln7Gqcs48788SKVJSHiUt/Cw8wpTFLTA6hM0mmG
	msy6uC0e2H3w9e9D5Q5QTphhzwR6ntMrlcUr7k+n+NF9iV1Y+yCc3bJPjskrR524vw29hhS7urR
	jz5yiLZN6r1burGwoDFZQMhFUmmKKIAMA=
X-Google-Smtp-Source: AGHT+IGM7UY6oMS+JtFcXp4zGMziRnc63xQa6ymwkLmTwybLxzWj362ZJbYIFXIQxqNHOSD+6Sjy+KJdIR7TmafJ7o0=
X-Received: by 2002:a17:907:3da1:b0:ad5:6cfc:e519 with SMTP id
 a640c23a62f3a-ad56cfcea61mr870003066b.11.1747755450606; Tue, 20 May 2025
 08:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
In-Reply-To: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 20 May 2025 21:06:53 +0530
X-Gm-Features: AX0GCFvG7jLMNmLOpCE9LYjuNh-QpG4w5o42HLCUUEguYqM8R_UQORhkuxgc5-o
Message-ID: <CACzX3AtYyMh1TBzVzuPt=n4hJs5qCBUUPhSqHuwh-AFEAVum5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: enable vectored registered bufs for passthrough cmds
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_083732_793346_E0DED41E 
X-CRM114-Status: UNSURE (   7.59  )
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

Looks good to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

