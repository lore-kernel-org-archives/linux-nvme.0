Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123A0C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=POFTmNZqo7YfxmW5BQWFljbickxNcer7z+h65BniyJ4=; b=iGY766wQde40TVKBJ/H8mv2Aa3
	3yanPR+Mxy+zb7VbpNbrOn9ZmIcOUyUdF1lEGtp4KnGRCPgjSFEblHGGl1r1iggZbkhUrfxlTYzO2
	FinbW5u+ROUQmSxJD6dFvuyNXF+j4OGV1OPyP/TW7JJmvOrJEpvZjkMGzMliP1gS58/OpSzfPKP5p
	V5MnHQGsO2RiW0MMxJNDoMz+N9iCw4JchYdflsocLTzL9xiG1HVWMBz8e6VRliC5ay6iTHg+x/ywJ
	UINwaOnyu2I8JAk9sIwNIRKm1+AoUTbgYljSyPXZCTJuUMW1NYA7PSb7v6xvK5XgnfKpJ8wVGR1LU
	Q/bmTC0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCLd-000000025y9-2ldH;
	Thu, 21 Mar 2024 06:56:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCLZ-000000025x4-0f1J
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 06:56:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFB3221A90;
	Thu, 21 Mar 2024 06:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711004175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POFTmNZqo7YfxmW5BQWFljbickxNcer7z+h65BniyJ4=;
	b=tI9LInhDNcnL6N5QhMn8JxmNcrpZBsbXXE/97tICr/AtKCPDS+Tweg3PkSg4DTdDyvZ2/M
	bOAbwoD0d4WqjLrwi1tE5G1BqfsISMWWGsCQ2MWhXEt3ylrkFo1TnvHpd70ZmvrS2Lr4SK
	rr9TxkFJKr1g7oylqZft9MHSm/BgX7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711004175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POFTmNZqo7YfxmW5BQWFljbickxNcer7z+h65BniyJ4=;
	b=0qPMV+p5Kh67b7LpUC/IZ6ht1OuGS5lfAxgy9yZ1Eyv4xtTbX77JXhT1VuIrfv8jYGuzrj
	y7y6ztjy/K2Q4xCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711004174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POFTmNZqo7YfxmW5BQWFljbickxNcer7z+h65BniyJ4=;
	b=DKZIXjI5iMDxZUR1Mc6VIEHB49IsxegNOBcTMC77nTNXQcYL+ReIKki5wpXZsOTNpMbScK
	1EPlnJhpIXOktTCYYJT5g75CpgokFXZtXNR4LTOmLk0vEb+bF904kb7VRtXWIFXPR6X2fs
	6p+IDC+Srd/FKlC9MH1aYE6MfrHVR4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711004174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POFTmNZqo7YfxmW5BQWFljbickxNcer7z+h65BniyJ4=;
	b=B7B1zC/2KWCGqXKxTCTRT31v+dXvzU4pAAOpf1dKDCmerMPKNGhoAm65PSA9M/cN6fYOeG
	4I7L0G6I1ubEY6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54D04136AD;
	Thu, 21 Mar 2024 06:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MKDEg7a+2VbVQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 21 Mar 2024 06:56:14 +0000
Message-ID: <ecf50b54-563f-418b-82ab-290df6fc180c@suse.de>
Date: Thu, 21 Mar 2024 07:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] nvmet-tcp: implement queue_peer_traddr()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20240320144017.106283-1-hare@kernel.org>
 <20240320144017.106283-4-hare@kernel.org>
 <17118de5-001c-4f08-a092-3b553a74feb9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <17118de5-001c-4f08-a092-3b553a74feb9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DKZIXjI5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="B7B1zC/2"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.57 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.17%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: BFB3221A90
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_235617_372898_3C4C9D78 
X-CRM114-Status: GOOD (  16.94  )
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

On 3/21/24 00:11, Sagi Grimberg wrote:
> 
> 
> On 20/03/2024 16:40, Hannes Reinecke wrote:
>> Implement callback to display the peer transport address.
> 
> s/peer/host
> 
Ok.

>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/target/tcp.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 4718d4d87a85..4b2cef897a66 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -2201,6 +2201,18 @@ static void nvmet_tcp_disc_port_addr(struct 
>> nvmet_req *req,
>>       }
>>   }
>> +static ssize_t nvmet_tcp_disc_peer_addr(struct nvmet_ctrl *ctrl,
>> +            struct nvmet_sq *sq, char *traddr, size_t traddr_len)
>> +{
>> +    struct nvmet_tcp_queue *queue =
>> +        container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>> +
>> +    if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
>> +        return -EINVAL;
>> +    return snprintf(traddr, traddr_len, "%pISc",
>> +            (struct sockaddr *)&queue->sockaddr_peer);
>> +}
>> +
>>   static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>>       .owner            = THIS_MODULE,
>>       .type            = NVMF_TRTYPE_TCP,
>> @@ -2211,6 +2223,7 @@ static const struct nvmet_fabrics_ops 
>> nvmet_tcp_ops = {
>>       .delete_ctrl        = nvmet_tcp_delete_ctrl,
>>       .install_queue        = nvmet_tcp_install_queue,
>>       .disc_traddr        = nvmet_tcp_disc_port_addr,
>> +    .queue_peertraddr    = nvmet_tcp_disc_peer_addr,
> 
> host_traddr, and it should really be per controller, and be taken from 
> the admin
> queue. Not sure how this would ever be different across queues in the 
> same ctrl

Okay, not a problem. Felt a bit odd in doing so, but okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


