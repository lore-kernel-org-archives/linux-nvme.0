Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A185C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9J5GX40JGRvI9MJYmoalcWrwI+e7PXyi8aPZTtpgw44=; b=zAxveu4rQZdn4VHZUVIfRD70aW
	fWAZJpHmTz9ep5sHFMzBS6kzrus1ywF5acRPDmo0N0gkg4cJatLBX40U5xT8/mcR/ZDqUMCR4MtFr
	Ze0BQktcG1384emyh+8PSvCoDaHMVixZI6fK9HCbsJJBB9vEl9pE7T8kWEQKXJEu92sK9RC0w723d
	Y18jf0339XG54t6TvDJo17dsNw+LkSPgvTMhLAwl+BEX8Nim0q0LiU4DpJw70/wdHwsYH2oNvPSRh
	mTxqWVtdMH3+fDEqsOuzeSIu8/Yh4BhJenlu6n0XN2xdiwmslW9jY9gxHbYeSbGfPg+DlVUeMuoyk
	gDbjvihQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdtkl-0000000AxbX-0M1Y;
	Fri, 31 Jan 2025 16:20:23 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdtki-0000000AxaV-20l2
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 16:20:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5084521109;
	Fri, 31 Jan 2025 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738340415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9J5GX40JGRvI9MJYmoalcWrwI+e7PXyi8aPZTtpgw44=;
	b=oukUgXv7NdFo1/rpMuatC7vXNPEMSWRh4b2AtZkCZMIq+xbF67HRPXfgYdtCIiHBi4ZyC9
	za/5/eHDUsVm2kYCtgsMNSZirGn+gDdP+m+e3XuhFFfh7Cre0SjN0y72ft8RHvEM9SIKi6
	hg0n9trcJ3N3v8HM8Y+zWMgu3XHyuiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738340415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9J5GX40JGRvI9MJYmoalcWrwI+e7PXyi8aPZTtpgw44=;
	b=0Aa8NBEb8uKsLvJYy/TOzriSebbrtariBMFC4QiVAT31NIPhNj0Mtre3sPajvnrqqMbH0u
	VxfyUZpo5IjsNtCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738340414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9J5GX40JGRvI9MJYmoalcWrwI+e7PXyi8aPZTtpgw44=;
	b=vPZ9oEC5IDbLzQ3tJPtGt6gU0AqaDjhgoy0+vJxYYSPumiIPs456Jq8Mi7e4xBIerXuI0o
	wcXD+4bK9McSebX93fQZnfhvx9BZvfYp+f/72bChuCaB1rHnWC0D9QvPbb4HMQBKN7jYE9
	FL7P2qOtGskdCPKcJbwoYaBThHCXVZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738340414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9J5GX40JGRvI9MJYmoalcWrwI+e7PXyi8aPZTtpgw44=;
	b=98hoj4L68ahiJd1l7N7aT/T5PlaWCmxsSFwP0VHuQyPS8oXgrS3N7jQsgrdzAH8ceZJOr+
	hxycBnbWsIYxqHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45630133A6;
	Fri, 31 Jan 2025 16:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p0MhED74nGd0HQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 31 Jan 2025 16:20:14 +0000
Date: Fri, 31 Jan 2025 17:20:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org, 
	Mohamed Khalfella <mkhalfella@purestorage.com>, Sagi Grimberg <sagi@grimberg.me>, 
	John Meneghini <jmeneghi@redhat.com>, Randy Jennings <randyj@purestorage.com>, 
	Keith Busch <kbusch@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Message-ID: <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_082020_666179_E625D638 
X-CRM114-Status: GOOD (  19.69  )
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

On Fri, Jan 31, 2025 at 12:02:59PM +0100, Hannes Reinecke wrote:
> On 1/31/25 10:32, Christoph Hellwig wrote:
> > On Fri, Jan 31, 2025 at 10:24:31AM +0100, Daniel Wagner wrote:
> > > Hi,
> > > 
> > > The KATO handling in the spec got updated via the TP4129. In short it
> > > mandatas that failing requests should be delayed by some value before
> > > retried on a different path.
> > 
> > TP4129 is broken and the TWG has been told that.  There is absolutely no
> > point in either implementing it or rehashing the discussion over and
> > over again.  Concentrate on making 8028 useful instead.  And if you want
> > a discussion, "why do people people push stupid things though the
> > NVMe TWG and then comaplain later about the lack of implementations"
> > might be more useful.
> 
> Okay, let's rephrase that to 'Improve NVMe-oF error handling'.
> We are trying to get TP8028 out into the open until LSF,
> then we can discuss that and also how to fold in the
> 'command cancel' patchset into the overall picture.

Yes, that basically was the idea for this proposal. I should have called
it differently. 'Improve NVMe-oF error handling' sounds about right.

