Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A05E71D42
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=za8EzqdYzUyppdLLpiPtivTza7p59Ioizqu+gaqUd3g=; b=kC/l+kUExl+jdQbzX9cThOg2Bt
	vfMGbrr40j+/B8n8Y3rGtx/LxpYOaNdH+SEOB9lEGJ81e4JDS2gslzchhpYV0buAHDVVkZEqMBZgZ
	eKwy9SXdPt18pPPzfzIXl6/Dz1XFvFypOAVXFP85CNaCdXQT7Z+wyCOGwe1u3YaDBtRw4mYfUH52i
	WPDuHZLqVSH9CH3TYftmDUeHAqSrhNwvnTH0hm0rhMX/W/eKUhqeqDlZaU2ghh7g6OWmflsXnwbr5
	MCM1fhvLsGpx9e978ua/d/LInlvdCHQcY7fts6FiVSNDofV4p3f72aXJ3OGS1PDKaU6Q/E76Er9Lj
	TgNFGmpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmEwr-0087PN-2Q;
	Fri, 29 Sep 2023 14:58:33 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmEwo-0087NW-0s
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 14:58:31 +0000
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c5cd27b1acso127971635ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 29 Sep 2023 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695999507; x=1696604307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za8EzqdYzUyppdLLpiPtivTza7p59Ioizqu+gaqUd3g=;
        b=bQ5PwwraP40WC0+31TrCuuT3IWH4eAfLhxib4Tlu3Pmq33CeAPfddjLCKNtf8Nbhd2
         ShXVCBV3pAU0EPfMduzn0sLwH/+m4MrjAW+Xxj6DKi4Wtdfn3enSB9YHIl3XtSA7SaQ+
         fJVPyRgGh4w8AB86cm27I6HAjuriZiInZ8aB+7NU6NKr6HiTAV5c1ehUEzaF/empJxSH
         hLNbfD5WOBPbQLGIN04EjP9ubwZQbSnyjrmt1nmAhgHIkMJV8fjdIcwmoLhv/9I+Y1lS
         YhVfvJEiAbnDRk7Kbukdg+C7WCsnk8FvT09VNvNWVRDRAKWnVz4FEgEqO4h7Pq0naxfp
         hxrA==
X-Gm-Message-State: AOJu0YzimihQqo4qk4VgfpxcVnsVSrmrId10mna4HfeXMoSLOzDzgkvh
	DaFvs7gXbDqtvXLghppLZd0=
X-Google-Smtp-Source: AGHT+IG5sgVITHE7nR5diwLXn/2VF45vvGKMJi6rof6uCdXanJ/bkpRzf92xSKeM2Bi/n6Pno9YC+w==
X-Received: by 2002:a17:902:d34b:b0:1bb:9b29:20d9 with SMTP id l11-20020a170902d34b00b001bb9b2920d9mr4928956plk.20.1695999506875;
        Fri, 29 Sep 2023 07:58:26 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001b9d335223csm13018814plb.26.2023.09.29.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 07:58:26 -0700 (PDT)
Message-ID: <378f6c3b-5c4d-4df8-ae1e-e8abb9ee47a3@acm.org>
Date: Fri, 29 Sep 2023 07:58:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] block atomic writes
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_075830_310929_4252C02C 
X-CRM114-Status: UNSURE (   7.90  )
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

On 9/29/23 03:27, John Garry wrote:
> The atomic writes feature requires dedicated HW support, like
> SCSI WRITE_ATOMIC_16 command.

This is not correct. Log-structured filesystems can implement atomic
writes without support for atomic writes in the block device(s) used
by the filesystem. See also the F2FS_IOC_*_ATOMIC_WRITE ioctls. This
being said, I hope that atomic write support will be added in the
block layer and also that a single interface will be supported by all
filesystems.

Thanks,

Bart.


