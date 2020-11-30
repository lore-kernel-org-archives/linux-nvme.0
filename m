Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD5C64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 01:23:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B74A20757
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 01:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DCFz2dks";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="hKnZYq2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B74A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=egEXqWQu9BQcLcyObi3KNWziCYn4uxpj3cZiJXy+F9o=; b=DCFz2dksdqozr5lv7dVcT56cW
	xOSxF8NwDr2lOcHUwNxzNKyiSxQe4wuQ6GGaxDF0kGszNB5a+k00S7lb+G6gMMOfIpmKKVsrccx28
	s/yOCbPRqm/oBJKzIRzaxWTGg6X/4MZDBKqhSMpTIxB/D2DYDzBVP3mbcjzC3FbNm++sgXCxN9B+c
	eyIia8T3C09F7ijA2VwouFpvYbOmvh5mkzS6AxjrS84QTQgKjqmRzr6VgWyqcsF/kKaQpjcpqllpU
	KnbeBV7QnERUS2G6OT4F+JgG45x6MFAwDGPF4f9CBWIw6c+wt9YSguaQTDiM0n2iREFIjJlKaKl93
	JLS/0Peiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjXul-00016C-Qd; Mon, 30 Nov 2020 01:23:39 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjXuh-00015j-4W
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 01:23:36 +0000
Received: by mail-il1-x142.google.com with SMTP id g1so9768449ilk.7
 for <linux-nvme@lists.infradead.org>; Sun, 29 Nov 2020 17:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieee.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BZmTZBqdpz8QAbNwD292cR5AKXCzTrvi1V4QZo4ASiQ=;
 b=hKnZYq2zYwBXSBj9NeRqd6+7PYTZURDvcmLIwor4SOQougjRYVBJjKQib8Bw+L+jyj
 hK29uuv0S3/5uH5/Y9KJob1/oXpFwwBro0asfQc1NQg3uLi60wqboim7OnzakiprgxjY
 vJ6Y2TDWIlzHPhC/HWJUs0MGAoR5NIq4xHju0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZmTZBqdpz8QAbNwD292cR5AKXCzTrvi1V4QZo4ASiQ=;
 b=P+4rEsLV9EYwd05gK14FsYLK+54NkmgQUAi+xCiZrafmc+HrWUzagVFDJxXSAm03Ru
 5GYg0cAKA6AC50Zjw/ouSAlVOfOWAOuITAVjulvcCZVXs5MexRNq7oF9hnI2SGCp6znf
 1Exq6ZFNA+9XWG+qO4Ugh/X1EYlWvMzCYH185tUwo1CaNwr4S7xcBI0N2p7h7CiiUMoo
 LyJXf4vTjNIyKfBCfekDTkCTvuzskystwi965Gylqbjaq4Ei99ZdPocNma8eniEzxjl6
 7MV6cAT8Lhg97E4n97spmQ/idWXYMfK4kqXRTcDML30mT5jhCxDwv5dzIcucqLR16AhW
 Fumg==
X-Gm-Message-State: AOAM532fJA/NXCkfRiDyr7+O0z8jco0x0G/evdTPMvrvKYLOXkL6h+98
 REApF9efYeWs5sgCcz/pYcxjScw7slDVnw==
X-Google-Smtp-Source: ABdhPJx6pfJfEezIuUrTQnLZt8wZNJbVHV799bmuRFAi7zQbwNigfx6jMUois48aZKI1igPQUl300Q==
X-Received: by 2002:a92:84c1:: with SMTP id y62mr16165882ilk.191.1606699411252; 
 Sun, 29 Nov 2020 17:23:31 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net.
 [73.185.129.58])
 by smtp.googlemail.com with ESMTPSA id n10sm7216731iom.36.2020.11.29.17.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Nov 2020 17:23:30 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de>
From: Alex Elder <elder@ieee.org>
Message-ID: <44c60506-059f-f272-208f-a39d94a8617d@ieee.org>
Date: Sun, 29 Nov 2020 19:23:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201129181926.897775-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_202335_270796_C711CA8C 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/29/20 12:19 PM, Christoph Hellwig wrote:
> Commit 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading
> partition") addressed a long-standing problem with user read-only

Little nit I noticed below.	-Alex

. . .

> diff --git a/block/genhd.c b/block/genhd.c
> index 565cf36a5f1864..5e746223b6fa0f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1625,31 +1625,35 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
>  	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
>  }
>  
> -void set_disk_ro(struct gendisk *disk, int flag)
> +/**
> + * set_disk_ro - set a gendisk read-only
> + * @disk:	The disk device
> + * @state:	true or false

s/state/read_only/

> + *
> + * This function is used to indicate whether a given disk device should have its
> + * read-only flag set. set_disk_ro() is typically used by device drivers to
> + * indicate whether the underlying physical device is write-protected.
> + */
> +void set_disk_ro(struct gendisk *disk, bool read_only)

. . .



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
