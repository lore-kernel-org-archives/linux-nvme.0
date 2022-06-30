Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZT3Pr4deTdJuSWhUG+KM8YnFqiQcwWEaUGAb7rnC7x0=; b=zVxGFl58nty+wLDHG4C1hMDe8F
	z2JWKQNvDuuDkupVbi1A3WsSTk4DZnUna33sIE1l98IeNRshX4PBji4uUnga9iJd4qaqJ0osZDL2U
	VzTCpCC7l05IZDvGYkmxzHjncF6z9iI6sBS14oriYpeqNLIsk7bHpdmM6/joAjoSN5tyEx6oGqkd3
	CcFsV577TjlW1+8b+H+fb5qwoBJ4e8AP02172YW7OOaEDeXVlU5C56F48qjn5PIU5E9IQE1qZTuGx
	TTDPXQYxtYCmOtvI/2zkphXFyEKftQLsKLF8kB25dr/qs1d/G/juH1x0ODdYs7qNuJTUteTlhEaRY
	EwwZzUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nGV-00FPwn-IZ; Thu, 30 Jun 2022 06:02:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nGS-00FPvt-Mo
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 06:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656568974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ZT3Pr4deTdJuSWhUG+KM8YnFqiQcwWEaUGAb7rnC7x0=;
	b=HobM9nNznf7E8TFZf3YzCY30veWbHtR9Y4Wg/B0rhuzaJdsfGLYEFaK3X17A8U3SBjxduk
	f0SAqRbFSHhy896BexjI/i4n0RCGi0X7/xdXhRH7bYLz+jqj+zS2kBJx7sI5hpvxo67hMF
	62CYUMKYzjA+UD7PWNVmno6JkJPnYvI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-r1DZXM-3OfKtJDqGAp1skA-1; Thu, 30 Jun 2022 02:02:52 -0400
X-MC-Unique: r1DZXM-3OfKtJDqGAp1skA-1
Received: by mail-pl1-f199.google.com with SMTP id u14-20020a17090341ce00b0016a38ec073aso9918273ple.21
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jun 2022 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZT3Pr4deTdJuSWhUG+KM8YnFqiQcwWEaUGAb7rnC7x0=;
        b=ToCHSOuC3d59Lw9GtDcPat66U1Rtk6BwvYP0u6E91NcJ/RAcnDuyGw/SPT33i6LFQ2
         RBhkXiTEGZLuwYcUlGZF0oFAkvomiEvJYxNz1OBGL0kgw80Oe9z67SS9o2GbaRKnqLNG
         DjNEGlfwJpW4Z5X+Yj+2PEJUoRhfWdZzVC6XHyizHfUvHeLUndWwMLnY1rvQ87nJmS1n
         mp/aZMY1hGusUsEPsJXXvUPYBtm+P8+gUjuikEfj49WIWnn0cHwXrkXDGRjJQVs9Dqrp
         M7oxZeJg3uPIQ9UTOLRtddErvWX3cNm3Jrza8OGoq61Vjbz5Nq38XFyXO8cyVtvEvxyy
         yyUQ==
X-Gm-Message-State: AJIora8LC6Yl0ILP49hUzWUL8gUC6lgMS+zmff7A9UDiFY5W2a5cQ3vX
	nqsjVYnyB/ySZKe8+VOUg1jgvJKPJCWBVxgOkUUcU/ONHNNvctIyW4MChv6sUls28/6mLVYlVP1
	rGBedXXlQnXnkMkjcLDxuqHHe9J4mcZMNLxZrYCP5TOU=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id m11-20020a170902db0b00b0016ba4ffc9d6mr5007230plx.15.1656568971132;
        Wed, 29 Jun 2022 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vUzb9knhbrYQkg5UlFZmHNfPcDRdw5zCedzO07PslAW3rs3r9YjY4t8YKOy/MvkmKqhXuurNcT4n2AIFDtPFo=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id
 m11-20020a170902db0b00b0016ba4ffc9d6mr5007219plx.15.1656568970762; Wed, 29
 Jun 2022 23:02:50 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 30 Jun 2022 14:02:39 +0800
Message-ID: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
Subject: [bug report] blktests nvme/004 failed after offline cpu
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_230256_861176_C5CF8383 
X-CRM114-Status: UNSURE (   8.17  )
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
I found this issue when I run blktests after offline cpus on
linux-block/for-next, here are the steps and dmesg log,
and from the log, the test failed with the target connect, feel free
to let me know if you need any info/test, thanks.

# echo 0 >/sys/devices/system/cpu/cpu0/online
# ./check nvme/004
nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]
    runtime    ...  0.725s
    --- tests/nvme/004.out 2022-06-30 01:50:53.637275584 -0400
    +++ /root/blktests/results/nodev/nvme/004.out.bad 2022-06-30
01:55:22.321399448 -0400
    @@ -1,5 +1,7 @@
     Running nvme/004
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +Failed to write to /dev/nvme-fabrics: Invalid cross-device link
    +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
    +cat: /sys/block/n1/uuid: No such file or directory
    ...
    (Run 'diff -u tests/nvme/004.out
/root/blktests/results/nodev/nvme/004.out.bad' to see the entire diff)
# dmesg
[ 1526.169417] numa_remove_cpu cpu 0 node 0: mask now 1-31
[ 1526.170619] smpboot: CPU 0 is now offline
[ 1531.030430] loop: module loaded
[ 1531.115255] run blktests nvme/004 at 2022-06-30 01:55:21
[ 1531.305557] loop0: detected capacity change from 0 to 2097152
[ 1531.354299] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1531.402815] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[ 1531.404124] nvme nvme0: creating 31 I/O queues.
[ 1531.448181] nvme nvme0: Connect command failed, error wo/DNR bit: -16402

--
Best Regards,
  Yi Zhang


