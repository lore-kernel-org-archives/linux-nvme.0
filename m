Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 03:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B1D61052
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 03:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57B1D61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8XND5jk1chSWFZ3TYNWOXvTjVqabcC3EHFqWuIJ/CGI=; b=E0ElApcjLDvH+H
	SPgLMettLtqBiqvkjR/mPHPWIhTgIEJtJWE3O+hvkbMe7A0EpOQL63+MRv2sh0J4oV5B0QIw6+fZP
	DH7CaK0KDWWycGUvzo8i60AIn58ibWFTT77vVvXoutRdQPUWkVSEiW++QdbpyHasMGL0ipFn4nmr0
	JcS26H1sFY90+Znz81FOMEoA5gbQtUOZ13ILoCdb56u1WZWNOOyqVXM0lykADwZTZH0RKnLW049Xz
	2WnxpQMHjvxisZiLvncbNbmHbd055YaC6wiBZyek9XYbTcSzfyRtnj/sijibgCW2+IPJLYondYfKa
	80+jhqU/SM3KsVdjew/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV42t-005T6Y-Vt; Tue, 28 Sep 2021 03:44:44 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV42q-005T6C-SZ
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 03:44:42 +0000
Received: by mail-ot1-x32b.google.com with SMTP id
 g62-20020a9d2dc4000000b0054752cfbc59so21586089otb.1
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TW1sJFA5TCGpuoPr9cxfxoorRNbsWjA5cLQfaJbdnbk=;
 b=Ro6ASlwDGgEA4XKOilR5k3T7ONWrc1mzqAtqdDmBPdpGwFMVEh1tUhYml1nNguNhGQ
 sjCbGcuUsZN36Piq52la+vkqARqfXVuS3pTBVDdaxY86V2OnE7E72zcYcGB2ECMRHCam
 RdAnCzJzloXkB5PrTpf3BLKpCgOIl73qRgcLuhH0W4fcNZF+b9QPY1I77sTPMHe7EGN3
 M/TyRG94NzDtAA7z8gi+VErnr1w0AaHMOeWhd/uRbiCrsKuhWOeFYIJS9whNSMO4pDyu
 2vlXwLIAuX7D0ynXp63i8TmPw4wQ794/IWPmRfNfdTLLOuLmafAHpcFEnauUHivNQm6H
 6ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TW1sJFA5TCGpuoPr9cxfxoorRNbsWjA5cLQfaJbdnbk=;
 b=syt37VZO7x//6d8wQr5AnujjHZ7JiIFpn1Dm5l3B1SmD/q5fHIGY8QKYyMx8kCutTq
 YMj6i/E+CwL3lu6CA6pYc4yNPZVyIlrM5bJvKg0jlNMuG4VZkI8LyyTe5lMPZkmA9HfL
 EtIl+MeCL8CfVmrShh58gHKlFsD+LOUCVWXUOS3bz+UsKgCW8F9rIld2qykm6MNscK4W
 nhSFaR90J0K8qLXYPfIQr0GVkE9T4P9zTeD16oYw9OAfKyUaNCojgHqHQIZ6Ayw5pYaC
 nzTWD7AJ3AUpLU2as40w+a6x9faLEtRPPQW8lQxgjPzJjzopuHP83QiqU5NVqOVxevqH
 womQ==
X-Gm-Message-State: AOAM531Sq5CHSDjzKmHGAjXDnPPQpPEXohT13CMScLHO0ahl9IokDokv
 zOaomREgyRTGotLe2uNARgpgye8GMPIEH2VW2/ORgN/Q
X-Google-Smtp-Source: ABdhPJwfyQpsqxUaEElumhPFXrx6cdCFw8zBgmWH2s0tRfUVjMge+QzrTyTkv7I51KhXLg0PFPYZjPQhhemAYoXkwls=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr3239097otd.200.1632800680053; 
 Mon, 27 Sep 2021 20:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
 <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEw-YnoeJbt3_JQ6v81YWV6Lc3ao7eh8dNA0+aS8p7mWBw@mail.gmail.com>
 <20210928025916.GA389836@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210928025916.GA389836@dhcp-10-100-145-180.wdc.com>
From: Steven Seungcheol Lee <sc108.lee@gmail.com>
Date: Tue, 28 Sep 2021 12:44:30 +0900
Message-ID: <CAGrZSExsxVcPaqpo-bh+Bekb+dxvQf8rNFMXxX7-9_+f7DYECQ@mail.gmail.com>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_204440_972231_865EA968 
X-CRM114-Status: UNSURE (   7.94  )
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

That means leave other elements and fix lbf only?

The changes for lbaf, lbafe happens.
so I thought same structure should be updated as same version of spec.

If not recommanded, I wll change as below.

id_ns
mssrl, mcl, msrc => remove
rsvd area -> lbaf[64]

id_zns
rrl1~3, frl1~3 => remove
rsvd area -> lbafe[64]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
