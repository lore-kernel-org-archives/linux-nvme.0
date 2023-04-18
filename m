Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD0C77B7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YOAekfdMDrNCNmoSakR74VsgpFGHDUIniIxcl0wF3fQ=; b=0933LeN0qvKcHDPw4BrJzSP4k9
	9YubRN1eAF3k0c6DWnWMOlSnKkDKhTQQ65Lx0/fuZyyBwRfTAeLS93zDnSnU3TrSx+cvbOb2uLUdy
	SKj4lYQO5zyIaAfTo5z+LCf6p6UdDIzNOxeljctj0KVmw2f6vY480MamqN0wOclJ/74w6upImNmty
	cqvHn+4Kz24rNSnKhzkBDdzzFDmJH1OAzu+mBQhqos1MSdQdNEFfxh/B0RH63DTylibBn7fPnsG89
	9Kl/DkCzTqqiW/rRtWocLRgJrEGaResvTf5nFKywO8iZJschJmauEZDIRtRpw166N9F6b5rtuMB88
	x0lVTJew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pohnO-001VSW-1j;
	Tue, 18 Apr 2023 09:38:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pohnL-001VQp-3D
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 09:38:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC81A1F8D5;
	Tue, 18 Apr 2023 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681810712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOAekfdMDrNCNmoSakR74VsgpFGHDUIniIxcl0wF3fQ=;
	b=HdWaPUbD3zJxobS9QKT/JNNNJYFIz7N+j7ulHioxlWadqtnNsXGI8A2o9EkFbK+W9o7z5N
	taP7EMW1dsQUKmXrHFOyNF011ZFhz11f3/9GxhDWHjO/rSWdu3dLu1YYC+hPFuFfHUQHNL
	IHg3Qyt/9saTJbyvnzqMCGwLltxHb88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681810712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOAekfdMDrNCNmoSakR74VsgpFGHDUIniIxcl0wF3fQ=;
	b=oFnt2gvnlhgs/K2wMonlv7mgBD/KfxGbofcCrLbcczPzFg3saGWNy6TJ5TrmpsaOLvaVSX
	lRPtvFW2gSxE0HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD0CB13581;
	Tue, 18 Apr 2023 09:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BEeALRhlPmQJLwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 09:38:32 +0000
Message-ID: <c6ff524b-df91-f0ef-259e-ada0e1623cd5@suse.de>
Date: Tue, 18 Apr 2023 11:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <msf6bjfbqiaj7s3ejxjwiueg7omvctsjftnux3qfvwadeg2jiq@hawgvoslzjo2>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <msf6bjfbqiaj7s3ejxjwiueg7omvctsjftnux3qfvwadeg2jiq@hawgvoslzjo2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_023840_201089_D13B71AD 
X-CRM114-Status: GOOD (  18.61  )
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

On 4/18/23 07:52, Daniel Wagner wrote:
> On Mon, Apr 17, 2023 at 03:02:55PM +0200, Hannes Reinecke wrote:
>   --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>>   	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
>> +	{ NVMF_OPT_TLS,			"tls"			},
>>   	{ NVMF_OPT_ERR,			NULL			}
>>   };
> 
> Coming back to your previous discussion about this. 'tls' is always announced
> but not always supported. This renders the unsupported option filtering added to
> libnvme useles:
> 
>    https://github.com/linux-nvme/libnvme/issues/612
> 
> Let's assume we go ahead with this patch. The user set explicit the tls option
> via 'nvme connect ... --tls' and the kernel will return EINVAL, but userland
> can't really know what it was and drop --tls and retry again (or print some
> useful information). It could be any other parameter provided by the user.
> 
> How is userland supposed to do any feature detection?
> 
And that is a good question.
I've just removed most of the #ifdef annotations on request from Sagi.
If we were going with your suggestion I would need to bring them back.

So, Sagi: What should we do?
Re-clutter and allow nvme-cli to figure out if TLS is supported?
And have it always enabled and invent other means for nvme-cli?

Cheers,

Hannes


