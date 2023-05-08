Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3FBC7EE22
	for <linux-nvme@archiver.kernel.org>; Mon,  8 May 2023 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKC+JKlCC60bjHNXRiHZI7ynBkY1nRGEcQd2Yz4B+AE=; b=I7kFea0k30SrGwFXWUfSddSAHI
	P5JUfcPeZFCNo+qVulCygcIsHjj0CC25fQGqaCr2SGiiT4B6FE47zb5H2c/A7hVei2Z8eajD5epth
	5SdRBENoRn/Jbo0f1DrISIDcnHfquN3Fsj+QL7fcTbDZ1jPgzao8Y37008uJ/uf24ggg+8GwmPVAC
	O3EjG5jpdd8+Looe8QCB0ch5w+mIXMwyxkYsfpK3HUfTnog6+PhmYN55PK20KRO3Jo6NfvesrcKTI
	q+/P/vAgXK0lMHimgfrYPwmgocLhtQbjNUOb2LfTd4BAKmNQP6gLL0Zzw8t3DvqwFCeCFUmkAVkH6
	/IBf7TgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pw7zG-001QF7-0n;
	Mon, 08 May 2023 21:01:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pw7zD-001QEW-1v
	for linux-nvme@lists.infradead.org;
	Mon, 08 May 2023 21:01:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60C2721D40;
	Mon,  8 May 2023 21:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683579691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC+JKlCC60bjHNXRiHZI7ynBkY1nRGEcQd2Yz4B+AE=;
	b=QUQJ4nTmY6T3mtvZNH5sF2SOP25s70xzGb21d3UHFaYe6oZlKR/LUbw9A7WTqnaPZEsGla
	CBHp3ZXNS+rSoBLvEQiGMU9LV+dWGpyVDduUAp0/Y6coxZyFv9TLT4prUQWYsgkJJ7kY1f
	tWd9IJmJBl8xj0e7i+fS+f64L16cVuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683579691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC+JKlCC60bjHNXRiHZI7ynBkY1nRGEcQd2Yz4B+AE=;
	b=lTZJEY3sPqVJgYyCIeptVdfpH3Y2OsHiy09aI5W9tEG/WDzxgkd4racUeRYXwfoYnZoxRt
	SqUYq8B746cyscDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D7F1346B;
	Mon,  8 May 2023 21:01:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tRZPGyljWWTqOwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 08 May 2023 21:01:29 +0000
Message-ID: <a4eb99fb-cb66-daea-e292-a379bbdf0dc1@suse.de>
Date: Mon, 8 May 2023 23:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/17] nvme: add TCP TSAS definitions
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-4-hare@suse.de>
 <76dda7eb-55a6-e2fc-677a-05d08de738be@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <76dda7eb-55a6-e2fc-677a-05d08de738be@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_140135_833759_01999123 
X-CRM114-Status: GOOD (  12.11  )
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

On 5/8/23 18:36, Max Gurtovoy wrote:
> Hi Hannes,
> 
> On 19/04/2023 9:57, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
> 
> can we find one sentence for the commit message please ?
> Maybe describe about the handshake and sectype ?
> 
Sure.

'Add TCP TSAS definition from NVMe TCP Transport specification 1.0'
?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


