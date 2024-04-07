Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A267CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fy5gdQMpx1k8YQ1q6iH8JDdStb5tBbHzfdextj/VRNs=; b=QWPZT5BbajYeQhP3VGjTR2IB19
	qcCi2rmsIP9Y/HhwbteOfJaOQ3+1Gdsd/Lk/KSlw2g2hbAZPNs293+2AHxzSTWL9Rp5b+QdIOtSma
	Iyn0MzE0/tB6fQZ0k0HgDdWwlCsabaXBRAhqYa5UPY/+P8SySbE9emCGTpAeu44L3Z/H6H6AqGImW
	H1dDax2xig5uVb7LfJrbeMbkNvAAr5MJa3HsJ3yeAFUQ2h+efFxiI9tO/9TH8c1ZCI9EO1toHep/E
	GURCSd53g355HHPyd3kRaK6AOge9EmPFUMt09cKm+raEHvkH4zjkrWHz2D5mMoZzIj93+mr4s3ycW
	RKqHB2yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaLq-0000000DZq3-330R;
	Sun, 07 Apr 2024 21:46:58 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaLn-0000000DZpY-1WGx
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:46:56 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d32aba7eso820082f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526413; x=1713131213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy5gdQMpx1k8YQ1q6iH8JDdStb5tBbHzfdextj/VRNs=;
        b=py7KWvn1k5zEMLJls1V/Mve5SMCOY5+zeJgaZPAVoEMAYvCyQVsot7XJINdjKCZfWD
         WQYfTAmSwZlBXFjlZC6v31CVEvYvHCl8pGOseMJgd7oVgAZVijjUz8HE80hL7xocM6eO
         pqgKSRaHpY508YJDbsu4Nth+YIuh9gqIbX+NrRoJpQPSbxCgMItTU1LCJrar9xTM12eJ
         aAJINhnRncRw2Y9bK86NfQOodTQzPQ9EPU7KM8XThh8wExAOe0Y9B67Zji8WHD/99eWP
         Eop7OotSv3e3zD90szjZxsRZ9isBS53N06FRJhZ3TLSbru1R816Fk6BhzU8EbsG6fi/H
         lH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcbJvyR0PPr3ZgNLF+3m2O82S/01nglEUBC7p5K5QziKzg28fLdGn/13A4KS8l1wP1yLec/I7KZnm5pbwDTptBp5QqOP643I7ClfzW+i4=
X-Gm-Message-State: AOJu0YzasBblqWtUXUxbRAz+cthU2h8XQMWbEZ590Of2yptuTTVrxszo
	7fFp/3yPqyU2pxN3pNfiATNy+Xu6xsGYgXNYAD++otYe8gvAsGxe
X-Google-Smtp-Source: AGHT+IEc2A/l5Ot4MJblKZbpL/dV0ajuUc/QVtOiPJFXQHae+EhFFlRjikIPjhA6VD/iN6U0/miGkA==
X-Received: by 2002:adf:f707:0:b0:33e:a016:faab with SMTP id r7-20020adff707000000b0033ea016faabmr4227476wrp.6.1712526412692;
        Sun, 07 Apr 2024 14:46:52 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b00343a3e62997sm7365426wrw.50.2024.04.07.14.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:46:52 -0700 (PDT)
Message-ID: <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
Date: Mon, 8 Apr 2024 00:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-13-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_144655_439323_DE7DA623 
X-CRM114-Status: GOOD (  13.66  )
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> When secure concatenation is requested the connection needs to be
> reset to enable TLS encryption on the new cnnection.
> That implies that the original connection used for the DH-CHAP
> negotiation really shouldn't be used, and we should reset as soon
> as the DH-CHAP negotiation has succeeded on the admin queue.
> The current implementation does not allow to easily skip
> connection attempts on the I/O queues, so we connect I/O
> queues, but disable namespace scanning on these queues.
> With that no I/O can be issued on these queues, so we
> can tear them down quickly without having to wait for
> quiescing etc.

We shouldn't have to connect io queues here. The scan prevention
is just a hack...

> Once that is done we can reset the controller directly
> after the ->create_ctrl() callback.

Why not set opts->nr_io_queues = 0 for secure concatenation and
setting it to the original value before resetting?

