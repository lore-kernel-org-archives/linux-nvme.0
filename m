Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D064C6FA8E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 04:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OiLX93qNxOIggMQE39gtCyYpTO910rpc2HqmiyP4Wqs=; b=MevfFLeot+IktM3V/7oI6eZG1R
	PNDmYXiBHmlUdr+lG4Tog5LN4UJ5TmiExtwwBebDnWP4Qfcr1dvvplqQkyuMkEcTyx1KK5Zf5M4DT
	qxllZLLtrELiNB38AqzNljX/EkBtsC3nushXY+oH3WV9BNcFWAAmdeopse+B9KIpV4o22wtNnNDDC
	UbDkMt0Lz7Ej94wjYGW/D90ndsrUMwd4CzEdJcmZnia0n7YMAPvunhPFYyKWlRv+3tvanYWdwAdZs
	4UndOYbCxNmTX/5h8LnGdkNEH2f/esrzuWDvYhALiywACINgz2YkfL+VaGsjY8QEQ9gXOvI8plArx
	t5iPg93Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXaN4-000mOn-Ix; Thu, 02 Mar 2023 04:16:46 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXaN2-000mO2-Bl
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 04:16:45 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d7so16782764qtr.12
        for <linux-nvme@lists.infradead.org>; Wed, 01 Mar 2023 20:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLX93qNxOIggMQE39gtCyYpTO910rpc2HqmiyP4Wqs=;
        b=A1EaYf8tKwM+OSZSx4sx0qUaPdLBesg9gHN2HlrQvObNa2lqTRK6IIiYpalGERQjcF
         pn+3xJBA/2791KiNqkOv//qXihovDpzswgjkqop1IXsV/L8NKh0Reo/ds5+FfnISkwnR
         I4WYiYH26wHIo2lOKIbarUgozHVzZhjq93i0zsrTBDllz8HnRhjt1fP7c+82n2uMukdc
         FrBA3ORoe7jdcFdPw9qrbyGt3C0CW2OrZV5E0sHojytvWDuV8PlYeOB/d3LJNDdjuJSG
         uvSrX/ZjBU8NVnQtHqnVeKjdMBgeElsggH2A6HgKfI3fDqki+55VcLxx2U4VMZJDfP6k
         wNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiLX93qNxOIggMQE39gtCyYpTO910rpc2HqmiyP4Wqs=;
        b=uEFrQ5ov0TU5AknbXEIWn0ktXELLxms8OQpJrLzQcH7xWVz6o56LmkMi3LZH/RvH79
         +RwpZFsqRVKt1xIM1qLbrrATx2Pfsng0euUk3itZNj7K4d7Xoz1NC5HsDGc9HB2KE7nh
         qVRdtxm617gs8tgbw4g/Iy8Tg7JM1qMdKxwsxljCiIYZPG9QVhC7kKlZQSCbu/xjEA72
         JTCCovptkgCORmItP6YpvMnr9XyFA8K/3UShwXHQbVtT0Y30xf0O0uaghmMqZSWfcL4k
         4txA/sIcqhARG5gVWSH3WmemDJFpGTKw6u07CHqcK+e7MsaUJOjziUw6olpenx2A76Im
         GLuw==
X-Gm-Message-State: AO0yUKUH2bvuDD6uDJH8duesi2dFDH7fn8BRn08D8b68U0sJ4+UGmThm
	zpysVJ83GBHNSEeny8JydY97Boxba/FW5FuFT3I86g==
X-Google-Smtp-Source: AK7set/1Qo/2N3JCxnEKF/vVdWvMT8KXKuR0NcpsojQRCVOxjmuWm2l5Wboe2MANA6zXLOiyu1AmcY+R5Hl0TYWvINA=
X-Received: by 2002:ac8:444a:0:b0:3bf:b844:ffc7 with SMTP id
 m10-20020ac8444a000000b003bfb844ffc7mr2387535qtn.12.1677730602197; Wed, 01
 Mar 2023 20:16:42 -0800 (PST)
MIME-Version: 1.0
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org> <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
 <ZAAgKTWpwCE1fruV@casper.infradead.org>
In-Reply-To: <ZAAgKTWpwCE1fruV@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 1 Mar 2023 23:16:06 -0500
Message-ID: <CA+CK2bCxBqjh4b_-ZU8czDR-naaHJVKWo38uhB2_a9x18NWYbQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230301_201644_424830_8BE424FA 
X-CRM114-Status: GOOD (  17.88  )
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

On Wed, Mar 1, 2023 at 11:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 01, 2023 at 10:50:24PM -0500, Pasha Tatashin wrote:
> > On Tue, Feb 21, 2023 at 2:58=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > My goal for 2023 is to get to a point where we (a) have struct page
> > > reduced to:
> > >
> > > struct page {
> > >         unsigned long flags;
> > >         struct list_head lru;
> > >         struct address_space *mapping;
> > >         pgoff_t index;
> > >         unsigned long private;
> > >         atomic_t _mapcount;
> > >         atomic_t _refcount;
> > >         unsigned long memcg_data;
> > > #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> > >         int _last_cpupid;
> > > #endif
> > > };
> >
> > This looks clean, but it is still 64-bytes. I wonder if we could
> > potentially reduce it down to 56 bytes by removing memcg_data.
>
> We need struct page to be 16-byte aligned to make slab work.  We also nee=
d
> it to divide PAGE_SIZE evenly to make CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMA=
P

Hm, can you please elaborate on both of these cases, how do both of
these cases work today with _last_cpuid configs or some other configs
that increase "struct page" above 64-bytes?

> work.  I don't think it's worth nibbling around the edges like this
> anyway; convert everything from page to folio and then we can do the
> big bang conversion where struct page shrinks from 64 bytes to 8.

I agree with general idea that converting to folio and shrinking
"struct page" to 8 bytes can be a big memory consumption win, but even
then we do not want to encourage the memdesc users to use larger than
needed types. If "flags" and "memcgs" are going to be part of almost
every single memdesc type it would be nice to reduce them from
16-bytes to 8-bytes.

Pasha

