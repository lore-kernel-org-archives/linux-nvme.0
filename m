Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F139C761A6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUBwuZ+S4oapPXf+bptKK8G2dxg14Dvnu+AZ9g28Nfs=; b=Q3swWSvROMSbVSdqi9VfZrc7M/
	t4V/zz4iPhicKW9Rfb0yLgv2vJUHvZhtuJ0y9vtZqsad/hq6+mbqj3YxWbiBw8wbNtx/cHI7Ylldt
	DzTeVrUI3AoAF7wduyhhsQg8Vd7BMZvyZrlwv1vUJry2T9lxgo2SPB+R8fmS3rPsF6a/XOfTIL3mf
	cCa8yfeJ588p/LdbV0nKPSvlEXDNE3WpAnLCkdJu/1JXHFWDFjlX2pR6wMQnmojmp2bsTKZEKxr7m
	FPI+AmIlGOjxZhvmVzaa+fd+SpFt/hiKgOkiqN2fizbuHgdbylcV4lzNpWMUyVdQSdFddcE1lFUxx
	jLYaydBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJWk-00FJk8-2T;
	Mon, 03 Apr 2023 12:43:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJWh-00FJjA-21
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:43:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6FDB1FF3C;
	Mon,  3 Apr 2023 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680525787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUBwuZ+S4oapPXf+bptKK8G2dxg14Dvnu+AZ9g28Nfs=;
	b=0RE7HA8rYZk8RJy+JWaR1uzAHljKraQPunqfOF12wX2iMy4QVBiTG+kl1d9G4bwp0b9+Sq
	CyM3VqQivJ1/FW4v68Vgl2SCxVgEE2rFXtJUfGKMhde6YnFvio/y1WmnWdCDlIxbmxGt95
	ZSDeS1cSkNY2LzFKDpCT1Dhz3wdTF7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680525787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUBwuZ+S4oapPXf+bptKK8G2dxg14Dvnu+AZ9g28Nfs=;
	b=tBm+H358pUR7jML9ROjR1rfq4BXDFKtT5HM+jhC7fiWXDINltqJyhkPeWNGB3iupUrtyuL
	PcCKZhgsRLVu9/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB4181331A;
	Mon,  3 Apr 2023 12:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OJzAK9vJKmQoVQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Apr 2023 12:43:07 +0000
Message-ID: <9db0016b-f56c-99fc-45e0-26a5f48fb4e3@suse.de>
Date: Mon, 3 Apr 2023 14:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/18] nvmet: make TCP sectype settable via configfs
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-14-hare@suse.de>
 <6fe0b3db-d60d-822f-b03a-acf697e50ff2@grimberg.me>
 <0c2240f0-27cc-ba19-16d8-8aac0399dda5@suse.de>
 <2e63aeab-6384-e10a-40d7-bbe305bba51a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2e63aeab-6384-e10a-40d7-bbe305bba51a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_054311_838122_D65CC4F1 
X-CRM114-Status: GOOD (  13.98  )
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

On 4/3/23 14:31, Sagi Grimberg wrote:
> 
>>>> Add a new configfs attribute 'addr_tsas' to make the TCP sectype
>>>> settable via configfs.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/target/configfs.c | 67 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 67 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/target/configfs.c 
>>>> b/drivers/nvme/target/configfs.c
>>>> index 907143870da5..ca66ee6dc153 100644
>>>> --- a/drivers/nvme/target/configfs.c
>>>> +++ b/drivers/nvme/target/configfs.c
>>>> @@ -303,6 +303,11 @@ static void nvmet_port_init_tsas_rdma(struct 
>>>> nvmet_port *port)
>>>>       port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
>>>>   }
>>>> +static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int 
>>>> sectype)
>>>> +{
>>>> +    port->disc_addr.tsas.tcp.sectype = sectype;
>>>> +}
>>>> +
>>>>   static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>>>>           const char *page, size_t count)
>>>>   {
>>>> @@ -325,11 +330,72 @@ static ssize_t nvmet_addr_trtype_store(struct 
>>>> config_item *item,
>>>>       port->disc_addr.trtype = nvmet_transport[i].type;
>>>>       if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
>>>>           nvmet_port_init_tsas_rdma(port);
>>>> +    else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
>>>> +        nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
>>>>       return count;
>>>>   }
>>>>   CONFIGFS_ATTR(nvmet_, addr_trtype);
>>>> +static const struct nvmet_type_name_map nvmet_addr_tsas_tcp[] = {
>>>> +    { NVMF_TCP_SECTYPE_NONE,    "none" },
>>>> +    { NVMF_TCP_SECTYPE_TLS13,    "tls1.3" },
>>>> +};
>>>> +
>>>> +static const struct nvmet_type_name_map nvmet_addr_tsas_rdma[] = {
>>>> +    { NVMF_RDMA_QPTYPE_CONNECTED,    "connected" },
>>>> +    { NVMF_RDMA_QPTYPE_DATAGRAM,    "datagram"  },
>>>> +};
>>>> +
>>>> +static ssize_t nvmet_addr_tsas_show(struct config_item *item,
>>>> +        char *page)
>>>> +{
>>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>>> +    int i;
>>>> +
>>>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
>>>> +        for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
>>>> +            if (port->disc_addr.tsas.tcp.sectype == 
>>>> nvmet_addr_tsas_tcp[i].type)
>>>> +                return sprintf(page, "%s\n", 
>>>> nvmet_addr_tsas_tcp[i].name);
>>>> +        }
>>>> +        return sprintf(page, "reserved\n");
>>>
>>> What is reserved?
>>>
>> All other values?
> 
> Yes, you should just consolidate it outside the if-else instead of "not
> required" (which is a treq value iirc).
> 
Okay, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


