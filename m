Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5712C43462
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 12:52:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557CB613F5
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 12:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557CB613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jSv2KctBfKy845j/bxmsHX5LuM+Is2h3pV7haOUPBvk=; b=ad92EETwYiWaJ9iOU1/gS+eBd
	Dol8uKVcur00TpkYxN+A5kklbrYB0h7Ek9CkHWaGVeAH3uGOAZNfhKd0IfScx0W9/1Hfx4oVZBYk8
	jZv4FO0SQ+68qx/Kptrf2ZoURE+XSZWW2WYFxmuj+diA6UnJqZBa7s7r0mvVRt82yQ/PvJwvOvlQY
	FPbrar55F7kvlaOTsQiu+zs59S0KhGEd1NnxxuxCR7gdPsDYykPMKBWclQs63qAAeZEJg5XTCU+cJ
	hq+tymTy/6sXuFWbPFk4WKXXIzqpfgHDEkLuY8slz32Sw9v3ZYfEdzyUtgvSees57vxhCEcxb917E
	PtJsTepnQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZvHB-001UqY-Fm; Fri, 23 Apr 2021 12:51:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZvH9-001UqT-17
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 12:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sshmBKSxuYkLzvbk1XxsPVurkStsjVnveRw2TPfsMV4=; b=QezXV0jTjPSn/WItX9bHrtVOAp
 V8hlwU6L7XdTfIEQ8hq/zzYK0XP+UE03kvCKWxgmM4d00hRzcVhs5jdGINs3CqBKGsFos0mIQzHx4
 PwbPUKpSxA7Hw3aXB1LflhYeIlpev7pwxBysVZFJZ75M7px8btKNLVEDFl2RoOhPL7wbx9/JFkQBd
 YGqMweAkvoa/EyilKejd3MIb0Oq+GZ0gUOE/38PMUpuSyyBImHB2JeiHLM2+sQPFMpeTotXp/25QK
 dfTJSvu8DayACg3GaYofjXIrTXAAxaxVnlnF46ZoLMaJB40Z16lb5xEsWZyzkxECI24euHdDcqT28
 dplicGPQ==;
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZvH6-00EPDQ-Fl
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 12:51:13 +0000
Received: by mail-wm1-x32d.google.com with SMTP id z6so8161360wmg.1
 for <linux-nvme@lists.infradead.org>; Fri, 23 Apr 2021 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sshmBKSxuYkLzvbk1XxsPVurkStsjVnveRw2TPfsMV4=;
 b=cvRpEXsZDnWusqlOJrMKei6NCJUDacFfYj8X6MjhxtlktTF5lXhVcC9O87Wa7cq8df
 AqP/YSAhTK52tDhr5151x425LytpFlFWP/CMBGeiQFfurUlMh+yFPYiCYAH/k3Ii8M1V
 cDB+2fMtlb9Vx+4gRniRidfTGYDIMlZHHoVhtO64gIclj5mn8rXfQykZXAVyzU5Fhe2O
 Rkbi8EObYQnWog0DOPXrEglG1odngcEp2wWCZnluTq0KT3Zu+s4nOkrVMHeAEMO3zn3x
 ryLMkenE5eCZrp6i9DL627dxIttgOoDz1ZwrbOTHSc9snq9b7qLm9IqpFuWiqT7uWsYA
 d8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sshmBKSxuYkLzvbk1XxsPVurkStsjVnveRw2TPfsMV4=;
 b=FKNggjID9RuWvXAhCyq8peyfxI4M8n4CGBaz51h1Tq6nMK0VIdQpqHnCgNGGgAG0C8
 jzUiFtYKyI4NuMPEL+ItqETRSnZcdTBnpyGd+N0bezPRP4/OI9nT8pA/8W2SfKGLpvLG
 zIjudUNOUj2uFnv2Mjl4U840W9SRGomL4yXkyedoy1BAV7k+5m2JtPKdkF1CHOQvo8sV
 96ohg4fb45H8CQfpCdKOBj9R4cpKdpDpRCG+j+dE7PtF3064mJ+QRRSj7jBjB2sRptGl
 5u+8rl50BLxPeRhJiJV7UZwHftAgyqk2dyGCom8BjIbBGyDZpZCcBvb/I30Y6wWCEWV6
 OnPA==
X-Gm-Message-State: AOAM530NDtOHz1jsEy6kRyBpfNLAgl8pZeLuu9apL7aEUgwz36zHzZon
 iTkmVi6nZg+6IXEnDIfA87eE+310wanjXF6UaH4=
X-Google-Smtp-Source: ABdhPJxKDl0stiJ9dOexp18uElomeSBBigHXiq3hillpNWwxVJmlK13xAHhFteRssO9FO4xe2AUm5YMNM3qGfgP99po=
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr5318404wmi.138.1619182270240; 
 Fri, 23 Apr 2021 05:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e@epcas5p3.samsung.com>
 <20210422115427.63636-3-joshi.k@samsung.com>
 <BYAPR04MB496535AE19BDE81222C0E0D186469@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496535AE19BDE81222C0E0D186469@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 23 Apr 2021 18:20:42 +0530
Message-ID: <CA+1E3rLSnR0G8eCgXkDm+Zn75Mk7Bc9S39Wqm7EpBKWBNX3RVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>, 
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "sagi@grimberg.me" <sagi@grimberg.me>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_055112_560776_D105A4C8 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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

On Fri, Apr 23, 2021 at 12:25 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 4/22/21 05:18, Kanchan Joshi wrote:
> > +             memset(cmd, 0, sizeof(struct nvme_command));
>
> The original code uses following :-
>
> -       memset(cmd, 0, sizeof(*cmd));
>
>
> Let's not change that.

Ok, I'll change and repost.

-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
