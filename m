Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D1CC0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STylol29bkcdT7SsorCcOdrMw/CbquajIgiRZO1Yx6I=; b=x3MvtvWtnL613RK80zR5pxY2Te
	xu2tkhFbXaTAhpryX5M4VCji2dpiRJ/K8pASMLft6g6tN5AKW3VhAEzJ94+TNMDefVxvJor+r/GTM
	G81wg8euLQodMSCqNkWuh/BIzmljp3RtyNIESX5y7ITua8d5Xm8Xk69aJsdUkvID0ePkh/P826JBY
	oBJxYsh2SCYS1/h2DVbblLZW7HjYIkrOOgwVgwxC2Q9OCUSOPcHDnlL8mgNCZEFRaz95jr5cc3YKn
	x6wj25DDdIhs7pM9qXxWJMg71SZUQk/7Jgli/bmUqyn/Bk+KyGaywBg9W//HCOUim31zvLbqGS0y/
	DaBk166g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOece-00AYXO-1i;
	Wed, 26 Jul 2023 13:32:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOecb-00AYWk-31
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:32:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A81361F889;
	Wed, 26 Jul 2023 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690378327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STylol29bkcdT7SsorCcOdrMw/CbquajIgiRZO1Yx6I=;
	b=KRIZb0jkdrD4d9bHHxZesyp3Z5sGRePEuHrUigruNdzGjfCY3L6YWBt63DX/FumbdVp0h1
	BMUBBdd9ZTGJejB9/OkEazqivtu2jcVzydUwty8J+KQKcO/g7/KAgFID+tEWVnHFZ9XmJZ
	8bOIw7ggS6e+oX8n42nyD9abDjGxWEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690378327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STylol29bkcdT7SsorCcOdrMw/CbquajIgiRZO1Yx6I=;
	b=BjU479VjTYorbjXF0yBxlKdBZj4oZ1RYEa/PUYqmRvD/Li/xHeRUvvPF5F/zdFUE08zUrf
	MfbcVXPRhxpoYNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81B14139BD;
	Wed, 26 Jul 2023 13:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WH95HlcgwWSDaQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 26 Jul 2023 13:32:07 +0000
Message-ID: <027cce79-c34a-9a8b-9eac-a34debb7c8d1@suse.de>
Date: Wed, 26 Jul 2023 15:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/2] nvme-multipath: additional iopolicies
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ewan Milne <emilne@redhat.com>, Uday Shankar <ushankar@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org
References: <20230726132305.33739-1-hare@suse.de>
 <20230726132544.GA16873@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230726132544.GA16873@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_063210_112678_DF178A13 
X-CRM114-Status: GOOD (  18.10  )
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

On 7/26/23 15:25, Christoph Hellwig wrote:
> On Wed, Jul 26, 2023 at 03:23:03PM +0200, Hannes Reinecke wrote:
>> Hi all,
>>
>> as Ewan raised the issue that we are suffering from a buffer-bloat
>> problem when using the round-robin I/O scheduler here are additiona
>> I/O schedulers to improve the situation.
>> The schedulers are untested, and are compile-tested only.
>> I just putting them out here as I had several requests for them;
>> I'm happily improving them upon feedback.
> 
> FYI, the policy for nvme-multpath has mostly been that we want to
> see very solid used cases.  So in addition to actually testing
> the code, I'd like to see detailed and solid use cases.  And preferably
> just one new policy and not three if possible..
> 
I could not agree more.
That was precisely why I was reluctant to post them in the first place.
But I have been asked by several parties and really don't have time now 
to do a proper testing (what with me being in the middle of a server 
room move).
So I decided to put them out as a RFC, fully expecting things to change.
And also expecting to have some solid data from testing to check which 
I/O scheduler really improves the situation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


