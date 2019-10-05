Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA3C4360C
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 00:03:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F9720830
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 00:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cDW641i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F9720830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2+1IwXINKF0e5JqNlwnLKBWEvKuGBdghys1hd4YaDsM=; b=cDW641i4/OEwIDdamJTriqSeR
	btuTZZBY2bKe/P7rEeboE6NftdEdGiSsfoSuBc0oXeb3mKHlcWW17iCLZH1WsBLITijCdUApUQgxd
	UGRcY9/fW2t+PdErR1AUXQE2RzYxZ+wlXXLS4tPxF7CHeqWITUf5X4m0g6s4lRSODMdVpjdRmwu+E
	zbHdc8gC9rO3XiBcpxaULqEtSV3siDOH7lHiyeNkVsg4Gy4AegE/buiZh/0UKO1wLj5y7z9E2RBeq
	B4xNtvARKczNUzDsIU+259k+YH+IhNNO0jA3ziYh1OnnkhasPMhsbhRProD0DTBEStLLzak8PAkQO
	cqQCHc1iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGXY1-0003wS-9Y; Sat, 05 Oct 2019 00:03:45 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGXXx-0003wB-AY
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 00:03:43 +0000
Received: by mail-wm1-f67.google.com with SMTP id f22so7373527wmc.2
 for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2019 17:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n/qNzDvsoyHjdZs50Nlwp+Ui/DB68tJM/9AmfW+9TRw=;
 b=Ectz6vX4qm6KwGD6P3ffN3b9vWxkyxEOe/ZhEgW/YwmFHtxYQOMXQ/fF51IPS8r+nj
 07Sz006d9SsrOM6buUQYKYjZR1kZHh4lQfyIYUT8NrWbux759b8vtKsBTAxnjp8/bznm
 to3/yFZyvhAtbRsk2fW/lNKimRMlHkfVD1DqMpUMz59U7Zbz8uvzfgZYaaQTd1j8I5Ds
 KrnPmJwfiU93Tx8fibagEj9xDrdaj5oTK3BnfaGIem3z2ImvAZKQOj6uPYJZu8MmIlN9
 3tHOdb7azyTBOeymJ952hq/qTQ9oXZTCQm00Ruc1nPa6OLUsRo7cwyEyd9rpwFhMzcMm
 MpCg==
X-Gm-Message-State: APjAAAX9qwrv5iBKu+nOC46VyOizgeQQ70K6RZi6nfuHjtEeXiJY2sHd
 dVHeWBeKjSOXDgBYk1yOd/nzYNts
X-Google-Smtp-Source: APXvYqzw9r5Q+OJnnNuL0ILR4N5NhXvtUEzH43HGsdcIBaUi2KUGS4sjZQN4b+DX1V30RGTt+EMyeA==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr12934074wme.96.1570233819584; 
 Fri, 04 Oct 2019 17:03:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id j1sm16736951wrg.24.2019.10.04.17.03.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 17:03:38 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet: add revalidate ns sysfs attribute to handle
 device resize
To: m.malygin@yadro.com, linux-nvme@lists.infradead.org
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <20190930150202.9259-1-m.malygin@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11e37d39-c85e-f844-953f-f540596b4410@grimberg.me>
Date: Fri, 4 Oct 2019 17:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930150202.9259-1-m.malygin@yadro.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_170341_360707_6440F949 
X-CRM114-Status: UNSURE (   8.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks fine to me,

Christoph, you happy with this version?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
