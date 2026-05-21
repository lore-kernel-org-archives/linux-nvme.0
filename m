Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D3CD5BAC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uy9505Mg5zF5P+I3cfeIelppYKD4CE3DmbW4sbx1iVc=; b=dw3VFRacVq9ixMI9Q9A1h8Vtou
	/sEmkcU4eJmhNds7sQTWNfUIrXMH0eGNF8XzrSyOeNsD7bWa6tIcJpcC18zoQM20dACxGQMJd5GU4
	/mBmWk6uqO9d8pa18nNeqJg1plcDcisTrm103BgcuEWVi4TDzQ+GxrTqtMVUFqFi0Ve1TWlmNEzVx
	ug5p0l7SVPe68dekt2yBixwI7PNWTLzlEHFlJWQmwSP4z3gZNCFws0arp/VUJvUDl2+EQSVuWqY++
	R5qgAcotsJXauRShVyv6L6ivy221Xs46Efbgi/cuVihAXCIFKDi1qr/Ogx75F0oTDPB5KWh1VTFNH
	4QP+x4ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ55T-00000008GvK-0Qdk;
	Thu, 21 May 2026 15:13:27 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ55Q-00000008Gur-2Nyz
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 15:13:26 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-484cf882ce5so4268560b6e.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 May 2026 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779376403; x=1779981203; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uy9505Mg5zF5P+I3cfeIelppYKD4CE3DmbW4sbx1iVc=;
        b=zD7gXBrl+A7ww1axHWqyzr/xL0B7mfbdXM+vmBsdwUbrvNo3O4lAKMaYGz66GIkW/V
         Sd7IVVDnX5C2LJJOTJtEUto+VBFCy6flpVHJnCKTstLPkH83nqkDQCccM7Bt0OojD5R4
         YgFfOF3jN65SL855r1v/V1QJjr2Q854qIBVeT8kqHoIqVWrM1ZEhLQGJpYjoQQn8lZ07
         Tbr7lPEZWw75gcRy/BUhek8nwLMc2sOgzKMgGUAEQdiZOogU0XZMqkE43yHIEr/UWBqY
         gseiuC1HPP9blErPCbdbSmf7m+0vDKMgs+vOfxhi3X7plqoApAGwTMd9v/AjlUwtZW6C
         rQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376403; x=1779981203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy9505Mg5zF5P+I3cfeIelppYKD4CE3DmbW4sbx1iVc=;
        b=YXntBfBYbvOzn6Ws5FyaQ+Bkqqd2WO3v/1bnzQ+QMKhRq4/pS0OD6nJsStt/nkqeqN
         zleyTnnhukjRqphSYXvC5xyE1XXGveYbuuRF7DZmR7zzkUQmTRlkVC8H0e/mbCb1Unxx
         NXcn8zf7lGO1FBkFoOUQyVlPO095h6kwjSXUsXuu58Hb+2NvGJxgultCr5GpuOoVkvHc
         gn8vKgFffLOoZan7l2IvlLO50CQ6AvThsb/dYBEay4gMzadKmbCgketbqi3OyFikmx6i
         I2oIGFoumfUUcKoe5hpb/Hs0DtD+LlJcW5Zkc5e15V5+N16BYs7xja4OEX4gyYha1oOg
         Cy8g==
X-Gm-Message-State: AOJu0YwGphzlqOBnIDbTNZ21CEOCA7f+hXqGkGhFJOW5AFZTG2QZn5BJ
	aOFi19f+clrZO/22yt6ZQOzGuiRFWZdxgeWQp8pErSBeSoL6LEgQC9kp+/aWBlcvk6Y=
X-Gm-Gg: Acq92OEFP5aR2GOOrGnDcis4vvuIGHTTIdoQ+y7WlsP8NLzjt5qriJ311rh9ZA4LSGb
	pQXGWpZJ/tBDFEoYIdxZsiAjy1rgV6ckxf5rfOPbFB/qZK7ITY2we6K8gxLksXZIDsNg60Tq/yW
	sUcEXXGCovIDjjPSbsQbmr7xFEC8LG+QwKGXsHiATKEVgokRTL9n0dguBy5i6Hn7HXEQqqkpEEZ
	nMj5gCZ3/L9TIYej4YxysuJp+4zLLA2pCzyqLb+SbauAU0yVAAmhCG94G912tukwoZOoEXLdH4p
	ctto3/QU3HZjvGRyRWh1QravcUFpH8tNKlQU8eeZF6UaEAHrC/C0Ld+NwZy8yO9pfDHIACk/03R
	r2heyRPqn/6dBo9WeqZmlHnjVegtLErY99ZLJ4Lcc9CEgbIAFsYuKpeOIrPFn+G3MY6UhYBOcyA
	N7obgJ+Y0tYz6L3QOTrAULep89QVnrz7cDZDpbfhXQGLvY0DUM+OgKJlCOHOM4NQulBwhhROkvN
	Epi38Tu
X-Received: by 2002:a05:6808:1b2a:b0:479:faf5:ef56 with SMTP id 5614622812f47-4852ec2ad3cmr1808116b6e.5.1779376402910;
        Thu, 21 May 2026 08:13:22 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48542f77271sm357670b6e.4.2026.05.21.08.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 08:13:21 -0700 (PDT)
Message-ID: <d22762fe-67bc-4c81-969b-f50e834475a8@kernel.dk>
Date: Thu, 21 May 2026 09:13:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.1
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <ag8fAfzFc31u2cct@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ag8fAfzFc31u2cct@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_081324_611723_E48F82F8 
X-CRM114-Status: UNSURE (   9.75  )
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

On 5/21/26 9:04 AM, Keith Busch wrote:
> The following changes since commit 431e40042d3599559e588b8946bb28bd440b4f65:
> 
>   bio-integrity-fs: pass data iter to bio_integrity_verify() (2026-05-19 11:38:21 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.1-2026-05-21
> 
> for you to fetch changes up to 1bf86336e4b6cf40873fda47a7fe191446864937:
> 
>   nvme-pci: fix dma mapping leak on data setup error (2026-05-21 07:49:05 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.1
> 
>  - Fix memory leak for peer-to-peer addresses
>  - Fix dma map leaks on resource errors

Pulled, thanks.

-- 
Jens Axboe


