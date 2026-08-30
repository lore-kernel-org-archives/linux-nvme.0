Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15EAC61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gU9OIDFoa/+cHgPTlNl7AnUZZ3
	T9Cv2Bmo5bBLb27pvkzvcMddoVoznYTGa17DAEJtEEWDPs43F0yVxJ9CrLSPmeb3KLE/7WeRPzAjh
	a9nyBWzLFSNnscEsZKyCR1pDPUr5jlGhlPNzlnEC1ThbQMr8d7MzadIY/QE0t2ST++dJUMk8bZjZf
	q6YND1uknzs/OuKOFJF4re+pvIdrL/ZQ4pcHNfoFEvLHTeCoaIJ/bPQQEvQyOw1A+U4K+FJA2Cd5n
	4/wJ7zHs7fap+Bhyj20vFyoPLUwR2Vz30LSIez9dTnpKf9SDmt1KIAS/eayA96K3juKTvqf901Cf9
	Kga4SVHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0msm-000000086b9-1LzL;
	Sun, 30 Aug 2026 21:16:04 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0msj-000000086aZ-3meS
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:16:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so32800235e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124560; x=1788729360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kglW2F7kwAKJbrzmrW0gX11rdMyk5mv1XjB3KHIuPyPl0VaNqAwDc4tbfeJg6HrYRV
         FYBspJB9+F53YgdotdyjGsxkQiFTREF46VjQIabZ6rNQAuD1J6CroAaJ7H2F3XOP23nI
         xqiB98vakfjrNjVp4hi1r3nnmDvRBYqSLFIL7N17tzbm99GdY4HP5IdsGPALnpmj0XXf
         ZaiOLEMOODWXkwfjlheFhQQ4+j9hn2ph53TdLhOtkn4kE9/CagJxtqISS3qQc+x9DSbK
         t0gLIrEY+gMFS8nUSaZzswT3dfCJ4o96A/apG7jS2kjnk1mObJmOsB3eKjn8vuzzTwVe
         kxDg==
X-Forwarded-Encrypted: i=1; AHgh+RrjOn/t3eVgC4Ai87CQC8a5Oi9icwn4Ce/QzRR4H75BR9DuhU3Wj8dX/vCwMskRlKGz3pyz+zY+t9Bi@lists.infradead.org
X-Gm-Message-State: AFuF++m3JIehYlAQtbE16R/Wa1HSohEqkgUl46IEyGDcXK2Px4+RUhwl
	NTDb8MpAxlu2iIFnLoLxlKbJymrCq04EMVuGyKMZfpt6DIDHYmbcwaOZ
X-Gm-Gg: AR+sD12gOZW/fMwRs9SawZ8daceUlneBLhEfCl3/jaoCzabBN1uvvNyejojzoTs1Pn6
	3LGnSZQC165w976vm/W8wm2+gD9AInXNL3tC1c6xalJElOBQPC58BdlkPwQ2WqiCe/ytAaBEk2n
	aorfe9sv0xfCJGq0umhM2tUJjbL/p8j0v4BdwG4eKS5UZYJUZKjXy83ADgeVYGwRz+rRaLSmyzp
	Ay7ba+uFajyYqZo3aNVe0F7fXKoSwI0poAyjhDV+0tKU+GaqkcTGIxS8JrwkoNuE2Q1Hm2Lq0HI
	eKn1wLT9meH3h58fJV9/vM7oIyAn6u0hvONKuMJFA+IbU9Ze1xW91mwgmatfZ/Ea15Olt3eWayU
	RSn3p4GLRN9kF6KTxUKoGiXMS9iO8zr3f4ipeT2b6vz1t4aS33DkDIqaWk8addv8ZVSKzeRKreU
	qTRBWxoSbQY72XgbIFry+TDHQJVaVn4pILD9sbBkxCFjkjX3iv8kitsmC6nny9fmjWjhRS6uJ99
	yCx585QI/RCc2zRlfSCVg==
X-Received: by 2002:a05:600c:1c13:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cd52ed3c0mr89516045e9.4.1788124559938;
        Sun, 30 Aug 2026 14:15:59 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f22sm19013222f8f.2.2026.08.30.14.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:15:59 -0700 (PDT)
Message-ID: <ce174d12-006e-4e36-b261-4b8f41d1918b@grimberg.me>
Date: Mon, 31 Aug 2026 00:15:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
To: Shivam Kumar <kumar.shivam43666@gmail.com>, Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <2026082755-stucco-champion-2bb9@gregkh>
 <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_141601_937882_366B997F 
X-CRM114-Status: UNSURE (   4.23  )
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

