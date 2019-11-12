Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F8C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:54:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EA0214E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wsep7i4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EA0214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5i5PygKaJ7lV33QZ2Jik+zNWIJmL1oCjwPu+CVX5188=; b=Wsep7i4J8zR+x1xFoOIckN3gc
	UcaTZSgPmVVB0QT3NdGEMZS7h9bupGjPZgXp3CTA1hwF6m1vQJcGhGhRRCtSpaKq/o5Ilxs7vUU25
	BqJSihdwycrmqvzGTjwdFpxB9lyCWPb7OLKypcrmwrZ3GkcvNMcZDpKFLvz9mPdzv+ZvXfbofYDuK
	tqRmqSz8VdIa1BmO025LSMVMUBk9+J4XXDLrCNhNNRgR7KxRajaDz/3BlSFAucjhN+DEfehDzDpdd
	F59KBbG6sBY52YHNo8A3hHdgwjbWjFuTKCF6VVrs8L/foxjsHw4NJykKFh8oP2f2VElH0zg8Wg8BU
	419RtqcgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUaMg-0007ya-0N; Tue, 12 Nov 2019 17:54:06 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUaMc-0007xi-Pv
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 17:54:04 +0000
Received: by mail-ot1-f66.google.com with SMTP id z25so1784738oti.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 09:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EctEHqXG8lyarRNQ0KPJIlm/Z+WDVBw7+k7ZqtwcU5U=;
 b=QK+NbVF/hr3tihu2zr+HDnIrVEcuEQ4osC9tHklHYZ5lp1jry42yB5drSEMpahnyMT
 g9d17g28Oi84oFqYnCSbcbEr0ActYa5iMUwx4gxcqqx2fQ+9atj3vqaZisP+HyZ+T1fN
 UeYrCw6efhZgcL9ClPNXpaYWIe/FCRzk2PMOyM8opNxto8DTfVMlt8R147sLQ8vcq/VF
 OvMMijKBXN2tQeT4kwcnsBVCzFs7U0CTFbwclwINUqZ/LuUQ/AVXDJsPzP0JqshsHKKX
 SExYhdA7NZac/7MmeLRAIXjzlbn6xRf+4s9e/cUy7ynhUK+9VBrXsfie7bQ3qX8uh24U
 eO9w==
X-Gm-Message-State: APjAAAXRLhwGsc0rI2/wqwLVjfyAQY0YI8LJmWF5sYBxdfykFTvoaafK
 OadNu4pe1OtnFqtp3M2mFHw=
X-Google-Smtp-Source: APXvYqyZWyF4bEFoRczJN3DlFeGhFsJDvC6G+zAXU+UjFYz5Yjz9QqpzNa7Hl9eYqERJnurY6iqgYg==
X-Received: by 2002:a05:6830:155a:: with SMTP id
 l26mr21970749otp.119.1573581241763; 
 Tue, 12 Nov 2019 09:54:01 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id n204sm4032298oig.15.2019.11.12.09.54.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:54:01 -0800 (PST)
Subject: Re: [PATCH 03/15] nvme: Introduce max_integrity_segments ctrl
 attribute
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-5-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f211d471-5318-ef37-721d-647da2481c3b@grimberg.me>
Date: Tue, 12 Nov 2019 09:53:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105162026.183901-5-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_095402_841649_CD51C923 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: israelr@mellanox.com, oren@mellanox.com, idanb@mellanox.com,
 vladimirk@mellanox.com, shlomin@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Other than the comment given,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
