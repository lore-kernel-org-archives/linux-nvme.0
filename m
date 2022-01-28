Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C35C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KxTG5IMRJoMimLDfLpIFB/N5IQskYQQurM8B7Hm/hJg=; b=YJWWm7Bw4rJBeTjGl3tQqv82KB
	0OX/IQ3t7NiXzMK5Y0aTuQW1YUpWz0qQX6wPnxRfE0/gPdOFawUvkQnKWobP/86yYHd5pHR2GT8KX
	2EmfCZjEPg8C4kc6x758PgywAkR5dEOi6WYUz1THIQ6Pd2fc+zY+G84QXZ6QTGlrKNuddIQjzAPpW
	0h+310Dh/xPQzcON/Y5ai1zRa3kBZaXcnzhBbSGN4kfJPFCRC3DjsmnDIRrU+gMHQM+AsTAqI1DUt
	tqY4JmqjoIE1Q74mQGSNRfdB3o+1cIUwR7PmPEXlNkfm04ABj+l9W7PO9p9q0nrzF40jy9pvcgGsf
	b/4HWWLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDQec-0023k6-Lg; Fri, 28 Jan 2022 12:47:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDQUa-001zj4-R3
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 12:36:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC291F3AA;
 Fri, 28 Jan 2022 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643373399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KxTG5IMRJoMimLDfLpIFB/N5IQskYQQurM8B7Hm/hJg=;
 b=c6/xK0Lq83iY2gVJm+25k1bHd9EGQhZQMLemTSOy1Zbx5aQrmVDv4js2ppYIKz1ZgutY+F
 nAJl9FgpwP/0MrSNiH+X0LC8YlahC2oI3c1We0giygShW57jKHK4m9hb9f/COOqgAQhy8J
 bsspez8WjCTEDz+iOEnlg9HHmRqg+WA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643373399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KxTG5IMRJoMimLDfLpIFB/N5IQskYQQurM8B7Hm/hJg=;
 b=ct9pX1x1w+Em4Vp8NnThnXBd7ZTibihBO6+kw0mMBmrpwCX3O9avwN3sCyxrizFNGqBaW/
 E9+RkUOplmefIdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D5C813A9F;
 Fri, 28 Jan 2022 12:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WpkhB1fj82FtYQAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 28 Jan 2022 12:36:39 +0000
Date: Fri, 28 Jan 2022 13:36:38 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220128123638.unxd5fzoctit6lpi@carbon.lan>
References: <20220127133648.8201-1-dwagner@suse.de>
 <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
 <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_043641_063406_F11E74CB 
X-CRM114-Status: GOOD (  13.57  )
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

On Fri, Jan 28, 2022 at 11:31:37AM +0100, Daniel Wagner wrote:
> On Thu, Jan 27, 2022 at 09:17:58AM -0800, Keith Busch wrote:
> > > +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> > > +{
> > > +	return ctrl->cntlid == 0xffff;
> > > +}
> > 
> > It's probably safe to assume 0xffff is dynamic, but spec suggests we
> > check ID_CTRL.FCATT bit 0.
> 
> Okay, but this one is only defined for fabrics. I haven't found anything
> so far which is equivalent to FCATT bit 0 for memory based transport.

Never mind. After discussing it with Hannes it turns out there is no
problem here. I didn't understand the spec correctly (it's difficult to
get an exact answer) on this topic.

