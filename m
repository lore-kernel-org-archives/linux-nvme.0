Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB59C3DA6F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KufHLa8qiX8ZvrwLb6e3dfBbke9UjLL2TqS8CHx6Fag=; b=xnbWkE8yOhra1ERoi+nP2qG7dX
	5HhVSq+nX8MS1HBvAvJMQntU/fDx+YEca+zq1EJeBSDf+oaEE8ei7c9ThZmFzng7fmWPtfSkqLiv7
	Oqme/QayEuvkbi+FiUCvON/xK7bgQBRFPGyKkNf2hJbOp/wFals8OUZ/V59+FYUhFx1wLrr/E1VMY
	7OWUVeKc9DNvMlzPHoTgSKmy1EYtYXbNgNzH4I4zMgP9y1h35KoyNk16Uk4WhNtoq1po3z+JQ3ony
	EA4UlIaJ9DX3BLV+qGJGwMVZ5SqZzflWZfbE5Rx8KqtRZA2LaAL6guCZctA9FPKiflkiwzT6n+CD0
	2lWWMu4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ7Ts-002lud-0I;
	Thu, 24 Aug 2023 10:22:24 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ7Tp-002ltJ-0E
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 10:22:22 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 30FA8480317;
	Thu, 24 Aug 2023 06:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692872540;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=KufHLa8qiX8ZvrwLb6e3dfBbke9UjLL2TqS8CHx6Fag=;
 b=1qQYwQ6WLssz/XOM/10YpPb7P43nXmZ86V2Hf2si7303Zg3gmKw1xhdsZRO8RQOH5NKdl
 5DPVAk7n5QoP8ImAw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692872540;
	cv=none; b=HyriQ/wyihUGWTCNjEJ6ODyaqhTWeHDqbrz1HkCCanFvJuWQQ3YHAGTL70g97Wg7O4ew/ATgmv8x+Rcfw+WkKfTFn0xmDqmVsRzA6KnDVWnithrzfolm9ZHYca9xrVtYAo9YDFsVsBIJhprQ60L9L7JvWCsamlobI/DZwthEtsPlWzxfJd2lp+xIOZwmd0G8RGzMH2exuWyQWBaJUbT/HN6TyNqYJVImRnnAFoK6I9Sc0RBp8AIr7fwiS69yEHatrCgzHENkmiL51Uf93riTSh5bQ9Itq0qyhrbR32g/cD/6oFSO3NHZ1y+4cOzqpBLZi1u6/ux0ZdL7FCHkgzePtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1692872540; c=relaxed/simple;
	bh=Zpsq7U/BuRxBt/NCOP9yDwQsPGzsVD3b8KgcZUs6cX8=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:From:To:Cc:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=HSd3D/WcEYM7qPD9Xrrwol2fh9z0KjRxXpisetTjCVmKy7S+qDeY6K8CeblBoanFfZtWYEt0ooUd+YgePxrthHbRQGkxbJsB4DT/zpg6UZ/qQgtOYXgnsO6BTOMjOde8L++haovBxSGfWRxYQCrSGwvXQlg6xTMKsct/6SzkoA8it04n5wUGqJaMMtubczgUtZm1+H0vj2lZAgYs7wSaCIIXpo+M7FH3h/dPhsgSI7pndO57I3tRzV96Fgg1ne6clpw7vqWtEYns11yXTGf8qhXJtHy/Urb9CIAlqFrtCPSgmrfwV+hKQLPTsCst1GQKzIZHIU1bSl3pERFsF3kGiQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692872540;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=KufHLa8qiX8ZvrwLb6e3dfBbke9UjLL2TqS8CHx6Fag=;
 b=l1X4u/6uzfeTakw7gS+qbyCDNYciUcqr1vAVoukJ5/H+y6wrXqJXqJNhXVbNjKZOpYbaa
 596QDhRqYpdIvkhDTcHvOlnfFqo/fob3iR4nWNxDFvtGllRodO/jBh8fx5bpsBizIAZdC97
 udiABNMVUflV52kCHOmvjXJOjQ3/b1eSXWobisA8x5oJXOd0K10nkW8jD0IaT3S+2Lg9+S1
 TrLA1dqjTvNMrqEjZtE3Qivt7vlV0kD+u9bkChvuGLdMv4Ewl5Qw4c9OsbJ3ALU2sOMWiB0
 48lX5ANlVTeqn5Rq+yglYcu4eiFTFegg1VN/jwkMXdS3MuoqmdmUG/E/Obzg==
Message-ID: <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
Date: Thu, 24 Aug 2023 06:22:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
From: Genes Lists <lists@sapience.com>
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
In-Reply-To: <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_032221_177553_8B446CFA 
X-CRM114-Status: GOOD (  17.41  )
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

On 8/24/23 05:48, Genes Lists wrote:
> On 8/23/23 22:44, Ricky WU wrote:
>> Hi Gene,
>>
>> I can't reproduce this issue on my side...
>>
>> So if you only revert this patch 
>> (69304c8d285b77c9a56d68f5ddb2558f27abf406) can work fine?
>> This patch only do is pull our clock request to HIGH if HOST need also 
>> can pull to LOW, and this only do on our device
>> I don’t think this will affect other ports...
>>
>> BR,
>> Ricky
> 
> Thanks Ricky - I will test revering just that commit and report back.  I 
> wont be able to get to it till later today (sometime after 2pm EDT) but 
> I will do it today.
> 
> FYI, i see one mpre report of someone experiencing same problem [1]
> 
> gene
> 
>   [1] https://bugs.archlinux.org/task/79439
> 
> 

That commit was what was reverted in the last step of the git bisect - 
and indeed reverting that commit makes the problem go away and machine 
then boots fine.

thanks

gene



