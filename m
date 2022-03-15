Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A080DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9ouYZisA55hPIRM2d9Qlhez9h0feQGHyW8yMNwupeA=; b=HkVx1Ck2Ks7f1NbXdGY4aCfVcB
	cD8XJdB8rnkh3L6gtA6DWPxUdW1IZTypKiL5suyT+cDCc8b5vsfA1TFLme5Vox29KE2WwSs2h6XfX
	QGRjphQzMKE/biTP1EXHpfJ6ly2O1pwO9BkKzN4cu9y4J4hubChL+yKMpV95KIyf/SqWK4erKQvb2
	j+mQ1SmqtT3MdWp1rfIdcxSa08bBbblKDV2T4KWGPXUzQbXDKZwWTqfcrovt+uHSQIzbX11QwmN0W
	yNCt3h+/W4tBkvjWesYGDh3Qlst+CVOJ5Uo9PBJ2aRR/v3k12YqInMk0Ky+aJg3TtXCvg4z/+mFpv
	4RbLhH3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU6eY-0094Nm-BD; Tue, 15 Mar 2022 12:51:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU6eV-0094N2-37
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 12:51:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6E131F397;
 Tue, 15 Mar 2022 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647348708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9ouYZisA55hPIRM2d9Qlhez9h0feQGHyW8yMNwupeA=;
 b=stLbS9Eo5nl7ZFobAYA1/To6ZDEbhqaRwx8H/00CbbDhsFey0ruJD/CpJCFaGClmQ4vscN
 iTwEik31hTfk1lypjpHFLSB3N+CYZnRKHIBu37sMZcpaPD1RSnuiBfNqhlHNEoChqLq77x
 bsnX4jsFd8l54Oj457NsG+0MkdFXxpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647348708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9ouYZisA55hPIRM2d9Qlhez9h0feQGHyW8yMNwupeA=;
 b=gV4NMI8PTDF3nsNIKV9XDOURnzNNqR9KwIIgsY7ZHL84DJV2B96F4gM/QAtNtV2fwhqoKP
 vNuFbfU5MKHdBeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D5C13B59;
 Tue, 15 Mar 2022 12:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 58xaKOSLMGJ4XAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 12:51:48 +0000
Message-ID: <c44e33fb-b1b8-da7e-bc70-87a39a2b5bd8@suse.de>
Date: Tue, 15 Mar 2022 13:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
 <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
 <79067416-401e-7ee1-2de8-f67187aaecdb@suse.de>
 <b0334223-367b-690b-3a41-55ccae21b47a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
In-Reply-To: <b0334223-367b-690b-3a41-55ccae21b47a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_055151_346135_8267E2B8 
X-CRM114-Status: GOOD (  15.43  )
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

On 3/15/22 12:15, Sagi Grimberg wrote:
> 
[ .. ]
>> When you want to retrieve the discovery log manually _and_ have 
>> existing persistent discovery controllers you'll need to know which 
>> device to pick.
> 
> Please describe the use-case because I still don't understand.
> nvme-cli offers 'discover' that gives you the log page and 'connect-all'
> that connects to the subsystems it found in the log page.
> 
> Do you have foreign udev rules in addition to the ones supplied in
> nvme-cli? I am missing the problem statement that you are alluding to.
> 

No, not foreign rules; it's the manual call to 'nvme discover' which I 
try to simplify.

But you are right; unique discovery controllers are only important for 
authentication. Everything else is just to make the system 'nicer'.

So leave it for now and I'll come back with a different set of patches, 
as I _still_ see a benefit in being able to configure the discovery 
response.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

