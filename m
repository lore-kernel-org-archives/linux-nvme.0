Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A52C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6EF22203
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6EF22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KyMSjcVLQ2gsF5tGMG1sVLr9moUg5lSSNUV9LeqSA6k=; b=z2ToVkOu+Cao7ba5qoOE4AVqi
	WFF+QCYfRqakEUsQQ9XqxWB1ekPilAqje0Q+hXaPqs6/RTe3SlVK7Y4F4nVSgM5/jc5kA8FU9Wrdg
	VNDjVc1YZmWwgYqfy02MTowzZvoOYLCxmQMneOYOkaLZc7agOnztkf91HUE0c46qczVGiTa7xTo/2
	T+luFs4epXfSVMKMYdKY+7Q4Kwp22jECaa5THjvnrSrt0MIlp8ZcfzQPd72HNnvGloh1rBQ/RPEYa
	10SMEAntzZnWpGseGpZrbRogptwB0A2zUGarN8kyK332bIO6349VpZxh7L3+h4mJI4agWBntK6OMC
	/j4bAsSCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkNWf-0001yo-LE; Wed, 02 Dec 2020 08:30:13 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkNWc-0001xb-4O
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 08:30:10 +0000
Received: by mail-ej1-x643.google.com with SMTP id f23so2392705ejk.2
 for <linux-nvme@lists.infradead.org>; Wed, 02 Dec 2020 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MOr64WR7JFh8O6zNoSvDJ/dxwL5S48zFZviyd6WC91U=;
 b=IdFVuOEzP1UAX1qbacan+RDDK2HPWdWW+uKPz5xMiXD8BrBdZyaBWurby6ulSX3FSM
 Sd2D2MZ+RJyzLsf59s1tTiJ7GgHpZsIJT2aqiZzENw5+NzLIKsvTvEu63yi60hSdL7iH
 jJRuoQ1tzzsAHfEq9jfcT/p9H0Qj1Ps69GZpNCOzWqO9bmxivYwkjZEZDPeXZhiPCW1X
 sG5F1TQF+MZuiw7kxeGNrD5ctg8U7N91rLjY/LXOn5Yyl9jADe/JZAsi5HFcA7rFIDSb
 gykybnUCwp2zkHSpuBd8tmgHGMSXQ1VWblo65+PwYk0eWMIg8vOhnGtVVU4onE1jFMBe
 GfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MOr64WR7JFh8O6zNoSvDJ/dxwL5S48zFZviyd6WC91U=;
 b=PBAzSeCr7NE40RQQo76lVMZ3CLoU62N26OP9pVspIxi9Dq4u1OCQl1aX4OP4u4IAZg
 zMkRUMzE+U6cYMWn/jRE8sbqDuS8pVPAE+04XNvUKs7axV4yFvi6mykqFcBdE8uxT2IP
 YYOTjh+stiCw2MV6kS0rTMbtwG/hO1PoqKwfPpGbq0VAZwPKjC0sUo1ge9SdQakmsVKs
 u5JFe010HEygkUtr49SoxyhZi84xuqSm5nKd3cC1lQFbwN5xxghqR61E4WBpqYM+IcJf
 U+06L0iPdT2qj/zHVhr7qNMzJ/0u6eJUnwHJuTWMGu6vkCTvklpjoso4AWHoL87tIOSo
 amww==
X-Gm-Message-State: AOAM530oz4TyTU0zEYoQ3980g22cdJBJlQ9/IsY2xJSld674VjGR2TOi
 CAj8d140CIYNaJaew7W23ogYDRECRRTmNPiC/Aw=
X-Google-Smtp-Source: ABdhPJyRsn8F0ekuoReb0bu4eiYLt4n3UgNR7w1ghBcz65//gOpSDr+Z68bjAUScjfVTmjnqIQRXB44LXSR8nb15Zf4=
X-Received: by 2002:a17:906:6693:: with SMTP id
 z19mr1249325ejo.376.1606897808576; 
 Wed, 02 Dec 2020 00:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e@epcas5p4.samsung.com>
 <20201201053949.143175-3-selvakuma.s1@samsung.com>
 <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
From: Selva Jove <selvajove@gmail.com>
Date: Wed, 2 Dec 2020 13:59:57 +0530
Message-ID: <CAHqX9vYLtpjWKu1otDWnSTM=MF+oMpFxSqLZvTZRcmp68LgCcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] nvme: add simple copy support
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_033010_215283_65D0844E 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, joshi.k@samsung.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nj.shetty@samsung.com, linux-block@vger.kernel.org, javier.gonz@samsung.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 1, 2020 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Dec 01, 2020 at 11:09:49AM +0530, SelvaKumar S wrote:
> > +static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
> > +                                    struct nvme_id_ns *id)
> > +{
> > +     struct nvme_ctrl *ctrl = ns->ctrl;
> > +     struct request_queue *queue = disk->queue;
> > +
> > +     if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
> > +             queue->limits.max_copy_sectors = 0;
> > +             blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
> > +             return;
> > +     }
> > +
> > +     /* setting copy limits */
> > +     ns->mcl = le64_to_cpu(id->mcl);
> > +     ns->mssrl = le32_to_cpu(id->mssrl);
> > +     ns->msrc = id->msrc;
>
> These are not used anywhere outside this function, so there's no need to
> add members to the struct.

Sure. Will remove these entries from nvme_ns.

>
> > +     if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue))
> > +             return;
>
> The queue limits are not necessarily the same each time we're called to
> update the disk info, so this return shouldn't be here.
>

Makes sense.

> > +
> > +     queue->limits.max_copy_sectors = ns->mcl * (1 << (ns->lba_shift - 9));
> > +     queue->limits.max_copy_range_sectors = ns->mssrl *
> > +             (1 << (ns->lba_shift - 9));
> > +     queue->limits.max_copy_nr_ranges = ns->msrc + 1;
> > +}
>
> <>
>
> > @@ -2045,6 +2133,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >       set_capacity_and_notify(disk, capacity);
> >
> >       nvme_config_discard(disk, ns);
> > +     nvme_config_copy(disk, ns, id);
> >       nvme_config_write_zeroes(disk, ns);
> >
> >       if (id->nsattr & NVME_NS_ATTR_RO)
> > @@ -3014,6 +3103,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >       ctrl->oaes = le32_to_cpu(id->oaes);
> >       ctrl->wctemp = le16_to_cpu(id->wctemp);
> >       ctrl->cctemp = le16_to_cpu(id->cctemp);
> > +     ctrl->ocfs = le32_to_cpu(id->ocfs);
>
> ocfs is not used anywhere.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
