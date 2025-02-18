Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95186C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBKOvjT4q4+r0xsz7Cxmcb+Agb6bdL44dfyQfoHeLQg=; b=Eozp7VI9vloTyPOLAQdv+TKQ4e
	Ub+RmOWxBfiSy7Uy1bR83a7yQvmDSY759mXKvqowFsxdP9v0dPQcrUBuSvGK7LmFps3WtfaA9ZKiU
	zanfCV8dKX0IBSurusn6qKOnC0JMyEV/FtoYVd4q/Sl7pH437kFTEw0z4HNL1sa137klqH1rBKtOw
	4RtQHuXSyjonrblvjqLsF+gGNKbuqOKGK83pd6NL6KhQ9sW71VPnuFtRR1IvxeOq8gotDIdkdDyf3
	uJa6op51Sef6LQ7S9aCvpD7RL5SOHYUhme/qmLQcrWKJrik9itzyFj/FnYMU9MK5S7k9DWUvNmF9W
	SCKpLpiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkO9X-00000008PhC-35fG;
	Tue, 18 Feb 2025 14:00:47 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkO8N-00000008PWU-43U5
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 13:59:37 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-6fb7c373416so16215997b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2025 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887175; x=1740491975; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBKOvjT4q4+r0xsz7Cxmcb+Agb6bdL44dfyQfoHeLQg=;
        b=nTG7fOX2G0cPBAHSPe0icSpq5ZJLFbUN0+BAJpsQyitMp5SaKzyoAsZaAmsfNbOk8k
         C6OwqGJEHNlJWc+lj55sLqsQyLNVIdQM7NW6a9J+Jd0kab/I2Nx4b//DyOgySQQk7BVi
         urBWHv5XHSHh3TfWcbhC3XFveTpZuOlpQIa9J4atFFxhJWX3CIB0kDIxvE005gppPajs
         nYFsruClSVBoziBN/ILNf421ds12N3Xu39ubwL5BoR0ZR81Phx416S/6FLopk7LoSxCf
         Dr+T6yTo8JuQvzPX4FS3Ov8ieNt67dQ5/c0gPLdFVfIEVIUsBpF7Hmcjpm5RIoiJU7t3
         shOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887175; x=1740491975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBKOvjT4q4+r0xsz7Cxmcb+Agb6bdL44dfyQfoHeLQg=;
        b=LfjK+iauUuzq0XcCTiLQwGln+dXsSQPiDZ6zvlFiPFgUGpW6FZHKa6Oy3MISZD5iXo
         baWRhYaku2KjCAmrnwfFcb9uY1xnQp/U+nUBOTkLAIsJfPOnx0lXVH5nH4xBY3mIA3vZ
         cNdEVjup6bcIZhVU4ijwEfnXNGZc72WH4dSc5g2VG18fS1ShjSN2MiZhBQr1ooEvNr4h
         0rU6hrArPsTuQmQSt8oLn1/bpvDRyunAZM5dMQcKUV3r64f+XocbbNF9iVel31WslptO
         MfEJ6BFYte39wnTQM4zVHbAd1R7bJjugLkFmUqpZsHV9Pzkp/GxEWu4ILto22Nx8zDSw
         FqBA==
X-Forwarded-Encrypted: i=1; AJvYcCVgcrZ463GoQi32/tIT7EhWqQLWOagfsnMpKEA5hdFE2pL1t3nfhC7Fptuj0ViDsLU9NYTLiVl3jHkd@lists.infradead.org
X-Gm-Message-State: AOJu0YwxleowW/QIHBkqNIciuSFbMPGnfphLTQXRbAAcd478XWxrg/i6
	fwLsDUxAm3L3VEoDRHjomJLJ/0AK4MSoJ8iztJM5cNQrKs/KWCuj
X-Gm-Gg: ASbGncvz8PAsMTYsSHcVfqTgk412omQv8ZiaVSMv8FmP8sksQY3iMV3t7FNOdEhRvQd
	A+upNlWtHq/n9RFkF2iLqRGFK/r443veLUc0oOTY77E11uSTTLGD3+NtL6cpAR6Q9EdG2bbt6Y1
	955y8WJI8Gf2Ix/GuupDdbJtB2KPmlD7ZaYMFXsjoJFX+1vvZovHeWqNonMv4TBXwW7qseu3BCx
	ektoV1VY/DD+1X80mYwr4gvKSZvm7EvjDuXyrmAGdNjqnw9vcxEbISZ/+671Uzo+XuIYvVaVrzi
	oGNXgXjFlFViPTDE6ymV/XKPYkYaAFH42TeJMamw4Q==
X-Google-Smtp-Source: AGHT+IEtw9NTViCsSAfD+Y7y5H/yTDPI26ZQ9FfUOYH8m/a5smC8kabGnU1/gB9NTb6xN2UMJfJuUQ==
X-Received: by 2002:a05:690c:7085:b0:6fb:46dc:d9c4 with SMTP id 00721157ae682-6fb58292d61mr107457297b3.12.1739887174864;
        Tue, 18 Feb 2025 05:59:34 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb36083ae2sm26122107b3.44.2025.02.18.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:34 -0800 (PST)
Message-ID: <9fbca62b-36d3-c2e6-8ac9-28e51af80f7a@gmail.com>
Date: Tue, 18 Feb 2025 08:59:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
 <20250218084217.GA11129@lst.de>
From: Christopher Lentocha <christopherericlentocha@gmail.com>
In-Reply-To: <20250218084217.GA11129@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_055936_003291_D4F112D2 
X-CRM114-Status: GOOD (  11.70  )
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

I just sent you another patch you with these minor changes mentioned, 
thanks!

- Christopher Lentocha <christopherericlentocha@gmail.com>

On 2/18/25 3:42 AM, Christoph Hellwig wrote:
> The subject line should rwad something like:
> 
> nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
> 
> and the commit log should be wrapped to 73 characters.
> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> and we can probably just fix that up when applying the patch.
> 

