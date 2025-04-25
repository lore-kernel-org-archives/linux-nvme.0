Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58281C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t7weJAFTzAcl+XkUvScOznHeB0WhY2s10TYoaORjnhg=; b=pE/cwvMUhY1Kr+dDVk2h9u/6ef
	fB5f3GkJkQvqEAkKxWRjyRImHwlsKUsogZrWC9pwpdnTiY69gzYQTYGpw7ZheLjsr/8hgF1syU8Ix
	3I7bqBiSwPqkhth3rLE+fXovV0g3ujJfAerdMaRml5sh/4uQuyNXoPbXRxp3c5M7ayo4cMWmjkINg
	77RyZHeNYM5ivxGicwg2QWEcvbMAzyVA6Yxn4pmnx0YAkJYH5dq/+DdoJcKIXwVUMq2ZHtPFol9yi
	lY+3BDQlALoUP4lgHGyDAyD2U9A2UxkgwVZeCdpUOlb6ICjecnX1P2UjgUY9b9AC+WYl3254UcBPD
	9ohFLk9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DX3-0000000GC9o-2l6q;
	Fri, 25 Apr 2025 07:31:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DX0-0000000GC8n-3DP9
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 07:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745566289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7weJAFTzAcl+XkUvScOznHeB0WhY2s10TYoaORjnhg=;
	b=LxlpH+S6oAnmtVu6vOXVC42VFRSp702AhINvDuJ/+bzPF1L/P0NokXWyYKhfbph6cVqYca
	7v3Iz9kgZ0Bk5ZdJ86rUDdWTyxevmmSz8zBoTPKY6YA46M9pwr8Lby6hR3WVjVvd2+CLY5
	8bQ0UW8cfSNT5Bu+7ZrYcmdoJcPjZKA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-zYFCXH6kMBKaSX6PRA2rBw-1; Fri, 25 Apr 2025 03:31:27 -0400
X-MC-Unique: zYFCXH6kMBKaSX6PRA2rBw-1
X-Mimecast-MFC-AGG-ID: zYFCXH6kMBKaSX6PRA2rBw_1745566286
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bf647866aso10656241fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 00:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566283; x=1746171083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7weJAFTzAcl+XkUvScOznHeB0WhY2s10TYoaORjnhg=;
        b=Ax2CQNn1ILf8y+dLMYTgwwyvGZvAzCeh1yOOehBgD5vW7fmxIgru4QAteGNtttl4Xq
         R6FecArffNIP4EhOGNpYhjFYfbbvHzWoDdBkgPeLddKwNypMcuax6TIS5sZR6mVVb6e8
         ewZk0/w8pzbJ0LaQGkKAXlgd1HKWydsgKZkrghD2ahX1VGhx/brDSK3XaKqbWcpomBZ6
         9kfr/5QLd1KW0KbLS8bQyLwBH+vP01Ca/q8dgot2SbeiKWlKDeN+BKi8W5MLtNq4NSAH
         BXDU/IxVWgiJN7+0c1V9kTgPD7oOzBVtyXeNYGIez0mJnScHcS/yfYjscFKaWJoKtzQc
         abFg==
X-Gm-Message-State: AOJu0Yx9Mf0QkqsuKy52Enb7XG+CDZm0bJF5T6m70G/cQnfnrKHryF6z
	aoalPQ4qLEC1pvFWdtgmr8GeV6lO4uljOjAnXTvtPTmsLWoXDcUpDDltRUkm2hqCAdZqA9g86iK
	Tb98yKe56Ct9G51aTsgQx7UOqug5N4jbLm7kIDF2HDOyFVnuvq+Nc5Gpdjgl/BuJSm4UAnaRDEF
	qSHQzZlaao+Oq6ljSX6Y0oc1FFArT+GhDMJJSXHU4=
