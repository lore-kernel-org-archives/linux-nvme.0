Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDE4EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8X6ArMXh62A5UxRR3ZN+q1CvObhoeb8ltfmXU1xj+zw=; b=r/foCNnTUgvzcGkDnFs+gpSeyh
	9XWFHSsx4EmosMjZGuOZ3GmtIga4F/T/t3SojAe+8QiTDA+lKsDlg4hRDjYc6r+xlStV5EAt1oK15
	v4qIx7V7yMlz1Q2QlA55SQ3bjQ51x4jERvlp2RVHhzt6ktBZPzcYhCcHx4DYoUtsQcjqqZm4oSsKg
	+5OcDa6pkUg0O9dLI4ta1thrNzMabN4zSE7OTjlpSx1UM2qowy1Ug+TR/xzPk/eUQ4bREnBrf2DCm
	KM4QE1bgcL594wBoLDJ/cykWK+mc/ovGV3s3wavGak1NIc5DR9sKzX29uW28qgQWOBgNSyfdqlWCQ
	VKFgqdzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcP8-000TCg-0r;
	Wed, 12 Jul 2023 16:09:26 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcMa-000SxP-04
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:06:49 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so11509002e87.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1689178006; x=1691770006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X6ArMXh62A5UxRR3ZN+q1CvObhoeb8ltfmXU1xj+zw=;
        b=V0Mwyzpfv5NHo344FebMkemb4OkDhqesSJzk3oLJrC1sXingJzi/DqoHJPX3cM7/kU
         /daZbGumusx7p3ETz9bL+dV7+a249DzrdJ5ucaxUqFs1cH4q4UNK1aBbCP0kRMVezgvK
         Gb0u18D1omT5qk875/bvJSIuyWWXlLKu5WnA0OT929rTcOY7rHqZVsWOvIcdQTq+Q4TI
         Xty8IQiQ2uEFjkBqRHhjaYUeIIjdk3TlKuW6ZBNL29/kZI8LKdOXvAAi+FiRNxSMUXsG
         92h/diWQ5jGfG/Pc/9JTOLcLZ2bS8Hyd3sIfxIs/rFITeR6YjIQmonhcUevYE5m/zN7s
         SmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178006; x=1691770006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X6ArMXh62A5UxRR3ZN+q1CvObhoeb8ltfmXU1xj+zw=;
        b=RJ9WMNdHETCZK4oruoYkQP7wQDe0g+4SGKyIZMzkKUsGeh9czmWO9r7CNOo1MiLUQp
         A1TUxQKQVve5BQD/RwlzHhN5w7yGIIvUJDm1pX/GJLMxAFzIiDV1TzfYZheVB17AQKrk
         +flaNsqQTiCf2VXaWTps7ERIafk2krjZ0MVgXkjZKYOuVgRaooCFG4LPTKNqFvGDpjTL
         9d0hY8fkhC1CZXOpjDOPvfurkt7DMk2nsckXijeVzttk1s4ZVdT7k6Dy1XI+lcNKBseF
         U0bh97/tme9w58C7Yoq3BR79sABhqD7iAuJ8+nJX81jIG7ygfa7lvaTzJAzkaomxHb0g
         PJag==
X-Gm-Message-State: ABy/qLaBLtnWr25jnOmQSrN/hEtsyf9T9BHhoX4RtCPhWY5IFxLBE7yB
	Y3cZUXuXy/irS/vRRaNN3fQOT2v63EMdb1aIAZC6sQ==
X-Google-Smtp-Source: APBJJlHjPtNIqZNhhKZT3JSG1orBAozCwd3+TwwvFjulJuToD7D5iIrA7grwKZQU8Z67qc0UJ0oDxWof6WbkdfMRi3A=
X-Received: by 2002:ac2:5b1d:0:b0:4fb:7a90:1abe with SMTP id
 v29-20020ac25b1d000000b004fb7a901abemr15797051lfn.49.1689178006211; Wed, 12
 Jul 2023 09:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230629165206.383-1-jack@suse.cz> <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
In-Reply-To: <ZKbgAG5OoHVyUKOG@infradead.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 12 Jul 2023 18:06:35 +0200
Message-ID: <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Alasdair Kergon <agk@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Kleikamp <shaggy@kernel.org>, David Sterba <dsterba@suse.com>, dm-devel@redhat.com, 
	drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>, 
	Jack Wang <jinpu.wang@ionos.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, Joern Engel <joern@lazybastard.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Kent Overstreet <kent.overstreet@gmail.com>, 
	linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, 
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, 
	reiserfs-devel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Song Liu <song@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, target-devel@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_090648_067526_D4FBFABD 
X-CRM114-Status: GOOD (  15.93  )
X-Mailman-Approved-At: Wed, 12 Jul 2023 09:09:22 -0700
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

On Thu, Jul 6, 2023 at 5:38=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> > Create struct bdev_handle that contains all parameters that need to be
> > passed to blkdev_put() and provide blkdev_get_handle_* functions that
> > return this structure instead of plain bdev pointer. This will
> > eventually allow us to pass one more argument to blkdev_put() without
> > too much hassle.
>
> Can we use the opportunity to come up with better names?  blkdev_get_*
> was always a rather horrible naming convention for something that
> ends up calling into ->open.
>
> What about:
>
> struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *ho=
lder,
>                 const struct blk_holder_ops *hops);
> struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
>                 void *holder, const struct blk_holder_ops *hops);
> void bdev_release(struct bdev_handle *handle);

+1 to this.
Also, if we are removing "handle" from the function, should the name
of the structure it returns also change? Would something like bdev_ctx
be better?

(Apologies for the previous non-plaintext email)

>
> ?

