Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EFFE74914
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 19:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/ve4+0hI3kPGfr74V3fRnzywfGyjXPBIyqNnDnwTuY=; b=h86v6qZE/TI84vFJf4mLRK/uL8
	T5J+fh7fwzTTpapPt4mbGoGlZlMF4MWs1uccT4MljOjs4QekPNJ9TaCzgzyoqstKlbWp6nRmjyntH
	/aNLk2M8xXoVQP0MRgyyirhbR+q/cJJoNFfndoK/eh+mpK/PyjDt1pomNF7ByYqEvdChBkbnxsoR1
	a/X3HkDiLqTS+/7aPLwJv2i+uWdW0FRE8KWhI5fi6Q2uK3Yu67V0JhWXUbLHzHWDoh9IAom9aImt2
	yuG5rNKvMQbM4EQeGz1kyXyVDI2zw2AaSlLwATG2LWeOQ/Vr6hz+pG7fk+0TtP+RDF/PvBQ5F3Jyi
	baMs+Kng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnOUP-00DHak-3A;
	Mon, 02 Oct 2023 19:21:57 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnOUM-00DHZO-2U
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 19:21:56 +0000
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-692c70bc440so95995b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 12:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274512; x=1696879312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/ve4+0hI3kPGfr74V3fRnzywfGyjXPBIyqNnDnwTuY=;
        b=l09gIg++NRBpmMbDoBxiiZRwkf4xwRVgnDJSbZp0J5BDWch9NDdpEeiwh2QB2CNJ3n
         OIDZ9M2piFZbUJyeIbXqht+067GAko6OOAhvjNyyQnaM3H6ys62MYHeD6cIbWnp12QS+
         re48tpwtLoZHg1dCkkYyikyIzfqmTgqdMX02czeGM7j6EtNfdqGVwnnsr6EaKb0RlvTu
         Hny6wo5ar9NSHSgay9INcOcBniHtvOnWWhS9xjLEhrMAZShVscDYXB/hpnJlIkQX+Qzr
         CqEYdb4eBsTs95wVFHpsrUkmW7Iz7gj4Xbv3Bq8KoHdxqrcL+tsYTYz0otV673s3nRWo
         BIzQ==
X-Gm-Message-State: AOJu0YzyP9/L5rwOjbnDeXeQRmajbm7E7ANCWm276UQHl2QAeG9WyhwD
	bcqM7Yf0CC6a5os9VTmPL5IQ0+aPSrA=
X-Google-Smtp-Source: AGHT+IHdmSkxcMU9Q3KlwXLUK3XdwSehxi52wiuutteyt+WOowhzgK0t39kMn9Z+tSskapiavysFsA==
X-Received: by 2002:a05:6a21:35c4:b0:136:ea0e:d23 with SMTP id ba4-20020a056a2135c400b00136ea0e0d23mr9301982pzc.11.1696274511618;
        Mon, 02 Oct 2023 12:21:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b001b896d0eb3dsm10650573plg.8.2023.10.02.12.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:21:51 -0700 (PDT)
Message-ID: <6a41f73c-d2ac-405f-9ecd-96dd938c9a1f@acm.org>
Date: Mon, 2 Oct 2023 12:21:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
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
 <20230929102726.2985188-20-john.g.garry@oracle.com>
 <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
 <a6041625-a203-04b3-fa42-ed023e868060@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a6041625-a203-04b3-fa42-ed023e868060@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_122154_811229_31FD1BE9 
X-CRM114-Status: GOOD (  11.43  )
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

On 10/2/23 04:36, John Garry wrote:
> On 29/09/2023 18:59, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>>> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
>>> +                    sector_t lba, unsigned int nr_blocks,
>>> +                    unsigned char flags)
>>> +{
>>> +    cmd->cmd_len  = 16;
>>> +    cmd->cmnd[0]  = WRITE_ATOMIC_16;
>>> +    cmd->cmnd[1]  = flags;
>>> +    put_unaligned_be64(lba, &cmd->cmnd[2]);
>>> +    cmd->cmnd[10] = 0;
>>> +    cmd->cmnd[11] = 0;
>>> +    put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
>>> +    cmd->cmnd[14] = 0;
>>> +    cmd->cmnd[15] = 0;
>>> +
>>> +    return BLK_STS_OK;
>>> +}
>>
>> Please store the 'dld' value in the GROUP NUMBER field. See e.g.
>> sd_setup_rw16_cmnd().
> 
> Are you sure that WRITE ATOMIC (16) supports dld?

Hi John,

I was assuming that DLD would be supported by the WRITE ATOMIC(16) 
command. After having taken another look at the latest SBC-5 draft
I see that the DLD2/DLD1/DLD0 bits are not present in the WRITE 
ATOMIC(16) command. So please ignore my comment above.

Thanks,

Bart.

