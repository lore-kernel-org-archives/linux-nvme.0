Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30426C25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNw9+b/Rv6pGAdSK+4nGBgAIWQCyInIRXWS4ldHD6gM=; b=bn0DYBW24zaHPHuPGuEvVifemj
	vaTkbUs3BD0DCzp4Vj3dWwKVqMH9xfGi+oifEcpma7z5IRKyZlICdhyc0d/ksivU1Y8PhJ9nLyibR
	EJcoey1uU0ymJXZXEn9kNGZ5ffwcKanSHdqVSnHLxc2y5irQZiXWbzyEI6yOpVKx/XElBNLWjoNT5
	0Fg0ovb0z2e6wV8vgBzksEH7DGz6jWPep/wb3REoKAp6yqqbmf+WlpzDf0G+FBsgOQmnkI2GscqHO
	lHglamWvcOCJEZeHrEGG5Sx0p1eK6dB6K1ttF3Apm7TzwMLxcwsKf0aqgfjDKesM4PdSNdfqD4VxH
	NvTghb3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvcoI-00CHPI-34;
	Wed, 25 Oct 2023 12:16:30 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvcoF-00CHOD-2C
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 12:16:29 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BD8955C03A9;
	Wed, 25 Oct 2023 08:16:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 08:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698236183; x=1698322583; bh=fN
	w9+b/Rv6pGAdSK+4nGBgAIWQCyInIRXWS4ldHD6gM=; b=n/Wxk4eX36AiGOHJoS
	2d+9MRqXyvFwujXdRKPND/2KoGlvoUnMeqbYDl0G8mbjd3m49shbXOdhQMkDQH9L
	bwXSa3JW7QJdaZNPWvvOvVHI1snYrZHnIAdpTuXHrI9pUd7L6HY8MBd5a4HlYuEn
	m3RBkakmQY7IX/6qgAIi/w/IzxZwX6+Z3EAyewCWAW03GyJXCFIB5fH41uIk1rce
	4Pj8az7p0WJQypu7JP5peUfouRoDP+wmAy5QFnJ8YrUY7zcuLf8+mkY63euZan3j
	Zrc738iv7c+rOj/jwK+vFRBmPMqSBPBendjYmrzD/wx8UTJlSZrJHsVMJeSJrs4D
	bF+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698236183; x=1698322583; bh=fNw9+b/Rv6pGA
	dSK+4nGBgAIWQCyInIRXWS4ldHD6gM=; b=la+cF0tuSlRe6J26SszHFsglE8nDq
	LhDTA2rN0QEe9LB8BpnijcqXhb95OTWEeSaOD6LOZquoKwy/moighg73TagjkBKc
	Gxb/2GqJQOyQ033jcYhlIAHEsGxs5AoANRLsYyOLARTdjO01UZREEZppy1dNkq5b
	1t4gsLD1Vf4T3Fs4OnOLsD5HlhtdYkuGdAVOVellJYFRTmr9GtogzVN0n020x+g8
	8pdd8WSfuRG9an8UqEn8FJDX4smG7uyY07sfo4hEmo++7rx53yh+p4VXvZDWNmM/
	dsDGGm5tDQB2sRUg3SIWBYT6XmltjdmY++SogauHAHNNfiIUg7YnFa8iA==
X-ME-Sender: <xms:Fwc5Zcvmh4gOnmTFuRSu5JSIYbl-otbGbBjz1ym4qsDRPqw1bMULaQ>
    <xme:Fwc5ZZfCUVBY8Ox1970NeBWzHpklAZ7IkWDvsbSbfb6hr1wcpAAEcgRubH-nZsAar
    A_tTGiCOrMhWKpG8rM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeegteeihfejvdfhfeffhfdvvddvfffgtedvteeigfehhfehudffleejueduvdel
    gfenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Fwc5ZXzcN_QWk0__krfJjGKcYVbYYmHk2IPloOe1mENcc6DKakfzrg>
    <xmx:Fwc5ZfO0EzsDMFWEhKFXJKljtZC7RntjiIzcrj33NQ3RCuDzj-5T0w>
    <xmx:Fwc5Zc8hPqIeO3g2EzDDLKe89ynwb-n0bwOSLhiWEDH7-lW9gjRwTg>
    <xmx:Fwc5ZeL5t7GMxzA43w8xs7gxYeXe1_hw2ALGg5-qNXQ3TL0lLwi5uA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B71BB6008D; Wed, 25 Oct 2023 08:16:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <24b5d8da-3804-4761-b480-69f1b5577fc0@app.fastmail.com>