X-Gm-Gg: ASbGncsnR+tiof+C/XO2UN5Y7oYGIVfrXRML1lfkCgxJrsq/ofd9r253GQkcmV4VaZF
	+JCOw5szijRNIQntCZf6gfKnZwxvyqmg9VH0bpU6RHQV4yttZbWJJM8QGPWJeknDiSst/eA==
X-Received: by 2002:a05:6512:68f:b0:549:903a:1bf with SMTP id 2adb3069b0e04-54e8cc0c1f1mr294767e87.48.1745566282704;
        Fri, 25 Apr 2025 00:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErG3/199nmgqzj7f3WRTibSb+1GbRktKCg2yKcDrGrNV5Mciu/+eoii4v0v+7+AIbN5ej8fJD78hfzCDCtdfQ=
X-Received: by 2002:a05:6512:68f:b0:549:903a:1bf with SMTP id
 2adb3069b0e04-54e8cc0c1f1mr294759e87.48.1745566282291; Fri, 25 Apr 2025
 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
 <e5691965-230f-46b6-a431-fbadee837a30@suse.de>
In-Reply-To: <e5691965-230f-46b6-a431-fbadee837a30@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 25 Apr 2025 15:31:10 +0800
X-Gm-Features: ATxdqUGHDO-pBKOoBNSdR9cNRCEFnG0V7oYCXw4YDy2wXtWG_5VYny8NUky7wdw
Message-ID: <CAHj4cs82R6ZRC+ipr6q0X4sSk18o=MjZnK_PSOrN9z0HsdL_1g@mail.gmail.com>
Subject: Re: [bug report] nvme_auth: kmemleak observed with blktests nvme/tcp nvme/062
To: Hannes Reinecke <hare@suse.de>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, hare@kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aCvYSeY0J6HTFfMslyUYes0jmm1Qa8u66W8rmqqOA4Y_1745566286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_003130_882733_D322413E 
X-CRM114-Status: GOOD (  23.88  )
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

