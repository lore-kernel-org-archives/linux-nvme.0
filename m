Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C962FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eS7Mu8ZyMbWc6UR5t2TJU8dDGsTfWpvSxmCfLpefPH0=; b=Zq4rUh3WVVhq5F2R+51rn21kGk
	AAza43DPEnr1a99mQRMCbjAGwHwfYgh64WbR35Sm5lSqsa5dKkDlQVweUpEMdksAAFbAtZiYfDuWp
	wo9VvjT0ZBKUblnMfipnAHETrcH7fxRUxe2JAP0MEfiX1IuVRW3YZkxhq9YS2+sri/POj6ytDFJ7g
	4CXiwr2/mSEdQbviVuWfcdiKXjYhOoH29qed1Yy4DOxo4SeY9uXPnbB2hBobVBhlcF3dZ+YFp6Nqb
	4eKGbl1lFx6bkQOowre1xu/+BTE7MjzmQ2Ex6p05ySK6UeMs/ngCPd3fCBGg3uikxYCwiC7mIjDEQ
	BOdvX5iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrJp5-00Fl3E-Pb; Sun, 28 Nov 2021 13:02:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrJp2-00Fl23-PM
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 13:02:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 136B01FCA3;
 Sun, 28 Nov 2021 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638104541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS7Mu8ZyMbWc6UR5t2TJU8dDGsTfWpvSxmCfLpefPH0=;
 b=ZF/Y/jvfPfFwrRN29/o81FC32utI/AUrGjKV9O/U8NV306Ln77LzX4vHJ8IE5SMUvBzn24
 kL8Wpbkf+h3CSAlvB5tbvPeoaxfNyxSLc94JH04TnMXZymdvqgcs6ultUptlp5jM3I1t4U
 xyIlotulsR76aNdqMxSvMmrIXHObpm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638104541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS7Mu8ZyMbWc6UR5t2TJU8dDGsTfWpvSxmCfLpefPH0=;
 b=NHtpp7liefyf9S70g+Ea3DNGsJ5zkksBRdUs95S01YyUGG0hrBFlSP4O1WFvZ0SmzTnkLB
 rXqBFGjo5et3MaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA829133FE;
 Sun, 28 Nov 2021 13:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C16kN9x9o2GHbwAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 13:02:20 +0000
Subject: Re: [regression] blktests nvme/002 nvme/016 nvme/017 failed from
 v5.16-rc1
To: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
References: <CAHj4cs_i-94okB1yu2d8gEbn_We=7qJfqG9Ev0K9qSgsGJSkBQ@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <27141b1d-918e-59a4-4b8b-af07d10acefe@suse.de>
Date: Sun, 28 Nov 2021 14:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_i-94okB1yu2d8gEbn_We=7qJfqG9Ev0K9qSgsGJSkBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_050224_997614_92C63BB6 
X-CRM114-Status: GOOD (  17.76  )
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

On 11/27/21 1:39 PM, Yi Zhang wrote:
> Hello
> blktests[2] failed from v5.16-rc1, and the bisecting showed it was
> introduced from [1], pls check it.
> 
> [1]
> 2953b30b1d9feb1bc555682e64e6479d197b9231 is the first bad commit
> commit 2953b30b1d9feb1bc555682e64e6479d197b9231
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Mon Oct 18 17:21:38 2021 +0200
> 
>      nvmet: register discovery subsystem as 'current'
> 
>      Register the discovery subsystem as the 'current' discovery subsystem,
>      and add a new discovery log page entry for it.
> 
>      Signed-off-by: Hannes Reinecke <hare@suse.de>
>      Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>   drivers/nvme/target/core.c      |  1 +
>   drivers/nvme/target/discovery.c | 17 +++++++++++------
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
> [2]
> # ./check nvme/002 nvme/016 nvme/017
> nvme/002 (create many subsystems and test discovery)         [failed]
>      runtime  2.092s  ...  12.200s
>      --- tests/nvme/002.out 2021-11-27 00:28:12.066040369 -0500
>      +++ /root/blktests/results/nodev/nvme/002.out.bad 2021-11-27
> 07:31:13.452891961 -0500
>      @@ -1,3003 +1,3006 @@
>       Running nvme/002
>      -Discovery Log Number of Records 1000, Generation counter X
>      +Discovery Log Number of Records 1001, Generation counter X
>       =====Discovery Log Entry 0======
>       trtype:  loop
>      -subnqn:  blktests-subsystem-0
>      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
>      ...
>      (Run 'diff -u tests/nvme/002.out
> /root/blktests/results/nodev/nvme/002.out.bad' to see the entire diff)
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [failed]
>      runtime  7.444s  ...  7.894s
>      --- tests/nvme/016.out 2021-11-27 00:28:12.069040481 -0500
>      +++ /root/blktests/results/nodev/nvme/016.out.bad 2021-11-27
> 07:31:21.446186124 -0500
>      @@ -1,6 +1,9 @@
>       Running nvme/016
>      -Discovery Log Number of Records 1, Generation counter X
>      +Discovery Log Number of Records 2, Generation counter X
>       =====Discovery Log Entry 0======
>       trtype:  loop
>      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
>      +=====Discovery Log Entry 1======
>      ...
>      (Run 'diff -u tests/nvme/016.out
> /root/blktests/results/nodev/nvme/016.out.bad' to see the entire diff)
> nvme/017 (create/delete many file-ns and test discovery)     [failed]
>      runtime    ...  7.578s
>      --- tests/nvme/017.out 2021-11-27 00:28:12.069040481 -0500
>      +++ /root/blktests/results/nodev/nvme/017.out.bad 2021-11-27
> 07:31:29.103467922 -0500
>      @@ -1,6 +1,9 @@
>       Running nvme/017
>      -Discovery Log Number of Records 1, Generation counter X
>      +Discovery Log Number of Records 2, Generation counter X
>       =====Discovery Log Entry 0======
>       trtype:  loop
>      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
>      +=====Discovery Log Entry 1======
>      ...
>      (Run 'diff -u tests/nvme/017.out
> /root/blktests/results/nodev/nvme/017.out.bad' to see the entire diff)
> 
But that was precisely the point, returning more information for 
discovery ...

I'll be sending a patch to update blktests.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

