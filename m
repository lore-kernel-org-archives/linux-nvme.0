Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49588C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Dec 2021 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z7B0zQTPiPVnnjbrvm4/s4TW9juVVpw1RLHcqMAWfQE=; b=Z3VdYdT849myzb1Y57Orra2Ivc
	HJlyxLPVMrJfYEBcAnGy9xHGShnIGaypcuu//sD273kRHEFJCwStkuMq+4UKuw0B1I/VtV/d4EtEm
	ivbJWiQGa1oL7mmuF1ehZGjgWQBczyZurQYMWyZhdkCi/y2fd4AXeKpF3B/9cR33cn9u5q9nabKXx
	4D5e8PvS2Lqx5zRtfrFOqV1NJPZU7fUgKk7JmrGszpgQcfL3wET+17qZM5smmxFKGQ3857mWIAwTe
	t4xLxnDe/i1mFNwAyGX3hEL21kDHT0a/2o3e4p8RwMuqngH/roJ8n1pjSAYI/+X6822tFtDdkNbqz
	Ev8AhyTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvseO-004T02-Fy; Sat, 11 Dec 2021 03:02:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvseL-004SzV-AS
 for linux-nvme@lists.infradead.org; Sat, 11 Dec 2021 03:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639191730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z7B0zQTPiPVnnjbrvm4/s4TW9juVVpw1RLHcqMAWfQE=;
 b=MHmszpyVZ1jqGtKkomWplOn2ukbNvh4DAklKElbHeEd0WAMpni4cOXx88BYOmkwWCKRiOB
 zrqUaTP/nz66JOJpsut5ZVAQZUJ+MZfq+btDl2Zp1WOthP+lCgbxbBwK1b7mRi4q7ZXRl2
 hy1R1y+s+qB+VfEVlf0CWo6I6XjuECk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-IWst4ZNWO9O1enjNOCt6jg-1; Fri, 10 Dec 2021 22:02:08 -0500
X-MC-Unique: IWst4ZNWO9O1enjNOCt6jg-1
Received: by mail-yb1-f200.google.com with SMTP id
 s7-20020a5b0447000000b005fb83901511so19761144ybp.11
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 19:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z7B0zQTPiPVnnjbrvm4/s4TW9juVVpw1RLHcqMAWfQE=;
 b=grETIx1HvkBxgMPzKsJ/GRYPPh5wL2UshJ6hr8jzkfOFDGUOqGMv9tG8mXFcfqujez
 xkPnJyOlRp1R8xYFReSDIPIMUeceNb7j8DkFfGLh0TKVRm22QKhxpgcqqxaqKpjubiZg
 rpf93dwJflpKobWBXd/G0hDPiDeAlzB46CIHQw5gK601e3buQ9wdXOm0wWTzgc4Jbnx3
 EqvwRkYApROshYWjAh0rzFT3k+rqjLh4Ze6HMm57e0+8KPWrcm3dsXf0Y+it0CqwExDC
 SHAJ8excm9aToxIPFI94/RIcdCfWSK5neEKGuPmlGcPv+4hd2hwPuUU3jtgwnShvOKQC
 rwzQ==
X-Gm-Message-State: AOAM530Hasildf/2401drtBjbgx3z8E2f2zpdZthdkdMxPk20cJkSHWt
 kIJEs650HUauHFtIBPRTzHqAdDGAX0Iuw1cwnoqlLCTiDDsy8S22d3rwZsZ/b2CEM4Fyq6pL7vW
 d6KMLgyiQLSYdsQ9w2vArH0E1x4I1iR7mZ6I0asB/2EA=
X-Received: by 2002:a25:c091:: with SMTP id
 c139mr19840668ybf.275.1639191727850; 
 Fri, 10 Dec 2021 19:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdaHKXA93lP45n4ISog5sZ7MeIS6MFFX+0xo/PMSOCVby4QA1p0Vpxp7AS1raK8PdUWsIaIaIkO0OgHbbPur8=
X-Received: by 2002:a25:c091:: with SMTP id
 c139mr19840646ybf.275.1639191727592; 
 Fri, 10 Dec 2021 19:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
In-Reply-To: <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 11 Dec 2021 11:01:56 +0800
Message-ID: <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20211210_190213_469756_BC036FAE 
X-CRM114-Status: GOOD (  28.06  )
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

On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hello
> > >
> > > Gentle ping here, this issue still exists on latest 5.13-rc7
> > >
> > > # time nvme reset /dev/nvme0
> > >
> > > real 0m12.636s
> > > user 0m0.002s
> > > sys 0m0.005s
> > > # time nvme reset /dev/nvme0
> > >
> > > real 0m12.641s
> > > user 0m0.000s
> > > sys 0m0.007s
> >
> > Strange that even normal resets take so long...
> > What device are you using?
>
> Hi Sagi
>
> Here is the device info:
> Mellanox Technologies MT27700 Family [ConnectX-4]
>
> >
> > > # time nvme reset /dev/nvme0
> > >
> > > real 1m16.133s
> > > user 0m0.000s
> > > sys 0m0.007s
> >
> > There seems to be a spurious command timeout here, but maybe this
> > is due to the fact that the queues take so long to connect and
> > the target expires the keep-alive timer.
> >
> > Does this patch help?
>
> The issue still exists, let me know if you need more testing for it. :)

Hi Sagi
ping, this issue still can be reproduced on the latest
linux-block/for-next, do you have a chance to recheck it, thanks.


>
>
> > --
> > diff --git a/drivers/nvme/target/fabrics-cmd.c
> > b/drivers/nvme/target/fabrics-cmd.c
> > index 7d0f3523fdab..f4a7db1ab3e5 100644
> > --- a/drivers/nvme/target/fabrics-cmd.c
> > +++ b/drivers/nvme/target/fabrics-cmd.c
> > @@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> > *ctrl, struct nvmet_req *req)
> >                  }
> >          }
> >
> > +       /*
> > +        * Controller establishment flow may take some time, and the
> > host may not
> > +        * send us keep-alive during this period, hence reset the
> > +        * traffic based keep-alive timer so we don't trigger a
> > +        * controller teardown as a result of a keep-alive expiration.
> > +        */
> > +       ctrl->reset_tbkas = true;
> > +
> >          return 0;
> >
> >   err:
> > --
> >
> > >> target:
> > >> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> > >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > >> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> > >> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> > >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >>
> > >> client:
> > >> [  857.264029] nvme nvme0: resetting controller
> > >> [  864.115369] nvme nvme0: creating 40 I/O queues.
> > >> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > >> [  868.001673] nvme nvme0: resetting controller
> > >> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> > >> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> > >> [  935.438080] nvme nvme0: creating 40 I/O queues.
> > >> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang


