Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F18C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 13:25:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B95610CD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 13:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B95610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OGbIfERtOngauZ+R6hLWOckqby1B/2I0JGLwv2sBpOM=; b=Vohz6/Sg9V2V9BGx2+clG90KOE
	DnaKhRy0Uf8aFNQJDI2kefzRCtoJo6O/lCQ9YebZsRjzf2ZzxqIPEMXRKdPyUvV6Bww1dnuzk3TUL
	YLhlVrWtPAR5HWHOwP+0DnU7qXevfa3spZqn9J/QxXzufCiYq+qUst7dxCxDjfYOfxhwVoMU7EYQF
	Rc1gLXQMzKYmSmLfyeX1DYSZW/Ew3q1GKs2fYCbBQOBAdPMsw0yKuEGEUUqNLfcBdkG9FDvkCeVY7
	FHyx2dse3pGbTC0yv/y+grlTmtmp8ung7E8+fy7vKpS/SJtgVMLL17DMMenClQhGM7t7et0m/wgN+
	sUQwDDIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lizi2-000s3v-RO; Tue, 18 May 2021 13:24:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lizhg-000ryB-FX
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 13:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621344233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6i6eXgSE1Cl7bPnzXaxdYmMGNwV6b4jIAQPk3FTqSyc=;
 b=RdBPLBpu9wBgHE1ieoQdGrQML4rKCN6DTv/8HdXS3AoHCogOnClY4CriYfD6cxMcO81EoB
 sy7zbO1a92D7dne+SfnpOD6ntYUeHawDyT3j6tDt7g+ivvLaF+gpCe7p+/rDbMKU7td6Ml
 vXK6xuhf8Zc3V4HCVJ3BfjtzMMcvHuA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621344243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6i6eXgSE1Cl7bPnzXaxdYmMGNwV6b4jIAQPk3FTqSyc=;
 b=jH7ZbOlbWFnzf74d6AENnlWCOwXy4dUoOqkH6exL6hDQ2Sr0Rj100NDwuE94fn9twrXxJb
 xMpFho88M9Bdh9+B5Qx6q+cTACnlfS86/u1KanJnVbsHN7iXn/CqUbUv5aChAYOo4eOE3i
 mAD77ieX2jEfu7m9WUTz6ornsXkiDTg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-nghB9m6JOum9_RjiXvxSCQ-1; Tue, 18 May 2021 09:23:51 -0400
X-MC-Unique: nghB9m6JOum9_RjiXvxSCQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 k186-20020a2524c30000b02905116c9c3759so3655838ybk.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 06:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=6i6eXgSE1Cl7bPnzXaxdYmMGNwV6b4jIAQPk3FTqSyc=;
 b=aq1/VWBokhQMzFbleoEKr9HiY/REDuCR11EHzT2ViyvdJk+p0BGywigpRz6ALyNIs+
 RNCSfkrpX0BtK3q2ycutB/jy8ZjcO/p170eGhvipDq8ktMbwbjlAAJIHtcx4Zyv3C3Fn
 /KhOe2ZBhIeYA3psyZ4Ftcy9PTeSMRStUHubiuZZY73S0tFVItb2upGtXny+iW/RJqUU
 xligJq+3S2zRDGPDansJMJlquRcG6NjgdAORsfuPch/wdARDQmO3UNXXao/mQeK8Jv/W
 svJAJygAtQ4FfOd0aJtXp5s+3HpCq3CATRxpudD6d7BBLHkiiNStJonMp/XO2CI4ogFG
 WeBw==
X-Gm-Message-State: AOAM532o8sRVH1eMSvKP4qYvqFmADpU/yrGMc0lj6Ql07p53hIvCdEjd
 kNHrkunw9oqh+bfs5jgyPSeeKdh1aaWdIeI6zij9SgHvXAckP0i8vT7V69bPlYbZ/gKLT8pDUiu
 O/FITnWMwCrMffnMXnaXhFxSJr8Bs+SX87QHo7ksvpBU=
X-Received: by 2002:a25:8402:: with SMTP id u2mr6794410ybk.89.1621344231051;
 Tue, 18 May 2021 06:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/Oei5EHcJLEaHDj69YFf4IO3h4WzdGaPTaUt20wn/Fz/8OKXsjDguUyoGouC93MdIVkdRphpf/Fa7ML87f8Q=
X-Received: by 2002:a25:8402:: with SMTP id u2mr6794390ybk.89.1621344230864;
 Tue, 18 May 2021 06:23:50 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 18 May 2021 21:23:39 +0800
Message-ID: <CAHj4cs9MVLY+KkFXfmwPd5db69pVjAuD2g+yJ=oE14UddUmKKA@mail.gmail.com>
Subject: [regression] nvme flush failed from v5.13-rc1
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_142408_970955_A80BF7CC 
X-CRM114-Status: UNSURE (   5.34  )
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
commit[3] add a check to validates nsid which will lead nvme flush
cmd[1] failed as the cmd.nsid will use the default nsid:
NVME_NSID_ALL[2], that finally lead validate failed, any suggestions
to fix it?

[1]
# nvme flush /dev/nvme0n1
flush: Invalid argument
# dmesg
[  802.131609] nvme nvme0: nvme: nsid (4294967295) in cmd does not
match nsid (1) of namespace

[2]
        struct config cfg = {
                .namespace_id = NVME_NSID_ALL,
        };

[3]
commit c881a23fb6f7eb901155d25ba8dd1af0b8c7923b (HEAD, refs/bisect/bad)
Author: Niklas Cassel <niklas.cassel@wdc.com>
Date:   Fri Mar 26 19:48:00 2021 +0000

    nvme: disallow passthru cmd from targeting a nsid != nsid of the block dev


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
