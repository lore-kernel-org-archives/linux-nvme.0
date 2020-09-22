Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E4FC4363D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:41:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92712399A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s+zRllVx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUWkNllN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92712399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+kZvRAYiiiZKXZjTNfYVia9Fm1sLyudFgEErctkXLls=; b=s+zRllVx+De7j+6JLz5r3zf+w
	ROvR1s+LkO4R6XbIbMUwa/kE5Od9FI4lEIUNTFMC7nxAmGqPd7bdeRwPEhkBFoFGJRrqrzJ1SZ6vE
	zs+EAy+j/YCnAQfS895vVguR46e5mDJSMv0264X9OXPpG/TAdrZWBpnHQhNRnC4TLTF2vhGFb4QKy
	/DSMd//PMGSub/je3dCNJwHCXl+HQPTx+ZGDC0lzQc252HOgcA+WkXT7igqsZGL+dJiyOFjg2YHxX
	aKswC2pP+H3tZeuzVA+btv95i7QZ+sCJAVAnRrJfUJtFa7aM5zsC97CR19kFIBYjejL+E8oCGf3u3
	FoNVggTWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKkPz-0005EN-N6; Tue, 22 Sep 2020 15:41:23 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKkPn-00059S-UW
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 15:41:13 +0000
Received: by mail-il1-x142.google.com with SMTP id y2so7041108ila.0
 for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2020 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PICW45X2iQWdtbXa7gacJOqYVJoHuDx6Nq+BthDfr08=;
 b=cUWkNllNiT01w6KswNUIrMY0Ct2ce+aDlWti5eWIA0GThp85hQmKbgPojFrqQVoF7X
 qrlLif2XyP0gCtEhA+weYIx7wDPiX7wpEuggUdNyPHPFg4zjyS/ICP1p8vo+5UawBDRv
 vZXp2VYviRupP+rze4FG74KuBSzlDK+e1fqID+LmtlXapwhZv3TVcjau5VUyeO06oGw6
 ltKr/rn6ZTvhpMWANx3G0iDJ59c/EDoj+gIcntoDiRuN67odfu/1fjtqD5kFAz7hzgMX
 f1aYnYmPG4kDMnH3HrJsKMapMTmpkXUwsspyaK464J9eW2AXhGMR36Myv86RCmBjydeG
 BFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PICW45X2iQWdtbXa7gacJOqYVJoHuDx6Nq+BthDfr08=;
 b=MKmG0gjSJcxvzOnIs6kKlpqaYXZFvXKKLD75uRJC7dmjOHO6356+Qax8WCmxDMccEn
 9fT0ul6OXa6uasNyapofmzalh+sTOSu+xnp74nV8YduDa7u7rbclHqGi7MsWpheg6M7f
 2oF7z3J5aMSJEWixJieXJyJqrZLUbGBluDYMdYefvOrIWVskKEJzR7PB2MUbErp8m9nu
 4xU6fsD6ju/KsFW6Lkqc1iWkTsheohDyEaZEe99FI7LOjSi8AN9YRPZcoHM1l2EcO5pO
 fRe+pk0tb/1S/UGOBW7Y+Gv5h/iMy+KHoq8J1P/HOzY3QohHfTYUu4fXtq0lnV6R/sSZ
 TGhg==
X-Gm-Message-State: AOAM530YeUzh8NrLTvvsTqJ1FOp3tfOHSPFdNIDCVA8MM2P4qCTEncYr
 OujNtB+Lb5nYvNlrYR3nGpZ5vdtb1FpYyAAXGbs=
X-Google-Smtp-Source: ABdhPJw6NV2OLpOjxnlDuvVs4PRyGAuozfr94GsaYzpcXqGEVxRWzcos8yTKxdBFVCriWw5f9l0B1WN9LxK4cXGgNp4=
X-Received: by 2002:a92:aa01:: with SMTP id j1mr5068011ili.301.1600789267967; 
 Tue, 22 Sep 2020 08:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
In-Reply-To: <20200922135956.GA23437@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Tue, 22 Sep 2020 11:40:56 -0400
Message-ID: <CAA5qM4DvFdQ_yvkGERyNjar7EJkcRmR5ry9BiuPaZkEzzO=Mug@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_114112_041552_83073981 
X-CRM114-Status: GOOD (  17.83  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you Christoph.
I will do some testing with my setup and let you know.
- Tong

On Tue, Sep 22, 2020 at 9:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Tong,
>
> can you test this patch?
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 99c64641c3148c..6473ae703789e4 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -836,6 +836,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>          * so that it sticks around as long as @disk is there.
>          */
>         WARN_ON_ONCE(!blk_get_queue(disk->queue));
> +       disk->flags |= GENHD_FL_QUEUE_REF;
>
>         disk_add_events(disk);
>         blk_integrity_add(disk);
> @@ -1567,7 +1568,7 @@ static void disk_release(struct device *dev)
>         kfree(disk->random);
>         disk_replace_part_tbl(disk, NULL);
>         hd_free_part(&disk->part0);
> -       if (disk->queue)
> +       if (disk->flags & GENHD_FL_QUEUE_REF)
>                 blk_put_queue(disk->queue);
>         kfree(disk);
>  }
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 4ab853461dff25..9441077ee10329 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -135,6 +135,7 @@ struct hd_struct {
>  #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE    0x0100
>  #define GENHD_FL_NO_PART_SCAN                  0x0200
>  #define GENHD_FL_HIDDEN                                0x0400
> +#define GENHD_FL_QUEUE_REF                     0x0800
>
>  enum {
>         DISK_EVENT_MEDIA_CHANGE                 = 1 << 0, /* media changed */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
