Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD56C10F1E
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Dec 2022 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=laZ6RFBDhSWaoNTBPlP8oXOEoixoNdyZ9KXTwzAh+pI=; b=JGfGr6qROL8+gu
	EI8rTkSGN/71ykVSpWhePlCkS5F3wXp92pxmM3JcDG2sVVv9pxIlu1g8FNb1R4VSb2Q7QyWKl7SWV
	hHW+Zn38JY4z8fQFz5nKqWx59MD76JrHwj59ERhFcaZ/fRcpf+1luwpScU0ywLIM04R1BlZwNFaFN
	P2OUgTfD6iXeNNDK0CobhEwP3ZBmA8yWDngNCDzHnLjgvaldOKiqef9Tr/t3l9rhPTxQVOdsRD8fq
	k1ygQ4pr7EVrVpIr+lKjea2Y2La97nVT0Qt+yiTkmjENSiZpKVWPz481zLFHQAXin+8b4a7Yhq1Yb
	ok67mtpkz5C/PxlWklFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6pN1-00HImz-9C; Sun, 18 Dec 2022 08:50:07 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6n2a-00GOfJ-SR
	for linux-nvme@lists.infradead.org; Sun, 18 Dec 2022 06:20:54 +0000
Received: by mail-pl1-x62a.google.com with SMTP id x2so6109396plb.13
        for <linux-nvme@lists.infradead.org>; Sat, 17 Dec 2022 22:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=laZ6RFBDhSWaoNTBPlP8oXOEoixoNdyZ9KXTwzAh+pI=;
        b=GohYgD9ZL5leZtK2NaqGmd5lLqV4UN1/WOnjjgCc5UrywxJTlK4FVAoeckhH1jTxNt
         n7WccYdetp5i+2wrbbeTlGmprclvJm/s0zqNsdHT1huynu4T75N+2IG/SkpsR+jhjzZR
         VYbAzYScOytRdg8ZRVNbtm36w0KP5ED6vNHujlg+Cx+Em1iRCPYc5uYT0AhFRkxe//IE
         qos+235vlXZx5FoqcEx2expdZfBsGU8aP5MdZI3HLrEX6akt0MsXpoLrP3AMUg3MeLE+
         FvdWMI/9VqVUD0It56D7Jdp1VAALi05wrFRkhvhta/cDznnSf9JqpVxOSs6X8BVfCzj6
         pObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laZ6RFBDhSWaoNTBPlP8oXOEoixoNdyZ9KXTwzAh+pI=;
        b=J7X/1QUG9TfAgn30xwXDQ9f3nPYJn413/kKDFOOrPCLp+QBAjgmJQibxLV0mqLn4F5
         A6ZQ8KxEUV20fWG7NC4sfDBpt+ORUDj5os7vQGDvfPKXqOc7rYpVqkO1dciYv7Z6Rzil
         SIvYCPq0cy11l7h/PUeGUerrwUUsdEZdyON+m/nTspmymrZ+qGDwdp1YfCmBUAXnqh5p
         dntQ7cah5lP41ConHmZGfqga+ypp7ebzDwIyFRv0EVrmoX33oF7I0bgX5v51tTQG7tPA
         h44S2qaK6CSW+Ak+OhC4flWjAK7idiNQ3N/BRZ7rciWPbh9tnY48OTiUnbLx3o1XNH3a
         rnlw==
X-Gm-Message-State: ANoB5plzzdhhozkZ5Lh5mCdlnrTgDjx83cuaclRe/xgRn/53KvrlYmhj
	ar9Pct576Ez9T2HC9SXxrB3cP8JcO9E=
X-Google-Smtp-Source: AA0mqf4D7d5EjFKdikPAGKJWbLKtj4pfy8Wq5EFHiVhZQRO5LzVItq+7H9UyIVXXpJXPi1/yeYzFJQ==
X-Received: by 2002:a17:902:e885:b0:189:e577:c83e with SMTP id w5-20020a170902e88500b00189e577c83emr49736440plg.36.1671344450849;
        Sat, 17 Dec 2022 22:20:50 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0017f74cab9eesm4452602plf.128.2022.12.17.22.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 22:20:50 -0800 (PST)
Message-ID: <5f053ba0-5c2f-0fc7-1357-98c6ab0b3bdf@gmail.com>
Date: Sun, 18 Dec 2022 15:20:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: jfhart085@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, hch@lst.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_222052_976249_80DF3F04 
X-CRM114-Status: UNSURE (   6.94  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 18 Dec 2022 00:50:01 -0800
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following may be interesting to note:

This afternoon I also tried an fsck check on the smaller partition 
/dev/nvme0n1p2 (the 64MB one).  I made sure it was not mounted and 
repeatedly ran fsck on it without anything else between runs.  The 
results would alternate between reporting no damage, and reporting 
damage present.  Both occurrences were frequent.

J. Hart

> I have done an fsck check on the /dev/nvme0n1p3 file system after the rsync invocation referenced earlier.  In the first run I found errors which fsck should have repaired if I understand correctly.  In repeating the fsck invocation immediately afterwards, I found errors again each time.
> This was done using the replacement Samsung nvme ssd (Samsung 970 EVO Plus 500G).


