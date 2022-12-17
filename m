Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C63C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Dec 2022 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8YXEGo4E4wlHkJodsVnLSrzwMnIEDYHUKz/ZNJgp1Yg=; b=3SQQOBytzZNGnu
	4LcTggyFXS4SGax2bG9JfyQE1cASFsxc6bI3hyghCcP3mvcujv7uJ6mkTGgyX1rgFyM3tqo0+/Q1k
	Je/No2vLnLYH2rQ06M5hIE80fJaKGPqQt4KClRcEhMwcHl1uUz2qRt2CzeLCMzdUvzrUbmjGg1TF9
	WhHM7bcObYJ8GsTfnrJjMG56YBFsIyvcJ1CmgHQjbZoeZvqs1b4vXy82P5jAOqeyYbRr6bDsk41Du
	zU/arWXq2g0tWobW0C+rBszYRgnCyB9h3gVq2jZY2rplnxfIzCemgQAoGv/94dlJAqRcJYukQ/SGa
	axj65R3f9pIKf+5XkEDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6pMw-00HIm0-Sm; Sun, 18 Dec 2022 08:50:03 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6fBm-00DEmM-I9
	for linux-nvme@lists.infradead.org; Sat, 17 Dec 2022 21:57:51 +0000
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso9531862pjt.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 Dec 2022 13:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8YXEGo4E4wlHkJodsVnLSrzwMnIEDYHUKz/ZNJgp1Yg=;
        b=C7tLBZwO/Blf6uKmGLilMV22GTC52bHGphIp2EXcNEDB40FrNQmK6aaTYl/yuc9lk+
         DEqsxGzrxS78Ors56kCu7vgPFeUUpJMMjNnMjQoXGSV3m+lgXt0OrbufcK1A8981YCHb
         HZN15jk0zyBhs77C09mLZR7EzqkiLNYqj1qPBlB82b5513r39u01gox7v3iEbRZL0hs/
         eSEBmm7V9AL2238OAXIGPyl8vzazx8ZZMnMkfZ5Pp9EzPBVCx1LWC6hTFjwftzPQpfM2
         QJP8BPz6LZRr5gQW8DlNNdSiwygTQ4jERTL31NRg/VZEbIPXLEvx+4HAjrzguDoaOHVj
         CJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YXEGo4E4wlHkJodsVnLSrzwMnIEDYHUKz/ZNJgp1Yg=;
        b=VACxrr65ZPUF8RbwNm5KGypqZj9JqRIbnyp4zUEUhALgVrJSanO9DzHy+4v2dWuOaA
         2cgQolQE+cdwmSBfIRsw2awAeV+sOErJ+iYpPKgT+4rRPLOW9aOVcvmD3xI1B+xPU9fE
         Cixdhtibc3gmeXCiCEedUuL1VcUBIlmOPlQcH90rS2WiZgV4FAHv+guq1Sf4yO+EClYx
         zAeObatP1i18kd1vSRRwnM5yIrQ3xCQxkw7CMb7nsQZq++r4BCztSDgu4MLdJHiSNE40
         7o2LDIHz6sziDv07Jlbls45mT0o2kHZvFltf7r+UysZzLa1VHe/ScyGg0VTtwhrvBiNQ
         rr1Q==
X-Gm-Message-State: ANoB5pnzZOV0OkY7aJ9CbdHs7FPox4eV7xKHCiVNmWeK8GNUZjBTflAH
	JquW/8MyNIYmkivE4wO2N5R4PRgABTY=
X-Google-Smtp-Source: AA0mqf6JTp5H6enrNxG0xxOhYo/QbCXjESCoa8l5ZVtHXdn2e5PFsqTivFVAdAUK6EsUxBwQmLa7RA==
X-Received: by 2002:a05:6a21:9016:b0:ac:29b6:a235 with SMTP id tq22-20020a056a21901600b000ac29b6a235mr37696355pzb.54.1671314269480;
        Sat, 17 Dec 2022 13:57:49 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b0017d97d13b18sm4009278pla.65.2022.12.17.13.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 13:57:49 -0800 (PST)
Message-ID: <dd34d5cc-e59c-affd-6172-89e4e2dedef8@gmail.com>
Date: Sun, 18 Dec 2022 06:57:45 +0900
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
X-CRM114-CacheID: sfid-20221217_135750_648766_F1A1114F 
X-CRM114-Status: UNSURE (   4.88  )
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


An additional note if I may:

Memory tests run overnight using memtest86plus-6.00 found no issues.
Please let me know if there is anything else you need from me.

With Thanks,

J. Hart

