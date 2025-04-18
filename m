Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58329C369CA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMi6RjNLnii56OiqqTtBYh/fDGXu3JBH/VNIF3fIEn0=; b=rSnx/VLN+9TONtZSITnPngouob
	Zj0NM2d/KmFjdb5wjtE/m/Iftyyk8LkMrdJlBrL6ksYyihSeywqnOwhn6csO5uDpz9lEMqYhhm5Sh
	8J6f2liCnej5B1O/NHkVjN74nKSh7Cp6q8XFmzOO6lruOEU5+Xl3sbLW7tJFbfPSSjJ5xxEdcnM8x
	bHMRwwbGn0/uljFZbCWHddhvI7jkXBJHKzIcA5WSxvGLR4j/RWY9leNE0vU2ovT1xM5Xox2q+JUW5
	fl7y32X6QjlTtCswWkqvAHnyhh3ZuEfxSJpt5Gjq/UdU+swfOB2Y+XFgt96CbhfRHIEqNXBkNVGrX
	wEN+fiNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ooV-0000000H1IY-1NLI;
	Fri, 18 Apr 2025 16:43:39 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5iuJ-0000000FrV8-0RsP
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:25:16 +0000
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774193fdffso23692321cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 03:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971913; x=1745576713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMi6RjNLnii56OiqqTtBYh/fDGXu3JBH/VNIF3fIEn0=;
        b=bVyQ6ttR7JN2jz7bIK5qJDhllHW+FEqcaJLQMgFstyuOUu12frjvF4PKGF0sH1yO5g
         ZtNNra9PPw8v7hDN0wlYQhu50kyBtQSLK0AwHvGws6LAnAapHr7Ps6nogBSgegj6eTGo
         cmCWYDAuwTL53kwXmqqCuborq8Yy0E3MdnQDrktg+G0r5s85QK3VzZcHbn0yV0lLWT+1
         yiIXFBXIfCuaMLTWEQomH/XeeAFEGjJaRjNh4GQ0xrjxUxMqR3Ps412AUi7SFFytw7Ip
         tFtfzqq0gzBVDjahsXex6QMERSLRAWI4Yyb+dxvpzEW0BNuJxY8lFHpd6dfuQnWRK8VP
         Opaw==
X-Forwarded-Encrypted: i=1; AJvYcCVO8EJHh9Yf2eoLFg/XU6vWSsN0DzRarOdteeohvNjt0IutfbHh2KiGvksKf8YlNt1P1n7ehBge2Dgj@lists.infradead.org
X-Gm-Message-State: AOJu0YwMiCcd/cAVNVnvt2EcY6oWtRw50/pVibO2zF1LZ/BV61djWfYy
	Dhe3x8MHUOzZfavOMAdg4iqYmL7XBDisTA6XD8FSk0CjiZwCDu1Ypjf8DhMm+mPktA==
X-Gm-Gg: ASbGncsCfXwxJSkDBR290C0R8lcgBto3qLd8qUyCJzSSY6kXa2G0PYUQeJcPLXyXanA
	n4eQIDNskEzY19U4nOKJ6HYMdWnSrW1zAPpPlX1J9X1TtlT5iGtX8wiRH+qma9kWUX+ykwJLy1x
	NBcFvZU0OoeP14dVNGUEbNL8++/Z2hykFMuo/fFDAM/dmMPg+mdmGbeXHZmxUJfoObwY9YOq8AS
	ZR0KX+3WMYh0cFNcQkQ+NHS5jhZ4NUOu8eLhitDjJa8UuU8VTWMNkAxwcV05o+O/ODapsTP7pMp
	jk+w5aBrADVRLDYmDHYPW+7AmYYwBI3KHlpqow2/R033iUIJe0ldiep2LJhEyTv+
X-Google-Smtp-Source: AGHT+IEKJZWW+CA0u03L2I1YwGaBuPS3Jq/Tgj4wyFEY1P0tyWIjeS90rjHfjPUoep1kge+Jl0aKkA==
X-Received: by 2002:ac8:5807:0:b0:47a:e6e1:c04f with SMTP id d75a77b69052e-47aec4cb1fdmr34086211cf.46.1744971913152;
        Fri, 18 Apr 2025 03:25:13 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c17673sm9266701cf.13.2025.04.18.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:25:12 -0700 (PDT)
From: Chen Linxuan <me@black-desk.cn>
To: bvanassche@acm.org
Cc: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	axboe@kernel.dk,
	changbin.du@intel.com,
	chenlinxuan@uniontech.com,
	hch@lst.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	justinstitt@google.com,
	kbusch@kernel.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev,
	peterhuewe@gmx.de,
	sagi@grimberg.me,
	shameerali.kolothum.thodi@huawei.com,
	virtualization@lists.linux.dev,
	wentao@uniontech.com,
	yishaih@nvidia.com
Subject: Re: [PATCH RFC v2 5/5] lib/Kconfig.debug: introduce CONFIG_NO_AUTO_INLINE
Date: Fri, 18 Apr 2025 18:24:53 +0800
Message-ID: <20250418102453.982042-1-me@black-desk.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <bb713790-0b68-4d91-831c-b18fa1ea01a9@acm.org>
References: <bb713790-0b68-4d91-831c-b18fa1ea01a9@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_032515_143326_D9BBA04D 
X-CRM114-Status: GOOD (  14.16  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

On 4/17/25 5:04 PM, Bart Van Assche wrote:
> On 4/16/25 2:44 AM, Chen Linxuan via B4 Relay wrote:
> > 2. Make it depends on X86 and LOONGARCH,
> >     as I haven't test other architectures
> 
> That sounds weird to me. Shouldn't this option be made architecture-
> independent?

It should, but I have only tested it on X86 and LOONGARCH.

> 
> > +config NO_AUTO_INLINE
> > +	bool "Disable compiler auto-inline optimizations (EXPERIMENTAL)"
> > +	default n
> > +	depends on CC_IS_GCC && (X86 || LOONGARCH)
> 
> Why "depends on CC_IS_GCC"? Please make sure that both gcc and clang are
> supported.

I make it depends on CC_IS_GCC because

1. Clang do not have `-fno-inline-small-functions`
   and `-fno-inline-functions-called-once`.

2. If we wrap those options with cc-option,
   Clang 18.1.3 fails to compile test_bitmap_const_eval(),
   with config KASAN and TEST_BITMAP is enabled.

   Comments above test_bitmap_const_eval() says that:

   > /*
   >  * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
   >  * To workaround it, GCOV is force-disabled in Makefile for this configuration.
   >  */

   It seems there are some issues with Clang's compile-time evaluations.

So I think there are some ways to workaround this problem:

1. Make NO_AUTO_INLINE depends on CC_IS_GCC;
2. Make NO_AUTO_INLINE depends on KASAN=n;
3. Disable NO_AUTO_INLINE for TEST_BITMAP
   like how we handle CC_IS_CLANG && KASAN && GCOV in lib/Makefile:

   > ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
   > # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
   > GCOV_PROFILE_test_bitmap.o := n
   > endif

Which one do you prefer or do you have any other suggestions?

> 
> Thanks,
> 
> Bart.

