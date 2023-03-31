Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F70C6FD18
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LJLdpTifbWu/NCZqsThk4lhL367AO5FzmVb5gHQL1I=; b=xZyxCuzyEFKARrwFoLzaREr+Mg
	cGKDF1v0NP0zKk0HFTtSHJOHBPeFxM2OV/iA2apO/nqvcIRAMOVBeUf5q5A00jfK3FSwRIsRxhcL+
	E0zIt502yzjdk6g68fRatZo+5afHnBDyovBhzAanh/Vd8px3iZubdoSJrsc9LYeHFMupqpYLbtQwN
	XGoETWom0H37cKojQ0ab1HfJdg9uPSdiC8sskJi3hiYHQL+dhsa7mX+zZrCIxYvNxUnNLfb2+UkIg
	RcrSKiWI3BRk6QPhRSs3trlOfR4T+9BnhsdQM3woCGRlsfbflMr047IKFVimHhg/oXgI0AUREI3dB
	AlO1IKpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi7r9-005y6O-0X;
	Fri, 31 Mar 2023 06:03:23 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi7r5-005y55-1p
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 06:03:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62F7421AD8;
	Fri, 31 Mar 2023 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680242595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LJLdpTifbWu/NCZqsThk4lhL367AO5FzmVb5gHQL1I=;
	b=EvfitK98rEkxTjr9Gf5JVZ8YVrIFBKyst9v8/QgRdtlRN1EjqHNyAXgrHP++rzUEzNAPNn
	Yc7efdCR0IvTnixcjRdl63Y8qw+qg+CixKZw+YROUofcSbhjitWhsZRVV/TRiP69KZO8QD
	2YrlZFgLG65yWPccVKWHd7NdoC/2qdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680242595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LJLdpTifbWu/NCZqsThk4lhL367AO5FzmVb5gHQL1I=;
	b=6szLB+9qXktTeIlghC8MGiUpZtjZgfPVbaO3F3Fhzq+BAhKjMyUTF1AbwdVgxHQu3uRnlD
	KGqyjHP1CLLEO0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C6E7133B6;
	Fri, 31 Mar 2023 06:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pnSoI5R3JmTyTAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 31 Mar 2023 06:03:00 +0000
Message-ID: <7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
Date: Fri, 31 Mar 2023 08:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
To: Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>,
 john.fastabend@gmail.com, Paolo Abeni <pabeni@redhat.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-11-hare@suse.de>
 <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
 <20230330224920.3a47fec9@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230330224920.3a47fec9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_230319_769174_4D58B910 
X-CRM114-Status: GOOD (  17.07  )
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

On 3/31/23 07:49, Jakub Kicinski wrote:
> On Thu, 30 Mar 2023 18:24:04 +0300 Sagi Grimberg wrote:
>>> kTLS does not support MSG_EOR flag for sendmsg(), and in general
>>> is really picky about invalid MSG_XXX flags.
>>
>> CC'ing TLS folks.
>>
>> Can't tls simply ignore MSG_EOR instead of consumers having to be
>> careful over it?
> 
> I think we can support EOR, I don't see any fundamental problem there.
> 
>>> So ensure that the MSG_EOR flags is blanked out for TLS, and that
>>> the MSG_SENDPAGE_LAST is only set if we actually do sendpage().
>>
>> You mean MSG_SENDPAGE_NOTLAST.
>>
>> It is also a bit annoying that a tls socket dictates different behavior
>> than a normal socket.
>>
>> The current logic is rather simple:
>> if more data comming:
>> 	flags = MSG_MORE | MSG_SENDPAGE_NOTLAST
>> else:
>> 	flags = MSG_EOR
>>
>> Would like to keep it that way for tls as well. Can someone
>> explain why this is a problem with tls?
> 
> Some of the flags are call specific, others may be internal to the
> networking stack (e.g. the DECRYPTED flag). Old protocols didn't do
> any validation because people coded more haphazardly in the 90s.
> This lack of validation is a major source of technical debt :(

A-ha. So what is the plan?
Should the stack validate flags?
And should the rules for validating be the same for all protocols?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


