Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0B3EE57E4
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iE/MifZUFhBLW4YfWK4elA3RXA0pZRBZ1zmDbLfI+QQ=; b=tv4OLDWNOthrWcUwCirO8XFpZp
	hdjgom78dduDuCazU/jWTLynDoW5PmNbTUUwH89nG/oAykNy7VETrTMDQCO7w7RoaRX0l2xWnxe96
	DVOpVP209WXYJKxNMRZULl63w08YZIbrg4UO5zmjVVR1t5qt45Wsf23t1aVq4ck8N2t7keFyJnrg6
	NWo46vH02x85thNpr/IZ8dKokyx2th7zSu/dUFQgIBvBbaDC6TGmzyLO+XQtGgH0f6ehvhq7ge3mB
	qKhQTfltsixvE7vwAZ7n0sqxzbwgQ2WByFUYwxpNi8XhlnMAqcglmtBb+DJwMrhLaFY7sWs5K/W+B
	rweo9GBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeX8N-00DLYo-2O;
	Fri, 08 Sep 2023 08:46:35 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeX8L-00DLY6-13
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 08:46:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AF771F74D;
	Fri,  8 Sep 2023 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694162787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE/MifZUFhBLW4YfWK4elA3RXA0pZRBZ1zmDbLfI+QQ=;
	b=wZ+8i0de0OYdt25QjJes/75tPnGlZfp+FpeQj7aYa8M5WN/rXRr5nkzxvMAMZaNCH8gdGK
	eAizdX9H8QyNWLrSnwctwJ+zEttH+SbZyHv/44mwx2eeAd8Ffu6CzqZobJxRlmvAuMOYlb
	73DbTXYTwiX8xzBDtXUU3DffGp3OHRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694162787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE/MifZUFhBLW4YfWK4elA3RXA0pZRBZ1zmDbLfI+QQ=;
	b=BBgXI84RiFxQnbUi2nwO6WR2Ow4R6tV7rneWGPZPGerM9G42ew0+EiHbj6HorhFHeWHzDr
	19ueOK+VvTZhBqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C669A131FD;
	Fri,  8 Sep 2023 08:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EGPuKmLf+mQ0OwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 08:46:26 +0000
Message-ID: <867b9e99-ec99-4227-bf4e-5600cd241cea@suse.de>
Date: Fri, 8 Sep 2023 10:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep
 warning
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
 <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
 <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
 <CAHj4cs_bn=mCiVu1ZhZYUhf950TsHzdLe4++9N2ebHsLq2YGwg@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs_bn=mCiVu1ZhZYUhf950TsHzdLe4++9N2ebHsLq2YGwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_014633_510152_045B4130 
X-CRM114-Status: GOOD (  13.68  )
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

On 9/8/23 10:44, Yi Zhang wrote:
> On Fri, Sep 8, 2023 at 4:09 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>
>> On Fri, Sep 8, 2023 at 3:15 PM Hannes Reinecke <hare@suse.de> wrote:
>>>
>>> On 9/7/23 10:12, Guoqing Jiang wrote:
>>>> Hi Yi,
>>>>
>>>> On 9/7/23 14:41, Yi Zhang wrote:
>>>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>>>>
>>>>> Confirmed below issue was fixed by this patch:
>>>>
>>>> Thanks a lot for the test!
>>>>
>>>> And I had got another similar lockdep warning about nvmet-rdma.
>>>>
>>> Please note that this issue is fixed by my patch 'nvmet-tcp: avoid
>>> circular locking dependency on install_queue()' send earlier to this list.
>>>
>>> Can you please test with that one to see if it fixes the issue for you?
> 
> Hi Hannes
> There are changes in nvmet_tcp_install_queue and the patch cannot be
> cleanly applied,
>  > Could you check it, Thanks.
> 
Ah, right. Why, but of course I'll be resending it.

Cheers,

Hannes


