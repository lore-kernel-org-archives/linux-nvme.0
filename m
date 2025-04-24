Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D9C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tBTch0mUBfQE0wXX/N+rKi/2rwruRH9bP1AegdyJQUQ=; b=nYVExXlr++M239oMz+P4bLFxc3
	E6g9JpRyc0sUBFxHq9M1jB97aBQYzqbLiEFlpReqMiYLkmnT4kNk1e+IzDFjbWwP/gUgnDoY610fx
	cEMA1sbYWECKl6FFX15bD05NyHd6QR0fr1FNQjGa+4N0P0UbHhPyT/ROjVU1rvjsDj1d0c7Pyqqca
	nQSL3hgGikwXc66UcwyMPCxUDg1r8QYSaxwJGg/pggzZSpPLtyX7nMyk+iEDkhepG3jiN95/6O/w0
	RtAxmnT4axbDtHlEYGQj5+JwfCV3XrUwdkhfHVz8/Krc1PgIO9p9nD1TGndvUiyvHkNRTDG14kVRL
	SIArKs5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wxc-0000000EFjl-1RV7;
	Thu, 24 Apr 2025 13:49:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7w6c-0000000E6fP-0xjS
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745499304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tBTch0mUBfQE0wXX/N+rKi/2rwruRH9bP1AegdyJQUQ=;
	b=Yxu4N5yLN0Jx0CAzO7pc1fyh4wVdoI5F8b/CoMTs8qhITVsEP6MzYA7RWJu0BSdkma5x3L
	843o8wx84ZYN5/92kf4Uji0W0YcTgnaODYw2fAakLYBoHE1Zsu8g+PN8ka907F7pc57MUw
	R1MAy2F7rtu39/94lliQ+99WpY7Nf3M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-FtSBV1FnPm-Ao8w68MX3Pg-1; Thu, 24 Apr 2025 08:53:33 -0400
X-MC-Unique: FtSBV1FnPm-Ao8w68MX3Pg-1
X-Mimecast-MFC-AGG-ID: FtSBV1FnPm-Ao8w68MX3Pg_1745499212
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c0c56a73aso5059851fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 05:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499210; x=1746104010;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBTch0mUBfQE0wXX/N+rKi/2rwruRH9bP1AegdyJQUQ=;
        b=dz2qH0Gc8oDeISmVgZM97+jUqj6GjH8sMXaortM+Zbl3N0qbLR2VW+CzP3AcLIo86H
         jMCjNuaMwaKgwabgJZFNYy0qhW3Kx2D/0VRL4Zav5D/F+4cMl/dljnNbCvi1STewbICZ
         Se189EWRjGFk1u0qL5IeFbpFO25ph4j4JZYtT8lnScbtIMpo6DnJ7GaZ01oRFBVhRz6W
         zyeoEOCv7OQEaCF8CiKZedEBSXvZYdcR1kjK50Xm15Qndo/a6cwsUYL/74zo5+g//RcL
         BBWr5kbCSf8gYPn4lM5yD8cNW3AYM9MOggOz1RJxZgfJNp+PZdSd2kxUZyUHSB7yHGpB
         hQzQ==
X-Gm-Message-State: AOJu0Yz5HKHcpUMDfpal9TaDC+v9+BR0gqCRZ0oH1RLbLpnQTuyExgHs
	czt5jUHRQQD3jgIAYOtF/iS5idYlnW2IDqAh2+aV0Mb2rzBwMO1Dj8Gf/Hs8qWWR3PY17GQuLld
	oz+eXoE3B6ecqwul0TUvkNo9LhuHST7o9DGZn1sqKrdbezsF0jrBnSk75wwRGDxF9v01EbQbQFv
	xmnFlM3B3Eel4qDuCZY863AWA5eWQwpt0HGDaT0r402+/4oxPHbg==
X-Gm-Gg: ASbGnct2/8PTgTZuhQYn2EkjeFd2M9hONhPCBzZNNtbyw8hq0eBtHURHNlkZ6cNu02+
	Mw1hM4FvDdqY1WfH0OeFhmjzJHuJSODCrj5pTaRuTNfM0UCbwHObER+AZ5TUzMQBNSx4b6w==
X-Received: by 2002:a2e:bc24:0:b0:30b:9813:b002 with SMTP id 38308e7fff4ca-3179feb95bamr9349041fa.30.1745499210124;
        Thu, 24 Apr 2025 05:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTtyGf2AgIlwxXir7aqold6XAiqWkcL3HgFk5UxRb88VWVLubx5pY1qKBx0lVklO7gY6VR9iQNEmdhalDOqoU=
X-Received: by 2002:a2e:bc24:0:b0:30b:9813:b002 with SMTP id
 38308e7fff4ca-3179feb95bamr9348961fa.30.1745499209663; Thu, 24 Apr 2025
 05:53:29 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 24 Apr 2025 20:53:16 +0800
