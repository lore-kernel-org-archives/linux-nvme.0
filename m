Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA07C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEyC0/nrUS4sC4gtrmv2XP7UM5muRnnz2RETfLi85PM=; b=MkEYngV+ay4XKfNxuiC6uce4Gv
	FmM/G4x/FZfoIIJ4nEjbKQHQb+wOJSdun3Pqf7uPo6PUTIkPb8I9vC9Hyz/LaHD0D7pIo3vNbG6Pc
	a/mkWaTuqL46z8jNMp7ArT1PNUdWZjGdiFIxTgNWlhkBpxWYjyDM+TdV/VTFlwda5iHVe9e7Dtrf+
	h7Jrx6I7QN3fUTbwkiWIebY+K1ldHHOml5mAY+HRBfHSa0DKKCDwRNeX3V55sF7bf8MkAoQgHagef
	AkmtkwcMsBk/Msv7fwjNWLsgTsO4sKeYKEslgEP3FvFzjlUz3knXLRFvMNRbN0R7/ivw0MsamOOjF
	Y3pRicIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXw7-000pz8-0C;
	Wed, 29 Mar 2023 15:42:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXw4-000puz-1v
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:42:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAD81FDF9;
	Wed, 29 Mar 2023 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680104513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyC0/nrUS4sC4gtrmv2XP7UM5muRnnz2RETfLi85PM=;
	b=xCdDxHLPse7GKNRI2yW5ttRflbNFztxNvrTcRMjtVWVrDa64Dhie4sGX5/5hApPwwdn8Ji
	VZ8CThsfTzLVhPJ6VAGMGNTM8vAnWeHl9cCe1GIAa5yZeiE7UzOHiI2enPXtc9JrJli9wT
	ODUIccTtbbSSmCoqhgmoX3H5kYetv1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680104513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyC0/nrUS4sC4gtrmv2XP7UM5muRnnz2RETfLi85PM=;
	b=LpSOXSAPOGWTT2cQOVj46iyOhm2A8HDo3GiNgSYCyNstBnX4edqbXzwXmwx/ij61h5RBND
	Z4ibSIy7U0YEy2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAA65139D3;
	Wed, 29 Mar 2023 15:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BsJZOEBcJGQuXwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 29 Mar 2023 15:41:52 +0000
Message-ID: <d97fa181-077a-6183-bdd2-17ad51b0fbc9@suse.de>
Date: Wed, 29 Mar 2023 17:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/18] net/tls: implement ->read_sock()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-6-hare@suse.de>
 <d177a5d6-3f76-4eee-0cc5-2c6d995c2e8a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d177a5d6-3f76-4eee-0cc5-2c6d995c2e8a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_084204_784409_6851321C 
X-CRM114-Status: GOOD (  11.74  )
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

On 3/29/23 17:37, Sagi Grimberg wrote:
> 
>> Implement ->read_sock() function for use with nvme-tcp.
> 
> Nice.
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Cc: Boris Pismenny <boris.pismenny@gmail.com>
> 
> Would be great to see a tls_device implementation as well.

Sheesh. But first we would need to update the tls_device implementation 
to TLS 1.3:

int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
[ .. ]
         crypto_info = &ctx->crypto_send.info;
         if (crypto_info->version != TLS_1_2_VERSION) {
                 rc = -EOPNOTSUPP;
                 goto release_netdev;
         }

which I'd rather defer to Boris or whoever maintains the hardware.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


