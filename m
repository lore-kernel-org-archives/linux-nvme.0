Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3568C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 04:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vX8iwHMrFB0ufwwEjQdziKzhMP0eO8UR5UxIgDd58HQ=; b=4t3FDq7YFCawFjNy6wcfqjUrkv
	AbRciQ2Fgy6hcv20lFEs+7zW6mVmPmPKgv8dtAT3zNG1UCjR3A5OnfFRwNqVZcqZoTCRceS/D/Yk7
	CPHLzhLIDRBopsvt4UsTmDYLc7+BLGv6knauyq1G0HOagwj2A5H+vi+u6RQHo/2CF/JnzMfpsmeU7
	C3pkXshr68CRS0tu2xFUqolpP6SlJjuMKlMcz/li742bpJnEEX+ibjtKAnEHr5adESCKvG18DMjIp
	POln9Sl/rRB3KpHgpZ3gWN6G8x3lgjgmYPxkYX+qt6ug7BHESchSGLyuCHRPwXVPCDNCaKtItpCi0
	C41OcLyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rylik-0000000C1SI-3yUw;
	Mon, 22 Apr 2024 04:56:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rylig-0000000C1QN-1B6r
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 04:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713761750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vX8iwHMrFB0ufwwEjQdziKzhMP0eO8UR5UxIgDd58HQ=;
	b=OgfiNdostOBzMlSLCtCPuVHGCejzgdhP8ZbzmeHEQFYzooxDBi2IRI4/MN9bjmtQ0NUS60
	kUS4FVHmnadHPTjVqN5f1xsmCRnXDQhWpDCJznGMaxT169SDg3ib/mubW0qsPCcALybyvf
	LFXMFQmzeB8mb9kElGxtKL+rLYIKo1A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-uz61ikvEP9G6DlvtUHTdsw-1; Mon, 22 Apr 2024 00:55:48 -0400
X-MC-Unique: uz61ikvEP9G6DlvtUHTdsw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2c2b0d82aso4694147a91.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 21:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713761746; x=1714366546;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX8iwHMrFB0ufwwEjQdziKzhMP0eO8UR5UxIgDd58HQ=;
        b=M8YGb39d0aqfJsUOmBPKFoJacbBrnOoJQL4EteG3G/sJTn89EOoHMETIhrT8osKBMb
         lzBiswoADrisOjk3082FONxr8FYCuonRFNRvOFQFXt6rmDtrZy1/xR3D27z0sTaH1/8E
         82cLyfJDrROnKTfNm9x3De/FPVMO4YEbZ6mB3ZcCaUMxm3SISU5UQv/qUvx8dbSmXd5u
         eWRW92dvn0Fca6T48Tb14+5MoFUPXIDO9s1YyepGIVcGW2tkUjJSbQolQ6RiJTTaSAlI
         yaNEdQT21RI4GnRvDAX+wvl3ArtPe+FR8ia0xwaWqIWRhlwxVPxvL49mF+BrsHjgp9AJ
         XwAQ==
X-Gm-Message-State: AOJu0YwQ1lLfucWHi5Lxg3haD3yazuGhYfrP3EyvldHDvnvr357V3O0j
	/9zUxOdD6hK0JrxTPie7DKCoIAKOiBSnDYrle4lTd++yPRMOf1JUSLoZHlhNp1exQVpphDvIbXu
	+awq4IFAv8ZX9h+1l5aRC25S4pqST6fQ0P7p5WknBRpcY2RfvSHtIkhhJj5WewShB/uxynFWVvy
	+sm2MP7+L+ZHOfcE/hM4iHKDh37bLIt0Awo+qQd7aDGibA8xJ7cA==
X-Received: by 2002:a17:90a:4804:b0:2a5:fff9:686e with SMTP id a4-20020a17090a480400b002a5fff9686emr5963667pjh.16.1713761745985;
        Sun, 21 Apr 2024 21:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVBOF5MHs0t3o0uJle80kpmJQgdwJF7ZmRLw2VzSuphrZjw2ylBqhkY3+o7djZtvp8F/mLHpgJ0BXGUlNshoI=
X-Received: by 2002:a17:90a:4804:b0:2a5:fff9:686e with SMTP id
 a4-20020a17090a480400b002a5fff9686emr5963660pjh.16.1713761745666; Sun, 21 Apr
 2024 21:55:45 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 22 Apr 2024 12:55:33 +0800
Message-ID: <CAHj4cs_9XT6Ky4=LTy4SZ5AVfhAUec2k52b81-OKqzsDubobmw@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp nvme/014 failed due to Read/Flush timeout
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_215558_427439_360BA3EB 
X-CRM114-Status: UNSURE (   7.89  )
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

I found nvme/014 failed[1] on one of my servers, seems it was due to
Read/Flush timeout during the test[2], I tried to add sync operation
after the dd operation[3] and the failure can be fixed now and no
timeout from dmesg, could anyone help check if it's one test issue or
nvme/tcp stack issue, thanks.

[1]
# uname -r
6.9.0-rc4+
# nvme_trtype=tcp ./check nvme/014
nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
    runtime  33.432s  ...  41.334s
    --- tests/nvme/014.out 2024-04-19 00:02:03.596691663 -0400
    +++ /root/blktests/results/nodev/nvme/014.out.bad 2024-04-22
00:10:10.042478026 -0400
    @@ -1,4 +1,4 @@
     Running nvme/014
    -NVMe Flush: success
    +NVMe status: Command Aborted By Host: The command was aborted as
a result of host action(0x371)
     disconnected 1 controller(s)
     Test complete
[2]
# dmesg
[  724.690961] run blktests nvme/014 at 2024-04-22 00:09:28
[  724.706957] loop0: detected capacity change from 0 to 2097152
[  724.715174] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  724.724103] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  724.735368] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  724.749633] nvme nvme1: creating 96 I/O queues.
[  724.757813] nvme nvme1: mapped 96/0/0 default/read/poll queues.
[  724.789035] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  758.518247] nvme nvme1: I/O tag 1 (0001) type 4 opcode 0x2 (I/O
Cmd) QID 86 timeout
[  758.525908] nvme nvme1: starting error recovery
[  758.530447] nvme nvme1: I/O tag 81 (0051) type 4 opcode 0x0 (I/O
Cmd) QID 87 timeout
[  758.538914] nvme1n1: I/O Cmd(0x2) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 / sc 0x71)
[  758.547101] I/O error, dev nvme1n1, sector 2097024 op 0x0:(READ)
flags 0x80700 phys_seg 1 prio class 0
[  758.562940] nvme nvme1: Reconnecting in 10 seconds...
[  758.568093] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  758.572165] nvme1n1: I/O Cmd(0x0) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 / sc 0x70)
[  758.582367] Buffer I/O error on dev nvme1n1, logical block 262128,
async page read
[  758.618831] nvme nvme1: Property Set error: 880, offset 0x14

[3]
diff --git a/tests/nvme/014 b/tests/nvme/014
index 839b91f..3f6a68f 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -37,7 +37,7 @@ test() {

        dd if=/dev/urandom of="/dev/${ns}" \
                count="${count}" bs="${bs}" status=none
-
+       sync
        nvme flush "/dev/${ns}"

        _nvme_disconnect_subsys

-- 
Best Regards,
  Yi Zhang


