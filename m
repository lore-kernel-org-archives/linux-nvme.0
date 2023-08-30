Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAACC83F15
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Aug 2023 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAQWYBmETROLjbPGuqGIMm8OdFb4xMwJG4FqWN0oL6A=; b=C7gy7JuE3N/uxo4wonjAn+jb29
	tQGxX77nJu2Je11mZdfjYWulepTm+MrpH1fiVpihWGt+llL0PZt33qiKxgm7hf9CR8+SO7ilqa5jg
	HnY+3PZYLZQySGt4mJZatiGkEH5i+9zazraXFTj+aYbngfQIGPGknH2rUSSC6JJgbocj7TxE4ZKFj
	q0caf7a675wON0TUvVFXqFDTIC872DRCMFdpnN+gLgKT27cXbd7KiTZ/AVUoqIIP3xh9+ndA4NjTR
	P1nu9SL735IyIiITnUqIxUtDU5ixGdeSuSHRMyvOocO09IXmKOJrN4/Zp95Y+A965VwINLfMgifCA
	Kz3koZiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbSR9-00EBBk-0K;
	Wed, 30 Aug 2023 21:09:15 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbSR6-00EBAc-2J
	for linux-nvme@lists.infradead.org;
	Wed, 30 Aug 2023 21:09:14 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id D737B480A54;
	Wed, 30 Aug 2023 17:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1693429747;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=JAQWYBmETROLjbPGuqGIMm8OdFb4xMwJG4FqWN0oL6A=;
 b=fM1Bq4eNemLcyRcbzAy8Q+wojExGbY8BB5+74Y2nwKJ4OgcBukkkb9FIMv9tSHxVQEwv1
 /4a14wBFfDk1PFLCg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1693429747;
	cv=none; b=u9x97SgH2/mzbicAoyiCc70vrsQgu/pwyoxQsqmlx0/8nG0fcff/msnPxzxrmVLbxO9dH1srLSXI1HT786DhmfTFOmKR3EhCQQ4Y5JdfPiBGKlfaO+bc9YSgKqcJP/VbUW+Ycd3a/RH+aNsbdS2/AzbH/zZ6AqpbPujjSr5YbkbtXNGd+ZXz0yHjPuRa5D10e4egL/GTJKBucBRz+/pk815GJJgOvDDv3YD/ljH1TE851iX9cUjCGoB2ta3SBWR1wvocEVZXIwU1nLTQYZAa9s/i4QeHGv66wMIw0Z1UYxP15XbPFfEc4XUnQX820dzezwP28Q5104bhyRrwezZ5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1693429747; c=relaxed/simple;
	bh=bx/1ye1ATCuKlYf8lNYXgl0XOYb5h0RDxuCDSH1XrAY=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=hZwQNQC0DN0iTB/FC0Jr/UnUoTcwUz8an4BmNJs2b3mdwBkEK1gpZsWsMBh2NiA3HMJvxeJ3hKxodAlqRFZpCCIg7JQYKBU4ZO1gDT+PGKbcJ2hpJZii7GQrsMPuZASfqQ6yoOvDWnqrEd4jnGsJJpsijjNHT7x0R5JDQpMqAgDF8WG7z4BBkNjH6k2ha2FXMyGnVcs6qzAKn4MwPzRInpdTJTpVUrMxf7zDAtXKcY04O52DRQA8M0Hepo7POWwuLdBpqOsL37EJi7i7mwS9PjqqMG4x0Z2zuV2YoVt6oGvztGnoQobA2ovld2Nt5mUdDM2QREdaphe5lvLthy9y/A==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1693429747;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=JAQWYBmETROLjbPGuqGIMm8OdFb4xMwJG4FqWN0oL6A=;
 b=cLbAIERhmhwAtcDdtpbtePCREplLgq9j6EIT267NRbrok72WqlW9WW8EC5L+mQ9h4mMa8
 R9hHPI9h/sYnhSDCYy873UwG3ZUadu39zAmIMpn0q9ABdUagio2PSNx9M7b6QqXo+SsJKJy
 fuyM+mBvskMdNYSyIm7qWODsdfTSvF3QBG3FkkRxr2v5lHpWpSwQKqL4DAEv0vBVkUQPnBA
 FgkvSIw20LbnQ8ldmSYYgdc20Im1+iLGrtCySZOF3wxbgDe2ArK9u+sJj00+i3O+YRxyCt7
 Pxtt4vurKiFVuNGDaWPV/U3cO1W/b4t1eXW/a2xeOqSXnZWFkLmYWqMzwABA==
Message-ID: <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
Date: Wed, 30 Aug 2023 17:09:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To: Ricky WU <ricky_wu@realtek.com>, Keith Busch <kbusch@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
 <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
 <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
From: Genes Lists <lists@sapience.com>
In-Reply-To: <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_140912_854974_7422F2CD 
X-CRM114-Status: GOOD (  13.99  )
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

...
> I think maybe it is a system power saving issue....
> In the past if the BIOS(config space) not set L1-substate, our driver will keep drive low CLKREQ# when HOST want to enter power saving state that make whole system not enter the power saving state.
> But this patch we release the CLKREQ# to HOST, make whole system can enter power saving state success when the HOST want to enter the power saving state, but I don't  know why your system can not wake out success from power saving stat on the platform
> 
> Ricky
>      

Hi

    Thanks for continuing to look into this. Can you share your thoughts 
on best way to proceed going forward - do you plan to revert or 
something else?

thanks

gene


