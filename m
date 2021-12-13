Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B0C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3TFAsQRIClwPso3h55COFgCPYMd8YWk5SFNWP4ZjE4=; b=FvdFnw7AvN48pk0am45aAB988i
	TfC7D9XvWcAXpQwEERndraSK3ElW7gwuUJwmcU++wihDAl84PvwmCi0zg0s6QnfOaN88EtKLwYAC7
	Z3MEH/RdCtGOimcJJhTUFqWuhngMMg+0uCOu31OkQeVlrAJ1cJSo1zxOlNG4ATJggiZSmVCVBE/N8
	QR5abHIXywBrGY8k6XdtdTk2fD8xOhzLT3rhvRHD1Z3/q6XaLvVy/L/lRh3BuDWL6Wj4IiG8zUTl4
	Yp+MyiSUtnbYijMYVmpPB4EDBRpcMhRXtUhtbOBYq8nCVGRXn6WU29+8SRFqSRgDosfNQQfV0Ekn4
	vew6SfNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwole-00AlwV-9p; Mon, 13 Dec 2021 17:05:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwolR-00Als8-Ei
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 17:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639415124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3TFAsQRIClwPso3h55COFgCPYMd8YWk5SFNWP4ZjE4=;
 b=Rways+O3ABMXXRf4PRznr30GC+mOmrtNtdexSVDADbJiBkw0LEKCR4XiTeaCRXCLIErOXM
 ySSVjG4L6D9MNLRNGJwv29ICp1cvDMUPbpTxqdjWHs2QQ6MmuYYzEN3eZz//gN7TOtcPPm
 2VfPMa/t4vG65xSYdfDlfGmnV3c3u7A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-n8Tz0AOQO5aLke5gVmryRg-1; Mon, 13 Dec 2021 12:05:23 -0500
X-MC-Unique: n8Tz0AOQO5aLke5gVmryRg-1
Received: by mail-pg1-f197.google.com with SMTP id
 14-20020a63144e000000b0032f07c8df95so9318291pgu.9
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 09:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P3TFAsQRIClwPso3h55COFgCPYMd8YWk5SFNWP4ZjE4=;
 b=d3NfM/l4i8oEm4mcmy9BJbRkrH9hUEYXC9JimsFFZm1N0oo/TAuskvKJGqx8MEya1+
 l7k06QIwapehhdufkWfBgfEutQTA8kOQjHTT3BSgKxIzSM4Kba8BhSJgsWo8i7576XPh
 TTALWLs6IGxN8IBilMpD2doCI8kBQIAhq4/XxtS26sgomRVuOCR0gZQtM0ZOU9iCG4Am
 hrIJtdes3OI+khPlDrhNGfluZ5azr74y8E/kQKdh6DpaYAsNWEeI9NgxTMu+UQkxmngO
 2RW+aqPuaQ5hW6xAOkLjfcAk7T96oCE6mqhZaInDWsa72T6oGbHwJbc3pHTcG92m6j/H
 B2SA==
X-Gm-Message-State: AOAM530Hx4SsTmLIvkXBjxm7BAKG8bzDYY/4dfJFGYATK/8G9y4gy/z2
 aIRPWPYI/D8Ndl1tBHeFZFkH4ZIyJ7KpVyzZafl3nQEHdVADmUMB09/l0WZkpCEhoRwBgZqbalT
 lsS2Z6KNxxtUMEfqdKs1+j+F8sWXLKM1nRVSgFHjVrmQ=
X-Received: by 2002:a17:90b:380e:: with SMTP id
 mq14mr46750250pjb.74.1639415121974; 
 Mon, 13 Dec 2021 09:05:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweCD/BYcw5iFp2acEXHQ/MEQ0f3B9dz/WJMFgzdqdERWwIqxZTxR5zsqDQX6IfaVpAytwC00r7vtPxTCtTNr0=
X-Received: by 2002:a17:90b:380e:: with SMTP id
 mq14mr46750204pjb.74.1639415121558; 
 Mon, 13 Dec 2021 09:05:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
In-Reply-To: <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 14 Dec 2021 01:05:09 +0800
Message-ID: <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_090525_776056_CB63B5BA 
X-CRM114-Status: GOOD (  20.42  )
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

On Mon, Dec 13, 2021 at 5:05 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>>>>> Hello
> >>>>>>
> >>>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
> >>>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m12.636s
> >>>>>> user 0m0.002s
> >>>>>> sys 0m0.005s
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m12.641s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.007s
> >>>>>
> >>>>> Strange that even normal resets take so long...
> >>>>> What device are you using?
> >>>>
> >>>> Hi Sagi
> >>>>
> >>>> Here is the device info:
> >>>> Mellanox Technologies MT27700 Family [ConnectX-4]
> >>>>
> >>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 1m16.133s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.007s
> >>>>>
> >>>>> There seems to be a spurious command timeout here, but maybe this
> >>>>> is due to the fact that the queues take so long to connect and
> >>>>> the target expires the keep-alive timer.
> >>>>>
> >>>>> Does this patch help?
> >>>>
> >>>> The issue still exists, let me know if you need more testing for it. :)
> >>>
> >>> Hi Sagi
> >>> ping, this issue still can be reproduced on the latest
> >>> linux-block/for-next, do you have a chance to recheck it, thanks.
> >>
> >> Can you check if it happens with the below patch:
> >
> > Hi Sagi
> > It is still reproducible with the change, here is the log:
> >
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.973s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    1m15.606s
> > user    0m0.000s
> > sys     0m0.007s
>
> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
Yes, with -i 4, it has stablee 1.3s
# time nvme reset /dev/nvme0

real 0m1.225s
user 0m0.000s
sys 0m0.007s

>
> >
> > # dmesg | grep nvme
> > [  900.634877] nvme nvme0: resetting controller
> > [  909.026958] nvme nvme0: creating 40 I/O queues.
> > [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > [  917.600993] nvme nvme0: resetting controller
> > [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> > [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> > [  988.608181] nvme nvme0: creating 40 I/O queues.
> > [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
> > BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>
> Then I think that we need the rdma folks to help here...
>


-- 
Best Regards,
  Yi Zhang


