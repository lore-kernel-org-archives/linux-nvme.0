Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF7CC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 14:48:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866AD60F41
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 14:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 866AD60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rDI+s3bd4sjuzfHop41bZM1m282HrK25avnEdGUtb24=; b=19VUCpZrSNY5ye
	aKu3rcD9AfGq8Dpv6UuzimvCYAqmGHFmlMEQ/hEDoa/7/s8PKGQPBRQxuw0HlphdBbJhtSnaDJpG8
	ShKXVJNMNUANtOfcQ8vJJX2C1zr35ysaj3uX41/acg/qnyjgRcKqnHTSpaJ7B+A8bGPbskCxuKYrJ
	zXNM7jZzZbGAJqysCc1/M2lQGQR3CPX8ACwhbVUfZhnd+rKRAhhG7VhFrnXMADS+pTOOZ6j2gMhNF
	HizHU/wMzUm7A4A5Hhpik7HOTw8a2VIFBND9yMTAt6QhZZhvdxPLuuamzYsnctXU6K7jeASsr0g8k
	0LgBPHwu7ZvLlmGme6SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0OD-002j3K-6g; Tue, 17 Aug 2021 14:48:29 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0OA-002j2N-Lo
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 14:48:28 +0000
Received: by mail-lf1-x136.google.com with SMTP id g13so41811838lfj.12
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LkI5q0Ud7n3yU60UTm3c6JeteGC7wMUAGiEejPjFM0g=;
 b=Vnd8MvzcyIJss0OkwpMOukq2mHc6qzT3i2r3F2v8Rq3m4IyAu38H3oi2pVyzXM9G+s
 9VecOZWA8UAF+urrr+2W519JaLBlHuWQzG+UDOngpQkbSQIj0M/0ws8PZhy6xLhG07Wa
 Vz/DJoYr8NWlmQtvDqIea+oR7xpJHXXiqxGFF3SOwH7uyLdNstSbjKZJ2uXuFYYwEX4r
 fr0NXkker9zxQM8m6Q9vTdYWONIUCHPKEIJ0MuujaeG25SlMoKnMoV0oCv6SIjnOz5rU
 sugq1U8oav7TjjWnQTEBM/oIZ7yUGwYL0iDYaL2+yIIAxr4gb+Bxv6Th8TCaf6NRLBLn
 4brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LkI5q0Ud7n3yU60UTm3c6JeteGC7wMUAGiEejPjFM0g=;
 b=L2981esATdyUIvLXpMpGplGn/Vg6zBzyyNnCNERYIiJHvtUrfyTC07orcPyape7NpK
 4gk/WrNL7Mqpawh5AmsPBkWluv4aur2vnNBqnNTzIp3m/MFRARzqZKDq4nbql9DxWgDK
 uuQD+HE6LYPPyLBvEYQdQ29oE7maEKBEEmJvCS/mCbZx+lDzVF8Y8M3t4DksMu9jmiF7
 JdPXeyTIIawXbh+eGXXuQyaAaAsU1+81XkqTV4vIWFP0sjMXBDhFsXFyQOxZr+NOg0E7
 zVoCYJjAdjw1MFHvxE8lspWXrnNXIMLCb+arhoi2CT+BsmuVobG0z1GIFEMhOxxucdr4
 FD/g==
X-Gm-Message-State: AOAM5304zx0fxImvKmwqy8GNzoOPINZ/d/ho9S2G4X6Ba7ZNoZyXc3Lm
 mSLR64L/TJQets0LFXcxZIzLOOS53oDw7C7tXJs=
X-Google-Smtp-Source: ABdhPJy78VibbpwFw9aY9bJD6KbF0FN0r9oY1sz4LqrxVQ5ggLWZJqClrS+h2E/ukIwkOys47vQF7tDbHI+OS3kdo5Q=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr2666539lfm.459.1629211705214; 
 Tue, 17 Aug 2021 07:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com> <YRu1WFImFulfpk7s@kroah.com>
In-Reply-To: <YRu1WFImFulfpk7s@kroah.com>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Tue, 17 Aug 2021 20:18:13 +0530
Message-ID: <CAOSviJ2q-y8h=Pf4t7oUZoL7WHdYeFQQOnoeN6Ta07iPNjX-wg@mail.gmail.com>
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
To: Greg KH <greg@kroah.com>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk, 
 damien.lemoal@wdc.com, asml.silence@gmail.com, johannes.thumshirn@wdc.com, 
 hch@lst.de, willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com, 
 mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org, 
 snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com, 
 nj.shetty@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_074826_800279_82178B02 
X-CRM114-Status: GOOD (  27.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 17, 2021 at 6:40 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 17, 2021 at 03:44:20PM +0530, SelvaKumar S wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> >
> > Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> > to a destination in the device. COPY ioctl accepts a 'copy_range'
> > structure that contains destination (in sectors), no of sources and
> > pointer to the array of source ranges. Each source range is represented by
> > 'range_entry' that contains start and length of source ranges (in sectors)
> >
> > MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> > MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> >
> > Example code, to issue BLKCOPY:
> > /* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
> >  * [64,24], on the same device */
> >
> > int main(void)
> > {
> >       int ret, fd;
> >       struct range_entry source_range[] = {{.src = 0, .len = 8},
> >               {.src = 16, .len = 8}, {.src = 32, .len = 8},};
> >       struct copy_range cr;
> >
> >       cr.dest = 64;
> >       cr.nr_range = 3;
> >       cr.range_list = (__u64)&source_range;
> >
> >       fd = open("/dev/nvme0n1", O_RDWR);
> >       if (fd < 0) return 1;
> >
> >       ret = ioctl(fd, BLKCOPY, &cr);
> >       if (ret < 0) printf("copy failure\n");
> >
> >       close(fd);
> >
> >       return ret;
> > }
> >
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h |  8 ++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index eb0491e90b9a..2af56d01e9fe 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
> >                                   GFP_KERNEL, flags);
> >  }
> >
> > +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> > +             unsigned long arg)
> > +{
> > +     struct copy_range crange;
> > +     struct range_entry *rlist;
> > +     int ret;
> > +
> > +     if (!(mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> > +             return -EFAULT;
> > +
> > +     rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> > +                     GFP_KERNEL);
>
> No error checking for huge values of nr_range?  Is that wise?  You
> really want userspace to be able to allocate "all" of the kernel memory
> in the system?
>
> thanks,
>
> greg k-h

We added a kernel imposed limit MAX_COPY_NR_RANGE for that purpose,
but missed adding the check here.
Will have that fixed. Thanks for pointing this out.

Nitesh Shetty

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
