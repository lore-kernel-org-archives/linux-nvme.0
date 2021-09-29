Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 20:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A974B61528
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 20:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A974B61528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOklL24104KQrDEiQe6HtrWsYOkE4G8iGhD8cX6b4Rc=; b=E/6cR2kkJHAWrtIDDsJpxNOYls
	1DL5VxO6eBuYdcYGriUQYZ7y5DOAlEQKB9UzUoFpID5IEAFtuECRVzi5BhK/CVBiIuGdsHxrzerU5
	Zarwun0tL3LNfW8OSJC2zZpr2hxWxwmIyepvWxwIi1gO8F0enJRaXf20xBZy6F04teDtrsKbgfKZK
	35dUbxlRcpWnPkzdCCvpbPvCSzsAF1JOUpe8v5BPUxBpn9GKvv4kUEipS7UBLVjnfanRZ5kM7UYjH
	wWmNXPgYGQzhehGvwSdhPqBCMFFbNazTm3s95DNWr1nFL+GlIF6kahA2+8a7A4rYVSxl3IGWi0rjx
	eehq+a/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVfmT-00CEyE-BN; Wed, 29 Sep 2021 20:02:17 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVfmQ-00CExr-4y
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 20:02:15 +0000
Received: by mail-ed1-f45.google.com with SMTP id ba1so13123247edb.4
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 13:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nTIu0JjIE9yiescS44nr41e9dJfc3HwjuPicp2NLKZk=;
 b=fhiPQbLr5ZeYAo6PVtoZTcK3Oa1/fXU/HT6i4Qk8dZh6SkN2avkmw2ipiIvAh1vupf
 LhWGojA277pGJS7gXUHu76Z0Y7BUCfzR0kXQihTCcERrRW0DlomYKAJcksIYYu7nhl7p
 prj8LL04dma9hSae9uN5XSOXJZkjNnvbaHpKLNtPX7H6GK4oHhWm318+E/783X+Gq4h0
 RLJ2PwwENCWyE3Dxsr9JwkThO/OVcMCV7hMH/KPK6qiR94lRuxJMMu9KN0W3XLLqloT1
 72Qof8hRd3U7a1jygRD3kyUAp7hzePMuQ/TRCS8tsvEgBu1dw3K/zOYbkY0FTnDPRpGQ
 KH0Q==
X-Gm-Message-State: AOAM533+cDySCJ77I3ExGm0B9vD6nX7v4RE/ue9R337OPs6iN4GnpPqu
 ukJNObJFzzGD6wgdI3wx21Y=
X-Google-Smtp-Source: ABdhPJw1PJ/QsV2JRoMrh3irx4PCe7jSiTcGUcDVgp3OIA9vaDfqJjkLbgIxP+WUzOkDOH/6cz0nrg==
X-Received: by 2002:a17:906:5cf:: with SMTP id
 t15mr1985852ejt.375.1632945732121; 
 Wed, 29 Sep 2021 13:02:12 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id 19sm474539ejw.31.2021.09.29.13.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 13:02:11 -0700 (PDT)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210928060356.27338-1-hare@suse.de>
 <20210928060356.27338-11-hare@suse.de>
 <d8827017-f8a7-c1fc-1950-8ac6c5997103@grimberg.me>
 <d1f4cd0c-1d53-6eff-83e2-d1b4d04b7221@suse.de>
 <e876b96a-e24b-d0de-0c62-d4345c4f8714@grimberg.me>
 <c1c90d31-a4c3-ab13-2f29-55a103715ef8@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a850b479-cea5-fdf3-2ea8-00a2b3e601b5@grimberg.me>
Date: Wed, 29 Sep 2021 23:02:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c1c90d31-a4c3-ab13-2f29-55a103715ef8@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_130214_252699_57517A31 
X-CRM114-Status: GOOD (  16.66  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> On the target:
>> # grep -r ''
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress\:uuid\:b73ff014-2723-4114-aa8d-2f784ecba4f4/
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_dhgroup:null
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_hash:hmac(sha512)
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_ctrl_key:
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_key:DHHC-1:03:KUwVlIUo627Pn05W/lRL2XD57kzIs1yZzJWdd2vgZJUC74kr:
>>
>>
>> On the host:
>> # ./nvme connect-all
>> --dhchap-secret="DHHC-1:03:KUwVlIUo627Pn05W/lRL2XD57kzIs1yZzJWdd2vgZJUC74kr:"
>>
>> failed to connect controller, error 5
>>
>> On the target dmesg:
>> [ 8695.716117] nvmet: creating controller 1 for subsystem
>> nqn.2014-08.org.nvmexpress.discovery for NQN
>> nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4.
>> [ 8695.749996] nvmet: creating controller 2 for subsystem testnqn1 for
>> NQN nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4
>> with DH-HMAC-CHAP.
>> [ 8695.755361] nvmet: ctrl 2 qid 0 failure1 (1)
>> [ 8695.755449] nvmet: ctrl 2 fatal error occurred!
>>
>> On the host dmesg:
>> [ 8781.616712] nvme nvme1: new ctrl: NQN
>> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
>> [ 8781.637954] nvme nvme2: qid 0: authentication failed
>> [ 8781.638084] nvme nvme2: failed to connect queue: 0 ret=401
>>
>> If I change the dhchap_hash to hmac(sha256) authentication succeeds.
>> The failure with hmac(sha512) comes from the above condition as the
>> host is sending key length 64 and nvmet is expecting 32.
> 
> A-ha. That shouldn't have happened; selecting the hash on the target was
> _supposed_ to be reflected to the host.
> 
> You did mention something about blocktests; guess I'll need to bite the
> bullet and actually implement something there.

That is why I mentioned it ;)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
