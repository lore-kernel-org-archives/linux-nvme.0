Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9A0C05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3EUStM2ZP71mnbwFMm9R/cUFwku39s3k3WtvXCNYdsA=; b=Au9MbeRbMGY1qduxAWyMjkepPS
	v9sWYfvQxZq6lUrDsp90UqDxJM5X2LNO9YAFLK7ghTLbmknQ/XLcPF4wXDxLIzYHOx3wzpJsIUss0
	3IbKmcAsSmG9xRgqtMlYqsv533yw2KBy701dPMR4BjA4Ns0t3h4hSjB7LJf/iN0HjHt6Pw8IaQmds
	mOxcCcki0ifQ83AfGBZ3lNw+0E9rjFm39HFWItHq/k9V3ZGqoHNzicURszykKDW3p+oO4EK8V/re0
	+QyOpGLfHGjVDgv8X6a0ykg6gUJGlZKFlDEHXKgngzeXRiFrQFteg16WaUXokPkqmFWSTLCbZ3FNQ
	iqjfkrEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP1CQ-008aO1-8Y; Mon, 06 Feb 2023 13:06:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP1CL-008aME-6x
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 13:06:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DDD320E3D;
	Mon,  6 Feb 2023 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675688772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EUStM2ZP71mnbwFMm9R/cUFwku39s3k3WtvXCNYdsA=;
	b=OjGgWEiPi5+jwk2Y4wkY24vQnRlcERtZLvEFQTIg4HxULpfUmwzOGBw/t1YAoznuLSkX/k
	RRU9m09zRNdJjU15lglPqosVBksjfDDNSFQBmD+KIFgiPbVGY5YNAGle5gdr+tXgf7L1ln
	p7te4YY9c4KeNa+XiSI5tzyhjGvvHd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675688772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EUStM2ZP71mnbwFMm9R/cUFwku39s3k3WtvXCNYdsA=;
	b=6KPFoXY3ZQQviUuPrNk/1dlOPkbNBJU5Ir+CRnLv1ofCUPzagJUDibMJ/pCpANBrCOmTSN
	ai8KFIfrym50IFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80C8F138E8;
	Mon,  6 Feb 2023 13:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xzDcHkT74GNoHAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 06 Feb 2023 13:06:12 +0000
Message-ID: <855bd863-270f-b69d-0aca-319773af35a8@suse.de>
Date: Mon, 6 Feb 2023 14:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: blktests failures with v6.1
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20221223045041.dl6ivxgo25eiwy33@shindev>
 <Y6VXjztUUz7GFmAW@infradead.org>
 <aaf09ea1-9cf0-0620-2c52-7298bb3409fe@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aaf09ea1-9cf0-0620-2c52-7298bb3409fe@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_050617_445970_71CDB3E8 
X-CRM114-Status: GOOD (  12.87  )
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

On 2/6/23 08:14, Chaitanya Kulkarni wrote:
> Hannes,
> 
>>> #3: nvme/002
>>> #4: nvme/016
>>> #5: nvme/017
>>>
>>>      The test cases fail with similar messages below. Reported in June [3].
>>>      Fixes in the test cases are expected.
>>
>> I think this is related to the current NQN that Hannes added.
>> Hannes, can you look into this?
>>
> 
> These testcases are still failing on latest nvme-6.3 HEAD:-
> 
> commit baff6491448b487e920faaa117e432989cbafa89 (HEAD -> nvme-6.3,
> origin/nvme-6.3)
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Fri Jan 27 08:56:20 2023 -0800
> 
>       nvme: mask CSE effects for security receive
> 
> can you please look into these ?
> 
Indeed, these _are_ the current NQN changes; but they do work as 
designed (main change was to add an entry for the discovery subsystem in 
the discovery log page).
And as we're checking the out of the discovery log we found that things 
changed; which they have.
I'll be sending a patch for blktests.

Cheers,

Hannes


