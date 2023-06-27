Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E698DEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWLUIp7q1rtPJfWo6m9bBCrc1CO7LCiTUvxN7NhIAdc=; b=MQ3ocKmImiLvMvMJzAWZv+5j8V
	5aVeSxc/m8DXE4sdTIhNa1+IeDwiHqxhou6Lox0yuahfnbb0Pyo+kPZ6VXYZvo2Phju3zQ653gt3z
	GszpJi/xtpXi86HFPE3FtZjL2RU6r9dcfnLGuyoSXB+lRulQTX4b3id7Kcj+WCOHwIr0Cf1EQuKuR
	JCKYwSHeQWoG1o5pCVo0vnBSORPjGr5fZSdrEO4eriF2JGgUJkWK4Jb8eUcZ4Utsrm4yQxWw5nSRG
	yJn6wrevwmb1/T8HO0q9ysz7FGdMNHsCDpyGQg99jXcHYQWD42yC+u8/zR4lgTLAmZc9Lx34y4ixt
	LVWwE6kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE2MH-00CACn-11;
	Tue, 27 Jun 2023 06:39:25 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE2MB-00CA9s-0n
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 06:39:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9360021850;
	Tue, 27 Jun 2023 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687847953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWLUIp7q1rtPJfWo6m9bBCrc1CO7LCiTUvxN7NhIAdc=;
	b=cWZcX6bURs991PZxqsLAalfq+9EmoAky51EkwHrC9rO9dm+kSlKGTIl8SJ++pkHT5IAnQC
	ZgS8RrDphkZT4PViQXAWoJePxPxLzbNCrVancoyPEXDPsIDFpKi60LjeOqZXDIc5R2RUDK
	mm0mxAVKIqk3hZ7OetyguJx9VUSrUF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687847953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWLUIp7q1rtPJfWo6m9bBCrc1CO7LCiTUvxN7NhIAdc=;
	b=jdgPoGRpyOY2B1JCf93i2JOKdNDRu2ho/hPPIz/2IB4FIExsRpSZ8pqns5L25w2Vm8A0sA
	pD5nybZs7hExBVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40D1013276;
	Tue, 27 Jun 2023 06:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id DaP/DRGEmmQbBAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 27 Jun 2023 06:39:13 +0000
Message-ID: <17321e5d-3744-dd7c-5ed9-cecf055ada39@suse.de>
Date: Tue, 27 Jun 2023 08:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
 <s7ojt6ad3i3t4ddqwxvxsxv4zxisz6skomogwbw3qljbuqkwr6@akwaxv2cyg2d>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <s7ojt6ad3i3t4ddqwxvxsxv4zxisz6skomogwbw3qljbuqkwr6@akwaxv2cyg2d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_233921_954361_6ACBE715 
X-CRM114-Status: GOOD (  25.58  )
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

On 6/27/23 08:18, Daniel Wagner wrote:
> On Mon, Jun 26, 2023 at 02:33:18PM +0300, Dan Carpenter wrote:
>>> @@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>>>   	/* force put free routine to ignore io queues */
>>>   	ctrl->ctrl.tagset = NULL;
>>>   
>>> +	if (ret > 0)
>>> +		ret = -EIO;
>>
>> All these checks for ret > 0 make me unhappy.  I don't understand how
>> they are a part of the commit.
> 
> We have two types of error message types in the nvme subsystem. The negative
> values are the usual ones and positive ones are nvme protocol errors.
> 
> For example if the authentication fails because of invalid credentials when
> doing the authentication nvmf_connect_admin_queue() will return a value of
> NVME_SC_AUTH_REQUIRED. This is also the value which gets propagated to this
> point here. The problem is any positive error code is interpreted as a valid
> pointer later in the code, which results in a crash.
> 
>> I have tried to look at the context and I think maybe you are working
>> around the fact that qla_nvme_ls_req() returns QLA_FUNCTION_FAILED on
>> error.
> 
> The auth blktests are exercising the error path here and that's why I added
> this check. BTW, we already use in other places, this is not completely new in
> this subsystem.
> 
>> Also the qla_nvme_ls_req() function EINVAL on error.  I just wrote a
>> commit message saying that none of the callers cared but I missed that
>> apparently gets returned to nvme_fc_init_ctrl().  :/
>> https://lore.kernel.org/all/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain/
> 
> Thank!
> 
>> Let's just fix qla_nvme_ls_req() instead of working around it here.
>>
>> And let's add a WARN_ON_ONCE() somewhere to prevent future bugs.
> 
> This makes sense for the driver APIs. Though for the core nvme subsystem this
> needs to be discusses/redesigned how to handle the protocol errors first.
> 
I would stick with the 'normal' nvme syntax of having negative errors as 
internal errors (ie errnos), '0' for no error, and positive numbers as 
NVMe protocol errors.
As such I would also advocate to not map NVMe protocol errors onto error 
numbers but rather fix the callers to not do a pointer conversion.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


