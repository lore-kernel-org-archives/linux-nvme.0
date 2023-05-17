Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08868C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrvDpGuHl+TqVC6c+w/rHc46lwWEj6Zn9IHb2K2L80o=; b=Mw/OatUIlT+3bnQpguVjY2XylX
	cEskVVA32wh6o0FUQVlPCS561X8q+eL/JUB5ARNaGI3yGN+Hh/x1M4w7DQWQj9Qn7C3WB+S4FgaZt
	SHTQkpZNLI6GWab83+MFGuFWPmJjEpwBWIj9XDHFc37BgHspJDc4BRCXX/w3L1Opu56HYTltJ2ZkE
	Kk/lfE38Nsbt/fLcNHCfL67N+1OzyVNGZSPManrTOwUhwxgC8HOkb5v7GqzWvSYZRBuxnbIbHXuzg
	4eZc8T9f/vt9JQBGaNl9nZ0tb6dscSP7TdEmE6yiG+y4+hvirqW5uAJLyRF13Il4RQzO8UJrAqBjh
	dt6D97hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC14-008kzs-35;
	Wed, 17 May 2023 07:56:10 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC12-008kwt-0E
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:56:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03E2522903;
	Wed, 17 May 2023 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1684310165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrvDpGuHl+TqVC6c+w/rHc46lwWEj6Zn9IHb2K2L80o=;
	b=qb7tUKf6NfH2rkHJtQtJKV4Z1yn/E02xHG55cBjZ3ijLcYZxTOjQWabB84NOwD1h8VzGPm
	+YIIFbYZJiv/j0fnpkV0iExrJ5nOCMG7vyc4o6pneLeR8HWTizeexbKZon6MQh6CXWiZDE
	tsI081gxnEeVQZnAR8QbDj6K/gO/EDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684310165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrvDpGuHl+TqVC6c+w/rHc46lwWEj6Zn9IHb2K2L80o=;
	b=bEM7ZXoWaPE4ijGPgX4V2woHCcQxcRbY48HDkSFihr/GMuJW3c+NFNcCZnS7Fg/l1NaONP
	SY7AKW3unXZD7SDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3CB613358;
	Wed, 17 May 2023 07:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nsJ4KpSIZGRCGwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 17 May 2023 07:56:04 +0000
Message-ID: <4d1f5afe-628c-ee5b-c6b9-59d59c184f42@suse.de>
Date: Wed, 17 May 2023 09:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>,
 David Howells <dhowells@redhat.com>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-7-hare@suse.de>
 <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
 <20230509174724.4a198306@kernel.org>
 <0097e7c0-351a-b922-dd77-ab414b53170b@grimberg.me>
 <c711fc3b-08c4-6673-0f22-f73bf377a072@suse.de>
 <20230517075444.GA30685@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230517075444.GA30685@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_005608_256541_C7B41C6A 
X-CRM114-Status: GOOD (  13.57  )
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

On 5/17/23 09:54, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 09:53:10AM +0200, Hannes Reinecke wrote:
>> Problem is the MSG_SPLIC patchset from David Howells; that essentially does
>> away with ->sendpage().
>> So I'm not sure how to go from here; wait for the patchset to land, and
>> rebase my patches on top of that, or proactively switch away from
>> ->sendpage() and resubmit directly.
> 
> I'd wait for it.  It should make life a lot simpler.
> 
Same thought here.
Let's see.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


