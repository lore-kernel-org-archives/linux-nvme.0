Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E44C4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCqMAjDPwAw8wLgZuWj+/zT6p1pW2ew/S9d036ov4YQ=; b=hYEpctt6Lgj6etuMXdvmtwey2N
	MYB4fQvBIH7U7Hpp3YdrUqDQjB/T3U9kQLKu4gWUr9KP+li6hkzoDUqilIu0S5vT86wTKGp2D3mNu
	++jwJ+xCvbmSYqbEQ4FOfVMgHjhog0StW9HN6mgflh1kLK9RIcOAC0LHYy7unexBvgTtsUj8DNoqR
	QbRJ+N+5nsBHKAjp5y6dkGFg9cl2wcvV3274KR2+qxc1g2VuvZBWE3GlwsSNTDUhv38xQFjLrsmUh
	05M6yFutdek9abpe9zhPbbBc8emd8FxTff64HJQgTbDVYqJnDAk58YHH7aJBqmNPbDs1sIXeAwMZV
	6F65SR6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3dmA-00000004cBT-1dzk;
	Sun, 05 May 2024 15:27:42 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3dm5-00000004cAd-2JHz
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 15:27:38 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ecd9a81966so21400265ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714922853; x=1715527653; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCqMAjDPwAw8wLgZuWj+/zT6p1pW2ew/S9d036ov4YQ=;
        b=k3489oB7EOfq6ow2RQfa1smp343WlNDDoJz5XVOYhavFsZJ3icUI6zYKBh60jc5IPD
         tS/eQHYUKoP49Ry0UwKoboOLlNxyDz1EzY2hPG2bEP5SyIlZH/ubjHiYS+p+/BPZJakB
         MSn7s/xQrPT9tKElVlzDSvfB3qs6LmpTV/eag+ylCxwqL4c72T0TOWj0qFvVzHTiGyhm
         YIkehGmt4EpMGeedVxy7ulE5PMjVBn8kr8i9G8bQu2dxyKuGXX8xS3QBCpxDYuK8mwf7
         xpP5Aeqms3NKSyA7apHBl3mksMuFbx1csCMSrRkTQ/iawx5Um78VL4kx7rtpUqFatiBQ
         2Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714922853; x=1715527653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCqMAjDPwAw8wLgZuWj+/zT6p1pW2ew/S9d036ov4YQ=;
        b=qMGKlC2wEDE9HPuMBWsd2EXwYflLZjK2p1mhAgX0D3ipAki5KkXDwKbxvs+o7eAzQP
         z9wTO4+ikX3W7L5PGjpzM9Z34IB1yY9YMfw/JTb3YuZxS3mZgvsNgauvIKzkvMHbHvv5
         3r62mXeoTJzOgA+D5NV2Qc+/NcNGX5ufnhHV98tU8DF0SEU49jdzCkl6JRfXuFg6MVaA
         sTDwzIXKY+UasMaDh3D2BY3R8en8M1JUVwi+oRUdFq5C7JDaHYvQvZwa//4m0wep1+Py
         iV0Y+/r7Kzd2Hg7acirUjq8bywSrf4fnRCkaX84jeID1bkpoKWj21OZ8A/NCwohDz+TD
         4Hsg==
X-Forwarded-Encrypted: i=1; AJvYcCV2+kEs1xWbSPmqIEi7E+p9t4IfNmFfysm7nExy7pAFYBXRIAhRDWNu7oFNTVW2+nKvQuoqwUE8UvosjCqcfXKjuOBeu6dU/b2g4Y2l4L8=
X-Gm-Message-State: AOJu0YwiUEHVuq1AY3DFfvKF71JeC3xGOe8+86vHo8s8Msyb2E5I54B5
	hNEltV6UoMpCHikjizfLsxygQPZLo3MT6z44xfFYenH6c+u/vl3mVSMbvr/V
X-Google-Smtp-Source: AGHT+IESd+AVQs5PPvtNdbz9tUsDCXb2br76xKBSTTAEHaj9gP1jb7V9bO9TqBkCdWE7dCOoVa2jgw==
X-Received: by 2002:a17:902:ec92:b0:1e4:39e0:660c with SMTP id x18-20020a170902ec9200b001e439e0660cmr14927190plg.23.1714922853505;
        Sun, 05 May 2024 08:27:33 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:dae:6af2:7bcc:d74? ([240b:10:2720:5500:dae:6af2:7bcc:d74])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001e868e29fabsm6754321pli.251.2024.05.05.08.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 08:27:33 -0700 (PDT)
Message-ID: <5fa201a1-b55e-457e-bd2d-94bef5f5cd74@gmail.com>
Date: Mon, 6 May 2024 00:27:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma, nvme-tcp: include max reconnects for failed
 reconnect logging
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240505120324.20858-1-ikegami.t@gmail.com>
 <cb2c0d9a-7f45-44d0-bb4d-e074870966f2@grimberg.me>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <cb2c0d9a-7f45-44d0-bb4d-e074870966f2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_082737_610480_46E2CC17 
X-CRM114-Status: UNSURE (   8.04  )
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


On 2024/05/05 22:46, Sagi Grimberg wrote:
>>   requeue:
>> -    dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
>> -            ctrl->ctrl.nr_reconnects);
>> +    dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d of %d\n",
>> +         ctrl->ctrl.nr_reconnects, ctrl->ctrl.opts->max_reconnects);
>
> How about we do:
> "Failed reconnect attempt %d/%d\n"
>
> And the same for the successful reconnect:
> "Successfully reconnected (attempt %d/%d)\n"

Thanks for your suggestion. Looks good so just sent the version 2 patch 
as mentioned.


