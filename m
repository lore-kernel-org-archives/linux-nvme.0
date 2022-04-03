Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD6C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Apr 2022 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IIVNEpWpaVjcnyyLFzQwAktLNrstRTvpTe0AK032a7w=; b=cL2749ZKNb8NKKccndYvhL0O93
	OdsYfI+rIImUeFbXKH5iRVLfck0M+hrgOI+6WOfnv4NCUohhjWQcakkzfKJLI9FqjljLRQORYcfgR
	e9jDjgYDnSuwRt3X4a7p7hbcze7UmzTFqu+0HVXkQHcfEF+rzxEobnxd+M2lIdmS/56qmLENEf9K7
	M7NgEqOk0U/I1ohi3Os1abRu4tLkSrZFrIgVSK635PEJzequwIdpdkp28Y66JO0l/Q9W1YyW3Phx9
	Iq1umE/Mr7flLaGpILcPcRSjOcg0rUigK+5eWMWYxNXzurCyjP4ayz1Cy0AN3dhTmb05mOdyckf6f
	1nJSRX4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nb1E9-00BbNd-GB; Sun, 03 Apr 2022 14:29:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nb1Dy-00BbNM-PT
 for linux-nvme@lists.infradead.org; Sun, 03 Apr 2022 14:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648996140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IIVNEpWpaVjcnyyLFzQwAktLNrstRTvpTe0AK032a7w=;
 b=dytTqS4rS07CI7wsjLeqCVmm49Ip+pxhfl3+JhoP6zcW6VTlhjXCNmU7VvhsfnSS2j9gx0
 xMwqPFhWf0s5gfgYh2aSlhgAUeHAZHW5xMIEGH5Ba4BmB9XWVqbpnzcHSdrScA4zMS84+g
 gnMTxeL7XWerqx/J4Cw5mbUoiUWOhII=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-QNEnvyCXMMiN05Z-rt9nqg-1; Sun, 03 Apr 2022 10:28:59 -0400
X-MC-Unique: QNEnvyCXMMiN05Z-rt9nqg-1
Received: by mail-pj1-f71.google.com with SMTP id
 l2-20020a17090ad10200b001ca56de815aso1385764pju.0
 for <linux-nvme@lists.infradead.org>; Sun, 03 Apr 2022 07:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=IIVNEpWpaVjcnyyLFzQwAktLNrstRTvpTe0AK032a7w=;
 b=Q1hsKCYLJZ41reygCwFh/ORCCAzkxt810D1SFRlZdtkDWC9Reez8xQYh0Tb7/y9CVS
 cMRgmlFVXJLryz7fI+pvDvZeeAvT8057Yy1Nox5ga0XJksdCqE+Ub1QEdv3G2HT+8/ym
 2+s4T8AIGq4HkmFFDje9fo2udO0Xj2KaEIhJgRl6IlL21hNQwkE+1m6GDGc6RIXhjOFj
 Vam5snwmjdsku7QJnvgu/s7tgGwdhr2pVYWU/TrAtbsD92LtP2eSwKX57rDnZ9TA0KKc
 NF34xokDZ/aJYG1504O/2+dUfPbiqGTw0a7YmJFHUIcgiNv2S2yb9vvOhNWdzMxn2aIj
 3Myg==
X-Gm-Message-State: AOAM533GDehwEY+4QydW5WopVR9r8RPB3rTQ0uLP5wCQoMo7fxuweqQh
 JchUWAW/bGobKMQNjYfrLYoaRI6NHRD7+UM08ZJYDN2HF3Q9T/qYcfSOYhf6UKYKpHDAL6a/Y94
 A5Ga73eidM2jNUtF5a9IZGnaBg0TySpvJy7+L8nxv79A=
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id
 q16-20020a170902dad000b00154740a9094mr18789032plx.107.1648996137799; 
 Sun, 03 Apr 2022 07:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxykBx4WErbjDXRnxlvGb3mBRrHiv20vRd0rI7+CYzKVat92og8eCotJ8WOQq1SqKAX0O4osPbYPNGBoit6qEs=
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id
 q16-20020a170902dad000b00154740a9094mr18789008plx.107.1648996137500; Sun, 03
 Apr 2022 07:28:57 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 3 Apr 2022 22:28:43 +0800
Message-ID: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
Subject: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE
 DNR observed during blktests
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, alan.adamson@oracle.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220403_072902_938122_302654D7 
X-CRM114-Status: UNSURE (   5.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

I found this error log during blktests[1] with the latest
linux-block/for-next, seems it was introduced after commit[2], is that
expected?

[1]
[   96.931911] run blktests nvme/004 at 2022-04-02 20:53:16
[   97.024693] loop: module loaded
[   97.029319] loop0: detected capacity change from 0 to 2097152
[   97.039641] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   97.068847] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
[   97.090108] nvme nvme0: creating 32 I/O queues.
[   97.098283] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   98.136900] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

[2]
commit bd83fe6f2cd2133beaac7c423fd36c3515048fc8
Author: Alan Adamson <alan.adamson@oracle.com>
Date:   Thu Feb 3 00:11:53 2022 -0800

    nvme: add verbose error logging

-- 
Best Regards,
  Yi Zhang