X-Gm-Features: ATxdqUH85zk1Ep5sllP-3bcP17a3S2qg2rUf6dlLU1ZkfkdZcPxU4qLFCL-_Xa0
Message-ID: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
Subject: [bug report] nvme_auth: kmemleak observed with blktests nvme/tcp nvme/062
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fTz9UZx4jKOj5ZvWluz_mthumm9J7tb7VgurIRqsU_w_1745499212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_055506_345514_46B592AD 
X-CRM114-Status: UNSURE (   6.95  )
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

Hi
I found this kmemleak when running the blktests on the latest
linux-block/for-next, please help check it and let me know if you need
any test/info for it, thanks.

# nvme_trtype=tcp ./check nvme/063
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure
concatenation)
    runtime  8.748s  ...
WARNING: Test did not clean up tcp device: nvme6
WARNING: Test did not clean up port: 0
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove
'/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
not empty
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure
concatenation) [failed]3-51e60b8de349
    runtime  8.748s  ...
8.261srnel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349':
Device or resource busy
    --- tests/nvme/063.out 2025-04-20 21:27:21.084101153 -0400
    +++ /root/blktests/results/nodev_tr_tcp/nvme/063.out.bad
2025-04-24 08:47:10.951187723 -0400
    @@ -3,5 +3,4 @@
     Reset controller
     disconnected 1 controller(s)
     Test secure concatenation with SHA384
    -disconnected 1 controller(s)
    -Test complete
    +WARNING: connection is not encrypted
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove
'/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
not empty
WARNING: Test did not clean up host:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
rmdir: failed to remove
'/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349':
Device or resource busy

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8964e25a4180 (size 32):
  comm "kworker/13:1H", pid 576, jiffies 4295435801
  hex dump (first 32 bytes):
    f1 c3 44 62 7d b7 12 57 34 f6 0d 61 33 f6 d0 63  ..Db}..W4..a3..c
    5d 27 ff 34 d4 2f da 08 04 9c 32 f2 e4 fe 4f a6  ]'.4./....2...O.
  backtrace (crc 6e2b0dcd):
    __kmalloc_noprof+0x379/0x4a0
    nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
    nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
    nvmet_auth_reply+0x39d/0x3b0 [nvmet]
    nvmet_execute_auth_send+0x488/0x550 [nvmet]
    0xffffffffc07f04f1
    process_one_work+0x25b/0x6b0
    worker_thread+0x19a/0x350
    kthread+0x11b/0x260
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff896560245800 (size 32):
  comm "kworker/0:1H", pid 560, jiffies 4295437983
  hex dump (first 32 bytes):
    22 92 b5 6a 0c 4c ab 38 fa 6a c4 f7 32 91 ff 4f  "..j.L.8.j..2..O
    b2 e8 ab 92 52 c8 99 fe c8 f0 1d 53 cb b8 3d ff  ....R......S..=.
  backtrace (crc 2f0a5d3c):
    __kmalloc_noprof+0x379/0x4a0
    nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
    nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
    nvmet_auth_reply+0x39d/0x3b0 [nvmet]
    nvmet_execute_auth_send+0x488/0x550 [nvmet]
    0xffffffffc07f04f1
    process_one_work+0x25b/0x6b0
    worker_thread+0x19a/0x350
    kthread+0x11b/0x260
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8965c134e300 (size 64):
  comm "kworker/6:2H", pid 2766, jiffies 4295441704
  hex dump (first 32 bytes):
    bb 40 af 2e cc 9b c9 cf b6 a9 f1 c8 63 12 be 3e  .@..........c..>
    82 75 8f b0 c1 af 3d ef 9b 5e 88 2e c1 ac 0f 85  .u....=..^......
  backtrace (crc ac0b7882):
    __kmalloc_noprof+0x379/0x4a0
    nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
    nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
    nvmet_auth_reply+0x39d/0x3b0 [nvmet]
    nvmet_execute_auth_send+0x488/0x550 [nvmet]
    0xffffffffc07f04f1
    process_one_work+0x25b/0x6b0
    worker_thread+0x19a/0x350
    kthread+0x11b/0x260
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1a/0x30


(gdb) l *(nvme_auth_derive_tls_psk+0x180)
0x13a0 is in nvme_auth_derive_tls_psk (drivers/nvme/common/auth.c:789).
784 put_unaligned_be16(psk_len, info);
785 memcpy(info + 2, psk_prefix, strlen(psk_prefix));
786 sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
787
788 tls_key = kzalloc(psk_len, GFP_KERNEL);
789 if (!tls_key) {
790 ret = -ENOMEM;
791 goto out_free_info;
792 }
793 ret = hkdf_expand(hmac_tfm, info, info_len, tls_key, psk_len);



-- 
Best Regards,
  Yi Zhang


