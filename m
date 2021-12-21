Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF65C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1dfjq0SX/UxPf43CoTsQA3b+4Z
	XORjvOmWQ8mOM0J11Onl+LXKYzxo7O05dRCqrQsaWjC7PtmV8yeFqTnadrkR/p85ES2TD5bgyEeeJ
	zrVL3+s7SGkTzLX+4N271teRg0TY7mnkdWU1+loiLOl2zku5cHtVT8fK+jXiMA2xG7Gyz6gs9j4ml
	WzXk2ja4GGHAEQFJZ/ort3VROAhDKemLGM/fTdbie5Nup+OAQ/buzIfRKdD/51/GXIioYGAYFOXO/
	At6NAUqjNKBJxxoQNf7wRU0aX6NkQe7shbwhOl52UCxeYyplritNFMsN4WzQoyPKHfPONMahjJyxb
	PmIZLZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzcKg-006PIx-5P; Tue, 21 Dec 2021 10:25:22 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzcKd-006PI6-Oj
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 10:25:20 +0000
Received: by mail-wr1-f44.google.com with SMTP id t18so25825531wrg.11
 for <linux-nvme@lists.infradead.org>; Tue, 21 Dec 2021 02:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=cZaTzc326Lnz0kAAterO2ba5MfemwLRZRixxvf9rW9biR37nBvhTDtWlwwk8gmHALW
 B2oVqwwAO6YxsiSxiSS3bgGNgp19N1d1rJzdmJZ+WD7P38F5MOmQnx4bP3gedGUzxXEC
 xX5S5ANPLbBT3GZVo41IyzG4QvpPOK4RGJnqCCLiZN0OLx7GM7LZQpI8bw7IeDwyAAy/
 xe4/UZdybxjg6oEGsIFlzhmt8ECU/dNp9qU80/I7lWXQPsBR8e0r2J0QE2GDAa1A5ZTI
 31f3P69B00W6CY94kakSyhTRsLWk6q5k9+OnPGC7nU+hRNIe/OIgpAXxJjaXcuaVMOe7
 L2LA==
X-Gm-Message-State: AOAM532ZnPUfQgbR6l8pdyPA4NoQ3A3f9sLykw+MJmRK7EI7mSAp9yj1
 sq7daygqC0EwcXOZEIzdiBY9WPzYl0I=
X-Google-Smtp-Source: ABdhPJwg8/gRgx+gta26vlwqE19msTdI34raKU4bcMF6cmk69YqQPF4MFf/RFPIgevzYKFeR/9sQ3w==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr2026876wrb.575.1640082317658;
 Tue, 21 Dec 2021 02:25:17 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d10sm1666826wri.57.2021.12.21.02.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Dec 2021 02:25:17 -0800 (PST)
Subject: Re: [PATCHv4] nvme: add 'iopolicy' module parameter
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20211220125145.38146-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4866e154-8783-083b-02e3-a1d1094cacb8@grimberg.me>
Date: Tue, 21 Dec 2021 12:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220125145.38146-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_022519_853182_CBD78D0C 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

