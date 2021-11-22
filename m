Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E71C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tbbevRhH2BN+cLXilsvvF3MyQy7tzQ1/scdTY35LU8A=; b=KrUReoRTzZ4teh3PASLw7BSTIP
	OnMoEOYaLcFDvtsPJlwAVrRTZUVAZOj7tg4BgvohmeD79JCLZf+imnYCssUCWKkkL/YSY5g0rId7H
	VgUMDz3VJyi7xM7jGqnEguKt9JR2dhek3TovPT8d48IvZ5+iZeChxoVP4s7kIbRg7fgXJJc3RaQtT
	jCsb1nCa+Qagp7rzIXcFdbgChScw8JSU7tAIk4z67PWZ/yCdgXGuB27qK+hbDts3ljDzxODo1oYqa
	kGzXP7b4QUJ8/hszxRKUsNr5m/2vgnKChLRsfLOBfza4rSyWEseD1Eem1QNrmxzziSbq2jCnI1tKp
	3v416Rjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8BP-00GHEM-KQ; Mon, 22 Nov 2021 12:12:27 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp7lQ-00G8DO-G3
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 11:45:38 +0000
Received: by mail-wm1-f54.google.com with SMTP id y196so15013470wmc.3
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 03:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tbbevRhH2BN+cLXilsvvF3MyQy7tzQ1/scdTY35LU8A=;
 b=LCfLq5eP8etCbSn7+6UDdvvnDaYNMg7Bwceg7hOp41fnC1RpWeCAbGQUIJeko1rnHV
 LW+n6/2rcypQztlUnvD9hwIMwd3Qvrgb30TQBbwUV0IhZJwYXRFV/6bQ1PbDmB1IJdfk
 S/wUA6/f+Fzy4xSZHJi3RL8YxDFJeWJ677BtWjhxApTQYRlHzS6nZvvofFoOMbgHatdQ
 5Re42kAWgIHyYyrcRIhdpcaHvr01nnTOM4KO4gjmIYX7WN8riqKMVTBPo4GLK6K3rFRY
 5RzohYE7Jma1iN5JJ7DoqlEh8W3yFhixHR5Z1O+hX+xC8w386Z+g1VSjbcqlvSC/BiW8
 YjZQ==
X-Gm-Message-State: AOAM533ykDC3eUwP+fE7ghIpW73ZuqyJca+qS2mjtNUr9g0C03Fl/Eor
 KfVGIZs3lIiLqEUcyhIysBw=
X-Google-Smtp-Source: ABdhPJzb3UiBq+TU9CNPSu2vLroNv/iclKwD8GQbQsBzssTyBM31OVRHTbf7kaiZuGJla24tOBZ+ww==
X-Received: by 2002:a1c:a592:: with SMTP id o140mr28775774wme.10.1637581535150; 
 Mon, 22 Nov 2021 03:45:35 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h15sm25598575wmq.32.2021.11.22.03.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 03:45:34 -0800 (PST)
Subject: Re: [PATCHv6 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.org>,
 linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <14b025bc-746f-ea73-a325-7805c4b46c28@grimberg.me>
 <8e0909ad-f431-2600-7b68-d86d014fc9ec@suse.de>
 <8ba377cc-5c33-7cba-456e-bfc890f1ad88@grimberg.me>
 <ff0acc79-40d7-8247-6f80-e1c6f635df3f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <153a78a9-8978-afc1-d321-35719feb5b7f@grimberg.me>
Date: Mon, 22 Nov 2021 13:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ff0acc79-40d7-8247-6f80-e1c6f635df3f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_034536_586357_3D749575 
X-CRM114-Status: GOOD (  12.55  )
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


>>>> What about the bug fix folded in?
>>>
>>> Yeah, and that, to
>>> Forgot to mention it.
>>
>> It is not the code that you shared in the other thread right?
>>
> Yes, it is.
> It has been folded into v6.

I don't see it in patch 07/12

