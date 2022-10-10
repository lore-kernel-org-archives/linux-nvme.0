Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D8AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/NCFyQVaTFUT6HVoiuDwR4gc37VCW+/wm92rica5PQ=; b=xdEDGsU+HDAm9xYYhNS1Xittuk
	axQA3zZ3tN4rYMxXTueWM+ShwAcz5JL3ij9T6kolZqp0+6GT83i2AuaBtupJnHHRxphgFYF7PbM2T
	pfNogAlwH114lm3KL5rWOiQ71YsjLs02novFSy66R3cxAdcy1tGxvblV96H616QsOH3VZxMxqt0X6
	XtXNd5rw1vyPIoK5aDSNhiupX/vVvbPrQTlIGF9TtwkeUv5/zEW31fe4jNeSJ84FOX0RpGzBJm/Qc
	70/FIqh8kEhYvMZV2vtXEa9dJ+lkKVp0AtOSJAp2rtqrAZukLfR+uIfyGvhHYPI5fOjOdizrGGEVD
	ie9UwXNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohnKf-00HOcS-A2; Mon, 10 Oct 2022 07:36:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohnKd-00HObL-6c
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 07:36:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5F5B1F37E;
	Mon, 10 Oct 2022 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665387364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/NCFyQVaTFUT6HVoiuDwR4gc37VCW+/wm92rica5PQ=;
	b=oFCobOWxmVHB/ynk0s4/J7tTbd2w5Bf0Psd9lXrucBa+H7Af1lJcKkozzZ73dTbl3wO/4f
	6M7U/XSYhuNIMOSY1a0OVA1u+x4Qu9i9/ap2IkwOsroDvpq5NkvrhDnoROigfrpx1o+wX8
	B+fQzMcxBG0JHo/nCTTHjzwiPrAG3wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665387364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/NCFyQVaTFUT6HVoiuDwR4gc37VCW+/wm92rica5PQ=;
	b=r7Op92f8KMp8wDZRehQwifiasdLF0a5ZfwFulOM5RiU7aorKTEfV8N0mh/y1XTBveTeVsc
	kSHMZyt4nH7Di4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6BFA13ACA;
	Mon, 10 Oct 2022 07:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TzGXLGTLQ2PnVgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 10 Oct 2022 07:36:04 +0000
Date: Mon, 10 Oct 2022 09:36:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Pankaj Raghav <pankydev8@gmail.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Tomas Bzatek <tbzatek@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Message-ID: <20221010073604.rryji23gnnxgoqrr@carbon.lan>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
 <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
 <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_003611_428910_ED9FC399 
X-CRM114-Status: GOOD (  13.48  )
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

Hi Alan,

On Fri, Oct 07, 2022 at 09:19:08PM +0000, Alan Adamson wrote:
> > I do get the debugging argument, but this clearly regresses production
> > code. Ideally, this code should be opt-in. The only way I see how to make
> > this work is by introducing a new API which allows enable this
> > feature.
> 
> Looks like a new API may need to be created.  I’ll investigate that.
> With your change, there will need to be a blktests change.

Thanks for picking this up.

> nvme/039 => nvme0n1 (test error logging)                     [failed]
>     runtime  0.120s  ...  0.118s
>     --- tests/nvme/039.out	2022-09-21 17:14:12.760890663 -0400
>     +++ /root/blktests/results/nvme0n1/nvme/039.out.bad	2022-10-06 19:11:45.846879996 -0400
>     @@ -2,6 +2,4 @@
>       Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
>       Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
>       Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
>     - Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
>     - Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
>      Test complete

Hmm, that is not supposed to happen. Well, obviously this needs some
more work :)

Thanks,
Daniel

