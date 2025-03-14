Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D10C35FF9
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=siM4mfqJ+j6Bu50tGy78bObN2ma9GftqWMTVUMvckJs=; b=NQEY3CNCip1zdUiD/JHlZiXKJ1
	qOGi3A9CAaD13SatfSyHBw9h1r2LK2nDur6pCacbPDmTTi1TXwOAn6+67SRMtWq6ZK8rwHTZh1zlA
	h0xHVrkDOvdz1PWdPPK5bNvQc5/p3VeCtV1FLwB4zxleYtOqx7p5OTPFiRSbCSUTXCpz+Rcl2+2aC
	w+GSFDy4aAB+N6sTh5yE+IFIQTOqT20V/nCM2WJN78GLcsp4RXpZzBPcPpXQx42nk+5Vs221eBR8u
	dAZjZmhOKv/vb2Bs76gisHiDzb/trD3ui28NDYRtRAd65K+j3Ka9I1bnteRdzHjgEt1/cvE5yOWtm
	cqdcKO1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt0lI-0000000DXJm-1o8T;
	Fri, 14 Mar 2025 08:51:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt0S0-0000000DU3E-0QPk
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 08:31:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C129221184;
	Fri, 14 Mar 2025 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741941084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siM4mfqJ+j6Bu50tGy78bObN2ma9GftqWMTVUMvckJs=;
	b=RnlE6T7dsPAs0tyw61oIG0CUnJYV+Tvm4epf5fW9s0zWMNMktLnpLIq01RxzseTcn+Eo8X
	opYwhSlezewRvRWtut0zPzFkGDLBCxuk1mbr0ZQ+DKz1XKs4RpmReLZGwAMaiKwR59x/O+
	zGR+19D7cqOSj6noXU8mxU5JQPFUNL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741941084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siM4mfqJ+j6Bu50tGy78bObN2ma9GftqWMTVUMvckJs=;
	b=nhnKOBavGgVjZQVv9QqxIURT+mTVzeXVvym1qek8NuEd7OfTYxJP7uw8VQaPfiu4Dcmk/b
	qj/B4CTEFYDJrGBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RnlE6T7d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nhnKOBav
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741941084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siM4mfqJ+j6Bu50tGy78bObN2ma9GftqWMTVUMvckJs=;
	b=RnlE6T7dsPAs0tyw61oIG0CUnJYV+Tvm4epf5fW9s0zWMNMktLnpLIq01RxzseTcn+Eo8X
	opYwhSlezewRvRWtut0zPzFkGDLBCxuk1mbr0ZQ+DKz1XKs4RpmReLZGwAMaiKwR59x/O+
	zGR+19D7cqOSj6noXU8mxU5JQPFUNL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741941084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siM4mfqJ+j6Bu50tGy78bObN2ma9GftqWMTVUMvckJs=;
	b=nhnKOBavGgVjZQVv9QqxIURT+mTVzeXVvym1qek8NuEd7OfTYxJP7uw8VQaPfiu4Dcmk/b
	qj/B4CTEFYDJrGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 563CF13A31;
	Fri, 14 Mar 2025 08:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AM8cE1zp02d3PwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 14 Mar 2025 08:31:24 +0000
Message-ID: <d6df4f45-8cef-423d-af7d-1df19cdef010@suse.de>
Date: Fri, 14 Mar 2025 09:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] nvmet: Add NVMe target mdev/vfio driver
To: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, sagi@grimberg.me,
 joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
 kvm@vger.kernel.org, kwankhede@nvidia.com, alex.williamson@redhat.com,
 mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313064743.GA10198@lst.de>
 <d1104f67-30e3-4397-bee0-5d8e81439fc3@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d1104f67-30e3-4397-bee0-5d8e81439fc3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C129221184
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_013128_285907_5075BAC3 
X-CRM114-Status: GOOD (  15.41  )
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

On 3/13/25 18:17, Mike Christie wrote:
> On 3/13/25 1:47 AM, Christoph Hellwig wrote:
>> On Thu, Mar 13, 2025 at 12:18:01AM -0500, Mike Christie wrote:
>>>
>>> If we agree on a new virtual NVMe driver being ok, why mdev vs vhost?
>>> =====================================================================
>>> The problem with a vhost nvme is:
>>>
>>> 2.1. If we do a fully vhost nvmet solution, it will require new guest
>>> drivers that present NVMe interfaces to userspace then perform the
>>> vhost spec on the backend like how vhost-scsi does.
>>>
>>> I don't want to implement a windows or even a linux nvme vhost
>>> driver. I don't think anyone wants the extra headache.
>>
>> As in a nvme-virtio spec?  Note that I suspect you could use the
>> vhost infrastructure for something that isn't virtio, but it would> be a fair amount of work.
> 
> Yeah, for this option 2.1 I meant a full nvme-virtio spec.
> 
> (forgot to cc Hannes's so cc'ing him now)
> 
And it really is a bit pointless. A nvme-virtio spec would, in the end 
of the day, result in a virtio pci driver in the guest. Which then 
speaks nvme over the virtio protocol.

But we already _have_ a nvme-pci driver, so the benefits of that
approach would be ... questionable.
OTOH, virtio-nvme really should be a fabrics driver, as it's running
nvme over another transport protocol.
Then you could do proper SGL mapping etc.
_But_ you would need another guest driver for that, which brings it's
own set of problems. Not to mention the problem that you would have
to update the spec for that, as you need another transport identifier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

