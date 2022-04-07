Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5485C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5UqXApufL6JTuPDM8n20Mt7Yt0v+OQbr683Oudt6Ls=; b=tv6I0baRxLL8MvO0S3OS1iIdZ8
	53QUF0Pes2TCKtHKCmK5u7rQ/oBOqn5cQ6mWy9RcgZqqsfWuxWHDFtvlKVwItuh0WgVf+noe2JgWQ
	QrHaVLBfM3en5A0IiW6MsJ6Yk7KhNSJKn2gjO63aVWIbi/texwkjfJgAD48hzh7IvnpC53FXqKVkS
	9e2E2nR6OUjbWtbGBfo3fAuQLFYR7jqvxYABSdjwdDbtlcV2tztdpEbl/3narLq2KE9eMTjsXVDZj
	dqoPLrQjRU5yAmelNr2B0HGmbMN3vpOe54iIdqHIH8N11BLrUUmBHF3NewMAwpMDzsf8udu57E4rw
	BSN8DeEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncR8H-00Bouu-EP; Thu, 07 Apr 2022 12:21:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncR8D-00Bot5-9O
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 12:21:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD1B3210EA;
 Thu,  7 Apr 2022 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649334054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5UqXApufL6JTuPDM8n20Mt7Yt0v+OQbr683Oudt6Ls=;
 b=A0mPUHGAt7XNCGTmCel5Fbo7YW99J6D2k+uGC/gxeeDvhkX4COFVBlrF5EBCTqwzhQHuNQ
 TYgHzT2VQlA4IzbmBUDW1g6mG6091a9lbi6q08AHYXOH9j2I5ZVwecIni5Pjzc3i696lWJ
 IqQcnUy97hkLpOwnsBtk/RfJdab5L04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649334054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5UqXApufL6JTuPDM8n20Mt7Yt0v+OQbr683Oudt6Ls=;
 b=k6Mg8LdKbmBbdi8nZddwbNA6EEJZUwLyAlfa5vnuq4vLRP507Zfk4ELHye+ieNwE7HXYBv
 SvXwQ4i9AYfRBCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFB3D13485;
 Thu,  7 Apr 2022 12:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eYqvMibXTmKODgAAMHmgww
 (envelope-from <dwagner@suse.de>); Thu, 07 Apr 2022 12:20:54 +0000
Date: Thu, 7 Apr 2022 14:20:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Message-ID: <20220407122054.reywmgnysnhryvg2@carbon.lan>
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_052057_521057_5DC1171F 
X-CRM114-Status: GOOD (  19.80  )
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

On Thu, Apr 07, 2022 at 03:04:42PM +0300, Sagi Grimberg wrote:
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 10fc45d95b86..f714d7ad38c0 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1145,9 +1145,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
> >   	if (ret == -EAGAIN) {
> >   		ret = 0;
> >   	} else if (ret < 0) {
> > +		struct request *rq = blk_mq_rq_from_pdu(queue->request);
> >   		dev_err(queue->ctrl->ctrl.device,
> >   			"failed to send request %d\n", ret);
> > -		if (ret != -EPIPE && ret != -ECONNRESET)
> > +		if ((ret != -EPIPE && ret != -ECONNRESET) ||
> > +		    rq->cmd_flags & REQ_FAILFAST_DRIVER)
> 
> I'm wandering if this will race with nvme_cancel_admin_tagset which
> can also complete the command... The whole assumption is that the
> cancel iterator will be running as the socket is shutdown by the peer
> and error_recovery was triggered.
> 
> I think these shouldn't race because we shutdown the queue (and flush
> the io_work) and only then cancel. But I've seen races of that
> sort in the past...

This particular request is issued by nvme_shutdown_ctrl() so we know
exactly where we are. But this might not be the case for any other
REQ_FAILFAST_DRIVER flagged request. So this might introduce the race
you are pointing out.

The option is see is what Margin suggested in

http://lists.infradead.org/pipermail/linux-nvme/2021-September/027867.html

