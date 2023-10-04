Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30718E936E6
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqWCjpGoPtGeBxPj6NXaJjfTI+0jdvkGwu/+8Rx4Pz4=; b=LwnTCLj7qey8d6WmAJtGcp9o30
	jRfj6q/xu8LN+/W/JvPVH19W/+be2pjeq3NrInc4eRCP9pU8F2/BbacbVuATJeKxXjCpqsOwYdXJA
	6JaiZf+0H7ECL05PHkwKDdW2UlkFcVMIDjj/b73jfNLQUYRIBWBelVjX76UtZ/8T0b0Gr8EUfDkJH
	7kAAry1gGFOgM/CuQZqYXKjzjcMMTtvehvigMPqNMo4xMYIqjMYQVlOTDfBoDK9k+yiR3COkXnTRf
	iTJUyg3QrSAd6b65X2gJwuaTsumulxOmW6l4VClh5SQb18CID2DOaiN3crLCGKVSWzBx0CKDQU7hf
	HYhbaWoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo8zW-000tvN-0Z;
	Wed, 04 Oct 2023 21:01:10 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo8zQ-000ttu-1q
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 21:01:08 +0000
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-694ed847889so208670b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 14:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453261; x=1697058061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqWCjpGoPtGeBxPj6NXaJjfTI+0jdvkGwu/+8Rx4Pz4=;
        b=dGtsKXegpvCpHFniDgcfNd7QS8kCRut6tjN9Q0cmRjdZMWVQjEfBpPtjEXElhAwn/f
         EmAXqp2UdxNkfl6hkeMcp4L7KOK5mij3shc27XyRC/ErN5hczmXpfLCPGmxL+ngvkTwu
         oK1fRoWfTadVU8odrkLDP/YKxkiiwLuieyPToriT17uvjuzep3M6JwqIBZKVKzkxJrD2
         WXHBnGaCsiBJQ+O+nL6LDDt/bRF2a34AqttYm766kwnukyCyO+JjPRWrYm3R2Pg8kSnl
         +dVFAMeeOLNrU07KkZD6liwsnUsgOui0IClQGBlzzL+ecoToT68CCvNymXlmBEVgj8KL
         Ktdg==
X-Gm-Message-State: AOJu0Yw9+rdj0eg0HqYVaSgZp90S+oIxiptfVWBEbPuIAwFjdiVbT0IM
	3ubUaPba4mJokamWNODCXl0=
X-Google-Smtp-Source: AGHT+IEuGjzH8Kj7y4GInNBPROGHOmz2jLurje3529a8epyygBEeFbbe5C5V5No2qUQIED/PIYh8gA==
X-Received: by 2002:a05:6a00:b84:b0:68f:ccea:8e14 with SMTP id g4-20020a056a000b8400b0068fccea8e14mr4137143pfj.32.1696453260897;
        Wed, 04 Oct 2023 14:01:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b006934e7ceb79sm3657241pfo.32.2023.10.04.14.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 14:01:00 -0700 (PDT)
Message-ID: <45bc1c01-09c7-4c54-b305-f349d0d0e19b@acm.org>
Date: Wed, 4 Oct 2023 14:00:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org,
 Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
 <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_140104_613766_DFA2C3D8 
X-CRM114-Status: GOOD (  10.93  )
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

On 10/3/23 20:00, Martin K. Petersen wrote:
> 
> Bart,
> 
>>    also that there are no guarantees that the data written by an atomic
>>    write will survive a power failure. See also the difference between
>>    the NVMe parameters AWUN and AWUPF.
> 
> We only care about *PF. The *N variants were cut from the same cloth as
> TRIM and UNMAP.

Hi Martin,

Has the following approach been considered? RWF_ATOMIC only guarantees 
atomicity. Persistence is not guaranteed without fsync() / fdatasync().

I think this would be more friendly towards battery-powered devices
(smartphones). On these devices it can be safe to skip fsync() / 
fdatasync() if the battery level is high enough.

Thanks,

Bart.




