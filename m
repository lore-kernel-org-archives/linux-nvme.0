Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E714D6ED34
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pq/XM0SZEFy5gATevhzqMaAH7wNKf6n+SB2NmScqXs=; b=Ob25Th3NnPDJtJsBe4ROtUnn6d
	oHZNZbHvpRBa7ziAUNvSaDyLZPbwU6RZDjRpA9HCRICr3frncRFN302TTIWPjFqVGl6BgA70zb+Pf
	ZCgD7uDn6JIbU+l6M/VF7wZH0Bq3YL9hS9EZzuYjGw0Jb39wHP4oJb0zEBqWe6w3HzGz/omhD5EbW
	AncbgDJhwOMI11PR3zaFNE2ykdaFQs3UZ7rPne4xWETuhW+P31Djvm0LOJ383HZSmCtMdD7gvVBSY
	b1OK4bxhbzQMzasNb0zUcH094Miqs0f8KyDFrHWELzpLBUTWqr9wHoWsr5sSMjJs9cjr6z4aV0RLy
	ywyJBkyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7Ud-000000008mG-1vEW;
	Thu, 21 Nov 2024 13:45:11 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7Ub-000000008jk-0ZxT
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 13:45:10 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-aa20c733e92so127715366b.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 05:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732196707; x=1732801507; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pq/XM0SZEFy5gATevhzqMaAH7wNKf6n+SB2NmScqXs=;
        b=dXI6Bov0f9/V4wHebbjeqylbIIvVErMz3CvY3FXudkH3/mWHE+F5ZJi3HE0A+jwMdC
         ILnWW2YxOWCGRMBjPZgo20xtQQ/vI0t4syFotsIYX3+iAGdsZnrjfvYw5CbpJcpw/wir
         bvl/I6bFOQiQr/CRJ9g17o5O1sodn7MGSvyFPEgL5SDisblHnj7jER7H6RIfsZC0hjVW
         9Euu/t5bcg/67VH4+m/J1ejseYcZqL2NFsp6ihhwHtsVpRzwpX9bNiq9N9enTtDspn45
         jaEyALSvnsSo8yn/EwjFbpGapMe68wdmsFCaiOQ/DBwhUbqYBgA7iZekRl28kOtk57pt
         xWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732196707; x=1732801507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pq/XM0SZEFy5gATevhzqMaAH7wNKf6n+SB2NmScqXs=;
        b=Wotbp9vb+4PZyfTAYkVKZxwpXPs2rG21a4h9YbOZEtQtB1K8MZtCRQoMJVnjX8tdmg
         fq5eVWKTvnQwucpRGt5mlUpnj/K9veKTmeQoV9k69D6kpwLrzmpKoHoHyXztMysogNtX
         +s1gbbBXviLgJ86yur+C3fXBse9EwrLe2I+ocCYt65EjuZLCbuYem7WcJrMzjbxv0WzP
         fhkxrbkSlxBIir6vCwmdUJBhMSjfXz/C4Zkrq4Tyc0JIXFaAL8oas0m1+LM/LkcKS1SI
         f6ZmHsz6tmXqp4gr0iMgcrSzdj2LTQbyeAxO5w77kgVL2SmUwmGJ8YdwQZHXKGe/RIrZ
         r0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUQxVDijYGnUn5V2MKvqMvf0ijgNKyG4HylAt6O07TAD5D4+rOuzTa+kYcoF6mwtHy54u+PYOn6mQLk@lists.infradead.org
X-Gm-Message-State: AOJu0YxNmcMvTR64wOZuQsRbswW3MJQz9j8TGuc43xGXlZYZO0hnaS0u
	E4eksmrbSgBT3Fi3QM2uzC/gTYs8mv4DiOv+6jN9zLMHgBN1q/cG
X-Gm-Gg: ASbGnctxFrR+2A1k8e1cVEibNzkm+vi3VK8QvCCiQ0UMbtsS2IvpRqULMwy99LUsJcM
	jwxMQkfwB8er5cWXrnJT1F1J8KnLhgWrpKIcZwJAihleSyTnAgLpMROKSn6uix2jLJ5a45+4URx
	jmc/gkdHfQuCSe1f3+0NIudAGGs3tuMXd4sn9lkweyXRg1TLecGBYjChI1KitbOhffBX0TbTVVy
	XJKVfWU+Ax9EEWX7hcNAaQ9yXfz8GSN3lYLvFpIoEp48cQG1q4E0hvhorj/fg==
X-Google-Smtp-Source: AGHT+IFbrl+oIuZ5/IgECuefc9devB61urmQnzBxxeqoidxHMM0dOzQmgj0ok1K5viTP+eBfwwX3YQ==
X-Received: by 2002:a17:907:1c1e:b0:a9e:b08e:b02d with SMTP id a640c23a62f3a-aa4dd552153mr705616066b.18.1732196707044;
        Thu, 21 Nov 2024 05:45:07 -0800 (PST)
Received: from [192.168.42.195] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f431b3b6sm82710766b.171.2024.11.21.05.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 05:45:06 -0800 (PST)
Message-ID: <9081b86c-1496-4d03-8063-18637e14be49@gmail.com>
Date: Thu, 21 Nov 2024 13:45:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
 axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
 anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
 <ZzeNEcpSKFemO30g@casper.infradead.org>
 <20241120173517.GQ9425@frogsfrogsfrogs>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241120173517.GQ9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_054509_178510_F06E9687 
X-CRM114-Status: GOOD (  20.92  )
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

On 11/20/24 17:35, Darrick J. Wong wrote:
> On Fri, Nov 15, 2024 at 06:04:01PM +0000, Matthew Wilcox wrote:
>> On Thu, Nov 14, 2024 at 01:09:44PM +0000, Pavel Begunkov wrote:
>>> With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
>>> of whether a particular request needs it or not, and the user will need
>>> to zero them for each request.
>>
>> The way we handled this in NVMe was to use a bit in the command that
>> was called (iirc) FUSED, which let you use two consecutive entries for
>> a single command.
>>
>> Some variant on that could surely be used for io_uring.  Perhaps a
>> special opcode that says "the real opcode is here, and this is a two-slot
>> command".  Processing gets a little spicy when one slot is the last in
>> the buffer and the next is the the first in the buffer, but that's a SMOP.
> 
> I like willy's suggestion -- what's the difficulty in having a SQE flag
> that says "...and keep going into the next SQE"?  I guess that
> introduces the problem that you can no longer react to the observation
> of 4 new SQEs by creating 4 new contexts to process those SQEs and throw
> all 4 of them at background threads, since you don't know how many IOs
> are there.

Some variation on "variable size SQE" was discussed back in the day
as an option instead of SQE128. I don't remember why it was refused
exactly, but I'd think it was exactly the "spicy" moment Matthew
mentioned, especially since nvme passthrough was spanning its payload
across both parts of the SQE.

I'm pretty sure I can find more than a couple of downsides, like for
it to be truly generic you need a flag in each SQE and finding a bit
is not that easy, and also in terms of some overhead to everyone else
while this extension is not even needed. By the end of the day, the
main concern is how it's placed and not where specifically,
SQE / user memory / etc.

-- 
Pavel Begunkov

