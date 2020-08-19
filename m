Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4DC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 08:34:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AEF207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o89xByXd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0jLXOFs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEF207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ADypPqwfzC95xhPOFNAQAdMsHSA3hpHQX6CrwOJUq+A=; b=o89xByXdgH2lJtRzidFNOg+5D
	lV88inaZ2rimoh0Njti+w81xi9lBQ4wCT7o4+nmNlbSoHoxcJxBMXcVfC5yGHQXqSBjJ6u8XYuzSD
	W93pT2spk6NIo9mhN1ixStLefojBLhavm1BPLHh5PjsH7gsnmNrW3AmqJlAJ4cLBW8uf5sIDyvsli
	ykcL94ynW5lQx/nA+UIWniskTePzydhzmO44ET6sr40V16Rc4kSrwiBLi9PKXor0SGFkN84hrd8Vr
	3AduhpFi2zsr/nE4ljT2vrkVyykmns/Z6vQeVBVWrMMc4wCw0J9yETQYcKLMN6tuWUepAasfcp39p
	6aJFnWTWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8JXj-0003XV-Lh; Wed, 19 Aug 2020 08:33:59 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8JXh-0003Wr-36
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 08:33:58 +0000
Received: by mail-wm1-x342.google.com with SMTP id p14so1245430wmg.1
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5xasR+X+UEQtR9u6qcm8KE/Y6iy5pfp5FFfxCYCX1do=;
 b=0jLXOFs6tYNjlMnwyLPvf7bjt2J75bLyh/fu26NBy6toCtHvAo5zecLkOQkVPdu/Uj
 b2wJw645AJGu1rCM15cMo1uoeOUG/hFFtTL8eR5oZ8Tj6sb7mkI9HSxaz2TLhOCvEsMp
 GI6UjI/WnasfSTcatQ7786KY81sl8xcdk7FkGMkXxhgCL2m6/4LDyz2mTumkqm8Bq71L
 e8nk+0w9pzPhsN1lE0QRrkdTrM7R4dwtniylspCSJpcugB+CV8QPOireyGBbVmes3bmL
 iQKEEt7qNCSTQs7hSHCOXGO7UJPRIM0TcfDC2Vgv+CLqzaDMtVHnyNYgTZa+XP9E7hzf
 IcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5xasR+X+UEQtR9u6qcm8KE/Y6iy5pfp5FFfxCYCX1do=;
 b=Icgb5Ik/+QFIM3rGpJm2UCkFkkK00vB+yUMB1tfkWnnvOv/Fa4npeRLO6zECxjARsg
 wjabOlWa0FWTOH63Ga6xqS6zh6/fVHMiSVNeGAzq9YsiSZvdi6EtHX9yQ9swYwlcuUEW
 9YUApsD62q3kcwtuBXslwZsO9eYR4PmYNCBAqb7Qsw09x50JsWVPeJDLGlU5pCaQOFjE
 cv9dozTKyWS+z/QL0mx1PGJ8S+MsfkGZHqyigPrdBx2qHUhzUl9witAn32X+6GbDXU3o
 2OUD0QHi6LgzKvp290Z7jZcA7aJFm2g1+HY4+e6XPKozs5majjrwBEnRTSE8uItW/aGq
 DFSA==
X-Gm-Message-State: AOAM532CvqEcSOCohHdLqiznlCVAiJnJNZG+z++YOo2SaPk0O95/ROwZ
 xXpwBrDfZyL5nU8Spf7hcR1u8g==
X-Google-Smtp-Source: ABdhPJymHDpawgsT57RrkKK+R5UwTu/3ozzwA2cjMzvyw/HybeFPB5Gl8lnIb3WaylDaezP8/fNn5g==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr3724574wme.174.1597826035879; 
 Wed, 19 Aug 2020 01:33:55 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id 68sm39096068wra.39.2020.08.19.01.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 01:33:55 -0700 (PDT)
Date: Wed, 19 Aug 2020 10:33:53 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819083353.rwblagiesocfcq7i@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200819074035.GA21991@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_043357_285784_EAC843DA 
X-CRM114-Status: GOOD (  22.67  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19.08.2020 09:40, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 08:04:28PM +0200, Javier Gonzalez wrote:
>> I understand that you want vendor alignment in the NVMe driver and I
>> agree. We are not pushing for a non-append model - you can see that we
>> are investing effort in implementing the append path in thee block layer
>> and io_uring and we will continue doing so as patches get merged.
>>
>> This said, we do have some OEM models that do not implement append and I
>> would like them to be supported in Linux. As you know, new TPs are being
>> standardized now and the append emulation is the based for adding
>> support for this. I do not believe it is unreasonable to find a way to
>> add support for this SSDs.
>
>I do not think we should support anything but Zone Append, especially not
>the new TP, which is going to add even more horrible code for absolutely
>no good reason.

I must admit that this is a bit frustrating. The new TP adds
functionality beyond operating as an Append alternative that I would
very much like to see upstream (do want to discuss details here).

I understand the concerns about deviating from the Append model, but I
believe we should find a way to add these new features. We are hiding
all the logic in the NVMe driver and not touching the interface with the
block layer, so the overall model is really not changed.

>
>> If you completely close the door this approach, the alternative is
>> carrying off-tree patches to the several OEMs that use these devices.
>> This is not good for the zoned ecosystem nor for the future of Zone
>> Append.
>
>I really don't have a problem with that.  If these OEMs want to use
>an inferior access model only, they have to pay the price for it.
>I also don't think that proxy arguments are very useful.  If you OEMs
>are troubled by carrying patches becomes they decided to buy inferior
>drivers they are perfectly happy to argue their cause here on the list.

I am not arguing as a proxy, I am stating the trouble we see from our
perspective in having to diverge from mainline when our approach is
being upstream first.

Whether the I/O mode is inferior or superior, they can answer that
themselves if they read this list.
>
>> Are you open to us doing some characterization and if the impact
>> to the fast path is not significant, moving ahead to a Zone Append
>> emulation like in SCSI? I will promise that we will remove this path if
>> requests for these devices terminate.
>
>As said I do not think implementing zone append emulation or the TP that
>shall not be named are a good idea for Linux.

I would ask you to reconsider this position. I have a hard time
understanding how zone append emulation is a good idea in SCSI and not
in NVMe, when there is no performance penalty.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
