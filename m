Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95571C48BEB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=; b=BlS6SPbW4sgnJClBDhqHNFvXRU
	iaa6na+o/CoZol3wRtJwtKSQjEo3lcKzixjnPQSLBqpH7GmpPokeaMfjh8WM3L4TzkkPPflqKVpjl
	d1ZdJd6smDYpcg8IAD+GTeuFby79GjlSkUNDhOQzVXCRPMH3vqkr3bNnnPasI1CPYY4KfVbzwWoc7
	JZh6PVfSZivh58zOF7B/93b5DzOADpxvpiJx6YjupKYdFvEoEktO3PFqti9aGmAvFtfzbOK88uohQ
	vp0DP6U9ZGdV3p2Af5CS0N+IbrOcZnZJYBsipsqtEpiHRHCRxdSqZWm/WFUl1y2vJEdhy/ixhFi9/
	JzrPSYqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3la-00000003rB7-3foy;
	Thu, 22 Feb 2024 07:45:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3lT-00000003r9p-2bpm
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 07:45:10 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45F4722280;
	Thu, 22 Feb 2024 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708587904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=Ev/wKbj7mutRHm61bCp9Y9yogY7qN4fVkrf8mZxovT6LGK0UNyibfEFjFQ7FaLmher2JsH
	AG6bymldnKSTFNC62Ok9/nE2cxqHzkwLFwiLFpehTgIVHq60KdNc4HzZ7yCYrdr8mNIa7U
	g/saKCvAoCrfq4z4dyILcWUfVm5zZgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708587904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=A8vK9tsNjWriImdmlEn/E+uJhA7fWEtI9c20/pKWnghzHoorFzzBJvt4hzpPQqs6zIAC1f
	oh6UGGcWMwTGEMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708587904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=Ev/wKbj7mutRHm61bCp9Y9yogY7qN4fVkrf8mZxovT6LGK0UNyibfEFjFQ7FaLmher2JsH
	AG6bymldnKSTFNC62Ok9/nE2cxqHzkwLFwiLFpehTgIVHq60KdNc4HzZ7yCYrdr8mNIa7U
	g/saKCvAoCrfq4z4dyILcWUfVm5zZgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708587904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=A8vK9tsNjWriImdmlEn/E+uJhA7fWEtI9c20/pKWnghzHoorFzzBJvt4hzpPQqs6zIAC1f
	oh6UGGcWMwTGEMDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A0513A6B;
	Thu, 22 Feb 2024 07:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DDirCoD71mUDCgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 07:45:04 +0000
Date: Thu, 22 Feb 2024 08:45:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.58%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_234507_850350_28DF3CF7 
X-CRM114-Status: GOOD (  18.33  )
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

On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
> On 2/21/24 17:37, Daniel Wagner wrote:
> > On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
> > In this case yes, I've tested on top of this patch. This breaks the loop
> > where the provided key is invalid or is missing. The loop would happy
> > retry until reaching max of retries.
> 
> But that's to be expected, no?

Why? If the key is wrong/missing it will be likely wrong/missing the
next retry again. So what's the point in retrying?

> After all, that's _precisely_ what
> NVME_SC_DNR is for;
> if you shouldn't retry, that bit is set.
> If it's not set, you should.

Okay, in this case there is a bug in the auth code somewhere.

> So why is NVME_SC_AUTH_REQUIRED an exception?

status is either NVME_SC_AUTH_REQUIRED or -ECONNREFUSED for the first
part of the nvme/041 (no key set). In this case DNR bit is not set.

Note, when -ECONNREFUSED is return

	if (status > 0 && (status & NVME_SC_DNR))

will not catch it either.

Glad we have these tests now.

