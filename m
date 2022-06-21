Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B71C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukvIAsal1kDm76X81Hesp7pMysW1cYX6Gm8+2oJuhFI=; b=ifHdqSMvkxGsY7m+gUQKoe0u2a
	jzaUzZHnrQ+exvpgUfqYJj+rv8eR9PEsvoFCs1kml4K4HxoOHE2nmBGEe8D3H9gF2ViTA651qgE4V
	CQLKjhawYSz9EizKU9zrNQpuQssbtzK9PeL3+lgd0iVCAi0jMXnAuXz0yYnyoZgxPgqfpUbtwwv5A
	kG+P3UUUpzrDMmow5ubkQzA0VFxLaXaNF9MADl40BD6GXKLW+OJ5xxhuffQzhmZTHE+6FeUTgOgiB
	ko/UI0rx+NTk6FIGIZTUR7IxbbMr6WGWsWO1CHvNOMED6E8mprop9rtUFIOlU6KU2li9olLD6rIWm
	d6RsYzuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3eph-005reM-Lf; Tue, 21 Jun 2022 14:26:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3epf-005rdR-F9
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 14:26:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74CC01F461;
	Tue, 21 Jun 2022 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655821577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukvIAsal1kDm76X81Hesp7pMysW1cYX6Gm8+2oJuhFI=;
	b=SgKN1obsbS/WCU5n2lauHPPEu4J+VEdgQe75My2OIut+F3un5rT4xifhJ2jMQfZIOAo4Po
	FHAeRGYmXndoeaxj4qhk2yg0t3jH3mb3r6v7deo9kavMcVBlPyCmdbmW6zc2XSgsX3g+mq
	Kd56S50rU2xhvXk8nOJHH0Z5k5IcgwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655821577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukvIAsal1kDm76X81Hesp7pMysW1cYX6Gm8+2oJuhFI=;
	b=RanCPfip+W/QkO0dx504KAhE+EZL5d3La7pLoZo/mriTvYEl1ixCAGPzY3keUUjuJp9fHe
	pvWTC8/cr7iFsJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 691AC13638;
	Tue, 21 Jun 2022 14:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QWxMGQnVsWI7TAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Jun 2022 14:26:17 +0000
Message-ID: <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
Date: Tue, 21 Jun 2022 16:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_072619_695132_C4F649FB 
X-CRM114-Status: UNSURE (   8.09  )
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

On 6/21/22 16:24, Sagi Grimberg wrote:
> This one doesn't compile against nvme-5.20.
> 
>> +    ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len, 0,
>> +                     qid == 0 ? NVME_QID_ANY : qid,
>> +                     0, flags);
> 
> here ^^^^^^^

Sheesh. I've compiled it against nvme-5.19, where it works perfectly.
Alright, once more unto the breach ...

Cheers,

Hannes


