Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E8C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yauJ3kKXZYCUgbsB6MV0tZE1GNuk95Zq1vEY3U6GDm4=; b=tdzDYvOckNZusFTYT+KjfSQU3t
	SMYcqJQLV3b7gCnhrz5WHNaJUr+PJOnfgs4maSW8maea6E40afYc844E0tQwnNLjJwS9ceyMKqdpM
	hgb3huOSdhHsBstA99LtIFcud3h0FGqKwMagfSj7s9WRq3c9BT/W7ZpqNttJQzp8kYWZiWt9rpTbg
	oaWCkKtvKhCdioIye9ZigG8dNuVh6MVv2w99o8koNa6Gb/0R6gih8RcpwUL8V9ojKTHng+3esWq5q
	7BH7MsglS0pn+qMqTkKeJY4Ju3vzFOtNSYEZEzZ3DZnTlXciNz8yRpL0yKnJGIu36h3RqsiMiA+ON
	HVKY+8hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRW45-00E721-7Q; Mon, 13 Feb 2023 10:28:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRW42-00E71S-FN
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:28:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD51A1F8CD;
	Mon, 13 Feb 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676284080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yauJ3kKXZYCUgbsB6MV0tZE1GNuk95Zq1vEY3U6GDm4=;
	b=0Q3MgMXdTJhDBFtt08vRKaHFe1l7JLU2EGyMH9nrd3gqGv2W47GNDUvfo/WGqt4Z1cq5qy
	wfHD6E6B+jHv+cWuwAjt7gVkimHjrNAKRW5AMK5qV13Gqngd9gg12mlpnnYs4UC8sqJrQf
	OyrHhZj7rlI5PiQOlF4W7RuLnzm9OAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676284080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yauJ3kKXZYCUgbsB6MV0tZE1GNuk95Zq1vEY3U6GDm4=;
	b=93ltGOE13OiIwSQIS9fLw42Rz2IGyJuI14xkhX0j0Tz4XjOoVjd1lRN137SUsJlYVDsNqe
	h5pBsEs/hgtQ3zDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB427138E6;
	Mon, 13 Feb 2023 10:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Yq04MbAQ6mO3ewAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 13 Feb 2023 10:28:00 +0000
Message-ID: <42618eea-5a4a-f0cf-9e6d-e1ae36357847@suse.de>
Date: Mon, 13 Feb 2023 11:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] nvme: retry authentication commands if DNR status bit
 is not set
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "George, Martin" <Martin.George@netapp.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-6-hare@suse.de>
 <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_022802_681985_68DEF918 
X-CRM114-Status: GOOD (  19.14  )
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

On 2/13/23 11:14, Sagi Grimberg wrote:
>> Clear the FAILFAST_DRIVER bit for authentication commands
>> allowing them to be retried in nvme_decide_disposition() if the DNR
>> bit is not set in the command result.
> 
> Can you please explain what is this fixing? and is there a test
> to reproduce this?
> 
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/auth.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index ef5dcd885b0c..935f340607a7 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>> int qid,
>>               "qid %d auth_submit failed to map, error %d\n",
>>               qid, ret);
>>       } else {
>> +        /* Clear failfast flag to allow for retries */
>> +        req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
> 
> This should come right after the allocation.
> But what makes this special than any other fabrics/admin command?
> Why is it different than connect for example?

It is not different; it does, however, introduce a difference in behaviour.
And hence I didn't enable it for all commands, as previously we didn't 
retry, and it's questionable if we should for things like 
'reg_read'/'reg_write' and friends.

But you are correct for connect, though; we really should retry that 
one, too, if the DNR bit is not set.

Cheers,

Hannes


