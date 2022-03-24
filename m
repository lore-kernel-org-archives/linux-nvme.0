Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LK6yweKT+aWYg7G9kCs4xIeMGR
	4nQVIS1bik60eTiUo0gCLq7uxSnnZr5BlCfdrOv87stMC9xP5QkXHyiamvTrDzjINm40NT+mAieT1
	/ODC9RBK6eQFb2wrS9SYFWRjyJ1JRQngK9orC9R1F6cCh7uDQeQNtxGA4rDQA+Af3CLOSDJ/aqum2
	LDgCWUourlb6911p2roVmFiPBVIUAn73beZQOOR3zTlUAehg86fjTp/Vz+vyz+G+rIciswekWYCxA
	MwT+zmHx88rjiN5dxM9dw0b9Qtqv1er+6AD/qzq0GOi7KUHF9ban47Gd774+jjBturRIetbVG4CI6
	ka9yw6VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXUfV-000ENk-8p; Thu, 24 Mar 2022 21:06:53 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXUfS-000ELn-Jk
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 21:06:51 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 p12-20020a05600c430c00b0038cbdf52227so3316070wme.2
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 14:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=5zDI9Nij3OlaJbAo4uwDu03pX0KWWDzu/a3+lDI/NG9tBL/CxKaDxju131qrgfKY9h
 ukBpxhIqU27BUip7RrV9WZLkkRxoRym09ZyVaHk6RNv7xmjL7eNTQMkNxxab7xg2VVPo
 RvXE5uRy0Pn1TT8tzbGYfL28Gzn8M4KAb/vLW4n1Bjg29Nl1nMLc7vfPJ6wLqJjaLESg
 g163aJbykbXycaqlATuupi4l8mHUwUW2YgWJAIpc4sq9bh3rdyShE/zY/tRoFGdeHZCM
 2pQhePE3A0b36cBKTZI0YT/sf7ZR24dMUukW1mDYAm8DBepvh+C0kNO4Mx/lY1F2FvRy
 PIuQ==
X-Gm-Message-State: AOAM533Q/mEFnMvdbOn3zZo0uMqg6GM4woZTuJaqN/qAah9+vTuFrQaZ
 oamVSp2LsJi2hmJw8Apzu9OkVQLTl+g=
X-Google-Smtp-Source: ABdhPJz/YcMp07xiEDU9QCkPPsGL7dKzvTtVP8PYSn4gnxEG/KtOYhGKuaoPX6NaPsL7m+MGt8US8w==
X-Received: by 2002:a05:600c:4a22:b0:38c:b316:e6fd with SMTP id
 c34-20020a05600c4a2200b0038cb316e6fdmr6670283wmp.93.1648156007034; 
 Thu, 24 Mar 2022 14:06:47 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0038ca3500494sm12519356wmq.27.2022.03.24.14.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 14:06:46 -0700 (PDT)
Message-ID: <061aadd7-5c8c-7bf2-7819-e608778f002d@grimberg.me>
Date: Thu, 24 Mar 2022 23:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/1] nvme/mpath: fix hang when disk goes live over
 reconnect
Content-Language: en-US
To: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
References: <20220323152212.GA325@lst.de>
 <20220324190511.1659517-1-anton@lightbitslabs.com>
 <20220324190511.1659517-2-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220324190511.1659517-2-anton@lightbitslabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_140650_659544_C109913D 
X-CRM114-Status: UNSURE (   6.36  )
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

