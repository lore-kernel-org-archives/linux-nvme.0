Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E681C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gRpmwZs82/tAYaBVjoKhBpaPZnYQyYXbVDLZ4yqgjRs=; b=iW94xggFy43swCoj95QtLHGFvs
	9QPwwUP1pHwlFSnq72s3a3jYhXuoQLn1PUGTbH8WFxE4U3lO6yVa4UE1ydzwRw1IJElztszXe44p2
	m5zIFr8pcZnohRuevnu8Eho2QS6o1agyt5068xVuP71tuOntDzXxqlkoDOabWU9dxEZx8f7XYrubP
	72j3Iu/NQrPRvLmgrCBXll3WWjiGAnEUEXgoK8S1oaexeAV4SrAaP2/Qrq0icI+KtzVMYCJ21tJ7c
	AnU911ILTMKTINXz56dS/cUeipmxU8VOj5TM9UdXdJHANRU87clyV7842UfT6kAUP5OVtvuELwNtF
	1ehV8GXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poiVY-001dxX-2x;
	Tue, 18 Apr 2023 10:24:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poiVV-001dwC-0A
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:24:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 246C721873;
	Tue, 18 Apr 2023 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681813453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRpmwZs82/tAYaBVjoKhBpaPZnYQyYXbVDLZ4yqgjRs=;
	b=eGieBXdeje7cTRmXSnjvfsTvF5UvTGl6WI7Bm7eHHTaU+WVWPdJjSu8+f87Pu/EakiD9Y5
	VS6lYewj6dmVcMIyCGv1+A/IEMZ1jC6d9m+48D0QPI9N3ACRa1KjUqTn+9wX44FeNyXOo7
	OxaueaSEL/f4LZJBJXekGbeZEnyCyeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681813453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRpmwZs82/tAYaBVjoKhBpaPZnYQyYXbVDLZ4yqgjRs=;
	b=Ela2kisoefHSY851WxEDcd8fBl52lPbQREAFcttiWIsAZmsldCfOeZiKwab8IiGdrxsVUy
	vErkZ1B05Lm2g3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E0D1139CC;
	Tue, 18 Apr 2023 10:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /iboAs1vPmQPSQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 10:24:13 +0000
Message-ID: <db39fd2d-6da2-852e-70aa-7499fedf8b48@suse.de>
Date: Tue, 18 Apr 2023 12:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-8-hare@suse.de>
 <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
 <20230417131048.66b6b3a0@kernel.org>
 <beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_032417_236392_5F900874 
X-CRM114-Status: GOOD (  16.29  )
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

On 4/18/23 12:07, Sagi Grimberg wrote:
> 
>>>> The TLS stack is using MSG_EOR internally, so the flag cannot be
>>>> set for sendmsg()/sendpage(). But to avoid having the caller to
>>>> check whether TLS is active modify the code to clear the MSG_EOR
>>>> flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
>>>> conflict with MSG_EOR anyway.
>>>
>>> This looks like a temporary workaround to me.
>>>
>>> The networking folks really need to be CC'd on this (same for patch 6).
>>
>> Thanks, when I said "we can support EOR" I obviously meant support
>> not ignore it :(  No ack.
> 
> Obviously neither Hannes or I have sufficient tls knowledge to properly
> support it... It needs to be done by someone who knows the
> implementation.
> 
> Is this a large scope to add support for it? Because if it is, I'd
> simply change nvme to clear MSG_EOR when tls is used (despite my
> preference to not do special things for tls).

There's a rather simple patch for tls_sw. It already paces the data 
internally by an 'eor' variable, which is currently set to !MSG_MORE.
So evaluating MSG_EOR here is really trivial, and doesn't seem to cause 
any issues.

Or, at least, none which would show up with NVMe-over-TLS :-)

Cheers,

Hannes


