Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585CFCA100C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNngwprob2Pk2yZXJ4uzIXFpGFC2WPsE7eCm8KD191Q=; b=0Qr4tgF6KcIj5niTHfuzyIT0XE
	q8JA+uYxTtQ2zjmJ7qben4OnzRwhunIkLOIkabCUvN3H++SDjWUTyBoLmYV+TQk2t9qjeoe19e1PF
	ma+EDdBJ7TbOiYn+dNFLoJQGfOAyAyzT8cZqgm1YI1v7byG2rMwKjFVo7Q9tt3W9rxE0RdIgki8Cc
	bQPk81hn0sTdyr1q+8YUE/VYBsXQq8dyWUQ5TR4rNmvJDXE+0Q0JBMgHTUPwrANzam1p0iBQ51skS
	z+RDA8INlzspbTrc0sDIMyrxfAd1PLrbDRGZ20vVbjUj6vPKGW28IoPfcy9A2hCfR7fU7JeyWk/PD
	uJluwjxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uthyl-000000057dQ-2u0W;
	Wed, 03 Sep 2025 07:32:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uthqp-000000053aU-2xBU
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 07:24:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56C191F7BE;
	Wed,  3 Sep 2025 07:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNngwprob2Pk2yZXJ4uzIXFpGFC2WPsE7eCm8KD191Q=;
	b=zEvmW+QsKg5j5JKeIh3UMj5A100P9u7T+b3YLnJZEqJCladACz80KypeUgikYJL0bCaSyT
	d/isTESRWzkiYF7lTuo8Iyz+awk45Gw4XS3r+hThvBPHdT3/KTybQ6cdNaj5xgQCRs1iK8
	c9rMYocA35HB8Z2tGI8kx1EyijEFtrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNngwprob2Pk2yZXJ4uzIXFpGFC2WPsE7eCm8KD191Q=;
	b=4FZsXHED14nqDt/Q4sGZaUgkHwWkfjZgbO5evDR7gMBsoylWcxuIDmKuSgZnrlN4Q7UxCh
	fqlMSzBJumHJb3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNngwprob2Pk2yZXJ4uzIXFpGFC2WPsE7eCm8KD191Q=;
	b=zEvmW+QsKg5j5JKeIh3UMj5A100P9u7T+b3YLnJZEqJCladACz80KypeUgikYJL0bCaSyT
	d/isTESRWzkiYF7lTuo8Iyz+awk45Gw4XS3r+hThvBPHdT3/KTybQ6cdNaj5xgQCRs1iK8
	c9rMYocA35HB8Z2tGI8kx1EyijEFtrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNngwprob2Pk2yZXJ4uzIXFpGFC2WPsE7eCm8KD191Q=;
	b=4FZsXHED14nqDt/Q4sGZaUgkHwWkfjZgbO5evDR7gMBsoylWcxuIDmKuSgZnrlN4Q7UxCh
	fqlMSzBJumHJb3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 462A513888;
	Wed,  3 Sep 2025 07:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AaXFEBztt2hEPgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 07:24:12 +0000
Date: Wed, 3 Sep 2025 09:24:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
Message-ID: <9a878215-da92-408a-afb1-0e54e5770518@flourine.local>
References: <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
 <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
 <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
 <ee0d329a-334b-429c-a916-f03c64bbb323@suse.de>
 <d904e2bf-1b59-4511-998d-f53249137428@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d904e2bf-1b59-4511-998d-f53249137428@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_002415_896836_C6A73A3E 
X-CRM114-Status: GOOD (  11.17  )
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

Hi Nilay,

On Wed, Sep 03, 2025 at 09:52:13AM +0530, Nilay Shroff wrote:
> Having said that, the “monitor” idea seems worth pursuing separately as a
> longer-term feature. For users who want a live view today, they can already
> run something like "watch -n1 nvme show-topology ..." to refresh the snapshot
> every second. A built-in --monitor feature would be nicer and more efficient,
> but I think that’s orthogonal and can be discussed separately. And I believe
> "minitor" feature shall be useful as well for implementing nvme-top command
> (as I recall we (me and Daniel) discussed it during LSFM-2025).

Yes, I remember the discussion, me trying to convince you to implement it :)

I've created an issue on github, so we can track this feature:

https://github.com/linux-nvme/nvme-cli/issues/2904

Thanks,
Daniel

