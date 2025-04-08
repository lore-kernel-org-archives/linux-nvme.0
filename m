Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFDFC3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0ksVZQXEx33ywx2mEnzmcsFRXsREct6EubUgNyb+To=; b=eCgx4sSBkddKVIYsotr8S7pc2+
	/oBWnY1EjFJZiiHWBHRTP/Uq5/w1HTahKezM0pehX3h9xP+JNwAol7XlGyoJtvALF2Ha+MUGvvDgL
	VRo4TH0BgLrHAtTbOUqdvSOYtgRvMDoCZ+yws2p2zLCPoAWqPO4UywQkiYrcgLri9cXfsY1HWYeTe
	uC2jBtpQDCiG957AWZN6tMp7oIij0b5WMu+PbxJcMNgG06NJF3WU3gR0x1w7vFShBGbtyA5z2q79M
	8EPsBzkRK4o6rr/Q5WGX2BnhnRbXLBI7SIc5kK/C+m7u+2uLRr6ujnwpYcgqkzqBsB73Wryci7NXC
	s7jcBlsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28mS-000000047Dn-458Z;
	Tue, 08 Apr 2025 13:14:20 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u27Lw-00000003spc-0Zpf
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 11:42:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 856711F388;
	Tue,  8 Apr 2025 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ksVZQXEx33ywx2mEnzmcsFRXsREct6EubUgNyb+To=;
	b=ggHwqBTKWPnT7m46I/aZ3V/SwGpBLVHQLwAtpaN/q/Gi1iVrbZyYYW2JdGS1aKoKsSHn8s
	GHjsrw6uNIEiZig9cW15obSl0chXyTDYgjP6jVhiAVYTdHc7THGF9Bx/pHj4yGBejwm2kT
	v7tDElHHzokaVGZdNsVb91J14wPLmM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ksVZQXEx33ywx2mEnzmcsFRXsREct6EubUgNyb+To=;
	b=eSst8MGDvCu9IxWrwBpuQkSiFq3U/38dLwEAN/xQZGGXyte+DIlBC0MoO85/C1wtAc+tzr
	yANmXKqRp1LN4KCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ksVZQXEx33ywx2mEnzmcsFRXsREct6EubUgNyb+To=;
	b=ggHwqBTKWPnT7m46I/aZ3V/SwGpBLVHQLwAtpaN/q/Gi1iVrbZyYYW2JdGS1aKoKsSHn8s
	GHjsrw6uNIEiZig9cW15obSl0chXyTDYgjP6jVhiAVYTdHc7THGF9Bx/pHj4yGBejwm2kT
	v7tDElHHzokaVGZdNsVb91J14wPLmM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ksVZQXEx33ywx2mEnzmcsFRXsREct6EubUgNyb+To=;
	b=eSst8MGDvCu9IxWrwBpuQkSiFq3U/38dLwEAN/xQZGGXyte+DIlBC0MoO85/C1wtAc+tzr
	yANmXKqRp1LN4KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7630A13A1E;
	Tue,  8 Apr 2025 11:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kdPjG7oL9WfaDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 08 Apr 2025 11:42:50 +0000
Date: Tue, 8 Apr 2025 13:42:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Message-ID: <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
 <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
 <9b957880-ec3b-4b22-a923-f5b91dee9b76@flourine.local>
 <72649ea2-35c8-4c97-a3af-3f1c38bf7303@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72649ea2-35c8-4c97-a3af-3f1c38bf7303@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_044252_327403_E107DD41 
X-CRM114-Status: GOOD (  24.46  )
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

On Tue, Apr 08, 2025 at 07:58:40AM +0200, Hannes Reinecke wrote:
> On 4/7/25 17:19, Daniel Wagner wrote:
> > On Mon, Apr 07, 2025 at 07:49:41PM +0530, Nilay Shroff wrote:
> > > Both approaches — either adding a no-cache flag or introducing dedicated
> > > __no_cached APIs — would work. However, in my opinion, we should aim to
> > > use a consistent method across both libnvme 1.x and 2.x versions.
> > 
> > There will be a lot of API changes for 2.x to address all the silly
> > mistakes. That's way it will be a major version change.
> > 
> > > As we discussed during LSFMM, if we plan to implement an "nvme top" command,
> > > we would need non-cached versions of these APIs even for nvme-cli.
> > 
> > Yes, that is why I brought up this discussion. For such a command we
> > would need non cached versions. And I realize that we would need this
> > feature also for other commands. So it's not just the queue depth which
> > changes. Maybe we should just not try to add this feature to 1.x and
> > rather start the 2.x project.
> > 
> > > So, using the same mechanism for both versions makes sense. Otherwise,
> > > we’d also have to maintain different logic in nvme top depending on
> > > the libnvme version, which adds unnecessary complexity.
> > 
> > I don't see a big problem here. Either use the 1.x or 2.x.
> 
> Why don't we make this option as non-cached by default?
> In the end, there is limited usability in having it cached.

Sure, this is also fine. I suppose there will be some more conversion
from cached to non-cached necessary for the 'nvme top' feature.

