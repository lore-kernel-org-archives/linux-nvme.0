Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8059FC3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/IynrjMgMbi55MV2GhVD76WbBTEeRvWVxKv58rh/4Y=; b=Zpib/9gIBI109jR6NOjp9PCW2J
	JTveMyKRV3CMATYcRKJgl3kUlWy7hgQy/2PggDxyKDTgQe/18FidnyiAGrypQUqzjX9arDvlBI52E
	JKSah30mH1POkV4usw6RWQXiN1kyAa6nFfbBqqyBHZWUICJoX+YYjE9HhnAL6L8MkPOKidopPMjvn
	S1KiQdCppreH/scfcbiiePgaosDgbg+ZjIuFwiC7wp2nbr+n4ZYOSPdF4aRP1UdPAtraekQvWfC8Z
	UlpYN78OrPctsoFRuEDIQKfCci9qXiZPxUoBGTEJWcygmStquVopB32euQ+mR8but7O5jxOT1vxmj
	1YBO9tAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUS0-00000006h7H-3ObC;
	Sun, 21 Jul 2024 11:10:00 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVURy-00000006h6q-0Ihr
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:09:59 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426744ca29bso2990895e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560196; x=1722164996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/IynrjMgMbi55MV2GhVD76WbBTEeRvWVxKv58rh/4Y=;
        b=VOs/gquwx9BrUkuKMBc0CiQOiOQYnTWmks3wLwQ9Acpm2mAIq/jBR+tWgdrdyqYEct
         bff6AJRctGVh/rrt6+SwBlx7GI2ZOXp2rMpHN5N6sHcOfn9sE/GL+gnAenyv8JzPLaoq
         uH1AOZ1fGjgj3P77ck3NzYoFyats5EZ5vLDy4HDfs/AHyEsZizU2x6cokoiNZgT9a4Q0
         qI4bKohzF39A0coUfZckoRRvnP8IlihDL1Qzh4EdtmhaU+QmIsrsEESdPPG/e5D2/oZK
         aWuoZQJ2SDDlazk1CsHeUp/iZZ4su1K8Jkhx9bRKbwpb51X+4SjZAM2Pq66+TveVVJdv
         uJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKCjzY0wh21jyOf1NdXpEDtKTK0ldAmWmyKb968/sbw8gWTZbc9r5pLDsP9LuzoHoDcZ5EeRg6+0lYzSrXAeStgJI0ge5mdBNHNvpYhHc=
X-Gm-Message-State: AOJu0Yw7T8FRDs4YF4rGyzAVjZYhEG2pjI91U+lrUts+NUr2Pvw8R0br
	JaemGCZydYSXonRM5IgipOaEgS6XdqesLim9QvAN8Epdfrq9E5Lu
X-Google-Smtp-Source: AGHT+IHxpSxN1f7MBxHKgrWT29UskOLAEGxo9QMIj/ZdXghG6KUFDzGdqt3HnwElwAg5so5XJ9AjuA==
X-Received: by 2002:a05:6000:188a:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-369b69d09b4mr1407015f8f.10.1721560195538;
        Sun, 21 Jul 2024 04:09:55 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684773sm5741262f8f.7.2024.07.21.04.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:09:55 -0700 (PDT)
Message-ID: <8aa4d7e4-4685-4fb2-b6a6-c88bcc7a7740@grimberg.me>
Date: Sun, 21 Jul 2024 14:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
To: Christoph Hellwig <hch@lst.de>, Ping Gan <jacky_gam_2001@163.com>
Cc: hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719053116.GA21474@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_040958_143658_6B327304 
X-CRM114-Status: GOOD (  12.81  )
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




On 19/07/2024 8:31, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will enable unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
> So why aren't we using unbound workqueues by default?  Who makea the
> policy decision and how does anyone know which one to chose?
>

The use-case presented is a case where the cpu resources are shared
between nvmet and other workloads running on the system. The ask is to
prevent nvmet to run io threads from specific cpu cores, and vice-versa, to
minimize interference.

The decision is made by the administrator that decides which resources are
dedicated to nvmet vs. other workloads (which are containers in this case).

Changing to unbound workqueues universally needs to prove that it is better
in the general case, outside of this specific use-case. Meaning that 
latency is
not affected by having unbound kthreads accessing the nvme device, the 
rdma qp
and/or the tcp socket.

