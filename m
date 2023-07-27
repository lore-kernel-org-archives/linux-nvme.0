Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C65AC0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TbDyUZsWzsObspTjv/7qDRWOVn/FC/GQiLADatzNto=; b=fFuU3Gbhci35w2plb7S2nKqXDy
	rS/JErUEDTucQtZL62Q1J288vBymFO1mI4iOnHOJfvqk4m5xC7m9oSUUxTXhGt6PadGreh4iFTP1C
	2OloemXV9UL411yrhOTnQ7F/ugdDe+77XOKCx7DhTbV7R9hMDGNlhDzzfZ32s8clxNIc/9Hb0hIYR
	o2Ngat7keT/k7SKxZKmpVZVHshsxjzduNY2iZI51G5K9Hn1NwjtOL+w5ZlxIPqgyCo+gOAylZNCAT
	ZLgp5OKGHLMnYRbzYdviCR3eXXRcyMz3ZRWTtEoePSDoPKXbzen7BWmXGVzHUqXjs6sk1IH9EwFBS
	ob7UJuFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qP4IN-00Gy4m-36;
	Thu, 27 Jul 2023 16:56:59 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qP4IJ-00Gy15-35
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 16:56:57 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-785ccd731a7so15003739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Jul 2023 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690477014; x=1691081814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TbDyUZsWzsObspTjv/7qDRWOVn/FC/GQiLADatzNto=;
        b=QVWXff1MHGFzKeu2yMSop5DgLF/mnGt7ujiUK+cK7qgU25t4z0pQLC3LLk1cBb9Fao
         ICDs5FS4uyyYYYSXZIj6AVAXLV8cXjT9xYUA0iwxzklJqzxG+4G8s8p2Y308gHg1u8vV
         nUMY3P3tHoHGmKuw7jAe4mVs5hOfFokPoIOjqkAucjNiC/q8j4P0R+26bksNpAN10G31
         aSH5whNcEwF+qzt9ECVIPo6MvqRhQExufVKQhNWHJr/y+xhMCdDUBYIU8KnOq9hyF9jV
         yPQk9EJS0SiO8Ja616+hmibeUeLXOfQfPl9hevhwxbjVGYM96ztaU59Xnz9m7zkEMEte
         GSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477014; x=1691081814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TbDyUZsWzsObspTjv/7qDRWOVn/FC/GQiLADatzNto=;
        b=Ozs4UFehyr5Bg4B9sMdY9rtaHmUUYSlrJGw2iy1c2vT/Qqs1L8DYcvC+0bJlSMVFGg
         WLmQjWoslQijJnAbYJBrSqmRNxXH3mOx926zHIZJNp+Jt/gx+o8eR70Y5HTFLHK6Ds8C
         m3fNCO3ChwylT/42MLty+HN2q7jZCy8XOJQ1kkpe3UIcrKjUDw4k6/F5d1evb5fB3u6g
         t+1bfkH6wToqzfhcMnSQkZeHzNQje6oUnjU8GT2gPhn/4UsMKiEPJ1ZSCy572r6BzIEA
         dOoCvEaD0L/DHBHrnx6te2qMGoRUZb8Rnj03w1bIyMajHl1wGET5mzaG212Fj9B+2RDR
         qCjg==
X-Gm-Message-State: ABy/qLYVr1qa+FkGV/nxEP7mMCEoOcGYKmhYoyB6q+I6Lgjq46nqsyiU
	INVymqxtFh3B5Mvnf9JXOAS4QFZEBHgaCjKX8Pw=
X-Google-Smtp-Source: APBJJlEoSCoL8q7efvULtSRO2w2U+hoIsFGnoOvtgrvlFGhkvFEEEYatzDufiBpbn8t4TXFCvNwzhUkmsGojgXJVZOw=
X-Received: by 2002:a05:6602:2d89:b0:780:d65c:d78f with SMTP id
 k9-20020a0566022d8900b00780d65cd78fmr90887iow.2.1690477014246; Thu, 27 Jul
 2023 09:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230726094027.535126-1-ming.lei@redhat.com> <20230726094027.535126-5-ming.lei@redhat.com>
 <CABPRKS-0GQqMRiGh6akOgk3BKpx5kqTd0QVhH4nPe=fUdi7DbQ@mail.gmail.com> <ZMHGLyg2bRY6S35i@ovpn-8-16.pek2.redhat.com>
In-Reply-To: <ZMHGLyg2bRY6S35i@ovpn-8-16.pek2.redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 27 Jul 2023 09:56:43 -0700
Message-ID: <CABPRKS-vnvOUOhZzc6yghKV4RjTTsZMQphR=TEs-S-OD5Ap29Q@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] scsi: lpfc: use blk_mq_max_nr_hw_queues() to
 calculate io vectors
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_095656_003320_AF9F8C3C 
X-CRM114-Status: GOOD (  10.86  )
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

On Wed, Jul 26, 2023 at 6:20=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> Strictly speaking, the above change is better, but non-managed irq
> doesn't have such issue, that is why I just apply the change on managed
> irq branch.
>
>
> Thanks,
> Ming

Sure, thanks Ming.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

