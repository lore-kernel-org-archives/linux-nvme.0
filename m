Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B78CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDtIVljD9I9i86coDvNni7FgZ6U82Hw98JljXYpTMEg=; b=cuVaWiFJ2Pv4dQvEMj8vifaTR3
	AN7muF0gCgEEGo5fqTHffbFnL/SPdBLSuJW28VQhv4bK8nDgKVgqcw0Xo1aDs9Y2//iJyXO5O/cBc
	gm4ystAzLXySGy4a3drPw+hvLE9ulUmDeW77c5X1xWuZxmyFBBAapnAMFNBiHFlPEJSWKtfwpSwDD
	SoTLbK+IySVYImy8jtb3Bu48oZt3R/6hZtW3sV0n7wi1YU5/Pu5/LWUPuRRX2p+9qQKfIgcFS0/yR
	/cHgQirNTgx2/01iRq6bXG7asMJ4E0H2ZjxtwNYw86ssjuUfkGEZQ8Hk2sx+nZoKsjUs9eFPAyvz2
	UP+5WDXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v78k0-000000084DW-2ukr;
	Fri, 10 Oct 2025 08:44:44 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v78jy-000000084CL-1qyT
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 08:44:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AB1121E80;
	Fri, 10 Oct 2025 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760085880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDtIVljD9I9i86coDvNni7FgZ6U82Hw98JljXYpTMEg=;
	b=oGspfD1ksoIb5c9+IG72RyNtVLbBtBHWL2WDC7RfRevL9WvE/0LA3mi/njtYfL+hG6hJ3q
	aje5oGRrnCal13AmxvXSRa6hu9nh8/7x5j3i+8z+Zng2fOyAG/cWF1kt/xmDvCkLnQMxaM
	1yDDhgMOqd7S4SH+JKbOzDbybEKO/lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760085880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDtIVljD9I9i86coDvNni7FgZ6U82Hw98JljXYpTMEg=;
	b=YVeogJpS1poMZcZO2wrrRoHgMaTpEoSvisoim6TtuUeIicQPI2kFjqde0+LCr3xGQ09d3e
	Y2L5YowbUmKhexCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760085880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDtIVljD9I9i86coDvNni7FgZ6U82Hw98JljXYpTMEg=;
	b=oGspfD1ksoIb5c9+IG72RyNtVLbBtBHWL2WDC7RfRevL9WvE/0LA3mi/njtYfL+hG6hJ3q
	aje5oGRrnCal13AmxvXSRa6hu9nh8/7x5j3i+8z+Zng2fOyAG/cWF1kt/xmDvCkLnQMxaM
	1yDDhgMOqd7S4SH+JKbOzDbybEKO/lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760085880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDtIVljD9I9i86coDvNni7FgZ6U82Hw98JljXYpTMEg=;
	b=YVeogJpS1poMZcZO2wrrRoHgMaTpEoSvisoim6TtuUeIicQPI2kFjqde0+LCr3xGQ09d3e
	Y2L5YowbUmKhexCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C79E13A40;
	Fri, 10 Oct 2025 08:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rs9pIXjH6GigRgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 10 Oct 2025 08:44:40 +0000
Date: Fri, 10 Oct 2025 10:44:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
 <20251010072658.GA17812@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010072658.GA17812@lst.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_014442_767884_DE14C0C7 
X-CRM114-Status: GOOD (  27.16  )
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

On Fri, Oct 10, 2025 at 09:26:58AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 09, 2025 at 01:07:47PM +0200, Daniel Wagner wrote:
> > Hi Christoph,
> > 
> > As you have suggested the command API should be inverted, that is the
> > only stable API will be nvme_submit_admin_passthru and struct
> > nvme_passthru_cmd and a bunch of helpers to initialize the cmd.
> > 
> > I've done updated a bunch of the identify commands and below is the
> > result. I think we could reduce the number of helpers a bit,
> > 
> >   nvme_nvm_init_identify_ns vs nvme_nvm_init_identify_ns_csi.
> > 
> > Is this what you had in mind
> 
> Yes.
> 
> > (obviously I haven't gone the whole way to
> > macros only, I like some type safty)?
> 
> What actual type safety do we actually gain here?

Not much, just via the argument types. I agree this argument is a bit
mood. The other point I missed to mention, is that the inline function
allow us to write code not worrying about the context it is called from
,no variable name collission. But then this might not be a big thing
either. I just prefer inline function over macros :)

> > static inline
> > void nvme_nvm_init_identify_ns(struct nvme_passthru_cmd *cmd,
> > 			       __u32 nsid, struct nvme_id_ns *ns)
> > {
> > 	nvme_nvm_init_identify(cmd,
> > 			       NVME_IDENTIFY_CNS_NS,
> > 			       ns, sizeof(*ns));
> > 	cmd->nsid = nsid;
> 
> Given that identify includes nsid and just specified how it is
> cleared to zero for the non-ns commands, maybe pass a nsid to
> nvme_nvm_init_identify to simplify things?

Okay, the majority of the currently existing helpers do use nsid so that
seem common enough.

> > 	cmd->cdw11 |=  NVME_SET(nvmsetid, IDENTIFY_CDW11_CNSSPECID);
> 
> And NVME_SET still feels very oddly name..

It's on the TODO list but we might address this at the same time indeed.

Is it just the name or the macro itself?

Something like NVME_FIELD_PREP, REG_FIELD_PREP, FIELD_ENCODE,
PACK_FIELD?

Yeah I am struggling coming up with good names...


Just for reference what v1 currently defines:

#define NVME_GET(value, name) \
	(((value) >> NVME_##name##_SHIFT) & NVME_##name##_MASK)

#define NVME_SET(value, name) \
	(((__u32)(value) & NVME_##name##_MASK) << NVME_##name##_SHIFT)

#define NVME_CHECK(value, name, check) ((value) == NVME_##name##_##check)

#define NVME_VAL(name) (NVME_##name##_MASK << NVME_##name##_SHIFT)


enum nvme_cmd_dword_fields {
	NVME_DEVICE_SELF_TEST_CDW10_STC_SHIFT			= 0,
	NVME_DEVICE_SELF_TEST_CDW10_STC_MASK			= 0xf,
	NVME_DIRECTIVE_CDW11_DOPER_SHIFT			= 0,
	NVME_DIRECTIVE_CDW11_DTYPE_SHIFT			= 8,
	NVME_DIRECTIVE_CDW11_DPSEC_SHIFT			= 16,
	NVME_DIRECTIVE_CDW11_DOPER_MASK				= 0xff,
	NVME_DIRECTIVE_CDW11_DTYPE_MASK				= 0xff,
	NVME_DIRECTIVE_CDW11_DPSEC_MASK				= 0xffff,
        [...]
};

