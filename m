Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F33C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2tO0iqptS5Gq5PqrL14dLn/cuo+wsT89Ak1Y8aDy/tQ=; b=ZZTASd5JD7iJBqPEbLS2KnU9Nb
	8Y7Y9mEMGTza8j0JmauFnwzBqtsMCfavSdDcU7+GJ/vW/dRl1ZrPTOhHvNeY4AkV8mgnpXcf2EY78
	QjuYMAGZeqaTwS2Rw7e764FUu4QukFA0EnbO/IZ0TR5EOoePyOm4d4IYJsuDNL0br53WQblsEX35+
	te8JoBZj4+JV+OPVWNkrCHVYnE6xg/Lx/5qz1adJYJdHEkwSe8/OhI2UHiBqDRB6IP7B4phXk+5yO
	qYYQ0Nb2be3tsLHcMVVlFxLdagvt++FUyMFr44vp7t/fBQ1BgveNcPEgi8KXgu/hfYUWAGXyLoHyT
	IgorOHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5jpW-00000007hef-1Q6M;
	Sat, 11 May 2024 10:19:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5jpT-00000007heG-2iZX
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 10:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715422784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2tO0iqptS5Gq5PqrL14dLn/cuo+wsT89Ak1Y8aDy/tQ=;
	b=f6Z+sqxPVim1fE3cWG+d4ld8KeXwvgEZwYptaLTiMURHEDs60BLmA/o/0rEc0ezLJINKg/
	twDbFqDwfAngWHKerSmzgNDFbKTDg3Cni1WXAFnjqYHIsG8nhpzMsRXcGTDGlwo8+bxvOo
	MAh/xoSn+dU/9SoORmx9ZnmW0cyhz1E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-b5g1J8lqPtOQeXIwUTMwYA-1; Sat, 11 May 2024 06:19:33 -0400
X-MC-Unique: b5g1J8lqPtOQeXIwUTMwYA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4348fb84bso2415969a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 May 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715422769; x=1716027569;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tO0iqptS5Gq5PqrL14dLn/cuo+wsT89Ak1Y8aDy/tQ=;
        b=VSOv5hoU5DPTC6O9+r2f8M0Or+6wTTPq3O1UzXYwT8kSuFoZ//TeIX8xj/6+kAY7i5
         qE7ElOjdXQKBMreJrEAX4wZpkvl88/wHiXWWxUHDZQpSUBJ1ba2K+5FYbzRYHoRfIw1u
         BRuqHHZTv8G+wdazTM1lR6x7kJUj739jQ03I/70EVF7ELr8FGQ0kDGIB2mTgwjioaJ4Q
         DMtWBw0Mk7C+N/54yEjw26Z0nqqAwFO6TGxhwttum0WKwHmuvcoZ1pMHpje0uVDrmcXB
         wrmXKGiZaML6y+lWAnIm/wJO5vglinfPao8unhAkGLLc8RPlLll1pzet9J2y3tGc29nD
         DSzA==
X-Gm-Message-State: AOJu0YxW9mBEfjotOMt92FGZ6jj8QyS2pkEJpzNAsJfjkkVh4vBdF9vl
	yeE5WB4W4gzlWzejo+sxmXmZ7/EZ9sgfaH1+3vxTvsZlDh7C0pTAn/8qRch2v7UCoVO/WmWw07L
	JYeq3nNG57cV3Q6vpzDLupc840ympUCXzJLtJ7N4gkbYvg04XM20kM+JUgQVBdgzVEBgy6AiVrc
	3Xo/YCsxIfrdHll1nC0CS79sbanvZGN9G0Xcl1g/Ibtqtmia/gwWOy
X-Received: by 2002:a17:90b:154:b0:2b3:b97e:c09f with SMTP id 98e67ed59e1d1-2b6ccb7e590mr4512696a91.31.1715422769418;
        Sat, 11 May 2024 03:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw9HQKL6EMryqwGkA/tp3y8n/7kkB6tOZye13ixKDs0XFbXTbNWuJF5+pXW4IW0NFzCeSa9czLORejtIZ1650=
X-Received: by 2002:a17:90b:154:b0:2b3:b97e:c09f with SMTP id
 98e67ed59e1d1-2b6ccb7e590mr4512685a91.31.1715422769086; Sat, 11 May 2024
 03:19:29 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 11 May 2024 18:19:17 +0800
Message-ID: <CAHj4cs-jM_46qK2n3g9vFguq7LVBSm1h38b6Sg_j5veubontWw@mail.gmail.com>
Subject: [bug report] kmemleak observed during nvme connect with host
 authentication and invalid ctrl key(blktests nvme/044)
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_031947_810401_CE076924 
X-CRM114-Status: UNSURE (   5.03  )
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
The kmemleak was triggered from Step 4 in nvme/044, please help check
it and let me know if you need any info/test for it, thanks.

blktests: ./check nvme/044
        # Step 4: Connect with host authentication
        # and invalid ctrl key
        echo "Test invalid ctrl key (should fail)"
        invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
        _nvme_connect_subsys --dhchap-secret "${hostkey}" \
                             --dhchap-ctrl-secret "${invkey}"

        _nvme_disconnect_subsys

dmesg:
[ 1624.248073] run blktests nvme/044 at 2024-05-11 05:59:21
[ 1624.842961] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1625.165556] key crc mismatch (key 021fa81b, crc e08833d2)

kmemleak:
unreferenced object 0xffff88a89a0fa800 (size 512):
  comm "nvme", pid 21764, jiffies 4298599713
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 20 29 32 bc ff ff ff ff  ........ )2.....
  backtrace (crc 5582e1c1):
    [<00000000e6877e1c>] kmalloc_trace+0x338/0x420
    [<00000000074bbdf4>] device_add+0xb09/0x1760
    [<00000000a4cc674f>] cdev_device_add+0xf7/0x230
    [<00000000903919a1>] nvme_init_ctrl+0xc65/0x1220 [nvme_core]
    [<00000000f315c00e>]
__kstrtab_nvme_keyring_id+0x1/0xfffffffffff4b654 [nvme_keyring]
    [<00000000e20dd92c>] 0xffffffffc1d3c760
    [<0000000077b20bbe>] vfs_write+0x20e/0x1010
    [<00000000986b0494>] ksys_write+0xfb/0x1d0
    [<000000008207ad01>] do_syscall_64+0x97/0x190
    [<00000000888f4e53>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88a8b2df4400 (size 512):
  comm "nvme", pid 30780, jiffies 4303376974
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 20 29 32 bc ff ff ff ff  ........ )2.....
  backtrace (crc 2990f85a):
    [<00000000e6877e1c>] kmalloc_trace+0x338/0x420
    [<00000000074bbdf4>] device_add+0xb09/0x1760
    [<00000000a4cc674f>] cdev_device_add+0xf7/0x230
    [<00000000903919a1>] nvme_init_ctrl+0xc65/0x1220 [nvme_core]
    [<000000004d96fd53>] 0xffffffffc1d6457f
    [<000000009aeccf81>] 0xffffffffc1d35760
    [<0000000077b20bbe>] vfs_write+0x20e/0x1010
    [<00000000986b0494>] ksys_write+0xfb/0x1d0
    [<000000008207ad01>] do_syscall_64+0x97/0x190
    [<00000000888f4e53>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

-- 
Best Regards,
  Yi Zhang


