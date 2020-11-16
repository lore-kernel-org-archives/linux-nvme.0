Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F1C61DD8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:40:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918ED2076E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zhxvhHui";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vJHuCgkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918ED2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ai1CvLJBqUk8QZ1ciBFQ5R/DbTri1EJgu0lktXCCGKg=; b=zhxvhHuib8L+T73ZQSUmyQB/f
	HiFHExClJdHNTkte2viyBBNqG9uwHNO6dZ8POwwpWEzPWhVO4Cmh/8Xz9VSNQoccQIrg+BI+6VBkd
	tDKNC1W/EDIhQLdqynf54i2ERRKK+78sPt5wyUad8DiUsEqeQ37kvRZeLpCvHuvpeXskX9A4Qwql5
	/TiOgmReOaDzOY90UCJDcZR4DWVCR89L36pnTrh1zNzKPEOw08FXMtNW5EyWvYsiLFRv8eNCd1tjt
	yqWMAAHjIKA9BNU34jz8LoiPD5NYDuHi8zT4fGwAXhLaRqyFz7PntLhDtWxrROrvziX3YsuvaAmmu
	6F2JYhYaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegcK-0007C2-Oz; Mon, 16 Nov 2020 15:40:32 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kegc4-00073H-Gn
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 15:40:29 +0000
Received: by mail-io1-xd30.google.com with SMTP id r9so17822791ioo.7
 for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2020 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tp0p5PHbr2FkOYp8vx6enMy9SJ7npMGO8ToOlTZAVD0=;
 b=vJHuCgkLtyaYNtKWJGKWTC2HAaX7Y9m8y1VpqDKgvUWa8d0I51VY3ALJeXJtOlsGpr
 QzxZZWfSIBe9Z9YJVgCkUF04iuHI0uFspV4JwGcoTFtYktgjnY7A8CRm243mremkxSFW
 /W8ZuC0hXxmoHn+ezTFvYhGe2XU1ttQu6xlHRIQZSFb9V/9nguKyH01uIZBsQIBla1sm
 kSpCVk0QJdWteogX0XEWe3MJV6jr1Lh++tWh99mrFKS4zYsaeRBflt08zg4X1OBFoLaD
 OZKwfBprL/CxXZIUp5e8ounGHLLXOFSswyyzQU1smV5YfKh+taZ0KanaNv47asHmejvk
 eLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tp0p5PHbr2FkOYp8vx6enMy9SJ7npMGO8ToOlTZAVD0=;
 b=HV0C31vsaI7tKjla/faTUUSsUoM4uCu0fG7hxkU4vWwXTUZQ4XD9Pr53hEXaoBAJ6x
 C+qmzqrgl+qErwJS2Vgjxm7HcSEexCSVio7BZMCeF7E/8F2ErYst9mK10eSjmfpoAQ+8
 5RXQmXFK4ZzeprZbEpuXyH0YlvlzUI+jXnRr0NdCqJO1wG8Ci19BGRW8WK8hmkKF75oV
 3g9N9pgOCJ5Rr8YAEmS0yDeTA4qqnFnTUiDiKAhw2NMeoFOKYDNA5FWFO/z6ioLsukch
 94dsfa0BhVjzSitkBPEjksbXsx16moulTlQikh4+O9kbdl3p5RpkHzMRcfaoGFROzdaN
 BW5w==
X-Gm-Message-State: AOAM532q9P6Em5RYJoONaCGnz+fiIKQwWN9oAJtpq+lrxZCD7n3s1LJw
 /icSAeSn2PbekDyRlpHF+el5cg==
X-Google-Smtp-Source: ABdhPJzORiPywjBgXN2NzytHbmvXHQyepXDfzUWSZfRzXJXzcmliMaw8xrhzAaFsEhdxvHHHShuK7g==
X-Received: by 2002:a5e:9e0b:: with SMTP id i11mr3534187ioq.33.1605541212314; 
 Mon, 16 Nov 2020 07:40:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id i82sm10491839ill.84.2020.11.16.07.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 07:40:11 -0800 (PST)
Subject: Re: cleanup updating the size of block devices v3
To: Christoph Hellwig <hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <506876ff-65b0-7610-6f9e-8228fcd201c8@kernel.dk>
Date: Mon, 16 Nov 2020 08:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_104016_713641_1A96AF5E 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/16/20 7:56 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series builds on top of the work that went into the last merge window,
> and make sure we have a single coherent interfac for updating the size of a
> block device.
> 
> Changes since v2:
>  - rebased to the set_capacity_revalidate_and_notify in mainline
>  - keep the loop_set_size function
>  - fix two mixed up acks

Applied 1-23 for 5.11, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
