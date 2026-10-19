Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AE606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=G9RErJaV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VpIx09my
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4414CCF2E6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHOolWs+HrDZTYIj1HgXgSZZtVsYtKQLKIFtAPPddUM=; b=G9RErJaVH+gMQSP1DFWPcVmgBF
	5NVW0sAV9dx6RO9zcFHnPUdaoA+e8d1wIw92WWhDqZCxa+XbVGvaWaaQ4ISbSqNIOhXzAqA86zD1m
	D7kRJgSvDwhPFIB19cGHD+EbUukUCAyEKHHxlhVn9v36BEKoMFk74ouDr3zNOZ20VJNocdukcz1oI
	JP03pAplvCeN3O3lDPZlGxS0xEbOVGRm+zM2jw91IbohLy+aYzwB66FHGxtzTg1fAqw1lldbuLr+T
	o/juF4kShiRXlXtB2cfk9OpR+fkFZU/ZxTgJE68fNO9s2wp/uDQRR15LERjY2p4bCICYPfgRdo3f0
	QJ6fPl0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIodl-00000007mIe-1K4k;
	Mon, 19 Oct 2026 14:47:05 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIodj-00000007mIJ-0qN9
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:47:04 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4659331eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421222; x=1793026022; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rHOolWs+HrDZTYIj1HgXgSZZtVsYtKQLKIFtAPPddUM=;
        b=VpIx09myvoVpLpGq9Vq0pz77s07s0HZXhsvs91SlTmbh1crt8utZkB4bC1GU6VvvEB
         vDCGMhwqy17EDNXbB0nBXo9mxNiYxYpuZVCgHvNzF9u8+fucqBtCytrFOV8IUkvYqE1W
         v71rCpsJ2w3dhf/pYJUO0xNkUcSlMc+iwGiwEA0GAKSSJ6rqWP1KGM7YcgP+FE86eEDj
         avRRxl017bandlruXc9N9jFQ9rR6Xx6jJ/e7GVv2r8Zc1vSt6g6Po/zulZyDptch1opd
         H8ypzSKHDQwYX1iPKDDF5lwuvB9PgkdwtyRIYieEQn/YNn+rbyIJmdi1zUYXkq4kKQPo
         kCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421222; x=1793026022;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHOolWs+HrDZTYIj1HgXgSZZtVsYtKQLKIFtAPPddUM=;
        b=gsnrakbLXlKdsBgRfFFMd89yxTFf5+rWVW5m8ORSAqNA6BkaIwrIXgdSPkemR/9d40
         /DM6bZMWMMHrWyZxLEE1EBowlpSQRZOkyKSfGwTL/YcA/dAnG9I4YNfj5RnfMEM+j3zm
         9qtB4OVWmCWGY7NZPZZgekHSLrg8wa0IFVX4/gbOatc1Yfa2GbGy8FflmFXK1xV0pnwC
         wJrjB4KHh0jSj9i16Z6pVj5VLLYFkuV5pkAEfFU2Kv9Ha59zfcjS2J05wRL6Re3D75lY
         nliljO50Y/PjxVO/wl1P1mbyl8rm8umlldwEGoUtxia4xHpbLbJWHhLn0a6qixTqZBl6
         aYgw==
X-Gm-Message-State: AFq9FYJT0vPt4i6Ly9tJOEIdTtszZT9fGYiHCY9NxVNAZKETzXxuxlZm
	TGETO7Oo04AcnqPPl/2yWn8feDSE/eZMBIO/LR1tlUD2TOwJ+w111/edgUxkJ63r
X-Gm-Gg: AYBFou38doB2b/qg0ENoppKteYlpOvVMnuCTM0NtM1gvprUxHJUhaECY0oPjzrIxCJQ
	549j5fwHrczS7MYiSRdDyoB9n80uMFtMLCSUWQ0Ru7RFrXSJ3jCq9L/cKEoHPhRkNXD3RwcRBjO
	THNeP/ddh50PlxBamyGNnhvfBVDjJ5Wo5mge9ZZlI+XtTECTUEmnsfjRDNMvHM9T+YpOYetkAjj
	U7wMMV/NXu9E7kI2OxtD7lX5EEhKNE1cvGAgFrGzljcp7g03m1GDjoyPWVM30tuF7xQYmdrQzxl
	QePA1TUwDEB0H+H92hdgT2K2jbJkv4hVHnS5Vt5ebUy/11RI2wmT4UWBu+pFObZtLj8eiKfnyty
	FojOpTbzzSAe+bG3OeuTFuuWOUDMvnsvxFAo8Dln6+GFdeZh6KEECqHTKJP3BBmpfVXkac1jAsL
	VuQLmMm3I/alqEqF/aGbh+4SKUW3P+ArouNOBctB3tzzuCjMJYkOaWaFBBLVoxctznxSWlRnhWd
	Lf0dDoI7va+FBHz
X-Received: by 2002:a05:7022:5f04:b0:149:1feb:6dae with SMTP id a92af1059eb24-18513b9ac38mr9541041c88.39.1792421221518;
        Mon, 19 Oct 2026 07:47:01 -0700 (PDT)
Received: from [10.0.2.15] ([136.226.252.185])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm34263642c88.0.2026.10.19.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:47:00 -0700 (PDT)
Message-ID: <1af1ff8db7803c1b8f8e656eebe249cbe5e622b4.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
From: Martin George <martinus.gpy@gmail.com>
To: Laurence Oberman <loberman@redhat.com>, Guixin Liu
 <kanie@linux.alibaba.com>,  sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Date: Mon, 19 Oct 2026 20:16:57 +0530
In-Reply-To: <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
	 <20261019075607.808947-4-kanie@linux.alibaba.com>
	 <sashiko-outbox-176783@kernel.org>
	 <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
	 <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
	 <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_074703_255938_EAB416FA 
X-CRM114-Status: GOOD (  15.66  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-19 at 08:43 -0400, Laurence Oberman wrote:
> On Mon, 2026-10-19 at 17:43 +0530, Martin George wrote:
> > On Mon, 2026-10-19 at 19:13 +0800, Guixin Liu wrote:
> > > >=20
> > > > Should "service-time" also be added to the accepted values for
> > > > /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
> > > >=20
> > > > =D9=87=D8=A7=DB=8C=DB=8C
> > > Sure, changed in v3.
> >=20
> > Not just /sys/class/nvme-subsystem/nvme-subsysX/iopolicy, but this
> > should be added to the accepted values in /sys/class/nvme-
> > subsystem/nvme-subsysX/iopolicies as well.
> >=20
> > -Martin
> Hello
>=20
> There should be no changes needed for my original iopolicies patch=C2=A0
>=20
> iopolicies_show() walks ARRAY_SIZE(nvme_iopolicy_names), so whoever
> adds a service-time policy adds its enum value and its string to
> nvme_iopolicy_names[] as part of that work. The new name then shows
> up
> in iopolicies automatically. The existing iopolicy store path already
> matches against the same array, so both attributes stay in sync
> without
> code changes
>=20

I meant adding to the iopolicies documentation here.

-Martin

