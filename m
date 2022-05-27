Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD697C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r847XQ0d5S6Cd8DX0ImmONalPnfrBt+aQgcTMcDUKpY=; b=3OShSQbCWwZSj0GSUv9HFWOLA9
	Mkoxb8JvsZwFWI+otEMNg0EydCc/jBIATjZzRvjU6XunxzNUmaOAuu2U63RIroaV1WA4XKvkSZ2H0
	y5oduXGPE71bhAOF6YhF0WZ84Q634juBxpN6id2BOaxY8hyvJpnkBCGhjcndelp/ax1nl6D9lB9i7
	sVakndmrVd7UmsIycnz5WHjnjJCuGofR6LjyrQe63d2zRFVcNzVeTj46Zsi1aEBbXSBrv3zOJEV7M
	WJUBHms3XOyNgZn4df6GahVaQpwbZycf7R+l5mr2mBu0dQcgCH9SZm7k4WbK/aMsPT0r0hy4dUFkl
	9o3kfLiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSs8-00Ghxx-Dd; Fri, 27 May 2022 05:50:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSs5-00Ghvz-HG
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 05:50:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EE0B1F8D5;
	Fri, 27 May 2022 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1653630643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r847XQ0d5S6Cd8DX0ImmONalPnfrBt+aQgcTMcDUKpY=;
	b=liEf9Yn0Tny6FXfccUelxNNUnSJuL4PLFI6JFrX8kAP4nbOf0ZXYMd2DjW34kM+sdktAc4
	KJEwuoO6RvoaZgnV55sSX5RvQb8bXI7OJePMOXds8EV3CcZgt1UkqO7SKFxXH/n9AGspeN
	O60lkSDsWnYuXjeKNlIeK1GUWep6iUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1653630643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r847XQ0d5S6Cd8DX0ImmONalPnfrBt+aQgcTMcDUKpY=;
	b=hxDvBWsnrK3fab0i2YJq1kjvOq67cFqWjncQKb7pdLxO0gDJOrsv3hvH/ScQqsKGPqpsYX
	vHD6g7Yrz/OEq2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CAC21346B;
	Fri, 27 May 2022 05:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LlpLArNmkGKAAgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 27 May 2022 05:50:43 +0000
Message-ID: <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de>
Date: Fri, 27 May 2022 07:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20220518112234.24264-1-hare@suse.de>
 <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
 <20220526090056.GA27050@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220526090056.GA27050@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_225049_755046_048EEBF4 
X-CRM114-Status: GOOD (  13.02  )
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

On 5/26/22 11:00, Christoph Hellwig wrote:
> On Wed, May 25, 2022 at 11:54:54AM +0200, Hannes Reinecke wrote:
>> How do we proceed here?
>> This has been lingering for quite some time now, without any real progress.
> 
> As said it is a high priority for the upcoming merge window.  But we
> also really need reviews from the crypto maintainers for the crypto
> patches, without that I can't merge the series even if I'd like to.

Hmm. Guess I can remove those helpers; after all,
both are just wrappers around existing exported helpers.
I'll resend.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

