Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tY9kUO9qREH823LGpACKfU8m83DnVGSSkJb8GF8CKCE=; b=ibPvgaPsZ+4A4fEMRg4KGvPAXa
	DMKzrNwpKPB/nU4eYjMF/EQmilDpNdLIKaF3YQ01iLcJrsu3zqVv7M6BRkZTRFbvf66spaYliQ+Ju
	v8cntfjmlFH4HkGKri5syzED77uo3HiPYPzTRoJGLmSQmbAnrbJfskJsH7hqMMCZn1zk4oMEo7aVV
	cEhwXypme02AtN6gbKJ1tDsxim7Rm8sMP6dCesV5MeTfVPYwH2JGkFdhBXxSS1boZjQ8eGnDKp2Z2
	LCOw/igXUbdAar4si+pFtvJQW4tOl3wqhROaDaecUX/f9EOGQCEiHCnttHvWTL8ryl+l8cHhKaxR8
	7VyN7qIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI4eH-0032si-R5; Thu, 10 Feb 2022 08:17:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI4eD-0032pL-Rp
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 08:17:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45C9B210F6;
 Thu, 10 Feb 2022 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644481065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY9kUO9qREH823LGpACKfU8m83DnVGSSkJb8GF8CKCE=;
 b=0Spm3Fi36TbzQ0Ax6ByMIR/KH1qHVI9u/odLqWHk/5uDGksa1Ue0Mjp2Q3qpxWyTCZli69
 +t5fZUKnbOAu2P0YG63A8if5jBHq8pCJ0dy2C0sbAq6ZSw2yQaj6aD7zMEHf9rCMfP+wAx
 4K6RPyc6GC4HVca79XtW+WohXiFXNa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644481065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY9kUO9qREH823LGpACKfU8m83DnVGSSkJb8GF8CKCE=;
 b=jplmX1aBfKhyjeo+gXGPJgIGKNSjc3ayA0EgwYAm4JguyyA+xtP0YqCDPH0GHRXhBNS+Hy
 EDfwEI+SOk3jo+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7D9D1331E;
 Thu, 10 Feb 2022 08:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PpQjMijKBGISLAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 10 Feb 2022 08:17:44 +0000
Message-ID: <58ecf3ab-aded-1fa1-e8fc-bd26bd70e90a@suse.de>
Date: Thu, 10 Feb 2022 09:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220207100005.34404-1-hare@suse.de>
 <20220209080747.GA9851@lst.de>
 <56fb153a-ba0e-605b-e774-885c259965a6@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <56fb153a-ba0e-605b-e774-885c259965a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_001750_088312_8F9FCFF3 
X-CRM114-Status: GOOD (  26.11  )
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

On 2/10/22 03:52, John Meneghini wrote:
> On 2/9/22 03:07, Christoph Hellwig wrote:
>> On Mon, Feb 07, 2022 at 11:00:05AM +0100, Hannes Reinecke wrote:
>>> On large installations the ANA log buffer can be exceedingly large;
>>> we've come across a controller with 49 ANA Group Descriptors and
>>> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
>>> And this is just to validate that the namespace ID is _really_listed
>>> in the log page.
>>> So to avoid an overly large memory allocation we can leverage the
>>> 'RGO' bit when retrieving the ANA log page, and check whether the
>>> ANA group ID from the namespace is found in the ANA descriptors.
>>> That cuts down the memory allocation, and provides the same result.
>>> But to be on the safe side I've added a module option 'ana_groups_only'
>>> to switch between modes.
>>
>> How is this supposed to work?  We'll fail to see what namespaces
>> the change applies to.
>>
>> So in doubt fix the controller config to be less broken (and say hello
>> to NetApp and explain them they do not need more namespace for more
>> performance), and if that fails switch to a vmalloc allocation for
>> the buffer.
> 
> I agree with Christoph.  I don't see the point in supporting 65536 
> namespaces across 49 ana groups or controllers. The problem here is: the 
> vendor is trying to turn NVMe into SCSI.
> 
> Moreover, I don't understand how implementing this as a MODULE_PARM is 
> supposed to work.  If you configure this module parameter on it assumes 
> all NVMe-oF arrays connected to the host support RGO. What's really 
> needed here is some kind of protocol mechanism that will allow the host 
> to dynamically discovery if RGO is supported on a controller by 
> controller basis.
> 
> And this isn't an NetApp array. Just look at who's asking for this 
> change if you want a clue as to what NVMe-oF array is asking for this.  
> I know for a fact this isn't a NetApp array.
> 
Indeed, you are correct. Surprisingly we have more customers/partners 
implementing NVMe :-)

All things considered I guess I'll have to go with the kvmalloc approach.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

