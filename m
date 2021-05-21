Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A14C47076
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 16:13:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D6C613AD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D6C613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=78XBp2axjcwDSUnPy7qR6aOafaHUtVWl5zcYTrlfH4Y=; b=e19ZSSqMlDPc9KkkIkF+vCpQ6m
	O8Qe46iQA0Y8CP8jcm0UqViBy5S0bOAOep+eyhfi95ID1HwcJzO4XF2Ye46yVQZrpLSFiYM9pnOQ8
	KzW+0Th4TbnhJwuHRcuWTOTH64O/XQcC8PbDPIyFvPMi/5LxxIoKuQsVJqWWtPRsUZ+soB6AmOfE/
	eB7jfx38K64pG2LYp0ZwiP+LKNjotod9PrzCaniwvuMrVdyucetGnLh4WR3p0AQdIRGbHNi1v1WwJ
	bQkwguEeYoePK9jvEkymRH/HNEjxdLSSpfY6p2GwNSpSJJQlNRUbYihTTfZzjenubggHCaTY/QVjS
	D5Stf7Iw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk7lb-000Cj1-4a; Fri, 21 May 2021 16:12:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk7lT-000Cgq-ND
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 16:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=BUc9vNUEFI1h0TmHJFjFqgJSEIeT9zOloVrP9nB4LeI=; b=ZkjMOAmmYHoaLRlYSFqKs/gpv5
 SLWTg6DFNFmzVUbfA/VbFztLZtNMiCp0maQ/+JMe3M6h4JkOmRflxdVxm5DVtTJuQsqtWipWQP8Oq
 CxCEuMxiwV+5K3TZd+w/v/UIkVAVY2P2oq9xot/uAzgK0XcdMB8l/S/utBOc6osxdX3Nasm8soq96
 0j8t1Zp31mk7E2fmpIhVB+cIaQfGb7/g+Yi3ePPSYP+SQg/VxyR1oA/YBtAZ67xe66+hxkkZeJJNK
 yFyo7pxeeUZ84E6dz0ImYotWzlRFDTDsYIsDaef+VlzpGXv16n5yaM1wlTYiJxtPU8XzKcwp2+wSU
 xzy5OIPQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk7lR-00HGf0-38
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 16:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621613560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=BUc9vNUEFI1h0TmHJFjFqgJSEIeT9zOloVrP9nB4LeI=;
 b=IhalENp5y3bSIQ6lSCnxRTzJen2iK3iFNTWvOe6gwcyAEjfDvz16Uhw+vfBMDRy2kFIcj8
 bbfXQUEP/kS0wsvUPnPv3LeqmMxAXCpJ7G/nsQpw9ZDXEtF8VUto7h+5tuI/364aYcwYwH
 cv/yqGK86Oe0USGrLqgnwS+wGkdI2O4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Xmn-iFZ1OIaqzVDduBHGYQ-1; Fri, 21 May 2021 12:12:38 -0400
X-MC-Unique: Xmn-iFZ1OIaqzVDduBHGYQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 o12-20020a5b050c0000b02904f4a117bd74so27712365ybp.17
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 09:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=BUc9vNUEFI1h0TmHJFjFqgJSEIeT9zOloVrP9nB4LeI=;
 b=L3fF2Voq/GDmP9Hw0FTq4bfOhO/lzx6xtcYLAdQLS7ipyhRUMK+YS4oDYY0W/xYKVy
 FL+zm3e4x5Qyla9JDwZ4L3gLnCE1k9xv+SSExbkHKiMQ+hyPKwtfntwygBXV7bWo+7gt
 DIXp1NX/Spfr66phjC/JtjfK86+Jq3p5QhKwXMrhFNFE7A/epuGr6eoogduHxPqnFYlQ
 dK942udGRRRrlmggWIczJ61FQfVT1v3wujoeUatG3d5mw7B8d8Jxp5H0wmhFnFGa0N6b
 j9PSLhMbPENIYBBYT+wauO8Rg/cCvzuFyvkjnHaVoWwznT1On//TbfX8krupZOFjUTi3
 IMVw==
X-Gm-Message-State: AOAM533mhtV2LLpwS7oRjOeP06sn0mBBTq0rw+q0MpmXsn1FuBcphQ4n
 AH1fZZgVn32L7ZH9JZwKgVGEhBFsVIh2mKD90XEUH+8cCLaALnJIFtw+IcKmJLGm5ONntyXBccq
 0+ad3r5y8G14KgGru2M0607Fxpaat+dbffH0JV7U28WE=
X-Received: by 2002:a25:744c:: with SMTP id p73mr15877960ybc.205.1621613557628; 
 Fri, 21 May 2021 09:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9T/WrkOTucst8g6Y/ojDUHloCX6zpyTKTQfsLHXdMgJ7O9jJK59DUa036rYJOBdNxbyZzZZ0jXlGo3s+PjuU=
X-Received: by 2002:a25:744c:: with SMTP id p73mr15877934ybc.205.1621613557420; 
 Fri, 21 May 2021 09:12:37 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 22 May 2021 00:12:26 +0800
Message-ID: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
Subject: [bug report] NVMe/IB: reset_controller need more than 1min
To: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, maxg@mellanox.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_091241_334120_47170F1E 
X-CRM114-Status: UNSURE (   5.12  )
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

Hi
I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
help check it?
Thanks.

$ time echo 1 >/sys/block/nvme0n1/device/reset_controller
real 0m10.678s
user 0m0.000s
sys 0m0.000s
$ time echo 1 >/sys/block/nvme0n1/device/reset_controller
real 1m11.530s
user 0m0.000s
sys 0m0.000s

target:
$ dmesg | grep nvme
[  276.891454] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  287.399317] nvmet: ctrl 1 fatal error occurred!
[  348.412672] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.

client:
$ dmesg | grep nvme
[  281.704475] nvme nvme0: creating 40 I/O queues.
[  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  353.187809] nvme nvme0: I/O 8 QID 0 timeout
[  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
[  353.226082] nvme nvme0: creating 40 I/O queues.
[  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
