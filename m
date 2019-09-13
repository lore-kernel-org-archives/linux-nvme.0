Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D8AC4CEC9
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 18:43:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEAE20830
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kSCQRUGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEAE20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=515dmI2C0lEEJgGZsOCZM0x67VrxhGvxFjv3juHTc/A=; b=kSCQRUGSNc/NAc5afJoWhiXru
	f2F/rZLxZ4XDDi/h7AVLZdA6lERoSNrsE8IFJTi7gz1WSw56WR6es7o4Ms1gszPTYZvX/1Qmph74I
	DNSiwYZDmiFcNysXuDNHG0TAaY+xLKyBL6JbAXkXazLyaNjZnmtg00PUXBU3JKZVcm6/gGk2QKIRY
	iz0D1+FA/sYZfDG/HjjxZpUkoKzPqEKhr+CM9htWW47aUbGjj3v36Bes+LIle7hkBlK32tJACwlS0
	6dq3RkyomHaaAYBR9P0eCi0UUbuA+Tnax387Ba4ZuseuuDMm/t/ZhxtEowrgM0JyhF17VuMbsJ5tM
	a1meRKn8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8qXr-00066K-W4; Fri, 13 Sep 2019 18:43:47 +0000
Received: from mail-ot1-f53.google.com ([209.85.210.53])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8qXo-00065z-R2
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 18:43:46 +0000
Received: by mail-ot1-f53.google.com with SMTP id g19so30329821otg.13
 for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2019 11:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JGd1HLQgFaiXOYTJCgwLv64BTva6RJZMhqMe4TdBaxo=;
 b=GZS5oUNzoIGf9g2BsP37+md9GguIHvJXCqvmJF6QzLmp02VjfAe3zr0wqlB2iq/2PO
 jYXY8tXnqCexvGqUeFZH0PRq923lAoHry7cw8pLLMdCbPkUMmctyVxzPcCnLiGwIec5E
 PRi2EMR8l9Fu/pvZCZPCK8T7VsITsrS1XFgVcqmivZe9hKf3BZBz6rQd1MEeU7JHbkGk
 7t63qyPcrFHaHG9fqW0xbFSKG5I3mVUxdsnyNx7YObWaB1NruDLbrNdsDLgoLka/gcwI
 XkPx3+CoD9nArOVO5lQ4mEExrs5hckAO8eBQsuxb4fjky6i/+T9y2slJiWnTGjip7kDv
 5aSA==
X-Gm-Message-State: APjAAAWYLdX37on7VP5hIrgdX5qlF45XZxU/bRmB3cWBh8ihlHdZx7e4
 Upo8rNCygO705WfWwjH7876Qt2Bw
X-Google-Smtp-Source: APXvYqxX9vV7VLxwwqap3dAHt6RXqIufNGnOOYOP3bPDxhOF8rwaKUii75zrSbGpTKhrRxwHtoXLZQ==
X-Received: by 2002:a05:6830:1446:: with SMTP id
 w6mr23895483otp.183.1568400222951; 
 Fri, 13 Sep 2019 11:43:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id g4sm9986677otj.42.2019.09.13.11.43.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Sep 2019 11:43:42 -0700 (PDT)
Subject: Re: incorrect sysfs reported by realpath for nvme disk when
 nvme-core:multipath enabled
To: Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>
References: <1753358694.11967186.1568394608486.JavaMail.zimbra@redhat.com>
 <1137688987.11971676.1568396450210.JavaMail.zimbra@redhat.com>
 <20190913175637.GC17139@keith-busch>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a24713ad-e907-2cfd-b1da-cef552c29b14@grimberg.me>
Date: Fri, 13 Sep 2019 11:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913175637.GC17139@keith-busch>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_114344_876835_575D2F88 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> # realpath  /sys/dev/block/259:0
>> /sys/devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/nvme/nvme1/nvme0n1   --------> should it be /sys/devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/nvme/nvme0/nvme0n1 ?
> 
> The sysfs links are correct. The controller-namespacenaming is just not
> related, which is what you're observing.
> 
> This was confusing to enough people that we've since changed the naming
> to something people expect to see, but that's staged in 5.4. Given the
> number of people who find this confusing, this might be worth making a
> stable patch.

I agree here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
