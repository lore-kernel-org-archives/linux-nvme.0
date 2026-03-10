Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B03FD4F1F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQNW4sKcGRyxKdmwCuNUFWDhu/bvjP+pzJMuARjecvM=; b=dVBBvN2anKTU31293pEKc14lnK
	nGEP3FsXK+dKsJqqAB+a+0I6pR/Gm7giUOYWyvmE9bAjGc86XcIxcpua1D3bk9ozTlJVegw+JqSRP
	aUcBCVvVMWya03e06IBL8RffYLC1lQ8GbIwrdlWcb+y9zIRU3LctKQt/OGDkj9TXYwD03Lya5Slv3
	VidB82M4jv/c/1xVQB2vRqRI1sJRIWP7fUV7BKkDBAA4pcx7qLkGgAILueXcNk7+EA0Zl+X1438CO
	UzM/a+Nk8tGnSQWShqBCvJx/l7bmGJAWSQjcf/YKMdA4W2cOvYVzwSuB4U2HdrA0/xkB3u8k/93xe
	3p3ngBFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w02Pz-0000000A8tn-0v24;
	Tue, 10 Mar 2026 19:06:59 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w02Pw-0000000A8tQ-2XEH
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 19:06:57 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so4114245a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 12:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169615; cv=none;
        d=google.com; s=arc-20240605;
        b=hrn49BDPpTQiCjjFgCsT3Zjr7SEaTVHv/jOqdZk4FEpXonFIvBunCzjxjyu/pA/X/4
         CBfMJAxsTUAqnN2dh3f3kjImhv7bvRqpwWADjhZoKQmxxy4t6qxbIxrzagFRADUwX3kt
         WmOLcWzfGGLTT2WPJoMp0QCWMilYjcSCSip8STgOK5mozn6TVgmBSz40SmKDp0ClKB0X
         8hKUMo0pM9+24/HTwpD3T4Qj31IAUOkNW5YSHlAySeASsF1JmOWmguecHChRh7rBn3JA
         v/2v5WZN4/DoeBA6EhagbnSUJRUWx+HMJC8bBa2Fl+FF8RwR5AU6zhTKAhGpPn7raiH2
         r6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hQNW4sKcGRyxKdmwCuNUFWDhu/bvjP+pzJMuARjecvM=;
        fh=wpC/EzNELjOJxsqCzY1mgo2ePubliD+0WAQ3Wj+2cU4=;
        b=iFrm9/Xjg/CoVlnc+DYCmlwu4LwGyHDzNR8guoIFZ4cTd+kil8eWTCe9GeN7NtJ58q
         YxwK5n2z78cHmJTUGuAu9LCvAdfiBU9Cv8TKdjcqIHWqt9qyYUx7L+9km3C/V5ekRIOz
         8sgmzPCK7Nxt9u1YyPTV7K3QFg0HGT+Tyko9VnNiQiPLvaAQGA0bJkJrEpFcgM4GvI21
         lVLD7eBoRzM9Dd2DlsbTESNaFQdLX/CBhZKwf4b8AEwzygmLyKSoUGAqfivsdJWRLXN+
         ESlJ2r7pD827ruOMrgHyEBIYSU05WP81oC3zZfgNmjl/zlnTTc0vmqIw1/kKolt2A0XP
         K1hA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773169615; x=1773774415; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQNW4sKcGRyxKdmwCuNUFWDhu/bvjP+pzJMuARjecvM=;
        b=ZDN0qxcWY7Gfv2keGNcSJelqy+SSKQ2wIL2EDC/iBuHMo4hlnrvpokiiVB7UBlmjDE
         h3NGNlTUIb/Q1+fam8XniExAl0eMFb+RkCGMY3yfgYEb7OM0ihLL9R+cWCYTqATyQT8C
         TkH3Wf0sCxkxe0fjWk9+2zY5qkxnyeX0i2nHYJgum9QkdpeokapvCXyOARydXSaaGvaE
         0Z8+FU9Jfw/M+adFSEVIPL4ZsUEiZdeqpXExNUKTqAz2TJWBH/jABHqWveiqBX6l3X00
         MZreHhHQAoS48YAT0937/wDsbjTiR250rlEJJynGRaxp/6RmaBzI4mODPGzKbXzjOS1+
         4a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773169615; x=1773774415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQNW4sKcGRyxKdmwCuNUFWDhu/bvjP+pzJMuARjecvM=;
        b=rUUo+/Z/J4UOPd6QeE+tqBPWCjaiXf4sVOfDwKuiJ3RgLMd89hIXgWIAMBa7OveH5B
         kEox9WvtwT1/B5DRLqxD82i+ih10mZ3nsmM3HsGirwYSSf5iB0FAGDZb56v7scE1zcfu
         Tuz6MpmHXQVAdmSCMjgbo3qM4upT5nkIF+jXjXVa4FG1bHMs9DHvMrpL5KshSLV2Ukh7
         +lAVDd8x05jahvzh04j3TACbDBjrmjKqaBJ1hZSut8QGemHAhMZJyXsvqda4lM6u3KN8
         iGyrLjObA6cj0Knwk0vhrD5rht6FHK+p2AZ2Y6FOCo89eJxBFCfXC16UcSHa+wc/WoG1
         ka/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZTiVc1eY3qRcLvE1ydJ7qBsaRsMDqJhFwc4cGfK/whv/2yiJoj87yGKe3MGuO34Qln5FfmPYIPIXj@lists.infradead.org
