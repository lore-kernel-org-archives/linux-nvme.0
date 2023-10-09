Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA2E784AF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Oct 2023 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FbRz1UHmb7XUmCqoAt2aiODWlREyMNkavGrCa5bn36A=; b=qKJ4qZxVPT6Dg0YUQ9dAWhFs/l
	EvZXlTYjZVcEVwnGf0gV0XOt9gXcEXU69z5yHK+M3ytZBqdeksA0RDj3OEFYcp1BnLPInUuZLuqV5
	3zfxwKWSqsaipxghCc9rR8RK3taQVqqJI9jHQMaazOwyRbIK1SokTV9n3fiYwMWm3LFO+71d+Ox7+
	hztpdJ2/NPzGmoBuAw/Zrh9SkeyWaeATAGlx32d1wVkZ9gaMTiufP5Khxgc9xNrIM4xlY+WcL2cqf
	iEXzT3YxapTw61gFXaesg7Amo6JoDOVqGrRn0QFwJkvcmOjaDzJUlvO54ePUUsNVy/8D2wZgeKj5O
	SRErPe/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpyL9-00Bi9b-2H;
	Mon, 09 Oct 2023 22:03:03 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpyL6-00Bi85-1f
	for linux-nvme@lists.infradead.org;
	Mon, 09 Oct 2023 22:03:02 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692eed30152so3678948b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Oct 2023 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696888976; x=1697493776; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbRz1UHmb7XUmCqoAt2aiODWlREyMNkavGrCa5bn36A=;
        b=gYIyjTPNDUsjK0T9dghV/oaOD7L4OueO9v8F3aghUTFp3zYnZykB2FbkkVecgjHnRq
         Y9SNQshaQ6Hc4vUWyEqFRIEoR+5IUSGhletCorvyq/jJjEaMJclP9FPsNPJj/Q01VSTa
         +Ey4B38ezE4TkLgrCJTh4kAogde4ROh7lQWgf4QKYECAzH567KJcD4slAKr7PqjE5kXi
         CviWKfK1RGKaLX+TcSSlpxm6uyBt6xwnt/o5JFFNxGTytf5lpBorfs3KmRE08VG7Yt9T
         htmswe8R912lnqiV2bOf1PdZ6hW2OozF1WY+ROV8U0GoOYZuDlH69wiSA7zQBdrugDO7
         HsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888976; x=1697493776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbRz1UHmb7XUmCqoAt2aiODWlREyMNkavGrCa5bn36A=;
        b=fQf40gePHbyyn7hUlo9yf20rOzwuoMOv10+MwFwxAh/6zmmbsy8M3XyuvEIvOQipRf
         3yzWnxxNcNEV9mQn1CQZs4/YcH3OYfp2AhyWfcPbH5nnfJXzHF+mhs5SE9ndMKzjr7sS
         qGBQUpF6XrcFSqrRpuK6LQPTK5bFmVqyhQDFr95WDtbWlyFNY9GfyhItUhShDdlQwBoC
         dAWSz/33umpsPEZ7vWFYHbVfFcPvbg9slkIrNyj6TA4KOyw3AuySI4lR1XUgRj9HtICv
         wcNHZyPCP8gtL3MyCdvap8ANR4kKDzjE0D7OVPO111vvX7/TB/TYtvrJLjcuzFfNDriX
         oBwg==
X-Gm-Message-State: AOJu0Yxg/7kFwK4no3TZrf/kG3v/fHvMqx6aWpkB3k1up9cBN+rNFPq+
	6KuML7DMEZqci1CGdFFBu8wpYQ==
X-Google-Smtp-Source: AGHT+IEpkt3G98AV4FGoCDMDB+5clUh7WiyyCdUTYHTZBvPKYhyU/1ce58WV9ik5NuXYhsQyrBkPyg==
X-Received: by 2002:a05:6a20:734b:b0:166:6582:a7d5 with SMTP id v11-20020a056a20734b00b001666582a7d5mr16692295pzc.3.1696888976074;
        Mon, 09 Oct 2023 15:02:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b00682868714fdsm7023146pfn.95.2023.10.09.15.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:02:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qpyKz-00BhaC-06;
	Tue, 10 Oct 2023 09:02:53 +1100
Date: Tue, 10 Oct 2023 09:02:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeremy Bongio <jbongio@google.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 04/21] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
Message-ID: <ZSR4jeSKlppLWjQy@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-5-john.g.garry@oracle.com>
 <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_150300_557190_0FCBA828 
X-CRM114-Status: GOOD (  12.88  )
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

On Fri, Oct 06, 2023 at 11:15:11AM -0700, Jeremy Bongio wrote:
> What is the advantage of using write flags instead of using an atomic
> open flag (O_ATOMIC)? With an open flag, write, writev, pwritev would
> all be supported for atomic writes. And this would potentially require
> less application changes to take advantage of atomic writes.

Atomic writes are not a property of the file or even the inode
itself, they are an attribute of the specific IO being issued by
the application.

Most applications that want atomic writes are using it as a
performance optimisation. They are likely already using DIO with
either AIO, pwritev2 or io_uring and so are already using the
interfaces that support per-IO attributes. Not every IO to every
file needs to be atomic, so a per-IO attribute makes a lot of sense
for these applications.

Add to that that implementing atomic IO semantics in the generic IO
paths (e.g. for buffered writes) is much more difficult. It's
not an unsolvable problem (especially now with high-order folio
support in the page cache), it's just way outside the scope of this
patchset.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

