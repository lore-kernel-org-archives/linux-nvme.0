Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044ECDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBZiaS+SI0805DpLimtelDk96ObyGZoUkVcyh/nX15M=; b=Ck9iYvFkbU8NNoGHnoAHzx2qcw
	B/2Rf7NW8mI0c+KgbAeI7Y3vnamfwjZQtZn/RcYaBmLAroWTeVfX4qNP1tsLuucSncz984MWW8N9I
	hYMar+nJA7iC2QdlDNt2zA1p8leukCyTU21UNp8ekOcAB3dRUvK8XJMTzfAwqUkiJX8hSuLij9RR1
	GEZrY+qe5G5x2ivjLyXiClSQH2TfvF1CGb73MPR4iBAs51kmCXSVV4lzCnx2zq7/b1E7cd97sPsVs
	CBSvLjWK2Gwz1zv7fHKfogoBJr1v1ZzcGYlxEGYXgdnUfryiSfVLGYsiBEEWMoVuC7/ko623o8ZFd
	rGjqvPiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt11a-00E3Zo-1Q;
	Wed, 18 Oct 2023 07:31:26 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt11X-00E3Z6-21
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 07:31:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF2521F8D7;
	Wed, 18 Oct 2023 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697614279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZiaS+SI0805DpLimtelDk96ObyGZoUkVcyh/nX15M=;
	b=d6DUne5l8jwnGMNMVtV2WFNT0Djkupvlf7uCrTR4LfwNBW5A3+U5u3t3zVmSHkvlQfFSGl
	F9S/uFSZKmg6H9v99tlcG3j1FXUbXCNvMz1UOlxNtCivk5c8+cufrO0KJT7SG7v8PdcrMp
	6r8Qr8rb6/rKcJSd2n6sls9jjqB09zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697614279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZiaS+SI0805DpLimtelDk96ObyGZoUkVcyh/nX15M=;
	b=dQSSs52f4sfq/5V4rbXv7doPGIPJwyQIEr3WQdJvcfCpM6uhZTpvBOH/Eh6RzFtyPSe7I/
	kMUMyWGDHk8OGsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A748513915;
	Wed, 18 Oct 2023 07:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +biTJ8eJL2UzZgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 18 Oct 2023 07:31:19 +0000
Message-ID: <88614972-be65-40c5-a7c1-0487f9258806@suse.de>
Date: Wed, 18 Oct 2023 09:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20231017134535.137780-1-hare@suse.de>
 <20231018054538.GA17150@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231018054538.GA17150@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-2.56)[98.04%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_003123_814968_ADEE5881 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

On 10/18/23 07:45, Christoph Hellwig wrote:
> On Tue, Oct 17, 2023 at 03:45:35PM +0200, Hannes Reinecke wrote:
>> Setting up I/O queues might take quite some time on larger and/or
>> busy setups, so KATO might expire before all I/O queues could be
>> set up.
>> Fix this by starting keep-alive right after the admin queue is
>> operational.
> 
> Having all these manual unpaired nvme_stop_keep_alive calls look
> rather unmaintainable.  What keeps us from doing it in
> nvme_uninit_ctrl?
> 
Problem here is the exit path of controller initialization.
That is per transport, and each and every one makes it ever
so slightly different.

I guess we can move starting and stopping keep alive into
nvme_quiesce_admin_queue()/nvme_unquiesce_admin_queue(),
as arguably quiescing should affect keep-alive, too.

Let me check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


