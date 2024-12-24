Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252EEE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3qkZeqmeWCN894zV+jeug2RvodU96jLSIXW7b0Me2s=; b=3bwgNndgysd7fRB5tNIosryStQ
	Y/bE3H1KRKzAMwY9/l5imwqg/tiRVrh3omcQ61J8lhCil7YxNIAdmcSQ3RLNokDbOsG0v55c2k24t
	ygqqb67BD7YVjfvwMzORUx9phPPN554xfgeb0rj6iAcUI9rTFUlb6VMu1iiCzvCoeqMsWdTF0ebbp
	VxcCC9FZivtJ8/HgjOLDS6kXhwBUxGyYfzGNhWYsI3RGC9W4AhuUJ7cpSQgjCKbxb27WXwT3QHzT3
	jm2tEeB9bBQsU3ZsBJ9KwNDojcwsCqe0aZsPQW4P7Vl0+4VlAxHtmfIC0wSNdAPF/ev3P3ARphn3a
	5SXCjjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2KE-0000000BmK9-0KfW;
	Tue, 24 Dec 2024 10:39:42 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2KB-0000000BmJe-3pf7
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:39:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385de9f789cso3826789f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036778; x=1735641578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3qkZeqmeWCN894zV+jeug2RvodU96jLSIXW7b0Me2s=;
        b=KNyH04dmERKnHE36bLHY6Knc+o+ySrdmS9mYtTFAPNSbcyFNL1UKP+tim0AtZRpd/o
         u9LRiOCTjiv2Qo0aBhN1l4/lJ/Wfah4NEz48i9chaDKc4snXPMS3XUkjFnpgfql+7HgA
         oH3XzSSf8m1Wc+4Ye2oyrFak1L/lxANw8CLvbs94FXqwNAQa+cP42jXYxpqzc3WuBTi+
         a6s3p+4oS1v9a7aEPQJm+6IBTOsKgL1SajBCbibwIkD2DiJ5Mr7jFxKOoLLMUAhzpCzg
         zcYUiFx49VBWiVrxK9xJ4/nJ6WdGIURwf2FVolgF9qCh9TpNRk6dUSYL4KB2jomo0/Sb
         5CIA==
X-Gm-Message-State: AOJu0YzNzD51mMft5Ilzyps4uKwSZEsvQDMQXUyKHsZJTYFlTHwDdWi0
	vWv5Pgm0FBKbq4Yb4Gn8ANARBEXbjzswU67UCHn5T2/cyTS7uyze
X-Gm-Gg: ASbGncsREuby2R7t6f36YLL8BNwACnXk2hYjKNEQ+D/+AUSDPiIeXINh7w+H8WveTxO
	tIbC1dgL1KUEFUwiiHjQH/pyXHg/vDi8Nu5ZpglGE531lpZnfunEAyd//f4mFsCZruZ10uE9DOH
	MVY6jinKFGL1BHxJdHnIpTrg01ntpVkcWouffjrd83fUsXX8jigJKC/gD2QtZ9EqOo77S3tF97M
	Esd9g4NDaaQtbx6omIjaIDsK9lCgtU0sy+p3G/i7bgl3fPEgME8bU1XLuhxXSXnS5W4zpAU6gS3
	7EXNgkvK5RGVPLYBhScqr70=
X-Google-Smtp-Source: AGHT+IGccp8W/u/U53gxH+fbpoboe6DibfVKKBpbew3YlT5/qWPlmibvt62OWBbbuokeyCMM7MR40A==
X-Received: by 2002:a5d:6d0a:0:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a22408d23mr17593491f8f.53.1735036778237;
        Tue, 24 Dec 2024 02:39:38 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm14070670f8f.1.2024.12.24.02.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:39:37 -0800 (PST)
Message-ID: <43891840-c554-4412-8f4b-648ac78ba3be@grimberg.me>
Date: Tue, 24 Dec 2024 12:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_023939_960222_EECD19BB 
X-CRM114-Status: UNSURE (   5.41  )
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

Makes sense to me,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


