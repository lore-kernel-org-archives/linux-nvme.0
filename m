Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D08E7AD7F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXhSrsitouTtG4jnIpF6WlTXUJWU1AdtRoPHLHegjNE=; b=mvGlSKE8XRr8ZvM+zINHWSbqfr
	JMzEaGPrsUG6FqrHhi03q5AHyq+XnB/zqEN6df2zrVMImr1YqoEHxyT9wJqbj8i5Y7WZ+UWAxBNkJ
	YNKvBSeWUt596BVEJoo6INgK6AP3v5R9+fDTqpDJKpjL3lUg+QoFBrZvy9No8MxfqFWW2qISwnj+V
	66XZJu9GQV7a6kZBNd1xxFJ7ZF4hiDK/d09lPdzO/xGVSZU0KEWq3xfdtq/iQn1DpIH/ve9u3NZBB
	SDrfITyb6J5r5uEAOSqm6BHToXQmA/ATqFXtsMC1cbgK38oAkFDrrSSzLEl/4ZoutCYsqYT/0LI5T
	8nYtE+wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qniWd-00EzR8-1c;
	Tue, 03 Oct 2023 16:45:35 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qniWa-00EzQc-2I
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 16:45:33 +0000
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2774874c3daso842956a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Oct 2023 09:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351532; x=1696956332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXhSrsitouTtG4jnIpF6WlTXUJWU1AdtRoPHLHegjNE=;
        b=YRi5gH1W2JICAG2oOji03XnsbnTMtqsubvydjNegRoj5n/dFNzz1POeKxC9eNZ0Qi+
         eh1sfoulLee/5glLIJ+GccYpy9s8rfEdxf5qx5iETgegOs+fnkOJ4gdgCba6k8/Y18xA
         ARKu3Y1deVmkQZOZcHC4LjHsqhodyC33qFzQH1R9vv4wU6CwR/zsAe/e65syBAHyx5vN
         wuuItHb4YRRVDANhD3lRsw4lj1Nl9Fk2SDYjzSz8v/fr2BLaN4LXcywO/ywMHrDzRoUJ
         eyXbt/j6TULyHAw5zGrBAls+FAmKtK/tPahEG22Ce6lrBMKA8DxS19QB6+0YXMu5Uu9+
         rWrw==
X-Gm-Message-State: AOJu0YwnmihhCxg16ht9QRW6caEjt7ymb6P9mvIon6F0xtgwnxaXKRnn
	TEWjfeiU7LBilFVN4c2cXpk=
X-Google-Smtp-Source: AGHT+IEwC8qVv1+tkY+wONdL32+rPKEpsbXoCH+j3Wnz44caGKeaCpNY+K3ZBdFDu5Ezk2vd0L3+eQ==
X-Received: by 2002:a17:90a:5d18:b0:26b:4a9e:3c7e with SMTP id s24-20020a17090a5d1800b0026b4a9e3c7emr14066923pji.4.1696351531639;
        Tue, 03 Oct 2023 09:45:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id e59-20020a17090a6fc100b0026b70d2a8a2sm1719463pjk.29.2023.10.03.09.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:45:30 -0700 (PDT)
Message-ID: <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
Date: Tue, 3 Oct 2023 09:45:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_094532_750509_4FFD053A 
X-CRM114-Status: GOOD (  10.49  )
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

On 10/3/23 01:37, John Garry wrote:
> I don't think that is_power_of_2(write length) is specific to XFS.

I think this is specific to XFS. Can you show me the F2FS code that 
restricts the length of an atomic write to a power of two? I haven't 
found it. The only power-of-two check that I found in F2FS is the 
following (maybe I overlooked something):

$ git grep -nH is_power fs/f2fs
fs/f2fs/super.c:3914:	if (!is_power_of_2(zone_sectors)) {

Thanks,

Bart.

