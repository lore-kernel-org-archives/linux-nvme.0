Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC69C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=PebMmrV+NSPRmelfAPvmEyxiAJ
	my33DRtyi0dWtBAJTuu80gny0txKDNkDIKS916hEmlrqvldUtWJugWwJY2MMVNKCb4pnjUSjV+TX5
	n1KiMldJ0g98qtoRORJ8ync5iLh3vUzcfyIcQLhKoa06swx7qhp7P0mnAqJ7n7pNJbnrfs2NUXgDH
	FUk+0j5Umvwtjbct/kRNgJKRgKz/n6QDSvpsitedukHbIjZ/a3GqcWbWHTgFX9aun6XMofQjSbUIk
	1cfbvOMn77D2FU6/FiRERvtZ3fUWMqVK6ZcHIASvy9tagfdTEgNHlehNIiNn9WyiBH2QttKsc2dt4
	cItdSNXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qrl-00000000xkM-1tu5;
	Fri, 25 Apr 2025 21:45:49 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qrj-00000000xjz-1HH2
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 21:45:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso3069796f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 14:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617546; x=1746222346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AmzBZMZj3sNrY5b/gW8b51zNqDQ4mZKLk4qZqpOyVBrdpKx/RNkTr2i7OOB7tCOrM6
         ex2ZeTrG1OuldfwACtZK79N5g3ab7Jtmk6C1GYDX4NupOy+yp71IGZoKMDmq/6J5RJMP
         ROIxMJOtxEiIlyEItQ1cQhp6qppIA4EwqpdWPD2e0loXWgHS+9HX95o/erJrSgVWdwsZ
         dWZgCXM1PPrNUIjBcSbeo/0bWZew25Mg8/ReNFDBVF0KY1XUjh/CweyLRJ99Yp1qNJVd
         MXaPiLNYJbBzPqpPKLup0wCyfUAxn+kn3wz7HUzopvdSuzjWfN2FgBTmyfz9PWOESIVE
         rpfA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Qd1vjabsJtNH5+GMeb/xMHEIAXSau6YG1B8hHn+UhHGjnsZOSmbA06biWF8onmvGqElhRMVsiuCa@lists.infradead.org
X-Gm-Message-State: AOJu0YyCqrA2OJVOXN15igItqNYwMkX/vVDgK77DlJyAvUHsIIMJz014
	Y3gnIyXjFFHx5RSf0zAvJv63TawQ233txMyGsKrqCMYcYf5Wye8+
X-Gm-Gg: ASbGncvDdsSjRyf1BdYAGVP0N8X+HzsQKnEkfu+RATljXtDkwS+6wBMAdUVFp1JeLQe
	ZgTD5oeqlzWBbO9ewXyP+egqtIbhiYiSwu009EC871L4xhvOSaPMT4rDobOiXT/uQI3NrJgBXBY
	tsqdq9dMMHYedz8+1FyC/9Z6b5mHUq69YiXihP1KIWNCb1NdT+Hp3BWvBEOrE3faLIc/CjNqVnY
	aTJTWwmY1ttuBQm3bJ/zV/Z4bygWJdJm7k+lyyrH8xcGe8j4tPm4C1hSKi1RCjyj+wOo/OpsZS6
	b766Yik04KJ5ntqFi8djSkugMnkYB3NwdPAa8zRt
X-Google-Smtp-Source: AGHT+IGBhVKO2leeb63SEUU99mM9KQPgKhe2jS7I+g2ZOiuieSxkeGvFGBWEaQP3Le9ZBFh+VOfx+A==
X-Received: by 2002:a05:6000:1848:b0:39c:30c9:815 with SMTP id ffacd0b85a97d-3a074e1e7b5mr3268189f8f.21.1745617545669;
        Fri, 25 Apr 2025 14:45:45 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbf04dsm3518606f8f.52.2025.04.25.14.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:45:45 -0700 (PDT)
Message-ID: <0e3158b2-8701-44f8-a9b2-0d8959a0e0bb@grimberg.me>
Date: Sat, 26 Apr 2025 00:45:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: always free derived key data
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, Maurizio Lombardi <mlombard@bsdbackstore.eu>
References: <20250425093434.36383-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425093434.36383-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_144547_335344_7CBFC559 
X-CRM114-Status: UNSURE (   4.72  )
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

