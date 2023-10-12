Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D16CDB47E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2YtcQtO97hsuZ6EM8MKLnQLs4XY10D58R09cFKnKnc=; b=DUERpAaj0ZOOWM1Or604zM0ySd
	+tXsUxsGInEyDXxJl9QNeuswg43nfNkEFkp7B60OIcDPz9HuDJZ6n3qRQWW9RP6wBGwrhaoQMsGSz
	f/01sKdxoxncTYGnOEcZtfdSHuOD1xnQJTaOGimAj7STyS9FzJe/eKAD+sWP8v+qBAj5eRQeIPGW7
	qX/i3GMWwXNCT36VcMIja7Y/vEkuftV+fAhIpO7KV7pWZD5xIHnHWi6Y1ygjAjihh2scuCWTb+zZc
	a+HZOx7PwJIf7fBxSgkOTpuBe/1P98VmvTmZ3wqBcy+UIxl9pXh5m5BrvDQ5XzHLWcE9ypCiouSJH
	vS/HcytA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqp7e-00HYC1-1h;
	Thu, 12 Oct 2023 06:24:38 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqp7b-00HY8W-11
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 06:24:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 651CB1F88C;
	Thu, 12 Oct 2023 06:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697091868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2YtcQtO97hsuZ6EM8MKLnQLs4XY10D58R09cFKnKnc=;
	b=T+PasbDfbaaU0pULptY2UBOotqFQHaTX+TRvXR4hlyWVTAVcLltl5VHXQnxYUV1XguELIX
	kkyPN1QIe1+i7cTT8dhOnhDjm+ZlYktJdAAV8woJ8CbN2YT2bJtJAOUeBIIffrqLvQMJCZ
	CLKzwgHfXqGZKJ2vNunfjXhyMK/5Pew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697091868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2YtcQtO97hsuZ6EM8MKLnQLs4XY10D58R09cFKnKnc=;
	b=r8VRgjucMWfkKYupR/CDD0k7o23arqDWD0Ykvbiwe2oiZxjqlVsRrVbrUHKw9eeqCfxH1J
	p7bF00ZNMUXFFXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A803139F9;
	Thu, 12 Oct 2023 06:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9bdeBRyRJ2UHDQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Oct 2023 06:24:28 +0000
Message-ID: <bd2c85e7-7924-4b7c-8470-6094e4d1ea1c@suse.de>
Date: Thu, 12 Oct 2023 08:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-12-hare@suse.de>
 <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_232435_497646_06C8EB07 
X-CRM114-Status: GOOD (  15.06  )
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

On 10/11/23 19:32, Keith Busch wrote:
> On Thu, Aug 24, 2023 at 04:39:18PM +0200, Hannes Reinecke wrote:
>>   	args.ta_data = queue;
>>   	args.ta_my_peerids[0] = pskid;
>>   	args.ta_num_peerids = 1;
>> +	if (nctrl->opts->keyring)
>> +		keyring = key_serial(nctrl->opts->keyring;
> 
> The key_serial call is missing the closing ')'. I fixed it up while
> applying, but a little concerning. I'm guessing you tested with a
> previous version?
> 
Yes, I did. I've tried in this series to implement the suggestion from
Sagi to store the key serial in the 'opts' structure; hence you wouldn't
need to call key_serial here. But then backed it out again as it didn't
make sense.
But that was apparently imperfectly done :-(

> Anyway, I've applied the series to nvme-6.7 since this otherwise looks
> good. I'll let it sit there a day and send a pull request to Jens if the
> build bots don't complain.

Thank you!

I had been wondering if I needed another resend...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


