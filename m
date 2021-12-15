Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BB2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 01:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqzviJpaiD/rtEttdKI7UVGMtsBNr4YqXbAMMdj58jk=; b=GsWgpTANl+8Pn3nhwnPR1liJCZ
	PCZXyrcoi0q+isiJZzxti5ID54vke5Lf+a5BzQR+7qdm5aAwb+Akpa42R/vxi5tz6IcqUf06omibT
	oZDSqOY6mFT+suFuusDYeMPO6HenjbLZI0U7y/G3CWC29Q/YLUinYa3NFJ1G3Sw8ibcfjgQ9kRaPC
	gkmNyLgvKZSd1BjgRgQM4dXEGdQ6s1lfcQx0/bOwpHVn+QXnm+P3a6z/PEquEvPFwDUVkaVVev8pq
	ap++my8hMGlJiADz1BUieYmzpoTZxFKQYOQVQzT29B88XFjMcG26PYfvLbxUHn2QAPAwvY785QSfD
	vYTFMgPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxItu-00GHHq-Dg; Wed, 15 Dec 2021 01:16:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxItq-00GHFz-1K
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 01:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639530961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqzviJpaiD/rtEttdKI7UVGMtsBNr4YqXbAMMdj58jk=;
 b=Dwq2nFiOBXR+ploRnY6ZH5Kvdkk11WSWHdox0JO+LzY62A8Xy6eNQBoNSZvlLR8NQC4bN8
 RcC+ktvcR4PI0tY2kf8XMNYfTupJEvAudCafx1M3ZEq22cy5YeWOeMsKYDeeuZOeXoeZmf
 7iLteZ+h2VnGdjXL4Tz+cGcf7R3xyhE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-YahW6mmjO0iUVmDZK1YW8g-1; Tue, 14 Dec 2021 20:16:00 -0500
X-MC-Unique: YahW6mmjO0iUVmDZK1YW8g-1
Received: by mail-pl1-f197.google.com with SMTP id
 i3-20020a170902c94300b0014287dc7dcbso5827175pla.16
 for <linux-nvme@lists.infradead.org>; Tue, 14 Dec 2021 17:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CqzviJpaiD/rtEttdKI7UVGMtsBNr4YqXbAMMdj58jk=;
 b=hmEAZU1rxEdBJxvQzSr79UDhhajecgKdOBhtvH/dQZVFTOzHYByMeFrIcQf8q7sEPx
 tjvkdsC/JEOoL6CnBYqF09i9HVck8qCKbz/C8bFxjFP4v8cjjiyJv0i8Y5xX9vcjCXBP
 XqMn4nNn1Grq8KVNeLZh20k7QMoPXqTKDm+yzV9Y6XkP2q8jvzesItF+w+hva7tr5Ibp
 z5mvXNPcLoSxr9Crue/egWg22TaNZJRhGUYJkoaTPm50Va5FwkEGWPgRiEtsU2p0M0iU
 L/0Ij8oRgixtWmcMeiHbtkS39DJX20aIMNn+yfNbaDOK0Q3g1SwWHtqbyLYL5QOUENth
 dCSQ==
X-Gm-Message-State: AOAM532BmAhb7gTUILKvgXKTL3KH6SsIbd6oNiow5fCiMxw5OQvfswLT
 oXlzk0BN4cUHe0m77YXP3rS0UVa4WkBShT/rHqPh9YMk2qUk9zIUcAL5HNqXdW6IQ7bWuB/1gut
 a5My3WEJz7wu32wifDycSJ0TcTu31A3j2b0jA3HKZsLI=
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id
 2-20020a170902c20200b001422441aa25mr9294401pll.68.1639530958942; 
 Tue, 14 Dec 2021 17:15:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCCN7LeRD3RsPAMydc2U/oekyRRH6c8j5ls98a+NL4Bsd8+iIKWIk7JTXsqge+RgLRVwN6pTzCJQVOfVaIs6I=
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id
 2-20020a170902c20200b001422441aa25mr9294388pll.68.1639530958657; Tue, 14 Dec
 2021 17:15:58 -0800 (PST)
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
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
In-Reply-To: <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 15 Dec 2021 09:15:47 +0800
Message-ID: <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211214_171606_203132_27B25F06 
X-CRM114-Status: GOOD (  18.22  )
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

On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >
> >>>> Hi Sagi
> >>>> It is still reproducible with the change, here is the log:
> >>>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real    0m12.973s
> >>>> user    0m0.000s
> >>>> sys     0m0.006s
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real    1m15.606s
> >>>> user    0m0.000s
> >>>> sys     0m0.007s
> >>>
> >>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> >> Yes, with -i 4, it has stablee 1.3s
> >> # time nvme reset /dev/nvme0
> >
> > So it appears that destroying a qp takes a long time on
> > IB for some reason...
> >
> >> real 0m1.225s
> >> user 0m0.000s
> >> sys 0m0.007s
> >>
> >>>
> >>>>
> >>>> # dmesg | grep nvme
> >>>> [  900.634877] nvme nvme0: resetting controller
> >>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>> [  917.600993] nvme nvme0: resetting controller
> >>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> >>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>
> >>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
> >>>
> >>> Then I think that we need the rdma folks to help here...
> >
> > Max?
>
> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
>
> Can you try repro with latest versions please ?
>
> Or give the exact scenario ?

Yeah, both target and client are using Mellanox Technologies MT27700
Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
first time reset will take 12s, and it always can be reproduced at the
second reset operation.

>
>


-- 
Best Regards,
  Yi Zhang


