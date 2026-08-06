Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94111C5AC7C
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=; b=1dlybpW3PPE5fNAXaoLlomyHF+
	XLXzSAYbKnyvFLV3CRl/J8ewCh4XRGCN3z2tQaLgeYU+X4mjrWYZ5RaVK0EUJWJihQIK3f7k7XJOH
	CYocttkxJReV6yIYbLmZKShRLI73hv6e0VbzrWEaocBMtMGp1UNAYXaHROzap6bseZPRr5jms3dal
	WE/eRLiT7bi6UeegFTgkysq5YaM6aeZ+Q88cefkeo6kV1jx1T7lQFdX2bhGktTrLA0FT+I1r/fmvu
	wBWfJVZ0+nl7rYYGkBWgaFLGrqWnI/Hv1BGW9skFaEseohgwOGfNdu4jB+MMdR7sLsgPRXbQRIjOX
	63Ps577w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wry73-00000005tbg-1urk;
	Thu, 06 Aug 2026 13:26:21 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrxaA-00000005pVV-1mTV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 12:52:23 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-92f03daaa97so124116785a.2
        for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786020741; x=1786625541; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=fZSUtnfs+TEM3TA4xyBaZbpc6uQuBpEJFh1XSyFVhcteCoa9bxIyNq4iX3W3E0o2eo
         wkw9sZ3GQD+E3ooi9jqMj8LUVn0AxQHLGBq7i83ybKhb3hvhwjkTrHR3WFdedo18M+lL
         nxjmjPVQrF87tuug/7zi0Je2ilTYzMfuGJr+2eTIov13HiIRPkjni4Hre76dhomwhowj
         134R90av+bMKdjHHrB/81uziogckmjnZe+JpWCTQHBEMjZ0lwhSAPGND8JXPEv3UWEIX
         A2un9rzUnYa+NEMVxgCTPupZ1J9wiOLUyCzTraan4PqNB8GNUE19cX0hZQwWNlny+BJH
         k1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020741; x=1786625541;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=EwswBOjy5yOcaH5RDHnQ7zg6ZAZjU5eRDIQhXfpOFIhQ8Fa7Vghi0r346KUlDfrXEQ
         kEw0MHE2mAKrDOcelIBA4qbvTaciVNq/OioNgX4aLWISABopmADB5pcb4jUI7mcOpZpS
         dhl23SdHJsfLbLk1R39T3+2pAS3qs16RCQ14RZO6depRk2Dr9I1ZdFNvwy0PZb8FTZhp
         Oh+rt7E0mveRx9KWsZo7Z2WqLdypdXw3VwR9mqdPuBYtuTYbf4n0z7FlLkOqSrOp/LLG
         A7FxPjzJ6E+YJJyw2SVvkBay/Kw4Q21mRee4E02mUnwAJIXHuqjyia+trhITzjyg6xVy
         yY3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq7MZq2NzQMmCkI/cteMLIXLVXNBaInQyLfPl9pQXsGYoXdlLat2d4lRuKDRkcbvRp+b6gfSf4LI3CJ@lists.infradead.org
X-Gm-Message-State: AOJu0YxGScI1UannazVJI9lRnL7Bj+jP5xaz1zzUb5JsLXft+elAtgEL
	SnSepXvAiVV0Pb96n6aR2QAbDyjuUUSxIJxMgNsdshMoyWRU1RMfGHDbNmAcD84azko=
X-Gm-Gg: AR+sD10+e8pXP4EjRhwyq+n5LsdYEip+hyjTQbbAHd9oTtIji/nU4l9pnyolPFjCxcp
	EaxWFTaYra4DXxtHMb1Y3m0Rq1DEEakopSpFz6qTGeYsXepaw36fzAIuXrxFFAgLCz24kgmFg1X
	mcBPN7QeB+D8x+plr5D80quJ9HHZ6iLSJKJcCrgPZUV13W8QtLc9b5HdKHkiU2coXBGRNjU56b1
	7UODjEqvuL4ZPdQ++7GIm34di3HCBTUyENLkdZS5vkfdby9KDA0mbxp5me8T8N9zyUvSOz1QmJG
	lpaBZ+1hOEtMBrjBYS152pr4z4EgrVik+7L3CxzMhR+hzkB4FT+oG/3R79oH7ygakzv5Jv28K4Z
	RswtuXiRheYFUn6hzyoUSwYMGWRyhq9Cm7CKYo9c2FyEY4N5Di2B/4HGePNzkJwXTy7iqSxKwVV
	goWwrzaQiXA54RbUf3dGdnxFxNqnfMFK/vv6in/eSzXWrcpuw4ycFniyXB5WWPz9wHoLfYpnZXv
	r5DUuLNoWlpN4Xpc16XAnPqohsPbBwOxSN40DNiGFrHHgSe
X-Received: by 2002:a05:620a:2311:20b0:930:84d0:fd3b with SMTP id af79cd13be357-93648fafbc7mr1150209885a.7.1786020740525;
        Thu, 06 Aug 2026 05:52:20 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365ef833edsm123847685a.3.2026.08.06.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:52:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>, 
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ceph-devel@vger.kernel.org
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
Message-Id: <178602073720.2137920.17721545855702977301.b4-ty@b4>
Date: Thu, 06 Aug 2026 06:52:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_055222_493520_49F47F7B 
X-CRM114-Status: GOOD (  10.18  )
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:26:18 -0700
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


On Thu, 06 Aug 2026 13:19:27 +0100, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

Applied, thanks!

[1/1] block: rename bi_bvec_done
      commit: b539aeacf8cc5e9d8e5d94625d2d9c697a167add

Best regards,
-- 
Jens Axboe




