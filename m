Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AB3C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C14m+5yBrv+u7QhAN78BFentZAFfnah8l0PUC4om7m8=; b=awdwp2/wRRfuLwhHiTJOUcHfOU
	UnWlCgb65R2R3ldUKiCZYoToBgHe4b4XLKwJr39ImPaaY8wZGIIWOvTzwde/j6onpWT1PIEc5arod
	soTh3zV4s3i97kGEazg9o7EvpK+L6VnhkdIqr3nPNuoEpIyj8B8zC2QfOOsJrsrqr7j6SkN6wymFl
	Ohmw2w5zkzsb2VlSSuvs/DzMGXizFqtAejWK1HuLXt4/BH0rAYoSzSrkCHv9PCFHxz7ywkeQ4oM7V
	emSAqliwvL1vnVxg1kEz7m+AZxvPgZO2DmmeRDcef0lOH1SqCqhDL2Np9RKgHtSmKeAlYOBiwRzXc
	ePeTzLBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxVmH-00AaCr-7P; Tue, 22 Nov 2022 16:05:41 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFKj-000pJL-Ea
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 22:32:10 +0000
Received: by mail-io1-xd32.google.com with SMTP id s10so9718146ioa.5
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 14:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C14m+5yBrv+u7QhAN78BFentZAFfnah8l0PUC4om7m8=;
        b=Hffgzad5MotJq5EstTpwFVQ55zJ2m4sb3dYfhAhqq6QB33wEMcRLHmm2P2eeaxcyl7
         AuWzz1/l9u/1PZyxMCWxsiA0Q6e5fRCsSvqJb8QkirXxS7f+WkWGHtcgrG5qSrXeSLS7
         dJYa3L0ToHNG/CDOCknNOKSmu/izuTLa+EFwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C14m+5yBrv+u7QhAN78BFentZAFfnah8l0PUC4om7m8=;
        b=xFkldn/OQceq2LEZGLH70ty9tHrmSKKRxnt8TB14hZXUS62i6Rbkf9DxxM8x7FtMuJ
         BH23SYMkxzUjNtPQ2MUUSvckmdDtnlWNmHiCzDF0E+KDSp+W7hDgl/rJZhavhKVsjLXd
         sEgxxXf7zQAf2xje8hJsp+IPXjdlfNgdnFBbAX9fYQb9UvJklAfz4uXafgxSwdsmHaMT
         tREEET+KRt8LEzMY9TARQqMP+NcpstPLwDT886P3A2RAbhvKicgoWo7uLw0O1EvwUaU1
         5V1w5UJ6r3l0+Jpwq2PgBDjeJ/4kec/WrxJvLKYSuLhV4bAkixz0AwF/L1X0tO19lBJG
         yGVQ==
X-Gm-Message-State: ANoB5plPUedpRxB7SqAUItfctbhW97iPbPwZOBl1SGOJRfN8Q0atGn2Z
	VzPrU+hr1J+0HFFCCiV02xkD0Q==
X-Google-Smtp-Source: AA0mqf7LzJaZLZ7BN/ieedWyHJVfNYy1D/3fvJQ9uHDra09xLMDQnM+TgsskrmQ988UMBIXzYDc/Wg==
X-Received: by 2002:a02:cba6:0:b0:375:a360:a130 with SMTP id v6-20020a02cba6000000b00375a360a130mr9477313jap.307.1669069925449;
        Mon, 21 Nov 2022 14:32:05 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f15-20020a056638112f00b0037502ffac71sm4612316jar.18.2022.11.21.14.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 14:32:04 -0800 (PST)
Message-ID: <96114bec-1df7-0dcb-ec99-4f907587658d@linuxfoundation.org>
Date: Mon, 21 Nov 2022 15:32:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Content-Language: en-US
To: Benjamin Coddington <bcodding@redhat.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
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
 <4585e331-03ad-959f-e715-29af15f63712@linuxfoundation.org>
 <26d98c8f-372b-b9c8-c29f-096cddaff149@linuxfoundation.org>
 <A860595D-5BAB-461B-B449-8975C0424311@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <A860595D-5BAB-461B-B449-8975C0424311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_143209_500079_7C7400DB 
X-CRM114-Status: GOOD (  17.36  )
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

On 11/21/22 15:01, Benjamin Coddington wrote:
> On 21 Nov 2022, at 16:43, Shuah Khan wrote:
> 
>> On 11/21/22 14:40, Shuah Khan wrote:
>>> On 11/21/22 07:34, Benjamin Coddington wrote:
>>>> On 21 Nov 2022, at 8:56, David Howells wrote:
>>>>
>>>>> Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>>
>>>>>> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
>>>>>> GFP_NOIO flag on sk_allocation which the networking system uses to decide
>>>>>> when it is safe to use current->task_frag.
>>>>>
>>>>> Um, what's task_frag?
>>>>
>>>> Its a per-task page_frag used to coalesce small writes for networking -- see:
>>>>
>>>> 5640f7685831 net: use a per task frag allocator
>>>>
>>>> Ben
>>>>
>>>>
>>>
>>> I am not seeing this in the mainline. Where can find this commit?
>>>
>>
>> Okay. I see this commit in the mainline. However, I don't see the
>> sk_use_task_frag in mainline.
> 
> sk_use_task_frag is in patch 1/3 in this posting.
> 
> https://lore.kernel.org/netdev/26d98c8f-372b-b9c8-c29f-096cddaff149@linuxfoundation.org/T/#m3271959c4cf8dcff1c0c6ba023b2b3821d9e7e99
> 

Aha. I don't have 1/3 in my Inbox - I think it would make
sense to cc people on the first patch so we can understand
the premise for the change.

thanks,
-- Shuah
  


