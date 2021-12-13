Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 03:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yEWPJfZgRtJBM6Mp0A5z/bkJsr1Ctl3SCplDAMANhhM=; b=XWLPV/5xzhsXl17JUkOAIqM9FY
	3Jn1o3nfdZKeMBSkouS/B2Iil6lsC3gUKtkKUQGFpkbI4bOpD+QYKsKQMJEPMUwQs6zoG9lpds7Vk
	MRlZTepxRweGjTeMUpnwoouAiaUoF//AejUVD2nnGtbDOjooLy/dDG9T89A/0Mo1nYq6P2Th5P5SN
	WzNPPHRv6aLGPUa1+Pw2UGY352VInllAjqoutGa2CqcorFBBP9IxSJ/fYNnSgktsY4awI5yzYxtMw
	ja/FXE2UFFW4tx81FkJvVpuzUOlF2jNOwW/8f8mL4SQEujW2tWpY/q3AXzygid7uYGfB1ORZKhlq0
	aNCgND6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwbz1-007g01-De; Mon, 13 Dec 2021 03:26:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwbyy-007fzS-AL
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 03:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639365988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEWPJfZgRtJBM6Mp0A5z/bkJsr1Ctl3SCplDAMANhhM=;
 b=evpGcExHLQi+ETGgDi92g40FGyO2SihO/AWfnOhPlWycyoQ3c/vk1SKiy2PJl76HfC+Y1W
 c5TOwXZntP8QVxtz0yXg0tNV3WaQHu/Jf7w2nt4HaNasDZ7e2Hr1BLn8iQRzNl//gVafM5
 hI5Q8qr3fPthiVcMCEzX1qR+z7NhP8c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-w7cysbi8PFCAmlUE10S7zQ-1; Sun, 12 Dec 2021 22:26:26 -0500
X-MC-Unique: w7cysbi8PFCAmlUE10S7zQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 m16-20020a628c10000000b004a282d715b2so9536162pfd.11
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 19:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yEWPJfZgRtJBM6Mp0A5z/bkJsr1Ctl3SCplDAMANhhM=;
 b=cXOcwGpbZGkQdnU6YFY5mpA7Jgk6FGzxOeSN7WPlmtjdNlHjVnTeOmBCGyrn93X6/S
 htwgPntIcijIkGarh4VojqMaAq9ehaSp84GoDhfP4dU95oekT0gJEM7Mzv0G6Doifrxl
 JGutThFlwkYTXg5qS4XfJGD1bfNAOkfWCYIlNWFPRTBya92TZm+vutSE86vioHeIx/DR
 ydb5sWNkGvoHjDgYeeupUaFkIqzjlF6F9jYL/gboA5952vFH01apPTlA6zJyHjP+Ibjm
 bcUmOUPR7BLdQVq0oK1TvjuYLinYf3wh9U3+G8fmcqamVuPQEwIdKF0hfzl7DzraXoWq
 WlzQ==
X-Gm-Message-State: AOAM530TfNWMU3wtZ6fEo/5QSOLgGs9Rogv+vnllngpREerqdA8zV58m
 yrfzBzBYmt930essuVXqEl8Z7CoM4DOv4/l861zDVJmPknM9XM52wuc4eTvzkuiwnFVgQhl6oOC
 mB5bVwTAL+JUDPLxx8moFyK7ebpsIetmDW6A7tdkSF+k=
X-Received: by 2002:a05:6a00:1ad3:b0:4a0:36d:d067 with SMTP id
 f19-20020a056a001ad300b004a0036dd067mr30903458pfv.19.1639365985072; 
 Sun, 12 Dec 2021 19:26:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzljL4mLQBl/XV88otKpq55Fa17L4SLM/cKAf+yk0qaGJNzbTjgRzKrn+UFo5EXGQSmnxq/nLwUDv61B+/g6kU=
X-Received: by 2002:a05:6a00:1ad3:b0:4a0:36d:d067 with SMTP id
 f19-20020a056a001ad300b004a0036dd067mr30903447pfv.19.1639365984830; Sun, 12
 Dec 2021 19:26:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs_ZmoGhVy3tZKtCY9TMCiXFR1RofswaAXKBB1VYm2zdcw@mail.gmail.com>
 <8ed5703f-c972-0ab2-a081-b023311e012b@grimberg.me>
In-Reply-To: <8ed5703f-c972-0ab2-a081-b023311e012b@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 13 Dec 2021 11:26:13 +0800
Message-ID: <CAHj4cs8Jgz2+7F-w6VfsPVJmzPThrDFXiLHRORYwVECOk8+hdw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: nvme disconnect -n testnqn need more than
 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_192632_480607_29B71852 
X-CRM114-Status: GOOD (  15.01  )
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

On Sun, Dec 12, 2021 at 5:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > I found the nvme disconnect always needs more than 1min to be
> > finished, could anyone help check this issue?
>
> Yi,
>
> Does this happen with rxe? didn't see this in my test VM lately.

Got "rdma_rxe: check_rkey: no MW matches rkey" error when I use rdma_rxe.
but it cannot be reproduced when I change to use siw and
NVMe/ROCE(Ethernet: Mellanox MT27710 CX-4 Lx])

>
> >
> > Reproducer:
> > + nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> >
> > real    0m4.673s
> > user    0m0.000s
> > sys     0m0.005s
> > + nvme disconnect -n testnqn
> > NQN:testnqn disconnected 1 controller(s)
> >
> > real    1m9.028s
> > user    0m0.000s
> > sys     0m0.187s
> >
> > client:
> > [  283.966930] nvme nvme0: creating 40 I/O queues.
> > [  288.527028] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > [  288.530501] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420
> > [  288.533203] nvme nvme0: Removing ctrl: NQN "testnqn"
> > [  357.534154] nvme nvme0: I/O 18 QID 0 timeout
> > [  357.539644] nvme nvme0: Property Set error: 881, offset 0x14target:
> >
> > target:
> > [  229.016490] nvmet: adding nsid 1 to subsystem testnqn
> > [  229.044861] nvmet_rdma: enabling port 2 (172.31.0.202:4420)
> > [  280.697930] nvmet: creating nvm controller 1 for subsystem testnqn
> > for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > [  291.155204] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [  291.162238] nvmet: ctrl 1 fatal error occurred!--
>
> Will have another look.

Thanks.

>


--
Best Regards,
  Yi Zhang


