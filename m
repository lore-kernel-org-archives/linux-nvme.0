Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A33C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vb0KgKixe92s8BQWHemnh1NGhiatOTvEhvbYfP3HRkQ=; b=EoBtC94xRdc8bIN66r7wf+Dzuf
	Fg5OFoOHV5vbGAOzHlcr/QKYnNbnjI+yDpzKzBsYSETKVdyl4s36DEkzlYw61PNTR4nb1t+BZniqJ
	I9DyrHhkSJNqfLS3W9qtWnY0BPlJTqOIWo1jHuVykY9Qp/B4bSsP64mDKl3tweV6JSkYPTjrjeQ4D
	/GHXo4FrG6L4Dqe8f4ePCpS6pmQhVlOex/JRidk/Bz/zzpD2ZkxpaRB7Ag5LjBP+gu+tGy25UteGK
	Lx9Zjs6NEMaHA/HzOaIHCDvZioRwHNdRgG2BxNPq4OQBB7sgac9Wk79Gvi6ek9BpGdqOUNY3hYEtE
	/qv4I4fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptspJ-0025Yo-1n;
	Tue, 02 May 2023 16:26:05 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptspG-0025Wk-1S
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 16:26:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 651991FD81;
	Tue,  2 May 2023 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683044758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb0KgKixe92s8BQWHemnh1NGhiatOTvEhvbYfP3HRkQ=;
	b=MXrHN+ce07FTeyxXglGyD//OK1qa1dBWw51d02TISaosK3NzQGXwiOzCr58kQ7R0pQ7iOo
	wXspw/vZGdkdImkA9gZOZvPX4DYvH0VQyvO+kip/KyRuuOaLNnMzG9kjyjY4JpEvnl1up/
	bgGcpARDwBd+kCG+la0010xN2xnasbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683044758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb0KgKixe92s8BQWHemnh1NGhiatOTvEhvbYfP3HRkQ=;
	b=X8xiyT4DM4Fd3D2yMTjRY+IMI/To176f3KySmAywuLccMV9+k9HkeoVuNDsFxgAgTF6Cgf
	fjWqnZJM7Mx4ejDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57055139C3;
	Tue,  2 May 2023 16:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8qcNFZY5UWReQAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 16:25:58 +0000
Date: Tue, 2 May 2023 18:25:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <tl2sdficjgijtdqojuvqz4rwv6afelne6nndycqggob33vsejl@7saidsxqclfv>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
 <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_092602_639468_DD5B60CF 
X-CRM114-Status: GOOD (  19.86  )
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

On Tue, May 02, 2023 at 05:45:46PM +0200, Daniel Wagner wrote:
> On Fri, Apr 28, 2023 at 04:00:54AM +0000, Shinichiro Kawasaki wrote:
> > On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > > Introduce two new function to calculate the IO size for fio jobs.
> > > 
> > > _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> > > function. Reduce the max size of the job by one megabyte to make the
> > > test more robust not to run out of space by accident. Note these fio
> > > calls run with just one jobs.
> > 
> > It is not clear for me what kind of issue happens without the 1MB decrement.
> > Could you share failure symptoms you observed?
> 
> As I said, this is just to make the test more robust as this the size limits
> are not the main objective of these tests. I don't care about this too
> much, I'll just drop it then.

BTW, this is how it would look like if the disk is too small:

nvme/035 => nvme0n1 (run mkfs and data verification fio job on an NVMeOF passthru controller) [failed]
    runtime  2.383s  ...  51.954s
    --- tests/nvme/035.out      2023-04-18 17:43:18.163745956 +0200
    +++ /home/wagi/work/blktests/results/nvme0n1/nvme/035.out.bad       2023-05-02 18:21:09.442382196 +0200
    @@ -1,3 +1,20 @@
     Running nvme/035
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=925274112, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=406040576, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=498868224, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=217063424, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=1049411584, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=348282880, buflen=4096
    ...
    (Run 'diff -u tests/nvme/035.out /home/wagi/work/blktests/results/nvme0n1/nvme/035.out.bad' to see the entire diff)

