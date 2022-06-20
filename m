Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7439C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8fleZmC/X0n6h1h+zM9BXNleHpZyB7qJUNhAI3b854=; b=0AI+PiacrF7bu+ig11cE+cL/Ct
	teRYzWsSQu+vmY1A1RsKgf9shcmoPvh6EKbIbK4cfX0Wnxi8P6sRjUO1J4oAL7J2VMom8d0j9Gk0s
	KPIQNy5ey2ZWJ5wsDv2zclVsAwM8qdtvCaIynBmbj7BzsoDZG1Z+AsGv84j3bOyFBXZAGAIuOX7/e
	BjTWCeFR2c2NT8gNK9K5QJqkqAw75DsjW/vmIZ5SFAhAb3fZ3q/3IpUIdrCRLz7pypjmTqs10EWPp
	7o+ytrGPITvZkrL+w7Eb6oSqMV2NbApiJT8LLiLfFRSU81Xt9yTl6bw4oH/1QzA8NRV0kO3xZ1vQM
	MhqcmXJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BIR-00GX7O-06; Mon, 20 Jun 2022 06:54:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BIN-00GX6C-JJ
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:54:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C1A921BE6;
	Mon, 20 Jun 2022 06:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655708037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8fleZmC/X0n6h1h+zM9BXNleHpZyB7qJUNhAI3b854=;
	b=qd9kWgwEftGWmopd0sKyjBb1m8jbfc7emBdEKoOToe7N6p3RsVHUeh29VFs7sGNcS3yV8V
	TbOdxIkSnMNrfSKtqXJkoOnYON9kFKoC/T6Ugr6fA4Fr7/yOacysRVVu1X2bI0XN0xOhUR
	L2zaHksptfTkmS22a3EENovx5+8UtAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655708037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8fleZmC/X0n6h1h+zM9BXNleHpZyB7qJUNhAI3b854=;
	b=FYzIz0x5mAn+Us/E8yKbLhvNjtUlzPTAZUMIatOWQnuliDQJtgaNqhfxUlNuC/bhdcxh9X
	lbkuNKdrcPe2SzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E4F134CA;
	Mon, 20 Jun 2022 06:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zWRFB4UZsGKfdgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:53:57 +0000
Message-ID: <8186dc0b-de4a-b07b-7086-e34748cc73cc@suse.de>
Date: Mon, 20 Jun 2022 08:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-3-hare@suse.de>
 <20220614041237.aivy2ecbb2xzecfi@shindev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220614041237.aivy2ecbb2xzecfi@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_235359_819823_C3D8CC32 
X-CRM114-Status: GOOD (  17.54  )
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

On 6/14/22 06:12, Shinichiro Kawasaki wrote:
> On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
>> When removing a subsystem we need to clear out the allowed_hosts
>> subdirectory, otherwise removal will fail.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   tests/nvme/rc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index ad4324f..454609a 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -264,6 +264,7 @@ _remove_nvmet_subsystem() {
>>   	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>>   
>>   	_remove_nvmet_ns "${nvmet_subsystem}" "1"
>> +	rm "${subsys_path}"/allowed_hosts/*
> 
> When the allowed_hosts directory is empty, the rm command reports an error,
> and it makes nvme/003 fail:
> 
> nvme/003 (test if we're sending keep-alives to a discovery controller) [failed]
>      runtime  10.481s  ...  10.481s
>      --- tests/nvme/003.out      2022-06-02 10:18:53.539739780 +0900
>      +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/nvme/003.out.bad    2022-06-14 13:10:22.804354624 +0900
>      @@ -1,3 +1,4 @@
>       Running nvme/003
>       NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
>      +rm: cannot remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1/allowed_hosts/*': No such file or directory
>       Test complete
> 
> How about to add -f option to the rm?
> 
Yes, good point.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

