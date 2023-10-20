Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591A5C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LonXQjpEizeoJQpauP0+j/vmuCHajAxbP1J23vL0NmQ=; b=QEZYFR5BE44RhfdzmUWfqjHGtU
	zx94+9+A293RClPuM2HxoeSCGxcWpS390oYn9tMeuhHsz3XFaQ6A+7e6ebDtAlB16b8TIqVgpFbpX
	mgMzRLZ8myi9r2dHHtQgqQFJCDkUS9YEzEGmngjItoV3c8gzVmGLIRM3RsrWFuY085ykwGVIkOFIt
	+lUCW7x2sX3KK6XlUFH1FqoANeBiPx8ZqvI4yUT6/jfxw9EN9E/NJmeJA2qsQNvXYZsjuAw6UZEQn
	5r4A3mM604Gf3sQXDdfHrU1FiKzpElnXe59e4hKAeYDwk6B3rUDHwjOf27suWcHjyXuyb3oS6qG4v
	WjOkzUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqvh-002XUV-1H;
	Fri, 20 Oct 2023 14:56:49 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqve-002XTO-34
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:56:48 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8526C5C0A69;
	Fri, 20 Oct 2023 10:56:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 10:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697813800; x=1697900200; bh=Lo
	nXQjpEizeoJQpauP0+j/vmuCHajAxbP1J23vL0NmQ=; b=gFP+xUkjM7oN0tsJus
	euvNpvogB+F2wdtuTRunKFP6FfjXMRvncstq96Mirecm7hjAnaHK7RMMouNANPsU
	J4WegSmqsk23NPZl9cWxWQlyKEh5GPodCkYQNVj6ZKNMRTpKQb+U4F9adxKnzcT2
	gIRdbUEldOnF8Q2kxcgqLSEtaHTApm2rPA5LGooJ9tDEUBMal3sKX1OBKgqtYXV3
	KuIdu3KQVvTSxYFn1uXDwaF+gwLSp7NCu2Y/jnGsOExGrlO8cRNDlIxzhDhtnak8
	9M7t9asPbgFNEOwD8OiVMu0NO+IfU/i4NApMgsLZy+7Tlmr70D86PNn3SMG9KHSe
	sS4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697813800; x=1697900200; bh=LonXQjpEizeoJ
	QpauP0+j/vmuCHajAxbP1J23vL0NmQ=; b=RmaN4zeU5G8qCpGTIGMkHlaSlhrIH
	FxeVQ5D36oajkNW+zoCtpcF+6zCFyJqi5OqYiSzH7LMWgDJYtXICkQG51IGOrp1i
	kEDaI1uB+px5+85Ttj1i/iGCgvTNMNbyKWbCtBgdvQaLd/rhzVsqCkxWya9WtKHL
	pfjzC/vT1OQ8SX9J5c0x4CqAZmVAsf0+8VpEDzbRCxgz7KjViv5yefhZsuiYi3LL
	rj5UxhxwqMsX2kR/RRyVkRAAd4/LpYITbUgi9ViOdFnlzHb08Y4JoX3yx42gzqLP
	U2Q97XaOsAcVNMJ1x+9Tlg+Pd6o5RJ2nhNgpVvdoCSRh7qrY+jY3ZOkQw==
X-ME-Sender: <xms:J5UyZQqFCXxDOI2261nQB3yC4HS84tA4kfXEvs941jPJTzHS7wD3SQ>
    <xme:J5UyZWq9wvZlfUFTD5tdMXYhEgQrDSr3Crxz50tkaznLJCIrYjFbVkSzN-mlkj3kl
    ZJQUu4WV2K0TWYn_d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:J5UyZVM6MIgTTjuMZjP83_VDXtRZ2OgxXcs8DkyNKfenarC82XajiQ>
    <xmx:J5UyZX7TVlThxE62ReZeaAKOjoONTEoNjQoPa5JayCYkKQn7VUtyLA>
    <xmx:J5UyZf4EZ2PYVZUFpsDGrlexp-1BHxDKPhUINf4ZqYqs1-VbYpqAmw>
    <xmx:KJUyZcHP30kb21UiGyzyDtvhPLV-DHFJFzxeDnpRTyg_LMh9Z2qHGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4F795B60089; Fri, 20 Oct 2023 10:56:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <a30328f6-d3d4-46f8-9ce9-b5ca5ff8aed8@app.fastmail.com>
In-Reply-To: <69afc25c-ffc7-4ec4-a290-8c67f4dd36bd@suse.de>
References: <20231020130644.485649-1-arnd@kernel.org>
 <20231020130644.485649-2-arnd@kernel.org>
 <69afc25c-ffc7-4ec4-a290-8c67f4dd36bd@suse.de>
Date: Fri, 20 Oct 2023 16:56:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Arnd Bergmann" <arnd@kernel.org>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>
Cc: "Mike Christie" <michael.christie@oracle.com>,
 "Uday Shankar" <ushankar@purestorage.com>,
 "David Howells" <dhowells@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_075647_064683_A6746F7E 
X-CRM114-Status: GOOD (  15.98  )
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

On Fri, Oct 20, 2023, at 15:50, Hannes Reinecke wrote:
> On 10/20/23 15:05, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>   
>>   static void __exit nvme_core_exit(void)
>>   {
>> -	nvme_exit_auth();
>> -	nvme_keyring_exit();
>> +	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
>> +		nvme_exit_auth();
>> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
>> +		nvme_keyring_exit();
>>   	class_destroy(nvme_ns_chr_class);
>>   	class_destroy(nvme_subsys_class);
>>   	class_destroy(nvme_class);
>
> Please add stub calls and avoid sprinkle the code with
> IS_ENABLED statements.

That seems to add a lot of complexity, but I can try. If I can't
figure it out, someone else might have to try it. Since we need
to check separately for the host and target options, this will
lead to having two extra stubs per function call, right?

key_serial_t nvme_tls_psk_default(struct key *keyring,
                const char *hostnqn, const char *subnqn);

static inline key_serial_t nvme_host_tls_psk_default(struct key *keyring,
                const char *hostnqn, const char *subnqn)
{  
        if (IS_ENABLED(CONFIG_NVME_TCP_TLS)
                return nvme_tls_psk_default(keyring, hostnqn, subnqn);

        return 0;
}

static inline key_serial_t nvme_target_tls_psk_default(struct key *keyring,
                const char *hostnqn, const char *subnqn)
{
        if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
                return nvme_host_tls_psk_default(keyring, hostnqn, subnqn);

        return 0;
}

>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 4714a902f4caa..e2b90789c0407 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1915,7 +1915,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>   	int ret;
>>   	key_serial_t pskid = 0;
>>   
>> -	if (ctrl->opts->tls) {
>> +	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && ctrl->opts->tls) {
>
> Why? '->tls' is not protected by a CONFIG options, and should be
> available in general ...
>
>>   		if (ctrl->opts->tls_key)
>>   			pskid = key_serial(ctrl->opts->tls_key);
>>   		else

It's the nvme_tls_psk_default() call that needs to be protected
here, but I found that the entire code block is dead if tls_key
is false, so it seemed more logical to make the entire block
conditional when we know the condition is always false at
compile time.

     Arnd

