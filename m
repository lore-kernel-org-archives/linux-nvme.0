Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234B4EB64DA
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jul 2023 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWG6yfCA3V3Tdfob5HbNNseG8GZJElIvt+EDZjnECA8=; b=xTfASyLZ5M/Paf1udWREBbB9zO
	Bffq0iY8minqPT84mmJlJlI4OVR64e0WY/Y0wX6bj6sBEqrYp/z0are9+A0/qAE0aI4kgmaCVdIrq
	1NHmSK4SDS4CvDfioE/5q9qWXoxckBKGLKP/WD5YLTP0UFQvuCKBlVbniokgqpx+ASpFIdzIH2ZuZ
	QVe1RU8y4mE6m1WRPh35AKHlGzlTbaig7Y8ZXjWCdm5oAh6wxfqKjMxAFUeisIlnnMTdbDWfSTFeL
	WjKJHimLZI2+zgG6vqclNGItyPsFkKb5JKw0V1miBFhiTOf4Wk5T8FWndud3OjsmXSIceY66qPUU8
	IOpW2aXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGarv-00CVAt-1G;
	Tue, 04 Jul 2023 07:54:39 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGars-00CV8S-1s
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jul 2023 07:54:37 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f13c41c957so1267680e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Jul 2023 00:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457273; x=1691049273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWG6yfCA3V3Tdfob5HbNNseG8GZJElIvt+EDZjnECA8=;
        b=N+Eqtbl4AV0rtraGAuWbLZdNCgtM2A3pChsBKg5dLXopgWMtxoyLKHDl2RJ4ig83in
         9QwM7U/74OPMd3wzFWaIn+g9JyL874IUbBZN4IptJ+a+QNsTXrAnh7fN1W9qGbiSV+kV
         woRMk3LafYcjssHcj0RW4swcI3is/V0ziXKYeICmH6/Cy/3NGhs5Jx25yXCWAuEqZNOj
         mJcRJcCCymLdxv3rUFG+KKVg5pJ3RpmwwAFMF++rdtDu6IyrL7s5TD0mXQMBYQgl6Tm6
         4LCy5sTpvm8xrueeU4fgA9pa8oMhCXo3ftalQ4yKMaKvTXWQTD6p56LQy5IYQm/JvVV3
         UOxQ==
X-Gm-Message-State: ABy/qLYsFrNonJRvyk2qw7FnvInKvYxL9OFSr177eb7MxVIQdBvslgSC
	uWoAswyoRVAcKAjdLv+/W9w=
X-Google-Smtp-Source: APBJJlHEl6sIR9YgO8cmzCcJZEnPPYatLGhl1VaqgU5lEb3DN3zwJhel3eNK9jVgpkANWurQuhjSBQ==
X-Received: by 2002:a19:ee0e:0:b0:4f8:6ab4:aac6 with SMTP id g14-20020a19ee0e000000b004f86ab4aac6mr6501972lfb.1.1688457272970;
        Tue, 04 Jul 2023 00:54:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l4-20020adfe9c4000000b0031435c2600esm5524082wrn.79.2023.07.04.00.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:54:32 -0700 (PDT)
Message-ID: <b181b848-b2c7-4a7e-7173-ff6c771d6731@grimberg.me>
Date: Tue, 4 Jul 2023 10:54:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Ofir Gal <ofir.gal@volumez.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 cgroups@vger.kernel.org
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
 <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
 <ZKMehaAF0v-nV1qt@slm.duckdns.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKMehaAF0v-nV1qt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_005436_616971_ABB8EC18 
X-CRM114-Status: GOOD (  24.01  )
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


>>> A full blown nvmet cgroup controller may be a complete solution, but it
>>> may take some time to achieve,
>>
>> I don't see any other sane solution here.
>>
>> Maybe Tejun/others think differently here?
> 
> I'm not necessarily against the idea of enabling subsystems to assign cgroup
> membership to entities which aren't processes or threads. It does make sense
> for cases where a kernel subsystem is serving multiple classes of users
> which aren't processes as here and it's likely that we'd need something
> similar for certain memory regions in a limited way (e.g. tmpfs chunk shared
> across multiple cgroups).

That makes sense.

 From the nvme target side, the prime use-case is I/O, which can be on
against bdev backends, file backends or passthru nvme devices.

What we'd want is for something that is agnostic to the backend type
hence my comment that the only sane solution would be to introduce a
nvmet cgroup controller.

I also asked the question of what is the use-case here? because the
"users" are remote nvme hosts accessing nvmet, there is no direct
mapping between a nvme namespace (backed by say a bdev) to a host, only
indirect mapping via a subsystem over a port (which is kinda-sorta
similar to a SCSI I_T Nexus). Implementing I/O service-levels
enforcement with blkcg seems like the wrong place to me.

> That said, because we haven't done this before, we haven't figured out how
> the API should be like and we definitely want something which can be used in
> a similar fashion across the board. Also, cgroup does assume that resources
> are always associated with processes or threads, and making this work with
> non-task entity would require some generalization there. Maybe the solution
> is to always have a tying kthread which serves as a proxy for the resource
> but that seems a bit nasty at least on the first thought.

That was also a thought earlier in the thread as that is pretty much
what the loop driver does, however that requires quite a bit of
infrastructure because nvmet threads are primarily workqueues/kworkers,
There is no notion of kthreads per entity.

> In principle, at least from cgroup POV, I think the idea of being able to
> assign cgroup membership to subsystem-specific entities is okay. In
> practice, there are quite a few challenges to address.

Understood.

