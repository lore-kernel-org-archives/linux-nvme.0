Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BECAC0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+x6vV1ems/OliHgjioHNx4h3hyDIQFdjm8xGfLTzqxE=; b=pCaAUyFU2QC0nJqKxlvf5Z910A
	RDOWdfDhjlczEOyaiaGTr4CZHDR92sWWDKKae1g2tNeNdLvTlgm+vSOxEJLGwq8Up5PDInNq3hLRR
	Q7dfhwMxnNJpz1VS0xX2ViMgcVIBphOfDyY38L2D3+GiH/2bkB8Pal7S9clDpJzeEABM9lwd2ce+v
	emX/jJFV/3cSnDBhMTfpLmDVBsLw0faA+KtVcO+MzFbcF8pTRDfihYHh7TI4tJEKqTNaLNN06Iqd3
	CE+YWUhJT1KN4vRxu7vEPiSUkVoFO+9Z+ntRk9a3Kx8fINuZJe5bWaJi+yx2t2rOjAGOCrgwYdMDu
	5Lo2cZKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvYRi-00Bb1u-2b;
	Wed, 25 Oct 2023 07:36:54 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvYRf-00Bb0q-00
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 07:36:52 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 67E89320095D;
	Wed, 25 Oct 2023 03:36:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 03:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698219404; x=1698305804; bh=+x
	6vV1ems/OliHgjioHNx4h3hyDIQFdjm8xGfLTzqxE=; b=owLu4/tQp/Ntse9YM2
	s4I4CjOJB7qCA8JSYsO8sZRuERSyXUhex3xHqByowCyzuQKf4brI3nS2I7+GWvlo
	sfgOlForMvqD1Qojr7i6NdNrYk9mE0qtZemxzE2qtRjpX3D6pB791Q9oaaZfUWep
	nAqccr4XNbV+0Ky0KgkDWPvohOQe6cF+0+aB2ajqECitlr2O3LHUgYicmH6DIAXL
	sMgsSJwBAaT1ab6+5YiuYhTvNkd4S0ANBlC4XL0pgHyIyF6Usu85HV6Y4VUvj9Ik
	nskBBap4Czs7wfdymPAItrlhU2CgQVArAJuSrca3QqdtlgWNpV56ci3HNWRaFtCc
	IG5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698219404; x=1698305804; bh=+x6vV1ems/Oli
	HgjioHNx4h3hyDIQFdjm8xGfLTzqxE=; b=IuTGYM4C9dL7RM2Zo4GYrQYEVHfBm
	lPQIbOSmbLGirxqENytGZ4mnZ/oMVTJbz4y6aCQ7IlcfdsSektrg+8xikUcGlX2v
	Hxkk6jkJbsE8oMTn8rGS1IZgfhj2KX2RmfJJvGpg1VDNtyzzEsX+lhFSidl+Nog5
	7Oi8CKLucbje2TLDknyjLjzQUAOiE+axQK6bGaEngxO9oyuZdHQ2d9+a+vO7sULB
	q2NcnNvujjJ3r6tjW3Zx0wgSiW91+t5OJbJDmr+L+rDxeyiPPNJzazFzY/cxc+UO
	AgZn8uRpu9wAz99OYEjtbDD4eRsdV/RHLHZNCqjce1QTDYc4RacChlRXQ==
X-ME-Sender: <xms:jMU4Zapc51SZx91r7wjPlOy0IlrCR1PcLXmNnh7rNhxO4SS7n8BE_A>
    <xme:jMU4ZYpMcSRZoVB3GJPQ4kyKjNFhgRkChaPYZggCduSlIRbabkcY-UFsMNvf09qps
    CQ5aSk0r8fby9m1dnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jMU4ZfPqmYHonoFblPytJAs8bkc1rkakbPR5PnB52E1YDWK7v6Z15A>
    <xmx:jMU4ZZ7Hhg5G1ARzvcxpNdGKPE2jXrQZagJnvUUFqPDACpsDgm5IcA>
    <xmx:jMU4ZZ62pozpN5gWOPGfrBVH2Uxjvd4DW01LYbBcrs9UnwDVc0Y4rw>
    <xmx:jMU4ZWtA7cXiY2U12cOVYmc4QTv0E-bxk6ADEo_lbjszhwHJFcoEJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 023D9B60089; Wed, 25 Oct 2023 03:36:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <d89d139e-744f-4bf2-bdd7-5bfaab1cc7fb@app.fastmail.com>
In-Reply-To: <60b7f4c3-c5e8-4fab-bf31-d576fff7a016@suse.de>
References: <20231020205521.3577821-1-arnd@kernel.org>
 <60b7f4c3-c5e8-4fab-bf31-d576fff7a016@suse.de>
Date: Wed, 25 Oct 2023 09:36:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Arnd Bergmann" <arnd@kernel.org>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_003651_381650_9B62259B 
X-CRM114-Status: GOOD (  12.25  )
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

On Wed, Oct 25, 2023, at 09:02, Hannes Reinecke wrote:
> On 10/20/23 22:54, Arnd Bergmann wrote:
oid)
>> +
>> +static inline key_serial_t nvme_target_keyring_id(void)
>>   {
>> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
>> +		return nvme_keyring_id();
>> +
>>   	return 0;
>>   }
>> -static inline int nvme_keyring_init(void)
>> +
>> +static inline int nvme_target_keyring_init(void)
>>   {
>> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
>> +		return nvme_keyring_init();
>> +
>>   	return 0;
>>   }
>> -static inline void nvme_keyring_exit(void) {}
>>   
>> -#endif /* !CONFIG_NVME_KEYRING */
>> +static inline void nvme_target_keyring_exit(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
>> +		nvme_keyring_exit();
>> +}
>> +
>>   #endif /* _NVME_KEYRING_H */
>
> I guess the right way is to make 'keyring' a 'real' module, and move 
> 'nvme_keyring_init()' and 'nvme_keyring_exit()' as the modules init/exit 
> functions. I'll prepare a patch.

That's probably a good idea, but you still need to address
the link failure for nvme_keyring_id() and nvme_tls_psk_default()
when the caller is built-in and the definition is in a loadable
module.

     Arnd

