Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E31BC001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caU6LmN+uBuUCPGEPatPHJikWsFS0nkylZDpP2pkBrg=; b=i4yvXsKX8EE9N4Y72GLZUtmfmI
	OZaxLayyjxJSjKIQJVBH7WCB46MEYoSyREa52BvRAzpNMAEn8oSKg1U7KA7XuZpUl7+mcVgMYJsmg
	b/LKSY+jBtDxERIr+pL3wIrCvK4Pko1lUFT07FR16vPJr3XDNbZWbqICwutMybexDaxOKLvMR00ox
	txc+p+SkBCpYuHhv9bAR6uodIWr7YuAv/E6I5tstjQOZaM2W+ovC5SdRD0ZFf+i+AxqucXOLIO03P
	xidJ9AtjPm8n3y0m6tRSThMiNpd3Rn/pKfaxVkzh+bnaIRunaQGTvnKxbz6iafaI5tSs29ukj3Kkp
	7r5I+tgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5nm-007kMT-1K;
	Thu, 10 Aug 2023 13:34:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5nj-007kLs-1e
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:34:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 471451F74B;
	Thu, 10 Aug 2023 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caU6LmN+uBuUCPGEPatPHJikWsFS0nkylZDpP2pkBrg=;
	b=Re9G7vfU4x0lMXvd+2rGesZvHZL9ZGEkh2nlYk066rnSWIPIBctlkRUlj+QzOZID3pt4t3
	QY/8HHEsarKaFgRMeFhaFd739IYS2LfaPvnPf50+cLdYDfT0cq57sJnFkseSVjx3a0zzaw
	ZGFpRDFd1PmrwAVFw84DIExaeUMl8H4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caU6LmN+uBuUCPGEPatPHJikWsFS0nkylZDpP2pkBrg=;
	b=3WiEjbS6m/QTWyFd8dSTAX1+fK9k+0+UWLYLotr9TQsmY8QZavJw+CDl7VmKmtP0Uog24g
	J0Us3Lxp0GLiKqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15DD9138E2;
	Thu, 10 Aug 2023 13:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YD3wA07n1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:34:06 +0000
Message-ID: <fa164dea-b34f-40dc-90a5-091d3a7f5b11@suse.de>
Date: Thu, 10 Aug 2023 15:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063407_685889_D39BC31A 
X-CRM114-Status: GOOD (  19.48  )
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

On 7/24/23 11:20, Sagi Grimberg wrote:
> Currently nvme-cli is able to resolve an ip address from a dns name if
> traddr argument was given as a dns name, so it does that and passes down
> to the kernel the resolved ip address.
> 
> However, if the dns resolution changes over time, the kernel will not
> be able to reconnect because it has a stale ip address. While this is
> not a real use case for nvme subsystems, it could be a valid use-case
> for discovery controllers, where the resolution is made from a dns
> name that may load-balance/failover over multiple endpoints.
> 
> The last patch (7/6) is for libnvme to pass down the traddr as a dns
> name if the kernel supports dns queries.
> 
> The inspiration was taken from the nfs client that does this for
> redirects or locations discovery.
> 
> It is an rfc, so feedback is welcome.
> 
> Sagi Grimberg (6):
>    nvme-fabrics: add helper to resolve ipv4/ipv6 or dns name
>    nvme-tcp: use nvmf_resolve_address helper
>    nvme-tcp: re-resolve traddr upon reconnect in case it is a dns name
>    nvme-rdma: use nvmf_resolve_address helper
>    nvme-rdma: re-resolve traddr upon reconnect in case it is a dns name
>    nvme-fabrics: expose support for traddr as dns names to userspace
> 
>   drivers/nvme/host/fabrics.c | 29 +++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  2 ++
>   drivers/nvme/host/rdma.c    | 21 +++++++++++++--------
>   drivers/nvme/host/tcp.c     | 21 +++++++++++++--------
>   4 files changed, 57 insertions(+), 16 deletions(-)
> 
In principle looks good, but what about target support?

Cheers,

Hannes


