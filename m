Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2F7FA3741
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 17:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gzv5+nMPKnMWp/zJk3KrqLVcV2rliO8dz64VfVNCa8=; b=UaolyVClaOtVoEusuiPCYMILSP
	KDS/dkojSV5ehb06Cq1J25dyst91Bjx2H+9mp0hMZrABFHDxlsAXKfiywwnZwu+pyx/wkQPF5akMT
	NKcsH72Qa3m24BakFkxXyvSJE3K6cPunpFiWpqGsf0EtNaqXT9HPhLwoRdOHqfdBIn/hx3k5o0AEI
	hpoz4jLcRe4D7rRbgagFnTaKRj1jmQnAUhTuCa38wsQ+XBcT7UXLGE7jRo46GTL04AkY3+jqJowzE
	afP9UVSIyjc3ny10X/Eey3bDGynH83bh8iu45+c3qCv4CwxMnqs+TWBSHBxKW1Ii6A1wpnyVsE4u4
	8AJFABig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opYrw-00DUHN-83; Mon, 31 Oct 2022 17:46:40 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opYrt-00DUE9-NX
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 17:46:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 927041F8BD;
	Mon, 31 Oct 2022 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667238389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gzv5+nMPKnMWp/zJk3KrqLVcV2rliO8dz64VfVNCa8=;
	b=GGAIw+cNk9GlxllPBKLfa8ffRIGi8tSJpMApW5UBEXgOaoMUgA/as7PV7Sl5VSyszHtv+J
	EHK3vCyZmjQHMykLLFMbdvN5R9oS7VlbFRZicX6HN1vd09FUP99jI56dtiwjxvAeiyZs/Q
	PZVkUdBWSXl9vncxvxeRdCZzPHe9ec4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667238389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gzv5+nMPKnMWp/zJk3KrqLVcV2rliO8dz64VfVNCa8=;
	b=MeKCQivlUPgHGWvrcd2mLKkoIqIGjCU2p3UwKEfsCzua3bO/FFxyYnfQAYiihh3rBuQDYJ
	YghWg3apsfI+RGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7209D13AAD;
	Mon, 31 Oct 2022 17:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ivD4GvUJYGN7YAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 31 Oct 2022 17:46:29 +0000
Message-ID: <b403e9cc-5539-18e1-bfb9-fbb8d75fa32b@suse.de>
Date: Mon, 31 Oct 2022 18:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] nvme-auth: allocate authentication buffer only during
 transaction
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20221028135027.116044-1-hare@suse.de>
 <20221028135027.116044-2-hare@suse.de> <20221030075230.GD4214@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221030075230.GD4214@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_104637_954981_55E9689C 
X-CRM114-Status: GOOD (  14.44  )
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

On 10/30/22 08:52, Christoph Hellwig wrote:
>> +
>> +	/*
>> +	 * Allocate a large enough buffer for the entire negotiation:
>> +	 * 4k should be enough to ffdhe8192.
> 
> should or is?
> 
Well, is.

>> +	chap->buf_size = 4096;
> 
> why do we even need the buf_size member if it is constant?
> 
Will be hardcoding it.

>> +	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
> 
> I think this needs to be GFP_NOIO as we can hit this during a reconnect.
Will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


