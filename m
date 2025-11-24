Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28217CFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=; b=E/GS50M0hXWYSpke0nM69/oCfE
	T+iKzKOft+LepGQVTSxSlMHtogsLIisLGZihoTI1JwAVSWhqViyG7FRQ80XgZN5EbMqsWPlsyIwqE
	r/lLHk58ojLQRINjOJ37HLi2Dvs6vB1Jvbmwl+DAjCe8g/e9GJRyPjQT0LlIy01wTv2cMnCkmlTyE
	IhQvnH+7al8uBgSxxPJy1/SYxG+E/IANrQf2xY5Qoo62Bt8L01LmLMjAMdZ4P18Y2wlyd2E5xc9//
	DMrRW36PH22vij76UxOD8PhiPdi6ri7NApciD+wzW/Z4C34F6a4cPrLWM7voDbsPr3NvhHwlX9p06
	0fWbo0Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWp3-0000000BlxT-35u6;
	Mon, 24 Nov 2025 13:41:41 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWoz-0000000Blx1-35Uq
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 13:41:40 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso145927a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991696; x=1764596496; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=NTafxtFz+Ja1X576uZxQAPEBjrH4Eszu7X9ZdrOgwnia30gDu/dMEVmd/FxfWVTnsg
         a5EIvYkXXXhhu8L5QdZwvBrgkcSTTsqDOvST/VRryjUncih/gxul0XYfYA7yzQ7YY1w3
         K/sicdy6xT1AkI8lF0oo8iHbTsN24rBOGp3uo0KMEJ8OZQexSwTVqptUXrrsPpAEmD7J
         FQ5mdTMrxzsCxKN5ux0uzuFcLKk+5gXs5K6h10SB87JVzE3/v9VsJJzrADP5B18dETP3
         lrU7XmFODmA85oQnddhKUB/V0+mJLvQHAKws9iJrWBNdPHF6RJo0kG8Y4Yns/LIm61jJ
         qHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991696; x=1764596496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=my4iiFlch6xCGnjDNmvf+BGhG62eH51mTczxU+2OppTPbc/KJSIhCd+65qQ9x8C5ok
         wGQznBisRJe8mmk/dtZh1H7Ccda92zYoDg9/fOsoojw4Wd4ckLnJEX5Sc2rMuNnj1Zmd
         j1pPuzig3Z1ALmJSoWG5+zbeFlTVAQCgbur6mIHNT1ARvvdeHkhJjOVTYptiYpuhMMXx
         3jEgRDPa14ZcZzByUyqMnaEkR8p6W1efpj1pRnkS3cWBTggcR90dX8dYrSvTmQBHNJlP
         31vCb4UqGPyFr1X41GaDiaCuD/YaIAS+ksc5HXIYjQ5crcGTQjVWnxlgLcYd11eOKhRK
         aOqg==
X-Forwarded-Encrypted: i=1; AJvYcCX+HJ2vQWD1gD5N7yor++UyDmC0ME0l/1Rc6X4rZihIQuh5vWoH5qMS0Ji5dNbKkeaPIaR1MvlGCLJY@lists.infradead.org
X-Gm-Message-State: AOJu0YyuvyFLLZWWY+V7W7Unhs1xJqacydFqDjakKlt7tLUfyvik9Qdz
	L2Zjvu8gIkR8zd+Sk+5xyo9iJsAJWLsDCQeiY5XBFiMO/DT56pM0MZxZrq/lP7nZO3KnPGOUt/X
	qNBPc418nv9X8JQfZlH3PWOQU/fhH2Q==
X-Gm-Gg: ASbGnctVBQ/GRCaqX4CnrHZHx7ZD5GxY02NWYcRvLWXXg/C/HOODAXVSllIdrHpx9lL
	drAAKHkonnnPtXpUtcaC1FfbK6QBGhq0xrz5/gKsMFQtqPWdPamnlyYlVatLznjoqLmco9IUXOe
	9IBF5aXt2p7WUvvZkgpUq2SKkZ7XQUhb86+WX9aHdDxaXmZFcgU440qZ8yym8B6Dx1gs+aApAly
	5Hk9i7fhuQmCje3+lO+5MUPgIgACde4gq7fG2v+wNNCZk5M4tTqz+Q+kbv1jqnvWcYAMA6ftVjy
	5wDx9FdToS3PyP3sxHeJRnJXaNt0u5KsUy73Ar7y0g2ur7MpvtE66JS5
X-Google-Smtp-Source: AGHT+IGfVsoGjX5Sxy1dySCnIJESUxRCyabV8O63iUc1Le7y4o1Ai34RI3broPwT+Hj5nWquSwgUdOuJhlEdpZCZaGc=
X-Received: by 2002:a05:6402:40c1:b0:640:ef03:82de with SMTP id
 4fb4d7f45d1cf-645550809a7mr11399195a12.4.1763991695708; Mon, 24 Nov 2025
 05:41:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
In-Reply-To: <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:10:59 +0530
X-Gm-Features: AWmQ_blM0KWu7aUv8ArY5r4a9fsKMGwJG-SFJqiYxWiv8fYwoMfNFeWPT1HOzl8
Message-ID: <CACzX3AsXD_C50CY0KYNjt5yMY4hm-ZDLQU5dQSJAmP3Duerauw@mail.gmail.com>
Subject: Re: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_054139_437569_84EF111B 
X-CRM114-Status: UNSURE (   7.85  )
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

nit:
s/reggistration/registration/ in subject

Also a MODULE_IMPORT_NS("DMA_BUF") needs to be added, since it now uses
symbols from the DMA_BUF namespace, otherwise we got a build error

