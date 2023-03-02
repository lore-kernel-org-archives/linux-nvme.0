Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460B0C678D4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 03:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fzTjgY6pmauoRhbcUsPGjrkNqmIUEBSmPmq+35HbjTg=; b=Nt0VkD7RSPu9zj47Rn6z8fBBkf
	PE0JIpSETHcuY/JEUY57DPfQyDk9qWIiAt2o/WGO+rKnkmxW4YaaZR0u6eGCnNzketicupTHBtLW/
	TkZjCywg7RFGrVmTCCBagzEHm0E5v+0OZYRtvacYwmjkrGBkPCWl78Yt/4b4gNX4+WypDj+SGo/Zk
	pPBK6eOqOALyrIYmxHf0RObE6k1094PyY8L1FcVNZogMGrwo3kYuUE5XUMBKmUd8JWzLWIFXXbSOW
	zoGsXve47yIJEib++BYADBeKnopAYulCUdcPxfZ4KNzLv60FW5Atf7snONUA3Mt4DU57dLCdL1SOU
	wwTrsOFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZyJ-000jDZ-GD; Thu, 02 Mar 2023 03:51:11 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZyC-000jAm-1e
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 03:51:09 +0000
Received: by mail-qv1-xf33.google.com with SMTP id nv15so10831190qvb.7
        for <linux-nvme@lists.infradead.org>; Wed, 01 Mar 2023 19:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzTjgY6pmauoRhbcUsPGjrkNqmIUEBSmPmq+35HbjTg=;
        b=Rkuxl05ESC6Da+YLV7H66DkVfB1H8MyYtOQTFidtgWYvhbtoHJdCqcJomw/klp4f4p
         XqBDwFnJdEAl0ucWx7CcTrs33pFqclCljuCmVnqweMj8LBzRRcsivrU/C4lkocoI9+yC
         C2mwzEPg/paf33J2Ji903B8EXrlrjNb+QaRv++UOOM2kcOMT0AMqQT7WBx3o8xEdIIht
         Nvihj11tox4hI7iUb3GIKpWeU1TLzUpq0QTI5SuYWe6pIduvYtTpTr3k6O5ufrXdsG9Y
         ok6hT9dX2S36ws37fXeesUMc/TS/FsilHh/kLZ8I7qRn6IZeYRPSJfWQ1VmEwgvv8ykT
         DsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzTjgY6pmauoRhbcUsPGjrkNqmIUEBSmPmq+35HbjTg=;
        b=uCCZd+I2XQH5v1hlCgzop6hSFZ14tc+psw3k6zV8zYOo0rqqtYPkG53ql6yPAXbVMf
         6+BrKMQiLozbXNfamwrg7z3ucOZ2hCdvZo+qcxvZoKHR5NRm47IhedvuAUVsqkktHhqP
         fN25O6cIgoe/5jtxd+T3i60jKQrdlzAoHiKqyzhSbD3hYiY8AmxxoNoOX77rsXZsX123
         ou0RT32OBRUM0MkR9XFRwO+S4UmiZ3GXjp/60aroBoRgi4CMVy49lZusVWW9cxIZvxGz
         N3lsuat4z7iCOLwkpvDL1mj55Z/kyr438QqGskpEy0E8uskl5xENuiGnMXqvhRkmYcGD
         nYFg==
X-Gm-Message-State: AO0yUKXil7SrzQGb5HsQJVqVc2jq2PlhFnJuJj5wxkEepyc64SRxhpDD
	nPab2pdbM81Pz6Sc1ej0JvXf1aJa7RlnCDaByotJwQ==
X-Google-Smtp-Source: AK7set8ZL6X672cfoaD5RsaDZWMHx5fDeqg32Dh9XQt6wt53fQihsEF2Gfjbea6c1Hmrrha2XrzWXFkxe3TZdU+vdG4=
X-Received: by 2002:a05:6214:4a43:b0:56e:9089:a447 with SMTP id
 ph3-20020a0562144a4300b0056e9089a447mr2200388qvb.0.1677729061071; Wed, 01 Mar
 2023 19:51:01 -0800 (PST)
MIME-Version: 1.0
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org>
In-Reply-To: <Y/UiY/08MuA/tBku@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 1 Mar 2023 22:50:24 -0500
Message-ID: <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_195104_378213_8E117613 
X-CRM114-Status: GOOD (  24.89  )
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

On Tue, Feb 21, 2023 at 2:58=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
> > On 2023/1/27 00:40, Matthew Wilcox wrote:
> > > I'd like to do another session on how the struct page dismemberment
> > > is going and what remains to be done.  Given how widely struct page i=
s
> > > used, I think there will be interest from more than just MM, so I'd
> > > suggest a plenary session.
> >
> > I'm interested in this topic too, also I'd like to get some idea of the
> > future of the page dismemberment timeline so that I can have time to ke=
ep
> > the pace with it since some embedded use cases like Android are
> > memory-sensitive all the time.
>
> As you all know, I'm absolutely amazing at project management & planning
> and can tell you to the day when a feature will be ready ;-)
>
> My goal for 2023 is to get to a point where we (a) have struct page
> reduced to:
>
> struct page {
>         unsigned long flags;
>         struct list_head lru;
>         struct address_space *mapping;
>         pgoff_t index;
>         unsigned long private;
>         atomic_t _mapcount;
>         atomic_t _refcount;
>         unsigned long memcg_data;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>         int _last_cpupid;
> #endif
> };

This looks clean, but it is still 64-bytes. I wonder if we could
potentially reduce it down to 56 bytes by removing memcg_data.
Something like this might work:

1. On a 64-bit system flags field contains 19 unused bits, we could
potentially use the free bits in this field.
2. There are up-to 64K memcg ids. So in case this field contains memcg
pointer 16-bit id would be enough to convert to memcg pointer
3. In case memcg_data contains a pointer to a list of memcgs, there
could be a separate hash table data structure that contains pointers
to memcgs for slabs, or other users.

However, I am not sure how that would affect the performance, but it
would be very nice to reduce "struct page" by  8-bytes.

Pasha

