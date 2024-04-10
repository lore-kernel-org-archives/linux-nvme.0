Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9443FCD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 10:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N8U80+37Ey0cYnbu7WdMhmM1N+pNOXuEuXzMIMzques=; b=CCPQg4kkzXAtFTAZHZuX14Bxa9
	38iiv7zi/cajmcT7cQfs7aXwi+v1N+KDfP7gwm1KfGDdOULkc+YBMtihzNQiMk0hcb5lxrOCoNwYJ
	5rbyUFBhEbTYT6iXrXNc/P43taoGxpJ5PEgREOKKN2guKwWJx84fZnFImT+t9kxhc4CapoHS9JJux
	4zcltdY/sJGs0IHdb+v65mPVSZbz7Z4o9c94KP21v5Lwbg+NELxVwg2OIUHdCt1VPzuoW1Ckm1bhe
	PhhV33MKdgjTDq3TcoC+EYM7Qs2UVLJuEHk4Grx6yHZcLYVLi5xvhH66gvO2EEmhN48eL4ipqMf5Z
	AfNCNsag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruV5b-00000006MUD-08TK;
	Wed, 10 Apr 2024 10:21:59 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruV5Y-00000006MTa-0zi9
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 10:21:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4165a253b39so4746765e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Apr 2024 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744513; x=1713349313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8U80+37Ey0cYnbu7WdMhmM1N+pNOXuEuXzMIMzques=;
        b=LwNGVEaB54tud5bFU8HN40B7ysPlxk44Opu7QA8wd3jsmlFg2OuXIcNBSGsR+sD4Kq
         Eex376Xkkt2avENu1NM4k+AbDAKNBUqiKxFd288nKizwHR/S2l7ZR8+TRvwlcdpZAVbZ
         Ea0BugFnX6l5pQ0+tyR8pa8Q/ChIkWz6ofSYsFAx4DMuPXhPS3QqqGP+y8dNqWnSiW9N
         Bbhpru/F6xZ+u1oU6dmZbja1EjtaavKxMVz+f4hi55pTYcunqlaRa2gL7enrpBMAiWaL
         5p1ye/jJPF7NycvgJBuRBErw6NvD7Q9Z333/0XEOeXDfYiwdvq+N6YPt2mYw5FJZEJVs
         FfMg==
X-Forwarded-Encrypted: i=1; AJvYcCVglE6itufJqNcPWbxV6t3EJ/33UX9NVDpe/46ZxuNmVD6gpapXbh+kIx034qBvP0JBxsUKXxzPVxMOf4rciqsjno8SPTzupxGoO1hpw6w=
X-Gm-Message-State: AOJu0Yza2OPBgo2Gle/0ct/RSAiZcEy5HdHev4GOmNxjE/ctWKL0i0gq
	mofhWKkbzu0liFU7h4HMQv3YyZwf5dtf6hzGrHYgHKby1mBooMCc
X-Google-Smtp-Source: AGHT+IEWRd7BwEL1or8KxIbk0RSRElXoUZ3t8B7ISeWGwnKkBTGE1l4AYCRIIraSp3xnwqgK8rdbnQ==
X-Received: by 2002:a05:600c:3507:b0:416:ac21:9666 with SMTP id h7-20020a05600c350700b00416ac219666mr1712000wmq.4.1712744513213;
        Wed, 10 Apr 2024 03:21:53 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b00416cac63b11sm1770331wmq.3.2024.04.10.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:21:52 -0700 (PDT)
Message-ID: <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
Date: Wed, 10 Apr 2024 13:21:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_032156_311996_35C9D0DC 
X-CRM114-Status: GOOD (  14.60  )
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



On 10/04/2024 9:52, Daniel Wagner wrote:
> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>
>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Any authentication errors which are generated internally are always
>>> non-retryable, so use negative error codes to ensure they are not
>>> retried.
>> The patch title says that any authentication error is not retryable, and
>> the patch body says "authentication errors which are generated locally
>> are non-retryable" so which one is it?
> Forgot to update the commit message. What about:
>
>    All authentication errors are non-retryable, so use negative error
>    codes to ensure they are not retried.
>
> ?

I have a question, what happens if nvmet updated its credentials (by the 
admin) and in the period until
the host got his credentials updated, it happens to 
disconnect/reconnect. It will see an authentication
error, so it will not retry and remove the controller altogether?

Sounds like an issue to me.

