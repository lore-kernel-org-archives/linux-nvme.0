Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABBCC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9tDs5Yc8B7Cv9pvLYNDhrDtLhOZATHUhQak+t8eJZI=; b=OiP8eLR9/XrIaaBCx5caLWPdrE
	n/3Qs5QB74KWLQbboYMllzE9s/qucYfraLzf7j4QTy5dBQxZODin4CUM5IbSaoTeF1m2L80sGTS7w
	tzX+BbwSE0w9tnkWpjPkCClRK2Al84PYwRnm2UT+Cygf4Tnjjqfr6vkFobZnoW/HIHou8+p0L/vtK
	or/mCa/d/aIgJgSrepHuWmfK4xjIhwl3f+9mMYRgVcd53k5MQvw+U6hvgjRp7+db/R8p952g23tKm
	1eIn20Tf9DTOSitn6fMz8H4DyGWRN4US9N2yZZsckrCPjPBCYRsvLvk1z8qf2ikWgYYnW4me/MT9e
	ytdCYC7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5eV-007iqR-36;
	Thu, 10 Aug 2023 13:24:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5eT-007ipg-0X
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:24:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E419D211BD;
	Thu, 10 Aug 2023 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691673871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9tDs5Yc8B7Cv9pvLYNDhrDtLhOZATHUhQak+t8eJZI=;
	b=NhCU9a5QhHT4cfcdlbsS1+X0Eyo3qrFXgTXu5zDrNWIXSCpxfxpQnKtAOogTo/IrEV8Ih3
	+h/MAgpLdJKzmOpRz5QuC+RkenweigkaxJgtfXIYxxSLidlujtUU9dX+TXbBJ75z/3hIXp
	3UM0GPZbSjmS24FNVBBvEQGXIdpLYN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691673871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9tDs5Yc8B7Cv9pvLYNDhrDtLhOZATHUhQak+t8eJZI=;
	b=cT72rnSi0Cpqw98ur9F6gU1T6FhVOnd9rBjcmdl5AhutC0dThbyoDbllony5/NBA/TxFef
	Hgx94OKJ9B+LK8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5838138E2;
	Thu, 10 Aug 2023 13:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KH3pKg/l1GSxaQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:24:31 +0000
Message-ID: <a7ca8d28-9c28-4eba-a21b-26579f5053e4@suse.de>
Date: Thu, 10 Aug 2023 15:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_062433_351160_95D8AA05 
X-CRM114-Status: GOOD (  16.14  )
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

On 8/10/23 14:03, Sagi Grimberg wrote:
> 
>> Currently nvme-cli is able to resolve an ip address from a dns name if
>> traddr argument was given as a dns name, so it does that and passes down
>> to the kernel the resolved ip address.
>>
>> However, if the dns resolution changes over time, the kernel will not
>> be able to reconnect because it has a stale ip address. While this is
>> not a real use case for nvme subsystems, it could be a valid use-case
>> for discovery controllers, where the resolution is made from a dns
>> name that may load-balance/failover over multiple endpoints.
>>
>> The last patch (7/6) is for libnvme to pass down the traddr as a dns
>> name if the kernel supports dns queries.
>>
>> The inspiration was taken from the nfs client that does this for
>> redirects or locations discovery.
>>
>> It is an rfc, so feedback is welcome.
> 
> So I get that there is zero appetite to support this?
No, actually not.

I'm pretty much in favour of it.

Hmm. Probably should send a review ... wait ...

Cheers,

Hannes


