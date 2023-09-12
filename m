Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D3CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwmGZ9ZIsFr5+FhaoWy67xUl8qAegsPsD0NNjSZLQVU=; b=1SRdu7QTVKOCLQb7OyWTmJr8W/
	Jz4LOn6a4MGY0fftNPVh1f71mpgnT9YvOlJ2TFyqAo7TxE1FFH7Q2fAqolVe9u9nm0yId5XWubBtU
	Wp7GhbvkbdhRgBcuvp/FL+Xj4nUunklunbq5L/4GlaFWccqJhXtdAnMu+xTXgX1q6McT6AAOetCAf
	LKV0t6i8Yy2WixXOXckL1UN/zsGnpL5W0JBP/VXA4ExWvv1LDaHhHsmWa7igrXhnswuvmAZq9yGKD
	I10e7rPLBBhX9EuYiy7c6HmvLJhuB73AyCvtvaBHpadY0tBH6RlKUUArXYTW/h4uS3RIgH2tk9E+y
	1chjLEkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg22J-003H8w-05;
	Tue, 12 Sep 2023 11:58:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg22G-003Gj2-2j
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:58:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDE621F8CD;
	Tue, 12 Sep 2023 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694519773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwmGZ9ZIsFr5+FhaoWy67xUl8qAegsPsD0NNjSZLQVU=;
	b=qbc3YB1MoUktjCJxF/P4ApfLzfLGRKT503FcWT8Yp/RGHiR9XKwI2WVAckLEWE6vcwAEUJ
	nWuScVYuw82F46X3TI4luA1F+KUHyM09YBi5fVImdcPBC1GTs26J8dm9bToK4xGdPamO/H
	qNQ8xSf3+mMGV9HgQkjd1E0CkL+2YOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694519773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwmGZ9ZIsFr5+FhaoWy67xUl8qAegsPsD0NNjSZLQVU=;
	b=C6D1DDzTDQweZdZeuuB2JNsW0P8fmWnNjgRaw9huf2Y+4FksbyZmQadynbx2uveuna3O0F
	agc6ElQD9A94aRAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5276139DB;
	Tue, 12 Sep 2023 11:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9uuoM91RAGWyBQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 11:56:13 +0000
Message-ID: <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
Date: Tue, 12 Sep 2023 13:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_045829_027478_E1531D08 
X-CRM114-Status: GOOD (  17.15  )
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

On 9/12/23 13:51, Sagi Grimberg wrote:
>> Hi all,
>>
>> there have been some very insistent reports of data corruption
>> with certain target implementations due to command retries.
> 
> None of which were reported on this list...
> 
Correct. I can ask them to post their finding here if that would make a 
difference.

>> Problem here is that for TCP we're starting error recovery
>> immediately after either a command timeout or a (local) link loss.
> 
> It does so only in one occasion, when the user triggered a
> reset_controller. a command timeout is greater than the default
> kato (6 times in fact), was this the case where the issue was
> observed? If so, the timeout handler should probably just wait
> the kato remaining time.
> 
Nothing to do with reset_controller.
The problem really is in nvme_tcp_state_change(), which will blindly 
start error recovery (and a subsequent command retry) whenever the local 
link drops. And that error recover does _not_ wait for KATO, but rather
causes an immediate retry.

> BTW, the same happens for rdma as well. Nothing should be
> tcp specific here afaict.

Oh, sure. Will be modifying the patch to include that.

Cheers,

Hannes