In-Reply-To: <4591215b-6ffa-4a74-8966-3ad0a3b9c239@suse.de>
References: <20231025081253.113738-1-hare@suse.de>
 <20231025081253.113738-3-hare@suse.de>
 <2d945ecf-6313-488e-bed4-26d87df0f61e@app.fastmail.com>
 <4591215b-6ffa-4a74-8966-3ad0a3b9c239@suse.de>
Date: Wed, 25 Oct 2023 14:16:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_051628_182745_DA73D67D 
X-CRM114-Status: GOOD (  21.85  )
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

On Wed, Oct 25, 2023, at 11:11, Hannes Reinecke wrote:
> On 10/25/23 10:20, Arnd Bergmann wrote:
>> On Wed, Oct 25, 2023, at 10:12, Hannes Reinecke wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The keyring and auth functions can be called from both the host and
>>> the target side and are controlled by Kconfig options for each of the
>>> combinations, but the declarations are controlled by #ifdef checks
>>> on the shared Kconfig symbols.
>>>
>>> This leads to link failures in combinations where one of the frontends
>>> is built-in and the other one is a module, and the keyring code
>>> ends up in a module that is not reachable from the builtin code:
>>>
>>> ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
>>> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
>>> ld: drivers/nvme/host/core.o: in function `nvme_core_init':
>>> core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init
>>>
>>> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
>>> tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'
>>>
>>> Address this by moving nvme_auth_init()/nvme_auth_exit() into
>>> module init/exit functions for the keyring module.
>>>
>>> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> 
>> Your patch looks good to me, and I think this fixes a
>> separate problem with missing the initialization of the
>> keyring when the kernel has only the target driver but
>> no host support, but it has nothing to do with the changelog
>> I wrote above and does not fix the build regression
>> I described.
>> 
> Hmm. Can you send me the .config file (or the config options for NVMe 
> where there failure occurred)? I tried the configurations mentioned, and 
> it worked for me.
> But apparently I didn't get the right combination...

Sorry if my explanations were not clear enough. The two
broken cases can be triggered using:

https://pastebin.com/aVQ1UbTv
CONFIG_NVME_KEYRING=m
CONFIG_NVME_AUTH=m
CONFIG_NVME_CORE=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
# CONFIG_NVME_TCP_TLS is not set
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
CONFIG_NVME_TARGET_TCP_TLS=y
CONFIG_NVME_TARGET_AUTH=y
ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
tcp.c:(.text+0x1099): undefined reference to `nvme_tls_psk_default'

and

https://pastebin.com/jXQ71vn9
CONFIG_NVME_KEYRING=m
CONFIG_NVME_AUTH=m
CONFIG_NVME_CORE=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_TCP_TLS=y
CONFIG_NVME_HOST_AUTH=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=y
# CONFIG_NVME_TARGET_TCP_TLS is not set
# CONFIG_NVME_TARGET_AUTH is not set
ld: drivers/nvme/target/configfs.o: in function `nvmet_ports_make':
configfs.c:(.text+0x13b8): undefined reference to `nvme_keyring_id'

The problem is the same in each case: one of the two callers
(target or host) is set to =m and enables keyring support, while
the other one is built-in but doesn't use the keyring. This
leads to the keyring code being built as a loadable module, but
include/linux/nvme-keyring.h contains broken stub functions
that lead to it still getting referenced from the built-in
code.

     Arnd

