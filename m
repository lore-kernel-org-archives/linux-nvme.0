Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7356C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HE/5yTj3a9eEeGDuFBIKfM6f6F9ozQkejGz6eoRL+84=; b=deGSCPmSTWH8bB/HSXxj77713d
	EtiKSA1vuVhH9ek2JZEx/f7C2EovLzEhl5cSlAvon35XCBE4w99TJH7M2hOTIUYgG+yzPQIvlJe3i
	VusT25SkajOyDeC0+Aa8fz+BgdXsnbKCpCZKlNmLsylKCq/7r0K0fe72DJRf+kulPjjvKn42T25fN
	zsKIDvyL7W3Mvip1ukKEKzKrZjLfhMqo/DTfTjOz/bdHNquc4C/Wj2Lp6LspGT44ojAhzLXocRdwS
	R49C3O1FpZENAlWjh5qwaCM3aVuz+knSFpjgBPFi6l0RYToyEcnk79CFQQ6bAcH+Y1+dPY1iEUuY2
	VH10ix8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqs50-00CHqS-58; Tue, 17 May 2022 07:57:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqs4x-00CHoV-3K
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 07:57:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2004E21D9E;
 Tue, 17 May 2022 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652774233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE/5yTj3a9eEeGDuFBIKfM6f6F9ozQkejGz6eoRL+84=;
 b=qwlr3QiS7i/mY8CNcp2PNSeN5edevXxQOhL5iVmsOG9OQHyIDyf5QJMSZNdIhPXqPpgOii
 BeGGhtvoXERmiW59WTg+DyCArBvApsVDpqxocdUwzB0WvdwDvWw0vFtHCMGgev2ivcvk0M
 X2uLwSnAGHXpI/NivJBRk3cERwucPJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652774233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE/5yTj3a9eEeGDuFBIKfM6f6F9ozQkejGz6eoRL+84=;
 b=mCL+TUQSoekh8vdEp1ckAJmYLjMH9PfdY7csqzBz8TnzuxSF5M+Mmqb71NJjIauGBKY8pj
 fUIilkik8NeRgWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FEC113305;
 Tue, 17 May 2022 07:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uHzgA1lVg2LTBAAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 17 May 2022 07:57:13 +0000
Date: Tue, 17 May 2022 09:57:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <martin.wilck@suse.com>,
 Belanger Martin <Martin.Belanger@dell.com>,
 James Smart <jsmart2021@gmail.com>, Hanumanthu H <hanumanthuh@micron.com>
Subject: Re: nvme-cli license clarification
Message-ID: <20220517075712.262gqfbyaylufl33@carbon>
References: <20220516161608.of4tklsysuvgbtie@carbon.lan>
 <YoJ574Sr5oOLSM8T@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJ574Sr5oOLSM8T@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_005715_306920_5C26F656 
X-CRM114-Status: GOOD (  17.12  )
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

On Mon, May 16, 2022 at 10:21:03AM -0600, Keith Busch wrote:
> On Mon, May 16, 2022 at 06:16:08PM +0200, Daniel Wagner wrote:
> > 2. nvme.h
> > 
> >    The situation here is a bit simpler as Keith is 'owning' most
> >    of the lines (monolithic and master branch are almost identically)
> > 
> >    Copyright (c) 2011-2014, Intel Corporation
> >
> >   I suppose someone from Intel needs to signed of the 'or any later
> >   version' thing. Keith do you happen to have a contact for this?
> 
> I am not sure of who would be interested at Intel in this anymore. This was
> initially just a copy of the Linux kernel's header, though, and diverged
> significantly from there, but I guess we'd need to inherit the original's
> GPLv2 only license?

Indeed, there isn't much left from the uapi header. I see to options.

The first is to accept this situation and mark nvme-cli as GPL-2.0-only
or second we reimplement the necessary parts under GPL-2.0-or-later.

Most of the content is just function declarations and the implementation
is licensed under GPL-2.0-or-later. Do we really have to consider these
declarations as GPL-2.0-only? So this could be moved to a new header
file which is licensed under GPL-2.0-or-later, I suppose.

The rest of the file could be reimplemented fairly simple. What you think?

