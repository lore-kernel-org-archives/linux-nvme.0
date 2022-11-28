Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47CC4321E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Nov 2022 05:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kG9z2qzxuFG+VRjNYAaaunJxmRkVIHKxHuUo9QjcyE=; b=cpWFgxsvuFdt7vyorp13iodfSL
	xqZNCdTCOXe7k+f4T02dt7Y/iyyCid74SckJAuYgN1OfgE2CzCtI60bk2BC6FSVhGfjVhlLOjJqoF
	kPgEcsm4HRQ9jn/vj4lZ3NRnG2FKW8MsqzUpnQiaSWhIGbulE+l2X/MxzDL5CbXskFrPGUREQlpVZ
	kLZby+zQb9uK8qRFGK8v2X5+sOO+GqsZ4hbhlXvNHYBfy+sWduUcQNPflA57aactXmviZ8dkcUQd8
	XeRhUC7crjfWoHbvlsefctoaA43w+N42iq4D/afy0+w/hMN7TtdYlIznzubiSN7+IpE0DnsQQgrCg
	P9auEKwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozWRC-00GEOx-20; Mon, 28 Nov 2022 05:12:14 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozU2g-00F6C0-Np
	for linux-nvme@lists.infradead.org; Mon, 28 Nov 2022 02:38:48 +0000
Received: by mail-pg1-f175.google.com with SMTP id q71so8721206pgq.8
        for <linux-nvme@lists.infradead.org>; Sun, 27 Nov 2022 18:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kG9z2qzxuFG+VRjNYAaaunJxmRkVIHKxHuUo9QjcyE=;
        b=tRcM7UiXfwomBMlqc+ZClVCLfyV7Qil1sK0QOJhgLvZb3SVayDmCiuvhpzefp0DdAO
         9NoVAnqJxf56yg6xwdaXQ3VHAGTUOmSFRUCd2ssv5ehjIIpWvXCBIeUrzwJXBP0FPRqT
         +N9J+6s9EQr9vdocvZGPb3AWa2VE9ndZu6L4fOrIKlG3I8WCRUVBfucuHIJlS9aUFC6N
         Ad+zjb8uL7Mm194rzlZ8cJ9cZzfW+Z4+oszqVcbfm4G3YKiCOx10r/Fg6KN0AK7PypZd
         LblodcnxsKKUZ4uzGMAwAlxGDXhqZutzZO3dPDB7pdNXfSgJJ4e7FyrBDUqwWWxMjePM
         uh3A==
X-Gm-Message-State: ANoB5pn8uRMLDOXVpScVPZvXJB6i7EODp2+F8LKwGP8XDblxYCGtJ7iH
	FjnecJlS07RGaRS7WxHv7AI=
X-Google-Smtp-Source: AA0mqf5vmCbco6ZHPjAXXxhwtD8PwFo1rRkGl5sk/L6YEIBylIo5gFL0rkxaBBXNXZfCI6rD4vcBjA==
X-Received: by 2002:a63:388:0:b0:477:c828:dd2d with SMTP id 130-20020a630388000000b00477c828dd2dmr18012978pgd.105.1669603124285;
        Sun, 27 Nov 2022 18:38:44 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b00176ea6ce0efsm7507123plx.109.2022.11.27.18.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 18:38:43 -0800 (PST)
Message-ID: <5b14cdea-1bbe-1900-0004-a218ba97bbcb@acm.org>
Date: Sun, 27 Nov 2022 18:38:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] driver core: make struct class.dev_uevent() take a
 const *
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russell.h.weight@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Johan Hovold <johan@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Karsten Keil <isdn@linux-pingi.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Sebastian Reichel <sre@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Raed Salem <raeds@nvidia.com>, Chen Zhongjin <chenzhongjin@huawei.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Avihai Horon <avihaih@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Colin Ian King <colin.i.king@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jakob Koschel <jakobkoschel@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Wang Yufen
 <wangyufen@huawei.com>, linux-block@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <d448b944-708a-32d4-37d7-0be16ee5f73c@acm.org> <Y4NqAJW5V0tAP8ax@kroah.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y4NqAJW5V0tAP8ax@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221127_183846_810226_4848F605 
X-CRM114-Status: GOOD (  20.89  )
X-Mailman-Approved-At: Sun, 27 Nov 2022 21:11:51 -0800
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

On 11/27/22 05:45, Greg Kroah-Hartman wrote:
> On Fri, Nov 25, 2022 at 03:51:11PM -0800, Bart Van Assche wrote:
>> On 11/23/22 04:25, Greg Kroah-Hartman wrote:
>>> diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
>>> index 7dd1f01ec4f9..7aab4a769736 100644
>>> --- a/include/linux/mISDNif.h
>>> +++ b/include/linux/mISDNif.h
>>> @@ -586,7 +586,7 @@ extern struct mISDNclock *mISDN_register_clock(char *, int, clockctl_func_t *,
>>>    						void *);
>>>    extern void	mISDN_unregister_clock(struct mISDNclock *);
>>> -static inline struct mISDNdevice *dev_to_mISDN(struct device *dev)
>>> +static inline struct mISDNdevice *dev_to_mISDN(const struct device *dev)
>>>    {
>>>    	if (dev)
>>>    		return dev_get_drvdata(dev);
>>
>> Why does the dev_to_mISDN() function drop constness? I haven't found an
>> explanation for this in the cover letter.
> 
> I agree, this is going to be fixed up, see the thread starting here:
> 	https://lore.kernel.org/r/Y34+V2bCDdqujBDk@kroah.com
> 
> I'll work on making a const / non const version for these so that we
> don't loose the marking.
> 
> Oh wait, no, this function is fine, it's not modifying the device
> structure at all, and only returning the pointer in the private data
> stored in the device.  There is no loss of const-ness here.

Hi Greg,

This is what I found in include/linux/mISDNif.h:

struct mISDNdevice {
	struct mISDNchannel	D;
	u_int			id;
	u_int			Dprotocols;
	u_int			Bprotocols;
	u_int			nrbchan;
	u_char			channelmap[MISDN_CHMAP_SIZE];
	struct list_head	bchannels;
	struct mISDNchannel	*teimgr;
	struct device		dev;
};

As one can see 'dev' is a member of struct mISDNdevice. I still think 
that dev_to_mISDN() drops constness. Did I perhaps overlook something?

Bart.

