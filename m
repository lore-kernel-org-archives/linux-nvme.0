Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10BC636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3TTXzje6yITYFhaF7w4ZKQmod5vWOeXQ504ZVJyoK7Y=; b=iueVpIRo073HZ6MdUodrCE9zxb
	B4dM6Gw6jgDC+F7w/+gkRNKaEqHTkMCb7U/9J4sv7BFrhN7wYT1+J0OdKM2C2pTxa2ZGddrYkAwSf
	0h/dXLQxIti+jRy0Wd7z8+Kq647AGJkFGqXT9AW1zulefHKwlpRz41lPznoE3UlfPdYgsyyE1icJK
	OJ4IhLGONWQ10rm6LqArc9Kl970aT2B9W3MMQeJKaXnyBcPKvV+1HGynHszywgV2T37/6SgoEG1my
	1ABI5reZuDnEdC5PnCj/owAId0hjUixhV+0u0sENPA1HTbr43FJGuyjXCWuYM7veiuiN27w1CoqFh
	kVdbtQSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPltj-00FzcQ-Lj; Wed, 08 Feb 2023 14:58:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPltg-00Fza7-Vs
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 14:58:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F37531F8A6;
	Wed,  8 Feb 2023 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675868282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TTXzje6yITYFhaF7w4ZKQmod5vWOeXQ504ZVJyoK7Y=;
	b=r2/Q85MmwMnijUfuxcmaaFFI48dxea71Rj02K9H26oMNJoVTLDsjQNsPlFzM39yKzPk5Sf
	4DcukcbtUS2BgrO8EFrhSPD3IixtdytVZUPu1CtXgapF7uUaft4IVexqSge6Aohc5tHzWi
	8G+9k4DRRVFO8EDLMJQFiba7qDtPPh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675868282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TTXzje6yITYFhaF7w4ZKQmod5vWOeXQ504ZVJyoK7Y=;
	b=ZrLhz7zvAtvdJrvK4o4vXXnoCgk9JeiAXO4v+HR6RaYoGJu30cHjP02/h5i3k3fAGsuWca
	hmpjoxDn+MMfYdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E506E13425;
	Wed,  8 Feb 2023 14:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Pu2HN3m442NgMwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 08 Feb 2023 14:58:01 +0000
Message-ID: <f9acea37-2a84-f174-8bc4-90f7f07281ba@suse.de>
Date: Wed, 8 Feb 2023 15:58:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] nvme: retry internal commands if DNR status bit is
 not set
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230208084939.145257-1-hare@suse.de>
 <CGME20230208085444epcas5p38a75bedb706daaf7828b6c98e38aa2da@epcas5p3.samsung.com>
 <20230208084939.145257-3-hare@suse.de> <20230208140233.GA13408@green5>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230208140233.GA13408@green5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_065809_252859_0089614C 
X-CRM114-Status: GOOD (  15.83  )
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

On 2/8/23 15:02, Kanchan Joshi wrote:
> On Wed, Feb 08, 2023 at 09:49:38AM +0100, Hannes Reinecke wrote:
>> Add a 'retry' argument to __nvme_alloc_rq() to instruct
>> the function to not set the FAILFAST_DRIVER bit for the command,
>> causing it to be retried in nvme_decide_disposition() if the DNR
>> bit is not set in the command result.
>> And modify the authentication code to allow for retries.
> 
> 
> This new argument is sent as true only at one place.
> Will it be better to have that case handled in that place itself?
> By clearing REQ_FAILFAST_DRIVER bit from req->cmd_flags in auth code.
> 
Good point. Will be resending.

Cheers,

Hannes


