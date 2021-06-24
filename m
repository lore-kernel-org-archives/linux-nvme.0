Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F580C49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 16:15:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E6560238
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 16:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E6560238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MEiMXIxwGY21S4aNtysFPWvwcGP2om/ihPDiVAWJ2CA=; b=z+RoVZMgVHrZHW
	Kh222j7krVtZDCFaJunBmj32cd0hG8z5e4d03Z2JDWEp2mlIoCwytbMb3TutsoUpBstLHFLEP0gK8
	VICO5WLnTq79aWsi2aOl8LxZS03oC4dipJ4l8CRmsLIf6Cyk5cLMX/qSOgRNbds/OjceHXKueiJgz
	N1o44cjfSxqWT7SN6ZqgIVUvCD3GVg8quuEz20Sa2Cp3PjuNRPOpGMVl8Q1GRODl91fzUuCXA7ln7
	gzbWnEUXFbuw7GLzAWNvjMCRwoUrW2hJ9hiPhUFn7IzWfxBF1PhZwL3DD2a1tiJIUqwVcuPR45XfN
	0FZHSg/y+EnMcwnn+XoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwS0M-00FREV-Ap; Thu, 24 Jun 2021 16:15:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwS0I-00FRD7-1z
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 16:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624551295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LfvmV+T2Wa7crMF2XTjjbjPZJO3tZTgNFMxtYVD+sIQ=;
 b=KTPHqNw23EMyVqKP+RHEA2wcHp/7FTVqCdSXW+fdlfBRfiqQkclPg1l7lA4XO2Wj5shHh1
 5OQFlSZrwMmmSSQ7rDP2gOQV8N3/Sn7nv5JZ1Ij92pZlIfl4QMdJOpcQISCUYdvyVRfGC+
 z/dF2S9ZV1VKya9zIv3WKOo7HFHL+sE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-hoNdhKGgO8KuczBUrZ5a8A-1; Thu, 24 Jun 2021 12:14:54 -0400
X-MC-Unique: hoNdhKGgO8KuczBUrZ5a8A-1
Received: by mail-yb1-f200.google.com with SMTP id
 67-20020a2514460000b029053a9edba2a6so30199ybu.7
 for <linux-nvme@lists.infradead.org>; Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfvmV+T2Wa7crMF2XTjjbjPZJO3tZTgNFMxtYVD+sIQ=;
 b=oRqb4Tsttvn3yZaMM30oL2nR2B7zgTTFCmUZ6qaw9uzQ0+whx6TR/+3hh5m3j3RUaC
 i8FGnDWfr8zJwaZ8oBZCFjWS27qRVlqCEM2t+tJmw2t1v9x6tBolNnBqjuX65m/CpaWm
 7PYsqUFYcA2UWW4ouiIJXg83f2yF5Xhms+oho9cOmPs6z5PNKpmJRcf1Pr7YBCQg4Y1+
 YNBPAdakairZ1ZftF6xNKSTK9vXhq1+/GRj5zWxMhOZ2X+fut0UK+sY7hD9I8qp9KrCM
 0rRv1nkYMElWz265JyH6tZCi6N6ETp9Sk9+RCI5BDkRT66S5IaUSYHWejD2Wmap7rr0T
 tUpw==
X-Gm-Message-State: AOAM533rVsgjCl/jcRkzxHsfgc4UQrXYE/hh3Wkibz+Ao7dKdUTRVokv
 BX88lSeY5o6XAD9NbEUWBzDYHG3DJvxHq4onCtys6yxMQvtEMHuPvnyVBGy4u0Fpk7ICpGDC439
 yqaypyWI12zdp6FM0CVBWn8dxgPWIJ5ZJUtKKQwMmr6E=
X-Received: by 2002:a25:d44f:: with SMTP id m76mr6043144ybf.198.1624551293303; 
 Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMNcdYCX1QZmZq62f1moLJxumIV0BcdcQYOU46uw4GOrUTffvwjZf9CwVJS7OhiIWaEKYG39RDgBUapSr2FoY=
X-Received: by 2002:a25:d44f:: with SMTP id m76mr6043119ybf.198.1624551293115; 
 Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
In-Reply-To: <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 25 Jun 2021 00:14:42 +0800
Message-ID: <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_091458_235683_79342458 
X-CRM114-Status: GOOD (  21.81  )
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

On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > Gentle ping here, this issue still exists on latest 5.13-rc7
> >
> > # time nvme reset /dev/nvme0
> >
> > real 0m12.636s
> > user 0m0.002s
> > sys 0m0.005s
> > # time nvme reset /dev/nvme0
> >
> > real 0m12.641s
> > user 0m0.000s
> > sys 0m0.007s
>
> Strange that even normal resets take so long...
> What device are you using?

Hi Sagi

Here is the device info:
Mellanox Technologies MT27700 Family [ConnectX-4]

>
> > # time nvme reset /dev/nvme0
> >
> > real 1m16.133s
> > user 0m0.000s
> > sys 0m0.007s
>
> There seems to be a spurious command timeout here, but maybe this
> is due to the fact that the queues take so long to connect and
> the target expires the keep-alive timer.
>
> Does this patch help?

The issue still exists, let me know if you need more testing for it. :)


> --
> diff --git a/drivers/nvme/target/fabrics-cmd.c
> b/drivers/nvme/target/fabrics-cmd.c
> index 7d0f3523fdab..f4a7db1ab3e5 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> *ctrl, struct nvmet_req *req)
>                  }
>          }
>
> +       /*
> +        * Controller establishment flow may take some time, and the
> host may not
> +        * send us keep-alive during this period, hence reset the
> +        * traffic based keep-alive timer so we don't trigger a
> +        * controller teardown as a result of a keep-alive expiration.
> +        */
> +       ctrl->reset_tbkas = true;
> +
>          return 0;
>
>   err:
> --
>
> >> target:
> >> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> >> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> >> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >>
> >> client:
> >> [  857.264029] nvme nvme0: resetting controller
> >> [  864.115369] nvme nvme0: creating 40 I/O queues.
> >> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >> [  868.001673] nvme nvme0: resetting controller
> >> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> >> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> >> [  935.438080] nvme nvme0: creating 40 I/O queues.
> >> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
