Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F61C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOJGvEjpqubh70sFtWpm/mrRZk63d2K0z1cO+zARO4M=; b=gqTtlko+7SP/uN5YR4kX8Hbaml
	C11qFBWrpUCX1uYr8rT8BAOiPjumJg/m9tmGUaPqzk6esIti95IVzipQc3t19J9GgrLudpE3XPUGz
	Nu+Vr3ooZdIGm0VGR8HUNzUgyI7nyDvoat/zaJ8shjaHWF+oPx8PrcAkAKoQ8LTIvSUmPUC7Qk7SE
	0Xa2euX5tgKaXbOjWc3uD4ICB9nyHj266xuCCc2xMaq7KQmPxwaGvMVMoh9wxaXSC5/8n/UhN3n3h
	EBYQmHZTRhfDuLhjmRCkKhWfMxqKlZhHoddnRzzP+bOQ3+y17WPxFy743DEIKgtNVsoBmpr2TZ7gE
	MaUv57Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFazE-00BVEE-8c; Wed, 11 Jan 2023 13:17:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFazB-00BVDG-CK
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 13:17:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0C6D7754C;
	Wed, 11 Jan 2023 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673443062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOJGvEjpqubh70sFtWpm/mrRZk63d2K0z1cO+zARO4M=;
	b=KkpQbl3cfuzoWSfhOPOnkFXqMMq0W5K9sWD8IbW3sZoRFUGRfgE/canouZ5Q1r+VmVlnA8
	JOwDl5ILOQQYzxpXu10J7GfQbcfEjejM/Qa8KuqzV58Z3Tsxr0HwEQ7wQ/V7WMagb3N78o
	dIm4JLSdw9SGvVtE47aFEtY6wnSShrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673443062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOJGvEjpqubh70sFtWpm/mrRZk63d2K0z1cO+zARO4M=;
	b=qgmsrz7YQAgwJiMBIU+sfqxuWzMXHrckKOCVMaamZDCTpCbUOWZPMDs+RKToyYEPY1vhWR
	TmvDMnUsNYMs7GCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D14CE1358A;
	Wed, 11 Jan 2023 13:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mmAfMva2vmMuZQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 11 Jan 2023 13:17:42 +0000
Message-ID: <a7c37acd-eb59-54a7-d401-38ffd16a7062@suse.de>
Date: Wed, 11 Jan 2023 14:17:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [LSF/MM/BPF TOPIC] Limits of development
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 lsf-pc@lists.linux-foundation.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de>
 <5230135e68bdf7b3fcbff78e7ffd51beebe509c8.camel@HansenPartnership.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5230135e68bdf7b3fcbff78e7ffd51beebe509c8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_051745_590360_2BB7FCF8 
X-CRM114-Status: GOOD (  15.76  )
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

On 1/11/23 13:55, James Bottomley wrote:
> On Wed, 2023-01-11 at 12:49 +0100, Hannes Reinecke wrote:
>> Hi all,
>>
>> given the recent discussion on the mailing list I would like to
>> propose a topic for LSF/MM:
>>
>> Limits of development
>>
>> In recent times quite some development efforts were left floundering
>> (Non-Po2 zones, NVMe dispersed namespaces), while others (like blk-
>> snap) went ahead. And it's hard to figure out why some projects are
>> deemed 'good', and others 'bad'.
> 
> It's not any form of secret: some ideas are just easier to implement
> and lead to useful features and others don't.  It's exactly why we
> insist on code based discussions.  It's also why standards that aren't
> driven by implementations can be problematic: what sounds good on paper
> doesn't necessarily work out well in practice.
> 
But that's kinda the point.
The above quoted examples do have implementations which were sent to the 
mailing list (well, not the dispersed namespace one, but let's not get 
hooked up on that one), _and_ enable existing hardware features.
So they tick all the boxes you specified.
Yet they have been rejected.

Cheers,

Hannes

