Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692ECA101F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5dGuAanKwsiY1ZqsKVkDAIjfNLSeHC2vPf4ogltoWw=; b=xsklZq3TRrQCrtM6l5ZLR8ivnJ
	bEI6LAFDD0vFjHJ1+rCNwTiodiRRZel0m0PKlE9BXhYEVytOFOHoBpphbKmrf5O7+iAvpwLJtMn0P
	8o4+7x/oMX+AJF2S26UIhouJHoGHw8PxIkICi2r+Ua4Mw/9PSKeJsMKscWCAm80nk5YMtJMGTMki4
	0+ufJeM4CAM5VoPsx9MGAIu/Gj3PGdO9eddX8S5JTh6xhea+qZjzn49D3/vTQ5r2iL5v78MOszMXi
	z+enwQ1A4++h+MG+ZO+qL2e7ItcoYrV+ZJKFe0PWlyLGLudv7dxeKBdMy77nBz/bGEiW20Ud9RLmU
	hyUqugww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwyZK-00000007kBv-1c2e;
	Fri, 12 Sep 2025 07:51:42 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwyZD-00000007k7y-1L4F
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 07:51:37 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso1670479b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 12 Sep 2025 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757663492; x=1758268292; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5dGuAanKwsiY1ZqsKVkDAIjfNLSeHC2vPf4ogltoWw=;
        b=UCseZp3uby8vNiPrrZcw+BoE8mAOIR2CNeZrTYggUIMHAO4TtLYnuyCvYQ8S9eAsgs
         inTWXG1Kn5MI9ILXdPjNQn5OwX65p94EhVuYbXzJyt2MzD9nr0QyX7jdjqWxcjFLitV1
         mJjVa5tV12+at+A1lHxzda3WLUG4BkNiVlrHPaSNQAgRW3HSD6o8FsjlnWtRdU0BttNE
         RXT/8slT0O4NF1p6EGTX7ZzTLxrzcfnxkVO8r7Lc7+E//IZA3z+60hN/+C+lH9Lp9Ur2
         a+GiDpeXCWTOe2CKlX4ARoztD+otOOCuvV3fSuTgmQjXWySDvlPYpUVmGQuXSRxr1ay0
         X1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663492; x=1758268292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5dGuAanKwsiY1ZqsKVkDAIjfNLSeHC2vPf4ogltoWw=;
        b=X2Kd7hi3GiGo+iH501tMaGgzy7d0LrOVlxl/SOMF3eZW9JCEaW7pLHbpi0FAaWCZsG
         5WdMG4wf17ruRw7qxnk4/bj0CuarJNoRvUWtgfwy0OBq5ItDmOJrSIoK1EejHDBjM2tl
         JPxHzlUQknGg+vqfsJJCNqXtWCRgq/PsNZ1Cb0M0Au0iZebymPjCcTIRNn06s1FO6lZR
         TabEEK+Hjul1fGMlRXCGdhtWsEf9VUUoyjHla7frm9dP29N8Qa+z/3XzLbsXUSy2NWNw
         pKRkL8UMmW3EBu00YwFzls+BJIH/GIaj4TwHfxMLer9LqZGh2f8q9PDYI0jB5Equww24
         fCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIWeQXHOD19YW+whdBJ/ubkhdLP4p4+BCP+fS/ZI6/7/kcGZ+v2I3NdG74IER3gdbc9NL5heJLgShb@lists.infradead.org
X-Gm-Message-State: AOJu0YxwHE65f9p/yyGhBgEqN79T7bScLcJ7ke+Fd23YKacEtyyVTQ7l
	s9BJ7KccW6EQEDcxQvh0ce6C5ytsQUZ26zzD6FsAmk4aOpfhvxTSYCYF195CrbxdjgU=
X-Gm-Gg: ASbGncv9tCOfQi9MdP7aPVd4TrppT4cdq96DmwPHsLdRVXSwoFKgo5AmOuLT+WwmW1t
	NhsqlUte3/q7glorWzi8otoeSoTWXRfKRjAb7ClDXf4t1hFBpBNj2XrTSNX4kVf0rrwOq3Fjksc
	DFNrdHw/qnzE5GaCVcBcJWioXRw/miedE+nRXVL/0Ytpqkn8gBF9aIe6UAjgQSY5EkYJ1BQ8bnT
	lVM4QJRGjyaacLwBOJLlFuOoHPB3bxIuH8F2x4QsZm6h+g7QZpLa9EMKOPW25Xu4veJ4dqmslMl
	HV0yWNa+wUd7lV2ILsEmXMagtLYJbqMNQyE+KLVTq68jROBusdp6uyQwiiDv9nQ0p67wGQzvVHm
	le309HSCSxUYoiFo2m5prcr/3TaVWAVnyrsuvZSktNVTT
X-Google-Smtp-Source: AGHT+IFtDrLHbUf9AliWqdyLS/y+bqUNiq48Oi6Y5dHmTb/VowvDyGiDtwNlsYwwblHsCPFZzZ+p4Q==
X-Received: by 2002:a05:6a20:7d86:b0:24e:a19:7e91 with SMTP id adf61e73a8af0-26029f9e7f9mr2593600637.5.1757663491712;
        Fri, 12 Sep 2025 00:51:31 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm3880886a12.50.2025.09.12.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:51:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:51:26 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 4/5] fscrypt: replace local base64url helpers with
 generic lib/base64 helpers
Message-ID: <aMPQ/sJJmgpZvDsY@wu-Pro-E500-G6-WS720T>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074556.691401-1-409411716@gms.tku.edu.tw>
 <20250911184705.GD1376@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911184705.GD1376@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_005135_597072_B213C39D 
X-CRM114-Status: GOOD (  17.09  )
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

Hi Eric,

On Thu, Sep 11, 2025 at 11:47:05AM -0700, Eric Biggers wrote:
> On Thu, Sep 11, 2025 at 03:45:56PM +0800, Guan-Chun Wu wrote:
> > Replace the existing local base64url encoding and decoding functions in
> > fscrypt with the generic base64_encode_custom and base64_decode_custom
> > helpers from the kernel's lib/base64 library.
> 
> But those aren't the functions that are actually used.
> 

I'll update the commit message. I meant base64_encode and base64_decode.

> > This removes custom implementations in fscrypt, reduces code duplication,
> > and leverages the well-maintained,
> 
> Who is maintaining lib/base64.c?  I guess Andrew?
> 

Yes, Andrew is maintaining lib/base64.c.

> > standard base64 code within the kernel.
> 
> fscrypt uses "base64url", not "base64".
> 

You're right, I'll update the commit message in the next version.

> >  /* Encoded size of max-size no-key name */
> >  #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
> > -		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
> > +		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)
> 
> Does BASE64_CHARS() include '=' padding or not?
> 
> - Eric

No, BASE64_CHARS() doesn't include the '=' padding; it's defined as #define BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3).

Best regards,
Guan-chun