X-Gm-Message-State: AOJu0YwV3E/HVpFc5inHqddLmZblwIdXh8WheGgd5CNDQxOaWZPenjia
	dUdwhLJ2UqES9caR4/5mKCJTpcZNAOF+liGUst5yCI+RVXk42uo3RixZDhsrBAsVcuYBlyVOlLQ
	VT8U80rCFEs6S3UBLDaImfL/CDmNkLFo=
X-Gm-Gg: ATEYQzxaj6yU6F5tKvyRuBeX7ZWg6bbO8ymJ9FZyQmUpuRCwVAxUFQ00w7Dy+spPO6q
	xwVQMNkIaTZHtydhuPVoQ4VQGCaVqc5/cOX1K7o9kZd0eyo79uQfTG3KsSqyeSePwzR734tAscr
	Ql8nA7FnebsMAgAPynNd5SBvzi+KtFHfjPOht2ht5yaqz+bwgV7HwINjMYVZDDwLta3EHVrm9O9
	2Rg0qaudm7PTIDaMdXZ2i33t3pmJI4RdMKNLlzOM5MMvp8pBfjHvxfyxjWYfvInrlgPMxTUW/VX
	XMkg3sg=
X-Received: by 2002:a05:6a21:b89:b0:398:bcee:4519 with SMTP id
 adf61e73a8af0-398bcee4bddmr1135869637.41.1773169615418; Tue, 10 Mar 2026
 12:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
 <20260309-scalding-propeller-e00bf0af6519@redhat.com> <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
 <CAMX6_QG_Xx=1shB+76GKdMyB3-JW9nRiC+1vik=382FyFCT9cg@mail.gmail.com> <20260310-ladle-underuse-50f571ba519c@redhat.com>
In-Reply-To: <20260310-ladle-underuse-50f571ba519c@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 11 Mar 2026 04:06:44 +0900
X-Gm-Features: AaiRm522XOYbR7Y2MI-LKYV4iPif4j511Uf9jTIdsKNOLWcoT5tC-5t_exNug9k
Message-ID: <CAMX6_QE64ttVQ03CQP4ULECePiTwooy6OfqUk4_biz+_s=vpbA@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_120656_672449_49A18E0C 
X-CRM114-Status: GOOD (  28.83  )
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

Thank you for the clarification regarding the 64-byte structural
constraints. If this approach looks good to you, I will format it
properly with an updated commit message and send out a formal v2
patch.

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..acba4878a873 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -72,6 +72,14 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
*req, void *d)
      NVME_AUTH_DHCHAP_AUTH_ID)
  return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

+ /*
+ * idlist[0..29]: hash IDs
+ * idlist[30..59]: DH group IDs
+ */
+ if (data->auth_protocol[0].dhchap.halen > NVME_AUTH_DHCHAP_MAX_HASH_IDS |=
|
+     data->auth_protocol[0].dhchap.dhlen > NVME_AUTH_DHCHAP_MAX_DH_IDS)
+ return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
  for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i++) {
  u8 host_hmac_id =3D data->auth_protocol[0].dhchap.idlist[i];

@@ -97,7 +105,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
*req, void *d)
  dhgid =3D -1;
  fallback_dhgid =3D -1;
  for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
- int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i + 30];
+ int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i +
NVME_AUTH_DHCHAP_MAX_HASH_IDS];

  if (tmp_dhgid !=3D ctrl->dh_gid) {
  dhgid =3D tmp_dhgid;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b09dcaf5bcbc..ea0393ab16fc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1824,6 +1824,8 @@ struct nvmf_auth_dhchap_protocol_descriptor {
  __u8 dhlen;
  __u8 idlist[60];
 };
+#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
+#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30

 enum {
  NVME_AUTH_DHCHAP_AUTH_ID =3D 0x01,
--=20
2.43.0

Thanks
Yunje Shin.

On Wed, Mar 11, 2026 at 3:07=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Wed, Mar 11, 2026 at 02:52:36AM +0900, yunje shin wrote:
> > Thanks for the review.
> >
> > Yes, I triggered the KASAN issue by injecting an invalid dhlen The
> > reproduction steps are:
> > 1. Connect to the NVMe/TCP target on port 4420 (ICReq + Fabrics CONNECT=
).
> > 2. Send AUTH_SEND with a crafted NEGOTIATE payload where dhlen=3D200. 3=
.
> > The kernel target code in nvmet_auth_negotiate() then iterates
> >
> >     for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> >         int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i + 30];
> >
> > With dhlen=3D200, this reads idlist[30..229], but idlist[] is only 60
> > bytes (indices 0..59). The accesses at indices 60 and beyond read past
> > the kmalloc'd slab object into adjacent slab memory, which KASAN
> > catches as a slab-out-of-bounds read.
>
> Thank you, I appreciate understanding how this was triggered.
>
> > While the standard Linux NVMe host driver does use hardcoded halen=3D3
> > and dhlen=3D6, the NVMe target is network-facing and must validate all
> > fields from the wire. A malicious or non-standard host can send
> > arbitrary values. The same applies to halen =E2=80=94 if halen > 30, th=
e
> > first loop also reads out of bounds.
>
> Yes, this code absolutly should validate halen and dhlen bounds.
>
> > Regarding idlist_half =E2=80=94 yes, idlist is currently a fixed 60-byt=
e array
> > and the DH offset is always 30. I derived it from sizeof(idlist)
> > rather than hardcoding 30 so that the bounds check and the DH offset
> > stay consistent with the array definition. If the struct ever changes,
> > the validation adapts automatically instead of silently going stale.
>
> The 60-byte idlist (and 30:30 split) are part of the NVMe specification.
> It's the maximum amount of space while keeping to a 64-byte struct.
>
> I'd rather see this made clearer with a define for the limit, but not
> adding code that appears to calculate it at runtime.
>
> Thanks,
> - Chris
>

