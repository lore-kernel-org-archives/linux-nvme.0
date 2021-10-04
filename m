Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F27C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:24:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998A960F39
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 998A960F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qxTw0bZIGmjpkdWqtHBKx2ub+PzhkV7Tp88OofV0Wls=; b=Ew/dUt8ws53eQ3rA5YxxF09Dar
	/I0RXwwAwqo5wScrS0VRr0G1gkapBteG6BG/QSgIef1NlWFMSvouOWfbtC010UGcZ1DH0xW+6ck0M
	vDHY78BX5nZQ3SNk4J16zRDfXC46xvLA18ct8wmXjZb46R+6CbVmidB6JPtBdzRZ1kXlhnAWfEDSh
	A9eiGoV6ooszHDX3ZGuyL6/DoQHO7lEIP1ZDzgeNst0ExDohdXUhFsD8gKpDK+k9SsIEHULtQXBdP
	3tf/naZ4TT1vnY7QAPa4rScb/AXS3/YV5OP4NhpuE9it8BRW04F/oLb0SpCOuVTAc+QLObitl7kb+
	SUDVWR0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXNwr-006e6f-5W; Mon, 04 Oct 2021 13:24:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXNwo-006e5D-3U
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 13:24:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7238E22342;
 Mon,  4 Oct 2021 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633353838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TwkRSXS5JCLCkDqYamrsFjA8koiYSLMY2wMjINZOUo=;
 b=hDHz1vusdYqMQIhq0s5wWkKnyIap6GIimQyQFmdqZ+LwFybt1U/u3hHC8QSG5nJsrcjbCW
 wIVAsAgFlh10a/9zsCigSeag35Cof+8Q53AARptpJIaNTFcNB38CqksYqHZ7PfmUOVXHvA
 WkAFo8niwWY1iUJ3GC0+Eh2UR0dac3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633353838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TwkRSXS5JCLCkDqYamrsFjA8koiYSLMY2wMjINZOUo=;
 b=4s4Ay4W9cs3EOQQQPdrfztTPuBX0JB9c6vswji7qL7cJHBwVW4+wMn2yQrGcAovwHNEOR4
 cHSHJRlJ+B1k/mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A89312FC5;
 Mon,  4 Oct 2021 13:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bcEeCG4AW2HTSgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 04 Oct 2021 13:23:58 +0000
Subject: Re: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect
To: Daniel Wagner <dwagner@suse.de>, Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB42919DA26E7A75E9219F62DF9CAA9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20211001111142.cpergy5bcleywv72@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1e0cf035-aac8-6b18-4ce5-a42240c7cda1@suse.de>
Date: Mon, 4 Oct 2021 15:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001111142.cpergy5bcleywv72@carbon.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_062402_336841_F68B9808 
X-CRM114-Status: GOOD (  14.77  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/1/21 1:11 PM, Daniel Wagner wrote:
> On Thu, Sep 30, 2021 at 10:56:34AM -0400, Martin Belanger wrote:
>> @@ -244,8 +257,8 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>>   	cmd.prop_set.offset = cpu_to_le32(off);
>>   	cmd.prop_set.value = cpu_to_le64(val);
>>   
>> -	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
>> -			NVME_QID_ANY, 0, 0);
>> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
>> +				     timeout, NVME_QID_ANY, 0, 0);
> 
> If I am not mistaken nvmf_connect_io_queue() suffers from the same
> problem.
> 
Hmm. Not a big fan, I must admit.

If the controller is _not_ live we cannot send commands. And especially 
if the controller is in DELETING I really can't see how we _could_ send 
commands at all.

Wouldn't it be better to ensure that __nvme_submit_sync_cmd() returns an 
appropriate error?

Cheers,

Hannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
