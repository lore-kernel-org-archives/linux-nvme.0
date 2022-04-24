Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7767C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Apr 2022 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZQCBA15R9Ya7Shhm5Hz7cUgtmM4P+Sb2TCYwDpu1L0=; b=CRLFPliYDtqHMTY2nr1rd92vld
	mSEakZnpQcuSbc3Pxx67fPCPcNBfU1cjzECWR4OMsjy9E7+vh0FQqAZ6qdz1eQyHvc6QToqctjw9o
	E2MyJ3CGdQKPClWY50pfLa+OdRLXjjqxbz2L+c3NEcR5rNEPOmopwvN1T1X3MplL1qkq+wFmzwcVl
	estN5B2dUW4/cfztXOiSt7fY2TRmbhqZrefFhcA3bB7X63msyokScqTqks2nU3cOw9do8jIcsZKBb
	Wb8ZC7KFZiIR+gloYF2buUC57SEWrYysNFYmUxqrC/y8a8IrJyWVe75tZjhnlbT0XcS9ktP94JzCb
	4rZ15d+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1niaaj-006UTA-9C; Sun, 24 Apr 2022 11:39:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1niaag-006USo-4Y
 for linux-nvme@lists.infradead.org; Sun, 24 Apr 2022 11:39:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EDBE210EC
 for <linux-nvme@lists.infradead.org>; Sun, 24 Apr 2022 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650800382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZQCBA15R9Ya7Shhm5Hz7cUgtmM4P+Sb2TCYwDpu1L0=;
 b=179+WLxML3oQuPMMforDBEGCcMeS65pXoAYk/04A91Fx0T8YBjakccCfS1v6nh11z9a/+O
 15dFmrEWrzuGzzctVaM6gds5EjyWHuSZMEECm03ehIDuFHrbqurV+b9sce4iLaPlkdK4vh
 BCcXvkZ+eH6ktqYqfUavq4Km1F7r54s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650800382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZQCBA15R9Ya7Shhm5Hz7cUgtmM4P+Sb2TCYwDpu1L0=;
 b=mFbOqHUhR5RHcFgFN/PrDC+t3/YcAHhdmzI9Mslg3J+LCiChEkGmNlfWN3qbpSME1ixcXM
 ukcBwizDCxZZHEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF45C13780
 for <linux-nvme@lists.infradead.org>; Sun, 24 Apr 2022 11:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XsTfL/02ZWJHQQAAMHmgww
 (envelope-from <hare@suse.de>)
 for <linux-nvme@lists.infradead.org>; Sun, 24 Apr 2022 11:39:41 +0000
Message-ID: <8677ebda-69f5-3fa0-87e4-8238c298cc57@suse.de>
Date: Sun, 24 Apr 2022 13:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Ask advise for disk safely reuse
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <CADb2eF902UkdnOpoj1w1MGT70fg0fdsoDhRBNjOK-jkE3HYF-g@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADb2eF902UkdnOpoj1w1MGT70fg0fdsoDhRBNjOK-jkE3HYF-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220424_043946_371559_EE3D1500 
X-CRM114-Status: GOOD (  13.77  )
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

On 4/22/22 06:50, Shuo Chen wrote:
> Hi teams,
> I am investigating how to safely reuse the disk between different
> customers and do a safe data cleaning. From the nvme-cli I see three
> options:
> nvme format
> nvme sanitize
> nvme write-zeros
> 
> I've tried all of these three methods and it looks like I can not read
> any previous data by using the "dd" command anymore. I wonder what is
> the difference between these three? My concern is writing zeros to the
> whole disk is really time consuming, as a result, I wonder whether
> "nvme format" is good enough to wipe the data.

In theory, all of the above provide the desired result.
'nvme format' is typically used to change the format parameters, so if 
you call 'nvme format' with the same parameters as had been used 
previously the net result will be pretty close to 'nvme sanitize'.
'nvme write-zeroes' will achieve similar effects, but with the drawback 
that it instructs the firmware to actually _write_ data, thereby 
decreasing the lifetime of the device.

So I would settle with 'nvme sanitize'; that achieves what you want with 
least side-effects.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

