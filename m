Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6FEE57DB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2o4TwarVQvnF84+hUo8xiaDyhicYeSIVA1um74AYjU=; b=clfBMZFSk+rbRyYQoYp+ofZwNQ
	PwP4CMpt7vAoH5b9SVjtEGEXOzT11VmCMl2yR82PRURI7RGuhIY7ohOvluhCCzteMiVRCbotT0r3S
	ikregCNe4uTJ6eX5m6ri+EicBPZAqN8a46asdb4mU3D7UkTrpwIuuVGhRj7o7kvFvB54bWeH4YZdm
	NxqAzKke3ch1FerPv5eIvo0Ke7CVUh+arL7f9Hc5uciHfWS/krMGTjlefhctGOrsdM2Ua/0Pn5tS6
	I2HpV53BNNp0h4cCAyMaw1J52jMTCKLq+4PDXE15QgLFIFBYxxSrGDTfx0cg9dJNzZ4nLwqPIqqtY
	8VTXEDpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVlK-00DEPq-1O;
	Fri, 08 Sep 2023 07:18:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVlH-00DEPP-0L
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 07:18:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A813F1F45A;
	Fri,  8 Sep 2023 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694157517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2o4TwarVQvnF84+hUo8xiaDyhicYeSIVA1um74AYjU=;
	b=DBaXq36gLDVGaMSmUohuraQrbSWCTLmvMTT7QHTu1SleFLUTzF2/cM20d7l6Nj701AcC15
	NtjT3SLGe5N5WRGKWSV+YpTuyeEbuXI7Lv58Fb4V+GH4JsDQUp0daewGiGhxey0LDr7OBh
	Ji86d11jbfLaTUWRVDMO5EB3ra7j2EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694157517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2o4TwarVQvnF84+hUo8xiaDyhicYeSIVA1um74AYjU=;
	b=mNzzV+wT60weMatic2lco6MQWOspHSXkG0otc86io2PyE/GDyRvWO5NocQvDiWF6TSQWIA
	1bSBe2biDNMcmBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8099D132F2;
	Fri,  8 Sep 2023 07:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Z8UXHc3K+mSHCgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 07:18:37 +0000
Message-ID: <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
Date: Fri, 8 Sep 2023 09:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_001839_295301_907182D1 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
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

On 9/7/23 09:47, Yi Zhang wrote:
> Seems I reproduced this issue[3] when I run [1] on the latest
> linux-block/for-next with kernel config[2].
> 
> [1]nvme_trtype=rdma ./check nvme/
> 
> [2] https://pastebin.com/u9fh7dbX
> 
But isn't this the same issue as the circular locking discussed earlier?

Can you check if the patch
'nvmet-tcp: avoid circular locking dependency on install_queue()'
fixes this issue, too?

Cheers,

Hannes
--
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


