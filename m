Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB08C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=; b=L/KWf/OXHQwpNrjbNVIyvbWiwi
	rtMvz8n8uTcG+WPL3SbAcnE5IWO7cYyW1Sh8cwoY/IVYgfQsBcBAiB+tnY0hEp9Rw1t2/ad84NdwV
	5KV6fzyzPg5VRzIPigIC7zJbjT5KS8OLqb/tbDqvfJSS5KL8uwPRyzU+EKmVxEb424vJxJflZH742
	F51f6eiGkp3p/eNR96zpNVjYKipkgy56zcEgozMcgfuCE8pzFDExidrMnWdJ+fFDPWDYWlbUoPgwr
	tLloP3nkOh2+H2PZvM6SM0T0JpmnJSdz5WZvwzGXvvKmQI2yGXzlxCxy5RFpMsoh9pfpZf+v+A1HA
	n7bTx5/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBf8-00000004EUg-2GlU;
	Thu, 07 Mar 2024 11:11:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBep-00000004EH1-1zmy
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:11:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FAEA8C697;
	Thu,  7 Mar 2024 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=1PNcKul5pYqaLADNEX7AzDdtYPvuKZjN7bfPn0t8vcwv0YCGYCALhebIjgPoY9/HjsdUCd
	s3uYpkl1rrrnkSDR+d6qZJwsswO5GSqv8MDW95dt6MKM+MPhZwBLD0yad9DkENaFXHSEzU
	8s1cGSJvNrpbgTJHG+Fp4Oo7lxfVZOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=HRUK/dSwa271duD6NAMCoOoIjSh2k/RNqOf0VFq2STc1x41C6DNlW8dcHe9PDbcvAgLpiS
	AAM2OE3T93YwEfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=1PNcKul5pYqaLADNEX7AzDdtYPvuKZjN7bfPn0t8vcwv0YCGYCALhebIjgPoY9/HjsdUCd
	s3uYpkl1rrrnkSDR+d6qZJwsswO5GSqv8MDW95dt6MKM+MPhZwBLD0yad9DkENaFXHSEzU
	8s1cGSJvNrpbgTJHG+Fp4Oo7lxfVZOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=HRUK/dSwa271duD6NAMCoOoIjSh2k/RNqOf0VFq2STc1x41C6DNlW8dcHe9PDbcvAgLpiS
	AAM2OE3T93YwEfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32678136BA;
	Thu,  7 Mar 2024 10:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHnZC9WY6WUGKwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 10:37:09 +0000
Message-ID: <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
Date: Thu, 7 Mar 2024 11:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.17)[88.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_031128_208862_01B59BE9 
X-CRM114-Status: GOOD (  15.73  )
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

On 3/7/24 09:00, Sagi Grimberg wrote:
> 
> On 05/03/2024 10:00, Daniel Wagner wrote:
>> I've picked up Hannes' DNR patches. In short the make the transports 
>> behave the same way when the DNR bit set on a re-connect attempt. We
>> had a discussion this
>> topic in the past and if I got this right we all agreed is that the 
>> host should honor the DNR bit on a connect attempt [1]
> Umm, I don't recall this being conclusive though. The spec ought to be 
> clearer here I think.

I've asked the NVMexpress fmds group, and the response was pretty 
unanimous that the DNR bit on connect should be evaluated.

>>
>> The nvme/045 test case (authentication tests) in blktests is a good 
>> test case for this after extending it slightly. TCP and RDMA try to
>> reconnect with an
>> invalid key over and over again, while loop and FC stop after the 
>> first fail.
> 
> Who says that invalid key is a permanent failure though?
> 
See the response to the other patchset.
'Invalid key' in this context means that the _client_ evaluated the key 
as invalid, ie the key is unusable for the client.
As the key is passed in via the commandline there is no way the client
can ever change the value here, and no amount of retry will change 
things here. That's what we try to fix.

The controller surely can return an invalid key, but that's part of
the authenticaion protocol and will be evaluated differently.

Cheers,

Hannes


