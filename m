Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F022DC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:25:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBB760D07
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBB760D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lmN4jFDgYPgU9NlEznk3UpfKBhy49+D5SUx1HLa41WU=; b=E5yQ1VYSffglSblNBsMhwB3wQ
	ryiydDkJqSbMzL4pOZnyRgtrlH9oU2bqAK1GdAPd//DSomeF7gWbBMLnr6aSTy6fFHVfHH1vbBg/W
	Fzm3lCCuYA4Ci0ymha7HHp/hVZ1bxVx9O99ytVWdsEFBCLT6cfQCiJJxW462G1Rb8mcxsQVx/1vJ7
	9M0laxZ1YP9AHUQ/ALuHu5yjBa5SDTK6fo/CxpAgwH3w6IKcKTCvNLBdIE2XbrIIs3+39BZkMDGv6
	gb8k/JYEpOuD6bFHkh9mg2i6cLqcYgrmC+9aMn+uWNBHbZ85einvT7QGf5HXizRazPu4beykefjdM
	BU4orhrwg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRjGm-007r3O-Qa; Wed, 31 Mar 2021 22:25:00 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRjGf-007r2j-Qk
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:24:55 +0000
Received: by mail-ot1-f43.google.com with SMTP id
 v24-20020a9d69d80000b02901b9aec33371so384943oto.2
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 15:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OZW7ZXqwQfZjqkb90Ox/iujIj7/RYaX8vsIM9kTDCa4=;
 b=ICIl0wH3SxiKvOy1T+gR700AAN2PPE4TUY+TrnpaKXIiQhhBn1LufiDWAy96h9UTQ5
 MG2WId5DHsAj436oeiScSSpy+P1wfsmyI37oFA8KjYriF99cZtgUSzfHgVtNqwKwZ5Er
 Db8iGwKMHqmX0OEFK7pZRKZEl7VKR0Em0IOM0oLfT/mnLpfGEGxl18IcTKeVZSt/cW6R
 VH/AmS3qoo4wLKFSva1xGa+NpJdSyVoqZdu74xUilsFqp6EZmUSh9SYsNs+WJig3duCG
 xutaAVvTiSdsNR4QWhAs90+Rp7mVoSZhIRGMvGuo7/S4l/H0i0Jq2wr8QL2NyTyAEn0e
 PV2g==
X-Gm-Message-State: AOAM531zitpqK9m5fXeI1fPlbcQrUxoaiSkEHepOBX0F4g7qsu5FfSxt
 4eupENn8VN9hgJrK2Sbqmsc=
X-Google-Smtp-Source: ABdhPJxWYblKkQ2Rbcl1pEHpKNGN1gKTw5zwYhFckf9cnHZFpl4w5pzn/FHdyv6KV9OS04qRmMBjuA==
X-Received: by 2002:a05:6830:4d:: with SMTP id
 d13mr4394137otp.295.1617229492582; 
 Wed, 31 Mar 2021 15:24:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id n6sm696289oop.48.2021.03.31.15.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 15:24:51 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: "Ewan D. Milne" <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
 <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
Date: Wed, 31 Mar 2021 15:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_232454_043007_3A4AEF5B 
X-CRM114-Status: GOOD (  14.24  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> What we can do, though, is checking the 'state' field in the tcp
>> request, and only allow completions for commands which are in a state
>> allowing for completions.
>>
>> Let's see if I can whip up a patch.
> 
> That would be great.  BTW in the crash dump I am looking at now, it
> looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
> blk_mq_tag_to_rq() returned a request struct that had not been used.
> So I think we do need to check that the tag was actually allocated.

request tag can't be zero? I forget...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
