Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A96C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Dec 2021 03:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5UiOJgBBbZLux9Bf/dpVaRBpoMUauCAOIQF97hVE91I=; b=zGEP2geYKHW1qzytHJ/rNWeG9E
	I5Af1A0UKG6u6pAFWz4ZF04q+VrBY8t37zSIoz43jFfYAra5RadDPGEEFHeL687wR6U47dCYuAnxT
	vD4ExJbMs5EvwoL5UNNZzVEsacBT6q1xs4UJWyrYQzdIJNV3eStb3NWx4envT1UhU4q2qIhwPOUFq
	cq9NWPD002qVaYlSYl00rb49yt7bdeSB6aEHUxoakrtL4I7WLL9i0G2VJAPATmQdBdPBIQ2vXOFDR
	vI0qaGqIMIx+nxxfJQKisuqCNAnLq407sbNvIhm7molLU3+A+O4ocT97AZvoqGCHiEHs13AoTAKbO
	jpb2bs/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvtBC-004Vc0-0I; Sat, 11 Dec 2021 03:36:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvtB9-004Vb8-D3
 for linux-nvme@lists.infradead.org; Sat, 11 Dec 2021 03:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639193766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=5UiOJgBBbZLux9Bf/dpVaRBpoMUauCAOIQF97hVE91I=;
 b=axFNFbbYn6HSMwk7suzlUyepP/5iAnvryF8jJyDpMPBck4JokRfGZzBPHDAxuxy2tsDvHm
 GorPhjPT72VWIyl95I2Jrpa4aoN/yD+QcjuBp/0fk3sxG07uZJbBA2Eyog6nCaBkcxkxb3
 lclV7KLTfuZCYyP3vn7J8//QYJseI4g=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-IcMFMa7gO2-mqiqpqhqjyQ-1; Fri, 10 Dec 2021 22:36:05 -0500
X-MC-Unique: IcMFMa7gO2-mqiqpqhqjyQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 b15-20020a25ae8f000000b005c20f367790so19931215ybj.2
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 19:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=5UiOJgBBbZLux9Bf/dpVaRBpoMUauCAOIQF97hVE91I=;
 b=reYRYzmoDBEnwqxmDZ7CmflaSW5vPKyLk23LRc8ol1Dw/oflQW9K+NKEVvjDx0WTOW
 9QCIrKVPJZWLttuaQ0CLZsXgYHOUhZhG1EVbo24BrnfMwJs2p9AHt7wxr+rtj1+F7uEA
 iFFFdpt8kdnY09Jw2xAhOyhdZ88GHkJHSovCAvkUMmK/8yABlQlec33w1K9YjlwzuzGr
 BSX9z+vXagONzMNI2Y9/AI6BpK1jA5WEU5g0SXu9k0DCYWBTTIDE2+5M/MfgvWmDdrQu
 ALSkbPFH/pF7gS8zkGzv+wIxJSV2vN5RclztW3mpAZpK3AsnfLoXIZJ6DBrIet7DeujD
 HrsQ==
X-Gm-Message-State: AOAM531li6+j82atNqzCf4fJLJkqvMPkH3XFsuicPDNYxqjOkUZpw5pI
 0A9pmDxfDBRlOGjxLFyMtjwkRHZCcQQi9QrjFT/UFaFYgkgI8YUdK+7xZTKhXOByzOkQP7/xqTa
 s4kH8NO9uLQw9+gWyl7+Jt/AtDD2C813NiuAWBpOYyzo=
X-Received: by 2002:a25:d70e:: with SMTP id o14mr18882187ybg.427.1639193764458; 
 Fri, 10 Dec 2021 19:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc2kMu2ehbnzZMVb1JKjUT2NKrZ6ylBog5JKDwFXXH4PjT/enECszYoHE02edeX5dhNn/ueyP+LQhi4ypgPfs=
X-Received: by 2002:a25:d70e:: with SMTP id o14mr18882172ybg.427.1639193764222; 
 Fri, 10 Dec 2021 19:36:04 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 11 Dec 2021 11:35:53 +0800
Message-ID: <CAHj4cs_ZmoGhVy3tZKtCY9TMCiXFR1RofswaAXKBB1VYm2zdcw@mail.gmail.com>
Subject: [bug report] NVMe/IB: nvme disconnect -n testnqn need more than 1min
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_193607_536371_033F62F2 
X-CRM114-Status: UNSURE (   4.82  )
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

I found the nvme disconnect always needs more than 1min to be
finished, could anyone help check this issue?

Reproducer:
+ nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn

real    0m4.673s
user    0m0.000s
sys     0m0.005s
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real    1m9.028s
user    0m0.000s
sys     0m0.187s

client:
[  283.966930] nvme nvme0: creating 40 I/O queues.
[  288.527028] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  288.530501] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420
[  288.533203] nvme nvme0: Removing ctrl: NQN "testnqn"
[  357.534154] nvme nvme0: I/O 18 QID 0 timeout
[  357.539644] nvme nvme0: Property Set error: 881, offset 0x14target:

target:
[  229.016490] nvmet: adding nsid 1 to subsystem testnqn
[  229.044861] nvmet_rdma: enabling port 2 (172.31.0.202:4420)
[  280.697930] nvmet: creating nvm controller 1 for subsystem testnqn
for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  291.155204] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  291.162238] nvmet: ctrl 1 fatal error occurred!--

HW:
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]

Best Regards,
  Yi Zhang


