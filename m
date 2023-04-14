Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECAAC77B6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/rVxwmuhdoXjph7m3KFQaaxQ03CPZ8xng6hMKv1qM8=; b=M8MYtbzjE+9vThaVCqi/5zSdmB
	93MmpwCY7CxcX5h4wUMmzB0QCG/Pu2+FFB5nEeZL/ua/M5mq7uXy2xFAZbbQUYQ6hrlc+5Q1ZiT2g
	2SmuRhCoHxSCP5H9Cv0dU954T5AzrTRCX9WVMMc7wU+cQdU4ABOyaFhJISn4QJuLnhuTy2TWqNSV/
	0H2OAGdHh33g4MluIPJc88Fom8LTW6rGhXg8HmlPocSlI0zuwDBzh9QhuTG380VbL+umqau43pSCD
	I9SWmurZSjztbDCkuN88ChebbWrIpzwW75M9Je9+xg0Xny+PyxmoRqooGoMdN6yD5JJu7WByBlyuH
	zERWguiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnGht-0099SE-1o;
	Fri, 14 Apr 2023 10:31:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnGhp-0099Qc-0a
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 10:31:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5831FD93;
	Fri, 14 Apr 2023 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681468259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/rVxwmuhdoXjph7m3KFQaaxQ03CPZ8xng6hMKv1qM8=;
	b=fD2GWcOYUW7dLr3AZS33c9W0k3eI3Q22fLjAbwCJnQNxH8OESeSJY3tTx7yePcIfXsDiA2
	7xVOYvrWrusXUNfYhXiLZLt1hk+F6DV6shKIOypCioZqqUrgNJbyKssdFF+zjxigP0NjlI
	T3e9ouPfbliQbNZIaO9RRyR2FdJzecg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681468259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/rVxwmuhdoXjph7m3KFQaaxQ03CPZ8xng6hMKv1qM8=;
	b=bC/apYcRbNGMfsqACwDKZKP0ljGQzFi7tqJVShsGD4NAPIM90gcmb5snxKCAF9xoHT6OCs
	V52YX8B/1V/Y3dDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 645BF139FC;
	Fri, 14 Apr 2023 10:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vossGGMrOWSgKgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 14 Apr 2023 10:30:59 +0000
Message-ID: <02e4f6eb-32c2-8f3c-872f-831e70da6166@suse.de>
Date: Fri, 14 Apr 2023 12:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
 <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
 <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
 <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_033101_364300_4D0D2CD8 
X-CRM114-Status: GOOD (  13.44  )
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

On 4/3/23 17:53, Sagi Grimberg wrote:
> 
>>>> Add a configfs attribute to list and change the default keyring.
>>>
>>> is the keyring an attribute of a port? or a subsystem? Why the choice
>>> of making it per port?
>>>
>> As per discussion at fmds each port might want to use different 
>> credentials.
>> We can move it to subsystems if we decide we don't want to support 
>> that use-case.
> 
> I think we should move it to the subsystem in Linux.
> 
Easier said than done.

We can only fetch the subsystem once we have the NQN, which we will
know after the connect command.
But out of necessity the connect command will only be transferred
after TLS handshake completed, so there is not subsystem NQN allowing
us to figure out the correct subsystem.

So we'll have to keep it at the port level, I'm afraid.

Cheers,

Hannes


