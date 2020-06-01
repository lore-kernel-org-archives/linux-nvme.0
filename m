Return-Path: <SRS0=I3sE=7O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D903C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:03:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB95C2065C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SkmoNIhb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy+GRsFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB95C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+feRdzvXh4SkdNTrdOknkSgksR76eZnQFdtBgoAyuyI=; b=SkmoNIhbu2aaul
	/YlmBb2d2xoxcrNq6fMQxOqUy/wXRPqFCCWkqJCq06wj7A04B1Bx3jQW30mHVxkraloO1ouEu9PKy
	BszKZG9c2yQpOJi9E3rJ4rDM9iqxqGLxdryPUbQgme0ZMFsCNz7ZmrJjZyWwBsZNWC3ynd2KTaUoP
	mh7dum+kbfguvn5aXNkOTAzf8tMmm3o18BavUqZWoP2hNU4ayRZKoqfeUZikY8IjY9UYmBg9vjJdU
	NIOqYrHC/LS177bASB23j18d0AcUS8NLKV68cCqYI8+e4Cuc9ks0U6+BafAotvzfcGCGcuruhuT+x
	EcAXnNWdCjVvoZk5kgiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jflxo-0003g9-92; Mon, 01 Jun 2020 15:02:56 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfem4-0007wJ-UO
 for linux-nvme@lists.infradead.org; Mon, 01 Jun 2020 07:22:22 +0000
Received: by mail-vs1-xe41.google.com with SMTP id r10so5029971vsa.12
 for <linux-nvme@lists.infradead.org>; Mon, 01 Jun 2020 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LIgRN0QDBu4gnSn3TisqfMx5xMC/fpgZPP0eL7TYZo4=;
 b=Qy+GRsFwP59gROSPpwcSk+d4BmBdCEdjxVcnG89ETwVbaChC3CZGqNCjYA5q3zZEXV
 ftJjSX22++JyxqShjPrcs60ExBRV9rkg0po2DVvCYUGUQ+/Lln9ssEhgcKVqibq5h1QD
 3GcB+VR5pmjymE7fc4kCi6UuBXGedcxGeKYY0JahfpNnaRtzua+jlXVyuPKz5eq95nyx
 FH5rsmTOlXiADyitE7Yo9XplyqzAHQ1AspJB0cypzPPGDXANPkzbpULgcPelQMQlpYkn
 q2rtZDeeH2pm1YHT1QiK+n+u+A7jM83OUkEtSD+uInIdVHUsPiVFys6kxdjnMNKzkX37
 ++ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LIgRN0QDBu4gnSn3TisqfMx5xMC/fpgZPP0eL7TYZo4=;
 b=XJplLTcImmnhKOZTeWfWV1HDrnIUce212UcjSom3D+zUCQsWlTmNlNhNFcOGMbkGYu
 o/8U77pO7P5xSSRggtI9og2TZsLLrlJ623vbuaKo2r98EOdbIHqdMqQR2XL+nx8/jjeX
 BdbUIXDetodMw0CxtWNid6UtZy3AAJo3ExKjDajHKbLvVoojtu6JV9YgasCvYhXj8lbi
 +IAud27Sm7UcuX5DiNm5mdUbyxas/WVMu5WG60fYdAu4zRsv44daTvhrrpTmYypUELYD
 PZtqaWNKfjrRdzAFdIr+bNkLQUtUZGecsHFA1TDrCn/XkuWECF6gACVAP7gmcmBT/hHs
 AETg==
X-Gm-Message-State: AOAM533ih7ZQPcRfbZZVwwJLjLgUqxQqG6xP+X6oVH9H2aINSVRB0xq4
 fh9YZC4F+1gbLpQRWr1E4VeWwth7JE5YFRUDcpI=
X-Google-Smtp-Source: ABdhPJzIA1FGKrVz+9UgvnCvE4qHbM8WwKnt0yzT0Ej9MwEf3XXL3bZ9GG5bYf4/kar44nR6s2ZBVVKbKsVOWbpBIWw=
X-Received: by 2002:a05:6102:a17:: with SMTP id
 t23mr9115865vsa.62.1590996132886; 
 Mon, 01 Jun 2020 00:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
In-Reply-To: <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Mon, 1 Jun 2020 15:22:01 +0800
Message-ID: <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
To: Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_002220_980435_AAFD1761 
X-CRM114-Status: GOOD (  13.49  )
X-Mailman-Approved-At: Mon, 01 Jun 2020 08:02:54 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, bvanassche@acm.org, darrick.wong@oracle.com,
 Mark Fasheh <mark@fasheh.com>, satyat@google.com, hch@infradead.org,
 borntraeger@de.ibm.com, gor@linux.ibm.com, ajay.joshi@wdc.com,
 chaitanya.kulkarni@wdc.com, chao@kernel.org,
 Josef Bacik <josef@toxicpanda.com>, ming.lei@redhat.com,
 viro@zeniv.linux.org.uk, Muchun Song <songmuchun@bytedance.com>,
 dsterba@suse.com, jaegeuk@kernel.org, jlbec@evilplan.org, sagi@grimberg.me,
 balbi@kernel.org, damien.lemoal@wdc.com, martin.petersen@oracle.com,
 joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 29, 2020 at 10:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/29/20 8:11 AM, Kaitao Cheng wrote:
> > There is a function named ilog2() exist which can replace blksize.
> > The generated code will be shorter and more efficient on some
> > architecture, such as arm64. And ilog2() can be optimized according
> > to different architecture.
>
> When you posted this last time, I said:
>
> "I like the simplification, but do you have any results to back up
>  that claim? Is the generated code shorter? Runs faster?"
>

Hi  Jens Axboe:

I did a test on ARM64.
unsigned int ckt_blksize(int size)
{
   return blksize_bits(size);
}
unsigned int ckt_ilog2(int size)
{
    return ilog2(size);
}

When I compiled it into assembly code, I got the following result,

0000000000000088 <ckt_blksize>:
      88: 2a0003e8 mov w8, w0
      8c: 321d03e0 orr w0, wzr, #0x8
      90: 11000400 add w0, w0, #0x1
      94: 7108051f cmp w8, #0x201
      98: 53017d08 lsr w8, w8, #1
      9c: 54ffffa8 b.hi 90 <ckt_blksize+0x8>
      a0: d65f03c0 ret
      a4: d503201f nop

00000000000000a8 <ckt_ilog2>:
      a8: 320013e8 orr w8, wzr, #0x1f
      ac: 5ac01009 clz w9, w0
      b0: 4b090108 sub w8, w8, w9
      b4: 7100001f cmp w0, #0x0
      b8: 5a9f1100 csinv w0, w8, wzr, ne
      bc: d65f03c0 ret

The generated code of ilog2  is shorter , and  runs faster


> which you handily ignored, yet sending out a new version. I'm not
> going to apply this without justification, your commit message is
> handwavy at best.
>

Do I need to write the test content into commit message?



-- 
Yours,
Kaitao Cheng

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
