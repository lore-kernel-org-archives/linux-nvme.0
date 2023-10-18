Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3991CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 06:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QceAaGz8QFib7qs3wWJh0gmuzZcVhllRWYFNw//CH5U=; b=X5a5spU+Pp5grlnJAZd4/D1REo
	Pg5BsudCYN+Y3dM/ygou1q5d/xldDbzj5W4/KvGHspjGt9PmdJ+XgfIqeaWvsdjwOBs5pkRet2s4A
	rcy/tmeWAuRBRYbKivOdvpdqRLHVuirB/dtsZliUtMyR4Xjt0A+P4lwX53XtLYG7UJ9CSGpewjObM
	TjCNLuMNTycPiH5cMSZcEtJr+nBgE6zR0LCDnAWaB4qgNC/9qPYv7MriETEU0m73CUJWiBSFSxwXk
	FjG/NeCobx8EVvAUpbDyjqoaH29QdlblxIkf1weL1ebIhWcwzgyEKJzP1x2kvjCXSIRiQ78DifrpZ
	IEyrOvYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt0VP-00DzS7-37;
	Wed, 18 Oct 2023 06:58:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt0VM-00DzRi-1J
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 06:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697612286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QceAaGz8QFib7qs3wWJh0gmuzZcVhllRWYFNw//CH5U=;
	b=f87ys8tQQE4bmVMwNhwPHs2Z1LGFwgKrleA7qApQzMumo9CDDYPg8OIi0wvqFOERCIwidt
	j07hfs2FMWmPKPY8uGyAV6W5+49ihYusnhGT5/AD/GCsbAp2Wngs+lmmKs6hYpGUEM4i/i
	ytK1Tt8gCA7s4C2nGaOoRWGTVOZnIZo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-UlywiY7MMGmbCH5B2ezRjA-1; Wed, 18 Oct 2023 02:58:05 -0400
X-MC-Unique: UlywiY7MMGmbCH5B2ezRjA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e987fa0d87so8896101fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 23:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612284; x=1698217084;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QceAaGz8QFib7qs3wWJh0gmuzZcVhllRWYFNw//CH5U=;
        b=BjSnIzfOzaGxGbMC3HwJDhSIdavj7z6IE/A4gtwe1RQoa9GykVEHN8/p+7lzhtq4DH
         R2daSuE1bnUEcRJp6N/jIvzS+V1Cr9Pt6zNeiv3Beu56pKoC6oVEz58vTi/nUbSkFNxE
         SsHbapndYBQ/Wzgi2Sg+l57goY16eHKhzqJ4ukP+KxYCGSNMmod7OjE9f5p1Ohahz6a+
         6SX/CsotCiHHwMXgr0mXhWwXzNHYg2wtufH6epUVHQEY5e/mzPRx4hqUm5HwxHbSZDTl
         oDF5j3MUPFnrHLYJhLVxn2/tvHT3hN/JSFuVc2uKppghrYX+CK20IlYrliQxXatdxfcZ
         CiaA==
X-Gm-Message-State: AOJu0YyMgX4dS/wdcoQcaFomE88B5fahNoUlXAw1RnPJayNUpx0sQwyn
	S7n/HTXvdHs5mYVhTbSsndQlJkA6bdeO6UgTzBF5OBUPCTqyu6M5iZ86tSg+VAQIEuEpRV+vXoC
	oLCNCGWptQIbWst6jDCa3C6qzdJEEWdXBUP0J+JgTZQFfp7uXTZG3Q2ozMjQ=
X-Received: by 2002:a05:6870:1b1a:b0:1e9:c59b:a9af with SMTP id hl26-20020a0568701b1a00b001e9c59ba9afmr4499542oab.15.1697612284212;
        Tue, 17 Oct 2023 23:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQwuZ9AVf4q6Nr0ZrOE5VZqFMDyTMT1rLOJZLSbGUmbyXFPDYSjWqhEgKsOmu0skCI4Mul01uDaCEJ3n6c24=
X-Received: by 2002:a05:6870:1b1a:b0:1e9:c59b:a9af with SMTP id
 hl26-20020a0568701b1a00b001e9c59ba9afmr4499534oab.15.1697612284009; Tue, 17
 Oct 2023 23:58:04 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 18 Oct 2023 14:57:52 +0800
Message-ID: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
Subject: [bug report] nvme authentication setup failed observed during
 blktests nvme/041 nvme/042 nvme/043
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_235808_536221_5C1BA879 
X-CRM114-Status: UNSURE (   5.99  )
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
Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
latest linux-block/for-next[1],
from the log I can see it was due to authentication setup failed,
please help check it, thanks.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.7/block' into for-next

[2]
# ./check nvme/041
nvme/041 (Create authenticated connections)                  [failed]
    runtime  3.274s  ...  3.980s
    --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
    +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
02:50:03.496539083 -0400
    @@ -2,5 +2,5 @@
     Test unauthenticated connection (should fail)
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test authenticated connection
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test complete

# dmesg
[ 2701.636964] loop: module loaded
[ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
[ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2702.447496] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[ 2702.447707] nvme nvme0: qid 0: authentication setup failed
[ 2704.099618] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[ 2704.099688] nvme nvme0: qid 0: authentication setup failed


-- 
Best Regards,
  Yi Zhang


