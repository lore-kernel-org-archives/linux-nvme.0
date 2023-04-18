Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C5CC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7NRQHrD5fOm0PvmBnQYM8CrVrtN3pzNp8jVrAsgAxI=; b=FkbjVG8PfZywogVuwkTmkYafXi
	PuzlHosa7uJ62Vt0JEUcc5QOTqg6EcmnLkaHz0ZiGdr2be9/Q4qT9BDPmvi/ENnEzgr6jb6Fqaf8Z
	ZVRPEA1j0ZvrD7/LX+a6C3BLh1orlj+dRlqXziCcJKpQBZX9Br1MdEV9fCiwW52YDO80bEXjJov45
	FN+pVhcfP3E6TlDUUJrTb3tDCTPfhb1Hy9yCWaSt3qOtRh0oumcHEbhzXpGXgTLrxMw4GkQbn70OO
	dUBfPt+fZyGg9Rn/YKrxtpeFk0lGNjsXGiC945Wx4pmD4BpWrp2FxXYvludsclub5zqmu689uxHF7
	u31vKf2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poiZF-001fLB-0e;
	Tue, 18 Apr 2023 10:28:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poiZC-001fEM-1F
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:28:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0CCA1FDCB;
	Tue, 18 Apr 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681813681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7NRQHrD5fOm0PvmBnQYM8CrVrtN3pzNp8jVrAsgAxI=;
	b=lvbma2s7WW9IVdb54xq8WBaUOoQuP48w+GoydyVYjh9bQW4OzRhlxE08pVYH8FAqs6qRBj
	ciGHi1JbP5s0SYQJC925Iu4zw0QE/CuuZ1IrAI31PevdplrhUD+qfxgiXIMlhYS002OlE4
	mGxqyUlzgxTn5HGBC262PZvT7+gLl8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681813681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7NRQHrD5fOm0PvmBnQYM8CrVrtN3pzNp8jVrAsgAxI=;
	b=a45gzZyHloPufuiBT+Ailuu1kvxIX04ED4CyyBx50LYmqARkMXRqXey957O/ba5Y76kC0b
	5Q8h+LPaCrynqrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97F2C139CC;
	Tue, 18 Apr 2023 10:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LQjBJLFwPmRMSwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 10:28:01 +0000
Message-ID: <aaa05f01-5047-03ed-2356-2f9544ee4b22@suse.de>
Date: Tue, 18 Apr 2023 12:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <msf6bjfbqiaj7s3ejxjwiueg7omvctsjftnux3qfvwadeg2jiq@hawgvoslzjo2>
 <c6ff524b-df91-f0ef-259e-ada0e1623cd5@suse.de>
 <f3c2fd60-b09c-6dd4-86f1-1c1e5b371ff4@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f3c2fd60-b09c-6dd4-86f1-1c1e5b371ff4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_032806_586556_7CAE8C84 
X-CRM114-Status: GOOD (  21.00  )
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

On 4/18/23 12:12, Sagi Grimberg wrote:
> 
>>>   --- a/drivers/nvme/host/fabrics.c
>>>> +++ b/drivers/nvme/host/fabrics.c
>>>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>>>> +    { NVMF_OPT_TLS,            "tls"            },
>>>>       { NVMF_OPT_ERR,            NULL            }
>>>>   };
>>>
>>> Coming back to your previous discussion about this. 'tls' is always 
>>> announced
>>> but not always supported. This renders the unsupported option 
>>> filtering added to
>>> libnvme useles:
>>>
>>>    https://github.com/linux-nvme/libnvme/issues/612
>>>
>>> Let's assume we go ahead with this patch. The user set explicit the 
>>> tls option
>>> via 'nvme connect ... --tls' and the kernel will return EINVAL, but 
>>> userland
>>> can't really know what it was and drop --tls and retry again (or 
>>> print some
>>> useful information). It could be any other parameter provided by the 
>>> user.
>>>
>>> How is userland supposed to do any feature detection?
>>>
>> And that is a good question.
>> I've just removed most of the #ifdef annotations on request from Sagi.
>> If we were going with your suggestion I would need to bring them back.
>>
>> So, Sagi: What should we do?
>> Re-clutter and allow nvme-cli to figure out if TLS is supported?
>> And have it always enabled and invent other means for nvme-cli?
> 
> I don't understand the issue.
> 
> userspace already has a way to know if a feature is supported by reading
> the misc device.
> 
Yes. But the output there is generated by evaluating the fields from the 
fabrics 'opts' structure.

So if the 'tls' option is present it assumes that TLS is supported.
With my current patchset the _option_ is always present, but the 
evaluation of the option once set by nvme-cli might return -EINVAL if 
it's not compiled in.

The request from Daniel is to have the compile option for the fabrics 
'tls' option, too, such that it doesn't show up with the misc device.
IE revert the changes which you requested to convert all the
'#ifdef CONFIG_NVME_TCP_TLS' conditionals.

Cheers,

Hannes


