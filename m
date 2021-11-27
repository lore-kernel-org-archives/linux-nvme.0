Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B68C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Nov 2021 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5WcWZFhOByDkZ2pfDN8pbu4aVIIlyns15aJ8lakV6u8=; b=V5uQhy0C5I10BFji/5+bXKjSjS
	MITqEhwX+A/BHS9tHJqG8c+mTZxcXk9Ny6xlDZ/RaKBoRapPCaKVEnIz62GKxrpnN+yMqtIVc6o3F
	3PTlbmSTRSyqQWQM2L5qrSvVcqlE9Dgy1H3gko9IkVlYStY5ayLcvYifg7Z1fkHND3PdEDEdX1cEG
	pjk43sbD+Vj229Gb94E4PGJOiZ9o8Fvwn5fh9HhTzzY43Dx1YEN05wfygDRNExQzRNTduMMMvEeow
	aQavlaKJW7niWs/hWxu7+kOa6MYrlIV6g8KzXf7CuWLYe+PneLGYruiv1lsFHAjBl8xS0be93UMpe
	3MjTJ8Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqx00-00DcuI-IT; Sat, 27 Nov 2021 12:40:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqwzw-00Dct5-Mn
 for linux-nvme@lists.infradead.org; Sat, 27 Nov 2021 12:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638016805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=5WcWZFhOByDkZ2pfDN8pbu4aVIIlyns15aJ8lakV6u8=;
 b=OkKZz0vanJ1MHypsyLBTUgLKxXURwBZDP+oSfLkS2odT2Oa3KIf/ZNDXK53ajXII1vVsGd
 2MWfuz8j8KJQiOHacx04eycm8cvnRc8/kfr/uCwEySJPdRorRdKEE+WQU6A/Sc9sM5UPRb
 sS8KYICGJCMCCokz927KY7sZwmdnlGU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-243-yy9v9GXmOGSuoggKUlI0zA-1; Sat, 27 Nov 2021 07:40:03 -0500
X-MC-Unique: yy9v9GXmOGSuoggKUlI0zA-1
Received: by mail-yb1-f200.google.com with SMTP id
 l28-20020a25b31c000000b005c27dd4987bso14539420ybj.18
 for <linux-nvme@lists.infradead.org>; Sat, 27 Nov 2021 04:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=5WcWZFhOByDkZ2pfDN8pbu4aVIIlyns15aJ8lakV6u8=;
 b=ZLFcreSZ9y6QCTDSmci8MuE8TosrbJYpHRXaql27zus4JA2kQN7g7Ya//HwRBpPxer
 Mm5UJ+FULR2v+WXQuVQtAVTNutGla7LjCITyJBVS4QdJfFAKVmC3MIBJxotgzgAPSIQG
 nw6SksDjLpl1x4lOQKXHPsiI+/vW2H2RsHmPTl4j22wrlM9Fj+D470+IoEl+ZdC2kdAu
 uNSXf1KsJ8MsANXeD9m+MJyPDa34TFpJNYBbxTk1Ag1NzqMFyecfvl21UOHG2sHRUKmN
 kt4eyzG0v9UTXn1wox9cLyumlvW669iGF8L0EFwetpuClnaQVbC9TxeAuTfATVOFp0Dj
 NAMA==
X-Gm-Message-State: AOAM530zerboYInH/SNflVmgSgF+K3UghzS2Qxh9cj5yvWAvna6M3UVL
 1UO10tYJc+WqU4k4WkZBCRwLutkh2M1ZHtS34kkOE1ynDtk7nElFbTsi/FRe9Lp6LAvFg9bLX1i
 ooSco9vBNuPSpVvfjpzNmiGHVlc1JGVGVSKtAqoPdBp4=
X-Received: by 2002:a25:8746:: with SMTP id e6mr24854647ybn.138.1638016803085; 
 Sat, 27 Nov 2021 04:40:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5zRVdWNlvHRCOe+6F7jt7hFdRCpl2hfosUZ7VHdTl3kq8irSTA+eJNAl6UDBaF3UBXiQO2odDkMyBRaecxtU=
X-Received: by 2002:a25:8746:: with SMTP id e6mr24854609ybn.138.1638016802696; 
 Sat, 27 Nov 2021 04:40:02 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 27 Nov 2021 20:39:51 +0800
Message-ID: <CAHj4cs_i-94okB1yu2d8gEbn_We=7qJfqG9Ev0K9qSgsGJSkBQ@mail.gmail.com>
Subject: [regression] blktests nvme/002 nvme/016 nvme/017 failed from v5.16-rc1
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211127_044008_859538_34A318C4 
X-CRM114-Status: UNSURE (   7.36  )
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
blktests[2] failed from v5.16-rc1, and the bisecting showed it was
introduced from [1], pls check it.

[1]
2953b30b1d9feb1bc555682e64e6479d197b9231 is the first bad commit
commit 2953b30b1d9feb1bc555682e64e6479d197b9231
Author: Hannes Reinecke <hare@suse.de>
Date:   Mon Oct 18 17:21:38 2021 +0200

    nvmet: register discovery subsystem as 'current'

    Register the discovery subsystem as the 'current' discovery subsystem,
    and add a new discovery log page entry for it.

    Signed-off-by: Hannes Reinecke <hare@suse.de>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/discovery.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

[2]
# ./check nvme/002 nvme/016 nvme/017
nvme/002 (create many subsystems and test discovery)         [failed]
    runtime  2.092s  ...  12.200s
    --- tests/nvme/002.out 2021-11-27 00:28:12.066040369 -0500
    +++ /root/blktests/results/nodev/nvme/002.out.bad 2021-11-27
07:31:13.452891961 -0500
    @@ -1,3003 +1,3006 @@
     Running nvme/002
    -Discovery Log Number of Records 1000, Generation counter X
    +Discovery Log Number of Records 1001, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    -subnqn:  blktests-subsystem-0
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    ...
    (Run 'diff -u tests/nvme/002.out
/root/blktests/results/nodev/nvme/002.out.bad' to see the entire diff)
nvme/016 (create/delete many NVMeOF block device-backed ns and test
discovery) [failed]
    runtime  7.444s  ...  7.894s
    --- tests/nvme/016.out 2021-11-27 00:28:12.069040481 -0500
    +++ /root/blktests/results/nodev/nvme/016.out.bad 2021-11-27
07:31:21.446186124 -0500
    @@ -1,6 +1,9 @@
     Running nvme/016
    -Discovery Log Number of Records 1, Generation counter X
    +Discovery Log Number of Records 2, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    +=====Discovery Log Entry 1======
    ...
    (Run 'diff -u tests/nvme/016.out
/root/blktests/results/nodev/nvme/016.out.bad' to see the entire diff)
nvme/017 (create/delete many file-ns and test discovery)     [failed]
    runtime    ...  7.578s
    --- tests/nvme/017.out 2021-11-27 00:28:12.069040481 -0500
    +++ /root/blktests/results/nodev/nvme/017.out.bad 2021-11-27
07:31:29.103467922 -0500
    @@ -1,6 +1,9 @@
     Running nvme/017
    -Discovery Log Number of Records 1, Generation counter X
    +Discovery Log Number of Records 2, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    +=====Discovery Log Entry 1======
    ...
    (Run 'diff -u tests/nvme/017.out
/root/blktests/results/nodev/nvme/017.out.bad' to see the entire diff)


