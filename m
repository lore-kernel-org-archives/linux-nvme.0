Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120E8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YiN+4De7KbvFLtBNApX/wO1HMLqf85/WU1oFiw5GP4=; b=Eoz1xdnUWttcaIAJB0K/6/irMM
	dtdVulLiDbLVl9RK4sx3RNtEyat7pK0yK4/WqoYYgYvU9qJQIewI5nGfIXl4kQMp3n2cBr6NKP5JA
	gYQ0UfCvOhga3AmpWPD77/26QMvXyqUnef1qYd06es2y9H+BHkZtiaJDh8d6SwXFB9+P11J1Wg4YN
	UiWFk+t97k44gHxoTU4ssJ7m7SZfzkFODECNkoBvXcbLq5UUa493jvkksnJ1e/tL+mLhL6/+xbuBc
	TR1xAV6nlJGeCO+8+zT1KvbGmCp2RiSUMC3F5MJxOTW1fN1PdAhrpiJ6UYbd83kO7aN+t0X9S+VIm
	gHnAMfQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nomBX-006uOa-VW; Wed, 11 May 2022 13:15:23 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nomBP-006uLe-Kn
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 13:15:17 +0000
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-d39f741ba0so2698087fac.13
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/YiN+4De7KbvFLtBNApX/wO1HMLqf85/WU1oFiw5GP4=;
 b=j1Mwh9FDWbws2uMSn0V+sBqtnKqxUFYuxoYQjC/6dy58BprpoxLZZDvVXK2b5q0R4h
 hOiGyGOTpgkSObpKRKQYxqhGBRwuZSVTmGG6zw0BKcM5e6jdmJgE2onimfJxLY7gq2Eu
 GkWAHaOKWmLTerbDGvAd6cEGRuyLBSNq+V+cvSU4dGEk0V60VRvGR+sXNkvhpTwPaWTL
 HxhbbQQMJan9QHe4KMhNpVBUy0Uz7Ds8OXDUwUxG2aEhqMQZjBMWcHjEWqSxdmDlBLkV
 dBtpPonhzq49MSsA5XFxVDBYYRYux2VdouchKgAbgj8Dpaeyfu95lFNE0KhqzOS3dlGA
 rHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/YiN+4De7KbvFLtBNApX/wO1HMLqf85/WU1oFiw5GP4=;
 b=wLg7CA4ATEz7sV+dorKeexpGlw3zCJYVhhNxWqTjyyLAGK+k1OeOFjNU1zEXCXaSc3
 i5oM8mg5LJMUhSmTYLoOyFzyk8rIoMJ7IrJVFiSbBXjgeZ1KbmMRb7CbSgVyisomst58
 ryFewOKi66UrQten40kaep59eG6EfqIOx+xVj+DDeyx5k5YTvLCWPS6QrZWmZM5jNUn8
 mMs8lIjQJ72zP8EQsEMQpw1Ct1WlHjBKi12EehaNmse2g1kh4FHQ5pM+Iqi3Zu9JEy2b
 f+knOHn7TEdmFhBNHDeVLBls5712JkSKbZ7DCh2ZfJP2kj4J60nt+XHK5gYqYLH/VQw8
 w29Q==
X-Gm-Message-State: AOAM530/DXhKwFVYpWmUr1y8MttOom34HZsAExooSJiWS+/9gOb57wvs
 Z8IwIfm0lY1Tg0BJUVBsXpkWNeA0IrS/7Z5EPCw=
X-Google-Smtp-Source: ABdhPJzBzN+cZ6x717t2j99xK2JBS7sD7mQ4UCSCSdWINjK+8VegDUh6mQneTC60tLZgCEpXeViwN0QYOVZnnNuDQ6A=
X-Received: by 2002:a05:6870:6006:b0:e5:e6f1:5f2a with SMTP id
 t6-20020a056870600600b000e5e6f15f2amr2650016oaa.160.1652274913458; Wed, 11
 May 2022 06:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220511055306epcas5p3bf3b4c1e32d2bb43db12785bd7caf5da@epcas5p3.samsung.com>
 <20220511054750.20432-1-joshi.k@samsung.com>
 <b7f8258a-8a63-3e5c-7a1a-d2a0eedf7b00@kernel.dk>
In-Reply-To: <b7f8258a-8a63-3e5c-7a1a-d2a0eedf7b00@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 11 May 2022 18:44:48 +0530
Message-ID: <CA+1E3rLe0QASNQFMwSjOe-xn_JMzrtG416cAKBTdore+hYYk5g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] io_uring passthrough for nvme
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Stefan Roesch <shr@fb.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_061515_734046_0BEAEC93 
X-CRM114-Status: GOOD (  12.58  )
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

On Wed, May 11, 2022 at 6:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Which patches had changes in this series? I'm assuming it's just patch
> 1, but the changelog doesn't actually say. Would save me from comparing
> to what's in-tree already.

Compared to in-tree, it is Patch 1 and Patch 4.
This part in patch 4:
+int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
+               unsigned int issue_flags)
+{
+       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
+       struct nvme_ns_head *head = container_of(cdev, struct
nvme_ns_head, cdev);
+       int srcu_idx = srcu_read_lock(&head->srcu);
+       struct nvme_ns *ns = nvme_find_path(head);
+       int ret = -EINVAL;
+
+       if (ns)
+               ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
+       srcu_read_unlock(&head->srcu, srcu_idx);
+       return ret;
+}
Initializing ret to -EINVAL rather than 0.
We do not support admin commands yet, so ns can be null only if
something goes wrong with multipath.
So if at all anything goes wrong and ns is null, it is better to
return failure than success.

And I removed the lore links from commit-messages, thinking those will
be refreshed too.

