Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D10C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ao3TO3fl4TQYcAvAE5Tjbx3YlGl25bmDv3Rsu9R0no=; b=AQrcxSf+c6wXNywjSNaQbcfhn9
	A0GE8m9UQoB4KBlUOEZUBULID9ql1zJEmqoFBBCI2Answguw5C93hDTHNOORW1+mA80NnJmIgUl/V
	DpxM8DCT8OrMdCFMsrwWjv3zdyYmpwdHjDWpQ7emd+sJleztY0gH6CYZQ3cmq58t56kCfUCdVST2V
	vJC8Q6bS3eAKOn0lsJZ27nLTKq/5fymgHg378bVxybBP+bbmZtMOBGsG4EYoyJq6Ded+EdhLh01kv
	Z+3pQTTaiaoVli6mpO8/XSxzVpXpUyPxcfBZasl/9QSG+Kdauuwkp5jixtIgG7FfkKTMPu3PRS88r
	vbV/LTdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzaZ-00Bmvz-24; Fri, 20 May 2022 10:10:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzaI-00Bmne-0f
 for linux-nvme@bombadil.infradead.org; Fri, 20 May 2022 10:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=5ao3TO3fl4TQYcAvAE5Tjbx3YlGl25bmDv3Rsu9R0no=; b=ai+Qms9ZUfaDz/KBjXUNVGizfs
 wsK4oPQ1/LRpDtDncplWV3+dbZRx2hH4p/t/Mq6k8ac03+9PqFeKZYophHHGLaLZKMx5FL3WCIIY2
 iZgqyjFGKrJM0gMQ++AYZuPSWekp+Swku+TZOex0m4bc1UrYY/ACSvagyS6Z3D9IfCT1QXL90QjvE
 CE5Cio4AWQQVXd/S6RFBC+98TXmDxtyXOixuoE/UifevTCFvohT0IFah4e0gUS+7+PAeeuQM+iFK6
 ZG+LS0UCR29veOhE7xs4EYJIk1hR2GNct/ywinb0eASKWL4DBBcQePrprn0rfAehCIFVwCou5A08/
 TDhhmC4Q==;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzSB-002IvH-QW
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:01:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0530B21C6D;
 Fri, 20 May 2022 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653040909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ao3TO3fl4TQYcAvAE5Tjbx3YlGl25bmDv3Rsu9R0no=;
 b=uunM6D7ZusHbTeyrHbaaeMe46n1/g0KHTI7Msclrrt5hdeyPeNkRphsNxH2YAmT/zXM3RZ
 UCYCp0Preh1o1sNXP0a9WKq/CX7cUv3a5SF/Lx4Vgoy4Vaf3hjGygIML3JTJPxYrf4raWT
 LJLlJNsG7FqRHOqOenvcCcwr5tI/q9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653040909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ao3TO3fl4TQYcAvAE5Tjbx3YlGl25bmDv3Rsu9R0no=;
 b=w1Saaw5ZEW8DgY0YUfglXp2NoRc332qH5q23z70/VbJUqNpATPUojs68BMSZi6ZprHErhx
 Ui8n6IpT3wWjSYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA16513AF4;
 Fri, 20 May 2022 10:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mEMUNAxnh2KRfgAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 20 May 2022 10:01:48 +0000
Message-ID: <23ab4753-593f-e44a-b768-0c1d3682abb0@suse.de>
Date: Fri, 20 May 2022 12:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/3] nvme-tcp: queue stalls under high load
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <64f57dcf-f3d2-d1db-782e-4f48c542754d@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <64f57dcf-f3d2-d1db-782e-4f48c542754d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_110152_269425_DDE17FBE 
X-CRM114-Status: GOOD (  14.73  )
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

On 5/20/22 11:20, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> one of our partners registered queue stalls and I/O timeouts under
>> high load. Analysis revealed that we see an extremely 'choppy' I/O
>> behaviour when running large transfers on systems on low-performance
>> links (eg 1GigE networks).
>> We had a system with 30 queues trying to transfer 128M requests; simple
>> calculation shows that transferring a _single_ request on all queues
>> will take up to 38 seconds, thereby timing out the last request before
>> it got sent.
>> As a solution I first fixed up the timeout handler to reset the timeout
>> if the request is still queued or in the process of being send. The
>> second path modifies the send path to only allow for new requests if we
>> have enough space on the TX queue, and finally break up the send loop to
>> avoid system stalls when sending large request.
> 
> What is the average latency you are seeing with this test?
> I'm guessing more than 30 seconds :)

Yes, of course. Simple maths, in the end.
(Actually it's more as we're always triggering a reconnect cycle...)
And telling the customer to change his testcase only helps _so_ much.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

