Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EFAC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NhJRTvC0Aop4+R17Q6R8aUdXettLEca36omgHanOwsQ=; b=EZMKyvfbx0vRmCv7U/zEzwZ7wS
	QArdlmPZXd43XahO/DN6uYWTMNdV8Xgyt9vSFNlenb5zpbiGlwEHtz0jXxAF4Oriqjc731XrWUC4A
	LgzPApvWTFhlgjoGeHTg9xeshuBGKqekWb1Sf8SvakQohTzxOMKOYHo1dnPpvgDG1OF34vrfX8o3U
	6ETJrEi+xr9yuQqJcZ5kf8uEHa+MDiJJ8CKk3o0moAwrHKIEyARm1tQgk1yUPdwZiMnF9/6wvcmP/
	FQNEkmEHD1u33lrHloZf/qKrpO28fK83iytILcyZPAbI5B45WjKis2SGAs2CFhA+GomvK0G1Bvq3H
	z1B7j93Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5kk-007jp4-1r;
	Thu, 10 Aug 2023 13:31:02 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5kh-007jno-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:31:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BCFB21864;
	Thu, 10 Aug 2023 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhJRTvC0Aop4+R17Q6R8aUdXettLEca36omgHanOwsQ=;
	b=DAxf80pM9m6+2GNtZWthPY6v81k8m3Nj+xAzxFOYgqzwq7GhTn14Mr3WP/FcuRBuCUjINo
	bmUUVVNWCqJHE6Ojz5eq9QI5mqHT80a1U6d96QkiG5RS+IdoDP1OmTBhjCE2bnm6cFj0hq
	qzFE0E8J/BPVzc1tHi2cNKl+7e5Tnkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhJRTvC0Aop4+R17Q6R8aUdXettLEca36omgHanOwsQ=;
	b=S10r+mcDI7UPGNg4W6PyrH9mV0sc2NeuL/+KzKhJ6ME3w0dGpiPzUAQNYR6g9fDW3y/OfO
	pMCA4Bh8lyZQEgCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D58A138E2;
	Thu, 10 Aug 2023 13:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mJl8AZLm1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:30:58 +0000
Message-ID: <7ce17be7-8343-4d0a-b37e-7647a7429b67@suse.de>
Date: Thu, 10 Aug 2023 15:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 3/6] nvme-tcp: re-resolve traddr upon reconnect in
 case it is a dns name
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063059_936561_4E00927E 
X-CRM114-Status: GOOD (  12.23  )
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
> In case traddr is a dns name, it may describe a different address
> during the controller lifetime. The classic example would be
> a discovery-service dns name that may be load-balanced via dns over
> multiple addresses.
> 
> So try to re-resolve the controller address. There is no dns query
> in case the traddr provided is an ip address.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



