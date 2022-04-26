Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DB0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPUzsVpQReDWK1+ZM1EtiHimITChzlKcI/0hyy3fCmQ=; b=saJLoB8+kblfgHQRMiD2p6UjUH
	dvaU8dZ+WCwrbxJVqmcSkhYxBzTGjHe2EBOVuDKNy567dvcyL/SZJ5XUZ822HwaV+LXoEUQPm9Q+0
	c9NDcFZGTTJKMi2dImRRYoBNqoII9sllmE4M0tQZ3I8gOXMixIfitX7QEw89mLinz3iZVzoYIUE/6
	lvVG8TrUHYB1wJYzt4O+Hn1uUN7PqQby3bEbKQc11/W/hdqyGLcmFQHObe7EDG2dg1h4r45So/Vkf
	Px+bDiO4W7c/UfRsg8dAOvZwNxlqZR37RUrEZEo876x4wV4kUzFOgpwfa4NbNMqs2EOHsSfyLHvsV
	MR8exrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njMBo-00F0Fs-8w; Tue, 26 Apr 2022 14:29:16 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njMBl-00F0DT-Iy
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 14:29:14 +0000
Received: by mail-wr1-f43.google.com with SMTP id v12so18922208wrv.10
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 07:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dPUzsVpQReDWK1+ZM1EtiHimITChzlKcI/0hyy3fCmQ=;
 b=4d6eDTBzwlnB2492+MdLRDXs41H9+s6Sm1h4YIvsTB4d2TdFrb9bang3tlJiwl3Hn+
 mX3A9N7rLsznkVc1ZW1xinJf2KrliRkXt1reNNuW3WtYooqzMv/b7PFbsTT81vQK4p6r
 cVFe0QPluZRCE8Kr+nomnN8YHOPOOXQv5ExwuXr7gzFSwPaZNNWvCWxWeZhMDLILoBMu
 wpmGDxXc/eUkyEIN1bGKA1PC+IoANwJxZq0+ZYYV8nxVlNHPVzXw3miWRc5KWvXrnhK9
 OrCMYkXcDtA3AZvpdyxjcWgxTz7fnURX0yvJJ52wnN57DhEcj+L9pzZK04CXJ7zdyoH3
 v27g==
X-Gm-Message-State: AOAM533sxoP3ajq5/KA0+nhwnIsvuWydLypxz1BJ+pbWDkeDr7Zbpzm1
 FHlmetiSrD1q3YNDv85/du9uhL9t1rw=
X-Google-Smtp-Source: ABdhPJzLjm32+x3PjFCtSgMX6CN/Awx9lzUWh+rzYyIYYtIJXXx/shQgSzAsNJny+Z1OwEIo5XILtA==
X-Received: by 2002:adf:8b90:0:b0:207:87ef:2720 with SMTP id
 o16-20020adf8b90000000b0020787ef2720mr18310239wra.567.1650983346024; 
 Tue, 26 Apr 2022 07:29:06 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c190800b00393e80a7970sm7318361wmq.7.2022.04.26.07.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 07:29:05 -0700 (PDT)
Message-ID: <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
Date: Tue, 26 Apr 2022 17:29:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS handshake
 listener)
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_072913_648787_6C59BFB3 
X-CRM114-Status: GOOD (  10.89  )
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


>>> Currently the prototype does not handle multiple listeners that
>>> overlap -- multiple listeners in the same net namespace that have
>>> overlapping bind addresses.
>>
>> Create the socket in user space, do all the handshakes you need there
>> and then pass it to the kernel.  This is how NBD + TLS works.  Scales
>> better and requires much less kernel code.
>>
> But we can't, as the existing mechanisms (at least for NVMe) creates the 
> socket in-kernel.
> Having to create the socket in userspace would require a completely new 
> interface for nvme and will not be backwards compatible.

And we will still need the upcall anyways when we reconnect 
(re-establish the socket)

