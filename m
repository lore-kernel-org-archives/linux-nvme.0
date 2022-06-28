Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04597C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAJbD3vx8KR/eygqXryj23Hlgyod22SrbYzjShp9Qks=; b=4pv0y5fEsGJAkeN+i5GpgFOKkb
	ZbfLI+pdtEWZhUIWPa3carIRI+m6VD8u1GakkJeMfp+Mgr+miMvi1AoEiyTP6CxstJ3ZsWNvHweFF
	NcRFvhNjTABAQlhDBMV835detAUMeT06Iu+6Y3RETN7LSh3LveTSQW4hSZuOvef+DWlo2HQxA7i2+
	fHZbeXjlethewPETd9XzPoBFAn9UcXsN8GL7qIWfQX/QKiIntN0sJiit3jeVydZ1jOrwEjzBmWPGv
	tbGFediW8qwKFolLLGCPGyeuqZMAcLET+uV1ZEwQRz2YQ4kB8NP9TXdoNR6riCWmx2YhCnFysfix6
	Falz5TMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o64TZ-004cwG-2g; Tue, 28 Jun 2022 06:13:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o64LX-004Yc7-NY
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 06:05:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF9E21FA5C;
	Tue, 28 Jun 2022 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656396306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAJbD3vx8KR/eygqXryj23Hlgyod22SrbYzjShp9Qks=;
	b=PMuSSKrhvMk8lQ+6BNOVqY7DxmhMExYS78BDQM3MOP7aGmRYqkONCokG/Tdh0YphkUBnp/
	7vy9lg4oThyclbpfPRmqM61ndgBfe+BtpbRBi2b8d6W+WwNf/Q75NFFiRlRd31QfYDyw1a
	VxKDOcYwlWhgoTCVuWKWuJXQeyEsurM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656396306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAJbD3vx8KR/eygqXryj23Hlgyod22SrbYzjShp9Qks=;
	b=cQxERa3fKLH2QfAs0KQYrziJ6mXmVQN1ZzNjvvOrnHwYoNjrh6Bc89rl0apDz58fAi3xqa
	EIKWjHfJGGUbhSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 575AF13ACA;
	Tue, 28 Jun 2022 06:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4c61NxGaumIzdQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 28 Jun 2022 06:05:05 +0000
Message-ID: <f22e7839-99dc-cb72-c28f-0cf434371919@suse.de>
Date: Tue, 28 Jun 2022 08:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
X-CRM114-CacheID: sfid-20220627_230512_007452_EB240E01 
X-CRM114-Status: GOOD (  23.30  )
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
Yes, they are.
The point of authenticated conections is that they should fail
if the authentication credentials do not match.
So we need not only test the 'good' case, but also the 'bad' case
where a connection is expected to fail.
That is being tested in test 040.

Test 043 is similar, but here it's for re-authentication; and
again it needs to fail if the authentication credentials do not
match.

> In case they are expected ones lets filter them out since it will
> create confusion and people will start reporting these issues.
> 
Sure. If you tell me how.
These are kernel messages which I deem
necessary in 'normal' operations. It's in this particular context
where they are expected and should be ignored.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

