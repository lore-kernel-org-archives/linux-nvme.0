Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B795C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVC/oDO35Mm9t5u8zdNjROMY0OSbK+vPTRsrVjO4cBQ=; b=qxMUimrrd5b5Zk8SwQRD2RKLT1
	XwDD4OoArNmzh8RvfzXUVM8KMFZ0BDUUDIA0vYewiz9BnEhb+2hpHeYi7Bq4gUMKYNgcjXCejtrze
	7u7kGIXu98APjccZKNrrm90cocVf8PUZIixtWwJgd8pKJ2t00/wBgHb8rb24+JhvGxBre722yRvI5
	ju4P5NpBgGtM27r/NmiJJU32+GwgRbSKRq/XDvPUNxlCxPco2GxCSA2HvZg/uFnBCsS5WRRAz9mfN
	D5mneozYFZ4F4CNOEUCjFCucUF1F9J0lJEIjYXaf4MVIAqK/79fJUTKLu5aQV6pYzZ9TI/QCXuc2z
	5xyu1BkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWQQ-004SpH-2b;
	Tue, 09 May 2023 23:07:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWQO-004Snu-0b
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:07:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00AB321BEC;
	Tue,  9 May 2023 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683673630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVC/oDO35Mm9t5u8zdNjROMY0OSbK+vPTRsrVjO4cBQ=;
	b=Vcj9EVcUUodtx10tDUVFAoziNeStynq1hSLAmgo2bUSGE5lLvbtrYpaUybi4dZTAd8uu/4
	59Iq/bjfsCZtnevkst5zAsqmZBVMlfRPobBXPuwIQPEkgWjVmRyslSHItJke9O8gpvCeSu
	Pn/xeSoh3EEwu77XzGZH+KyDbGKVVcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683673630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVC/oDO35Mm9t5u8zdNjROMY0OSbK+vPTRsrVjO4cBQ=;
	b=UDkwMb5msMERbyeYNHXwc4j/X7NmxzXL2c63q2LULIwu8qH0fCgtFwPw9C8zvs1vv3JrsY
	wsqNVreeMdIk5hDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 664E4139B3;
	Tue,  9 May 2023 23:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WnW+DxzSWmQIAwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 09 May 2023 23:07:08 +0000
Message-ID: <0794d1e7-7402-d41b-3d0d-7ff159645bf7@suse.de>
Date: Wed, 10 May 2023 01:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 07/17] net/tls: handle MSG_EOR for tls_sw TX flow
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-8-hare@suse.de>
 <fb934ee3-879f-f33f-efeb-945ccc9dc9a3@nvidia.com>
 <f3fe3fc4-b885-d981-9685-4b1a377db639@suse.de>
 <20230509081308.4a531d4e@kernel.org>
 <5e603985-6ef1-879d-cc52-a093a1366795@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5e603985-6ef1-879d-cc52-a093a1366795@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_160716_394630_A4875781 
X-CRM114-Status: GOOD (  14.14  )
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

On 5/10/23 01:02, Max Gurtovoy wrote:
> 
> 
> On 09/05/2023 18:13, Jakub Kicinski wrote:
>> On Tue, 9 May 2023 16:18:30 +0200 Hannes Reinecke wrote:
>>>> This seems like a nice optimization but seems not mandatory for the
>>>> acceptance of TLS support in nvme/tcp.
>>>>
>>>> I wonder if this can go to net/tls as a standalone patch ?
>>>
>>> Errm. Without this NVMe/TLS will not work as sendmsg/sendpage will
>>> bail out.
>>> So yes, surely it can be applied as a standalone patch, but that
>>> only makes sense if it will be applied _before_ the rest of the
>>> nvme/tls patches.
> 
> how come it will bail out only for NVMe/TLS and not for Other_user/TLS ?
> 
Oh, it will bail for other TLS users as well.
Point is it will not bail for _non_ TLS connections, causing the issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


