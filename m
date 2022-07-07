Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235A7C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+bmMEifozR/8jnz08gE5A+SDHU6RUN4Cov1EIxzyl8=; b=tuYjYMynun5Q/lj6FSDdT9i/sE
	3Xy4X7iSxti4M7X/KQu7oLPLUOOKWLBbjEM9ovrHnVqqpkrtGZYPa/hdzqOZkP5XRKNNRFRrMdZNg
	LbvCK2erbOwQWwvKJGbcPN8W877x65ymSm80cgYwefi1p9XUt4GlQBSVer66JU6kQxPAEI6zy6NBo
	h65SilaQEthrSzySqR3PGhr8UabQ1wmqweum2CtvUsGHKFLuqRdxcIlM3Pe4xWzLkmTgLLkp0t5QY
	H0dmP0LZHAMwSpuJutk8BFs0qdecAtTwD7ACF8HhPZY3wnBgYyt7rtRfdxWluF0Xv7A7ClSsiLexQ
	r7W9EmBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9KTF-00Dph0-1O; Thu, 07 Jul 2022 05:54:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9KTB-00DpgV-Cf
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 05:54:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11DAA1F920;
	Thu,  7 Jul 2022 05:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657173270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+bmMEifozR/8jnz08gE5A+SDHU6RUN4Cov1EIxzyl8=;
	b=g7h/m+AzQRbkHxEVkKyrWQ+QCP28qCtK8YaTuDdBpqp79UtxrP1PkAkT6uVUGxOngVom9S
	Q89PiMil+wiBk/nEmvSrTGEABXSMrXTRerfNxRGNHCGHOJhAV+COxXQkOt7bLtT8qBG/G8
	ud8h7A2yjp+8B810xIclaIGuzwQ1O4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657173270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+bmMEifozR/8jnz08gE5A+SDHU6RUN4Cov1EIxzyl8=;
	b=6ylu1PHA84inuT4gRjLYt411t0AokuiF4x+/D2UY6BPrnaTAzm9e48r6VEXKk4ryKEixod
	3wCyOAcYWEl0XwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E760913488;
	Thu,  7 Jul 2022 05:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VMHJNxV1xmJMNAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 07 Jul 2022 05:54:29 +0000
Message-ID: <872e0129-35ba-0480-0c83-960adc1ab737@suse.de>
Date: Thu, 7 Jul 2022 07:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCHv18 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220627095207.105201-1-hare@suse.de>
 <b08b8df2-b278-21dc-aff0-b126a70363f5@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b08b8df2-b278-21dc-aff0-b126a70363f5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_225433_616191_D271A551 
X-CRM114-Status: GOOD (  21.83  )
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

On 6/27/22 23:34, Chaitanya Kulkarni wrote:
> On 6/27/22 02:51, Hannes Reinecke wrote:
>> Hi all,
>>
>> recent updates to the NVMe spec have added definitions for in-band
>> authentication, and seeing that it provides some real benefit
>> especially for NVMe-TCP here's an attempt to implement it.
>>
>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>> to provide us with a FFDHE implementation; I've updated the patchset
>> to use the ephemeral key generation provided there.
>>
>> Note that this is just for in-band authentication. Secure
>> concatenation (ie starting TLS with the negotiated parameters)
>> requires a TLS handshake, which the in-kernel TLS implementation
>> does not provide. This is being worked on with a different patchset
>> which is still WIP.
>>
>> The nvme-cli support has already been merged; please use the latest
>> nvme-cli git repository to build the most recent version.
>>
>> A copy of this patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>> branch auth.v17
>>
>> The patchset is being cut against nvme-5.20.
>>
> 
> I was able to run the V5 of blktets on this version see log below.
> 
> I am seeing few error messages when I run with tcp and loop,
> please have a look to make sure they are the expected ones.
> 
> In case they are expected ones lets filter them out since it will
> create confusion and people will start reporting these issues.
> 
As indicated in my earlier mail, these errors _are_ expected, as we also 
have to check if authentication fails is there's a mismatch of the 
authentication keys.

But an authentication failure is an event which the admin definitely 
should be made aware, so the kernel message is warranted.

So I'm not sure how one could filter them out ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

