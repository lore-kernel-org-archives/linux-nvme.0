Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7CAC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f4Apnf4bphlPjhBLPjGlt4jDUFtIcbFPTaAGw2Bwtrs=; b=t1OgrNXujBDFBG96YzLUSeUVGI
	CGCsnO5HSamS+oCvoRS0GwLmGn4Mr0dnwb+SS/56eFG88A6X+ydcZKwQ7YCaKEsr/N7ZN3w58KMIM
	1jpa/90Udxt/NuBaaxnLbytMcUHnx7PYXCSlMuDCFm7MhCrvssvKH7kv/QcfWtE8gfrBmCACAOLld
	EmBr/4GR7e9zx/npygHQC6N3s5m+ZZYwjou+1veesSE2VcsH+ThOF8h0gJXBWEWIBmAzdfVhj188F
	2sfG8c43zjmNYzYxn3lVO68DADyKI0u9H/3NTzsES+HI07HbfYx2lvM6cwfYRqye9vvEMpyG4XUjw
	18FpCk7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8qAR-00C86R-36;
	Thu, 30 Nov 2023 23:09:59 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8qAP-00C85k-2M
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 23:09:58 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c1b6fc5426so194154a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701385796; x=1701990596; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4Apnf4bphlPjhBLPjGlt4jDUFtIcbFPTaAGw2Bwtrs=;
        b=iPpzr/x87Ve7208klAeLEOioPdQKKT1H0iBhuZsGUxnLeA0xFJ7fazWJZ5uxKotBKq
         D5+XMiCEZoF2YX2rJ1CfGkUY/2q3zydA2ep18h9M2jjuk67mnVnW0jMrBkhPbKUoF4E2
         EHFjNN9DZLL9rLTED28bYKLv0Izi9ZiNYXhF8Iwv4VCKFNBMvesxyN/0qJXcnXw28lqj
         5kgyQIiDoFQGzBO1vp7J/tOIIjjwdH3bjcEu9yKHYCq1wbLL5PM+bWItvxcmMrEee6+t
         Fj4VqL0eshs8xlJR316Thg3MbP4q29BJDQ6YechiNoM8eEHD1eB27i3wx4slZIro4ClM
         DoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385796; x=1701990596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Apnf4bphlPjhBLPjGlt4jDUFtIcbFPTaAGw2Bwtrs=;
        b=UFwqiG5lsWkeeYTq69gr93EPLgUpUuWOe/D4ye3lPhTVlT12XIrWmd4I26q17tC8XT
         jnjPPtdceAO4WGoNOFIvbSrlMG+uBxneF7Qgkig5XJYU+f+lwZt0N7lyXNUhHcavZAfc
         3QYqR+T4MsMsX59vAdwXVR1EDKNSxLgwrt+nM7ydbjE7eSQeizO+p0uic5hV4VTxa+S2
         NzHXGBSSR1OSN/dETTagbbVxS/AAQOSM3VQnrjfqGP05dlv/C9iWqkl8QKQ+IjkwY/8U
         uIKdEOmImh4YrK+XEJSSdyhTp+/SKBVs4yxPB+ZJweGUWht5zQvC43Zuk1UoqTRMdhw2
         CglQ==
X-Gm-Message-State: AOJu0Yy6vuH1t3gsalYRLxYN/0lHb9RP1ajayZKVuSePfVc6F1SpU2QQ
	q4Ce3TlIryQuGEnUmbU5tunSNQ==
X-Google-Smtp-Source: AGHT+IHqjo5dzVNi162u3rOS8bW91cKTJV44L/VXsuTy9clWrsB/eWTG2BXBa3UO8XRzRCmlg0dMww==
X-Received: by 2002:a05:6a20:5482:b0:18d:4821:f785 with SMTP id i2-20020a056a20548200b0018d4821f785mr2796005pzk.4.1701385796333;
        Thu, 30 Nov 2023 15:09:56 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fn8-20020a056a002fc800b006c7c6ae3755sm1717443pfb.80.2023.11.30.15.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:09:55 -0800 (PST)
Message-ID: <48212850-89e7-42d4-bd9a-93d0c35bc38f@kernel.dk>
Date: Thu, 30 Nov 2023 16:09:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20231130201919.2486553-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130201919.2486553-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_150957_771857_98EEF5C1 
X-CRM114-Status: UNSURE (   8.05  )
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

On 11/30/23 1:19 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This can be an expensive call on some distros. Move it to the end after
> checking the cheaper ways to determine if the command is allowed.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



