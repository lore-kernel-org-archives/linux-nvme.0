Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1245AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+xfYS/683CuEX8Moz7DN5D+iq5a+HRddPc04OAxt08=; b=Tg4k3y0x1CKele3vQBc2OnNRb/
	suqXVyFInx2to2j5OH5IMsj/BH/9ZOBbCfLGyQJaAnctDs3LBQCol+upKRQDT9yEukD7mKQxnwjM0
	kelkBhCYxJtjS/C9OHJiMdFbYhjp5dI3x8+htH6UiPaO1rQmxbchsYskapK+qcYG/rJJxfdCqauyW
	JpItE3le5KDIrTIu5AfvOgYw+AGM9Zar1S7C+1/qfxP4VRCXvM47mPUvGOLK+m5BOvItGR93S1Du6
	eHQ1+aidfNyFSdNxM6xhjdlsGqgGuFzCElcWsbVQHr6ZeDLbM2qEXqBjk9/5uV2mZyIjm6CJ/vK2x
	cm7igEeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxVm2-00Aa7w-28; Tue, 22 Nov 2022 16:05:26 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxEXJ-000Uea-Q2
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 21:41:09 +0000
Received: by mail-io1-xd30.google.com with SMTP id 11so9668219iou.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 13:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+xfYS/683CuEX8Moz7DN5D+iq5a+HRddPc04OAxt08=;
        b=Tmrax2HtLx9acijQh4ktOiCFNspYBm9czQO9vC+hgh16yhXiq5RyvSKc/8X48Yn6bo
         htTajxPPiW0Lsmr5jl6ZJh1+6V/m5ChitgOSpS6KBQ7ll5X5P1skZcbsej2h/DApNnIq
         u0xC1JtTdPPMF5q+wPkS1LuhqaXUemqkmRceA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+xfYS/683CuEX8Moz7DN5D+iq5a+HRddPc04OAxt08=;
        b=bx4zgzcV0dhKNMkZi/bgZQOv+MzUUtKz0slNSgXi7FH/R1M4aYzVcoidwQcfvKBdbd
         hWDwxsNebtx9ZGLHWdpURtpmT0ynBzd1evcfniPcYSF5IRjf+Rt6ABPWhyL1K6MYIJl/
         gn8XcxA8ZIBKRygV/4ELovCxYlzXLXcldrz0cUr1yM78wqdD9BSh8+3DAeIyI8Nj+Ip6
         DMslT47Bp7deb+koPNPTMoTD4fBICiATiDu/FKD/UiFuIuif0uSMnolLMG829pAnkU66
         QPIXEKHmHOeLSkTyv6n4DKuTPmr/DembQp6FtyN/+Fns2/0HxS2rMJiM07A865c38VGr
         Of3Q==
X-Gm-Message-State: ANoB5plreq5qJoT0pREzBuF4c3CS1t89GPZI2p8QEbMTyKHFxSVI8lHn
	bDiDdTJb64XpFsrSROLF4bukpA==
X-Google-Smtp-Source: AA0mqf4lOq6werVuvT/Ru0/037+ZZBKwQ9dV2Uvyt9oiXBE03aeSGMACS9M8fMwvTL7wgcvnDkeJPA==
X-Received: by 2002:a05:6638:3786:b0:363:b82d:d510 with SMTP id w6-20020a056638378600b00363b82dd510mr9070708jal.112.1669066860689;
        Mon, 21 Nov 2022 13:41:00 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w11-20020a056638024b00b0037609ad8485sm4704611jaq.69.2022.11.21.13.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 13:40:59 -0800 (PST)
Message-ID: <4585e331-03ad-959f-e715-29af15f63712@linuxfoundation.org>
Date: Mon, 21 Nov 2022 14:40:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Content-Language: en-US
To: Benjamin Coddington <bcodding@redhat.com>,
 David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>,
 Christine Caulfield <ccaulfie@redhat.com>,
 David Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eric Van Hensbergen <ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, cluster-devel@redhat.com,
 ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
 <cover.1669036433.git.bcodding@redhat.com>
 <382872.1669039019@warthog.procyon.org.uk>
 <51B5418D-34FB-4E87-B87A-6C3FCDF8B21C@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <51B5418D-34FB-4E87-B87A-6C3FCDF8B21C@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_134105_881182_0AF5760B 
X-CRM114-Status: GOOD (  13.79  )
X-Mailman-Approved-At: Tue, 22 Nov 2022 08:05:24 -0800
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

On 11/21/22 07:34, Benjamin Coddington wrote:
> On 21 Nov 2022, at 8:56, David Howells wrote:
> 
>> Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>>> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
>>> GFP_NOIO flag on sk_allocation which the networking system uses to decide
>>> when it is safe to use current->task_frag.
>>
>> Um, what's task_frag?
> 
> Its a per-task page_frag used to coalesce small writes for networking -- see:
> 
> 5640f7685831 net: use a per task frag allocator
> 
> Ben
> 
> 

I am not seeing this in the mainline. Where can find this commit?

thanks,
-- Shuah

