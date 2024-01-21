Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131B1C47DB7
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jan 2024 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRZzT2f1JofCE2kB4k8BjPK4SbjBTzmzlRfHn5i6bdY=; b=vnmATflVtdseFdSGhd+W4aXSPd
	orj0LG46FyVdXQQp9PSKre+NNkdvM+IdKJsUz47qh7G5h3Mqz854MDLehak0hnFXOfUVScizca2R+
	uMlh256t5HHdAMpC3c9Qbk7CKl5AXl2ot7zdRoKAdhFc08NXUU0b9zDWjj/GwB+KsHVy3w7J73SEz
	M328jMOB6aHH3WRmy+DU/WgF0cBCy3BgeCqnIlbn4IWb1PTlIewl3BiTx9iKFmdxtp+T6ErUvW57D
	VAhqi8XVb1djsgKMiwK0DjiWuIdlXVVO36s3WrYdaVEfewKnuJValoTFpHv64Ks35vTURWr/G5T+z
	rgkVMGZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRew2-00A29H-1X;
	Sun, 21 Jan 2024 21:00:54 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRevx-00A27a-0a
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jan 2024 21:00:50 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d5ce88b51cso146155ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jan 2024 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705870842; x=1706475642; darn=lists.infradead.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZzT2f1JofCE2kB4k8BjPK4SbjBTzmzlRfHn5i6bdY=;
        b=OjRqTVMY8XsH0LkCV4oItzfhQt9yv5Qe0aMuflofx/FI7ZPwWCTK7YkxrZDfdxhtLc
         XGKjCHE4r/refvR7amJl+3weQDrbufxnZwLif0eYVKDogbsEdCe/lyVTAXdpLUb2qsfX
         4JBEzrq7dN/AF4QMK/CgKEO9JUXWXP53x1uS5RwgCcNXqYM5D4yGtNAxWOPsZ0KAX8ZQ
         xBDUluqdyYCOsRzQJrLZX0H7NBKaDX04yse3/Ziu3RynUEhq2vdLmnE+4WADAaZcLp7e
         EUuF7oHN6ebMggPaG0kLyTp6KLBv9DvizZCUvRrF73DreUJbHQjMcr2vHAXXKFtdULso
         +9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705870842; x=1706475642;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZzT2f1JofCE2kB4k8BjPK4SbjBTzmzlRfHn5i6bdY=;
        b=W9GMJMPiaCwZ42lqusG7Wc5DpJW/wki/pnQbPgwcKm93LHiertAU46NipO+7/D01QZ
         kJs6eelohgjlHyTmJRE9K2FV1AsRDuFBFGZhQ1oEYWAyAgfXeFL2h7aG17trP3ig/BnK
         e+JAjeRW1vOwB/sW4A66yLs0rmO+ott+N++TvOhGlWnRP/w1TaxUhincbGRtdArV5aBY
         AfOqzYov9p9tFf6mYW3XQqqh7V1aj/dBYL+nGZWfV77z5iSKHAuXFjwlJcunjtHQX7qt
         vOqHZzLxW8ET7RQCi3tiqS0X+pnGxXfIRQfoiaccnrOKtfdWbtM9opnC58T5J4YXLiWc
         r23w==
X-Gm-Message-State: AOJu0YwkjQ0BNLSkROFovFe3QReZIRs+EjKxyPaZPPwGoEtnU9bJHWhf
	TIz+/oHeoVx2q3T3HrRf/55l9SA61Ovu
X-Google-Smtp-Source: AGHT+IEXMNPZIS3H5wZZueT2jT74eobFzGlQuvq//fhxcAORa46mOSrn/8EHf0mLkfzQHYyU7j+f5w==
X-Received: by 2002:a17:902:ecce:b0:1d6:ffb7:4af9 with SMTP id a14-20020a170902ecce00b001d6ffb74af9mr161181plh.14.1705870841493;
        Sun, 21 Jan 2024 13:00:41 -0800 (PST)
Received: from [2620:0:1008:15:9c9c:e5a:9eed:f21b] ([2620:0:1008:15:9c9c:e5a:9eed:f21b])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028b6759d8c1sm8191663pjb.29.2024.01.21.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 13:00:40 -0800 (PST)
Date: Sun, 21 Jan 2024 13:00:40 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Matthew Wilcox <willy@infradead.org>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>
cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Message-ID: <b04b65df-b25f-4457-8952-018dd4479651@google.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240121_130049_215719_6B363395 
X-CRM114-Status: GOOD (  17.96  )
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

On Fri, 19 Jan 2024, Matthew Wilcox wrote:

> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
> 
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
> 
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.
> 

Thanks for proposing this again, Matthew, I'd definitely like to be 
involved in the discussion as I think a couple of my colleagues, cc'd, 
would has well.  Memory efficiency is a top priority for 2024 and, thus, 
getting on a pathway toward reducing the overhead of struct page is very 
important for our hosts that are not using large amounts of 1GB hugetlb.

I've seen your other thread regarding how the page allocator can be 
enlightened for memdesc, so I'm hoping that can either be covered in this 
topic or a separate topic.

Especially important for us would be the division of work so that we can 
parallelize development as much as possible for things like memdesc.  If 
there are any areas that just haven't been investigated yet but we *know* 
we'll need to address to get to the new world of memdesc, I think we'd 
love to discuss that.

