Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3CDE67A71
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubymJC3yMVrWaVX4434QCzD6ml7X+t88qVksAj99ZwM=; b=zgHjySHmtSIFHRuuHrS9rn84zE
	L8Ft1FIpRCFVzzmutiwiCeh5IaWij+HKOASwjuLwhM1o9YVGkIiLCCIXdSbbNnq+HhSXqLhlPmXwk
	owv6xHCiXrjAW9s5IdCgl2iPXBd2gVBvo1jsKxxht31WiG1KxEvG5nuVhpgUlpkmMv8CZakJX2E0K
	o6KVykWQut0P6sTuTNRQBsitjIyoCZ2KMha953KMAbWJdE7ySr+5luOD0K7ZN0pphqAY9YTLnZcgR
	6xHaewq5Cygk1aktkXRFoO2Xg+YFfYLjdeLf1Ikeqf41sFp4rclGYCoi0TM+cHLD7cdrv0qFe9jFl
	GeDOQUQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJzz-0000000Eesv-1oJI;
	Tue, 03 Mar 2026 07:16:55 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJzw-0000000Eers-2rWb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:16:54 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-48069a48629so57389055e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 23:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772522211; x=1773127011; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubymJC3yMVrWaVX4434QCzD6ml7X+t88qVksAj99ZwM=;
        b=B6cflLgH49YRi7pXVXaLA7kp/OQAW07UiQ08dzoKz44fMt6myzxHX4ohgY2Z85xMe/
         YDWViKvXU/qeVLmr3AWPvw8q+zPF81D8cHuQEWGh0PWeeEwxqRKz4B9dLvcTxRHYSqhJ
         QqWcnRMb6dyaihJDv81ZpxtmL0paE/Cs8HEBhGgoyjtuNYMG/bldRchSP8nF8/rlbAee
         OJBNSbsgzwxkMfOaGNOMCJRumIjhMn8qOrEC5lkzLkeRIBPoTe+7VnQIGsjicN10yOn0
         k75ZGHann2ZSfkKm77GryYmEgsSiPpVGOewn75XafEVvN75FUCpDvym8g40KH2EXgT0J
         yPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522211; x=1773127011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubymJC3yMVrWaVX4434QCzD6ml7X+t88qVksAj99ZwM=;
        b=hKMnQf6hKKB8Y4Wh0enD5sLC8lTPgmzOBQ7AlVd2ufwcS97vXUBQapsdhfwUs1uJsG
         soW+r2JUaB74sFGK7szIUeii12bI73uqNUa+psI7YvgfRTm+bAa7K+fimNgj/w0DL2EK
         uKfArIIuLrMfOW8apVORLFDT81GpLr9Z8t3XnDKF439MMVb7nRlIRvbwiEWSXsFaW7kF
         RLpuDPSDkyE1NwXidLnPSE+Izi6bd+FYvw+sEFyWZzE+Kl/K/713QdjTgYl9d3rKT56g
         YsGqfPwHCublsn6xv4Cx5lCk3IC+D0oh02Yazb4u66fEb/DIPqHyy9afa2KWyAo+7GHq
         fE2g==
X-Forwarded-Encrypted: i=1; AJvYcCW/sAHsuzuvPTesdfkNCna2xeRsvU957pMkwpGAlhB0NruV7VjeprR6omkiqtpRF/VNz0BRFK6EyNXr@lists.infradead.org
X-Gm-Message-State: AOJu0YxwiUd5mqXHhaf5KYLWpPbD4443HYzkqIkpB15es+doh2qwOeuI
	C3O7oktiaTe1MWFwBj5ONRwIccQ55VwmrxGNrkq1qeKb4n+rhfC/A5m8nI3cL/vptKQ=
X-Gm-Gg: ATEYQzyuVFrGuFhb55phg5tsd2ANb63iRtyimyLbqBeDRw4gOoRIDjGjNFMNIQNRhpX
	wBlXw7kV4hpRcnwRZvKumCQ5mPaA1aqPLBPkjREHNGQOjwLoOhlfswdd3ONFmVswpZPwZWrsyUa
	KXJh/tZBMfrKPCXmtkHGp4NbwwHC7eaH10n9HYIkzFtebWIRcdvjGhHUtVEVuuFyz7bb1aO4f39
	dt1Gyto7tq0Gmunra2wdnfq9Evf1EEj57GT+nbzBP4vMcR+ghvcbY6gq0irFvKpM44zY6n22uCW
	15vkhs7dcvGUusSqK7bqhd7m1IoWkkRLPGdt+hRhFKsa2mOSPsUqTG0w+LpCG87k0Vdkgc65QmU
	at5EhAgTy63qRwGqV8jXRNwS66vqjfWcX81LMqaIG+RB0eTB2o5Tw2eEkyTjmeSHoxL202VypW4
	EiiFdrZOcyZAXuucxHK1aYLQb2B0AycdYeeNe1obXmgOPrL20VXA8l8Fk0EUDKRLbSOQ==
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-483c9c1d177mr268411375e9.29.1772522210626;
        Mon, 02 Mar 2026 23:16:50 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485125bbb48sm16093555e9.0.2026.03.02.23.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 23:16:50 -0800 (PST)
Message-ID: <9881a867-244c-4ae5-852a-3332b7eb0614@suse.com>
Date: Tue, 3 Mar 2026 08:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] scsi-multipath: introduce scsi_mpath_device_class
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-5-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_231652_738986_C6FABDEC 
X-CRM114-Status: GOOD (  15.05  )
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

On 2/25/26 16:36, John Garry wrote:
> Introduce a new class for multipathed devices, scsi_mpath_device_class.
> 
> The purpose of this class is for managing the scsi_mpath_head.dev member.
> 
> The naming for the scsi_device structure is in form H:C:I:L,
> where H is host, C is channel, I is ID, and L is lun.
> 
> However, for a multipathed scsi_device, all the naming members may be
> different between member scsi_device's. As such, just use a simple
> single-number naming index for each scsi_mpath_head.
> 
> The sysfs device folder will have links to the scsi_device's so, it will
> be possible to lookup the member scsi_device's.
> 
> An example sysfs entry is as follows:
> # ls -l /sys/class/scsi_mpath_device/0/
> total 0
> drwxr-xr-x    2 root     root             0 Feb 24 11:56 power
> lrwxrwxrwx    1 root     root             0 Feb 24 11:56 subsystem -> ../../../../class/scsi_mpath_device
> -rw-r--r--    1 root     root          4096 Feb 24 11:55 uevent
> -r--r--r--    1 root     root          4096 Feb 24 11:56 wwid
> # cat /sys/class/scsi_mpath_device/0/wwid
> naa.600140505200a986f0043c9afa1fd077
> 
Ah, here it is.
So you can ignore my comments from the previous patch.
(and you might think of merging this and the previous patch).

But device naming is still dodgy. A plain number has so many ways of
being misinterpreted.
Wouldn't it be better to name it 'mpathX' ?

And, of course: how can we get the topology?
Do we get a list of the underlying scsi devices from sysfs?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