On Thu, Apr 24, 2025 at 9:38=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/24/25 14:53, Yi Zhang wrote:
> > Hi
> > I found this kmemleak when running the blktests on the latest
> > linux-block/for-next, please help check it and let me know if you need
> > any test/info for it, thanks.
> >
> > # nvme_trtype=3Dtcp ./check nvme/063
> > nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure
> > concatenation)
> >      runtime  8.748s  ...
> > WARNING: Test did not clean up tcp device: nvme6
> > WARNING: Test did not clean up port: 0
> > WARNING: Test did not clean up subsystem: blktests-subsystem-1
> > rmdir: failed to remove
> > '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
> > not empty
> > nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure
> > concatenation) [failed]3-51e60b8de349
> >      runtime  8.748s  ...
> > 8.261srnel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42=
-9f7f-4856-b0b3-51e60b8de349':
> > Device or resource busy
> >      --- tests/nvme/063.out 2025-04-20 21:27:21.084101153 -0400
> >      +++ /root/blktests/results/nodev_tr_tcp/nvme/063.out.bad
> > 2025-04-24 08:47:10.951187723 -0400
> >      @@ -3,5 +3,4 @@
> >       Reset controller
> >       disconnected 1 controller(s)
> >       Test secure concatenation with SHA384
> >      -disconnected 1 controller(s)
> >      -Test complete
> >      +WARNING: connection is not encrypted
> > WARNING: Test did not clean up subsystem: blktests-subsystem-1
> > rmdir: failed to remove
> > '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
> > not empty
> > WARNING: Test did not clean up host:
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > rmdir: failed to remove
> > '/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb=
42-9f7f-4856-b0b3-51e60b8de349':
> > Device or resource busy
> >
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff8964e25a4180 (size 32):
> >    comm "kworker/13:1H", pid 576, jiffies 4295435801
> >    hex dump (first 32 bytes):
> >      f1 c3 44 62 7d b7 12 57 34 f6 0d 61 33 f6 d0 63  ..Db}..W4..a3..c
> >      5d 27 ff 34 d4 2f da 08 04 9c 32 f2 e4 fe 4f a6  ]'.4./....2...O.
> >    backtrace (crc 6e2b0dcd):
> >      __kmalloc_noprof+0x379/0x4a0
> >      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
> >      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
> >      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
> >      nvmet_execute_auth_send+0x488/0x550 [nvmet]
> >      0xffffffffc07f04f1
> >      process_one_work+0x25b/0x6b0
> >      worker_thread+0x19a/0x350
> >      kthread+0x11b/0x260
> >      ret_from_fork+0x30/0x50
> >      ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xffff896560245800 (size 32):
> >    comm "kworker/0:1H", pid 560, jiffies 4295437983
> >    hex dump (first 32 bytes):
> >      22 92 b5 6a 0c 4c ab 38 fa 6a c4 f7 32 91 ff 4f  "..j.L.8.j..2..O
> >      b2 e8 ab 92 52 c8 99 fe c8 f0 1d 53 cb b8 3d ff  ....R......S..=3D=
.
> >    backtrace (crc 2f0a5d3c):
> >      __kmalloc_noprof+0x379/0x4a0
> >      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
> >      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
> >      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
> >      nvmet_execute_auth_send+0x488/0x550 [nvmet]
> >      0xffffffffc07f04f1
> >      process_one_work+0x25b/0x6b0
> >      worker_thread+0x19a/0x350
> >      kthread+0x11b/0x260
> >      ret_from_fork+0x30/0x50
> >      ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xffff8965c134e300 (size 64):
> >    comm "kworker/6:2H", pid 2766, jiffies 4295441704
> >    hex dump (first 32 bytes):
> >      bb 40 af 2e cc 9b c9 cf b6 a9 f1 c8 63 12 be 3e  .@..........c..>
> >      82 75 8f b0 c1 af 3d ef 9b 5e 88 2e c1 ac 0f 85  .u....=3D..^.....=
.
> >    backtrace (crc ac0b7882):
> >      __kmalloc_noprof+0x379/0x4a0
> >      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
> >      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
> >      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
> >      nvmet_execute_auth_send+0x488/0x550 [nvmet]
> >      0xffffffffc07f04f1
> >      process_one_work+0x25b/0x6b0
> >      worker_thread+0x19a/0x350
> >      kthread+0x11b/0x260
> >      ret_from_fork+0x30/0x50
> >      ret_from_fork_asm+0x1a/0x30
> >
> >
> > (gdb) l *(nvme_auth_derive_tls_psk+0x180)
> > 0x13a0 is in nvme_auth_derive_tls_psk (drivers/nvme/common/auth.c:789).
> > 784 put_unaligned_be16(psk_len, info);
> > 785 memcpy(info + 2, psk_prefix, strlen(psk_prefix));
> > 786 sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_dige=
st);
> > 787
> > 788 tls_key =3D kzalloc(psk_len, GFP_KERNEL);
> > 789 if (!tls_key) {
> > 790 ret =3D -ENOMEM;
> > 791 goto out_free_info;
> > 792 }
> > 793 ret =3D hkdf_expand(hmac_tfm, info, info_len, tls_key, psk_len);
> >
> >
> >
> Can you try this patch?

Hi Hannes

The kmemleak still can be reproduced with the change.
I also tried the change below provided by Maurizio today, and it fixed
the kmemleak.

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index cef8d77f477b..fd167fc9bad4 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -606,7 +606,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
                key_put(sq->ctrl->tls_key);
        sq->ctrl->tls_key =3D tls_key;
 #endif
-
+       kfree_sensitive(tls_psk);
 out_free_digest:
        kfree_sensitive(digest);
 out_free_psk:



>
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index e7d82bc32f41..1ed606892a8a 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -669,6 +669,8 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
>          if (sq->ctrl->tls_key)
>                  key_put(sq->ctrl->tls_key);
>          sq->ctrl->tls_key =3D tls_key;
> +#else
> +       kfree_sensitive(tls_psk);
>   #endif
>
>   out_free_digest:
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


--=20
Best Regards,
  Yi Zhang


