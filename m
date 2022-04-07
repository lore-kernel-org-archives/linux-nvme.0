Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF557C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mrye2sJxp7i4nFgKg26tplJp7WvaOn6N6lOuE8JMzSE=; b=jPdnrVa5Pajc7QWpEkJaC07NdD
	Ewo24dIUJARpReNoJ3NXLQ85rUIJPny4D7rGEguePtWw4gDaZt5e2DJFnXewbFzfQzNAf+R0wrDJh
	gqKyTpRnOqkJmNKXwpB9+RSDAi/0NxKsmtdI60ZGufrahh/tofaT7ONWUrLIBaCN2hmGQYjXSpPCt
	B5OjvC0LnuOELEaVeNCbx85IKsNKYC3DDFaEB037cxgw2eI95VF4Zt2rlTmLo+AyYbKsp6f7hT/45
	oSRfpNMZ/GqFwThiasmQ62jZzeZ2/EGCmwDN8eiEpXZc/Ky11ESsed+3FZ7oukI7xFyE4pASVPA3h
	w/pQfVbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSaJ-00CF2d-Lr; Thu, 07 Apr 2022 13:54:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSaC-00CF07-C3
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:54:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5421F85A;
 Thu,  7 Apr 2022 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649339634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrye2sJxp7i4nFgKg26tplJp7WvaOn6N6lOuE8JMzSE=;
 b=cSxE4ap4lv1tLTBs06WCMpYN8TbBh/LwYyaLwDbmpWfDXROaKiDEcTBN13VPWfzVV3ZmOH
 lL3q35usqLvVgkOJsTNhS/vm7/+mpzZGhBLxOJwiS3PRWxGbbQjCZE07cR/MJIin8JAV6a
 MKAyf4S3J5cjMsjoPBWgI9pVrtU7fuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649339634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrye2sJxp7i4nFgKg26tplJp7WvaOn6N6lOuE8JMzSE=;
 b=j+maKYmqzLI8HSd4tWG/RJXoHNswgy4w7ez4rh0c3OUX9lA3t21JdRT5fQJS6xz+6gfeGm
 zR+6/k69XwTXV5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DC8813A66;
 Thu,  7 Apr 2022 13:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /f0lC/LsTmIRQQAAMHmgww
 (envelope-from <dwagner@suse.de>); Thu, 07 Apr 2022 13:53:54 +0000
Date: Thu, 7 Apr 2022 15:53:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Message-ID: <20220407135353.uupdcx2jbk37qtpx@carbon.lan>
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
 <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_065356_598946_EB035BF6 
X-CRM114-Status: GOOD (  13.87  )
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

On Thu, Apr 07, 2022 at 04:42:55PM +0300, Sagi Grimberg wrote:
> > Understood. Would something like this work
> > 
> >        struct request *rq = blk_mq_rq_from_pdu(queue->request);
> >        bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> > 
> >        dev_err(queue->ctrl->ctrl.device,
> >                "failed to send request %d\n", ret);
> >        if ((ret != -EPIPE && ret != -ECONNRESET) ||
> >            (!queue_ready && rq->cmd_flags & REQ_FAILFAST_DRIVER))
> >                nvme_tcp_fail_request(queue->request);
> > 
> > ?
> 
> But in your case the queue is live...

Could we not just test for NVME_CTRL_ADMIN_Q_STOPPED instead as it is
set in nvme_stop_admin_queue:

nvme_tcp_teardown_ctrl
  nvme_stop_admin_queue
  nvme_shutdown_ctrl

instead?

> I'm thinking that we maybe need a register access timeout value for
> fabrics...

I see there is a shutdown_timeout which is 5 seconds on default. Seems
not to trigger though.

